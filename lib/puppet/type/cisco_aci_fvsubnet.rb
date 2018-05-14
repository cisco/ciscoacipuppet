#
# May 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet resource type for fvsubnet
# For documentation for the Managed Object corresponding to this Puppet Type
# please refer to the following URL
# https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvSubnet.html
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

Puppet::Type.newtype(:cisco_aci_fvsubnet) do
  # ---------------------------------------------------------------
  # @doc entry to describe the resource and usage
  # ---------------------------------------------------------------
  @doc = 'A subnet defines the IP address range that can be used within the bridge
  domain. While a context defines a unique layer 3 space, that space can consist
  of multiple subnets. These subnets are defined per bridge domain. A bridge
  domain can contain multiple subnets, but a subnet is contained within a single
  bridge domain.'

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

  newparam(:ip, namevar: true) do
    desc 'The IP address and mask of the default gateway.'
  end

  # ---------------------------------------------------------------
  # Namevars (Parent Instance Identifiers)
  # ---------------------------------------------------------------

  newparam(:fvtenant, namevar: true) do
    desc 'Parent cisco_aci_fvtenant instance Identifier'
  end

  newparam(:fvbd, namevar: true) do
    desc 'Parent cisco_aci_fvbd instance Identifier'
  end

  # ---------------------------------------------------------------
  # Properties
  # ---------------------------------------------------------------

  newproperty(:ctrl) do
    desc 'The subnet control state. The control can be specific protocols applied to the
    subnet such as IGMP Snooping.'
  end

  newproperty(:descr) do
    desc 'Specifies the description of a policy component.'
  end

  newproperty(:name) do
    desc ''
  end

  newproperty(:name_alias) do
    desc ''
  end

  newproperty(:preferred) do
    desc 'Indicates if the subnet is preferred (primary) over the available alternatives.
    Only one preferred subnet is allowed.'
  end

  newproperty(:scope) do
    desc 'The network visibility of the subnet.'
  end

  newproperty(:virtual) do
    desc 'Treated as virtual IP address. Used in case of BD extended to multiple sites.'
  end
end
