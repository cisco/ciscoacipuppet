#
# May 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet Class for Puppet Resource fvaepg
# For documentation for the Managed Object corresponding to this Puppet Type
# please refer to the following URL: https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvAEPg.html
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
# please refer to <module_directory>/lib/puppet/type/cisco_aci_fvaepg.rb
#
# This class is capable of obtaining the parameters from external sources like
# Puppet Hiera. When using Hiera YAML, please refer to Puppet documentation for
# details. This class supports an additional, optional parameter 'override_ensure'
# that can be used to dynamically override the $fvaepg_ensure parameter
#
# Note: The override_descr argument is primarily used for testing. It can be
# used to override the $fvaepg_descr argument
#
class cisco_aci::classes::cisco_aci_fvaepg (
    $fvaepg_ensure,
    $fvaepg_name, #Instance Identifier
    $fvaepg_fvtenant, #Parent cisco_aci_fvtenant Identifier
    $fvaepg_fvap, #Parent cisco_aci_fvap Identifier
    $fvaepg_descr,
    $fvaepg_fwd_ctrl,
    $fvaepg_is_attr_based_e_pg,
    $fvaepg_match_t,
    $fvaepg_name_alias,
    $fvaepg_pc_enf_pref,
    $fvaepg_pref_gr_memb,
    $fvaepg_prio,
    $override_ensure = $fvaepg_ensure,
    $override_descr = $fvaepg_descr,
) {
    cisco_aci_fvaepg {'deploy_fvaepg':
          ensure => $override_ensure,
          name => $fvaepg_name,
          fvtenant => $fvaepg_fvtenant,
          fvap => $fvaepg_fvap,
          descr => $override_descr,
          fwd_ctrl => $fvaepg_fwd_ctrl,
          is_attr_based_e_pg => $fvaepg_is_attr_based_e_pg,
          match_t => $fvaepg_match_t,
          name_alias => $fvaepg_name_alias,
          pc_enf_pref => $fvaepg_pc_enf_pref,
          pref_gr_memb => $fvaepg_pref_gr_memb,
          prio => $fvaepg_prio,
      }

}