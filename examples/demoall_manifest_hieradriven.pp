#
# February 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Sample Puppet manifest to demonstrate the type and provider in the module
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
# Sample manifest that uses component classes and hiera data to test/demo
# provisioning of the resources defined in the module.
#

#Proxy Agent Node configuration
#Note-1: Replace 'proxy-agent.example.com' with FDQN for your Proxy Agent Node
#Note-2: Replace 'apic.example.com' with FDQN for your APIC node
#Note-3: Replace 'username:password' with credential for your APIC
#Note-4: This demo manifest is hiera data driven. Ensure that you have populated hiera data on the server
#        A sample hiera data file (demo_hiera_data.yaml is in this directory)

node 'proxy-agent.example.com' {
  device_manager {'apic.example.com':
    type         => 'apic',  # Specifies the type of the device in device.conf.
    url          => 'https://username:password@apic.example.com', # Specifies the URL of the device in device.conf.
    run_interval =>  30,     # Execute `puppet device --target apic.example.com` every 30 minutes.
  }
}

#APIC Node configuration

node 'apic.example.com' {
#
#Change the variables operation to "present" or "absent" to provision or
#un-provision. if you skip the $override_ensure or set it to "undef", the
#operation of the individual puppet component classes will be controlled
#by the hiera data
#
#For testing purpose, one can also override the description (descr) property
#associated with resources.

  $override_ensure = 'present'
  $override_descr = undef
  class {'cisco_aci::classes::cisco_aci_all':
    override_ensure => $override_ensure,
    override_descr  => $override_descr
  }

}
