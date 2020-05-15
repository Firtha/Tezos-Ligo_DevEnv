Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/bionic64"

    # Install vagrant plugin with (host cmd) "$ vagrant plugin install vagrant-disksize" for this to work
    config.disksize.size = '30GB'

    config.vm.provider "virtualbox" do |v|
        v.name = "Tezos-VM"
        v.memory = 2048
    end

    config.vm.provision :shell, path: "provisionning.sh"
end