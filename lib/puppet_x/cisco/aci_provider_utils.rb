module PuppetX
  module Cisco
    # PuppetX::Cisco::ACIUtils - Class with ACI Utility methods
    class ACIUtils
      #====================Common Terms & Notes=========================
      # MO     = ACI Managed Object
      # Class  = Each MO represented by a Class Name (ex: fvTenant)
      # Prefix = Each MO has a unique Prefix (ex: 'tn' for fvTenant)
      # RN     = Relative Name of a MO in prefix-instance form (ex: tn-tenant1)
      # Parent = Each MO is unique location in the tree
      # DN     = Distinguished Name that uniquely identifies a MO instance in
      #         ACI(ex: uni/tn-tenant1/BF-mybd1)
      #====================Provider Utilities===========================

      # Extract a {MO prefix=>instance value} hash from ACI DN for a MO
      # Note: Each provider instance is associated with a single MO
      #
      # @param dn [String] Example: uni/tn-cisco_aci_demo/BD-bd_ansible_1/
      #                   subnet-[9.9.9.1/24]
      # @return [Hash] MO prefix => instance value. Example:
      #               {tn=>cisco_aci_demo, BD=>bd_ansible_1}.
      #               Returns empty hash if DN is nil
      #
      def self.xtract_prfx2val_frm_dn(dn)
        p2v = {}
        return p2v if dn.nil?
        dn.split('/').each do |p|
          p_v = p.split('-')
          p2v[p_v[0]] = p_v[1] if p_v.length == 2
        end
        p2v
      end

      # Extract {:puppet_attr=>attrvalue } hash from ACI JSON response for a MO
      # Note: Each provider instance is associated with a single MO
      #
      # @param mo_hash [Hash] ACI JSON response. Example: {"fvTenant"=>
      #                      {"attributes"=>{"childAction"=>"",
      #                       "descr"=>"", "dn"=>"uni/tn-tenant"}}}
      # @param p_class [Class] Puppet Provider class
      # @return [Hash] Puppet Attribute to attribute value Example:
      #               {:dn=>"uni/tn-tenant1",:descr=>"This is tenant1",
      #                :name=>"tenant1"}
      def self.xtract_attr_hash_frm_json(mo_hash, p_class)
        pt_attrs_hash = {}
        if mo_hash[p_class.mo_class_name] &&
           mo_hash[p_class.mo_class_name]['attributes']
          attrs = mo_hash[p_class.mo_class_name]['attributes']
          p_class.pt_attr_2_mo_attr.each do |pt_attr, mo_attr|
            pt_attrs_hash[pt_attr] = attrs[mo_attr] if attrs[mo_attr]
          end
        end
        # Parent MOs are namevars in Puppet. Exract their value from DN
        dn_p2v_hash = xtract_prfx2val_frm_dn(pt_attrs_hash[:dn])
        p_class.parent_namevars.each do |nv, p|
          pt_attrs_hash[nv] = dn_p2v_hash[p] if dn_p2v_hash[p]
        end
        pt_attrs_hash
      end

      # Generate the RN for MO -- Try to eliminate this method
      # Note: Each provider instance is associated with a single MO
      #
      # @param keys2value_map [Hash] Puppet attribute to value map
      # @param mo_prefix [String] Prefix associated with the type
      # @param my_namevars [List] Namevars associated with the type
      # @return [String] RN associated with the MO
      #
      def self.gen_rn(keys2value_map,
                      mo_prefix,
                      my_namevars)

        rn = mo_prefix + '-'
        if my_namevars.length == 1 &&
           my_namevars[0] == 'name'
          rn += keys2value_map[name]
        else
          rn += '['
          my_namevars.each { |k| rn += keys2value_map[k] }
          rn += ']'
        end
        rn
      end

      # Generate a DN for the MO
      # Note: Each provider instance is associated with a single MO
      #
      # @param p_inst [Object] Provider instance
      # @return dn [String] DN associated with the MO
      #
      def self.gen_dn(p_inst)
        dn = 'uni/'
        p_inst.class.parent_namevars.each do |key, prefix|
          dn += prefix + '-' + p_inst.property_flush[key] + '/'
        end
        dn += gen_rn(p_inst.property_flush, p_inst.class.mo_dn_prefix,
                     p_inst.class.my_namevars)
      end

      # Generate URL for query MO instance given DN
      # Note: Each provider instance is associated with a single MO
      #
      # @param dn [String] DN for MO corresponding to the provider instance
      # @return [String] URL for the instance
      #
      def self.gen_url4instance(dn)
        '/api/mo/' + dn + '.json' + '?rsp-subtree=modified'
      end

      # Generate APIC GUI URL that will be used to print a helpful URI that can
      # be used to easily located a provisioned MO. This URI does not have any
      # functional implication and used purely to generate informational message
      # for administrator
      #
      # Note: Current implemention generates the URI only for managed objects
      # that have a Tenant as a parent. This functionality can be extended in
      # future for generating APIC GUI for MOs that donot have a tenant as one
      # of the parents
      # @param tenant_name Name of the tenant
      # @param dn [String] DN for MO corresponding to the provider instance
      # @return [String] APIC URI for the instance being provisioned
      #
      def self.gen_url4apicgui(tenant_name, dn)
        Puppet::Util::NetworkDevice.current.apicuri + '/#bTenants:' + \
          tenant_name + '|' + dn unless tenant_name.nil? || dn.nil?
      end

      # Convert a Puppet attributes hash to MO attributes hash
      # Note: Each provider instance is associated with a single MO
      #
      # @param p_inst [ Object] Provider instance
      # @param puppet_attrs [Hash] Puppet attribute hash
      # @return [Hash] Hash containing MO attributes hash
      # @raise [IndexError] When it fails to map a Puppet attribute to MO attribute
      #
      def self.conv_puppet_attrs_2_mo_attrs(p_inst, puppet_attrs)
        mo_attrs = {}
        puppet_attrs.each do |key, value|
          mo_key = p_inst.class.pt_attr_2_mo_attr[key]
          fail IndexError, "Failed to map Puppet attribute to MO attribute. \
            Type #{p_inst.mo_class_name} Attribute #{key}" if mo_key.nil?
          mo_attrs[mo_key] = value
        end
        mo_attrs
      end

      # Generate JSON payload for create and modify
      # Note: Each provider instance is associated with a single MO
      #
      # @param p_inst [ Object] Provider instance
      # @return [JSON] payload for APIC REST request for POST
      #
      def self.gen_json4createmodify(p_inst)
        attributes = p_inst.property_flush.clone
        attributes.delete_if do |key, _value|
          (key == :ensure || key == :provider ||
            p_inst.class.parent_namevars.include?(key))
        end
        mo_attributes = conv_puppet_attrs_2_mo_attrs(p_inst, attributes)
        payload = { p_inst.class.mo_class_name => { 'attributes' => mo_attributes } }
        payload.to_json
      end

      # Debug routine . Prints the difference between two hash
      # Note: Each provider instance is associated with a single MO
      #
      # @param updated_attrs [Hash] Puppet attributes after operation
      # @param orig_attrs [Hash] Puppet attributes before operation
      #
      def self.debug_what_changed(updated_attrs,
                                  orig_attrs)
        updated_attrs.each do |key, value|
          if orig_attrs[key] != value
            puts "Changed '#{key}' from= '#{orig_attrs[key]}' to= '#{value}' "
          end
        end
      end

      # Set the property_flush has with necessary key values from source hash
      # Note: Each provider instance is associated with a single MO
      #
      # @param p_inst [Object] Provider instance
      #
      def self.property_flush_keys_from_property_hash(p_inst)
        p_inst.class.allnamevars.each do |attr|
          p_inst.property_flush[attr] = p_inst.property_hash[attr]
        end
      end

      # Update property_flush with attributes from a source hash
      #
      # @param p_inst [Object] Provider instance
      #
      def self.property_flush_attrs_frm_resource(p_inst)
        allattrs = p_inst.class.allproperties + p_inst.class.allnamevars
        p_inst.resource.each do |attr, value|
          p_inst.property_flush[attr] = value if allattrs.include?(attr)
        end
      end

      #=======Common Implementation of Provider Methods or Helpers ===========

      # Query ACI to discover instances of this resource
      # Note: Each provider instance is associated with a single MO
      #
      # @param provider_class [Class] Provider class
      #
      def self.instances(provider_class)
        instance_array = []
        mos = Puppet::Util::NetworkDevice.current.get(
          provider_class.mo_class_query_url)
        mos['imdata'].each do |mo|
          pt_attr_hash = xtract_attr_hash_frm_json(mo, provider_class)
          pt_attr_hash.update(ensure: :present)
          instance_array << provider_class.new(pt_attr_hash)
        end
        instance_array
      end

      # Initilize the property_flush for new provider instances
      # Note: Each provider instance is associated with a single MO
      #
      # @param provider_instance [Object] Provider instance
      #
      def self.puppet_hash_init(provider_inst)
        property_flush_keys_from_property_hash(provider_inst)
        provider_inst.property_flush[:ensure] = :present
      end

      # Common create: initialize the property_flush from resource
      # Note: Each provider instance is associated with a single MO
      #
      # @param provider_instance [Object] Provider instance
      #
      def self.create(provider_inst)
        property_flush_attrs_frm_resource(provider_inst)
      end

      # Common flush to push changes from property_flush to ACI
      # Note: Each provider instance is associated with a single MO
      #
      # @param provider_instance [Object] Provider instance
      #
      def self.flush(provider_inst)
        provider_inst.property_flush[:dn] = gen_dn(provider_inst)
        begin
          case provider_inst.property_flush[:ensure]
          when :present
            resp = Puppet::Util::NetworkDevice.current.post(
              gen_url4instance(provider_inst.property_flush[:dn]),
              gen_json4createmodify(provider_inst))
            resp['imdata'].each do |mo|
              resp_attrs_hash = xtract_attr_hash_frm_json(mo,
                                                          provider_inst.class)
              debug_what_changed(resp_attrs_hash,
                                 provider_inst.property_hash)
            end
          when :absent
            Puppet::Util::NetworkDevice.current.delete(
              gen_url4instance(provider_inst.property_flush[:dn]))
          end
          # Return the corresponding APIC GUI URI that will be used for informational
          # message
          gen_url4apicgui(provider_inst.property_flush[:fvtenant],
                          provider_inst.property_flush[:dn])
        rescue => e
          puts e.message
          puts e.backtrace.inspect
        end
      end

      #=============ACI Factor related utility methods =======================

      # Extract Fabric Members from  DHCP client query request.
      # @param [JSON] Response from the DHCP Client query
      # @return [Hash] {NodeID => Attribute Map} for leaf and spine members
      #               Please note that there is a possibility that this method
      #               can return a nil
      #
      def self.xtract_fabric_member_frm_dhcp_query(one_dhcp_clnt_json)
        if one_dhcp_clnt_json &&
           one_dhcp_clnt_json['dhcpClient'] &&
           one_dhcp_clnt_json['dhcpClient']['attributes'] &&
           one_dhcp_clnt_json['dhcpClient']['attributes']['id'] &&
           (one_dhcp_clnt_json['dhcpClient']['attributes']['nodeRole'] == 'leaf' ||
            one_dhcp_clnt_json['dhcpClient']['attributes']['nodeRole'] == 'spine')
          # create an NodeID => Node Details Hash
          attrs = one_dhcp_clnt_json['dhcpClient']['attributes']
          { attrs['id'] => attrs }
        end
      end

      # Generate Facts for ACI Fabric from the APIC
      #
      # @return [Hash] Facts for the ACI Fabric
      #
      def self.facts
        fab_mem_attrs = []
        dhcp_clnt_query_url = '/api/class/dhcpClient.json'
        mem_lst = Puppet::Util::NetworkDevice.current.get(dhcp_clnt_query_url)
        mem_lst['imdata'].each do |mem|
          mem_attrs = xtract_fabric_member_frm_dhcp_query(mem)
          fab_mem_attrs << mem_attrs if mem_attrs
        end
        # Construct the custom ACI Fact Hash
        { 'aci_fabric_members' => fab_mem_attrs }
      end
    end
  end
end
