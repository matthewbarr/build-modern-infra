# Class: moderninfra::sensu::client
#
#
class moderninfra::sensu::client {
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
    rabbitmq_password        => 'meep',
#    rabbitmq_ssl_cert_chain  => '/etc/sensu/ssl/cert.pem',
#    rabbitmq_ssl_private_key => '/etc/sensu/ssl/key.pem',
    subscriptions            => 'mbarr',
    rabbitmq_port            => '5672',
    use_embedded_ruby        => true,
    rabbitmq_host            => 'rabbitmq.aws.mbarr.net'
    }

}
