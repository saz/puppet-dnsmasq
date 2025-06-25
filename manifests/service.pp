# @summary This class manages the dnsmasq service
# @api private
class dnsmasq::service {
  assert_private()

  if $dnsmasq::service_control == true {
    service { $dnsmasq::service_name:
      ensure => $dnsmasq::service_ensure,
      enable => $dnsmasq::service_enable,
    }
  }
}
