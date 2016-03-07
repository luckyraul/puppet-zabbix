# == Class zabbix::service
class zabbix::service (
    $service_name   = $zabbix::params::agent_package_name,
    $service_status = $zabbix::service_status,
    $service_ensure = $zabbix::service_ensure,
) inherits zabbix::params
{


    service { $service_name:
      ensure     => $service_ensure,
      enable     => $service_status,
      hasstatus  => true,
      hasrestart => true,
    }
}
