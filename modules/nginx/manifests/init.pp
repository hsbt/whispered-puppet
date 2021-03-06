class nginx ($user="whispered"){
  package { "nginx":
    ensure => present,
  }

  file { "/etc/nginx/nginx.conf":
    ensure => present,
    content => template("nginx/nginx.conf"),
    require => Package['nginx'],
  }

  file { "/etc/nginx/conf.d/default.conf":
    ensure => present,
    content => template("nginx/default.conf"),
    require => Package['nginx'],
  }

  service { "nginx":
    ensure => "running",
    require => [
      File["/etc/nginx/nginx.conf"],
      File["/etc/nginx/conf.d/default.conf"],
    ]
  }
}
