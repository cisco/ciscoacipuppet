#
# June 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet resource type for vzsubj
# For documentation for the Managed Object corresponding to this Puppet Type
# please refer to the following URL
# https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzSubj.html
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

Puppet::Type.newtype(:cisco_aci_vzsubj) do
  # ---------------------------------------------------------------
  # @doc entry to describe the resource and usage
  # ---------------------------------------------------------------
  @doc = 'A subject is a sub-application running behind an endpoint group (for example,
  an Exchange server). A subject is parented by the contract, which can
  encapsulate multiple subjects. An endpoint group associated to a contract is
  providing one or more subjects or is communicating with the subject as a peer
  entity. An endpoint group always associates with a subject and defines rules
  under the association for consuming/providing/peer-to-peer communications to
  that subject.'

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
    desc 'The name of a sub application running behind an endpoint group, such as an
    Exchange server. This name can be up to 64 alphanumeric characters. Note that
    you cannot change this name after the object has been saved.'
  end

  # ---------------------------------------------------------------
  # Namevars (Parent Instance Identifiers)
  # ---------------------------------------------------------------

  newparam(:fvtenant, namevar: true) do
    desc 'Parent cisco_aci_fvtenant instance Identifier'
  end

  newparam(:vzbrcp, namevar: true) do
    desc 'Parent cisco_aci_vzbrcp instance Identifier'
  end

  # ---------------------------------------------------------------
  # Properties
  # ---------------------------------------------------------------

  newproperty(:cons_match_t) do
    desc 'The subject match criteria across consumers.'
  end

  newproperty(:descr) do
    desc 'Specifies the description of a policy component.'
  end

  newproperty(:name_alias) do
    desc 'Specify an alias for the Managed Object.'
  end

  newproperty(:prio) do
    desc 'The priority level of a sub application running behind an endpoint group, such
    as an Exchange server.'
  end

  newproperty(:prov_match_t) do
    desc 'The subject match criteria across consumers.'
  end

  newproperty(:rev_flt_ports) do
    desc 'Enables the filter to apply on both ingress and egress traffic.'
  end

  newproperty(:target_dscp) do
    desc 'The target differentiated services code point (DSCP) of the path attached to
    the layer 3 outside profile.'
  end
end
