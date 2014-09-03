# 
class ntp (
  $servers      = $::ntp::defaults::servers,
  $driftfile    = $::ntp::defaults::driftfile,
  $restrict     = $::ntp::defaults::restrict,
  $includefile  = $::ntp::defaults::includefile,
  $keys         = $::ntp::defaults::keys,
  $disable      = $::ntp::defaults::disable,
  $conffile     = $::ntp::defaults::conffile,
  $ensure       = $::ntp::defaults::ensure,
  $onboot       = $::ntp::defaults::onboot,
) inherits ntp::defaults {

  if $::osfamily != 'RedHat' {
    fail("${module_name} does not support ${::osfamily}")
  }

  case $::operatingsystemmajrelease {
    5,6,7: { }
    default: {
      fail("${module_name} does not support ${::operatingsystemmajrelease}")
    }
  }

  validate_array($servers, $restrict, $includefile, $disable)
  validate_string($driftfile, $keys)
  validate_re($ensure, '^(running|stopped)$')
  validate_re($onboot, '^(enabled|disabled)$')

  package { 'ntp':
    ensure => installed,
  }

  file { '/etc/ntp.conf':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
  }

  if $conffile =~ /^puppet:\/\/\// or is_array($conffile) {
    File['/etc/ntp.conf'] {
      source => $conffile,
    }
  } else {
    File['/etc/ntp.conf'] {
      content => template($conffile),
    }
  }

  $service_enable = $onboot ? {
    'enabled'  => true,
    'disabled' => false,
  }

  service { 'ntpd':
    ensure => $ensure,
    enable => $service_enable,
  }

  Package['ntp']->File['/etc/ntp.conf']->Service['ntpd']
  Package['ntp']~>Service['ntpd']<~File['/etc/ntp.conf']
}
