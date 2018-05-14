#
# May 2018
#
# Copyright (c) 2017-2018  Cisco and/or its affiliates.
#
# Puppet resource provider for fvctx
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

require 'json'
begin
  require 'puppet_x/cisco/aci_provider_utils'
rescue LoadError # seen on master, not on agent
  # See longstanding Puppet issues #4248, #7316, #14073, #14149, etc.
  require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..',
                                     'puppet_x', 'cisco', 'aci_provider_utils.rb'))
end

#====================Common Terms & Notes=========================
# MO     = ACI Managed Object
# Class  = Each MO represented by a Class Name (ex: fvTenant)
# Prefix = Each MO has a unique Prefix (ex: 'tn' for fvTenant)
# RN     = Relative Name of a MO in prefix-instance form (ex: tn-tenant1)
# Parent = Parent MO for the ACI Managed Object
# DN     = Distinguished Name that uniquely identifies a MO instance in ACI
#         (ex: uni/tn-tenant1/BF-mybd1)
#====================Provider Utilities===========================

Puppet::Type.type(:cisco_aci_fvctx).provide(:cisco_aci) do
  desc 'The Cisco provider for fvctx.'

  mk_resource_methods
  attr_reader :property_hash, :property_flush

  # ---------------------------------------------------------------
  # Class Constants
  # ---------------------------------------------------------------

  # Get the MO class name associated with the Puppet Type
  def self.mo_class_name
    'fvCtx'
  end

  # Get the MO prefix associated with the Puppet Type
  def self.mo_dn_prefix
    'ctx'
  end

  # Get the URL to query the MO class associated with the Puppet Type
  def self.mo_class_query_url
    '/api/class/fvCtx.json?query-target=self'
  end

  # Get a list of parent MOs (and their prefix) for this Puppet Type
  def self.parent_namevars
    {
      fvtenant: 'tn',
    }
  end

  # Get the namevars for this Puppet Type
  def self.my_namevars
    [
      :name,
    ]
  end

  # Get all the namevars for this Puppet Type (includes parents)
  def self.allnamevars
    [
      :name,
      :fvtenant,
    ]
  end

  # Get all the properties for this Puppet Type
  def self.allproperties
    [
      :bd_enforced_enable,
      :descr,
      :knw_mcast_act,
      :name_alias,
      :owner_key,
      :owner_tag,
      :pc_enf_dir,
      :pc_enf_pref,
    ]
  end

  # Get the hash that maps Puppet Type attributes to MO attributes
  def self.pt_attr_2_mo_attr
    {
      bd_enforced_enable: 'bdEnforcedEnable',
      descr:              'descr',
      dn:                 'dn',
      knw_mcast_act:      'knwMcastAct',
      name:               'name',
      name_alias:         'nameAlias',
      owner_key:          'ownerKey',
      owner_tag:          'ownerTag',
      pc_enf_dir:         'pcEnfDir',
      pc_enf_pref:        'pcEnfPref',
    }
  end

  # ---------------------------------------------------------------
  # Puppet Provider Class Methods
  # ---------------------------------------------------------------

  def self.instances
    # Discover instances by querying ACI
    PuppetX::Cisco::ACIUtils.instances(self)
  end # self.instances

  def self.prefetch(resources)
    fvctx_instances = instances
    resources.keys.each do |name|
      provider = fvctx_instances.find do |inst|
        inst.name.to_s == resources[name][:name].to_s &&
        inst.fvtenant.to_s == resources[name][:fvtenant].to_s &&
        inst
      end
      resources[name].provider = provider unless provider.nil?
    end
  end

  # ---------------------------------------------------------------
  # Puppet Provider Instance Methods
  # ---------------------------------------------------------------

  def resource
    @resource.to_hash
  end

  def initialize(value={})
    super(value)
    @property_flush = {}
    # Initialize property_flush with keys from property_hash
    PuppetX::Cisco::ACIUtils.puppet_hash_init(self)
  end

  def exists?
    (@property_hash[:ensure] == :present)
  end

  def create
    # Update property_flush with desired value from resource
    PuppetX::Cisco::ACIUtils.create(self)
    @property_flush[:ensure] = :present
  end

  def destroy
    @property_flush[:ensure] = :absent
  end

  def flush
    # Flush the attributes in property_flush to ACI
    apic_gui_url = PuppetX::Cisco::ACIUtils.flush(self)
    notice('APIC GUI URI for provisioned resource ' + apic_gui_url) \
      unless apic_gui_url.nil? || apic_gui_url.empty?
  end

  # Generate setters that cache proposed changes in the property_flush
  def self.mk_resource_methods_custom_setters
    all_puppet_attrs = allnamevars + allproperties
    all_puppet_attrs.each do |attr|
      define_method(attr.to_s + '=') do |val|
        @property_flush[attr] = val
      end
    end
  end

  mk_resource_methods_custom_setters
end
