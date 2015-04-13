class profile::pe_env {

  file { '/root/.bashrc':
    ensure => 'file',
    owner  => '0',
    group  => '0',
    mode   => '644',
  }

  file_line { 'root_puppet_path':
    ensure  => present,
    line    => 'PATH=/opt/puppet/bin:$PATH; export PATH',
    path    => '/root/.bashrc',
    require => File['/root/.bashrc'],
  }

  ssh_authorized_key { 'jenkins':
    user => peadmin,
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAu3RZXs1BIcrvstiSYSAes7CkWGtah8gePgoxd85jp/5kdOU/oVvVPyFfXMJb0iWcHgLV6LNOaxQ5YyIOvBP3W1zQgy1K/IVB3WEcTFzGgHloXR5b2tPMvbtGvVRZ3V/62ZXi1w7q9iQzNb+mATvBWaXm+7cmd9sWuXVRRaFrcKVhfFPaO96D1C0JQIx1TXSAP1tUIxAB8NyulRObUL0ngbi3+fYuEvYXPwzk/0up2Lf7qjMpyASDkcAsih90CgPj2cOLwxMyQiT5GHJ/iqTrTXRj49HE4UYOjFlIWX04LMjTwi/Tu3dHTm03z30AJd9HBGHmHsVKuOMUvoaULOOYwQ== peadmin@master.inf.puppetlabs.demo',
  }
}
