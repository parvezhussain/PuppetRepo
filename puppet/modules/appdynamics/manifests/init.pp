class appdynamics { 
if $hostname =~ /kci|wci|irs/  {
        $fname = "tomcat"
        }
else { $fname = "jbinst" }

# notify {"==== Validating and OR Installing AppDynamics4.1.4.0 =====":}

    file {"/opt/puppet/AppDynamics4.1.4.0.tgz":
	owner => "$fname",
	group => "$fname",
	mode => "0775",
	ensure => present,
	source => "puppet:///installer_files/AppDynamics4.1.4.0.tgz",
	require => File["/opt/puppet"],
#	require => User["$fname"],File["/opt/puppet"],
	notify  => Exec["unpack AppDynamics"]
	}->

## Unpack AppD
    exec {"unpack AppDynamics":
	command => "/bin/tar -zxf /opt/puppet/AppDynamics4.1.4.0.tgz",
	cwd => "/opt",
	refreshonly => true
	}->

## Change ownership of the directory

   file {"/opt/AppDynamics4.1.4.0":
        ensure => directory,
        recurse => true,
        owner => "$fname",
        group => "$fname",
#        mode => "0755"
        }->

## Create the link
    file {"/opt/AppDynamics":
        ensure  => link,
        target  => 'AppDynamics4.1.4.0',
    }

$output = generate("/bin/bash", "-c", "/etc/puppet/modules/appdynamics/files/config/CreateXMLfile.sh $hostname")

   file { "/opt/AppDynamics4.1.4.0/AppServerAgent-4.1.4.0/ver4.1.4.0/conf/controller-info.xml":
        ensure          => file,
        owner           => $fname,
        group           => $fname,
        mode            => 750,
        source          => "puppet:///modules/appdynamics/config/controller-info.xml_${hostname}_AppAgent",
#       require         => [ User[$owner], Group[$group] ],
        }
   file { "/opt/AppDynamics4.1.4.0/MachineAgent-4.1.4.0/conf/controller-info.xml":
        ensure          => file,
        owner           => $fname,
        group           => $fname,
        mode            => 750,
        source          => "puppet:///modules/appdynamics/config/controller-info.xml_${hostname}_MachineAgent",
        }
   file { "/etc/init.d/appdynamics":
        ensure          => file,
        owner           => root,
        group           => root,
        mode            => 750,
        source          => "puppet:///modules/appdynamics/config/appdynamics_${fname}",
        }


}

