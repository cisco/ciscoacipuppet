#
# May 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet Class for Puppet Resource fvctx
# For documentation for the Managed Object corresponding to this Puppet Type
# please refer to the following URL: https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvCtx.html
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
# please refer to <module_directory>/lib/puppet/type/cisco_aci_fvctx.rb
#
# This class is capable of obtaining the parameters from external sources like
# Puppet Hiera. When using Hiera YAML, please refer to Puppet documentation for
# details. This class supports an additional, optional parameter 'override_ensure'
# that can be used to dynamically override the $fvctx_ensure parameter
#
# Note: The override_descr argument is primarily used for testing. It can be
# used to override the $fvctx_descr argument
#
class cisco_aci::classes::cisco_aci_fvctx (
    $fvctx_ensure,
    $fvctx_name, #Instance Identifier
    $fvctx_fvtenant, #Parent cisco_aci_fvtenant Identifier
    $fvctx_bd_enforced_enable,
    $fvctx_descr,
    $fvctx_knw_mcast_act,
    $fvctx_name_alias,
    $fvctx_owner_key,
    $fvctx_owner_tag,
    $fvctx_pc_enf_dir,
    $fvctx_pc_enf_pref,
    $override_ensure = $fvctx_ensure,
    $override_descr = $fvctx_descr,
) {
    cisco_aci_fvctx {'deploy_fvctx':
          ensure             => 'present',
          name               => $fvctx_name,
          bd_enforced_enable => $fvctx_bd_enforced_enable,
          descr              => $fvctx_descr,
          knw_mcast_act      => $fvctx_knw_mcast_act,
          name_alias         => $fvctx_name_alias,
          owner_key          => $fvctx_owner_key,
          owner_tag          => $fvctx_owner_tag,
          pc_enf_dir         => $fvctx_pc_enf_dir,
          pc_enf_pref        => $fvctx_pc_enf_pref,
  }

}