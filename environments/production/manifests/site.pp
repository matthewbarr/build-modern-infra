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
    class {'moderninfra':
      rmq          => true,
      mco_client   => true,
      sensu_server => true,
    }
    include profiles::sensuchecks 
  }

  if $role == "puppet" {
    class {'moderninfra':
      mco_server   => true,
      sensu_client => true,
    }
  }

  if $role == "logstash" {
    class {'moderninfra':
      logstash     => true,
      mco_server   => true,
      sensu_client => true,
    }
    include profiles::logstash
  }

  if $role == "jenkins" {
    class {'moderninfra':
      mco_server   => true,
      sensu_client => true,
    }
    include jenkins
  }
}
