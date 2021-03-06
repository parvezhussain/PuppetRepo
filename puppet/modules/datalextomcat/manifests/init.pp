class datalextomcat { 

#include ::nodeinfo

 notify {"==== Validating and OR Installing  files =====":}

## Change ownership of the directory

    file {"/opt/datalex":
	ensure => directory,
	owner => jbinst,
	group => jbinst,
	mode => 0755,
	recurse => true,
	source => "puppet:///installer_files/cui",
	require => User["jbinst"],
	}
->

## Create the link
    file {"/opt/datalex/tomcat":
        ensure  => link,
        target  => 'apache-tomcat-6.0.35',
    }

   file { "/etc/init.d/tdpcontrol-tomcat":
        ensure => link,
	target => "/opt/datalex/totality/tdpcontrol-tomcat",
    }
    file {"/datalex":
        ensure  => link,
        target  => '/opt/datalex',
    }

}
