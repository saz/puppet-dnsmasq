# @summary Manage static host entries in `/etc/hosts` and `/etc/ethers`
#
# This defined type adds or removes an entry in `/etc/hosts` (and optionally
# `/etc/ethers`) to allow dnsmasq to provide consistent DNS and DHCP responses
# for a given hostname and IP.
#
# The define supports optional MAC address binding via `/etc/ethers`, which can
# be used by dnsmasq when integrated with DHCP or BOOTP services.
#
# @example Define a host with IP, custom hostname, and DNS aliases
#   dnsmasq::host { 'db-primary':
#     ip       => '192.168.1.50',
#     hostname => 'db01.example.com',
#     aliases  => 'db-primary db-master',
#   }
#
# @example Define a host with both IP and MAC address (for DHCP/DNS integration)
#   dnsmasq::host { 'printer':
#     ip       => '192.168.1.75',
#     hostname => 'printer.local',
#     mac      => '00:1A:2B:3C:4D:5E',
#   }
#
# @param aliases
#   Optional space-separated list of additional DNS names for this host.
# @param ensure
#   Whether the host entry should be 'present' or 'absent'.
# @param hostname
#   Optional hostname; if not provided, defaults to the resource title.
# @param ip
#   IP address associated with the host. Required.
# @param mac
#   Optional MAC address for use in `/etc/ethers`.
define dnsmasq::host (
  Stdlib::IP::Address::Nosubnet        $ip,
  Stdlib::FQDN                         $hostname = $name,
  Variant[String[1], Array[String[1]]] $aliases  = [],
  Optional[Stdlib::MAC]                $mac      = undef,
  Enum['present', 'absent']            $ensure   = 'present',
) {
  include dnsmasq::reload

  if $mac {
    @@file_line { "dnsmasq::ethers ${hostname} ${mac.upcase}":
      ensure => $ensure,
      path   => '/etc/ethers',
      line   => "${mac.upcase} ${ip}",
      tag    => 'dnsmasq-host',
      notify => Class['dnsmasq::reload'],
    }
  }

  $line_entries = [
    $ip,
    $hostname,
  ] + Array($aliases, true)

  @@file_line { "dnsmasq::hosts ${hostname} ${ip}":
    ensure => $ensure,
    path   => '/etc/hosts',
    line   => $line_entries.join(' '),
    tag    => 'dnsmasq-host',
    notify => Class['dnsmasq::reload'],
  }
}
