Vagrant.configure(2) do |config|

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :machine

    config.cache.enable :yum
  end

  config.r10k.puppetfile_path = 'Puppetfile'
  config.r10k.puppet_dir = 'environments'
  config.r10k.module_path = 'environments/production/modules'

  config.vm.define "balancer" do |v|
    v.vm.box = "puppetlabs/centos-6.6-64-puppet"
    v.vm.host_name = "balancer"

    v.vm.provider "virtualbox" do |virtualbox|
      virtualbox.name = "centos-6-balancer"
      virtualbox.memory = 512
    end

    v.vm.network "private_network", ip: "172.28.128.2"

    v.vm.provision :puppet do |puppet|
      puppet.environment_path = "environments"
      puppet.environment = "production"
      # puppet.options = "--verbose --debug --trace --profile"
    end
  end

  config.vm.define "es-01" do |v|
    v.vm.box = "puppetlabs/centos-6.6-64-puppet"
    v.vm.host_name = "server-01"

    v.vm.provider "virtualbox" do |virtualbox|
      virtualbox.name = "centos-6-elasticsearch-01"
      virtualbox.memory = 1024
    end

    v.vm.network "private_network", ip: "172.28.128.3"

    v.vm.provision :puppet do |puppet|
      puppet.environment_path = "environments"
      puppet.environment = "production"
      # puppet.options = "--verbose --debug --trace --profile"
    end
  end

  config.vm.define "es-02" do |v|
    v.vm.box = "puppetlabs/centos-6.6-64-puppet"
    v.vm.host_name = "server-02"

    v.vm.provider "virtualbox" do |virtualbox|
      virtualbox.name = "centos-6-elasticsearch-02"
      virtualbox.memory = 1024
    end

    v.vm.network "private_network", ip: "172.28.128.4"

    v.vm.provision :puppet do |puppet|
      puppet.environment_path = "environments"
      puppet.environment = "production"
      # puppet.options = "--verbose --debug --trace --profile"
    end
  end

end
