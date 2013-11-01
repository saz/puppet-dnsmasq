# = Class: dnsmasq::resolvconf
#
# This class is private to the dnsmasq module.
#
class dnsmasq::resolvconf {
  include dnsmasq

  dnsmasq::conf {'use-resolvconf':
    content => "resolv-file=/var/run/dnsmasq/resolv.conf\n",
  }
}
