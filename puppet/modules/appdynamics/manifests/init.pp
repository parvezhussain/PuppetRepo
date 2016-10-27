class appdynamics { 
if $hostname =~ /kci|wci|irs/  {
        $fname = "tomcat"
        }
else { $fname = "jbinst" }

 notify {"==== Validating and OR Installing AppDynamics4.1.4.0 =====":}

$output = generate("/bin/bash", "-c", "/etc/puppet/modules/appdynamics/files/config/CreateXMLfile.sh $hostname")
 
    exec {"appdtest":
	command => '/bin/true',
	creates => '/opt/AppDynamics4.1.4.0/AppServerAgent-4.1.4.0/readme.txt',
	path => ["/bin","/usr/bin"]
       }

    file {"/tmp/AppDynamics4.1.4.0.tgz":
	ensure => file,
	mode => "0644",
	replace => false,
	source => "puppet:///installer_files/AppDynamics4.1.4.0.tgz",
	require => Exec["appdtest"],
#	require => [ File["/opt/puppet"], Exec["appdtest"] ],
	}
## Unpack AppD
    exec {"unpack AppDynamics":
        command => "/bin/tar -zxf /tmp/AppDynamics4.1.4.0.tgz",
        cwd => "/opt",
	creates => '/opt/AppDynamics4.1.4.0/AppServerAgent-4.1.4.0/readme.txt',
	require => File["/tmp/AppDynamics4.1.4.0.tgz"]
        }->


   file { "/opt/AppDynamics4.1.4.0/AppServerAgent-4.1.4.0/ver4.1.4.0/conf/controller-info.xml":
        ensure  => file,
        owner   => "$fname",
        group   => "$fname",
	require => User["$fname"],
        source  => "puppet:///modules/appdynamics/config/controller-info.xml_${hostname}_AppAgent",
        }
   file { "/opt/AppDynamics4.1.4.0/MachineAgent-4.1.4.0/conf/controller-info.xml":
        ensure  => file,
        owner   => "$fname",
        group   => "$fname",
	require => User["$fname"],
        source  => "puppet:///modules/appdynamics/config/controller-info.xml_${hostname}_MachineAgent",
        }

## Change ownership of the directory

   file {"/opt/AppDynamics4.1.4.0":
        ensure => directory,
        recurse => true,
        owner => "$fname",
        group => "$fname",
	require => [ User["$fname"], Exec["unpack AppDynamics"] ],
        }

## Create the link		
     file {"/opt/AppDynamics":		
         ensure  => link,		
         target  => 'AppDynamics4.1.4.0',		
	require => File["/opt/AppDynamics4.1.4.0"]
     }		
 

   file { "/etc/init.d/appdynamics":
        ensure          => file,
        owner           => root,
        group           => root,
        mode            => 750,
        source          => "puppet:///modules/appdynamics/config/appdynamics_${fname}",
        }
   
   exec { "AppD_gz_clean":
	command => "cat /dev/null > /tmp/AppDynamics4.1.4.0.tgz",
	onlyif => "test -f /tmp/AppDynamics4.1.4.0.tgz -a -s /tmp/AppDynamics4.1.4.0.tgz",
	path => ["/bin","/usr/bin"],
	require => Exec["unpack AppDynamics"]
	}

}

