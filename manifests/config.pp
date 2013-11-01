# = Class: dnsmasq::config
#
# This class is private to the dnsmasq implementation
#
# == Parameters:
#
# [*upstream_servers*]
# An array of IP addresses of upstream nameservers to proxy.
class dnsmasq::config(
  $upstream_servers = []
) {
  file { $dnsmasq::params::config_file:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/dnsmasq/dnsmasq.conf',
  }

  file { $dnsmasq::params::config_dir:
    ensure  => directory,
    recurse => true,
    purge   => true,
    force   => true,
    owner   => 'root',
    group   => 'root',
  }
}
