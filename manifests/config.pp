class dnsmasq::config {
  file { $dnsmasq::params::config_file:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/dnsmasq/dnsmasq.conf',
    require => Class['dnsmasq::install'],
    notify  => Class['dnsmasq::service'],
  }

  file { $dnsmasq::params::config_dir:
    ensure  => directory,
    recurse => true,
    purge   => true,
    force   => true,
    owner   => 'root',
    group   => 'root',
    require => Class['dnsmasq::install'],
    notify  => Class['dnsmasq::service'],
  }
}
