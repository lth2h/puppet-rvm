# rvm::gemset is a simple wrapper around rvm_gemset to ensure that the type is not
# invloked unless RMV is installed. It also adds an automatic requirement to
# the corresponding rvm::system::ruby resource according to the specified
# $ruby_version
#
# == Parameters
#
# [*ensure*]
#   What state the gemset should be in.
#   Possible values:
#   *present* - the gemset is installed
#   *absent* - the gemset is not installed
#
# [*ruby_version*]
#   The ruby version to use.  This should be the fully qualified RVM string
# (including gemset if applicable).  For example: 'ruby-1.9.2-p136@mygemset'
# For a full list of known strings: `rvm list known_strings`.
#
# == Examples
#
# Install a gemset with:
# 
#   rvm::gemset { 'ruby-1.9.2-p290/myproject':
#     ensure       => 'present,
#     ruby_version => 'ruby-1.9.2-p180',
#   }
#
define rvm::gemset (
  $ruby_version = 'ruby-1.9.2-p290',
  $ensure = 'present'
) {

  if $rvm_installed == "true" {
    rvm_gemset { $title:
      ensure       => $ensure,
      ruby_version => $ruby_version,
      require      => Rvm::System::Ruby[$ruby_version],
    }
  } else {
    info "RVM is not installed yet (perhaps first run?). rvm::gemset[${name}] will not be installed on this run."
  }
}
