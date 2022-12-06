#!/bin/bash
# 1 mot est séparé par //

# Initialisation
maChaine="$@" # On récupère la chaine
nbMot=0 && i=0

# Tant qu'on a pas parcouru toute la chaine
while [ $i -lt ${#maChaine} ]
do
    if [ "${maChaine:$i:3}" = " //" ]
    then
        # On incrémente le nombre de mot
        nbMot=$[$nbMot+1]
        i=$[$i+3]
    fi
    i=$[$i+1]
done

echo $nbMot
exit 0