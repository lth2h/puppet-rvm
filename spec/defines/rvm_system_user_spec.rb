require 'spec_helper'

describe 'rvm::system::user', :type => :define do
  let(:title) { 'test' }
  
  describe 'define with no params' do
		it { should contain_rvm__system__user('test').with_unmanaged_user(false) }
		it { should contain_exec('/usr/sbin/usermod -a -G rvm test').with_unless('/bin/cat /etc/group | grep rvm | grep test') }
  end
  
  describe 'define with unmanaged_user true' do
    let(:params) { { :unmanaged_user => true } }
    
		it { should contain_rvm__system__user('test').with_unmanaged_user(true) }
		it { should contain_exec('/usr/sbin/usermod -a -G rvm test').with_unless('/bin/cat /etc/group | grep rvm | grep test') }
  end
  
  describe "define with too many parameters" do
    let(:params) { { :extra => 'extra' } }
    
    it "should throw an error about the extra parameter" do
			expect { should contain_rvm__system__user('test') }\
				.to raise_error(Puppet::Error, /Invalid parameter extra/)
		end
  end
end
