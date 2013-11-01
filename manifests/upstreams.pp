# = Class: dnsmasq::upstreams
#
# Configures dnsmasq to use a static list of upstream DNS servers
#
# == Parameters:
#
# [*upstream_servers*]
# An array of IP addresses of upstream nameservers to proxy.
class dnsmasq::upstreams (
  $upstream_servers = []
  ) {
  include dnsmasq::params
  file {$dnsmasq::params::resolv_file:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('dnsmasq/resolv-file.erb'),
  }
}
