#!/bin/bash

#On test si on a bien un au moins un argument
[ $# -eq 0 ] && echo "Usage : $0 <chaine>" && exit 1

#Initialisation
chaine="$@" # On récupère la chaine
newCH=""
i=0 && j=0

# Tant qu'on a pas parcouru toute la chaine
while [ $i -lt ${#chaine} ] 
do
    # Tant qu'on a pas de separateur on incremente i
    # Si on a un separateur
    if [ "${chaine:$i:4}" = " // " ]
    then
        # On ajoute le mot à la nouvelle chaine
        k=$[$i-$j+4]
        newCH=${chaine:$j:$k}$newCH
        j=$[$i+4] && i=$[$i+4]
        continue
    fi
    i=$[$i+1]
done
# On ajoute le dernier mot à la nouvelle chaine
newCH=${chaine:$[$j-3]:${#chaine}}" "$newCH

echo $newCH
exit 0