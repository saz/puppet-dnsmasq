# puppet-dnsmasq

Manage dnsmasq via Puppet

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
