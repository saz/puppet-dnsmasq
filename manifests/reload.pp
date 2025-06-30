# @summary Class to reload dnsmasq when needed
#
# Notify `dnsmasq` to reload changes from `/etc/hosts`, `/etc/ethers` or any
# other file given by `--dhcp-hostsfile`, `--dhcp-optsfile` or `--addn-hosts`.
#
# @param command
#   Command to execute when reloading the dnsmasq configuration. When set, this
#   class can be used without including the main dnsmasq class.
# @param path
#   Path to search the command in.
class dnsmasq::reload (
  String[1] $command = $dnsmasq::reload_command,
  Variant[Array[Stdlib::Absolutepath], String[1]] $path = ['/usr/bin', '/usr/sbin'],
) {
  exec { 'dnsmasq_reload':
    command     => $command,
    path        => $path,
    refreshonly => true,
  }
}
