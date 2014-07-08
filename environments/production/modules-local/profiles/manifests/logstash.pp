# Class: profiles::logstash
#
#
class profiles::logstash {

  logstash::configfile { 'basic_config':
    source => 'puppet:///modules/profiles/logstash/basic_config',
    order  => 10
  }

  include kibana3

}
