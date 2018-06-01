#
# February 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Rspec helper for acceptance test
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# TBD: After discussion with Puppet Labs
#     (i)  add 'puppet device' execution into the apply_manifest method
#     (ii) gather the device credentials from .rspec in the
#          create_device_conf_on_proxy
#     (iii)Add the Expectation clause once we start using the 'puppet device'
#     (iv) clean the nodeset/default.yaml
#     (v) Add steps to clean the master after execution
require 'spec_helper'
require 'beaker-rspec'

def apply_manifest(manifest)
  manifestdir = '/etc/puppetlabs/code/environments/production/manifests/'
  proxy = hosts_as('proxy').first
  on master, "mkdir -p #{manifestdir}"
  create_remote_file(master, File.join(manifestdir, 'site.pp'), manifest)
  on master, "chown -R root:puppet #{manifestdir}"
  on master, "chmod -R 0755 #{manifestdir}"
  on proxy, "/opt/puppetlabs/bin/puppet device --verbose --server #{master}" do
    return stdout, stderr
  end
end

def create_device_conf_on_proxy
  proxy = hosts_as('proxy').first
  conf = "[#{proxy[:aci_server_name]}]\ntype apic\nurl https://#{proxy[:aci_user]}:#{proxy[:aci_password]}@#{proxy[:aci_ip]}/"
  create_remote_file(proxy, '/etc/puppetlabs/puppet/device.conf', conf)
end

def cleanup_certs
  proxy = hosts_as('proxy').first
  name = proxy[:aci_server_name]
  on master, "puppet cert clean #{name}" do
    puts stdout
  end
  on proxy, "find /opt/puppetlabs/puppet/cache/devices/#{name}/ssl -name #{name}.pem -delete" do
    puts stdout
  end
  # on proxy, "puppet agent -t" do
  #  puts stdout
  # end
end

RSpec.configure do |c|
  c.formatter = :documentation
  c. before :suite do
    master.add_env_var('PATH', '/opt/puppetlabs/bin')
    create_device_conf_on_proxy
    cleanup_certs
  end
end
