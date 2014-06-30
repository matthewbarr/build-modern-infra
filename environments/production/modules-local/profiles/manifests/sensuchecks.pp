# Class: profiles::sensuchecks
#
#
class profiles::sensuchecks {
  sensu::check { 'check_ntp':
    command     => 'PATH=$PATH:/usr/lib/nagios/plugins check_ntp_time -H pool.ntp.org -w 20 -c 40',
    handlers    => 'default',
    subscribers => 'general',
    standalone  => false,
    custom      => { occurrences => 2 },
  }
  sensu::check { 'check_disk':
    command     => 'PATH=$PATH:/usr/lib/nagios/plugins check_disk -w 15% -c 5%  -m',
    handlers    => ['default','mail_eng'],
    subscribers => 'general',
    standalone  => false,
    custom      => { occurrences => 2 },
  }
  sensu::check { 'check_mem':
    command     => '/etc/sensu/plugins/check_mem.sh -w 90 -c 95',
    handlers    => ['mail_eng'],
    subscribers => 'general',
    standalone  => false,
    custom      => { occurrences => 2 },
  }
  sensu::check { 'check_cron':
    command     => '/etc/sensu/plugins/check-procs.rb -p cron -C 1 -c 10 -w 10 ',
    handlers    => 'default',
    subscribers => 'general',
    interval    => 60,
    standalone  => false,
    custom      => { occurrences => 2 },
  }

  # Webserver checks
  sensu::check { 'check_http_nginx':
    command     => 'PATH=$PATH:/usr/lib/nagios/plugins check_http -I localhost -H www.example.com -u /',
    handlers    => ['default'],
    subscribers => 'webserver',
    standalone  => false,
    custom      => { occurrences => 2 },
  }
}