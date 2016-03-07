# == Class: zabbix::config
#
class zabbix::config (
    $server        = $zabbix::server,
    $server_active = $zabbix::server_active,
    $hostname      = $zabbix::hostname,
    $nginx         = $zabbix::nginx_script,
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

    if($nginx){
        file { '/etc/zabbix/zabbix_agentd.d/nginx.conf':
            ensure  => present,
            content => template('nginx/scripts/nginx.conf.erb'),
        }
    } else {
        file { '/etc/zabbix/zabbix_agentd.d/nginx.conf':
            ensure => absent,
        }
    }

    File['/etc/zabbix/zabbix_agentd.d/nginx.conf'] ~> Service['zabbix-agent']
}
