#
# May 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet Class for Puppet Resource vzentry
# For documentation for the Managed Object corresponding to this Puppet Type
# please refer to the following URL: https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzEntry.html
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
# please refer to <module_directory>/lib/puppet/type/cisco_aci_vzentry.rb
#
# This class is capable of obtaining the parameters from external sources like
# Puppet Hiera. When using Hiera YAML, please refer to Puppet documentation for
# details. This class supports an additional, optional parameter 'override_ensure'
# that can be used to dynamically override the $vzentry_ensure parameter
#
# Note: The override_descr argument is primarily used for testing. It can be
# used to override the $vzentry_descr argument
#
class cisco_aci::classes::cisco_aci_vzentry (
    $vzentry_ensure,
    $vzentry_name, #Instance Identifier
    $vzentry_fvtenant, #Parent cisco_aci_fvtenant Identifier
    $vzentry_vzfilter, #Parent cisco_aci_vzfilter Identifier
    $vzentry_apply_to_frag,
    $vzentry_arp_opc,
    $vzentry_d_from_port,
    $vzentry_d_to_port,
    $vzentry_descr,
    $vzentry_ether_t,
    $vzentry_icmpv4_t,
    $vzentry_icmpv6_t,
    $vzentry_match_dscp,
    $vzentry_name_alias,
    $vzentry_prot,
    $vzentry_s_from_port,
    $vzentry_s_to_port,
    $vzentry_stateful,
    $vzentry_tcp_rules,
    $override_ensure = $vzentry_ensure,
    $override_descr = $vzentry_descr,
) {
    cisco_aci_vzentry {'deploy_vzentry':
          ensure        => $override_ensure,
          name          => $vzentry_name,
          fvtenant      => $vzentry_fvtenant,
          vzfilter      => $vzentry_vzfilter,
          apply_to_frag => $vzentry_apply_to_frag,
          arp_opc       => $vzentry_arp_opc,
          d_from_port   => $vzentry_d_from_port,
          d_to_port     => $vzentry_d_to_port,
          descr         => $override_descr,
          ether_t       => $vzentry_ether_t,
          icmpv4_t      => $vzentry_icmpv4_t,
          icmpv6_t      => $vzentry_icmpv6_t,
          match_dscp    => $vzentry_match_dscp,
          name_alias    => $vzentry_name_alias,
          prot          => $vzentry_prot,
          s_from_port   => $vzentry_s_from_port,
          s_to_port     => $vzentry_s_to_port,
          stateful      => $vzentry_stateful,
          tcp_rules     => $vzentry_tcp_rules,
      }

}
