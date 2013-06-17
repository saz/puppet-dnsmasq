class dnsmasq(
  $ignore_resolvconf = undef
) {
  include dnsmasq::params

  anchor { 'dnsmasq::start': }

  class { 'dnsmasq::install':
    require => Anchor['dnsmasq::start'],
  }

  class { 'dnsmasq::config':
    ignore_resolvconf => $ignore_resolvconf,
    require           => Class['dnsmasq::install'],
  }

  class { 'dnsmasq::service':
    subscribe => Class[
      'dnsmasq::install',
      'dnsmasq::config'
    ],
  }

  class { 'dnsmasq::reload':
    require => Class['dnsmasq::service'],
  }

  anchor { 'dnsmasq::end':
    require => Class['dnsmasq::service'],
  }
}
