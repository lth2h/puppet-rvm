# Class: rmv::params
#
#
class rvm::params {
  $version = $rvm_version ? {
    ''      => 'latest',
    default => $rvm_version,
  }

  $trust_rvmrcs = $rvm_trust_rvmrcs ? {
    'true'  => true,
    'false' => false,
    default => false,
  }
}
