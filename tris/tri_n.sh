#!/bin/bash

#   -n : tri suivant le nom des entrées ;

[ $# -eq 0 ] && echo "Pas d'arguments" && exit 1

# Initialisation
maChaine="$@"           # $@ contient deja tout les noms de fichier
chaineRETOUR=""         # La chaine qu'on renvoie
nbMot=0                 # Nombre de mot dans la chaine   
i=0

#motPlusPetit=`./util/recupNom.sh $@`

# On recupère le nombre de mot dans la chaine
nbMot=`./util/compteMot.sh $@`


# Tant qu'on a pas recupere tout les mots
while [ $nbMot -gt 0 ]
do
    # On recupère le premier mot de la chaine qui sera le plus petit pour le moement
    while [ "${maChaine:$i:3}" != " //" ]
    do
        i=$[$i+1]
    done
    # On sauvegard le mot, sa position et la position du mot suivant
    motPlusPetit=${maChaine:0:$i} && iMin=$i && jMin=0 && j=$[$i+4] && i=$[$i+4]

    # $i est a la position du mot suivant, alors tant que $i est inferieur a la taille de la chaine
    while [ $i -lt ${#maChaine} ]
    do
        # On recupere le mot
        while [ "${maChaine:$i:3}" != " //" ]
        do
            i=$[$i+1]
        done
        # $j est la position de la premiere lettre du mot et $i la pos de la derniere
        mot=${maChaine:$j:$[$i-$j]}

        # On compare le mot avec le mot plus petit
        if [ "$mot" \< "$motPlusPetit" ]
        then
            #Si mot est plus petit alors on le sauvegarde
            motPlusPetit=$mot && iMin=$i && jMin=$j
        fi
        #on avance dans la chaine
        j=$[$i+4] && i=$[$i+3]
    done
    # On suavegarde le mot plus petit dans la chaine de retour
    chaineRETOUR=$chaineRETOUR$motPlusPetit" // "
    # On supprime le mot plus petit de la chaine
    maChaine=${maChaine:0:$jMin}${maChaine:$[$iMin+4]}
    #Si on a enlevé le mot de la fin il y a un espace en trop
    [ "${maChaine:$[${#maChaine}-1]:1}" = " " ] && maChaine=${maChaine:0:$[${#maChaine}-1]}
    # On reinitialise les variables et met a jour le nombre de mot
    nbMot=$[$nbMot-1] && i=0 && j=0
done

# On affiche la chaine
echo $chaineRETOUR