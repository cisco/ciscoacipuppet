#
#Demo Resource data for resource cisco_aci_fvsubnet
#
cisco_aci_fvsubnet { '20.20.20.1/24':
  ensure     => 'present',
  ip         => '20.20.20.1/24', #Instance Identifier
  fvtenant   => 'test_tenant1', #Parent cisco_aci_fvtenant Identifier
  fvbd       => 'test_bd1', #Parent cisco_aci_fvbd Identifier
  ctrl       => 'nd,no-default-gateway,querier',
  descr      => 'My subnet subnet1 in bridge domain test_bd1 in tenant test_tenant1',
  name       => 'subnet1',
  name_alias => 'subnet_1',
  preferred  => 'yes',
  scope      => 'private,shared',
  virtual    => 'yes',
}