#
#Demo Resource data for resource cisco_aci_vzfilter
#
cisco_aci_vzfilter { 'test_filter1':
  ensure     => 'present',
  name       => 'test_filter1', #Instance Identifier
  fvtenant   => 'test_tenant1', #Parent cisco_aci_{{item['p_name']}} Identifier
  descr      => 'My filter test_filter1',
  name_alias => 'test_filter_1',
  owner_key  => 'admin_cisco',
  owner_tag  => 'cisco',
}