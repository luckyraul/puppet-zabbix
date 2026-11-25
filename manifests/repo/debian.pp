# Configure the official Zabbix APT repository.
#
# Supports Debian and Ubuntu distributions.
#
# @param version
#   Zabbix repository version to configure (for example, '7.0' or '8.0').
#   Defaults to the Zabbix agent package version.
#
class zabbix::repo::debian (
  String[1] $version = $zabbix::agent_package_version,
) {
  assert_private()
  include apt

  $codename = $facts['os']['distro']['codename']
  $architecture = regsubst($facts['os']['architecture'], '\baarch64\b', 'arm64')
  $distribution = $facts['os']['name'].downcase

  # Remove legacy repository configuration.
  file { '/etc/apt/sources.list.d/zabbix.list':
    ensure => absent,
  }

  # Install the official Zabbix repository signing key.
  apt::keyring { 'zabbix.asc':
    source => 'https://repo.zabbix.com/zabbix-official-repo.key',
  }

  # Configure the Zabbix repository.
  apt::source { 'zabbix':
    ensure        => present,
    enabled       => true,
    source_format => 'sources',
    location      => ["https://repo.zabbix.com/zabbix/${version}/stable/${distribution}"],
    release       => [$codename],
    repos         => ['main'],
    architecture  => [$architecture],
    keyring       => '/etc/apt/keyrings/zabbix.asc',
    require       => Apt::Keyring['zabbix.asc'],
  }
  Exec['apt_update'] -> Package['zabbix-agent']
}
