# Developer notes for vagrant-vboxmanage

## Packaging a gem

See https://github.com/dergachev/vagrant-vbox-snapshot/blob/master/DEVNOTES.md#pushing-out-a-new-release-of-the-gem

In the future, also consider this workflow:

```
# build the gem locally
vim lib/vagrant-vboxmanage/version.rb +/VERSION # increment version counter, eg to 0.0.3
rake build  # package the gem into ./pkg/vagrant-vboxmanage-0.0.3.gem

# install and test the gem locally
vagrant plugin uninstall vagrant-vboxmanage
vagrant plugin install ./pkg/vagrant-vboxmanage-0.0.3.gem      # FIX VERSION NUMBER!!
cd ~/code/screengif 
vagrant vboxmanage showvminfo  # works...

# commit and publish the gem
vim CHANGELOG.md      # add v0.0.3 details
git commit -m "Publishing v0.0.3" CHANGELOG.md lib/vagrant-vboxmanage/version.rb

rake release
git push --tags
```

See http://asciicasts.com/episodes/245-new-gem-with-bundler

## Resources 

Testing is a big TODO:

* https://github.com/mitchellh/vagrant/blob/master/test/acceptance/ssh_test.rb

VBoxManage info:

* http://www.virtualbox.org/manual/ch08.html

Other Vagrant command examples:

* https://github.com/mitchellh/vagrant/blob/master/plugins/providers/virtualbox/driver/version_4_1.rb
* https://github.com/mitchellh/vagrant/blob/master/plugins/commands/ssh/command.rb
