vagrant-vboxmanage
==================================
Vagrant plugin that simplifies calling `VBoxManage cmd UUID`

## Usage

The following commands are added by this plugin:

     vagrant vboxmanage [vm-name] [--] <subcommand> [args]

Where:

* `<subcommand>` is the VBoxManage subcommand, eg `showvminfo` 
  * See http://www.virtualbox.org/manual/ch08.html
* `[vm-name]` is the VM name; must be specified if multiple VMs are defined in Vagrantfile

For all commands except those listed in `SPECIAL_COMMANDS.md`, the VM uuid will be inserted
immediately after the command name. For example:

    # calls `VBoxManage showvminfo a0b76635-3c88-45ea-b26e-e9f442dc1f6e`
    vagrant vboxmanage showvminfo --details    

## Caveats

* Only minimally tested.
* TODO: support for UUID substitution for irregular commands like `guestproperty`.
* TODO: show VBoxManage-like usage help.

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
