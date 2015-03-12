class profile::wordpress::app(
  $db_host              = $::profile::wordpress::db_host,
  $db_name              = $::profile::wordpress::db_name,
  $db_user              = $::profile::wordpress::db_user,
  $db_password          = $::profile::wordpress::db_password,
  $install_dir          = '/opt/wordpress',
  $install_url          = 'http://wordpress.org',
  $version              = '3.8',
  $wp_owner             = 'root',
  $wp_group             = '0',
  $wp_lang              = '',
  $wp_config_content    = undef,
  $wp_plugin_dir        = 'DEFAULT',
  $wp_additional_config = 'DEFAULT',
  $wp_table_prefix      = 'wp_',
  $wp_proxy_host        = '',
  $wp_proxy_port        = '',
  $wp_multisite         = false,
  $wp_site_domain       = '',
  $wp_debug             = false,
  $wp_debug_log         = false,
  $wp_debug_display     = false
) {

  $db_host_real = $db_host[0]

  host { $db_host_real:
    ip   => query_nodes('Class[profile::wordpress::db]', ipaddress_eth1)
  }

  class { 'apache':
    default_vhost => false,
  }

  apache::vhost { $::fqdn:
    docroot => $install_dir,
    port    => 80,
  }

  apache::listen { '80': }

  class {'::apache::mod::php': }

  class { '::mysql::bindings::php': 
    notify => Class['::apache'],
  }

  class { '::wordpress::app':
    install_dir          => $install_dir,
    install_url          => $install_url,
    version              => $version,
    db_name              => $db_name,
    db_host              => $db_host_real,
    db_user              => $db_user,
    db_password          => $db_password,
    wp_owner             => $wp_owner,
    wp_group             => $wp_group,
    wp_lang              => $wp_lang,
    wp_config_content    => $wp_config_content,
    wp_plugin_dir        => $wp_plugin_dir,
    wp_additional_config => $wp_additional_config,
    wp_table_prefix      => $wp_table_prefix,
    wp_proxy_host        => $wp_proxy_host,
    wp_proxy_port        => $wp_proxy_port,
    wp_multisite         => $wp_multisite,
    wp_site_domain       => $wp_site_domain,
    wp_debug             => $wp_debug,
    wp_debug_log         => $wp_debug_log,
    wp_debug_display     => $wp_debug_display,
  }

  class { 'mysql::client': 
    before => Class['::wordpress::app'],
    notify => Class['::apache'],
  }
}
