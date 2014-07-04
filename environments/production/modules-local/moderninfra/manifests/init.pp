# Class: moderninfra
#
#
#Mco clients are also a MCO server.
class moderninfra (
$rmqserver,
$rmq=false,
$mco_client=false,
$mco_server=false,
$sensu_client=false,
$sensu_server=false,
$mco_password=undef,
$sensu_password=undef,
)
{
  exec { "apt-update":
      command => "/usr/bin/apt-get update"
  }

  Apt::Key <| |> -> Apt::Source <| |> -> Exec["apt-update"] -> Package <| |>
  
  
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

}
