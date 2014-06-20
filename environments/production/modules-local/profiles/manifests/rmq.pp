# Class: profile::rmq
#
#
class profiles::rmq (
$rmqhostname=undef)
{
  class { '::rabbitmq':
    ssl                      => true,
    ssl_verify               => 'verify_peer',
    ssl_fail_if_no_peer_cert => true,
    ssl_cacert               => '/var/lib/puppet/ssl/certs/ca.pem',
    ssl_cert                 => "/var/lib/puppet/ssl/certs/$rmqhostname.pem",
    ssl_key                  => "/var/lib/puppet/ssl/private_keys/$rmqhostname.pem",
    stomp_port               => 61613,
    config_stomp             => true,
    ssl_stomp_port           => 61614,
    stomp_ensure             => true,
  } ->
  rabbitmq_vhost { '/sensu':
    ensure => present,
  }
  rabbitmq_user_permissions { 'guest@/sensu':
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
  }
  rabbitmq_user { 'sensu':
    admin    => true,
    password => 'meep',
  }
  rabbitmq_user_permissions { 'sensu@/sensu':
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
  }

  puppet_certificate { "$rmqhostname":
    ensure => present,
  }

}
