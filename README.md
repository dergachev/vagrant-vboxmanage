vagrant-vboxmanage
==================================

[![Gem Version](https://badge.fury.io/rb/vagrant-vboxmanage.png)](http://badge.fury.io/rb/vagrant-vboxmanage)

Vagrant plugin that simplifies calling `VBoxManage` on your Vagrant VM, by automatically injecting 
the machine uuid argument into the right spot. So instead of this:

```
VBoxManage showvminfo `cat .vagrant/machines/default/virtualbox/id` --details
```

You can just do this:

```
vagrant vboxmanage showvminfo --details
```

## Usage

The following commands are added by this plugin:

     vagrant vboxmanage [vm-name] [--] <subcommand> [args]

Where:

* `<subcommand>` is the [VBoxManage subcommand](http://www.virtualbox.org/manual/ch08.html), eg *showvminfo*
* `[vm-name]` is the VM name; must be specified if multiple VMs are defined in Vagrantfile

For all VBoxManage commands except those listed in [SPECIAL_COMMANDS.txt](https://github.com/dergachev/vagrant-vboxmanage/blob/master/SPECIAL_COMMANDS.txt), the VM uuid will be inserted immediately after the command name. 

Examples:

    # in case of a single VM environment
    vagrant vboxmanage showvminfo --details
    
    # in case of multi-VM environment
    vagrant vboxmanage mysql01 showvminfo  --details

## Caveats

* Only minimally tested.
* TODO: support for UUID substitution for `SPECIAL_COMMANDS.txt` commands
* TODO: show VBoxManage-like usage help.
* On my system, running `vagrant -h` takes 3 seconds... 
  which means this plugin introduces a 3 second lag over VBoxManage straight.

## Installation

Ensure you have Vagrant 1.1+ installed, then run:

    vagrant plugin install vagrant-vboxmanage

## Development

To develop on this plugin, do the following:

```
# get the repo, and then make a feature branch (REPLACE WITH YOUR FORK)
git clone https://github.com/dergachev/vagrant-vboxmanage.git
cd vagrant-vboxmanage
git checkout -b MY-NEW-FEATURE

# installs the vagrant gem, which is a dev dependency
bundle install 

# hack on the plugin
vim lib/vagrant-vboxmanage.rb # or any other file

# test out your changes, in the context provided by the development vagrant gem, and the local Vagrantfile.
bundle exec vagrant snapshot ...

# commit, push, and do a pull-request
```

See [DEVNOTES.md](https://github.com/dergachev/vagrant-vboxmanage/blob/master/DEVNOTES.md)
for the notes I compiled while developing this plugin.
