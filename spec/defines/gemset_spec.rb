require 'spec_helper'

describe 'rvm::gemset', :type => :define do
  let(:title) { 'test' }
  
  describe 'define with no params' do
		it { should contain_rvm__gemset('test').with_ensure('present')\
		                                       .with_ruby_version('ruby-1.9.2-p290') }
		it { should_not contain_rvm_gemset('test') }
  end
  
  describe 'define with no params and rvm_installed true' do
    let(:facts) { { :rvm_installed => 'true' } }

		it { should contain_rvm__gemset('test').with_ensure('present')\
		                                       .with_ruby_version('ruby-1.9.2-p290') }
		it { should contain_rvm_gemset('test').with_ensure('present')\
	                                        .with_ruby_version('ruby-1.9.2-p290') }
  end
  
  describe 'define with ensure present, ruby_version ruby-2.0-p1024 and rvm_installed true' do
    let(:params) { { :ensure => 'present', :ruby_version => 'ruby-2.0-p1024' } }
    let(:facts) { { :rvm_installed => 'true' } }

		it { should contain_rvm__gemset('test').with_ensure('present')\
		                                       .with_ruby_version('ruby-2.0-p1024') }
		it { should contain_rvm_gemset('test').with_ensure('present')\
	                                        .with_ruby_version('ruby-2.0-p1024') }
  end
  
  describe "define with too many parameters" do
    let(:params) { { :extra => 'extra' } }
    
    it "should throw an error about the extra parameter" do
			expect { should contain_rvm__gemset('test') }\
				.to raise_error(Puppet::Error, /Invalid parameter extra/)
		end
  end
end
