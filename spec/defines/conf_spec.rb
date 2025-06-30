# frozen_string_literal: true

require 'spec_helper'

describe 'dnsmasq::conf' do
  on_supported_os.each do |os, facts|
    context "on #{os} with Facter #{facts[:facterversion]} and Puppet #{facts[:puppetversion]}" do
      let(:facts) do
        facts
      end

      let(:title) { 'example' }

      context 'without parameters' do
        it { is_expected.to compile.and_raise_error(%r{source or content}) }
      end

      context 'with content specified' do
        let(:params) { { content: 'foo=bar' } }

        it do
          is_expected.to contain_file('/etc/dnsmasq.d/10-example').
            with_ensure('present').
            with_content('foo=bar').
            with_source(nil).
            with_validate_cmd(%r{/usr/sbin/dnsmasq}).
            that_notifies('Class[dnsmasq::service]')
        end
      end

      context 'with source specified' do
        let(:params) { { source: 'puppet:///modules/profiles/example.conf' } }

        it do
          is_expected.to contain_file('/etc/dnsmasq.d/10-example').
            with_content(nil).
            with_source('puppet:///modules/profiles/example.conf')
        end
      end

      context 'with prio specified' do
        let(:params) { { prio: 123, content: 'stub' } }

        it { is_expected.to contain_file('/etc/dnsmasq.d/123-example') }
      end

      context 'with ensure => absent' do
        let(:params) { { ensure: 'absent' } }

        it { is_expected.to contain_file('/etc/dnsmasq.d/10-example').with_ensure('absent') }
      end

      context 'with custom dnsmasq::config_dir' do
        let(:pre_condition) { 'class { "dnsmasq": config_dir => "/usr/local/etc/dnsmasq.d" }' }
        let(:params) { { content: 'stub' } }

        it { is_expected.to contain_file('/usr/local/etc/dnsmasq.d/10-example') }
      end

      context 'with custom dnsmasq::binary_path' do
        let(:pre_condition) { 'class { "dnsmasq": binary_path => "/usr/local/sbin/dnsmasq" }' }
        let(:params) { { content: 'stub' } }

        it { is_expected.to contain_file('/etc/dnsmasq.d/10-example').with_validate_cmd(%r{/usr/local/sbin/dnsmasq}) }
      end
    end
  end
end
