class dnsmasq::install {
  package { $dnsmasq::params::package_name: ensure => 'installed', }

  file { "${dnsmasq::params::config_dir}":
    ensure => 'directory'
  }
}
