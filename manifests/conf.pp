# = Type: dnsmasq::conf
#
# Add a dnsmasq config snippet to its conf.d directory
#
# === Parameters
#
# [*ensure*]
#   Valid values: present/absent. Default: present.
#
# [*prio*]
#   A parameter which determines the evaluation order of dnsmasq
#   config snippets. Note that this should always be exactly two
#   digits long, since it is simply prepended to the filename of the
#   resultant file. Instead of '5', use '05'.
#     Default: 10
#
# [*source*]
#   The source of the config snippet. Mutually exclusive with content.
#
# [*content*]
#   The content of the config snippet. Mutually exclusive with source.
#
define dnsmasq::conf(
  $ensure = 'present',
  $prio = 10,
  $source = undef,
  $content = undef
) {
  include dnsmasq

  file { "${dnsmasq::params::config_dir}${prio}-${name}":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    content => $content,
    source  => $source,
    notify  => Class['dnsmasq::service'],
  }
}
