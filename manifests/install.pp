# = Class: dnsmasq::install
#
# This class is private to the dnsmasq implementation
#
class dnsmasq::install {
  if $::osfamily == 'Debian' {
    # Prevent dnsmasq service from automatically starting on
    # installation on debian-based distributions.
    #
    # This can cause problems because dnsmasq immediately registers
    # itself as the sole resolver in resolvconf, but it takes a while
    # for resolvconf to inform dnsmasq of the upstream servers in
    # /var/run/dnsmasq/resolv.conf. During this time, ALL DNS LOOKUPS
    # FAIL, which is Very Bad News.
    file { $::dnsmasq::params::sysv_default:
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => "ENABLED=0\n",
      before  => Package[$dnsmasq::params::package_name],
    }
  }
  package { $dnsmasq::params::package_name:
    ensure => installed,
  }
}
