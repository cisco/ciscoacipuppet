#
# May 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet resource type for fvaepg
# For documentation for the Managed Object corresponding to this Puppet Type
# please refer to the following URL
# https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvAEPg.html
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

Puppet::Type.newtype(:cisco_aci_fvaepg) do
  # ---------------------------------------------------------------
  # @doc entry to describe the resource and usage
  # ---------------------------------------------------------------
  @doc = 'A set of requirements for the application-level EPG instance. The policy
  regulates connectivity and visibility among the end points within the scope of
  the policy.'

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
    desc 'The name for the endpoint group.'
  end

  # ---------------------------------------------------------------
  # Namevars (Parent Instance Identifiers)
  # ---------------------------------------------------------------

  newparam(:fvtenant, namevar: true) do
    desc 'Parent cisco_aci_fvtenant instance Identifier'
  end

  newparam(:fvap, namevar: true) do
    desc 'Parent cisco_aci_fvap instance Identifier'
  end

  # ---------------------------------------------------------------
  # Properties
  # ---------------------------------------------------------------

  newproperty(:descr) do
    desc 'Specifies the description of a policy component.'
  end

  newproperty(:fwd_ctrl) do
    desc 'Forwarding Control.'
  end

  newproperty(:is_attr_based_e_pg) do
    desc ''
  end

  newproperty(:match_t) do
    desc 'The provider label match criteria.'
  end

  newproperty(:name_alias) do
    desc ''
  end

  newproperty(:pc_enf_pref) do
    desc 'The preferred policy control.'
  end

  newproperty(:pref_gr_memb) do
    desc 'Represents parameter used to determine if EPg is part of a group that does not
    a contract for communication.'
  end

  newproperty(:prio) do
    desc 'The QoS priority class identifier.'
  end
end
