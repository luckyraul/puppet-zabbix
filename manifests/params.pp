# == Class: zabbix::params
class zabbix::params {
    $version = '5.0'
    $agent_ensure = 'latest'
    $agent_service_ensure = 'running'
    $agent_service_enable = true

    $scripts_path = '/etc/zabbix/scripts'
    $agent_config_path = '/etc/zabbix/zabbix_agentd.conf'

    $server_ensure = 'latest'
    $server_database_type = 'mysql'
    $server_service_ensure = 'running'
    $server_service_enable = true
    $frontend = true

    case $facts['os']['name'] {
        'Ubuntu', 'Debian': {
            $agent_package_name = 'zabbix-agent'
            $server_package_name = 'zabbix-server-'
            $server_service_name = 'zabbix-server'
            $frontend_package_name = 'zabbix-frontend-php'
        }
        'CentOS', 'Redhat': {
            $agent_package_name = 'zabbix-agent'
            $server_package_name = 'zabbix-server-'
            $server_service_name = "zabbix-server-${server_database_type}"
            $frontend_package_name = "zabbix-web-${server_database_type}"
        }
        default: {
            fail("Unsupported os: ${facts['os']['name']}")
        }
    }
}
