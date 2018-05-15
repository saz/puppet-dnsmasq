class dnsmasq::params {
  case $::osfamily {
    'Debian': {
      $package_name  = 'dnsmasq'
      $service_name  = 'dnsmasq'
      $config_file   = '/etc/dnsmasq.conf'
      $resolv_file   = '/etc/resolv.conf.dnsmasq'
      $defaults_file = '/etc/default/dnsmasq'
      $config_dir    = '/etc/dnsmasq.d/'
    }
    'RedHat': {
      $package_name  = 'dnsmasq'
      $service_name  = 'dnsmasq'
      $config_file   = '/etc/dnsmasq.conf'
      $resolv_file   = '/etc/resolv.conf.dnsmasq'
      $defaults_file = '/etc/sysconfig/dnsmasq'
      $config_dir    = '/etc/dnsmasq.d/'
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
