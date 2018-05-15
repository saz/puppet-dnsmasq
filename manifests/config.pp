class dnsmasq::config (
  Array $except_interface = undef,
) {
  File {
    owner => 'root',
    group => 'root',
  }

  file { $::dnsmasq::params::config_file:
    mode   => '0644',
    source => 'puppet:///modules/dnsmasq/dnsmasq.conf',
  }

  if is_array($except_interfaces) {
    $except_value = join($except_interface, ' ')
    file_line { 'except_interfaces':
      ensure => present,
      path   => $::dnsmasq::params::defaults_file,
      line   => "DNSMASQ_EXCEPT=\"${except_value}\"",
    }
  }

}
