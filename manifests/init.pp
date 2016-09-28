# == Class: puppet-opendj
#
# puppet-opendj puppet hiera module.
#
# === Examples
#
#  include puppet-opendj
#  or
#  class { 'puppet-opendj': }
#
class puppet-opendj inherits puppet-opendj::params { 

  if ($opendj_package_name == undef) {
    fail('Cannot leave opendj version undefined.')
  }

  anchor { 'puppet-opendj::start': } ->
  class { 'puppet-opendj::package': } ->
  class { 'puppet-opendj::config': } ~>
  class { 'puppet-opendj::service': } ->
  class { 'puppet-opendj::replication': }
  anchor { 'puppet-opendj::end': }

}
