class dnsmasq(
  $configs_hash = {}
) {
  include ::dnsmasq::params

  validate_hash($configs_hash)

  anchor { '::dnsmasq::start': }

  class { '::dnsmasq::install': require => Anchor['::dnsmasq::start'], }

  class { '::dnsmasq::config': require => Class['::dnsmasq::install'], }

  class { '::dnsmasq::service':
    subscribe => Class['::dnsmasq::install', '::dnsmasq::config'],
  }

  class { '::dnsmasq::reload':
    require => Class['::dnsmasq::service'],
  }

  anchor { '::dnsmasq::end': require => Class['::dnsmasq::service'], }
  if $::settings::storeconfigs {
    File_line <<| tag == 'dnsmasq-host' |>>
  }

  if $configs_hash != {} {
    create_resources(dnsmasq::host, $configs_hash)
  }
}
