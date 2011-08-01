class dnsmasq::params {
    case $operatingsystem {
        /(Ubuntu|Debian)/: {
            $package_name = 'dnsmasq'
            $service_name = 'dnsmasq'
            $config_file = '/etc/dnsmasq.conf'
            $resolv_file = '/etc/resolv.conf.dnsmasq'
            $config_dir = '/etc/dnsmasq.d/'
        }
    }
}
