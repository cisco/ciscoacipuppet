#
#Demo Resource data for resource cisco_aci_fvtenant
#
cisco_aci_fvtenant { "test_tenant1":
  ensure => "present",
  name => "test_tenant1", #Instance Identifier
  descr => "My test tenant",
  name_alias => "test_tenant_1",
  owner_key => "admin_cisco",
  owner_tag => "cisco",
}