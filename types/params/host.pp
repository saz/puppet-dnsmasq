# @summary Type corresponding to dnsmasq::host resource parameters
type Dnsmasq::Params::Host = Struct[{
  ip                 => Stdlib::IP::Address::Nosubnet,
  Optional[hostname] => Stdlib::FQDN,
  Optional[aliases]  => Variant[String[1], Array[String[1]]],
  Optional[mac]      => Stdlib::MAC,
  Optional[ensure]   => Enum['absent', 'present'],
}]
