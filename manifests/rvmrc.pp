# Define: rvm::rvmrc
# Parameters:
# $ruby_version, $gemset, $path, $trust = true
#
define rvm::rvmrc (
  $ruby_version,
  $path,
  $trust = true,
  $user = 'root',
  $ensure = 'present'
) {

  if $rvm_installed == 'true' {
    case $ensure {
      'present': {
        exec { "Create rvmrc ${ruby_version}@${name} in ${path}":
          command => "/usr/local/rvm/bin/rvm --rvmrc --create ${ruby_version}@${name}",
          cwd     => $path,
          creates => "${path}/.rvmrc",
          user    => $user,
          notify  => Exec["Trust rvmrc ${ruby_version}@${name} in ${path}"],
          require => Rvm::System::Ruby[$ruby_version],
        }
        
        if $trust {
          exec { "Trust rvmrc ${ruby_version}@${name} in ${path}":
            command     => "/usr/local/rvm/bin/rvm rvmrc trust",
            cwd         => $path,
            refreshonly => true,
            user        => $user,
          }
        }
      }
      'absent': {
        file { "${path}/.rvmrc":
          ensure => absent,
        }
      }
      default: {
        fail "Unknown ensure value ${ensure} in module 'rvm'. Known values are 'present|absent"
      }
    }
  } else {
    info "RVM is not installed yet (perhaps first run?). rvm::rvmrc[${name}] will not be created on this run."
  }
}
