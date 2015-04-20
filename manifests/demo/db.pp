class profile::demo::db (
  $install_dir = '/opt/wordpress',
  $db_user = hiera('wordpress::db_user'),
  $db_password = hiera('wordpress::db_password')
) {
  include ::mysql::server 
}
