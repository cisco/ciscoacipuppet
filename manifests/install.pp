# Private class
class cisco_aci::install {
  $gems = [ 'httpclient', 'nokogiri' ]

  package { $gems:
    ensure   => present,
    provider => 'puppet_gem',
  }

  case $::operatingsystem {
    'CentOS': {
      $packages = [ 'gcc', 'zlib-devel' ]

      package { $packages:
        ensure  => present,
        before  => Package['nokogiri'],
      }
    }
  }
}
