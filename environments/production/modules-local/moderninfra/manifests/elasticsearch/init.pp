class moderninfra::elasticsearch ($clusternodes=undef){
  sensu::subscription { 'elasticsearch':}

  if $clusternodes
  { $config_hash={
      'discovery.zen.ping.unicast.hosts' => $clusternodes
    }
  }
  else
  { $config_hash={
      'node.name' => $fqdn
    }
  }

  class { 'elasticsearch':
    java_install  => true,
    manage_repo   => true,
    repo_version  => '1.1',
    config        => $config_hash,
    # init_defaults => {
    #   'ES_HEAP_SIZE' => '2G'
    # },
  }


  elasticsearch::plugin{'mobz/elasticsearch-head':
    module_dir => 'head'
  }

}