#! /bin/bash

[ $# -eq 3 ] || exit 1

num=$1
prefSym=$2
unitSym=$3

pref=$(cat prefix.csv | tail -n +2 | grep ",$prefSym," )
unit=$(cat base.csv | tail -n +2 | grep ",$unitSym,")

[ -z $pref ] && exit 2
[ -z $unit ] && exit 3

prefNum=$(echo $pref | awk -F "," '{print $3}')
unitNameMeasure=$(echo $unit | awk -F "," '{print "("$1 ", " $3")"}' )
endNum=$(echo "${num} * ${prefNum}" | bc)

echo $endNum $unitSym $unitNameMeasure

