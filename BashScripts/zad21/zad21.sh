#!/usr/bin/bash

[ $# -eq 3 ] || exit 1

File=$1
K1=$2
K2=$3

V1=$(grep "${K1}=" ${File} | awk -F "=" '{print $2}')
V2=$(grep "${K2}=" ${File} | awk -F "=" '{print $2}')


NV=$(comm -13 <(echo ${V1} | tr ' ' '\n' | sort) <(echo ${V2} | tr ' ' '\n' | sort) | xargs)

sed -i "s/${K2}=${V2}/${K2}=${NV}/" ${File}
