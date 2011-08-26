# rvm::gem is a simple wrapper around rvm_gem to ensure that the type is not
# invloked unless RVM is installed. It also adds an automatic requirement to
# the corresponding rvm::system::ruby resource according to the specified
# $ruby_version.
# At this time rvm::gem does not support the shorthand version of rvm_gem i.e:
# ruby-1.9.2-p180/bundler
#
# == Parameters
#
# [*ensure*]
#   What state the gem should be in.
#   Possible values:
#   *present* - the gem is installed
#   *latest* - the gem is installed and is the latest stable version
#   *absent* - the gem is not installed
#   version - the gem is installed and matches the given version
#
# [*ruby_version*]
#   The ruby version to use.  This should be the fully qualified RVM string
# (including gemset if applicable).  For example: 'ruby-1.9.2-p136@mygemset'
# For a full list of known strings: `rvm list known_strings`.
#
# [*gem_name*]
#   The name of the Ruby gem. Usually used when trying to install the same gem
# in multiple versions of ruby
#
# [*source*]
#   If a URL is passed via, then that URL is used as the
# remote gem repository; if a source is present but is not a valid URL, it will be
# interpreted as the path to a local gem file.  If source is not present at all,
# the gem will be installed from the default gem repositories.
#
# == Examples
#
# Install a gem with:
# 
#   rvm::gem { 'bundler':
#     ensure       => '1.0.13',
#     ruby_version => 'ruby-1.9.2-p180',
#     require      => Rvm_system_ruby['ruby-1.9.2-p180'],
#   }
# 
# Sometimes you need to install the same gem for multiple rubies:
# 
#   rvm::gem { 'bundler192':
#     gem_name     => 'bundler',
#     ensure       => '1.0.13',
#     ruby_version => 'ruby-1.9.2-p180',
#     require      => Rvm_system_ruby['ruby-1.9.2-p180'],
#   }
# 
#   rvm::gem { 'bundler187':
#     gem_name     => 'bundler',
#     ensure       => '1.0.13',
#     ruby_version => 'ruby-1.8.7-p334',
#     require      => 'Rvm_system_ruby['ruby-1.8.7-p334'],
#   }
#
define rvm::gem (
  $ensure = present,
  $gem_name = undef,
  $ruby_version = 'ruby-1.9.2-p290',
  $source = undef
) {

  if $rvm_installed == "true" {
    rvm_gem { $title:
      ensure       => $ensure,
      name         => $gem_name,
      ruby_version => $ruby_version,
      source       => $source,
      require      => Rvm::System::Ruby[$ruby_version],
    }
  } else {
    info "RVM is not installed yet (perhaps first run?). rvm::gem[${name}] will not be installed on this run."
  }
}
