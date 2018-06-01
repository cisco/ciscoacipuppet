#
# June 2018
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
# Wrapper class that uses component classes and hiera data to test
# provisioning of the resources defined in the module. It provides
# an optional parameter 'override_ensure' to that overrides the hiera data
# related to the ensure parameter.
#
# Example-1: When no parameter is specified hiera data will be used
# Example-2: When parameter override_ensure=>"present", component classes will
# use all the data from the hiera, except ensure. This allows one
# to test the provisioning of all the resources, without having to
# modify the hiera yaml
# Example-3: When parameter override_ensure=absent, component classes will
# use all the data from the hiera, except ensure. This allows one
# to test the un-provisioning of all the resources, without having to
# modify the hiera yaml
#
# Note: optional override_descr is primarily for testing and can be used
# override the description (descr) property.
#
class cisco_aci::classes::cisco_aci_all (
    $override_ensure = undef,
    $override_descr = undef
) {

  class {'cisco_aci::classes::cisco_aci_fvtenant':
    override_ensure => $override_ensure,
    override_descr  => $override_descr
  }
  class {'cisco_aci::classes::cisco_aci_fvap':
    override_ensure => $override_ensure,
    override_descr  => $override_descr
  }
  class {'cisco_aci::classes::cisco_aci_fvbd':
    override_ensure => $override_ensure,
    override_descr  => $override_descr
  }
  class {'cisco_aci::classes::cisco_aci_fvctx':
    override_ensure => $override_ensure,
    override_descr  => $override_descr
  }
  class {'cisco_aci::classes::cisco_aci_vzbrcp':
    override_ensure => $override_ensure,
    override_descr  => $override_descr
  }
  class {'cisco_aci::classes::cisco_aci_vzfilter':
    override_ensure => $override_ensure,
    override_descr  => $override_descr
  }
  class {'cisco_aci::classes::cisco_aci_fvaepg':
    override_ensure => $override_ensure,
    override_descr  => $override_descr
  }
  class {'cisco_aci::classes::cisco_aci_fvsubnet':
    override_ensure => $override_ensure,
    override_descr  => $override_descr
  }
  class {'cisco_aci::classes::cisco_aci_vzentry':
    override_ensure => $override_ensure,
    override_descr  => $override_descr
  }
  class {'cisco_aci::classes::cisco_aci_vzsubj':
    override_ensure => $override_ensure,
    override_descr  => $override_descr
  }

  Class['cisco_aci::classes::cisco_aci_fvtenant']
  -> Class['cisco_aci::classes::cisco_aci_fvap']
  -> Class['cisco_aci::classes::cisco_aci_fvbd']
  -> Class['cisco_aci::classes::cisco_aci_fvctx']
  -> Class['cisco_aci::classes::cisco_aci_vzbrcp']
  -> Class['cisco_aci::classes::cisco_aci_vzfilter']
  -> Class['cisco_aci::classes::cisco_aci_fvaepg']
  -> Class['cisco_aci::classes::cisco_aci_fvsubnet']
  -> Class['cisco_aci::classes::cisco_aci_vzentry']
  -> Class['cisco_aci::classes::cisco_aci_vzsubj']

}