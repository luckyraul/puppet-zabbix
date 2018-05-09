# == Class: zabbix::repo
class zabbix::repo (
    $zabbix_version = $zabbix::params::version,
    $repos   = 'main',
    $apt_key = {
        'id'     => 'FBABD5FB20255ECAB22EE194D13D58E479EA5ED4',
        'source' => 'http://repo.zabbix.com/zabbix-official-repo.key',
    }
) inherits zabbix::params {
    $downcase_os = downcase($::operatingsystem)
    $location = "http://repo.zabbix.com/zabbix/${zabbix_version}/${downcase_os}/"

    include apt

    apt::source { 'zabbix':
        location => $location,
        repos    => $repos,
        release  => $::releasename,
        key      => $apt_key,
    }
}
