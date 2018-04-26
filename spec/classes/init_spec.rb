require 'spec_helper'
describe 'aci_puppet_module' do

  context 'with defaults for all parameters' do
    it { should contain_class('aci_puppet_module') }
  end
end
