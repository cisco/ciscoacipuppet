#
#Demo Resource data for resource cisco_aci_vzsubj
#
cisco_aci_vzsubj { 'test_subject1':
  ensure        => 'present',
  name          => 'test_subject1', #Instance Identifier
  fvtenant      => 'test_tenant1', #Parent cisco_aci_fvtenant Identifier
  vzbrcp        => 'test_contract1', #Parent cisco_aci_vzbrcp Identifier
  cons_match_t  => 'AtleastOne',
  descr         => 'My subject test_subject1 for contract test_contract1 in tenant test_tenant1',
  name_alias    => 'test_subject_1',
  prio          => 'level3',
  prov_match_t  => 'AtleastOne',
  rev_flt_ports => 'yes',
  target_dscp   => 'CS3',
}