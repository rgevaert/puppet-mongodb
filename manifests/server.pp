class mongodb::server( $auth = false )
{
  $package = 'mongodb-server/squeeze-backports'

  package {
    $package:
      ensure => present;
  }

  file {
    '/etc/mongodb.conf':
      require => Package[$package],
      notify  => Service['mongodb'],
      content => template('mongodb/mongodb.conf.erb'),
      ensure  => present,
      mode    => 644,
      owner   => root,
      group   => root;
  }
  service {
    "mongodb":
      require  => File['/etc/mongodb.conf'],
      enable   => true,
      hasstatus => true,
      ensure   => running;
  }
}
