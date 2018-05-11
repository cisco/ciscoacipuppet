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