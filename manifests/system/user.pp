define rvm::system::user ($unmanaged_user = false) {

  $group = $operatingsystem ? {
    default => 'rvm',
  }

  exec { "/usr/sbin/usermod -a -G ${group} ${name}":
    unless  => "/bin/cat /etc/group | grep ${group} | grep ${name}",
  }
  
  if $unmanaged_user {
    Exec["/usr/sbin/usermod -a -G ${group} ${name}"] {
      require => Exec['system-rvm'],
    }
  } else {
    Exec["/usr/sbin/usermod -a -G ${group} ${name}"] {
      require => [ User[$name], Exec['system-rvm'] ],
    }
  }
}
