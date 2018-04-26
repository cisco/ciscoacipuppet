#
# March 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet cisco_aci::facts::num_members function
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

Puppet::Functions.create_function(:'cisco_aci::facts::num_members') do

  # Retrieve aci fabric member count
  #
  # @return [Integer] ACI fabric member count
  #
  # @examples:
  #   cisco_aci::facts::num_members
  #
  # NOTE: This is a helper method and is not intended to be called directly.
  dispatch :get_size do
  end

  def get_size()
    scope = closure_scope
    scope['facts']['aci_fabric_members'].size
  end
end
