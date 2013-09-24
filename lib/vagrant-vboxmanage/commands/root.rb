module VagrantPlugins
  module VBoxManage
    module Command
      class Root < Vagrant.plugin(2, :command)
        
        def execute
          options = {}

          opts = OptionParser.new do |opts|
            opts.banner = "Usage: vagrant vboxmanage [vm-name] [--] <vboxmanage-cmd> [UUID] [cmd-args]..."
          end

          if split_index = @argv.index('--')
            # of form `vagrant vboxmanage [vm-name] -- showvminfo ...`
            options[:command] = @argv[split_index + 1]
            options[:extra_args] = @argv.drop(split_index + 2) 
            @argv = @argv.take(split_index)
          elsif command_index = @argv.index { |x| vboxmanage_commands_all.include?(x)}
            # of form `vagrant vboxmanage [vm-name] showvminfo...`
            options[:command] = @argv[command_index]
            options[:extra_args] = @argv.drop(command_index + 1)
            @argv = @argv.take(command_index)
          else
            @env.ui.error opts
            @env.ui.error "No valid VBoxManage subcommand detected."
            return 1
          end

          @logger.debug "Parsing options:" + options.merge({"argv" => @argv}).to_yaml

          argv = parse_options(opts)
          return if argv.length > 1

          with_target_vms(argv, single_target: true) do |machine|
            if machine.state.id == :not_created
              machine.env.ui.error("Target machine is not created, unable to run VBoxManage.")
            end

            if vboxmanage_commands_standard.include?(options[:command])
              @logger.debug("Performing UUID insertion for standard vboxmanage command: #{options[:command]}")
              args = [options[:command], machine.id] + options[:extra_args]
            else
              @logger.debug("Skipping UUID insertion for special vboxmanage command: #{options[:command]}")
              # TODO: handle substitution for commands like `usbfilter add 0 --target <uuid|name>`
              # [VM_UUID] is an optiona literal token `VM_UUID`, which will be replaced by the UUID of the VM referenced by Vagrant
              args = [options[:command]] + options[:extra_args]
            end

            @logger.debug("Executing: VBoxManage " + args.join(" "))
            machine.provider.driver.execute(*args) do |type, data|
              colors = { :stdout => :green, :stderr => :red }
              machine.env.ui.info(data, :color => colors[type])
            end
          end
        end

        def vboxmanage_commands_all 
          # derived as follows: `VBoxManage | sed '1,/Commands/d' | grep '^  [a-z]' | awk '{ print $1; }' | sort -u`
          return %w{adoptstate bandwidthctl clonehd clonevm closemedium controlvm convertfromraw
            createhd createvm debugvm dhcpserver discardstate export extpack
            getextradata guestcontrol guestproperty hostonlyif import list
            metrics modifyhd modifyvm registervm setextradata setproperty
            sharedfolder showhdinfo showvminfo snapshot startvm storageattach
            storagectl unregistervm usbfilter}
        end

        # not of form `VBoxManage showvminfo uuid|name ...`
        def vboxmanage_commands_special
          #   derived by manual inspection of `VBoxManage`; see SPECIAL_COMMANDS.md
          return %w{list registervm createvm import export closemedium createhd clonehd
            convertfromraw getextradata setextradata setproperty usbfilter
            sharedfolder guestproperty metrics hostonlyif dhcpserver extpack}
        end

        # of form `VBoxManage showvminfo uuid|name ...`
        def vboxmanage_commands_standard
          return vboxmanage_commands_all - vboxmanage_commands_special
        end
      end
    end
  end
end
