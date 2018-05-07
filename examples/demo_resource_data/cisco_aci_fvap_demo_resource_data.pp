#
#Demo Resource data for resource cisco_aci_fvap
#
cisco_aci_fvap { 'test_app1':
  ensure     => 'present',
  name       => 'test_app1', #Instance Identifier
  fvtenant   => 'test_tenant1', #Parent cisco_aci_{{item['p_name']}} Identifier
  descr      => 'My test application profile tenant test_tenant1',
  name_alias => 'test_app_1',
  owner_key  => 'admin_cisco',
  owner_tag  => 'cisco',
  prio       => 'level3',
}