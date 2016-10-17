
class nodeinfo () {

 if $hostname  =~ /tdp/ { 
	$CodeSrcDir = "TDP" 
	$CodeDestDir = "/opt/datalex"
	$fname = "jbinst" 
	}
 if $hostname  =~ /cui/ {
        $CodeSrcDir = "CUI"
        $CodeDestDir = "/opt/datalex"
        $fname = "jbinst"
        }
 if $hostname  =~ /aui/ {
        $CodeSrcDir = "AUI"
        $CodeDestDir = "/opt/datalex"
        $fname = "jbinst"
        }
 if $hostname  =~ /rst/ {
        $CodeSrcDir = "RST"
        $CodeDestDir = "/opt/datalex"
        $fname = "jbinst"
        }
 if $hostname  =~ /mui/ {
        $CodeSrcDir = "MUI"
        $CodeDestDir = "/opt/datalex"
        $fname = "jbinst"
        }
 if $hostname  =~ /kci/ {
        $CodeSrcDir = "KCI"
        $CodeDestDir = "/opt/ibm"
        $fname = "tomcat"
        }

 if $hostname  =~ /kci/ {
        $CodeSrcDir = "KCI"
        $CodeDestDir = "/opt/ibm"
        $fname = "tomcat"
        }

 if $hostname  =~ /wci/ {
        $CodeSrcDir = "WCI"
        $CodeDestDir = "/opt/ibm"
        $fname = "tomcat"
        }

 if $hostname  =~ /irs/ {
        $CodeSrcDir = "IRS"
        $CodeDestDir = "/opt/ibm"
        $fname = "tomcat"
        }

 if $hostname  =~ /css/ {
        $CodeSrcDir = "CSS"
        $CodeDestDir = "/opt/ibm"
        $fname = "tomcat"
        }

 if $hostname  =~ /cts/ {
        $CodeSrcDir = "CTS"
        $CodeDestDir = "/opt/ibm"
        $fname = "tomcat"
        }

notify {"$CodeSrcDir $CodeDestDir $fname":}

   file {"/opt/puppet":
        ensure => directory,
        owner => puppet,
        group => puppet,
        mode => 0755
       }


   file {"$CodeDestDir":
        ensure => directory,
	replace => no,
        owner => $fname,
        group => $fname,
  	recurse => true,
       mode => 0755,
        }
}
