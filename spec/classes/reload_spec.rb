# frozen_string_literal: true

require 'spec_helper'

describe 'dnsmasq::reload' do
  on_supported_os.each do |os, facts|
    context "on #{os} with Facter #{facts[:facterversion]} and Puppet #{facts[:puppetversion]}" do
      let(:facts) do
        facts
      end

      context 'with default parameters' do
        let(:pre_condition) { 'include dnsmasq' }

        it do
          is_expected.to contain_exec('dnsmasq_reload').
            with_command('/usr/bin/systemctl reload dnsmasq').
            with_path(['/usr/bin', '/usr/sbin']).
            with_refreshonly(true)
        end
      end

      # Not testing parameters separately here, because that requires
      # non-trivial dnsmasq::reload_command stubbing but gives no benefits.
      context 'with custom parameters' do
        let(:params) do
          {
            command: 'service dnsmasq reload',
            path: '/usr/local/bin:/usr/local/sbin',
          }
        end

        it do
          is_expected.to contain_exec('dnsmasq_reload').
            with_command('service dnsmasq reload').
            with_path('/usr/local/bin:/usr/local/sbin').
            with_refreshonly(true)
        end
      end

      context 'with dnsmasq::reload_command specified' do
        let(:pre_condition) { 'class { "dnsmasq": reload_command => "service dnsmasq reload" }' }

        it { is_expected.to contain_exec('dnsmasq_reload').with_command('service dnsmasq reload').with_refreshonly(true) }
      end
    end
  end
end
