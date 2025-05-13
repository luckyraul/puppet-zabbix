# == Class: zabbix
# lint:ignore:parameter_documentation
class zabbix (
  $agent_ensure          = $zabbix::params::agent_ensure,
  $agent_service_ensure  = $zabbix::params::agent_service_ensure,
  $agent_service_enable  = $zabbix::params::agent_service_enable,
  $agent_package_name    = undef,
  $agent_service_name    = undef,
  $agent_version         = '2',
  $server                = '127.0.0.1',
  $server_active         = '127.0.0.1',
  $hostname              = $facts['networking']['fqdn'],
  $nginx_script          = false,
  $iostat_script         = false,
  $mdraid                = false,
  $mysql                 = false,
  $mysql_user            = undef,
  $mysql_pass            = undef,
) inherits zabbix::params {
  anchor { 'zabbix::begin': }
  -> class { 'zabbix::repo': }
  -> class { 'zabbix::packages': }
  -> class { 'zabbix::config_agent': }
  -> class { 'zabbix::config_agent2': }
  -> class { 'zabbix::service': }
  -> anchor { 'zabbix::end': }
}
