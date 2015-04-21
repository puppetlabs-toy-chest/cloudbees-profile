class profile::jenkins::demo {
  include ::jenkins
  include ::git

  jenkins::plugin { 'swarm': }

  jenkins::job { 'puppet-site':
    config => template('profile/puppet-site.xml.erb'),
  }

  jenkins::job { 'profile-module':
    config => template('profile/profile-module.xml.erb'),
  }

  package { 'rspec':
    ensure   => installed,
    provider => pe_gem,
  }

  user { 'jenkins':
    shell => '/bin/bash',
  }

  file { '/var/lib/jenkins/.ssh/config':
    owner  => 'jenkins',
    group  => 'jenkins',
    mode   => 0644,
    source => 'puppet:///modules/profile/jenkins_ssh_config',
  }
}
