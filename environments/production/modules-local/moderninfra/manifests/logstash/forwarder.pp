# Class: moderninfra/logstash::forwarder
#
#
class moderninfra::logstash::forwarder {
  require kenshorepo
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