# = Class: dnsmasq
#
# Installs and manages dnsmasq
#
class dnsmasq(
  $upstream_servers => [],
) {
  include dnsmasq::params

  anchor { 'dnsmasq::start': }

  class { 'dnsmasq::install':
    require => Anchor['dnsmasq::start'],
  }

  class { 'dnsmasq::config':
    require          => Class['dnsmasq::install'],
    upstream_servers => $upstream_servers,
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
