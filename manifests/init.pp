class dnsmasq(
  $configs_hash = {},
  $hosts_hash = {},
  $dhcp_hosts_hash = {},
  $service_control = true,
) {
  include ::dnsmasq::params

  validate_hash($configs_hash)
  validate_hash($hosts_hash)
  validate_hash($dhcp_hosts_hash)

  anchor { '::dnsmasq::start': }

  class { '::dnsmasq::install': require => Anchor['::dnsmasq::start'], }

  class { '::dnsmasq::config': require => Class['::dnsmasq::install'], }

  class { '::dnsmasq::service':
    service_control => $service_control,
    subscribe => Class['::dnsmasq::install', '::dnsmasq::config'],
  }

  class { '::dnsmasq::reload':
    require => Class['::dnsmasq::service'],
  }

  anchor { '::dnsmasq::end': require => Class['::dnsmasq::service'], }
  if $::settings::storeconfigs {
    File_line <<| tag == 'dnsmasq-host' |>>
  }

  create_resources(dnsmasq::conf, $configs_hash)
  create_resources(dnsmasq::host, $hosts_hash)
  create_resources(dnsmasq::dhcp_host, $dhcp_hosts_hash)
}
