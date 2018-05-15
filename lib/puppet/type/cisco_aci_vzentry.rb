#
# May 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet resource type for vzentry
# For documentation for the Managed Object corresponding to this Puppet Type
# please refer to the following URL
# https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzEntry.html
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

Puppet::Type.newtype(:cisco_aci_vzentry) do
  # ---------------------------------------------------------------
  # @doc entry to describe the resource and usage
  # ---------------------------------------------------------------
  @doc = 'A filter entry is a combination of network traffic classification properties.'

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
    desc 'The name of a filter entry. This name can be up to 64 alphanumeric characters.
    Note that you cannot change this name after the object has been saved.'
  end

  # ---------------------------------------------------------------
  # Namevars (Parent Instance Identifiers)
  # ---------------------------------------------------------------

  newparam(:fvtenant, namevar: true) do
    desc 'Parent cisco_aci_fvtenant instance Identifier'
  end

  newparam(:vzfilter, namevar: true) do
    desc 'Parent cisco_aci_vzfilter instance Identifier'
  end

  # ---------------------------------------------------------------
  # Properties
  # ---------------------------------------------------------------

  newproperty(:apply_to_frag) do
    desc ''
  end

  newproperty(:arp_opc) do
    desc 'ARP opcodes.'
  end

  newproperty(:d_from_port) do
    desc 'Destination From Port.'
  end

  newproperty(:d_to_port) do
    desc 'Destination To Port.'
  end

  newproperty(:descr) do
    desc 'Specifies the description of a policy component.'
  end

  newproperty(:ether_t) do
    desc 'Ether type.'
  end

  newproperty(:icmpv4_t) do
    desc 'The ICMP v4 Type.'
  end

  newproperty(:icmpv6_t) do
    desc 'The ICMP v6 Typ'
  end

  newproperty(:match_dscp) do
    desc 'Specify DSCP constants.'
  end

  newproperty(:name_alias) do
    desc 'Specify an alias for the Managed Object.'
  end

  newproperty(:prot) do
    desc 'L3 Ip Protocol.'
  end

  newproperty(:s_from_port) do
    desc 'Source From Port.'
  end

  newproperty(:s_to_port) do
    desc 'Source To Port.'
  end

  newproperty(:stateful) do
    desc 'Specify if stateful.'
  end

  newproperty(:tcp_rules) do
    desc 'TCP Session Rules.'
  end
end
