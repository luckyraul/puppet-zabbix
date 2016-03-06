# == Class: zabbix::packages

class zabbix::packages (
    $ensure       = $zabbix::ensure,
    $package_name = $zabbix::package_name,
)  inherits zabbix::params
{
    package { 'zabbix-agent':
        ensure => $ensure,
        name   => $package_name,
    }
}
