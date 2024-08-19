class dnsmasq::service (
  Variant[String, Boolean]   $service_control = $dnsmasq::params::service_control,
  Enum['running', 'stopped'] $service_ensure  = 'running',
  Boolean                    $service_enable  = true,
) {
  # validate type and convert string to boolean if necessary
  if $service_control =~ String {
    $service_control_real = Boolean($service_control)
  } else {
    $service_control_real = $service_control
  }
  if $service_control_real == true {
    service { $dnsmasq::params::service_name:
      ensure     => $service_ensure,
      enable     => $service_enable,
      hasrestart => true,
      hasstatus  => true,
    }
  }
}
