class profile::wordpress(
  $app_hosts = query_nodes('Class[profile::wordpress::app]', fqdn),
  $db_host   = query_nodes('Class[profile::wordpress::db]', fqdn),
  $db_name,
  $db_user,
  $db_password
) {

  package { 'wget':
    ensure => latest,
  }
}
