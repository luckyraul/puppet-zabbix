# == Class: zabbix::config_agent2
#
# lint:ignore:parameter_documentation
class zabbix::config_agent2 (
  $version       = $zabbix::agent_version,
  $ensure        = $zabbix::agent_ensure,
  $server        = $zabbix::server,
  $server_active = $zabbix::server_active,
  $hostname      = $zabbix::hostname
) inherits zabbix::params {
  if (versioncmp($version, '2') == 0) {
    if ($ensure in ['present', 'installed', 'latest']) {
      $defaults = {
        path    => $zabbix::params::agent2_config_path,
        notify  => Service['zabbix-agent'],
        require => Package['zabbix-agent'],
      }

      $params = {
        '' => {
          'Server' => $server,
          'ServerActive' => $server_active,
          'Hostname' => $hostname,
        },
      }

      inifile::create_ini_settings($params, $defaults)
    }
  }
}
