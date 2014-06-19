# Class: profile::sensu
#
#
class profile::sensu {
  package { 'redis-server':
    ensure => installed,
  }
}