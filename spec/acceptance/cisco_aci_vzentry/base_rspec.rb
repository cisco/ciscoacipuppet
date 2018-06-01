#
# June 2018
#
# Copyright (c) 2017-2018  Cisco and/or its affiliates.
#
# Base (create, modify, delete) acceptance test for vzentry
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

describe 'vzentry' do
  context 'Base acceptance test' do
    basedata_fname = File.dirname(__FILE__) + '/vzentry_basedata.pp'
    basedata = File.read(basedata_fname)
    it 'vzentry Testcase Setup' do
      manifest = "$override_ensure = absent\n$override_descr = undef\n" + basedata
      apply_manifest(manifest)
    end
    it 'Create (ensure = present)' do
      manifest = "$override_ensure = present\n$override_descr = undef\n" + basedata
      output, error = apply_manifest(manifest)
      puts output
      fail "Failed in CREATE \n #{error}" unless output.include? "Changed 'name' from="
      output, error = apply_manifest(manifest)
      puts output
      fail "Failed in CREATE - Idempotence \n #{error}" if output.include? "Changed 'name' from="
    end
    it 'Modify description (ensure = present)' do
      manifest = "$override_ensure = present\n$override_descr = 'Rspec Modified'\n" + basedata
      output, error = apply_manifest(manifest)
      puts output
      fail "Failed in Modify \n #{error}" unless output.include? "Changed 'descr' from="
      output, error = apply_manifest(manifest)
      puts output
      fail "Failed in Modify - Idempotence \n #{error}" if output.include? "Changed 'descr' from="
    end
    it 'Delete (ensure = absent)' do
      manifest = "$override_ensure = absent\n$override_descr = undef\n" + basedata
      output, error = apply_manifest(manifest)
      puts output
      fail "Failed in DELETE \n #{error}" unless output.include? 'ensure: removed'
      output, error = apply_manifest(manifest)
      puts output
      fail "Failed in DELETE - Idempotence \n #{error}" if output.include? 'ensure: removed'
    end
  end
end
