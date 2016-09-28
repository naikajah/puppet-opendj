# == Class: puppet-opendj Config
#
# puppet-opendj configuration.
#
class puppet-opendj::config inherits puppet-opendj::params {

  file { '/opt/opendj':
    ensure  => directory,
    owner   => 'opendj',
    group   => 'opendj',
    require => [User['opendj'], Package[$opendj_package_name]],
   }

    if $ldifFile {
      file { "$ldifFile":
        ensure  => present,
        path    => "$opendjDir$ldifFile",
        owner   => root,
        group   => root,
        mode    => '0444',
        source  => "puppet:///modules/puppet-opendj/$ldifFile",
        before  => File['opendj.puppet.properties'],
      }
    }
 

    # build OpenDJ properties file to aide installation 
    file { "opendj.puppet.properties":
      path    => "/opt/opendj/opendj.puppet.properties",
      owner   => 'root',
      group   => 'root',
      mode    => '0544',
      content => template("puppet-opendj/default_properties_file.erb"),
    }

    # build a script to execute the setup of opendj
    file { "opendj_setup.sh":
      path    => "/opt/opendj/opendj_setup.sh",
      owner   => 'root',
      group   => 'root',
      mode    => '0744',
      content => template("puppet-opendj/default_setup_opendj.erb"),
      require => File['opendj.puppet.properties'],
      before  => Exec['run_opendj_setup'],
    }

    # run the opendj_setup.sh script that contains our arguments
    exec {'run_opendj_setup':
      onlyif => "/usr/bin/test ! -f /opt/opendj/installed.txt",
      cwd => '/opt/opendj',
      command => '/opt/opendj/opendj_setup.sh',
      require => File['opendj_setup.sh'],
    }

    exec {'installed':
      onlyif => "/usr/bin/test ! -f /opt/opendj/installed.txt",
      cwd => '/opt/opendj',
      command => '/usr/bin/touch /opt/opendj/installed.txt',
      require => Exec['run_opendj_setup'],
    } 
    
   file { '/opt/opendj/bak':
     ensure => directory,
     owner  => 'opendj',
     group  => 'opendj',
   }

}
