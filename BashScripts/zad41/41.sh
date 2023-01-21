#!/bin/bash
[ $# -eq 3 ]  exit 1
[ -f $1 ]  exit 2
key=$2
value=$3
if [ $(egrep -c "^ ${key}=" $1) -eq 0 ]; then
        echo ${key} = ${value} # added at $(date) by $USER >> $1
else
        line=$(egrep "^ ${key}=" $1)
        sed -E -i "s/^ ${key}= *.+/# ${line} edited at $(date) by ${USER}\n ${key} = ${value} # added at $(date) by $USER/" $1
fi
