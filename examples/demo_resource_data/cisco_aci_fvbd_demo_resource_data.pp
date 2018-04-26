#
#Demo Resource data for resource cisco_aci_fvbd
#
cisco_aci_fvbd { "test_bd1":
  ensure => "present",
  name => "test_bd1", #Instance Identifier
  fvtenant => "test_tenant1", #Parent cisco_aci_fvtenant Identifier
  arp_flood => "yes",
  descr => "My bridge domain in tenant test_tenant1",
  ep_clear => "no",
  ep_move_detect_mode => "",
  intersite_bum_traffic_allow => "no",
  intersite_l2_stretch => "no",
  ip_learning => "yes",
  limit_ip_learn_to_subnets => "yes",
  ll_addr => "::",
  mac => "00:22:BD:F8:19:FF",
  mcast_allow => "yes",
  multi_dst_pkt_act => "encap-flood",
  name_alias => "test_bd_1",
  optimize_wan_bandwidth => "no",
  owner_key => "admin_cisco",
  owner_tag => "cisco",
  type => "regular",
  unicast_route => "yes",
  unk_mac_ucast_act => "proxy",
  unk_mcast_act => "opt-flood",
  vmac => "not-applicable",
}