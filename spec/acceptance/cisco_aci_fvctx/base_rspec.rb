#
# April 2018
#
# Copyright (c) 2017-2018  Cisco and/or its affiliates.
#
# Base (create, modify, delete) acceptance test for fvctx
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

describe "fvctx" do
  context "Base acceptance test" do
    basedata_fname = File.dirname(__FILE__) + "/fvctx_basedata.pp"
    basedata = File.read(basedata_fname)
    it "Create (ensure = present)" do
      manifest = "$override_ensure = present\n$override_descr = undef\n" + basedata
      apply_manifest(manifest)
    end
    it "Modify description (ensure = present)" do
      manifest = "$override_ensure = present\n$override_descr = 'Rspec Modified'\n" + basedata
      apply_manifest(manifest)
    end
    it "Delete (ensure = absent)" do
      manifest = "$override_ensure = absent\n$override_descr = undef\n" + basedata
      apply_manifest(manifest)
    end
  end
end