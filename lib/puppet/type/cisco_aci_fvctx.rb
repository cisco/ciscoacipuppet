#
# May 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet resource type for fvctx
# For documentation for the Managed Object corresponding to this Puppet Type
# please refer to the following URL
# https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvCtx.html
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

Puppet::Type.newtype(:cisco_aci_fvctx) do
  # ---------------------------------------------------------------
  # @doc entry to describe the resource and usage
  # ---------------------------------------------------------------
  @doc = 'The private layer 3 network context that belongs to a specific tenant or is
  shared.'

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
    desc 'A name for the network context.'
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

  newproperty(:bd_enforced_enable) do
    desc 'BD Enforced Flag.'
  end

  newproperty(:descr) do
    desc 'Specifies a description of the policy definition root.'
  end

  newproperty(:knw_mcast_act) do
    desc ''
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

  newproperty(:pc_enf_dir) do
    desc 'Policy Control Enforcement Direction. It is used for defining policy enforcemnt
    direction for the traffic coming to or from an L3Out. Egress and Ingress
    directions are wrt L3Out. Default will be Ingress. But on the existing L3Outs
    during upgrade it will get set to Egress so that right after upgrade behavior
    doesnt change for them. This also means that there is no special upgrade
    sequence needed for upgrading to the release introducing this feature. After
    upgrade user would have to change the property value to Ingress. Once changed,
    system will reprogram the rules and prefix entry. Rules will get removed from
    the egress leaf and will get insatlled on the ingress leaf. Actrl prefix entry,
    if not already, will get installed on the ingress leaf. This feature will be
    ignored for the following cases 1. Golf Gets applied at Ingress by design. 2.
    Transit Rules get applied at Ingress by design. 4. vzAny 5. Taboo'
  end

  newproperty(:pc_enf_pref) do
    desc ''
  end
end
