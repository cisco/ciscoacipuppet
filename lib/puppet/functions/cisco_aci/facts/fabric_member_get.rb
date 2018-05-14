#
# March 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet cisco_aci::facts::fabric_member_get
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
Puppet::Functions.create_function(:'cisco_aci::facts::fabric_member_get') do
  # Acts on various request types to return fabric member fact data.
  #
  # @param value count: Request number of aci fabric members.
  # @param value all:   Request all aci fabric member data.
  # @param value ids:   Request Array of aci fabric member ids.
  #
  # @return:
  #   [Integer] Number of aci fabric members when request 'count'
  #   [Hash] All aci fabric member data when request 'all'
  #   [Array] List of aci fabric member ids
  #
  # @examples:
  #   1) Get ACI fabric member count.
  #      cisco_aci::facts::fabric_member_get('count')
  #
  #   2) Get list of ACI fabric member ids.
  #      cisco_aci::facts::fabric_member_get('ids')
  #
  #   3) Get hash containing all ACI fabric member data.
  #      cisco_aci::facts::fabric_member_get('all')
  dispatch :get do
    param 'Enum[count, all, ids]', :request
  end

  # Retrieve member data using the member id and member data key
  #
  # @param member_id_key_hash Hash containing member id and member data key
  #
  # @return [String] Member id data indexed by member data key
  #
  # @examples:
  #   1) Get model number data for aci fabric member with id SAL1814PTC6
  #      cisco_aci::facts::fabric_member_get({"SAL1814PTC6"=>"model"})
  #
  #   2) Get all data for aci fabric member SAL1814PTC6
  #      cisco_aci::facts::fabric_member_get({"SAL1814PTC6"=>"all"})
  dispatch :get_member_data do
    param 'Hash', :member_id_key_hash
  end

  def get(request)
    case request
    when 'count'
      return call_function('cisco_aci::facts::num_members')
    when 'all'
      return call_function('cisco_aci::facts::member_data_all')
    when 'ids'
      return call_function('cisco_aci::facts::member_ids')
    end
  end

  def get_member_data(member_id_key_hash)
    method = 'cisco_aci::facts::member_data_get'
    call_function(method, member_id_key_hash)
  end
end
