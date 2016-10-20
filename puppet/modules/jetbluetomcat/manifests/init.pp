class jetbluetomcat { 

#include ::nodeinfo

 notify {"==== Validating  and OR Installing  files =====":}

## Change ownership of the directory

    file {"/opt/jetblue":
	ensure => directory,
	owner => jbcomp,
	group => jbcomp,
	mode => 0755,
	recurse => true,
	source => "puppet:///installer_files/jetblue",
	require => User["jbcomp"],
	}
->

## Create the link
    file {"/opt/jetblue/tomcat":
        ensure  => link,
        target  => 'apache-tomcat-6.0.35',
    }
    file {"/opt/jetblue/jetblue":
        ensure  => link,
        target  => 'jetblue-staticpages',
    }
    file {"/opt/jetblue/jdk":
        ensure  => link,
        target  => 'jdk1.6.0_45',
    }

   file { "/etc/init.d/jb_tomcat":
        ensure => link,
	target => "/opt/jetblue/totality/scripts/jb_tomcat",
    }
}
