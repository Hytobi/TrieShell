#!/bin/bash

#On test si on a bien un au moins un argument
[ $# -eq 0 ] && echo "Usage : $0 <chaine>" && exit 1

# Initialisation
chaine="$@" # On récupère la chaine
newCH="" && i=0 && j=0

# Tant qu'on a pas parcouru toute la chaine
while [ $i -lt ${#chaine} ] 
do
    if [ "${chaine:$i:4}" = " // " ]
    then
        k=$[$i-$j+4]
        newCH=$newCH${chaine:$j:$k}
        j=$[$i+4] && i=$[$i+4]
        continue
    fi
    i=$[$i+1]
done

newCH=$newCH${chaine:$j:$[${#chaine}-$j+4]}
echo $newCH
exit 0