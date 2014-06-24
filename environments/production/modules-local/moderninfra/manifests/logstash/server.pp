# Class: moderninfra::logstash::server
#
#
class moderninfra::logstash::server {
  sensu::subscription { 'logstash':}


  # file {
  #   '/etc/logstash/ssl':
  #     ensure => directory,
  #     owner  => root ,
  #     group  => root;
  #   '/etc/logstash/ssl/logstash-forwarder.crt':
  #     ensure => file,
  #     owner  => root ,
  #     group  => root,
  #     mode   => '0644',
  #     source => 'puppet:///modules/moderninfra/logstash/logstash-forwarder.crt';
  #   '/etc/logstash/ssl/logstash-forwarder.key':
  #     ensure => file,
  #     owner  => root ,
  #     group  => root,
  #     mode   => '0644',
  #     source => 'puppet:///modules/moderninfra/logstash/logstash-forwarder.key';
  # }
  
  class { 'logstash':
    ensure       => 'present',
    java_install => true,
#    conffile     => { 'agent' => 'puppet:///modules/moderninfra/logstash/zulip' }
  }
  # package { 'kibana':
  #   ensure => installed,
  # }

  #
  # class { 'nginx':
  #   worker_processes => 4,
  #   server_tokens    => 'off',
  #   http_cfg_append  => {gzip_types => 'text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript'}
  # }

  # file {
  #   '/etc/nginx/conf.d/logstash.conf':
  #     ensure => file,
  #     owner  => root,
  #     group  => root,
  #     mode   => '0644',
  #     source => 'puppet:///modules/moderninfra/logstash/logstash.conf',
  #     notify => Service['nginx'] ;
  #
  #   '/var/www/kibana/config.js':
  #     ensure  => file,
  #     owner   => root,
  #     group   => root,
  #     mode    => '0644',
  #     source  => 'puppet:///modules/moderninfra/logstash/config.js',
  #     require => Package['kibana'];
  #
  #   '/etc/nginx/conf.d/kibana.htpasswd':
  #     ensure  => file,
  #     owner   => root,
  #     group   => root,
  #     mode    => '0644',
  #     content => 'mbarr:$apr1$d7SKeBvv$nZoN2txbRQNzT8nn6oY/x.',
  #     require => Class['nginx'] ;
  #   '/etc/nginx/conf.d/default.conf':
  #     ensure  =>  absent,
  #     notify  => Service['nginx'] ;
  # }

# Inputs
  # logstash::input::syslog { 'logstash-syslog':
  #   type => 'syslog',
  #   port => '5544',
  # }
  # logstash::input::lumberjack { 'logstash-lumberjack':
  #   type            => 'lumberjack',
  #   port            => '5005',
  #   ssl_certificate => '/etc/logstash/ssl/logstash-forwarder.crt',
  #   ssl_key         => '/etc/logstash/ssl/logstash-forwarder.key'
  # }


  # Filters
  # logstash::filter::grok { 'nginx':
  #   pattern => ["%{IPORHOST:remote_addr} - %{USERNAME:remote_user} \[%{HTTPDATE:time_local}\] %{QS:request} %{INT:status} %{INT:body_bytes_sent} %{QS:http_referer} %{QS:http_user_agent}"],
  # }
  # Outputs
  # logstash::output::elasticsearch { 'logstash-elasticsearch':
  #   host     => "127.0.0.1",
  #   embedded => false,
    # config => {
    #   'template_overwrite' => 'true'}
  }
  # class { 'moderninfra::elasticsearch':
  #   clusternodes=> '["logstash.aws.mbarr.net[9300-9400]","logstash-us-east-1c.aws.mbarr.net:9300","logstash-us-east-1d.aws.mbarr.net:9300"]'
  # }
}