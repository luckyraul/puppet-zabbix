# == Class: zabbix::packages
# @param agent_ensure
#   Desired state of the Zabbix agent package.
#   Defaults to the value defined in zabbix::agent_package_ensure.
class zabbix::packages (
  String $agent_ensure = $zabbix::agent_package_ensure,
) {
  assert_private()
  package { 'zabbix-agent':
    ensure => $agent_ensure,
    name   => 'zabbix-agent2',
  }
}
