# == Class: zabbix::config
#
class zabbix::config (
    $server = $zabbix::server,
    $server_active = $zabbix::server_active,
    $hostname = $zabbix::hostname,
) inherits zabbix::params
{
    $defaults = {
        'path' => $zabbix::params::agent_config_path,
    }
    $params = {
        '' => {
            'Server' => $server,
            'ServerActive' => $server_active,
            'Hostname' => $hostname,
        }
    }

    create_ini_settings($params, $defaults)
}
