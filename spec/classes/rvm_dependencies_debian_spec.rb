require 'spec_helper'

describe 'rvm::dependencies::debian', :type => :class do
  let(:title) { 'debian' }
  let(:facts) { { :operatingsystem => 'Debian' }  }
  
  describe 'class no parameters' do
		it { should create_class('rvm::dependencies::debian') }
		it { should contain_class('buildenv::libs::sqlite') }
  end
  
  describe "class with too many parameters" do
    let(:params) { { :extra => 'extra' } }
    
    it "should throw an error about the extra parameter" do
			expect { should create_class('rvm::dependencies::debian') }\
				.to raise_error(Puppet::Error, /Invalid parameter extra/)
		end
  end
end
