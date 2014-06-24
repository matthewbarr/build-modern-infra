# Class: profiles::logstash
#
#
class profiles::logstash {
  include moderninfra::logstash::server
  include moderninfra::elasticsearch
  
  
  logstash::configfile { 'basic_config':
    source => 'puppet:///profiles/logstash/basic_config',
    order  => 10
  }  

# Inputs
  # logstash::input::syslog { 'logstash-syslog':
  #   type => 'syslog',
  #   port => '5544',
  # }

}