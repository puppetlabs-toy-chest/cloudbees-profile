class profile::jenkins_enterprise {
  include ::ruby
  include ::ruby::dev
  include ::jenkins
  include ::git

  package { 'gcc-c++':
    ensure => installed,
  }

  package { 'beaker':
    ensure   => installed,
    provider => gem,
  }

  package { 'puppetlabs_spec_helper':
    ensure   => installed,
    provider => gem,
  }

  package { 'rspec':
    ensure   => installed,
    provider => gem,
  }
}
