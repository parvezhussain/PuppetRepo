class ntp {
	package { 'ntp' :
		ensure => present,
		}
	->
	file { '/etc/ntp.conf' :
		ensure => file,
		mode => 0644,
		source => 'puppet:///modules/ntp/ntp.conf',
		}
	service { 'ntpd' :
		ensure => running,
		enable => true,
		subscribe => File['/etc/ntp.conf']
		}
	}
