class dnsmasq::service (
  Variant[String, Boolean] $service_control = $dnsmasq::params::service_control,
) {
  # validate type and convert string to boolean if necessary
  $service_control_real = $service_control ? {
    Boolean => $service_control,
    String  => str2bool($service_control),
    default => fail('Illegal value for $service_control parameter'),
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
