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

