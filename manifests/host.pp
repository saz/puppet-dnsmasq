define dnsmasq::host (
  $ensure   = "present",
  $hostname = undef,
  $aliases  = undef,
  $mac      = false,
  $ip) {
  $h_real = $hostname ? {
    undef   => $name,
    default => $hostname,
  }

  if $mac != false {
    @@common::line { "dnsmasq::ethers ${h_real}":
      file   => "/etc/ethers",
      line   => "${mac} ${ip}",
      ensure => $ensure,
      notify => Class['dnsmasq::reload'],
      tag    => 'dnsmasq-host',
    }
  }
  $al_add = $aliases ? {
    undef   => '',
    default => " ${aliases}",
  }

  @@common::line { "dnsmasq::hosts ${h_real}":
    file   => "/etc/hosts",
    line   => "${ip} ${h_real}${al_add}",
    ensure => $ensure,
    notify => Class['dnsmasq::reload'],
    tag    => 'dnsmasq-host',
  }
}
