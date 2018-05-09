#
# May 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet Class for Puppet Resource fvbd
# For documentation for the Managed Object corresponding to this Puppet Type
# please refer to the following URL: https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html
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
# please refer to <module_directory>/lib/puppet/type/cisco_aci_fvbd.rb
#
# This class is capable of obtaining the parameters from external sources like
# Puppet Hiera. When using Hiera YAML, please refer to Puppet documentation for
# details. This class supports an additional, optional parameter 'override_ensure'
# that can be used to dynamically override the $fvbd_ensure parameter
#
# Note: The override_descr argument is primarily used for testing. It can be
# used to override the $fvbd_descr argument
#
class cisco_aci::classes::cisco_aci_fvbd (
    $fvbd_ensure,
    $fvbd_name, #Instance Identifier
    $fvbd_fvtenant, #Parent cisco_aci_fvtenant Identifier
    $fvbd_arp_flood,
    $fvbd_descr,
    $fvbd_ep_clear,
    $fvbd_ep_move_detect_mode,
    $fvbd_intersite_bum_traffic_allow,
    $fvbd_intersite_l2_stretch,
    $fvbd_ip_learning,
    $fvbd_limit_ip_learn_to_subnets,
    $fvbd_ll_addr,
    $fvbd_mac,
    $fvbd_mcast_allow,
    $fvbd_multi_dst_pkt_act,
    $fvbd_name_alias,
    $fvbd_optimize_wan_bandwidth,
    $fvbd_owner_key,
    $fvbd_owner_tag,
    $fvbd_type,
    $fvbd_unicast_route,
    $fvbd_unk_mac_ucast_act,
    $fvbd_unk_mcast_act,
    $fvbd_vmac,
    $override_ensure = $fvbd_ensure,
    $override_descr = $fvbd_descr,
) {
    cisco_aci_fvbd {'deploy_fvbd':
          ensure                      => $override_ensure,
          name                        => $fvbd_name,
          fvtenant                    => $fvbd_fvtenant,
          arp_flood                   => $fvbd_arp_flood,
          descr                       => $override_descr,
          ep_clear                    => $fvbd_ep_clear,
          ep_move_detect_mode         => $fvbd_ep_move_detect_mode,
          intersite_bum_traffic_allow => $fvbd_intersite_bum_traffic_allow,
          intersite_l2_stretch        => $fvbd_intersite_l2_stretch,
          ip_learning                 => $fvbd_ip_learning,
          limit_ip_learn_to_subnets   => $fvbd_limit_ip_learn_to_subnets,
          ll_addr                     => $fvbd_ll_addr,
          mac                         => $fvbd_mac,
          mcast_allow                 => $fvbd_mcast_allow,
          multi_dst_pkt_act           => $fvbd_multi_dst_pkt_act,
          name_alias                  => $fvbd_name_alias,
          optimize_wan_bandwidth      => $fvbd_optimize_wan_bandwidth,
          owner_key                   => $fvbd_owner_key,
          owner_tag                   => $fvbd_owner_tag,
          type                        => $fvbd_type,
          unicast_route               => $fvbd_unicast_route,
          unk_mac_ucast_act           => $fvbd_unk_mac_ucast_act,
          unk_mcast_act               => $fvbd_unk_mcast_act,
          vmac                        => $fvbd_vmac,
      }

}