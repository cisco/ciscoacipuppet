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

class {'cisco_aci::classes::cisco_aci_vzbrcp':
  vzbrcp_ensure      => present,
  vzbrcp_name        => 'test_contract1',
  vzbrcp_fvtenant    => 'test_tenant1',
  vzbrcp_descr       => 'My contract test_contract1 on my tenant test_tenant1',
  vzbrcp_name_alias  => 'test_contract_1',
  vzbrcp_owner_key   => 'admin_cisco',
  vzbrcp_owner_tag   => 'cisco',
  vzbrcp_prio        => 'level1',
  vzbrcp_scope       => 'global',
  vzbrcp_target_dscp => 'CS3',
  override_ensure    => $override_ensure,
  override_descr     => $override_descr,
}

class {'cisco_aci::classes::cisco_aci_vzsubj':
  vzsubj_ensure        => present,
  vzsubj_name          => 'test_subject1',
  vzsubj_fvtenant      => 'test_tenant1',
  vzsubj_vzbrcp        => 'test_contract1',
  vzsubj_cons_match_t  => 'AtleastOne',
  vzsubj_descr         => 'My subject test_subject1 for contract test_contract1 in tenant test_tenant1',
  vzsubj_name_alias    => 'test_subject_1',
  vzsubj_prio          => 'level3',
  vzsubj_prov_match_t  => 'AtleastOne',
  vzsubj_rev_flt_ports => 'yes',
  vzsubj_target_dscp   => 'CS3',
  override_ensure      => $override_ensure,
  override_descr       => $override_descr,
}

