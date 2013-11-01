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

  file { $dnsmasq::params::resolv_file:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => inline_template("
<% @upstream_servers.each do |server|%>
nameserver <%= server %>
<% end %>"),
  }

  file { $dnsmasq::params::config_dir:
    ensure  => directory,
    recurse => true,
    purge   => true,
    force   => true,
    owner   => 'root',
    group   => 'root',
  }

  dnsmasq::conf {'use-custom-resolv-conf':
    content => "resolv-file=${dnsmasq::params::resolv_file}\n",
  }
}
