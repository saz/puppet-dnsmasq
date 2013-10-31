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

# register with resolvconf when we start and unregister when we stop
post-start exec echo 'nameserver 127.0.0.1' | /sbin/resolvconf -a lo.dnsmasq

pre-stop exec /sbin/resolvconf -d lo.dnsmasq

expect daemon

exec /usr/sbin/dnsmasq -r ${dnsmasq::params::resolv_file}
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
