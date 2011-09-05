require 'spec_helper'

describe 'rvm::gem', :type => :define do
  let(:title) { 'test' }
  
  describe 'define with no params' do
		it { should contain_rvm__gem('test').with_ensure('present')\
		                                    .without_gem_name\
		                                    .with_ruby_version('ruby-1.9.2-p290')\
		                                    .without_source }
		it { should_not contain_rvm_gem('test') }
  end
  
  describe 'define with no params and rvm_installed true' do
    let(:facts) { { :rvm_installed => 'true' } }

		it { should contain_rvm__gem('test').with_ensure('present')\
		                                    .without_gem_name\
		                                    .with_ruby_version('ruby-1.9.2-p290')\
		                                    .without_source }
		it { should contain_rvm_gem('test').with_ensure('present')\
	                                     .without_name\
	                                     .with_ruby_version('ruby-1.9.2-p290')\
	                                     .without_source }
  end
  
  describe 'define with ensure 3.1, gem_name testme, ruby_version ruby-2.0-p1024, source http://supergems.com/testme/testme-3.1.gem and rvm_installed true' do
    let(:params) { { :ensure => '3.1', :gem_name => 'testme', :ruby_version => 'ruby-2.0-p1024',
                    :source => 'http://supergems.com/testme/testme-3.1.gem' } }
    let(:facts) { { :rvm_installed => 'true' } }

		it { should contain_rvm__gem('test').with_ensure('3.1')\
		                                    .with_gem_name('testme')\
		                                    .with_ruby_version('ruby-2.0-p1024')\
		                                    .with_source('http://supergems.com/testme/testme-3.1.gem') }
		it { should contain_rvm_gem('test').with_ensure('3.1')\
	                                     .with_name('testme')\
	                                     .with_ruby_version('ruby-2.0-p1024')\
	                                     .with_source('http://supergems.com/testme/testme-3.1.gem') }
  end
  
  describe "define with too many parameters" do
    let(:params) { { :extra => 'extra' } }
    
    it "should throw an error about the extra parameter" do
			expect { should contain_rvm__gem('test') }\
				.to raise_error(Puppet::Error, /Invalid parameter extra/)
		end
  end
end
