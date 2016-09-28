# == Class: puppet-opendj Replication setup
#
# puppet-opendj Replication Setup
#
class puppet-opendj::replication inherits puppet-opendj::params {

  $dsreplication = "/opt/opendj/bin/dsreplication --adminUID ${rootUserDN} --adminPassword ${rootUserPassword} -X -n"

  if ($opendj_master  != undef and $hostName != $opendj_master) {

    exec { 'enable replication':
      require => Service['opendj'],
      command => "/bin/su opendj -s /bin/bash -c \"$dsreplication enable \
        --host1 ${opendj_master} --port1 ${adminConnectorPort} \
        --replicationPort1 ${replicationPort} \
        --bindDN1 '${rootUserDN}' --bindPassword1 ${rootUserPassword} \
        --host2 ${hostName} --port2 ${adminConnectorPort} \
        --replicationPort2 ${replicationPortt} \
        --bindDN2 '${rootUserDN}' --bindPassword2 ${rootUserPassword} \
        --baseDN '${baseDN}'\"",
      unless  => "/bin/su ${user} -s /bin/bash -c \"$dsreplication \
        status | grep ${hostName} | cut -d : -f 5 | grep true\"",
    } ->

    exec { 'initialize replication':
      command     => "/bin/su ${user} -s /bin/bash -c \"$dsreplication initialize \
        -h ${opendj_master} -p ${adminConnectorPort} -O ${hostName} --baseDN ${baseDN}\"",
      require     => Exec['enable replication'],
      refreshonly => true,
    }

  }


}
