class cron {
 if $hostname =~ /kci|wci|irs/ {
	$fname = "tomcat"
	}
 else { $fname = "jbinst" }

   file {"/var/spool/cron/root":
	ensure => file,
	owner => root,
	group => root,
	mode => 0600,
	source => "puppet:///modules/cron/root"
	}

   file {"/var/spool/cron/sumouser":
	ensure => file,
	owner => root,
	group => root,
	mode => 0600,
	source => "puppet:///modules/cron/sumouser",
	require => [ File["/opt/verizon"], User[sumouser] ]
	}

}
	
