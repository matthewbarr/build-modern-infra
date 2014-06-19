# Class: profile::sensu
#
#
class profiles::sensu {
  package { 'redis-server':
    ensure => installed,
  }
}