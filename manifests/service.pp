class dnsmasq::service (
  $service_control = true,
) {
  # validate type and convert string to boolean if necessary
  if is_string($service_control) {
    $service_control_real = str2bool($service_control)
  } else {
    $service_control_real = $service_control
  }
  if $service_control_real == true {
    service { $dnsmasq::params::service_name:
      ensure     => 'running',
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
    }
  }

}
