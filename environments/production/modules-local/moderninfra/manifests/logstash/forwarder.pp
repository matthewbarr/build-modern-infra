# Class: moderninfra/logstash::forwarder
#
#
class moderninfra::logstash::forwarder {

http://packages.elasticsearch.org/logstashforwarder/debian

  apt::source { 'logstashforwarder':
    location    => 'http://packages.elasticsearch.org/logstashforwarder/debian',
    repos       => 'main',
    release     => 'stable',
    include_src => false,
    key         => 'D88E42B4',
    key_server  => 'pgp.mit.edu',
  }

  package { 'logstash-forwarder':
    ensure => installed,
    } ->
  file {
   '/opt/logstash-forwarder/logstash-forwarder.crt':
      ensure => file,
      owner  => root ,
      group  => root,
      mode   => 0644,
      source => 'puppet:///modules/moderninfra/logstash/logstash-forwarder.crt';

    '/etc/logstash-forwarder.conf':
       ensure => file,
       owner  => root ,
       group  => root,
       mode   => 0644,
       content => template("${module_name}/logstash-forwarder.conf.erb"),;

     '/etc/init.d/logstash-forwarder':
        ensure => file,
        owner  => root ,
        group  => root,
        mode   => 0775,
        source => 'puppet:///modules/moderninfra/logstash/logstash-forwarder.initscript';
  } ~>
  service { "logstash-forwarder":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    # pattern    => 'logstash-forwarder',
  }
}