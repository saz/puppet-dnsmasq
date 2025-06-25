# @summary Type corresponding to dnsmasq::conf resource parameters
type Dnsmasq::Params::Conf = Struct[{
    Optional[ensure]  => Enum['absent', 'present'],
    Optional[prio]    => Variant[Integer[0, 999], String[1]],
    Optional[source]  => Stdlib::Filesource,
    Optional[content] => String[1],
}]
