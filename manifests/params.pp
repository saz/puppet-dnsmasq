class dnsmasq::params {

  # Facter under ArchLinux reports $osfamily as "Linux", but it
  # gets $operatingsystem correct.
  $_family = $osfamily ? {
    Linux => $operatingsystem,
    default => $osfamily,
  }

  case $_family {
    Debian, RedHat, Archlinux: {
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
