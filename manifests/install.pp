class dnsmasq::install {
    package { $dnsmasq::params::package_name:
        ensure => present,
    }
}
