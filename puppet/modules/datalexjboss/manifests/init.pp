class datalexjboss { 

include ::nodeinfo

# notify {"==== Validating and OR Installing  jboss-5.1.0 =====":}

    file {"/opt/puppet/jboss-5.1.0.GA-jdk6.zip":
	owner => jbinst,
	group => jbinst,
	mode => "0775",
	ensure => present,
	source => "puppet:///installer_files/jboss-5.1.0.GA-jdk6.zip",
	require => User["jbinst"],
	notify  => Exec["unpack jboss-5.1.0"]
	}->

## Unpack jboss
    exec {"unpack jboss-5.1.0":
        command => "/usr/bin/unzip /opt/puppet/jboss-5.1.0.GA-jdk6.zip", 
	creates => "/opt/datalex/jboss-5.1.0.GA",	##execute only if dir does not exist
        cwd => "/opt/datalex",
#        refreshonly => true
        }->

## Change ownership of the directory

    file {"/opt/datalex/jboss-5.1.0.GA":
	ensure => directory,
	owner => jbinst,
	group => jbinst,
	recurse => true,
	}

## Create the link
    file {"/opt/datalex/jboss":
        ensure  => link,
        target  => 'jboss-5.1.0.GA',
    }

   file { "/etc/init.d/tdpcontrol-jboss":
        ensure          => file,
        owner           => root,
        group           => root,
        mode            => 750,
        source          => "puppet:///modules/datalexjboss/tdpcontrol-jboss",
        }
}
