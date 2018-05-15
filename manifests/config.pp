class dnsmasq::config (
  $except_interface  = undef,
  $ignore_resolvconf = false,
) {

  validate_bool($ignore_resolvconf)

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
    file_line { 'defaults_except_interfaces':
      ensure             => present,
      path               => $::dnsmasq::params::defaults_file,
      line               => "DNSMASQ_EXCEPT=\"${except_value}\"",
      match              => '^#?DNSMASQ_EXCEPT',
      append_on_no_match => true,
    }
  }

  $ign_resolvconf_value = bool2str($ignore_resolvconf,'yes','no')
  file_line { 'defaults_ignore_resolvconf':
    ensure             => present,
    path               => $::dnsmasq::params::defaults_file,
    line               => "IGNORE_RESOLVCONF=${ign_resolvconf_value}",
    match              => '^#?IGNORE_RESOLVCONF',
    append_on_no_match => true,
  }

}
