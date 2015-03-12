class profile::wordpress::integrated(
  $install_dir = '/opt/wordpress',
  $db_user,
  $db_password
) {
  include ::mysql::client
  include ::mysql::server

  class { 'php':
    fpm => true,
  }

  class { 'nginx': }

  nginx::resource::vhost { $::fqdn:
    www_root    => $install_dir,
  }

  nginx::resource::location { "${::fqdn}_root":
    vhost       => $::fqdn,
    location    => "~ \.php$",
    index_files => ['index.php', 'index.html', 'index.htm'],
    www_root    => $install_dir,
    proxy       => undef,
    fastcgi     => "127.0.0.1:9000",
    fastcgi_script  => undef,
    location_cfg_append => {
      fastcgi_connect_timeout => '3m',
      fastcgi_read_timeout    => '3m',
      fastcgi_send_timeout    => '3m'
    }
  }

  class { '::mysql::bindings::php': }

  class { '::wordpress':
    db_user        => $db_user,
    db_password    => $db_password,
    create_db      => true,
    create_db_user => true,
  }
}