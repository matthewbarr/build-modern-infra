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
    if $role == "mco" {
    class {'moderninfra::rmq':
      rmqhostname => "rabbitmq.aws.mbarr.net"
    }
    include moderninfra::mco::client
    include moderninfra::sensu::server
  }
  if $role == "puppet" {
    include moderninfra::mco::server
    include moderninfra::sensu::client
    
  }
  if $role == "logstash" {
    include moderninfra::mco::server
    include moderninfra::sensu::client
    include profiles::logstash
  }
  if $role == "jenkins" {
    include moderninfra::mco::server
    include moderninfra::sensu::client
    include jenkins
  }
}
