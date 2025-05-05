# == Class: zabbix::packages

class zabbix::packages (
  $agent_version      = $zabbix::agent_version,
  $agent_ensure       = $zabbix::agent_ensure,
  $agent_package_name = $zabbix::agent_package_name
)  inherits zabbix::params {
  case $facts['os']['name'] {
    'Ubuntu', 'Debian': {
      Exec['apt_update'] -> Package['zabbix-agent']
    }
    default: {}
  }

  if ($agent_package_name != undef) {
    $real_package_name = $agent_package_name
  } else {
    case $agent_version {
      2: {
        $real_package_name = $zabbix::params::agent2_package_name
      }
      default: {
        $real_package_name = $zabbix::params::agent_package_name
      }
    }
  }

  package { 'zabbix-agent':
    ensure => $agent_ensure,
    name   => $real_package_name,
  }
}
