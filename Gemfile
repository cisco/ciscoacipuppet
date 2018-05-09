#
# February 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet resource type for fvtenant
#
# Licensed under the Apache License, Version 2.0 (the "License");                                      1,1           All
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

source ENV['GEM_SOURCE'] || 'https://rubygems.org'

def location_for(place, fake_version=nil)
  if place =~ /^(git[:@][^#]*)#(.*)/
    [fake_version, { git: Regexp.last_match(1), branch: Regexp.last_match(2), require: false }].compact
  elsif place =~ %r{^file://(.*)}
    ['>= 0', { path: File.expand_path(Regexp.last_match(1)), require: false }]
  else
    [place, { require: false }]
  end
end

puppetversion = ENV.key?('PUPPET_VERSION') ? "#{ENV['PUPPET_VERSION']}" : ['>= 3.3']
gem 'puppet', puppetversion

gem 'facter', '>= 1.7.0'

group :development, :acceptance_tests do
  gem 'rake',                    require: false
  gem 'rspec',                   require: false
  gem 'rspec-puppet',            require: false
  gem 'mocha',                   require: false
  gem 'beaker-rspec',            require: false
  gem 'puppetlabs_spec_helper',  require: false
  gem 'puppet-lint',             require: false
  gem 'pry',                     require: false
  gem 'rubocop', '= 0.35.1',     require: false
  gem 'simplecov',               require: false
  gem 'puppet-blacksmith', '~> 3.4', require: false
end
