# Class: rmv::params
#
#
class rvm::params {
  $trust_rvmrcs = $rvm_trust_rvmrcs ? {
    'true'  => true,
    'false' => false,
    default => false,
  }
}
