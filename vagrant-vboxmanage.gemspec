$:.unshift File.expand_path('../lib', __FILE__)
require 'vagrant-vboxmanage/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-vboxmanage"
  spec.version       = VagrantPlugins::VBoxManage::VERSION
  spec.authors       = "Alex Dergachev"
  spec.email         = "alex@evolvingweb.ca"
  spec.summary       = 'Vagrant plugin that simplifies calling the `VBoxManage` command.'
  spec.homepage      = 'https://github.com/dergachev/vagrant-vboxmanage'
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_path  = 'lib'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
