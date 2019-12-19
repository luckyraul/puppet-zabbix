# == Class zabbix::server_service
class zabbix::server_service (
    $service_name   = $zabbix::server_package_name,
    $service_enable = $zabbix::server_service_enable,
    $service_ensure = $zabbix::server_service_ensure,
    $database_type  = $zabbix::server::database_type,
) inherits zabbix::params
{
    service { "${service_name}${database_type}":
      ensure     => $service_ensure,
      enable     => $service_enable,
      hasstatus  => true,
      hasrestart => true,
    }
}
