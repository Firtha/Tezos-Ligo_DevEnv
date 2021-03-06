# Tezos-Ligo_DevEnv

Vagrant VM : Ubuntu 18.04 with Truffle-Tezos (based on the truffle box tezos-example).

## Installation

Required : Vagrant installed on your host computer.

Required : Vagrant plugin installed (vagrant-disksize) on your host computer.

```shell
# vagrant plugin install vagrant-disksize
```

## Mount the Virtual Machine

After cloning the repository, go to its folder and then:

```shell
# vagrant up
```

When finished:

```shell
# vagrant ssh
```

The workplace is in /home/vagrant/tezos-workplace.

### Vagrant commons (always entered from host computer)

```shell
Launch or mount (if needed) the VM from Vagrantfile:
# vagrant up

Open SSH connection with VM:
# vagrant ssh

Stop the VM:
# vagrant halt

Destroy the VM (destroys current folder VM if no ID specified):
# vagrant destroy $VM_ID

Check vagrant VMs status and IDs:
# vagrant global-status
```

### Author's advice

Use this VM with an associated Github project, covering contracts, migrations and test folders.

The importWorkFolders.sh script updates the content of the truffle project (contracts, migrations and test files), inside the VM, with the content of your shared folder.
