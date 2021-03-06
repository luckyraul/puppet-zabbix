# == Class: zabbix
class zabbix (
    $ensure                = $zabbix::params::agent_ensure,
    $package_name          = $zabbix::params::agent_package_name,
    $service_ensure        = $zabbix::params::agent_service_ensure,
    $service_enable        = $zabbix::params::agent_service_enable,
    $server                = '127.0.0.1',
    $server_active         = '127.0.0.1',
    $hostname              = $::fqdn,
    $nginx_script          = false,
    $iostat_script         = false,
    $mdraid                = false,
    $mysql                 = false,
    $mysql_user            = undef,
    $mysql_pass            = undef,
    ) inherits zabbix::params
{
    anchor { 'zabbix::begin': }
        -> class  { 'zabbix::repo': }
        -> class  { 'zabbix::packages': }
        -> class  { 'zabbix::config': }
        -> class  { 'zabbix::service': }
        -> anchor { 'zabbix::end': }
}
