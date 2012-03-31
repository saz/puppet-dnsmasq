class dnsmasq::config {
    file {
        $dnsmasq::params::config_file :
            ensure => file,
            owner => root,
            group => root,
            mode => 644,
            source => 'puppet:///modules/dnsmasq/dnsmasq.conf',
            require => Class['dnsmasq::install'],
            notify => Class['dnsmasq::service'],
    }
    file {
        $dnsmasq::params::config_dir :
            ensure => directory,
            recurse => true,
            purge => true,
            force => true,
            owner => root,
            group => root,
            require => Class['dnsmasq::install'],
            notify => Class['dnsmasq::service'],
    }
}
define dnsmasq::dhcp-host ($ensure = "present",
    $hostname = "",
    $mac,
    $ip = "") {
    $h_real = $hostname ? {
        "" => $name,
        default => $name,
    }
    $add_real = $ip ? {
        "" => $h_real,
        default => "${h_real},${ip}",
    }
    dnsmasq::config {
        "dhcp-host_${name}" :
            ensure => $ensure,
            content => "dhcp-host=${mac},${add_real}\n",
    }
}
