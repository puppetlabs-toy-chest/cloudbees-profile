# this is the offline class, it gets applied to all agents
# and ensures they are able to work with local on networks
class profile::repos (
  $offline = 'false',
) {
  include stdlib::stages

  case "$::osfamily $::operatingsystemmajrelease" {
    "RedHat 6": {
      class { '::profile::se_repo':
      stage => 'setup',
      }
      if $offline == 'true' {
        class { '::profile::el6_repo_disabled':
        stage => 'setup',
        }
      }
    }
  }
}
