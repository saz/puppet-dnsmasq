# = Class: dnsmasq::upstreams
#
# This class is private to the dnsmasq implementation
class dnsmasq::upstreams (
  $upstream_servers = []
  ) {
  include dnsmasq

  file {'/etc/resolv.conf.dnsmasq':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('dnsmasq/resolv-file.erb'),
  }

  dnsmasq::conf {'use-custom-resolv-conf':
    content => "resolv-file=/etc/resolv.conf.dnsmasq\n",
  }
}
