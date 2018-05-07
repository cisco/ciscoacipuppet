#
#Demo Resource data for resource cisco_aci_vzbrcp
#
cisco_aci_vzbrcp { 'test_contract1':
  ensure      => 'present',
  name        => 'test_contract1', #Instance Identifier
  fvtenant    => 'test_tenant1', #Parent cisco_aci_{{item['p_name']}} Identifier
  descr       => 'My contract test_contract1 on my tenant test_tenant1',
  name_alias  => 'test_contract_1',
  owner_key   => 'admin_cisco',
  owner_tag   => 'cisco',
  prio        => 'level1',
  scope       => 'global',
  target_dscp => 'CS3',
}