#
# May 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet Class for Puppet Resource vzfilter
# For documentation for the Managed Object corresponding to this Puppet Type
# please refer to the following URL: https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzFilter.html
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
# please refer to <module_directory>/lib/puppet/type/cisco_aci_vzfilter.rb
#
# This class is capable of obtaining the parameters from external sources like
# Puppet Hiera. When using Hiera YAML, please refer to Puppet documentation for
# details. This class supports an additional, optional parameter 'override_ensure'
# that can be used to dynamically override the $vzfilter_ensure parameter
#
# Note: The override_descr argument is primarily used for testing. It can be
# used to override the $vzfilter_descr argument
#
class cisco_aci::classes::cisco_aci_vzfilter (
    $vzfilter_ensure,
    $vzfilter_name, #Instance Identifier
    $vzfilter_fvtenant, #Parent cisco_aci_fvtenant Identifier
    $vzfilter_descr,
    $vzfilter_name_alias,
    $vzfilter_owner_key,
    $vzfilter_owner_tag,
    $override_ensure = $vzfilter_ensure,
    $override_descr = $vzfilter_descr,
) {
    cisco_aci_vzfilter {'deploy_vzfilter':
          ensure     => $override_ensure,
          name       => $vzfilter_name,
          fvtenant   => $vzfilter_fvtenant,
          descr      => $override_descr,
          name_alias => $vzfilter_name_alias,
          owner_key  => $vzfilter_owner_key,
          owner_tag  => $vzfilter_owner_tag,
      }

}
