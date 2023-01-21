#!/bin/bash
[ $# -eq 0 ]  exit 1
[ $USER == oracle ]  [ $USER == grid ] || exit 2
hasVar=$(find /home/students/$USER -type f -name "ORACLE_HOME")

[ ${hasVar} -gt 0 ] || exit 3

path=$(cat /home/students/$USER/ORACLE_HOME|head -n 1)

hasadrci=$(find ${path}/bin -type f -name "adrci")

[ $(echo hasadrci|wc -c) -gt 0 ] || exit 4

result=$(${hasadrci} "show homes")

[ $(echo result| grep -c "No ADR homes are set") -gt 0 ] || exit 5

while read p; do

	sz=$(stat -c %s /u01/app/${USER}/${p})

	echo ${sz} /u01/app/${USER}/${p}

done< <(echo ${result})
