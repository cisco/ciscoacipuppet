#
# April 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet resource type for vzentry
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

Puppet::Type.newtype(:cisco_aci_vzentry) do
  # ---------------------------------------------------------------
  # @doc entry to describe the resource and usage
  # ---------------------------------------------------------------
  @doc = "https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzEntry.html"

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
    desc "https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzEntry.html#name"
  end


  # ---------------------------------------------------------------
  # Namevars (Parent Instance Identifiers)
  # ---------------------------------------------------------------

  newparam(:fvtenant, namevar: true) do
    desc "Parent cisco_aci_fvtenant instance Identifier"
  end

  newparam(:vzfilter, namevar: true) do
    desc "Parent cisco_aci_vzfilter instance Identifier"
  end


  # ---------------------------------------------------------------
  # Properties
  # ---------------------------------------------------------------

  newproperty(:apply_to_frag) do
    desc "https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzEntry.html#applyToFrag"
  end

  newproperty(:arp_opc) do
    desc "https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzEntry.html#arpOpc"
  end

  newproperty(:d_from_port) do
    desc "https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzEntry.html#dFromPort"
  end

  newproperty(:d_to_port) do
    desc "https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzEntry.html#dToPort"
  end

  newproperty(:descr) do
    desc "https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzEntry.html#descr"
  end

  newproperty(:ether_t) do
    desc "https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzEntry.html#etherT"
  end

  newproperty(:icmpv4_t) do
    desc "https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzEntry.html#icmpv4T"
  end

  newproperty(:icmpv6_t) do
    desc "https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzEntry.html#icmpv6T"
  end

  newproperty(:match_dscp) do
    desc "https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzEntry.html#matchDscp"
  end

  newproperty(:name_alias) do
    desc "https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzEntry.html#nameAlias"
  end

  newproperty(:prot) do
    desc "https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzEntry.html#prot"
  end

  newproperty(:s_from_port) do
    desc "https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzEntry.html#sFromPort"
  end

  newproperty(:s_to_port) do
    desc "https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzEntry.html#sToPort"
  end

  newproperty(:stateful) do
    desc "https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzEntry.html#stateful"
  end

  newproperty(:tcp_rules) do
    desc "https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzEntry.html#tcpRules"
  end


end