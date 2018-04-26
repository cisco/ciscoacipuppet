#
#Demo Resource data for resource cisco_aci_vzentry
#
cisco_aci_vzentry { "test_filter_entry1":
  ensure => "present",
  name => "test_filter_entry1", #Instance Identifier
  fvtenant => "test_tenant1", #Parent cisco_aci_fvtenant Identifier
  vzfilter => "test_filter1", #Parent cisco_aci_vzfilter Identifier
  apply_to_frag => "no",
  arp_opc => "reply",
  d_from_port => "unspecified",
  d_to_port => "unspecified",
  descr => "My filter entry test_filter_entry1 for filter test_filter1 in tenant test_tenant1",
  ether_t => "arp",
  icmpv4_t => "unspecified",
  icmpv6_t => "unspecified",
  match_dscp => "unspecified",
  name_alias => "test_filter_entry_1",
  prot => "unspecified",
  s_from_port => "unspecified",
  s_to_port => "unspecified",
  stateful => "no",
  tcp_rules => "",
}