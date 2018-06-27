#
# March 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet Class for Puppet Resource aci_rest that allows the administrator to send
# HTTP POST/DELETE operations with specified raw JSON body formed
# according to the specification in the ACI REST Pramming Guide
# [https://www.cisco.com/c/en/us/td/docs/switches/datacenter/aci/apic/sw/2-x/rest_cfg/2_1_x/b_Cisco_APIC_REST_API_Configuration_Guide/b_Cisco_APIC_REST_API_Configuration_Guide_chapter_01.html]
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# For details on the Puppet Resource Type associated with this class
# please refer to <module_directory>/lib/puppet/type/cisco_aci_rest.rb
#
# This class is capable of obtaining the parameters from external sources like
# Puppet Hiera. When using Hiera YAML, please refer to Puppet documentation for
# details. This class supports an additional, optional parameters 'override_method',
# 'override_content' and 'override_path' that can be used to dynamically override
# the default parameters.
#
class cisco_aci::classes::cisco_aci_rest (
    $aci_rest_http_request_type,
    $aci_rest_resource_uri,
    $aci_rest_http_request_body,
    $override_http_request_type = $aci_rest_http_request_type,
    $override_resource_uri = $aci_rest_resource_uri,
    $override_http_request_body = $aci_rest_http_request_body,
) {
    cisco_aci_rest {'deploy_aci_rest':
          http_request_type => $override_http_request_type,
          resource_uri      => $override_resource_uri,
          http_request_body => $override_http_request_body,
    }

}
