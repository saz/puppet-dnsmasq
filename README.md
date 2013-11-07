# puppet-dnsmasq

Manage dnsmasq via Puppet

## How to use

The basic dnsmasq class will just install dnsmasq and run it with as
blank a configuration as is practical. You can add config snippets
with the `dnsmasq::conf` type, which will add config to the
`/etc/dnsmasq.d` or equivalent directory.

Basic usage therefore looks like this:

```puppet
include dnsmasq

dnsmasq::conf { 'local-dns':
    source => 'puppet:///files/dnsmasq/local-dns',
}

dnsmasq::conf { 'another-config':
    content => "dhcp-range=192.168.0.50,192.168.0.150,12h\n",
}
```

## Class parameters

The top-level dnsmasq takes some optional convenience parameters for
common configuration requirements.

### upstream_servers

Adds a `resolv-file` directive which proxies a static list of upstream
DNS servers:

```puppet
class {'dnsmasq':
    upstream_servers => ['192.0.2.0','198.51.100.5'],
}
```

### use_resolvconf

Tells dnsmasq to use
[resolvconf](http://en.wikipedia.org/wiki/Resolvconf) to get
configuration for upstream nameservers:

```puppet
class {'dnsmasq':
    use_resolvconf => 'yes',
}
```
