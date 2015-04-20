class profile::demo::web (
  $install_dir = '/opt/wordpress',
  $db_user = hiera('wordpress::db_user'),
  $db_password = hiera('wordpress::db_password')
) {
  include ::mysql::client
  

  service { 'httpd':
    ensure => stopped,
    enable => false,
  }

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

  class { '::mysql::bindings::php':
    notify => Class['::nginx'],
  }

  class { '::wordpress':
    db_user        => $db_user,
    db_password    => $db_password,
    create_db      => true,
    create_db_user => true,
  }
}
