#
# March 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet cisco_aci::facts::member_ids function
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

Puppet::Functions.create_function(:'cisco_aci::facts::member_ids') do

  # Retrieve all aci fabric member ids
  #
  # @return [Array] ACI fabric member ids
  #
  # @examples:
  #   cisco_aci::facts::fabric_member_ids
  #
  # NOTE: This is a helper method and is not intended to be called directly.
  dispatch :ids do
  end

  def ids
    scope = closure_scope
    member_ids = []
    scope['facts']['aci_fabric_members'].each do |index|
      member_ids << index.keys[0]
    end
    member_ids
  end
end
