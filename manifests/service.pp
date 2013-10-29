# = Class: dnsmasq::service
#
# This class is private to the dnsmasq implementation
#
class dnsmasq::service {
  service { $dnsmasq::params::service_name:
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
}
