# == Class: puppet-opendj Service
#
# puppet-opendj service.
#
class puppet-opendj::service {

  service { 'opendj':
    ensure      => running,
    enable      => true,
    hasstatus   => false,
    provider    => base,
    binary      => '/opt/opendj/bin/start-ds',
    start       => '/opt/opendj/bin/start-ds',
    stop        => '/opt/opendj/bin/stop-ds',
    pattern      => 'start-ds',
  }  

}
