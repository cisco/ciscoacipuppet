
class {"cisco_aci::classes::cisco_aci_rest":
  aci_rest_http_request_type => "post",
  aci_rest_resource_uri => "/api/mo/uni.json",
  aci_rest_http_request_body => '{
          "fvTenant": {
              "attributes": {
                  "name": "puppet_test1"
              },
              "children":
              [{
                 "fvAp": {
                    "attributes": {
                        "name": "puppet_test_Ap"
                    },
                 "children":
                 [{
                   "fvAEPg": {
                      "attributes": {
                          "name": "puppet_test_AEPg"
                     }
                   }
                 }]
                 }
              }]
          }
  }',
  override_http_request_type => $override_http_request_type,
  override_resource_uri  => $override_resource_uri,
  override_http_request_body => $override_http_request_body,
}
