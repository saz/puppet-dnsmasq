class dnsmasq::install {
  package { $dnsmasq::params::package_name:
    ensure => $dnsmasq::package_ensure,
  }

  file { $dnsmasq::params::config_dir:
    ensure => 'directory',
  }
}
