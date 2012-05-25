require 'spec_helper'

describe 'rvm::system::ruby', :type => :define do
  let(:title) { 'test' }
  
  describe 'define with no params' do
		it { should contain_rvm__system__ruby('test').with_ensure('present')\
		                                             .with_default_use(false) }
		it { should_not contain_rvm_system_ruby('test') }
  end
  
  describe 'define with no params and rvm_installed true' do
    let(:facts) { { :rvm_installed => 'true' } }

		it { should contain_rvm__system__ruby('test').with_ensure('present')\
		                                             .with_default_use(false) }
		it { should contain_rvm_system_ruby('test').with_ensure('present')\
	                                             .with_default_use(false) }
  end
  
  describe 'define with ensure present, default_use and rvm_installed true' do
    let(:params) { { :ensure => 'present', :default_use => true } }
    let(:facts) { { :rvm_installed => 'true' } }

		it { should contain_rvm__system__ruby('test').with_ensure('present')\
		                                             .with_default_use(true) }
		it { should contain_rvm_system_ruby('test').with_ensure('present')\
	                                             .with_default_use(true) }
  end
  
  describe 'define with ensure absent and rvm_installed true' do
    let(:params) { { :ensure => 'absent' } }
    let(:facts) { { :rvm_installed => 'true' } }

		it { should contain_rvm__system__ruby('test').with_ensure('absent')\
		                                             .with_default_use(false) }
		it { should contain_rvm_system_ruby('test').with_ensure('absent')\
	                                             .with_default_use(false) }
  end
  
  describe "define with too many parameters" do
    let(:params) { { :extra => 'extra' } }
    
    it "should throw an error about the extra parameter" do
			expect { should contain_rvm__system__ruby('test') }\
				.to raise_error(Puppet::Error, /Invalid parameter extra/)
		end
  end
end
