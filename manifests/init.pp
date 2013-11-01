# = Class: dnsmasq
#
# Installs and manages dnsmasq
#
# == Parameters
#
# [*upstream_servers*]
#   An array of upstream DNS servers to proxy.
#   Default: undef
class dnsmasq (
  $upstream_servers = undef
  ) {
  include dnsmasq::params

  anchor { 'dnsmasq::start': }

  class { 'dnsmasq::install':
    require => Anchor['dnsmasq::start'],
  }

  class { 'dnsmasq::config':
    upstream_servers => $upstream_servers,
    require          => Class['dnsmasq::install'],
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
