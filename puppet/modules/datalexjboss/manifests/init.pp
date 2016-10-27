class datalexjboss { 

include ::nodeinfo

notify {"==== Validating and OR Installing  jboss-5.1.0 =====":}

    exec {"datalexjbosstest":
        command => '/bin/true',
        creates => '/opt/datalex/jboss-5.1.0.GA/readme.html',
        path => ["/bin","/usr/bin"]
       }


    file {"/tmp/jboss-5.1.0.GA-jdk6.zip":
	ensure  => file,
	mode    => "0644",
	replace => false,
	source  => "puppet:///installer_files/jboss-5.1.0.GA-jdk6.zip",
	require => Exec["datalexjbosstest"],
	}

## Unpack jboss
    exec {"unpack jboss-5.1.0":
        command  => "/usr/bin/unzip /tmp/jboss-5.1.0.GA-jdk6.zip", 
        cwd      => "/opt/datalex",
	creates  => "/opt/datalex/jboss-5.1.0.GA/readme.html",
	require  => File["/tmp/jboss-5.1.0.GA-jdk6.zip"]
        }

## Change ownership of the directory

    file {"/opt/datalex/jboss-5.1.0.GA":
        ensure   => directory,
        owner    => jbinst,
        group    => jbinst,
        recurse  => true,
        require  => [User["jbinst"], Exec["unpack jboss-5.1.0"]]
        }

## Create the link
    file {"/opt/datalex/jboss":
        ensure  => link,
        target  => 'jboss-5.1.0.GA',
        require => File["/opt/datalex/jboss-5.1.0.GA"]
    }

    file {"/opt/datalex/totality":
        ensure => directory,
        owner => jbinst,
        group => jbinst,
        mode => 755,
        recurse => true,
        source => "puppet:///modules/datalexjboss/totality",
        }
   file { "/etc/init.d/tdpcontrol-jboss":
        ensure => link,
        target => "/opt/datalex/totality/tdpcontrol-jboss",
        require => File["/opt/datalex/totality"]
        }

   exec { "jboss.zip clean":
        command => "cat /dev/null > /tmp/jboss-5.1.0.GA-jdk6.zip",
        onlyif  => "test -f /tmp/jboss-5.1.0.GA-jdk6.zip -a -s /tmp/jboss-5.1.0.GA-jdk6.zip",
        path    => ["/bin","/usr/bin"],
        require => Exec["unpack jboss-5.1.0"]
        }
}
