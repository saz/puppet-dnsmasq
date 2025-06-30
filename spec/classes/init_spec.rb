# frozen_string_literal: true

require 'spec_helper'

describe 'dnsmasq' do
  on_supported_os.each do |os, facts|
    context "on #{os} with Facter #{facts[:facterversion]} and Puppet #{facts[:puppetversion]}" do
      let(:facts) do
        facts
      end

      context 'with default parameters' do
        it { is_expected.to compile }

        it { is_expected.to contain_package('dnsmasq').with_ensure('installed') }

        it do
          is_expected.to contain_file('/etc/dnsmasq.d').
            with_ensure('directory').
            without_recurse.
            without_purge.
            without_force
        end

        it do
          is_expected.to contain_file('/etc/dnsmasq.conf').
            with_validate_cmd('/usr/sbin/dnsmasq --test --conf-file=%').
            with_content(%r{^conf-dir=/etc/dnsmasq.d})
        end

        it do
          is_expected.to contain_service('dnsmasq').
            with_ensure('running').
            with_enable(true)
        end

        it { is_expected.to have_dnsmasq__conf_resource_count(0) }
        it { is_expected.to have_dnsmasq__host_resource_count(0) }
        it { is_expected.to have_dnsmasq__dhcp_host_resource_count(0) }

        it { is_expected.to contain_class('dnsmasq::install').that_comes_before('Class[dnsmasq::config]') }
        it { is_expected.to contain_class('dnsmasq::install').that_comes_before('Class[dnsmasq::service]') }
        it { is_expected.to contain_class('dnsmasq::config').that_notifies('Class[dnsmasq::service]') }
        it { is_expected.to contain_class('dnsmasq::service') }
        it { is_expected.to contain_class('dnsmasq::reload').that_comes_before('Class[dnsmasq::service]') }
      end

      context 'with binary_path specified' do
        let(:params) { { binary_path: '/opt/bin/dnsmasq' } }

        it { is_expected.to contain_file('/etc/dnsmasq.conf').with_validate_cmd('/opt/bin/dnsmasq --test --conf-file=%') }
      end

      context 'with config_dir specified' do
        let(:params) { { config_dir: '/usr/local/etc/dnsmasq.d' } }

        it { is_expected.to contain_file('/etc/dnsmasq.conf').with_content(%r{^conf-dir=/usr/local/etc/dnsmasq.d}) }
      end

      context 'with config_file specified' do
        let(:params) { { config_file: '/usr/local/etc/dnsmasq.conf' } }

        it { is_expected.not_to contain_file('/etc/dnsmasq.conf') }
        it { is_expected.to contain_file('/usr/local/etc/dnsmasq.conf') }
      end

      context 'with package_ensure specified' do
        let(:params) { { package_ensure: '1.2.3' } }

        it { is_expected.to contain_package('dnsmasq').with_ensure('1.2.3') }
      end

      context 'with package_name specified' do
        let(:params) { { package_name: 'mydnsmasq' } }

        it { is_expected.to contain_package('mydnsmasq') }
      end

      context 'with purge_config_dir specified' do
        let(:params) { { purge_config_dir: true } }

        it { is_expected.to contain_file('/etc/dnsmasq.d').with_purge(true).with_recurse(true).with_force(true) }
      end

      context 'with service_control specified' do
        let(:params) { { service_control: false } }

        it { is_expected.not_to contain_service('dnsmasq') }
      end

      context 'with service_ensure specified' do
        let(:params) { { service_ensure: 'stopped' } }

        it { is_expected.to contain_service('dnsmasq').with_ensure('stopped') }
      end

      context 'with service_enable specified' do
        let(:params) { { service_enable: false } }

        it { is_expected.to contain_service('dnsmasq').with_enable(false) }
      end

      context 'with service_name specified' do
        let(:params) { { service_name: 'mydnsmasq' } }

        it { is_expected.to contain_service('mydnsmasq') }
      end

      context 'with configs_hash specified' do
        let(:params) do
          {
            configs_hash: {
              'foo.conf': {
                content: 'foo=bar',
              },
              'bar.conf': {
                ensure: 'absent',
                prio: 23,
                source: 'puppet:///bar.conf',
              },
            }
          }
        end

        it do
          is_expected.to contain_dnsmasq__conf('foo.conf').
            with_ensure('present').
            with_source(nil).
            with_content('foo=bar')
        end

        it do
          is_expected.to contain_dnsmasq__conf('bar.conf').
            with_ensure('absent').
            with_prio(23).
            with_source('puppet:///bar.conf').
            with_content(nil)
        end
      end

      context 'with dhcp_hosts_hash' do
        let(:params) do
          {
            dhcp_hosts_hash: {
              foo: {
                mac: '0a:1b:2c:3d:4e:5f',
              },
              bar: {
                mac: '0a:1b:2c:3d:4e:60',
                hostname: 'barbar',
                ip: '1.2.3.4',
                prio: 23,
                ensure: 'absent',
              },
            }
          }
        end

        it { is_expected.to contain_dnsmasq__dhcp_host('foo').with_mac('0a:1b:2c:3d:4e:5f') }

        it do
          is_expected.to contain_dnsmasq__dhcp_host('bar').
            with_hostname('barbar').
            with_mac('0a:1b:2c:3d:4e:60').
            with_ip('1.2.3.4').
            with_prio(23).
            with_ensure('absent')
        end
      end

      context 'with hosts_hash' do
        let(:params) do
          {
            hosts_hash: {
              foo: {
                ip: '1.2.3.4',
              },
              bar: {
                ip: '2.3.4.5',
                hostname: 'barbar',
                aliases: 'bar1 bar2',
                mac: '0a:1b:2c:3d:4e:5f',
                ensure: 'absent',
              },
            }
          }
        end

        it { is_expected.to contain_dnsmasq__host('foo').with_ip('1.2.3.4') }

        it do
          is_expected.to contain_dnsmasq__host('bar').
            with_ip('2.3.4.5').
            with_hostname('barbar').
            with_aliases('bar1 bar2').
            with_mac('0a:1b:2c:3d:4e:5f').
            with_ensure('absent')
        end
      end
    end
  end
end
