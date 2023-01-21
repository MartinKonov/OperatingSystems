#!/bin/bash

[ $# -eq 2 ] || exit 1

a=$1
b=$2

sort -t ',' -k 2 $a | sed "s/,/\t/" | uniq -f 1 | tr '\t' ',' > $b

