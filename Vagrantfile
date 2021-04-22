Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/bionic64"

    config.vm.provider "virtualbox" do |v|
        v.name = "Tezos-VM"
        v.memory = 4096
    end

    config.vm.boot_timeout = 900

    config.vm.provision :shell, path: "provisionning.sh"
end