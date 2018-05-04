#
# May 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet resource type for vzbrcp
# For documentation for the Managed Object corresponding to this Puppet Type
# please refer to the following URL: https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzBrCP.html
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

Puppet::Type.newtype(:cisco_aci_vzbrcp) do
  # ---------------------------------------------------------------
  # @doc entry to describe the resource and usage
  # ---------------------------------------------------------------
  @doc = 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzBrCP.html'

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
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzBrCP.html#name'
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

  newproperty(:descr) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzBrCP.html#descr'
  end

  newproperty(:name_alias) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzBrCP.html#nameAlias'
  end

  newproperty(:owner_key) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzBrCP.html#ownerKey'
  end

  newproperty(:owner_tag) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzBrCP.html#ownerTag'
  end

  newproperty(:prio) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzBrCP.html#prio'
  end

  newproperty(:scope) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzBrCP.html#scope'
  end

  newproperty(:target_dscp) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzBrCP.html#targetDscp'
  end
end
