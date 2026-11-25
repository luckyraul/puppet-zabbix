# == Class: zabbix::repo
# Configure package repository
class zabbix::repo {
  assert_private()
  case $facts['os']['name'] {
    'Debian','Ubuntu': {
      include zabbix::repo::debian
    }
    default: {
      fail("Unsupported os: ${facts['os']['name']}")
    }
  }
}
