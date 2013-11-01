require 'spec_helper'

describe 'dnsmasq' do
  let (:facts) { {
      :osfamily => 'Debian',
  } }

  context 'blank config' do
    it { should_not contain_file('/etc/resolv.conf.dnsmasq') }
    it { should_not contain_dnsmasq__conf('use-custom-resolv-conf') }
    it { should_not contain_dnsmasq__conf('use-resolvconf') }
  end

  context 'when specifying upstream servers' do
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

  context 'when requesting resolvconf configuration' do
    let (:params) {{
        :use_resolvconf => 'yes',
      }}
    it { should contain_dnsmasq__conf('use-resolvconf').
           with_content("resolv-file=/var/run/dnsmasq/resolv.conf\n") }
  end
end
