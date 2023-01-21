#!/usr/bin/bash

[ $# -eq 2 ] || exit 1

firstFile=$1
secondFile=$2

CountFirstFile=$(grep "${firstFile}" ${firstFile} | wc -l)
CountSecondFile=$(grep "${secondFile}" ${secondFile} | wc -l)

endFile=${firstFile}
if [ ${CountFirstFile} -lt ${CountSecondFile} ]; then
endFile=${secondFile}
fi

awk -F "-" '{print $2}' ${endFile} | sort > ${endFile}.songs


