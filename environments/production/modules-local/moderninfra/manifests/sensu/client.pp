# Class: moderninfra::sensu::client
#
#
class moderninfra::sensu::client {
  class { 'sensu':
    rabbitmq_password        => 'meep',
    rabbitmq_ssl_cert_chain  => 'puppet:///modules/kenshosensu/client/cert.pem',
    rabbitmq_ssl_private_key => 'puppet:///modules/kenshosensu/client/key.pem',
    subscriptions            => 'kensho',
    rabbitmq_port            => '5671',
    use_embedded_ruby        => true,
    rabbitmq_host            => 'rabbitmq.aws.mbarr.net'
    }
}
