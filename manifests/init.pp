class dnsmasq {
  include dnsmasq::params, dnsmasq::install, dnsmasq::config, dnsmasq::service
}
