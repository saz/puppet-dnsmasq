# frozen_string_literal: true

require 'spec_helper'

describe 'dnsmasq::host' do
  on_supported_os.each do |os, facts|
    context "on #{os} with Facter #{facts[:facterversion]} and Puppet #{facts[:puppetversion]}" do
      let(:facts) do
        facts
      end

      let(:title) { 'example' }
      let(:pre_condition) { 'class { "dnsmasq::reload": command => "stub" }' }
      let(:params) { { ip: ip } }
      let(:ip) { '1.2.3.4' }
      let(:conf_title) { "dnsmasq::hosts #{title} #{ip}" }

      it do
        expect(exported_resources).to contain_file_line(conf_title).
          with_ensure('present').
          with_path('/etc/hosts').
          with_line("#{ip} #{title}").
          with_tag('dnsmasq-host')
      end

      it { expect(exported_resources).to have_file_line_resource_count(1) }

      context 'with hostname specified' do
        let(:params) { super().merge(hostname: 'foo') }

        it { expect(exported_resources).to contain_file_line("dnsmasq::hosts foo #{ip}").with_line("#{ip} foo") }
        it { expect(exported_resources).to have_file_line_resource_count(1) }
      end

      {
        'String' => 'foo bar',
        'Array' => %w[foo bar],

      }.each do |as, aliases|
        context "with aliases specified (#{as})" do
          let(:params) { super().merge(aliases: aliases) }

          it { expect(exported_resources).to contain_file_line(conf_title).with_line("#{ip} #{title} foo bar") }
          it { expect(exported_resources).to have_file_line_resource_count(1) }
        end
      end

      context 'with mac specified' do
        let(:mac) { '0a:1b:2c:3d:4e:5f' }
        let(:params) { super().merge(mac: mac) }

        it do
          mac_upcase = mac.upcase
          expect(exported_resources).to contain_file_line("dnsmasq::ethers #{title} #{mac_upcase}").
            with_ensure('present').
            with_path('/etc/ethers').
            with_line("#{mac_upcase} #{ip}").
            with_tag('dnsmasq-host')
        end

        it { expect(exported_resources).to contain_file_line(conf_title).with_line("#{ip} #{title}") }

        context 'with ensure => absent' do
          let(:params) { super().merge(ensure: 'absent') }

          it do
            mac_upcase = mac.upcase
            expect(exported_resources).to contain_file_line("dnsmasq::ethers #{title} #{mac_upcase}").
              with_ensure('absent').
              with_line("#{mac_upcase} #{ip}")
          end

          it { expect(exported_resources).to contain_file_line(conf_title).with_line("#{ip} #{title}").with_ensure('absent') }
        end
      end

      context 'with ensure => absent' do
        let(:params) { super().merge(ensure: 'absent') }

        it { expect(exported_resources).to contain_file_line(conf_title).with_line("#{ip} #{title}").with_ensure('absent') }
        it { expect(exported_resources).to have_file_line_resource_count(1) }
      end
    end
  end
end
