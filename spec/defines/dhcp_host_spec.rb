# frozen_string_literal: true

require 'spec_helper'

describe 'dnsmasq::dhcp_host' do
  on_supported_os.each do |os, facts|
    context "on #{os} with Facter #{facts[:facterversion]} and Puppet #{facts[:puppetversion]}" do
      let(:facts) do
        facts
      end

      let(:title) { 'example' }
      let(:pre_condition) { 'class { "dnsmasq::reload": command => "stub" }' }
      let(:params) { { mac: mac } }
      let(:mac) { '0a:1b:2c:3d:4e:5f' }
      let(:conf_title) { "dhcp-host_#{title}_#{mac}" }

      it do
        is_expected.to contain_dnsmasq__conf(conf_title).
          with_ensure('present').
          with_content("dhcp-host=#{mac},id:*,#{title}\n").
          with_prio(99).
          that_notifies('Class[dnsmasq::reload]')
      end

      context 'with hostname specified' do
        let(:params) { super().merge(hostname: 'foo') }

        it do
          is_expected.to contain_dnsmasq__conf('dhcp-host_foo_0a:1b:2c:3d:4e:5f').
            with_content("dhcp-host=#{mac},id:*,foo\n")
        end
      end

      context 'with ip specified' do
        let(:params) { super().merge(ip: '1.2.3.4') }

        it do
          is_expected.to contain_dnsmasq__conf(conf_title).
            with_content("dhcp-host=#{mac},id:*,example,1.2.3.4\n")
        end
      end

      context 'with prio specified' do
        let(:params) { super().merge(prio: 123) }

        it { is_expected.to contain_dnsmasq__conf(conf_title).with_prio(123) }
      end

      context 'with ensure specified' do
        let(:params) { super().merge(ensure: 'absent') }

        it { is_expected.to contain_dnsmasq__conf(conf_title).with_ensure('absent') }
      end
    end
  end
end
