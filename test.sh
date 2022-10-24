#!/bin/bash

# Programme qui recupere tout les fichier d'un repertoire et les affiche

#Si on a trop d'argument : erreur
[ $# -gt 1 ] && echo "Usage : $0 <rep>" && exit 1
#Si on a un argument mais que ce n'est pas un dossier : erreur
[ $# -eq 1 ] && [ ! -d $1 ] && echo "Usage : $0 <rep>" && exit 1
#Si on a pas d'argument on prend le repertoire courant, l'argument sinon
[ $# -eq 0 ] && rep="." || rep=$1

#initialisation
chaineRETOUR=""

#On doit recupérer tout ce qui est dans le repertoire
chaineRETOUR=`stat -c "%n // " $rep/*`

# On recupère le nombre de mot dans la chaine
nbMot=`./util/compteMot.sh $@`

i=0 && j=0
# Tant qu'on a pas recupere tout les mots

    # $i est a la position du mot suivant, alors tant que $i est inferieur a la taille de la chaine
    while [ $i -lt ${#chaineRETOUR} ]
    do
        # On recupere le mot
        while [ "${chaineRETOUR:$i:3}" != " //" ]
        do
            i=$[$i+1]
        done
        # $j est la position de la premiere lettre du mot et $i la pos de la derniere
        mot=${chaineRETOUR:$j:$[$i-$j]}
        [ -d $mot ] && chaineRETOUR="$chaineRETOUR `./util/recupRec.sh $mot`"
        
       
        j=$[$i+4] && i=$[$i+3]
    done

echo $chaineRETOUR