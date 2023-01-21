#!/usr/bin/bash

[ $# -eq 1 ] || exit 1

#if [ "$EUID" -ne 0 ];then
# 	exit 1
#fi

FOO=$1


CF=$(ps -e -o user,pid,%cpu,%mem,vsz,rss,tty,stat,time,command | grep "^${FOO}" | wc -l)


Names=$(ps -e -o user | sort | uniq -c | awk -v var1="$1" -v var2="${CF}" 'var1 > var2 {print $2}')

echo "${Names}"
