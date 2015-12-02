## ElasticSearch Vagrant Puppet

A simple multi-machine environment with two nodes ES cluster (es-01 and es-02) and a load balancer (nginx) (balancer)

###Requirements

* Vagrant 1.7.4+
* VirtualBox 4+
* vagrant-r10k

###Getting started

`mkdir environments/production/modules`

`vagrant up`

And you're ready for:

http://172.28.128.2 or http://172.28.128.2/_cluster/health 