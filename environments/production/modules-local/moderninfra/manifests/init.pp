# Class: moderninfra
#
#
#Mco clients are also a MCO server.
class moderninfra (
$rmqserver,
$logstash_server,
$rmq=false,
$mco_client=false,
$mco_server=false,
$sensu_client=false,
$sensu_server=false,
$logstash=false,
$logstash_forwarder=true,
$mco_password=undef,
$sensu_password=undef,
)
{ 
  if $rmq {
    include moderninfra::rmq
  }

  if $mco_client {
    include moderninfra::mco::client
  }

  if $mco_server {
    include moderninfra::mco::server
  }

  if $sensu_client {
    include moderninfra::sensu::client
  }

  if $sensu_server {
    include moderninfra::sensu::server
  }
  if $sensu_server {
    include moderninfra::sensu::server
  }
  if $logstash_forwarder {
    include moderninfra::logstash::server
  }
  if $logstash_forwarder {
    include moderninfra::logstash::forwarder
  }
}
