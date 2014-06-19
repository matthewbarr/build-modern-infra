# Class: profiles::mco::client
#
#
class profiles::mco::client {
  class {'mcollective':
    client           => true,
    connector        => 'rabbitmq',
  }
}