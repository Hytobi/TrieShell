#!/bin/bash
#   -l : tri suivant le nombre de lignes des entrées ;

# Test si le nombre de parametre est correct
[ $# -eq 0 ] && echo "Pas d'arguments" && exit 1

#initialisation
chaineRETOUR=""     # La chaine qui sera retournée         
chaineNOM="$@"      # On récupère les noms des fichiers / dossier etc... 
chaineINTER=""      # Cette chaine stock le nombre de ligne de chaque fichier
rep=""              # Chaine qui contient seulement nos répertoires car ils n'ont pas de ligne

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
        chaineINTER="$chaineINTER`wc -l "${chaineNOM:$j:$[$i-$j]}"` // "
    fi
    j=$[$i+4] && i=$[$i+3]
done
# On recupère le nombre de mot dans la chaine
nbMot=`./util/compteMot.sh $chaineINTER`
i=0 && j=0 && tkmin=0 && tk=0
# Tant qu'on a pas recupere tout les mots
while [ $nbMot -gt 0 ]
do
    # On recupère la taille du nombre de ligne pour la retirer ensuite
    while [ "${chaineINTER:$i:1}" != " " ]
    do
        i=$[$i+1]
        tkmin=$[$tkmin+1]
    done
    kmin=${chaineINTER:0:$i}
    # On recupère le premier mot de la chaine qui sera le plus petit pour le momement
    while [ "${chaineINTER:$i:3}" != " //" ]
    do
        i=$[$i+1]
    done
    # On sauvegard le mot, sa position et la position du mot suivant
    motPlusPetit=${chaineINTER:0:$i} && iMin=$i && jMin=0 && j=$[$i+4] && i=$[$i+4]

    # $i est a la position du mot suivant, alors tant que $i est inferieur a la taille de la chaine
    while [ $i -lt ${#chaineINTER} ]
    do
        # On recupere la taille du nombre de ligne pour la retirer ensuite
        tk=0
        while [ "${chaineINTER:$i:1}" != " " ]
        do
            i=$[$i+1]
            tk=$[$tk+1]
        done
        k=${chaineINTER:$j:$[$i-$j]}
        # On recupere le mot
        while [ "${chaineINTER:$i:3}" != " //" ]
        do
            i=$[$i+1]
        done
        # $j est la position de la premiere lettre du mot et $i la pos de la derniere
        mot=${chaineINTER:$j:$[$i-$j]}

        # On compare le mot avec le mot plus petit
        if [ $k -lt $kmin ]
        then
            #Si mot est plus petit alors on le sauvegarde
            kmin=$k && tkmin=$tk && motPlusPetit=$mot && iMin=$i && jMin=$j
        fi
        #on avance dans la chaine
        j=$[$i+4] && i=$[$i+4]
    done
    # On suavegarde le mot plus petit dans la chaine de retour
    chaineRETOUR=$chaineRETOUR${motPlusPetit:$tkmin}" // "
    # On supprime le mot plus petit de la chaine
    chaineINTER=${chaineINTER:0:$jMin}${chaineINTER:$[$iMin+4]}
    #Si on a enlevé le mot de la fin il y a un espace en trop
    [ "${chaineINTER:$[${#chaineINTER}-1]:1}" = " " ] && chaineINTER=${chaineINTER:0:$[${#chaineINTER}-1]}
    # On reinitialise les variables et met a jour le nombre de mot
    nbMot=$[$nbMot-1] && i=0 && j=0 && tk=0 && tkmin=0
done

# on affiche du plus petit au plu grand, on considère que les repertoires ont 0 ligne
echo "$rep ${chaineRETOUR:0:$[${#chaineRETOUR}-1]}"

exit 0