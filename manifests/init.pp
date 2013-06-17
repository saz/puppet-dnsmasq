class dnsmasq {
  include dnsmasq::params

  anchor { 'dnsmasq::start': }

  class { 'dnsmasq::install':
    require => Anchor['dnsmasq::start'],
  }

  class { 'dnsmasq::config':
    require => Class['dnsmasq::install'],
  }

  class { 'dnsmasq::service':
    subscribe => Class[
      'dnsmasq::install',
      'dnsmasq::config'
    ],
  }

  anchor { 'dnsmasq::end':
    require => Class['dnsmasq::service'],
  }
}
