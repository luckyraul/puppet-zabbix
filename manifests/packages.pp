# == Class: zabbix::packages

class zabbix::packages (
    $ensure       = $zabbix::ensure,
    $package_name = $zabbix::package_name,
)  inherits zabbix::params
{
    case $facts['os']['name'] {
      'Ubuntu', 'Debian': {
        Exec['apt_update'] -> Package['zabbix-agent']
      }
    }

    package { 'zabbix-agent':
        ensure => $ensure,
        name   => $package_name,
    }
}
