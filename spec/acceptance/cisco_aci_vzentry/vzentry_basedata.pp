class {'cisco_aci::classes::cisco_aci_fvtenant':
  fvtenant_ensure     => present,
  fvtenant_name       => 'test_tenant1',
  fvtenant_descr      => 'My test tenant',
  fvtenant_name_alias => 'test_tenant_1',
  fvtenant_owner_key  => 'admin_cisco',
  fvtenant_owner_tag  => 'cisco',
  override_ensure     => $override_ensure,
  override_descr      => $override_descr,
}

class {'cisco_aci::classes::cisco_aci_vzfilter':
  vzfilter_ensure     => present,
  vzfilter_name       => 'test_filter1',
  vzfilter_fvtenant   => 'test_tenant1',
  vzfilter_descr      => 'My filter test_filter1',
  vzfilter_name_alias => 'test_filter_1',
  vzfilter_owner_key  => 'admin_cisco',
  vzfilter_owner_tag  => 'cisco',
  override_ensure     => $override_ensure,
  override_descr      => $override_descr,
}

class {'cisco_aci::classes::cisco_aci_vzentry':
  vzentry_ensure        => present,
  vzentry_name          => 'test_filter_entry1',
  vzentry_fvtenant      => 'test_tenant1',
  vzentry_vzfilter      => 'test_filter1',
  vzentry_apply_to_frag => 'no',
  vzentry_arp_opc       => 'reply',
  vzentry_d_from_port   => 'unspecified',
  vzentry_d_to_port     => 'unspecified',
  vzentry_descr         => 'My filter entry test_filter_entry1 for filter test_filter1 in tenant test_tenant1',
  vzentry_ether_t       => 'arp',
  vzentry_icmpv4_t      => 'unspecified',
  vzentry_icmpv6_t      => 'unspecified',
  vzentry_match_dscp    => 'unspecified',
  vzentry_name_alias    => 'test_filter_entry_1',
  vzentry_prot          => 'unspecified',
  vzentry_s_from_port   => 'unspecified',
  vzentry_s_to_port     => 'unspecified',
  vzentry_stateful      => 'no',
  vzentry_tcp_rules     => '',
  override_ensure       => $override_ensure,
  override_descr        => $override_descr,
}

