#
#Demo Resource data for resource cisco_aci_fvctx
#
cisco_aci_fvctx { 'test_vrf1':
  ensure             => 'present',
  name               => 'test_vrf1', #Instance Identifier
  fvtenant           => 'test_tenant1', #Parent cisco_aci_{{item['p_name']}} Identifier
  bd_enforced_enable => 'no',
  descr              => 'My VRF context in tenant test_tenant1',
  knw_mcast_act      => 'permit',
  name_alias         => 'test_vrf_1',
  owner_key          => 'admin_cisco',
  owner_tag          => 'cisco',
  pc_enf_dir         => 'egress',
  pc_enf_pref        => 'unenforced',
}