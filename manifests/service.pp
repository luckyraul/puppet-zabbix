# == Class zabbix::service
class zabbix::service (
  $version       = $zabbix::agent_version,
  $service_name    = $zabbix::agent_service_name,
  $service_enable  = $zabbix::agent_service_enable,
  $service_ensure  = $zabbix::agent_service_ensure,
) inherits zabbix::params {
  if ($service_name != undef) {
    $real_service_name = $service_name
  } else {
    case $version {
      2: {
        $real_service_name = $zabbix::params::agent2_package_name
      }
      default: {
        $real_service_name = $zabbix::params::agent_package_name
      }
    }
  }

  service { 'zabbix-agent':
    ensure     => $service_ensure,
    name       => $real_service_name,
    enable     => $service_enable,
    hasstatus  => true,
    hasrestart => true,
  }
}
