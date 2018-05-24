require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.ignore_paths = ['spec/**/*.pp', 'pkg/**/*.pp']


desc 'Task to build puppet module and install it'
task :build do
  puppet_version = Facter.value(:puppetversion)
  if puppet_version.nil?
    fail "Can't find a puppet version."
  end
  build_cmd = 'puppet module build'
  uninstall_cmd = 'puppet module uninstall cisco-cisco_aci'
  install_cmd = 'puppet module install pkg/cisco-cisco_aci*gz'
  sh "#{build_cmd}"
  sh "#{uninstall_cmd}" do |ok, res|
  end
  sh "#{install_cmd}"
end
