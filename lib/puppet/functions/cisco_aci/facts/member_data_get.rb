#
# March 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet cisco_aci::facts::member_data_get function
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
Puppet::Functions.create_function(:'cisco_aci::facts::member_data_get') do

  # Get specific aci fabric member data using a lookup key
  #
  # @param member_id_key_hash Hash containing member id and member data key
  #
  # @return [Hash] aci fabric member if key is 'all' else [String] of key data.
  #
  # @examples:
  #   1) Get model number data for aci fabric member with id SAL1814PTC6
  #      cisco_aci::facts::member_data_get({"SAL1814PTC6"=>"model"})
  #
  #   2) Get all data for aci fabric member SAL1814PTC6
  #      cisco_aci::facts::member_data_get({"SAL1814PTC6"=>"all"})
  #
  # NOTE: This is a helper method and is not intended to be called directly.
  dispatch :data_get do
    param 'Hash', :member_id_key_hash
  end

  def data_get(member_id_key_hash)
    if member_id_key_hash.empty? or member_id_key_hash.size > 1
      fn = "cisco_aci::facts::member_data_get"
      arg = "#{fn}({'<aci_fabric_member_id>' => '<data_key>'})"

      msg = %{
      Invalid argument format specified for function '#{fn}'!
      Argument should be type [Hash] with one key/value pair"

      Example:
          #{arg}
      }
      call_function('fail', msg)
    end
    member_id = member_id_key_hash.keys[0].to_s
    data_key = member_id_key_hash[member_id].to_s
    scope = closure_scope
    scope['facts']['aci_fabric_members'].each do |member|
      if member.keys[0].to_s == member_id
        if data_key == 'all'
          return member[member_id]
        else
          return member[member_id][data_key]
        end
      end
    end
    return "DATA NOT FOUND FOR ACI FABRIC MEMBER #{member_id}"
  end
end
