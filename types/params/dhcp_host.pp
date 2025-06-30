# @summary Type corresponding to dnsmasq::dhcp_host resource parameters
type Dnsmasq::Params::Dhcp_host = Struct[{
    mac                => Stdlib::MAC,
    Optional[hostname] => Stdlib::FQDN,
    Optional[ip]       => Stdlib::IP::Address::Nosubnet,
    Optional[prio]     => Variant[Integer[0, 999], String[1]],
    Optional[ensure]   => Enum['absent', 'present'],
}]
