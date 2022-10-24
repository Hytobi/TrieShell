#!/bin/bash

#On test si on a bien un au moins un argument
[ $# -eq 0 ] && echo "Usage : $0 <chaine>" && exit 1

chaine="$@"
newCH=""
i=0
j=0
while [ $i -lt ${#chaine} ] 
do
    if [ "${chaine:$i:4}" = " // " ]
    then
        k=$[$i-$j+4]
        newCH=${chaine:$j:$k}$newCH
        j=$[$i+4] && i=$[$i+4]
        continue
    fi
    i=$[$i+1]
done
newCH=${chaine:$[$j-3]:${#chaine}}" "$newCH
echo $newCH

