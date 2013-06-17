# = Class: dnsmasq::server
#
# Configure dnsmasq as an authoritative and caching server.
#
class dnsmasq::server {
  include ::dnsmasq

  dnsmasq::conf { 'server_defaults':
    ensure => present,
    source => 'puppet:///modules/gds_dns/server/server_defaults.conf',
  }
}
