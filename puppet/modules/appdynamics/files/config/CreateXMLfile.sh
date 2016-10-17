#!/bin/bash

#/etc/puppet/modules/appdynamics/files/config/CreateXMLfile.sh


PROGRAM=$0
PWD=`dirname $PROGRAM`

HOSTNAME=$1
APPAGENT=controller-info.xml_${HOSTNAME}_AppAgent
MACHINEAGENT=controller-info.xml_${HOSTNAME}_MachineAgent


NUM=`echo $HOSTNAME | awk '{print substr($0,11,1)}'`
case $NUM in
   1)  ENV=PROD;;
   2)  ENV=STAGE;;
   4)  ENV=QA;;
   7)  ENV=INT;;
   9)  ENV=DEV;;
esac
if [ `echo $HOSTNAME | egrep "jbcc"` ]; then
	DC=CUL
else
	DC=EGW
fi
APPNAME="CTR ${ENV}${DC}"

APP=`echo $HOSTNAME | awk '{print substr($0,7,3)}' | tr '[:lower:]' '[:upper:]'`
TIER="CTR $APP"

CTR_TDP_CHK="tdpc4006|tdpc1127|tdpc1128|tdpc1129|tdpc1130"
CTR_TDP_FLB="tdpc4002|tdpc4003|tdpc111|tdpc1120"
CTR_TDP_RST="tdpc4004|tdpc1121|tdpc1122|tdpc1123|tdpc1124|tdpc112|tdpc1126"

if [ `echo $HOSTNAME | egrep ${CTR_TDP_CHK}` ]; then
    TIER="CTR TDP CHK"
fi

if [ `echo $HOSTNAME | egrep ${CTR_TDP_FLB}` ]; then
    TIER="CTR TDP FLB"
fi
if [ `echo $HOSTNAME | egrep ${CTR_TDP_RST}` ]; then
    TIER="CTR TDP RST"
fi


if [ ! -s $PWD/$APPAGENT ]; then
    cp $PWD/controller-info.xml_AppAgent $PWD/$APPAGENT
    perl -pi -e "s/SERVER/$HOSTNAME/g" $PWD/$APPAGENT
    perl -pi -e "s/TIER/$TIER/g" $PWD/$APPAGENT
    perl -pi -e "s/APPNAME/$APPNAME/g" $PWD/$APPAGENT
fi

if [ ! -s $PWD/$MACHINEAGENT ]; then
    cp $PWD/controller-info.xml_MachineAgent $PWD/$MACHINEAGENT
    perl -pi -e "s/SERVER/$HOSTNAME/g" $PWD/$MACHINEAGENT
    perl -pi -e "s/TIER/$TIER/g" $PWD/$MACHINEAGENT
    perl -pi -e "s/APPNAME/$APPNAME/g" $PWD/$MACHINEAGENT  
fi
