class dnsmasq::config (
  $except_interface = undef,
) {
  File {
    owner => 'root',
    group => 'root',
  }

  file { $::dnsmasq::params::config_file:
    mode   => '0644',
    source => 'puppet:///modules/dnsmasq/dnsmasq.conf',
  }

  if is_array($except_interface) {
    $except_value = join($except_interface, ' ')
    file_line { 'except_interfaces':
      ensure => present,
      path   => $::dnsmasq::params::defaults_file,
      line   => "DNSMASQ_EXCEPT=\"${except_value}\"",
      match  => "^DNSMASQ_EXCEPT",
      append_on_no_match => true,
    }
  }

}
