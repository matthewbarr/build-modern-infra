# Class: moderninfra::mco::client
#
#
class moderninfra::mco::server {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }
  
  include moderninfra::mco::common
  class {'mcollective':
    connector          => 'rabbitmq',
    middleware_hosts   => [ $::moderninfra::rmqserver ],
    psk                => $::moderninfra::mco_password,
    middleware_ssl     => true,
    ssl_ca_cert        => 'file:///var/lib/puppet/ssl/certs/ca.pem',
    ssl_server_public  => "file:///var/lib/puppet/ssl/certs/${fqdn}.pem",
    ssl_server_private => "file:///var/lib/puppet/ssl/private_keys/${fqdn}.pem",
  }
}
