#!/bin/bash
[ $# -eq 2 ] ||  exit 1
[ -f $1 ] ||  exit 2
[ -d $2 ] || exit 3

echo hostname,phy,vlans,hosts,failover,VPN-3DES-AES,peers,VLAN Trunk Ports,license,SN,key >> $1

while read i ; do
	
	hostname=$(basename -s ".log" $i)
	phy=$(grep "Maximum Physical Interfaces" $i | awk -F ":" '{print $2}' | sed "s/ //")
	vlan=$(grep "VLANs" $i | awk -F ":" '{print $2}' | sed "s/ //")
	host=$(grep "Inside Hosts" $i | awk -F ":" '{print $2}' | sed "s/ //")
	failover=$(grep "Failover" $i | awk -F ":" '{print $2}' | sed "s/ //")
	VPN=$(grep "VPN-3DES-AES" $i | awk -F ":" '{print $2}' | sed "s/ //")
	peers=$(grep "*Total VPN Peers" $i | awk -F ":" '{print $2}' | sed "s/ //")
	VLAN=$(grep "VLAN Trunk Ports" $i | awk -F ":" '{print $2}' | sed "s/ //")
	license=$(grep "This platform has" $i | cut -d " " -f 5- | rev | cut -d " " -f 2- | rev)
	SN=$(grep "Serial Number" $i | awk -F ":" '{print $2}' | sed "s/ //")
	key=$(grep "Running Activation Key" $i | awk -F ":" '{print $2}' | sed "s/ //")
	
	echo ${hostname}','${phy}','${vlan}','${host}','${failover}','${VPN}','${peers}','${VLAN}','${license}','${SN}','${key} >> $1

done < <(find $2 -type f)





#!/bin/bash
[ $#==2 ]  exit 1
[ -f $1 ]  exit 2
[ -d $2 ] || exit 3
count=0
echo hostname,phy,vlans,hosts,failover,VPN-3DES-AES,peers,VLAN Trunk Ports,license,SN,key>>$1
while read p; do
      count=0
	  data=""
	 while read i;  do
	    if [ $count -eq 0 ]; then
	        data=$(basename -s ".log" $p)
		elif [ $count -eq 8 ]; then
		    data=$(echo $i|cut -d " " -f 5-|rev|cut -d " " -f 2-|rev)
		else
		    data=$(echo $i|cut -d ":" -f 2)
		fi
		count=$((count+1))
		echo -n ${data},>>$1
	 done< <(cat $p)
	 echo "" >> $1
done< <(find $2 -type f )
