define dnsmasq::conf ($ensure = 'present',
    $prio = 10,
    $source = undef,
    $content = undef) {
    include dnsmasq file {
        "${dnsmasq::params::config_dir}${prio}-${name}" :
            ensure => $ensure,
            owner => root,
            group => root,
            content => $content,
            source => $source,
            require => Class['dnsmasq'],
            notify => Class['dnsmasq::service'],
    }
}

## Making life easier
define dnsmasq::dhcp-host ($ensure = "present",
    $hostname = "",
    $mac,
    $ip = "",
    $prio = 99) {
    $h_real = $hostname ? {
        "" => $name,
        default => $hostname,
    }
    $add_real = $ip ? {
        "" => $h_real,
        default => "${h_real},${ip}",
    }
    dnsmasq::conf {
        "dhcp-host_${h_real}" :
            ensure => $ensure,
            content => "dhcp-host=${mac},id:*,${add_real}\n",
            prio => $prio,
    }
}

