# @summary This class manages the dnsmasq configuration file
# @api private
class dnsmasq::config {
  assert_private()

  file { $dnsmasq::config_file:
    owner        => 'root',
    group        => 0,
    mode         => '0644',
    validate_cmd => "${dnsmasq::binary_path} --test --conf-file=%",
    content      => epp('dnsmasq/dnsmasq.conf.epp',
      config_dir => $dnsmasq::config_dir
    ),
  }
}
