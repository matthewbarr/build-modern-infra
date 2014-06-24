# Class: moderninfra::mco::client
#
#
class moderninfra::mco::server {
  include moderninfra::mco::common
  class {'mcollective':
    connector          => 'rabbitmq',
    middleware_hosts   => [ 'rabbitmq.aws.mbarr.net' ],
    middleware_ssl     => true,
    ssl_ca_cert        => 'file:///var/lib/puppet/ssl/certs/ca.pem',
    ssl_server_public  => "file:///var/lib/puppet/ssl/certs/${fqdn}.pem",
    ssl_server_private => "file:///var/lib/puppet/ssl/private_keys/${fqdn}.pem",
  }
}
