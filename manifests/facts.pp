#
# March 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Sample Puppet manifest to demonstrate ACI Fabric Member Fact usage.
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

# To easily display the cisco_aci fabric member facts simply add the following
# include line to the /etc/puppetlabs/code/environments/production/manifests/site.pp
#
#
# node 'cnijim-61.cisco.com' {
#   include cisco_aci::facts
# }
class cisco_aci::facts {

  #############################################################################
  # Display total count for aci fabric members.
  #############################################################################
  $count = cisco_aci::facts::fabric_member_get('count')
  notice("Number of ACI Fabric Members: ${count}")

  #############################################################################
  # Display list of aci fabric member ids.
  #############################################################################
  $members = cisco_aci::facts::fabric_member_get('ids')
  notice("ACI Fabric Members: ${members}")

  #############################################################################
  # Use member ids to display the model number on each
  #############################################################################
  $members.each |$mem| {
    $model = cisco_aci::facts::fabric_member_get({"${mem}" => 'model'})
    notice("Model number for ${mem}, ${model}")
  }

  #############################################################################
  # Display complete data set for one fabric member
  #############################################################################
  $member1 = $members[0]
  notice("ACI Fabric Member Data for Member: ${member1}")
  $member_data = cisco_aci::facts::fabric_member_get({"${member1}" => 'all'})
  $json_name = '@member_data'

  $content = inline_template("
  <%- require 'json' -%>
  <%= JSON.pretty_generate(${json_name}) %>
  ")

  notice($content)

  # Note: To view notice logs tail the following file on the puppet server
  #   tail -f /var/log/puppetlabs/puppetserver/puppetserver.log
}
