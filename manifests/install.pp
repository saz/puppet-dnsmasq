# @summary This class manages the dnsmasq package
# @api private
class dnsmasq::install {
  assert_private()

  package { $dnsmasq::package_name:
    ensure => $dnsmasq::package_ensure,
  }

  $purge_attributes = if $dnsmasq::purge_config_dir {
    {
      recurse => true,
      purge   => true,
      force   => true,
    }
  } else {
    {}
  }

  file { $dnsmasq::config_dir:
    * => { ensure => 'directory' } + $purge_attributes,
  }
}
