require 'spec_helper'

describe 'dnsmasq::upstreams' do
  let (:facts) { {
      :osfamily => 'Debian',
  } }
  let (:params) {{
      :upstream_servers => ['0.0.0.0','255.255.255.255'],
  }}
  it {
    should contain_file('/etc/resolv.conf.dnsmasq').
      with_content(/^nameserver 0.0.0.0$/).
      with_content(/^nameserver 255.255.255.255$/)
  }
  it { should contain_dnsmasq__conf('use-custom-resolv-conf').
         with_content("resolv-file=/etc/resolv.conf.dnsmasq\n") }
end
