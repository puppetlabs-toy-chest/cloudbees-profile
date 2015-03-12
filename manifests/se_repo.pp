class profile::se_repo {
  yumrepo { 'se-repo':
    baseurl  => "http://${::servername}/rpms",
    descr    => 'SE Cached Files',
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
  }
}
