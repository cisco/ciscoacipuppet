#
# May 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet resource type for fvap
# For documentation for the Managed Object corresponding to this Puppet Type
# please refer to the following URL
# https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvAp.html
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

Puppet::Type.newtype(:cisco_aci_fvap) do
  # ---------------------------------------------------------------
  # @doc entry to describe the resource and usage
  # ---------------------------------------------------------------
  @doc = 'The application profile is a set of requirements that an application instance
  has on the virtualizable fabric. The policy regulates connectivity and
  visibility among endpoints within the scope of the policy.'

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
    desc 'The name of the application profile.'
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
    desc 'Specifies a description of the policy definition root.'
  end

  newproperty(:name_alias) do
    desc ''
  end

  newproperty(:owner_key) do
    desc 'The key for enabling clients to own their data for entity correlation.'
  end

  newproperty(:owner_tag) do
    desc 'A tag for enabling clients to add their own data. For example, to indicate who
    created this object.'
  end

  newproperty(:prio) do
    desc 'The priority class identifier.'
  end
end
