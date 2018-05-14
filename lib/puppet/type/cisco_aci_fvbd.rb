#
# May 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet resource type for fvbd
# For documentation for the Managed Object corresponding to this Puppet Type
# please refer to the following URL
# https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html
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
  @doc = 'A bridge domain is a unique layer 2 forwarding domain that contains one or more
  subnets. Each bridge domain must be linked to a context.'

  ensurable
  apply_to_device

  def self.title_patterns
    identity = ->(x) { x }
    patterns = []

    patterns << [
      /^(\S+)$/,
      [
        [:name, identity],
      ],
    ]
    patterns
  end

  # ---------------------------------------------------------------
  # Namevars (Instance Identifiers)
  # ---------------------------------------------------------------

  newparam(:name, namevar: true) do
    desc 'The bridge domain name.'
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
    desc 'A property to specify whether ARP flooding is enabled. If flooding is disabled,
    unicast routing will be performed on the target IP address.'
  end

  newproperty(:descr) do
    desc 'Specifies a description of the policy definition root.'
  end

  newproperty(:ep_clear) do
    desc 'Represents the parameter used by the node (i.e. Leaf) to clear all EPs in all
    leaves for this BD.'
  end

  newproperty(:ep_move_detect_mode) do
    desc 'The End Point move detection option uses the Gratuitous Address Resolution
    Protocol (GARP). A gratuitous ARP is an ARP broadcast-type of packet that is
    used to verify that no other device on the network has the same IP address as
    the sending device.'
  end

  newproperty(:intersite_bum_traffic_allow) do
    desc 'Control whether BUM traffic is allowed between sites.'
  end

  newproperty(:intersite_l2_stretch) do
    desc 'l2Stretch flag is enabled between sites.'
  end

  newproperty(:ip_learning) do
    desc ''
  end

  newproperty(:limit_ip_learn_to_subnets) do
    desc 'Limits IP address learning to the bridge domain subnets only. Every BD can have
    multiple subnets associated with it. By default, all IPs are learned.'
  end

  newproperty(:ll_addr) do
    desc 'The override of the system generated IPv6 link-local address.'
  end

  newproperty(:mac) do
    desc 'The MAC address of the bridge domain (BD) or switched virtual interface (SVI).
    Every BD by default takes the fabric wide default mac address. If user wants
    then he can override that address and with a different one By default the BD
    will take a 00:22:BD:F8:19:FF mac address.'
  end

  newproperty(:mcast_allow) do
    desc 'Multicast. Flag to indicate if multicast is enabled.'
  end

  newproperty(:multi_dst_pkt_act) do
    desc 'The multiple destination forwarding method for L2 Multicast, Broadcast, and
    Link Layer traffic types.'
  end

  newproperty(:name_alias) do
    desc ''
  end

  newproperty(:optimize_wan_bandwidth) do
    desc 'OptimizeWanBandwidth flag is enabled between sites.'
  end

  newproperty(:owner_key) do
    desc 'The key for enabling clients to own their data for entity correlation.'
  end

  newproperty(:owner_tag) do
    desc 'A tag for enabling clients to add their own data. For example, to indicate who
    created this object.'
  end

  newproperty(:type) do
    desc 'The specific type of the object or component.'
  end

  newproperty(:unicast_route) do
    desc 'The forwarding method based on predefined forwarding criteria (IP or MAC
    address).'
  end

  newproperty(:unk_mac_ucast_act) do
    desc 'The forwarding method for unknown layer 2 destinations.'
  end

  newproperty(:unk_mcast_act) do
    desc 'The parameter used by the node (i.e. a leaf) for forwarding data for an unknown
    multicast destination.'
  end

  newproperty(:vmac) do
    desc 'Virtual MAC address of the BD/SVI. This is used when the BD is extended to
    multiple sites using l2 Outside.'
  end
end
