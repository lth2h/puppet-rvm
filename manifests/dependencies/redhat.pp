class rvm::dependencies::redhat {
  require buildenv::packages::libffi
  require buildenv::packages::patch

  if ! defined(Package['bzip2']) {
	  package { 'bzip2':
	    ensure => installed,
	  }
	}
}
