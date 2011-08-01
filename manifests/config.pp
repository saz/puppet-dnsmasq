class dnsmasq::config {
    file { $dnsmasq::params::config_file:
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => 644,
        source  => 'puppet:///modules/dnsmasq/dnsmasq.conf'
        require => Class['dnsmasq::install'],
        notify  => Class['dnsmasq::service'],
    }
}
