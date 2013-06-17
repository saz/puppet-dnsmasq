# = Class: dnsmasq::config
#
#
# == Parameters:
#
# [*ignore_resolvconf*]
#   Tell dnsmasq to ignore resolvconf and just read `/etc/resolv.conf`. Only
#   valid for Debian-alike systems.
#   Default: false
#
class dnsmasq::config(
  $ignore_resolvconf = false
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

  if $::osfamily == 'Debian' {
    file { $dnsmasq::params::sysv_default:
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('dnsmasq/etc/default/dnsmasq.erb'),
    }
  }
}
