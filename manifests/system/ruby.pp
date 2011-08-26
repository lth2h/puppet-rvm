# rvm::system::ruby is a simple wrapper around rvm_system_ryby to ensure that
# the type is not invloked unless RVM is installed
#
# == Parameters
#
# [*ensure*]
#   What state the ruby should be in.
#   Possible values:
#   *present* - the ruby is installed
#   *absent* - the ruby is not installed
#
# [*default_use*]
#   Should this Ruby be the system default for new terminals?
#
# == Examples
#
# Install a ruby with:
# 
#   rvm::system::ruby { 'ruby-1.9.2-p180':
#     ensure      => 'present',
#     default_use => true,
#   }
#
#   rvm::system::ruby { 'ruby-1.8.7-p334':
#     ensure      => 'present',
#     default_use => false,
#   }
#
define rvm::system::ruby (
  $ensure = 'present',
  $default_use = false
) {

  if $rvm_installed == "true" {
    rvm_system_ruby { $name:
      ensure      => $ensure,
      default_use => $default_use,
    }
  } else {
    info "RVM is not installed yet (perhaps first run?). rvm::system::ruby[${name}] will not be installed on this run."
  }
}
