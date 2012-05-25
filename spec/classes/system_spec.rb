require 'spec_helper'

describe 'rvm::system', :type => :class do
  let(:title) { 'system' }
  let(:facts) { { :operatingsystem => 'Ubuntu'} }
  
  describe 'class with no parameters' do
		it { should create_class('rvm::system').with_version('latest')\
		                                       .with_trust_rvmrcs(false) }
		it { should contain_class('rvm::params') }
		it { should contain_class('rvm::dependencies') }
		it { should contain_exec('system-rvm').with_command("bash -c '/usr/bin/curl -s https://rvm.beginrescueend.com/install/rvm -o rvm-installer ; chmod +x rvm-installer ; rvm_bin_path=/usr/local/rvm/bin rvm_man_path=/usr/local/rvm/man ./rvm-installer --version latest'")\
		                                      .with_path('/usr/bin:/usr/sbin:/bin')\
		                                      .with_creates('/usr/local/rvm/bin/rvm') }
		it { should_not contain_common__line('trust-rvmrcs') }
  end

  describe 'class with version 1.0, trust_rvmrcs true and rvm not installed' do
    let(:params) { { :version => '1.0', :trust_rvmrcs => true } }

		it { should create_class('rvm::system').with_version('1.0')\
		                                       .with_trust_rvmrcs(true) }
		it { should contain_class('rvm::params') }
		it { should contain_class('rvm::dependencies') }
		it { should contain_exec('system-rvm').with_command("bash -c '/usr/bin/curl -s https://rvm.beginrescueend.com/install/rvm -o rvm-installer ; chmod +x rvm-installer ; rvm_bin_path=/usr/local/rvm/bin rvm_man_path=/usr/local/rvm/man ./rvm-installer --version 1.0'")\
		                                      .with_path('/usr/bin:/usr/sbin:/bin')\
		                                      .with_creates('/usr/local/rvm/bin/rvm') }
		it { should_not contain_common__line('trust-rvmrcs') }
  end
  
  describe 'class with version 1.0, trust_rvmrcs true and rvm installed' do
    let(:params) { { :version => '1.0', :trust_rvmrcs => true } }
    let(:facts) { { :operatingsystem => 'Ubuntu', :rvm_installed => 'true' } }

		it { should create_class('rvm::system').with_version('1.0')\
		                                       .with_trust_rvmrcs(true) }
		it { should contain_class('rvm::params') }
		it { should contain_class('rvm::dependencies') }
		it { should contain_exec('system-rvm').with_command("bash -c '/usr/bin/curl -s https://rvm.beginrescueend.com/install/rvm -o rvm-installer ; chmod +x rvm-installer ; rvm_bin_path=/usr/local/rvm/bin rvm_man_path=/usr/local/rvm/man ./rvm-installer --version 1.0'")\
		                                      .with_path('/usr/bin:/usr/sbin:/bin')\
		                                      .with_creates('/usr/local/rvm/bin/rvm') }
		it { should contain_common__line('trust-rvmrcs').with_ensure('present')\
		                                                .with_file('/etc/rvmrc')\
		                                                .with_line('rvm_trust_rvmrcs_flag=1') }
  end
  
  describe "class with too many parameters" do
    let(:params) { { :extra => 'extra' } }
    
    it "should throw an error about the extra parameter" do
			expect { should create_class('rubygems') }\
				.to raise_error(Puppet::Error, /Invalid parameter extra/)
		end
  end
end
