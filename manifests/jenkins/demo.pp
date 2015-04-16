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
}
