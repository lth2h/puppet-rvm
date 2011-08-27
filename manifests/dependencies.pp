class rvm::dependencies {
  require buildenv::cpp
  require buildenv::packages::libxml2
  require buildenv::packages::libxslt
  require buildenv::packages::openssl
  require buildenv::packages::readline
  require buildenv::packages::yaml
  require buildenv::packages::zlib
  require git::client
  
  if ! defined(Package['curl']) {
	  package { 'curl':
	    ensure => installed,
	  }
	}
  
  case $operatingsystem {
    /(?i)(Debian|Ubuntu)/: {
      require rvm::dependencies::debian
    }
		/(?i)(Redhat|CentOS)/: {
		  require rvm::dependencies::redhat
		}
  }
}
