require 'spec_helper'

describe 'rvm::rvmrc', :type => :define do
  let(:title) { 'test' }
  
  describe 'define with no parameters' do
		it "should throw an error about the missing path parameter" do
			expect { should contain_rvm__rvmrc('test') }\
				.to raise_error(Puppet::Error, /Must pass path/)
		end
  end
  
  describe 'define with ruby_version 1.8.7, path /tmp/rvm' do
    let(:params) { { :ruby_version => '1.8.7', :path => '/tmp/rvm' } }

		it { should contain_rvm__rvmrc('test').with_ruby_version('1.8.7')\
		                                      .with_path('/tmp/rvm')\
		                                      .with_trust(true)\
		                                      .with_user('root')\
		                                      .with_ensure('present') }
		it { should_not contain_exec('Create rvmrc 1.8.7@$test in /tmp/rvm') }
		it { should_not contain_exec('Trust rvmrc 1.8.7@$test in /tmp/rvm') }
  end
  
  describe 'define with ruby_version 1.8.7, path /tmp/rvm and rvm_installed true' do
    let(:params) { { :ruby_version => '1.8.7', :path => '/tmp/rvm' } }
    let(:facts) { { :rvm_installed => 'true' } }

		it { should contain_rvm__rvmrc('test').with_ruby_version('1.8.7')\
		                                      .with_path('/tmp/rvm')\
		                                      .with_trust(true)\
		                                      .with_user('root')\
		                                      .with_ensure('present') }
		it { should contain_exec('Create rvmrc 1.8.7@test in /tmp/rvm').with_command('/usr/local/rvm/bin/rvm --rvmrc --create 1.8.7@test')\
		                                                               .with_cwd('/tmp/rvm')\
		                                                               .with_creates('/tmp/rvm/.rvmrc')\
		                                                               .with_user('root') }
		it { should contain_exec('Trust rvmrc 1.8.7@test in /tmp/rvm').with_command('/usr/local/rvm/bin/rvm rvmrc trust')\
    		                                                          .with_cwd('/tmp/rvm')\
    		                                                          .with_refreshonly(true)\
    		                                                          .with_user('root') }
    it { should_not contain_file('/tmp/rvm/.rvmrc') }
  end
  
  describe 'define with ruby_version 1.8.7, path /tmp/rvm, trust false, user admin and rvm_installed true' do
    let(:params) { { :ruby_version => '1.8.7', :path => '/tmp/rvm', :trust => false, :user => 'admin' } }
    let(:facts) { { :rvm_installed => 'true' } }

		it { should contain_rvm__rvmrc('test').with_ruby_version('1.8.7')\
		                                      .with_path('/tmp/rvm')\
		                                      .with_trust(false)\
		                                      .with_user('admin')\
		                                      .with_ensure('present') }
		it { should contain_exec('Create rvmrc 1.8.7@test in /tmp/rvm').with_command('/usr/local/rvm/bin/rvm --rvmrc --create 1.8.7@test')\
		                                                               .with_cwd('/tmp/rvm')\
		                                                               .with_creates('/tmp/rvm/.rvmrc')\
		                                                               .with_user('admin') }
		it { should_not contain_exec('Trust rvmrc 1.8.7@test in /tmp/rvm') }
    it { should_not contain_file('/tmp/rvm/.rvmrc') }
  end
  
  describe 'define with ruby_version 1.8.7, path /tmp/rvm, ensure absent and rvm_installed true' do
    let(:params) { { :ruby_version => '1.8.7', :path => '/tmp/rvm', :ensure => 'absent' } }
    let(:facts) { { :rvm_installed => 'true' } }

		it { should contain_rvm__rvmrc('test').with_ruby_version('1.8.7')\
		                                      .with_path('/tmp/rvm')\
		                                      .with_trust(true)\
		                                      .with_user('root')\
		                                      .with_ensure('absent') }
		it { should_not contain_exec('Create rvmrc 1.8.7@test in /tmp/rvm') }
		it { should_not contain_exec('Trust rvmrc 1.8.7@test in /tmp/rvm') }
    it { should contain_file('/tmp/rvm/.rvmrc').with_ensure('absent') }
  end
  
  describe 'define with invalid ensure trusted and rvm_installed true' do
    let(:params) { { :ruby_version => '1.8.7', :path => '/tmp/rvm', :ensure => 'trusted' } }
    let(:facts) { { :rvm_installed => 'true' } }

    it "should throw an error about the invalid ensure value" do
			expect { should contain_rvm__rvmrc('test') }\
				.to raise_error(Puppet::Error, /Unknown ensure value trusted/)
		end
  end
  
  describe "define with too many parameters" do
    let(:params) { { :extra => 'extra' } }
    
    it "should throw an error about the extra parameter" do
			expect { should contain_rvm__rvmrc('test') }\
				.to raise_error(Puppet::Error, /Invalid parameter extra/)
		end
  end
end
