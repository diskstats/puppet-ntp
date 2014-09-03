Package {
    allow_virtual => false,
}

class { '::ntp':
  servers => ['0.pool.ntp.org iburst', '1.pool.ntp.org iburst'],
}
