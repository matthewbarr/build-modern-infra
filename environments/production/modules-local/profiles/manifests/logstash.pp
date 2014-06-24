# Class: profiles::logstash
#
#
class profiles::logstash {
  include moderninfra::logstash::server
  
  
  logstash::configfile { 'basic_config':
    source => 'puppet:///modules/profiles/logstash/basic_config',
    order  => 10
  }  

  class { 'elasticsearch':
    java_install  => true,
    manage_repo   => true,
    repo_version  => '1.1',
  }

# Inputs
  # logstash::input::syslog { 'logstash-syslog':
  #   type => 'syslog',
  #   port => '5544',
  # }

}