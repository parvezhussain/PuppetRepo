#!/bin/sh
#
AUDITLOG=/opt/logs/puppet                   # log dir
DATE=$(date +%d%b%Y_%H:%M)
PROGRAM=`basename $0`
HOSTNAME=`uname -n`                                     # current host name
USERNAME=`id -un`                                       # current user name
ARGS=$@
LOGFILE=$AUDITLOG/$PROGRAM.log             # Log file
 
mkdir -p $AUDITLOG 2>/dev/null
 
if [ -f /tmp/$PROGRAM.lock ]; then
        echo -e "\n\t date +%d%b%Y_%H:%M:%S -- /tmp/$PROGRAM.lock file found....."  2>&1 >> $LOGFILE
        echo -e "\t date +%d%b%Y_%H:%M:%S -- Another program is running......Exiting"  2>&1 >> $LOGFILE
        exit 1
fi
 
touch /tmp/$PROGRAM.lock
echo -e "\n\n=========================================" >> $LOGFILE
echo -e "DATE=$(date +%d%b%Y_%H:%M)" >> $LOGFILE
/usr/bin/puppet agent -tv 2>&1 >> $LOGFILE
rm -rf /tmp/$PROGRAM.lock  2>&1 > /dev/null
exit 0
