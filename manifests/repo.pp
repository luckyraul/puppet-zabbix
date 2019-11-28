# == Class: zabbix::repo
class zabbix::repo (
    $zabbix_version = $zabbix::params::version,
    $repos   = 'main',
    $apt_key = {
        'id'     => 'FBABD5FB20255ECAB22EE194D13D58E479EA5ED4',
        'source' => 'http://repo.zabbix.com/zabbix-official-repo.key',
    }
) inherits zabbix::params {
    $operatingsystem = downcase($facts['os']['name'])
    $releasename = $facts['lsbdistcodename']

    case $facts['os']['name'] {
      'Ubuntu', 'Debian': {
        include apt

        apt::source { 'zabbix':
          location => "http://repo.zabbix.com/zabbix/${zabbix_version}/${operatingsystem}/",
          repos    => $repos,
          release  => $releasename,
          key      => $apt_key,
        }
      }
      'CentOS', 'Redhat': {
        $majorrelease = $facts['os']['release']['major']
        yumrepo { 'zabbix':
          name     => "Zabbix_${zabbix_version}_${operatingsystem}",
          descr    => "Zabbix_${zabbix_version}_${operatingsystem}",
          baseurl  => "https://repo.zabbix.com/zabbix/${zabbix_version}/rhel/${majorrelease}/\$basearch/",
          gpgcheck => '1',
          gpgkey   => 'https://repo.zabbix.com/RPM-GPG-KEY-ZABBIX-A14FE591',
          priority => '1',
        }
      }
      default: {
        fail("Unsupported os: ${facts['os']['name']}")
      }
    }
}
