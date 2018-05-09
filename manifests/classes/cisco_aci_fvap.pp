#
# May 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet Class for Puppet Resource fvap
# For documentation for the Managed Object corresponding to this Puppet Type
# please refer to the following URL: https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvAp.html
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
# please refer to <module_directory>/lib/puppet/type/cisco_aci_fvap.rb
#
# This class is capable of obtaining the parameters from external sources like
# Puppet Hiera. When using Hiera YAML, please refer to Puppet documentation for
# details. This class supports an additional, optional parameter 'override_ensure'
# that can be used to dynamically override the $fvap_ensure parameter
#
# Note: The override_descr argument is primarily used for testing. It can be
# used to override the $fvap_descr argument
#
class cisco_aci::classes::cisco_aci_fvap (
    $fvap_ensure,
    $fvap_name, #Instance Identifier
    $fvap_fvtenant, #Parent cisco_aci_fvtenant Identifier
    $fvap_descr,
    $fvap_name_alias,
    $fvap_owner_key,
    $fvap_owner_tag,
    $fvap_prio,
    $override_ensure = $fvap_ensure,
    $override_descr = $fvap_descr,
) {
    cisco_aci_fvap {'deploy_fvap':
          ensure     => $override_ensure,
          name       => $fvap_name,
          fvtenant   => $fvap_fvtenant,
          descr      => $override_descr,
          name_alias => $fvap_name_alias,
          owner_key  => $fvap_owner_key,
          owner_tag  => $fvap_owner_tag,
          prio       => $fvap_prio,
      }

}