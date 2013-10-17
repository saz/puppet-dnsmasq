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
    $mac_r = inline_template('<%= mac.upcase! %>')
    debug("DNSMASQ: ${h_real} ${ip} ${mac_r}")

    @@common::line { "dnsmasq::ethers ${h_real} ${mac_r}":
      file   => "/etc/ethers",
      line   => "${mac_r} ${ip}",
      ensure => $mac ? {
        ''      => 'absent',
        default => $ensure,
      },
      notify => Class['dnsmasq::reload'],
      tag    => 'dnsmasq-host',
    }
  }
  $al_add = $aliases ? {
    undef   => '',
    default => " ${aliases}",
  }

  @@common::line { "dnsmasq::hosts ${h_real} ${ip}":
    file   => "/etc/hosts",
    line   => "${ip} ${h_real}${al_add}",
    ensure => $ip ? {
      ''      => 'absent',
      default => $ensure,
    },
    notify => Class['dnsmasq::reload'],
    tag    => 'dnsmasq-host',
  }
}
