# puppet-dnsmasq [![Build Status](https://secure.travis-ci.org/saz/puppet-dnsmasq.png)](https://travis-ci.org/saz/puppet-dnsmasq)

Manage dnsmasq via Puppet

### Supported Puppet versions
* Puppet >= 4
* Last version supporting Puppet 3: v1.3.1

## How to use

```
    dnsmasq::conf { 'local-dns':
        ensure => present,
        source => 'puppet:///files/dnsmasq/local-dns',
    }
```

or

```
    dnsmasq::conf { 'another-config':
        ensure  => present,
        content => 'dhcp-range=192.168.0.50,192.168.0.150,12h',
    }
```

## Hiera usage

```
    class { '::dnsmasq':
        configs_hash    => {},
        hosts_hash      => {},
        dhcp_hosts_hash => {},
    }
```

```
    class { '::dnsmasq':
        configs_hash => {
            'another-config' => {
                content      => 'dhcp-range=192.168.0.50,192.168.0.150,12h',
            },
        },
    }
```
