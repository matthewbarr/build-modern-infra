# Class: profile::sensu
#
#
class profiles::sensu::server {
  package { 'redis-server':
    ensure => installed,
  }
  
  class { 'sensu':
    rabbitmq_password        => 'meep',
    server                   => true,
    dashboard                => true,
    api                      => true,
    use_embedded_ruby        => true,
    rabbitmq_port            => '5671',
    rabbitmq_ssl_cert_chain  => "file:///var/lib/puppet/ssl/certs/${fqdn}.pem",
    rabbitmq_ssl_private_key => "file:///var/lib/puppet/ssl/private_keys/${fqdn}.pem",
    subscriptions            => 'mbarr',
  }

  # sensu::handler { 'default':
  #   command                       => '/etc/sensu/handlers/mailer.rb',
  #   source                        => 'puppet:///modules/profiles/sensu/handlers/mailer.rb',
  #   severities                    => ['warning', 'critical', 'unknown'],
  #   config                        => {
  #     'mail_from'                 => 'sensu@mbarr.net',
  #     'mail_to'                   => 'mbarr@mbarr.net',
  #     'smtp_address'              => 'email-smtp.us-east-1.amazonaws.com',
  #     'smtp_port'                 => '587',
  #     'smtp_domain'               => 'mbarr.net',
  #     'smtp_username'             => 'MEEEPE',
  #     'smtp_password'             => 'ABC',
  #     'smtp_enable_starttls_auto' => true
  #   }
  # }

#  class {'profiles::sensu::checks':}
#  class {'profiles::sensu::plugins':}
  
}