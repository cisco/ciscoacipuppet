#
# March 2018
#
# Copyright (c) 2017-2018  Cisco and/or its affiliates.
#
# Base (create, modify, delete) acceptance test for aci_rest
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

require_relative '../../spec_helper_acceptance'

describe 'aci_rest' do
  context 'Base acceptance test' do
    basedata_fname = File.dirname(__FILE__) + '/aci_rest_basedata.pp'
    basedata = File.read(basedata_fname)
    it 'Create with POST request' do
      manifest = "$override_http_request_type = undef\n$override_resource_uri = undef\n"
      manifest = manifest + "$override_http_request_body = undef\n" + basedata
      output, error = apply_manifest(manifest)
      puts output
      fail "Failed in CREATE \n #{error}" unless output.include? 'Objects changed - 1'
      output, error = apply_manifest(manifest)
      puts output
      fail "Failed in CREATE - Idempotence \n #{error}" unless output.include? 'Objects changed - 0'
    end
    it 'Modify object with POST request' do
      unmodified = "$override_http_request_type = undef\n$override_resource_uri = undef\n"
      modified = '{"fvTenant": {"attributes": {"name": "puppet_test1", "descr": "modify descr"}}}'
      manifest = unmodified + "$override_http_request_body = '" + modified + "'\n\n" + basedata
      output, error = apply_manifest(manifest)
      puts output
      fail "Failed in Modify \n #{error}" unless output.include? 'Objects changed - 1'
      output = apply_manifest(manifest)
      puts output
      fail "Failed in Modify - Idempotence \n #{error}" unless output.include? 'Objects changed - 0'
    end
    it 'Delete object with DELETE request' do
      manifest = "$override_http_request_type = 'delete'\n$override_resource_uri = '/api/mo/uni/tn-puppet_test1.json'\n"
      manifest = manifest + "$override_http_request_body = undef\n" + basedata
      puts apply_manifest(manifest)
      puts apply_manifest(manifest)
    end
  end
end
