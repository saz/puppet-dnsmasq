class dnsmasq::install {
  package { $dnsmasq::params::package_name: ensure => 'installed', }

  if $dnsmasq::params::purge {
    file { $dnsmasq::params::config_dir:
      ensure  => 'directory',
      recurse => true,
      purge   => true,
      force   => true,
    }
  } else {
    file { $dnsmasq::params::config_dir:
      ensure => 'directory',
    }
  }
}

