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

class {'cisco_aci::classes::cisco_aci_fvap':
  fvap_ensure     => present,
  fvap_name       => 'test_app1',
  fvap_fvtenant   => 'test_tenant1',
  fvap_descr      => 'My test application profile tenant test_tenant1',
  fvap_name_alias => 'test_app_1',
  fvap_owner_key  => 'admin_cisco',
  fvap_owner_tag  => 'cisco',
  fvap_prio       => 'level3',
  override_ensure => $override_ensure,
  override_descr  => $override_descr,
}

class {'cisco_aci::classes::cisco_aci_fvaepg':
  fvaepg_ensure             => present,
  fvaepg_name               => 'test_epg1',
  fvaepg_fvtenant           => 'test_tenant1',
  fvaepg_fvap               => 'test_app1',
  fvaepg_descr              => 'My EPF test_epg1 in the application profile test_app1 in tenant test_tenant1',
  fvaepg_fwd_ctrl           => 'proxy-arp',
  fvaepg_is_attr_based_e_pg => 'no',
  fvaepg_match_t            => 'AtmostOne',
  fvaepg_name_alias         => 'test_epg_1',
  fvaepg_pc_enf_pref        => 'enforced',
  fvaepg_pref_gr_memb       => 'include',
  fvaepg_prio               => 'level2',
  override_ensure           => $override_ensure,
  override_descr            => $override_descr,
}

