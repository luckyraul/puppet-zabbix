# == Class: zabbix::server
class zabbix::server (
  $ensure               = $zabbix::params::server_ensure,
  String $database_type = $zabbix::params::server_database_type,
  Boolean $frontend     = $zabbix::params::frontend,
  String $package_name  = $zabbix::params::server_package_name,
  $service_ensure       = $zabbix::params::server_service_ensure,
  $service_enable       = $zabbix::params::server_service_enable,
) inherits zabbix::params {
  anchor { 'zabbix_server::begin': }
  -> class { 'zabbix::repo': }
  -> class { 'zabbix::server_packages': }
  -> class { 'zabbix::server_config': }
  -> class { 'zabbix::server_service': }
  -> anchor { 'zabbix_server::end': }
}
