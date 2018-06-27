#
# May 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet resource type for vzbrcp
# For documentation for the Managed Object corresponding to this Puppet Type
# please refer to the following URL
# https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzBrCP.html
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
  @doc = 'A contract is a logical container for the subjects which relate to the filters
  that govern the rules for communication between endpoint groups (EPGs). Without
  a contract, the default forwarding policy is to not allow any communication
  between EPGs but all communication within an EPG is allowed.'

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
    desc 'Name of a contract to apply between two or more EPGs under the Application
    Profile.'
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
    desc 'Specifies a description of the policy definition.'
  end

  newproperty(:name_alias) do
    desc 'Specify an alias for the Managed Object.'
  end

  newproperty(:owner_key) do
    desc 'The key for enabling clients to own their data for entity correlation.'
  end

  newproperty(:owner_tag) do
    desc 'A tag for enabling clients to add their own data. For example, to indicate who
    created this object.'
  end

  newproperty(:prio) do
    desc 'Specify priority level.'
  end

  newproperty(:scope) do
    desc 'Represents the scope of this contract. If the scope is set as application-
    profile, the epg can only communicate with epgs in the same application-profile'
  end

  newproperty(:target_dscp) do
    desc 'The target differentiated services code point (DSCP) of the path attached to
    the layer 3 outside profile.'
  end
end
