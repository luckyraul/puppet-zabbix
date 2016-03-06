# == Class: zabbix
class zabbix (
    $ensure = $zabbix::params::agent_ensure,
    $version = '3.0',
    $package_name = $zabbix::params::agent_package_name,
    $service_ensure = $zabbix::params::agent_service_ensure,
    $service_enable = $zabbix::params::agent_service_enable,

    ) inherits zabbix::params
{
    anchor { 'zabbix::begin': } -> class { 'zabbix::repo': } -> class { 'zabbix::packages': } -> class { 'zabbix::config': } -> anchor { 'zabbix::end': }

}
