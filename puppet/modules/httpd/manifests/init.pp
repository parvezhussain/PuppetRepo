class httpd {
	package { 'httpd' :
		ensure => present,
		}
	->
	file { '/etc/httpd/conf/httpd.conf' :
		ensure => file,
		mode => 0644,
		source => 'puppet:///modules/httpd/httpd.conf',
		}
	service { 'httpd' :
		ensure => running,
		enable => true,
		subscribe => File['/etc/httpd/conf/httpd.conf']
		}
	}
