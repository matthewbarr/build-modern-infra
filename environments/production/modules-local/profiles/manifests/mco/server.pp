# Class: profiles::mco::client
#
#
class profiles::mco::server {
  include profiles::mco::common
  class {'mcollective':
    connector          => 'rabbitmq',
    middleware_hosts   => [ 'rabbitmq.aws.mbarr.net' ],
    middleware_ssl     => true,
    ssl_ca_cert        => '/var/lib/puppet/ssl/certs/ca.pem',
    ssl_server_public  => '/var/lib/puppet/ssl/certs/${::fqdn}.pem',
    ssl_server_private => '/var/lib/puppet/ssl/private_keys/${::fqdn}.pem',
  }
}
