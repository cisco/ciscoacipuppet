#
#Demo Resource data for resource cisco_aci_fvaepg
#
cisco_aci_fvaepg { 'test_epg1':
  ensure             => 'present',
  name               => 'test_epg1', #Instance Identifier
  fvtenant           => 'test_tenant1', #Parent cisco_aci_fvtenant Identifier
  fvap               => 'test_app1', #Parent cisco_aci_fvap Identifier
  descr              => 'My EPF test_epg1 in the application profile test_app1 in tenant test_tenant1',
  fwd_ctrl           => 'proxy-arp',
  is_attr_based_e_pg => 'no',
  match_t            => 'AtmostOne',
  name_alias         => 'test_epg_1',
  pc_enf_pref        => 'enforced',
  pref_gr_memb       => 'include',
  prio               => 'level2',
}