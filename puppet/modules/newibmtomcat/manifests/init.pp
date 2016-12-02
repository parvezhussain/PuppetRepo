class newibmtomcat { 

#include ::nodeinfo

 notify {"==== Validating and OR Installing  files and Packages ====":}

    exec {"newibmtest":
        command => '/bin/true',
        creates => '/opt/ibm/tomcat/bin/startup.sh',
        path => ["/bin","/usr/bin"]
       }

    file {"/tmp/ibm_build_clean_1.2.tgz":
        ensure => file,
        mode => "0644",
        replace => false,
        source => "puppet:///installer_files/ibm_build_clean_1.2.tgz",
        require => Exec["newibmtest"],
        }

## Unpack IBM Tarball
    exec {"unpack ibm_build":
        command => "/bin/tar -zxf /tmp/ibm_build_clean_1.2.tgz",
        cwd => "/opt",
        creates => '/opt/ibm/tomcat/bin/startup.sh',
        require => File["/tmp/ibm_build_clean_1.2.tgz"]
	}
    file {  "/opt/logs":
        owner => root,
        group => root,
        mode => "0775",
        ensure => directory,
        }->

    file { [ "/opt/logs/tomcat", "/opt/logs/tomcat/${hostname}" ]:
        owner => tomcat,
        group => tomcat,
        recurse => true,
        mode => "0775",
        ensure => directory,
        require => User["tomcat"],
        }

## Create the link
    file {"/opt/logs/tomcat/server":
        ensure  => link,
        target  => "${hostname}",
    }

   file { "/etc/init.d/tomcat":
        ensure          => link,
        target           => "/opt/ibm/scripts/ibm_tomcat",
        }



}
