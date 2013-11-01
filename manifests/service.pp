# = Class: dnsmasq::service
#
# This class is private to the dnsmasq implementation
#
class dnsmasq::service {
  if $::osfamily == 'Debian' {
    file { "/etc/init/${dnsmasq::params::service_name}.conf":
      content => "
description 'dnsmasq - a dns caching proxy'

start on runlevel [2345]
stop on runlevel [!2345]

respawn

# If the app respawns more than 5 times in 20 seconds, it has deeper problems
# and should be killed off.
respawn limit 5 20

expect daemon

exec /usr/sbin/dnsmasq
",
      before => Service[$dnsmasq::params::service_name],
    }
  }
  service { $dnsmasq::params::service_name:
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
}
