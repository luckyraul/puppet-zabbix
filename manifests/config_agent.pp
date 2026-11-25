# == Class: zabbix::config_agent
#
# Configures the Zabbix agent configuration file with the
# server connection settings and hostname.
#
# @param ensure
#   Controls whether the Zabbix agent package should be installed.
#   Uses the value defined by $zabbix::agent_package_ensure by default.
#
# @param server
#   IP address or DNS name of the Zabbix server or proxy used for
#   passive checks. Defaults to $zabbix::server.
#
# @param server_active
#   IP address or DNS name of the Zabbix server or proxy used for
#   active checks. Defaults to $zabbix::server_active.
#
# @param hostname
#   Hostname used by the Zabbix agent to identify itself to the server.
#   Defaults to $zabbix::hostname.
#
# @param config_path
#   Absolute path to the Zabbix agent configuration file.
#   Defaults to $zabbix::agent_config_path.
#
class zabbix::config_agent (
  Stdlib::Ensure::Package $ensure = $zabbix::agent_package_ensure,
  String[1] $server = $zabbix::server,
  String[1] $server_active = $zabbix::server_active,
  String[1] $hostname = $zabbix::hostname,
  Stdlib::Absolutepath $config_path = $zabbix::agent_config_path,
) {
  assert_private()
  if ($ensure in ['present', 'installed', 'latest']) {
    $defaults = {
      path    => $config_path,
      notify  => Service['zabbix-agent'],
      require => Package['zabbix-agent'],
    }

    $params = {
      '' => {
        'Server'       => $server,
        'ServerActive' => $server_active,
        'Hostname'     => $hostname,
      },
    }

    inifile::create_ini_settings($params, $defaults)
  }
}
