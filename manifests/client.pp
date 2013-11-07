# = Class: dnsmasq::client
#
# Configure dnsmasq to serve as a local forwarder/resolver on loopback.
#
class dnsmasq::client {
  include ::dnsmasq

  if defined(Class['dnsmasq::server']) {
    fail('dnsmasq::client and dnsmasq::server are mutually exclusive')
  }

  dnsmasq::conf { 'client_local':
    ensure => present,
    source => 'puppet:///modules/dnsmasq/client/client_local.conf',
  }
}
