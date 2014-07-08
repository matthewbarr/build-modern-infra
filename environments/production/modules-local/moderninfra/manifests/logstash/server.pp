# Class: moderninfra::logstash::server
#
#
class moderninfra::logstash::server {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  sensu::subscription { 'logstash':}

  class { '::elasticsearch':
    java_install => true,
    manage_repo  => true,
    repo_version => '1.1',
    status       => 'running'
  } ~>

  exec { 'start_elasticsearch':
    command     => "/usr/sbin/service elasticsearch start",
    refreshonly => true,
  }

  file {
    '/etc/logstash/ssl':
      ensure => directory,
      owner  => root ,
      group  => root;
    '/etc/logstash/ssl/cert.pem':
      ensure => file,
      owner  => logstash ,
      group  => logstash,
      mode   => '0444',
    source   => "file:///var/lib/puppet/ssl/certs/${fqdn}.pem";
    '/etc/logstash/ssl/key.pem':
      ensure => file,
      owner  => logstash ,
      group  => logstash,
      mode   => '0400',
    source   => "file:///var/lib/puppet/ssl/private_keys/${fqdn}.pem";
  }
  
  class { 'logstash':
    ensure       => 'present',
    java_install => true,
    manage_repo  => true,
    repo_version => '1.4'
  }
}
