class dnsmasq::service {
  service { $dnsmasq::params::service_name:
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Class['dnsmasq::config'],
  }
}
