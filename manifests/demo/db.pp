class profile::demo::db (
  $install_dir = '/opt/wordpress',
  $db_user,
  $db_password
) {
  include ::mysql::server 
}
