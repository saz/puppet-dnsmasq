# = Class: dnsmasq::params
#
# This class is private to the dnsmasq implementation
#
class dnsmasq::params {
  case $::osfamily {
    debian: {
      $package_name = 'dnsmasq'
      $service_name = 'dnsmasq'
      $config_file = '/etc/dnsmasq.conf'
      $config_dir = '/etc/dnsmasq.d/'
      $sysv_default = '/etc/default/dnsmasq'
    }
    redhat: {
      $package_name = 'dnsmasq'
      $service_name = 'dnsmasq'
      $config_file = '/etc/dnsmasq.conf'
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
