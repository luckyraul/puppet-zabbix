# == Class: zabbix
#
# Installs and configures the Zabbix agent.
#
# Includes repository configuration, package installation and service
# management.
#
# @param agent_package_version
#   Version of the Zabbix repository and agent package to install.
#   Defaults to '8.0'.
#
# @param agent_package_ensure
#   Desired state of the Zabbix agent package.
#   Defaults to the value defined in zabbix::params.
#
# @param agent_service_ensure
#   Desired state of the Zabbix agent service (running or stopped).
#   Defaults to the value defined in zabbix::params.
#
# @param agent_service_enable
#   Whether the Zabbix agent service should be enabled at boot.
#   Defaults to the value defined in zabbix::params.
#
# @param server
#   IP address or hostname of the Zabbix server or proxy accepting passive
#   agent connections.
#   Defaults to '127.0.0.1'.
#
# @param server_active
#   IP address or hostname of the Zabbix server or proxy used for active
#   agent checks.
#   Defaults to '127.0.0.1'.
#
# @param hostname
#   Hostname reported by the agent to the Zabbix server.
#   Defaults to the system FQDN.
#
# @param agent_config_path
#   Absolute path to the Zabbix agent configuration file.
#
# @example Basic usage
#   include zabbix
#
# @example Configure the Zabbix agent
#   class { 'zabbix':
#     agent_package_version => '7.4',
#     server                => '192.168.1.10',
#     server_active         => '192.168.1.10',
#     hostname              => 'web01.example.com',
#   }
#
class zabbix (
  String[1] $agent_package_version = '8.0',
  Stdlib::Ensure::Package $agent_package_ensure = $zabbix::params::agent_package_ensure,
  Stdlib::Ensure::Service $agent_service_ensure = $zabbix::params::agent_service_ensure,
  Boolean $agent_service_enable = $zabbix::params::agent_service_enable,
  String[1] $server = '127.0.0.1',
  String[1] $server_active = '127.0.0.1',
  String[1] $hostname = $facts['networking']['fqdn'],
  Stdlib::Absolutepath $agent_config_path = $zabbix::params::agent_config_path,
) inherits zabbix::params {
  contain 'zabbix::repo'
  contain 'zabbix::packages'
  contain 'zabbix::service'
  contain 'zabbix::config_agent'
}
