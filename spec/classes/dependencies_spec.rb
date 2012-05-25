require 'spec_helper'

describe 'rvm::dependencies', :type => :class do
  let(:title) { 'dependencies' }
  
  describe 'class with OS set to Ubuntu' do
    let(:facts) { { :operatingsystem => 'Ubuntu'} }

		it { should create_class('rvm::dependencies') }
		it { should contain_class('buildenv::cpp') }
		it { should contain_class('buildenv::libs::xml2') }
		it { should contain_class('buildenv::libs::xslt') }
		it { should contain_class('buildenv::libs::openssl') }
		it { should contain_class('buildenv::libs::readline') }
		it { should contain_class('buildenv::libs::yaml') }
		it { should contain_class('buildenv::libs::zlib') }
		it { should contain_class('git::client') }
		it { should contain_class('rvm::dependencies::debian') }
		#it { should contain_package('curl').with_version('installed') }
		it { should_not contain_class('rvm::dependencies::redhat') }
  end
  
  describe 'class with OS set to Debian' do
    let(:facts) { { :operatingsystem => 'Debian'} }

		it { should create_class('rvm::dependencies') }
		it { should contain_class('buildenv::cpp') }
		it { should contain_class('buildenv::libs::xml2') }
		it { should contain_class('buildenv::libs::xslt') }
		it { should contain_class('buildenv::libs::openssl') }
		it { should contain_class('buildenv::libs::readline') }
		it { should contain_class('buildenv::libs::yaml') }
		it { should contain_class('buildenv::libs::zlib') }
		it { should contain_class('git::client') }
		it { should contain_class('rvm::dependencies::debian') }
		#it { should contain_package('curl').with_version('installed') }
		it { should_not contain_class('rvm::dependencies::redhat') }
  end
  
  describe 'class with OS set to CentOS' do
    let(:facts) { { :operatingsystem => 'CentOS'} }

		it { should create_class('rvm::dependencies') }
		it { should contain_class('buildenv::cpp') }
		it { should contain_class('buildenv::libs::xml2') }
		it { should contain_class('buildenv::libs::xslt') }
		it { should contain_class('buildenv::libs::openssl') }
		it { should contain_class('buildenv::libs::readline') }
		it { should contain_class('buildenv::libs::yaml') }
		it { should contain_class('buildenv::libs::zlib') }
		it { should contain_class('git::client') }
		it { should contain_class('rvm::dependencies::redhat') }
		#it { should contain_package('curl').with_version('installed') }
		it { should_not contain_class('rvm::dependencies::debian') }
  end
  
  describe 'class with OS set to Fedora' do
    let(:facts) { { :operatingsystem => 'Fedora'} }

		it { should create_class('rvm::dependencies') }
		it { should contain_class('buildenv::cpp') }
		it { should contain_class('buildenv::libs::xml2') }
		it { should contain_class('buildenv::libs::xslt') }
		it { should contain_class('buildenv::libs::openssl') }
		it { should contain_class('buildenv::libs::readline') }
		it { should contain_class('buildenv::libs::yaml') }
		it { should contain_class('buildenv::libs::zlib') }
		it { should contain_class('git::client') }
		it { should contain_class('rvm::dependencies::redhat') }
		#it { should contain_package('curl').with_version('installed') }
		it { should_not contain_class('rvm::dependencies::debian') }
  end
  
  describe 'class with OS set to RedHat' do
    let(:facts) { { :operatingsystem => 'RedHat'} }

		it { should create_class('rvm::dependencies') }
		it { should contain_class('buildenv::cpp') }
		it { should contain_class('buildenv::libs::xml2') }
		it { should contain_class('buildenv::libs::xslt') }
		it { should contain_class('buildenv::libs::openssl') }
		it { should contain_class('buildenv::libs::readline') }
		it { should contain_class('buildenv::libs::yaml') }
		it { should contain_class('buildenv::libs::zlib') }
		it { should contain_class('git::client') }
		it { should contain_class('rvm::dependencies::redhat') }
		#it { should contain_package('curl').with_version('installed') }
		it { should_not contain_class('rvm::dependencies::debian') }
  end
  
  describe 'class with invalid OS' do
    let(:facts) { { :operatingsystem => 'CloudOS' } }
    
    it 'should throw an error about the unsupported OS' do
			expect { should create_class('rvm::dependencies') }\
				.to raise_error(Puppet::Error, /Unsupported OS CloudOS/)
		end
  end
  
  describe "class with too many parameters" do
    let(:params) { { :extra => 'extra' } }
    
    it "should throw an error about the extra parameter" do
			expect { should create_class('rvm::dependencies') }\
				.to raise_error(Puppet::Error, /Invalid parameter extra/)
		end
  end
end
