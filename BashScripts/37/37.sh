#!/bin/bash
[ $# -eq 1 ] || exit 1

while read p; do
        count1=$(grep "$p" $1|grep "HTTP/2.0"|wc -l)
        count2=$(grep "$p" $1|grep -v "HTTP/2.0"|wc -l)
        clients=$(grep "$p" $1|awk '{if ($9>302) print $1}'|sort -k 1,1|uniq -c|sort|tail -n 5)
    echo $p HTTP/2.0: ${count1} nonHTTP/2.0: ${count2}
        echo ${clients}
done< <(awk '{print $2}' $1|sort|uniq -c|sort -r -k 1,1|head -n 3|awk '{print $2}')
