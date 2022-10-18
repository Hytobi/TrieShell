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
chaineRETOUR=`stat -c "%n " $rep/*`

#On regard s'il y a d'autre dossier dans le repertoire
for i in $chaineRETOUR
do
    if [ -d $i ]
    then
        #Si oui on recupere tout ce qui est dans le repertoire e on l'ajoute a la chaine
        chaineRETOUR="$chaineRETOUR `./util/recupRec.sh $i`"
    fi
done

echo $chaineRETOUR