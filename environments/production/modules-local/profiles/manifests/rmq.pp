# Class: profile::rmq
#
#
class profiles::rmq (
$rmqhostname=undef,
)
{
  file { '/etc/rabbitmq/ssl/ca.pem':
    owner  => 'rabbitmq',
    group  => 'rabbitmq',
    mode   => '0444',
    source => 'file:///var/lib/puppet/ssl/certs/ca.pem';
  }
  
  file { '/etc/rabbitmq/ssl/server_public.pem':
    owner  => 'rabbitmq',
    group  => 'rabbitmq',
    mode   => '0444',
    source => "file:///var/lib/puppet/ssl/certs/$rmqhostname.pem";
  }
  
  file { '/etc/rabbitmq/ssl/server_private.pem':
    owner  => 'rabbitmq',
    group  => 'rabbitmq',
    mode   => '0444',
    source => "file:///var/lib/puppet/ssl/private_keys/$rmqhostname.pem";
  }
  
  class { '::rabbitmq':
    ssl                      => true,
    ssl_verify               => 'verify_peer',
    ssl_fail_if_no_peer_cert => true,
    ssl_cacert               => '/etc/rabbitmq/ssl/ca.pem',
    ssl_cert                 => '/etc/rabbitmq/ssl/server_public.pem',
    ssl_key                  => '/etc/rabbitmq/ssl/server_private.pem',
    stomp_port               => 61613,
    config_stomp             => true,
    ssl_stomp_port           => 61614,
    } ->
  rabbitmq_plugin { 'rabbitmq_stomp':
    ensure => present,
  } ->

  rabbitmq_vhost { '/mcollective':
    ensure => present,
  } ->

  rabbitmq_user { 'mcollective':
    ensure   => present,
    admin    => false,
    password => 'marionette',
  } ->

  rabbitmq_user { 'admin':
    ensure   => present,
    admin    => true,
    password => 'secret',
  } ->

  rabbitmq_user_permissions { "mcollective@/mcollective":
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
  } ->

  rabbitmq_user_permissions { "admin@/mcollective":
    configure_permission => '.*',
  } ->

  rabbitmq_exchange { "mcollective_broadcast@/mcollective":
    ensure   => present,
    type     => 'topic',
    user     => 'admin',
    password => 'secret',
  } ->

  rabbitmq_exchange { "mcollective_directed@/mcollective":
    ensure   => present,
    type     => 'direct',
    user     => 'admin',
    password => 'secret',
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
