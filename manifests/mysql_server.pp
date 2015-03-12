class profile::mysql_server(
  $root_password,
  $override_options = {},
) {
  
  class { 'mysql::server':
    root_password    => $root_password,
    override_options => $override_options,
  }

  firewall { '9001 accept mysql':
    ensure     => 'present',
    action     => 'accept',
    chain      => 'INPUT',
    dport      => ['3306'],
    isfragment => 'false',
    proto      => 'tcp',
  }
}
