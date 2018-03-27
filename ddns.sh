#!/bin/bash
domain=example.com
subDomain=example
recordId=123456
recordLine=默认
ip=$(curl --retry 5 --retry-delay 20 -s icanhazip.com)
touch /var/tmp/local_ip
LOCAL_IP=`cat /var/tmp/local_ip`
if [ "$LOCAL_IP" == "$ip" ] ;then
logger "DDNS" "Local IP has not changed!"
exit 0
fi
LOG=`qcloudcli cns RecordModify --domain $domain --subDomain $subDomain --recordType A --recordLine $recordLine --recordId $recordId --value $ip`
echo $ip > /var/tmp/local_ip
logger "DDNS" $LOG
