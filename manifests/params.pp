# == Class: nginx::params
class zabbix::params {
    $agent_ensure = 'latest'
    $agent_service_ensure = 'running'
    $agent_service_enable = true
    $scripts_path = '/etc/zabbix/scripts'
    $agent_config_path = '/etc/zabbix/zabbix_agentd.conf'

    case $::operatingsystem {
        'Debian': {
            $agent_package_name = 'zabbix-agent'
        }
        default: {
            fail("Unsupported os: ${::operatingsystem}")
        }
    }
}
