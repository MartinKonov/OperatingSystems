#! /bin/bash
[ $# -ge 3 ]  exit 1
[ $(echo $@|grep -o "-jar" |wc -l) -eq 1 ]   exit 2
[ $1 == "java" ] || exit 3
jarLocation=$(echo $@|awk '{for(i=1;i<=NF;i++){ if($i=="-jar") print i} }')
alldLocation=$(echo $@|awk '{output=""; for(i=1;i<=NF;i++){ if($i~ /^-D.+=./) output=output" "$i} print output}')
allDash=$(echo $@|awk '{ output=""; for(i=1;i<=NF;i++){ if($i!~/^-jar/ && $i!~/^-D./ && $i~/^-./) output=output" "$i} print output}')
path=$(echo $@|awk '{output=""; for(i=1;i<=NF;i++){if($i~/..jar/) output=$i } print output}')
echo $( java ${alldLocation} -jar ${path} ${allDash}
