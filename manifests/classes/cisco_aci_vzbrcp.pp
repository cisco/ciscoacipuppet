#
# May 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet Class for Puppet Resource vzbrcp
# For documentation for the Managed Object corresponding to this Puppet Type
# please refer to the following URL: https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzBrCP.html
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
# please refer to <module_directory>/lib/puppet/type/cisco_aci_vzbrcp.rb
#
# This class is capable of obtaining the parameters from external sources like
# Puppet Hiera. When using Hiera YAML, please refer to Puppet documentation for
# details. This class supports an additional, optional parameter 'override_ensure'
# that can be used to dynamically override the $vzbrcp_ensure parameter
#
# Note: The override_descr argument is primarily used for testing. It can be
# used to override the $vzbrcp_descr argument
#
class cisco_aci::classes::cisco_aci_vzbrcp (
    $vzbrcp_ensure,
    $vzbrcp_name, #Instance Identifier
    $vzbrcp_fvtenant, #Parent cisco_aci_fvtenant Identifier
    $vzbrcp_descr,
    $vzbrcp_name_alias,
    $vzbrcp_owner_key,
    $vzbrcp_owner_tag,
    $vzbrcp_prio,
    $vzbrcp_scope,
    $vzbrcp_target_dscp,
    $override_ensure = $vzbrcp_ensure,
    $override_descr = $vzbrcp_descr,
) {
    cisco_aci_vzbrcp {'deploy_vzbrcp':
          ensure      => $override_ensure,
          name        => $vzbrcp_name,
          fvtenant    => $vzbrcp_fvtenant,
          descr       => $override_descr,
          name_alias  => $vzbrcp_name_alias,
          owner_key   => $vzbrcp_owner_key,
          owner_tag   => $vzbrcp_owner_tag,
          prio        => $vzbrcp_prio,
          scope       => $vzbrcp_scope,
          target_dscp => $vzbrcp_target_dscp,
      }

}