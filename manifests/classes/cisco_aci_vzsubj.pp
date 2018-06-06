#
# May 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet Class for Puppet Resource vzsubj
# For documentation for the Managed Object corresponding to this Puppet Type
# please refer to the following URL: https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzSubj.html
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
# please refer to <module_directory>/lib/puppet/type/cisco_aci_vzsubj.rb
#
# This class is capable of obtaining the parameters from external sources like
# Puppet Hiera. When using Hiera YAML, please refer to Puppet documentation for
# details. This class supports an additional, optional parameter 'override_ensure'
# that can be used to dynamically override the $vzsubj_ensure parameter
#
# Note: The override_descr argument is primarily used for testing. It can be
# used to override the $vzsubj_descr argument
#
class cisco_aci::classes::cisco_aci_vzsubj (
    $vzsubj_ensure,
    $vzsubj_name, #Instance Identifier
    $vzsubj_fvtenant, #Parent cisco_aci_fvtenant Identifier
    $vzsubj_vzbrcp, #Parent cisco_aci_vzbrcp Identifier
    $vzsubj_cons_match_t,
    $vzsubj_descr,
    $vzsubj_name_alias,
    $vzsubj_prio,
    $vzsubj_prov_match_t,
    $vzsubj_rev_flt_ports,
    $vzsubj_target_dscp,
    $override_ensure = $vzsubj_ensure,
    $override_descr = $vzsubj_descr,
) {
    cisco_aci_vzsubj {'deploy_vzsubj':
          ensure        => $override_ensure,
          name          => $vzsubj_name,
          fvtenant      => $vzsubj_fvtenant,
          vzbrcp        => $vzsubj_vzbrcp,
          cons_match_t  => $vzsubj_cons_match_t,
          descr         => $override_descr,
          name_alias    => $vzsubj_name_alias,
          prio          => $vzsubj_prio,
          prov_match_t  => $vzsubj_prov_match_t,
          rev_flt_ports => $vzsubj_rev_flt_ports,
          target_dscp   => $vzsubj_target_dscp,
      }

}
