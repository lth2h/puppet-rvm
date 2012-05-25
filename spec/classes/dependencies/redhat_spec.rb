require 'spec_helper'

describe 'rvm::dependencies::redhat', :type => :class do
  let(:title) { 'redhat' }
  let(:facts) { { :operatingsystem => 'RedHat' }  }
  
  describe 'class no parameters' do
		it { should create_class('rvm::dependencies::redhat') }
		it { should contain_class('buildenv::libs::ffi') }
		it { should contain_class('buildenv::tools::patch') }
		#it { should contain_package('bzip2').with_version('latest') }
  end
  
  describe "class with too many parameters" do
    let(:params) { { :extra => 'extra' } }
    
    it "should throw an error about the extra parameter" do
			expect { should create_class('rvm::dependencies::redhat') }\
				.to raise_error(Puppet::Error, /Invalid parameter extra/)
		end
  end
end
