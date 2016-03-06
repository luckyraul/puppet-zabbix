# == Class: zabbix::config
#
class zabbix::config (
    $server = '127.0.0.1',
    $server_active = '127.0.0.1',
    $hostname = $::fqdn,
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
