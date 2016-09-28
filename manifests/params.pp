# Class for setting params.

class puppet-opendj::params {

  $opendj_version                 = undef
  $baseDN                         = 'dc=myexample,dc=com'
  $ldapPort                       = 389
  $adminConnectorPort             = 4444
  $replicationPort                = 8989
  $rootUserDN                     = "cn=Directory\\ Manager"
  $rootUserPassword               = "passwordfromhell"
  $adminPassword                  = "passwordfromheaven"
  $doNotStart                     = true
  $enableStartTLS                 = true
  $ldapsPort                      = 636
  $generateSelfSignedCertificate  = true
  $hostName                       = 'opendj.example.com'
  $usePkcs11Keystore              = undef
  $useJavaKeystore                = undef
  $useJCEKS                       = undef
  $usePkcs12keyStore              = undef
  $keyStorePassword               = undef
  $keyStorePasswordFile           = undef
  $certNickname                   = undef
  $acceptLicense                  = true
  $propertiesFilePath             = "/opt/opendj/opendj.puppet.properties"
  $noPropertiesFile               = false
  $setuptemplate                  = 'default_setup_opendj'
  $ldifFile                       = 'opendj-ldiff.ldiff'
  $opendjDir                      = "/opt/opendj/"
  $backup_mail_succ               = undef
  $backup_mail_err                = undef
  $opendj_master                  = undef

  $java_version                   = "jdk1.8.0_102"
  $opendj_package_name            = "opendj-3.0.0-1.noarch"

  $dsconfig_path                  = "/opt/opendj/bin/dsconfig"

}
