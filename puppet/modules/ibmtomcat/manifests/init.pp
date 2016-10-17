class ibmtomcat { 

#include ::nodeinfo

 notify {"==== Validating and OR Installing  files and Packages ====":}

    file {"/opt/ibm":
	owner => tomcat,
	group => tomcat,
	recurse => true,
	mode => "0775",
	ensure => directory,
	source => "puppet:///installer_files/wci/ibm",
	require => User["tomcat"],
	}

## Create the link
    file {"/opt/ibm/app":
        ensure  => link,
        target  => 'wci',
    }

    file {"/ibm":
        ensure  => link,
        target  => '/opt/ibm',
    }

    file {"/opt/ibm/wci/tomcat/webapps/WCI.war":
        ensure  => link,
        target  => '/opt/ibm/Release/WCI-v8.1.1.war',
    }

    file {"/opt/ibm/wci/java":
        ensure  => link,
        target  => '/usr/lib/jvm/jre-1.8.0-openjdk.x86_64',
    }

   file { "/etc/init.d/tomcat":
        ensure          => file,
        owner           => root,
        group           => root,
        mode            => 750,
        source          => "puppet:///modules/ibmtomcat/tomcat",
        }
}
