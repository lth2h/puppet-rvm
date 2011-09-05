class rvm::dependencies::redhat {
  require buildenv::libs::ffi
  require buildenv::tools::patch

  if ! defined(Package['bzip2']) {
	  package { 'bzip2':
	    ensure => latest,
	  }
	}
}
