# == Class: zabbix::params
class zabbix::params {
  $agent_service_ensure = 'running'
  $agent_service_enable = true
  $agent_package_ensure = 'latest'
  $agent_config_path = '/etc/zabbix/zabbix_agent2.conf'
}
