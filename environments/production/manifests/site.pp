# Default file attributes
File {
  ignore => [ '.svn', '.git', 'CVS', '.bzr' ],
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
} # File

# Default package attribute

Package {
  ensure => installed,
} # Package

# Default exec paths

Exec {
  path => ['/bin', '/sbin', '/usr/bin', '/usr/sbin' ],
} # Exec

node default {
  if $role == "puppet" {
    class {'mcollective':
      middleware       => true,
      client           => true,
      connector        => 'rabbitmq',
    }
#    include profile::sensu::server
  }
  if $role == "search" {
    include profile::elasticsearch
  }
  if $role == "logstash" {
    include profile::logstash
  }
}
