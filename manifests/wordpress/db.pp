class profile::wordpress::db(
  $app_hosts   = $::profile::wordpress::app_hosts,
  $db_name     = $::profile::wordpress::db_name,
  $db_user     = $::profile::wordpress::db_user,
  $db_password = $::profile::wordpress::db_password
) {
  $app_hosts_real = $app_hosts[0]

  host { $app_hosts_real:
    ip => query_nodes('Class[profile::wordpress::app]', ipaddress_eth1)
  }

  class { '::wordpress::db':
    create_db      => true,
    create_db_user => true,
    db_name        => $db_name,
    db_user        => $db_user,
    db_host        => $app_hosts[0],
    db_password    => $db_password,
  }
}
