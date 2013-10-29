# = Class: dnsmasq::install
#
# This class is private to the dnsmasq implementation
#
class dnsmasq::install {
  package { $dnsmasq::params::package_name:
    ensure => installed,
  }
}
