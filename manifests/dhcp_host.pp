# # Making life easier
define dnsmasq::dhcp_host (
  $ensure   = "present",
  $hostname = '',
  $mac,
  $ip       = '',
  $prio     = '99') {
  $h_real = $hostname ? {
    ''      => $name,
    default => $hostname,
  }
  $add_real = $ip ? {
    ''      => $h_real,
    default => "${h_real},${ip}",
  }

  dnsmasq::conf { "dhcp-host_${h_real}_${mac}":
    ensure  => $ensure,
    content => "dhcp-host=${mac},id:*,${add_real}\n",
    prio    => $prio,
    notify  => Exec['/usr/bin/pkill -HUP dnsmasq'],
  }
}
