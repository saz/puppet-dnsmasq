# @summary Manage a static DHCP host mapping in dnsmasq
#
# This defined type creates or removes a static DHCP lease definition
# (`dhcp-host=`) in dnsmasq configuration. It allows assigning a fixed IP
# address and hostname to a client based on its MAC address.
#
# The generated configuration fragment ensures predictable ordering using a priority,
# and it notifies dnsmasq to reload via SIGHUP after changes.
#
# @example Assign only a hostname to a MAC address (no fixed IP)
#   dnsmasq::dhcp_host { 'guest-device':
#     mac => '66:77:88:99:AA:BB',
#   }
#
# @example Assign a hostname and IP address to a MAC address
#   dnsmasq::dhcp_host { 'myclient':
#     mac      => '00:11:22:33:44:55',
#     hostname => 'myclient.local',
#     ip       => '192.168.1.100',
#   }
#
# @param ensure
#   Whether this DHCP host entry should be present or absent.
# @param hostname
#   Optional hostname to assign to the client. If not provided, defaults to the
#   resource title.
# @param ip
#   Optional fixed IP address to assign to the client. If not provided, only
#   the hostname will be used.
# @param mac
#   MAC address of the client (required).
# @param prio
#   The priority (sort order) of the configuration fragment. Lower numbers are
#   loaded first.
#
define dnsmasq::dhcp_host (
  Stdlib::MAC                             $mac,
  Stdlib::FQDN                            $hostname = $name,
  Optional[Stdlib::IP::Address::Nosubnet] $ip       = undef,
  Variant[Integer[0, 999], String[1]]     $prio     = 99,
  Enum['present', 'absent']               $ensure   = 'present',
) {
  include dnsmasq::reload

  $record_params = [
    $mac,
    'id:*',
    $hostname,
  ] + if $ip {[$ip] } else {[] }

  dnsmasq::conf { "dhcp-host_${hostname}_${mac}":
    ensure  => $ensure,
    content => "dhcp-host=${$record_params.join(',')}\n",
    prio    => $prio,
    notify  => Class['dnsmasq::reload'],
  }
}
