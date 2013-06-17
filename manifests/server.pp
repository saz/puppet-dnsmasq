# = Class: dnsmasq::server
#
# Configure dnsmasq as an authoritative and caching server.
#
# == Parameters:
#
# [*hosts*]
#   A multi-line string of hosts(5) entries which will be passed to
#   dnsmasq's `addn-hosts` option.
#   Default: ''
#
# [*cnames*]
#   A hash of `{source => destination}` addresses to create CNAME records
#   from.
#   Default: {}
#
# [*aliases*]
#   A hash of `{source => destination}` addresses to create split-horizon
#   views of external IP addresses.
#   Default: {}
#
class dnsmasq::server(
  $hosts = '',
  $cnames = {},
  $aliases = {}
) {
  include ::dnsmasq

  validate_hash($cnames)
  validate_hash($aliases)

  dnsmasq::conf { 'server_defaults':
    ensure => present,
    source => 'puppet:///modules/dnsmasq/server/server_defaults.conf',
  }

  file { '/etc/hosts.dnsmasq':
    ensure  => present,
    content => $hosts,
    notify  => Class['dnsmasq::reload'],
  }

  dnsmasq::conf { 'server_hosts':
    ensure  => present,
    content => template('dnsmasq/server/server_hosts.conf.erb'),
    require => File['/etc/hosts.dnsmasq'],
  }
}
