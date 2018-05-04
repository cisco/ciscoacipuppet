#
# May 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet resource type for fvbd
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

Puppet::Type.newtype(:cisco_aci_fvbd) do
  # ---------------------------------------------------------------
  # @doc entry to describe the resource and usage
  # ---------------------------------------------------------------
  @doc = 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html'

  ensurable
  apply_to_device

  def self.title_patterns
    identity = ->(x) { x }
    patterns = []

    patterns << [
      /^(\S+)$/,
      [
        [:name, identity]
      ],
    ]
    patterns
  end

  # ---------------------------------------------------------------
  # Namevars (Instance Identifiers)
  # ---------------------------------------------------------------

  newparam(:name, namevar: true) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html#name'
  end

  # ---------------------------------------------------------------
  # Namevars (Parent Instance Identifiers)
  # ---------------------------------------------------------------

  newparam(:fvtenant, namevar: true) do
    desc 'Parent cisco_aci_fvtenant instance Identifier'
  end

  # ---------------------------------------------------------------
  # Properties
  # ---------------------------------------------------------------

  newproperty(:arp_flood) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html#arpFlood'
  end

  newproperty(:descr) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html#descr'
  end

  newproperty(:ep_clear) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html#epClear'
  end

  newproperty(:ep_move_detect_mode) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html#epMoveDetectMode'
  end

  newproperty(:intersite_bum_traffic_allow) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html#intersiteBumTrafficAllow'
  end

  newproperty(:intersite_l2_stretch) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html#intersiteL2Stretch'
  end

  newproperty(:ip_learning) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html#ipLearning'
  end

  newproperty(:limit_ip_learn_to_subnets) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html#limitIpLearnToSubnets'
  end

  newproperty(:ll_addr) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html#llAddr'
  end

  newproperty(:mac) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html#mac'
  end

  newproperty(:mcast_allow) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html#mcastAllow'
  end

  newproperty(:multi_dst_pkt_act) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html#multiDstPktAct'
  end

  newproperty(:name_alias) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html#nameAlias'
  end

  newproperty(:optimize_wan_bandwidth) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html#OptimizeWanBandwidth'
  end

  newproperty(:owner_key) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html#ownerKey'
  end

  newproperty(:owner_tag) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html#ownerTag'
  end

  newproperty(:type) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html#type'
  end

  newproperty(:unicast_route) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html#unicastRoute'
  end

  newproperty(:unk_mac_ucast_act) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html#unkMacUcastAct'
  end

  newproperty(:unk_mcast_act) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html#unkMcastAct'
  end

  newproperty(:vmac) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html#vmac'
  end
end
