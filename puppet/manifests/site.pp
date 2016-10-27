notify {"Agent connection is successful":}

node default {
include cron
include verizonscripts
}

node 'pxeclient.localhost.com' {
	include httpd
	include accounts
	realize (Accounts::Myuser['johndoe'])
	realize (Accounts::Myuser['adil'])
}

node 'peclient2.localhost.com' {
	include accounts
	realize (Accounts::Localuser['amar'])
	realize (Accounts::Localuser['johndoe'])
#	include appdynamics
}

node /^peclient.*\.localhost\.com$/ {
	include accounts
#	realize (Accounts::Localuser['johndoe'])
	realize (Accounts::Localuser['amar'])
	realize (Accounts::Sshkey['amar'])
	include appdynamics
}

node /.*(kci|cts|irs|wci|css).*\.localhost\.com$/ {
	include accounts
	realize (Accounts::Localuser['tomcat'])
#	realize (Accounts::Sshkey['tomcat'])
	realize (Accounts::Localuser['sumouser'])
	include ntp
	include appdynamics
#	include misc
	include cron
	include verizonscripts
	include ibmtomcat

}

node /.*cui.*\.localhost\.com$/ {
        include accounts
        realize (Accounts::Localuser['jbinst'])
        realize (Accounts::Localuser['sumouser'])
        realize (Accounts::Localuser['jbcomp'])
#        include nodeinfo
	include httpd
	include ntp
#	include misc
        include appdynamics
        include cron
        include verizonscripts
        include datalextomcat
        include jetbluetomcat
}



node /.*tdp.*\.localhost\.com$/ {
	include accounts
	realize (Accounts::Localuser['jbinst'])
	realize (Accounts::Localuser['sumouser'])
	include nodeinfo
	include ntp
	include appdynamics
	include cron
	include verizonscripts
#	include all_facts_file
#	include test1
	include datalexjboss
#	notify { $::hello: }
#	notify { $::info[CODEDIR]: }
}
