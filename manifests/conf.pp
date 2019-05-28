define dnsmasq::conf (
  Enum['absent', 'present'] $ensure = 'present',
  Integer[0, 999] $prio = 10,
  Optional[String] $source = undef,
  Optional[String] $content = undef
) {
  include ::dnsmasq

  file { "${dnsmasq::params::config_dir}${prio}-${name}":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    content => $content,
    source  => $source,
    notify  => Class['dnsmasq::service'],
  }
}
