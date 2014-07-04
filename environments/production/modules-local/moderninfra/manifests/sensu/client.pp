# Class: moderninfra::sensu::client
#
#
class moderninfra::sensu::client {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  exec { "apt-update":
      command => "/usr/bin/apt-get update"
  }
  Apt::Key['sensu']-> Apt::Source['sensu'] ->  Exec["apt-update"] -> Package['sensu']

  # file { '/etc/sensu/ssl/cert.pem':
  #   owner   => 'sensu',
  #   group   => 'sensu',
  #   mode   => '0444',
  #   source => "file:///var/lib/puppet/ssl/certs/${fqdn}.pem";
  # }
  #
  # file { '/etc/sensu/ssl/key.pem':
  #   owner   => 'sensu',
  #   group   => 'sensu',
  #   mode   => '0400',
  #   source => "file:///var/lib/puppet/ssl/private_keys/${fqdn}.pem";
  # }
  class { 'sensu':
    rabbitmq_password         => $::moderninfra::sensu_password,
#    rabbitmq_ssl_cert_chain  => '/etc/sensu/ssl/cert.pem',
#    rabbitmq_ssl_private_key => '/etc/sensu/ssl/key.pem',
    subscriptions             => 'general',
    rabbitmq_port             => '5672',
    use_embedded_ruby         => true,
    rabbitmq_host             => $::moderninfra::rmqserver,
    }

}
