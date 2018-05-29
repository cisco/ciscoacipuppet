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

class {'cisco_aci::classes::cisco_aci_fvctx':
  fvctx_ensure             => present,
  fvctx_name               => 'test_vrf1',
  fvctx_fvtenant           => 'test_tenant1',
  fvctx_bd_enforced_enable => 'no',
  fvctx_descr              => 'My VRF context in tenant test_tenant1',
  fvctx_knw_mcast_act      => 'permit',
  fvctx_name_alias         => 'test_vrf_1',
  fvctx_owner_key          => 'admin_cisco',
  fvctx_owner_tag          => 'cisco',
  fvctx_pc_enf_dir         => 'egress',
  fvctx_pc_enf_pref        => 'unenforced',
  override_ensure          => $override_ensure,
  override_descr           => $override_descr,
}

