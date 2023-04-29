class dnsmasq::config {
  file { $dnsmasq::params::config_file:
    owner  => 'root',
    group  => 0,
    mode   => '0644',
    source => 'puppet:///modules/dnsmasq/dnsmasq.conf',
  }
}
