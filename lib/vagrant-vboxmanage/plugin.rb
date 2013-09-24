begin
    require "vagrant"
rescue LoadError
    raise "The vagrant-vboxmanage plugin must be run within Vagrant."
end

module VagrantPlugins
  module VBoxManage
    class Plugin < Vagrant.plugin("2")
      name "vagrant-vboxmanage"
      description "Simplifies calling the `VBoxManage` command."

      command "vboxmanage" do
        require_relative 'commands/root.rb'
        Command::Root
      end

    end
  end
end
