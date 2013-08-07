class dnsmasq::params {
  case $::osfamily {
    debian: {
      $package_name = 'dnsmasq'
      $service_name = 'dnsmasq'
      $config_file = '/etc/dnsmasq.conf'
      $resolv_file = '/etc/resolv.conf.dnsmasq'
      $config_dir = '/etc/dnsmasq.d/'
    }
    redhat: {
      $package_name = 'dnsmasq'
      $service_name = 'dnsmasq'
      $config_file = '/etc/dnsmasq.conf'
      $resolv_file = '/etc/resolv.conf.dnsmasq'
      $config_dir = '/etc/dnsmasq.d/'
    }
    default: {
      case $::operatingsystem {
        default: {
          fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
        }
      }
    }
  }
}
