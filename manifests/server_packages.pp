# == Class: zabbix::server_packages
#
# lint:ignore:parameter_documentation
class zabbix::server_packages (
  $ensure        = $zabbix::server::ensure,
  $database_type = $zabbix::server::database_type,
  $frontend      = $zabbix::server::frontend,
) inherits zabbix::params {
  Exec['apt_update'] -> Package['zabbix-server']
  Exec['apt_update'] -> Package['zabbix-frontend']

  package { 'zabbix-server':
    ensure => $ensure,
    name   => "${zabbix::params::server_package_name}${database_type}",
  }

  package { 'zabbix-frontend':
    ensure => $frontend,
    name   => $zabbix::params::frontend_package_name,
  }
}
