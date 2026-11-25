# == Class: zabbix::service
# @param ensure
#   Specifies the desired state of the Zabbix Agent 2 service.
#   Accepts `running` or `stopped`.
#   Defaults to `$zabbix::agent_service_ensure`.
#
# @param enable
#   Specifies whether the Zabbix Agent 2 service should be enabled to start
#   automatically at boot.
#   Defaults to `$zabbix::agent_service_enable`.
#
class zabbix::service (
  Stdlib::Ensure::Service $ensure = $zabbix::agent_service_ensure,
  Boolean $enable = $zabbix::agent_service_enable,
) {
  assert_private()
  service { 'zabbix-agent':
    ensure     => $ensure,
    name       => 'zabbix-agent2',
    enable     => $enable,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['zabbix-agent'],
  }
}
