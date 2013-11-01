# = Class: dnsmasq::config
#
# This class is private to the dnsmasq implementation
class dnsmasq::config (
  $upstream_servers = undef,
  $use_resolvconf   = 'no'
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

  if $upstream_servers {
    validate_array($upstream_servers)
    class {'dnsmasq::upstreams': upstream_servers => $upstream_servers }
  }

  if str2bool($use_resolvconf) {
    include dnsmasq::resolvconf
  }
}
