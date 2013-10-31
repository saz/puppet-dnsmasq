# = Class: dnsmasq::config
#
# This class is private to the dnsmasq implementation
#
# == Parameters:
#
class dnsmasq::config(
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
    content => '
    nameserver 8.8.8.8
    nameserver 8.8.4.4
    ',
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
