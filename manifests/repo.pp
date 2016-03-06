# == Class: zabbix::repo
class zabbix::repo(
    $zabbix_version = $zabbix::version,
    $repos   = 'main',
    $apt_key = {
        'id'     => 'FBABD5FB20255ECAB22EE194D13D58E479EA5ED4',
        'source' => 'http://repo.zabbix.com/zabbix-official-repo.key',
    }
)
{
    $location = "http://repo.zabbix.com/zabbix/${zabbix_version}/${::operatingsystem}/"

    include apt

    apt::source { 'zabbix':
        location => $location,
        repos    => $repos,
        release  => $::releasename,
        key      => $apt_key,
    }

    Exec['apt_update'] -> Package['zabbix-agent']
}
