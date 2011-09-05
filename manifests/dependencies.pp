class rvm::dependencies {
  require buildenv::cpp
  require buildenv::libs::xml2
  require buildenv::libs::xslt
  require buildenv::libs::openssl
  require buildenv::libs::readline
  require buildenv::libs::yaml
  require buildenv::libs::zlib
  require git::client
  
  if ! defined(Package['curl']) {
	  package { 'curl':
	    ensure => latest,
	  }
	}
  
  case $operatingsystem {
    /(?i-mx:debian|ubuntu)/: {
      require rvm::dependencies::debian
    }
		/(?i-mx:centos|fedora|redhat)/: {
		  require rvm::dependencies::redhat
		}
    default: {
      fail "Unsupported OS ${operatingsystem} in module 'rvm'. Supported OSes are Ubuntu|Debian|CentOS|Fedora|RedHat"
    }
  }
}
