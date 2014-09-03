#
class ntp::defaults {
  $servers      = suffix(range(0, 3), '.pool.ntp.org')
  $driftfile    = '/var/lib/ntp/drift'
  $restrict     = ['default nomodify notrap nopeer noquery', '127.0.0.1', '::1']
  $includefile  = ['/etc/ntp/crypto/pw']
  $keys         = '/etc/ntp/keys'
  $disable      = ['monitor']
  $conffile     = "${module_name}/ntp.conf.erb"
  $ensure       = 'running'
  $onboot       = 'enabled'
}
