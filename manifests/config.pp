# == Class: zabbix::config
#
class zabbix::config (
    $server        = $zabbix::server,
    $server_active = $zabbix::server_active,
    $hostname      = $zabbix::hostname,
    $scripts_path  = $zabbix::params::scripts_path,
    $nginx         = $zabbix::nginx_script,
    $iostat        = $zabbix::iostat_script,
) inherits zabbix::params
{
    $defaults = {
        'path'   => $zabbix::params::agent_config_path,
        'notify' => Service['zabbix-agent'],
    }
    $params = {
        '' => {
            'Server' => $server,
            'ServerActive' => $server_active,
            'Hostname' => $hostname,
        }
    }

    file { $scripts_path:
      ensure => directory,
    }

    create_ini_settings($params, $defaults)

    if($nginx){
        file { '/etc/zabbix/zabbix_agentd.d/nginx.conf':
            ensure  => present,
            content => template('zabbix/scripts/nginx.conf.erb'),
        }
    } else {
        file { '/etc/zabbix/zabbix_agentd.d/nginx.conf':
            ensure => absent,
        }
    }

    File['/etc/zabbix/zabbix_agentd.d/nginx.conf'] ~> Service['zabbix-agent']

    if($iostat){
        file { '/etc/zabbix/zabbix_agentd.d/iostat.conf':
            ensure  => present,
            content => template('zabbix/scripts/iostat.conf.erb'),
        }

        file { "${scripts_path}/iostat-discovery.sh":
            ensure  => present,
            mode    => '0755',
            content => template('zabbix/scripts/iostat-discovery.sh.erb'),
        }

        file { "${scripts_path}/iostat-cron.sh":
            ensure  => present,
            mode    => '0755',
            content => template('zabbix/scripts/iostat-cron.sh.erb'),
        }

        file { "${scripts_path}/iostat-check.sh":
            ensure  => present,
            mode    => '0755',
            content => template('zabbix/scripts/iostat-check.sh.erb'),
        }

        cron { 'iostat-cron':
          command => "${scripts_path}/iostat-cron.sh",
          user    => 'root',
        }

        File[$scripts_path] -> File["${scripts_path}/iostat-discovery.sh"]
        File[$scripts_path] -> File["${scripts_path}/iostat-cron.sh"]
        File[$scripts_path] -> File["${scripts_path}/iostat-check.sh"]

    } else {
        file { [
          '/etc/zabbix/zabbix_agentd.d/iostat.conf',
          "${scripts_path}/iostat-discovery.sh",
          "${scripts_path}/iostat-cron.sh",
          "${scripts_path}/iostat-check.sh",
          ]:
            ensure => absent,
        }

        cron { 'iostat-cron':
          ensure => absent,
        }
    }

    File['/etc/zabbix/zabbix_agentd.d/iostat.conf'] ~> Service['zabbix-agent']
}
