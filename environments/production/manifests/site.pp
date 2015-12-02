node 'balancer' {

  firewall { '100 allow http':
    chain  => 'INPUT',
    state  => ['NEW'],
    dport  => '80',
    proto  => 'tcp',
    action => accept,
  }

  include nginx

  nginx::resource::upstream { 'elasticsearch':
    members => [
      '172.28.128.3:9200',
      '172.28.128.4:9200',
    ],
  }

  nginx::resource::vhost { 'balancer':
    proxy => 'http://elasticsearch',
  }


}

node 'server-01' {

  include java
  include firewall_es

  class { 'elasticsearch':
    config      => { 'cluster.name'          => 'mycluster',
      'network.host'                         => $networking['interfaces']['eth1']['ip'],
      'discovery.zen.ping.multicast.enabled' => false,
      'discovery.zen.ping.unicast.hosts'     => '172.28.128.4' },
    package_url => 'https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/rpm/elasticsearch/2.1.0/elasticsearch-2.1.0.rpm',
  }

  elasticsearch::instance { 'es-01': }

  Class['java'] ->
    Class['elasticsearch']

}

node 'server-02' {

  include java
  include firewall_es

  class { 'elasticsearch':
    config      => { 'cluster.name'          => 'mycluster',
      'network.host'                         => $networking['interfaces']['eth1']['ip'],
      'discovery.zen.ping.multicast.enabled' => false,
      'discovery.zen.ping.unicast.hosts'     => '172.28.128.3' },
    package_url => 'https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/rpm/elasticsearch/2.1.0/elasticsearch-2.1.0.rpm',
  }

  elasticsearch::instance { 'es-01': }

  Class['java'] ->
    Class['elasticsearch']

}

class firewall_es {

  firewall { '100 allow web api':
    chain  => 'INPUT',
    state  => ['NEW'],
    dport  => '9200',
    proto  => 'tcp',
    action => accept,
  }

  firewall { '200 allow cluster':
    chain  => 'INPUT',
    state  => ['NEW'],
    dport  => '9300',
    proto  => 'tcp',
    action => accept,
  }

}