# = Class: dnsmasq::resolvconf
#
# Include this class to tell resolvconf to use the resolv.conf file
# generated for it by resolvconf.
#
# FIXME: only tested on ubuntu. Assumes that resolvconf will generate
# a file in /var/run/dnsmasq/resolv.conf
#
class dnsmasq::resolvconf {
  include dnsmasq

  dnsmasq::conf {'use-resolvconf-generated-config':
    content => "resolv-file=/var/run/dnsmasq/resolv.conf\n",
  }
}
