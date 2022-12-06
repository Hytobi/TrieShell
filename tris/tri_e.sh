#!/bin/bash

#   -l : tri suivant le nombre de lignes des entrées ;

#!/bin/bash
# Test si le nombre de parametre est correct
[ $# -eq 0 ] && echo "Pas d'arguments" && exit 1

#initialisation
chaineRETOUR=""     # La chaine qui sera retournée         
chaineNOM="$@"      # On récupère les noms des fichiers / dossier etc... 
chaineINTER=""      # Cette chaine stock les proprietaires (User/groupe) ou la taille selon le tri

#On recupère les noms du propriétaire ou la taille selon le tri
i=0 && j=0
# Tant qu'on a pas fini de parcourire la chaine
while [ $i -lt ${#chaineNOM} ]
do
    # Tant qu'on a pas de separateur on incremente i
    while [ "${chaineNOM:$i:3}" != " //" ] ; do i=$[$i+1] ; done
    
    if [ -d "${chaineNOM:$j:$[$i-$j]}" ] 
    then
        rep="$rep${chaineNOM:$j:$[$i-$j]} // "
    else
        chaineINTER="$chaineINTER`basename "${chaineNOM:$j:$[$i-$j]}"|sed 's/.*\.//g'` // "
    fi
    j=$[$i+4] && i=$[$i+3]
done

# On affiche la chaine
chaineINTER=`./tris/tri_n.sh $chaineINTER`

# On recupère le nombre de mot dans la chaine
nbMot=`./util/compteMot.sh $chaineINTER`
i=0 && j=0 && tkmin=0 && tk=0
# Tant qu'on a pas recupere tout les mots
while [ $nbMot -gt 0 ]
do
    # On recupère le premier mot de la chaine qui sera le plus petit pour le momement
    while [ "${chaineINTER:$i:1}" != " " ]
    do
        i=$[$i+1]
        tkmin=$[$tkmin+1]
    done
    kmin=${chaineINTER:0:$i}
    
    while [ "${chaineINTER:$i:3}" != " //" ]
    do
        i=$[$i+1]
    done
    # On sauvegard le mot, sa position et la position du mot suivant
    motPlusPetit=${chaineINTER:0:$i} && iMin=$i && jMin=0 && j=$[$i+4] && i=$[$i+4]

    # $i est a la position du mot suivant, alors tant que $i est inferieur a la taille de la chaine
    while [ $i -lt ${#chaineINTER} ]
    do
        # On recupere le mot
        tk=0
        while [ "${chaineINTER:$i:1}" != " " ]
        do
            i=$[$i+1]
            tk=$[$tk+1]
        done
        k=${chaineINTER:$j:$[$i-$j]}
        while [ "${chaineINTER:$i:3}" != " //" ]
        do
            i=$[$i+1]
        done
        # $j est la position de la premiere lettre du mot et $i la pos de la derniere
        mot=${chaineINTER:$j:$[$i-$j]}
        echo "- $mot -"
        echo "-- `basename "${chaineNOM:$j:$[$i-$j]}"|sed 's/.*\.//g'` --"
        if [ $mot = " `basename "${chaineNOM:$j:$[$i-$j]}"|sed 's/.*\.//g'` " ]
        then
        echo "aa"
        fi
        j=$[$i+4] && i=$[$i+4]
    done
    nbMot=$[$nbMot-1] && i=0 && j=0 && tk=0 && tkmin=0
done

exit 0