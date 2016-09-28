# == Class: puppet-opendj Package
#
# puppet-opendj package.
#
class puppet-opendj::package inherits puppet-opendj::params {

  group { 'opendj' :
    ensure  => present
  }

  user { 'opendj':
    ensure      => present,
    comment     => 'OpenDJ User',
    gid         => 'opendj',
    home        => '/opt/opendj',
    managehome  => true,
  }

  package { $java_version:
    ensure => present,
  }

  package { $opendj_package_name:
    ensure => present,
    require => Package[$java_version],
  }

}
