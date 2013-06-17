# = Class: dnsmasq::client
#
# Configure dnsmasq to serve as a local forwarder/resolver on loopback.
#
class dnsmasq::client {
  include ::dnsmasq

  dnsmasq::conf { 'client_local':
    ensure => present,
    source => 'puppet:///modules/dnsmasq/client/client_local.conf',
  }
}
