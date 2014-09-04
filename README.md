
## Content

- [About](#about)
- [Examples](#example)
- [Parameters](#parameters)

## About
Lean RedHat NTP module, with the most common settings.

## Examples

##### 1) Use all the default settings.
```puppet
   include '::ntp'
```

##### 2) Set the preferred servers.
```puppet
  class { '::ntp':
    servers => ['time1.google.com', 'time2.google.com'],
  }
```

##### 3) Set the preferred servers with the iburst option.
```puppet
  class { '::ntp':
    servers => ['time1.google.com iburst', 'time2.google.com iburst'],
  }
```

##### 4) Use the default OS provided ntp.conf file, servers may also be specified.
```puppet
  class { '::ntp':
    conffile => "ntp/${::osfamily}/ntp.conf-${::operatingsystemmajrelease}.erb",
  }
```

##### 5) Use a static file for ntp.conf
```puppet
  class { '::ntp':
    conffile => ["puppet:///modules/${module_name}/ntp.conf-${::operatingsystemmajrelease}"], 
  }
```

## Parameters
See your OS man pages for a description of most of the parameters.

`server`
- *type:* array 
- *default:* ['0.pool.ntp.org', '1.pool.ntp.org', '2.pool.ntp.org', '3.pool.ntp.org']

`driftfile`
- *type:* string
- *default:* '/var/lib/ntp/drift'

`restrict`
- *type:* array
- *default:* ['default nomodify notrap nopeer noquery', '127.0.0.1', '::1']

`includefile`
- *type:* array
- *default:* ['/etc/ntp/crypto/pw']

`keys`
- *type:* string
- *default:* '/etc/ntp/keys'
- *description:*  

`disable`
- *type:* array
- *default:* ['monitor']

`conffile`
- *type:* string|array
- *default:* "${module_name}/ntp.conf.erb"

`ensure`
- *type:* string
- *values:* 'running'|'stopped'
- *default:* 'enabled'
- *description:* Ensure the service is in the desired state.

`onboot`
- *type:* string
- *values:* 'enabled'|'disabled'
- *default:* 'running'
- *description:* Ensure the service is in the desired state on boot.

