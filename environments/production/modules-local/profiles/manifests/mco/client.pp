# Class: profiles::mco::client
#
#
class profiles::mco::client {
  include profiles::mco::common
  class {'mcollective':
    client             => true,
    connector          => 'rabbitmq',
    middleware_hosts   => [ 'rabbitmq.aws.mbarr.net' ],
    middleware_ssl     => true,
    ssl_ca_cert        => 'file:///var/lib/puppet/ssl/certs/ca.pem',
    ssl_server_public  => "file:///var/lib/puppet/ssl/certs/${fqdn}.pem",
    ssl_server_private => "file:///var/lib/puppet/ssl/private_keys/${fqdn}.pem",
  }
  mcollective::client::setting { 'plugin.rabbitmq.heartbeat_interval':
    value => '60',
  }
  mcollective::client::setting { "plugin.rabbitmq.pool.1.ssl.cert":
    value => '/etc/mcollective/server_public.pem',
  }

  mcollective::client::setting { "plugin.rabbitmq.pool.1.ssl.key":
    value => '/etc/mcollective/server_private.pem',
  }
}
