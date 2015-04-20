class profile::pe_master {
  class { 'sudo':
    secure_path => '/opt/puppet/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  }

  class { '::jenkins::slave':
    masterurl         => 'http://jenkins.inf.puppetlabs.demo:8080',
    labels            => 'mco r10k',
    slave_home        => '/var/lib/peadmin',
    slave_user        => peadmin,
    manage_slave_user => false,
    executors         => 1,
    slave_name        => 'pe_master',
  }

  sudo::rule { "mco_rule":
    ensure => present,
    who    => 'peadmin',
    runas  => 'root',
    commands => '/opt/puppet/bin/r10k deploy environment -p *',
    nopass   => true,
    comment  => 'Allow peadmin to deploy environments',
  }

  sudo::rule { "vagrant":
    ensure   => present,
    who      => 'vagrant',
    runas    => 'ALL',
    commands => 'ALL'
    nopass   => true,
  }
}
