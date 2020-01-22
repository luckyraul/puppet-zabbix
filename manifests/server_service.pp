# == Class zabbix::server_service
class zabbix::server_service (
    $service_name   = $zabbix::params::server_service_name,
    $service_enable = $zabbix::server::service_enable,
    $service_ensure = $zabbix::server::service_ensure,
    $database_type  = $zabbix::server::database_type,
) inherits zabbix::params
{
    service { $service_name:
      ensure     => $service_ensure,
      enable     => $service_enable,
      hasstatus  => true,
      hasrestart => true,
    }
}
