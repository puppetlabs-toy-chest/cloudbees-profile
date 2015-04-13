class profile::jenkins_enterprise {
  include ::jenkins
  include ::git

  jenkins::job { 'puppet-site':
    config => template('profile/puppet-site.xml.erb'),
  }

  jenkins::job { 'profile-module':
    config => template('profile/profile-module.xml.erb'),
  }

  jenkins::credentials { 'peadmin':
    password            => '',
    private_key_or_path => '/var/lib/jenkins/.ssh/peadmin_private_key',
    require             => File['peadmin key'],
  }

  file { 'peadmin key':
    content => template('profile/jenkins_pe_master_private_key'),
    path    => '/var/lib/jenkins/.ssh/peadmin_private_key',
    ensure  => file,
    owner   => jenkins,
    group   => jenkins,
    mode    => 0600,
  }
}
