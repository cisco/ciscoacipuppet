#
# May 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet resource type for fvctx
# For documentation for the Managed Object corresponding to this Puppet Type
# please refer to the following URL: https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvCtx.html
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
  @doc = 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvCtx.html'

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
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvCtx.html#name'
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
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvCtx.html#bdEnforcedEnable'
  end

  newproperty(:descr) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvCtx.html#descr'
  end

  newproperty(:knw_mcast_act) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvCtx.html#knwMcastAct'
  end

  newproperty(:name_alias) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvCtx.html#nameAlias'
  end

  newproperty(:owner_key) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvCtx.html#ownerKey'
  end

  newproperty(:owner_tag) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvCtx.html#ownerTag'
  end

  newproperty(:pc_enf_dir) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvCtx.html#pcEnfDir'
  end

  newproperty(:pc_enf_pref) do
    desc 'https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvCtx.html#pcEnfPref'
  end
end
