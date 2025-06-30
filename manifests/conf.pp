# @summary Manage a dnsmasq configuration fragment
#
# @example Using `content` to define inline configuration
#   dnsmasq::conf { 'local-dns':
#     content => 'address=/example.com/127.0.0.1',
#   }
#
# @example Using `source` to deploy a static configuration file
#   dnsmasq::conf { 'dhcp-settings':
#     prio   => 30,
#     source => 'puppet:///modules/site/dnsmasq/dhcp.conf',
#   }
#
# This defined type creates or removes a configuration fragment file in the
# dnsmasq configuration directory. Configuration fragments are typically used
# to modularly manage dnsmasq settings, especially when multiple components
# contribute to the overall configuration.
#
# The fragment is created with a prioritized filename (`<prio>-<name>`) to
# ensure correct ordering when dnsmasq reads the configuration files.
#
# @param ensure
#   Whether the configuration fragment should be present or absent.
# @param content
#   The content to write directly into the configuration fragment.
#   Mutually exclusive with `source`.
# @param source
#   The source file to copy into the configuration fragment.
#   Mutually exclusive with `content`.
# @param prio
#   The priority (sort order) of the configuration fragment. Lower numbers are
#   loaded first.
#
define dnsmasq::conf (
  Enum['absent', 'present']           $ensure  = 'present',
  Variant[Integer[0, 999], String[1]] $prio    = 10,
  Optional[Stdlib::Filesource]        $source  = undef,
  Optional[String[1]]                 $content = undef
) {
  include dnsmasq

  if $ensure == 'present' and !$source and !$content {
    fail('Either source or content parameter must be specified!')
  }

  file { "${dnsmasq::config_dir}/${prio}-${name}":
    ensure       => $ensure,
    owner        => 'root',
    group        => 0,
    content      => $content,
    source       => $source,
    validate_cmd => "${dnsmasq::binary_path} --test --conf-file=%",
    notify       => Class['dnsmasq::service'],
  }
}
