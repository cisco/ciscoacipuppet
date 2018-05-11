#
# May 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet Class for Puppet Resource fvsubnet
# For documentation for the Managed Object corresponding to this Puppet Type
# please refer to the following URL: https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvSubnet.html
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
# For details on the Puppet Resource Type associated with this class
# please refer to <module_directory>/lib/puppet/type/cisco_aci_fvsubnet.rb
#
# This class is capable of obtaining the parameters from external sources like
# Puppet Hiera. When using Hiera YAML, please refer to Puppet documentation for
# details. This class supports an additional, optional parameter 'override_ensure'
# that can be used to dynamically override the $fvsubnet_ensure parameter
#
# Note: The override_descr argument is primarily used for testing. It can be
# used to override the $fvsubnet_descr argument
#
class cisco_aci::classes::cisco_aci_fvsubnet (
    $fvsubnet_ensure,
    $fvsubnet_ip, #Instance Identifier
    $fvsubnet_fvtenant, #Parent cisco_aci_fvtenant Identifier
    $fvsubnet_fvbd, #Parent cisco_aci_fvbd Identifier
    $fvsubnet_ctrl,
    $fvsubnet_descr,
    $fvsubnet_name,
    $fvsubnet_name_alias,
    $fvsubnet_preferred,
    $fvsubnet_scope,
    $fvsubnet_virtual,
    $override_ensure = $fvsubnet_ensure,
    $override_descr = $fvsubnet_descr,
) {
    cisco_aci_fvsubnet {'deploy_fvsubnet':
          ensure     => $override_ensure,
          ip         => $fvsubnet_ip,
          fvtenant   => $fvsubnet_fvtenant,
          fvbd       => $fvsubnet_fvbd,
          ctrl       => $fvsubnet_ctrl,
          descr      => $override_descr,
          name       => $fvsubnet_name,
          name_alias => $fvsubnet_name_alias,
          preferred  => $fvsubnet_preferred,
          scope      => $fvsubnet_scope,
          virtual    => $fvsubnet_virtual,
      }

}