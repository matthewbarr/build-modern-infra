# Class: moderninfra::mco::plugins
#
#
class moderninfra::mco::common {
  mcollective::server::setting { 'plugin.rabbitmq.heartbeat_interval':
    value => '60';
  }
  mcollective::plugin {
  'puppet':
    package => true;
  'package':
    package => true;
  'service':
    package => true;
  }
}