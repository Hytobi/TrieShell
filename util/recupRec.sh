#!/bin/bash

# Programme qui recupere tout les fichier d'un repertoire et les affiche

#Si on a trop d'argument : erreur
[ $# -gt 1 ] && echo "Usage : $0 <rep>" && echo $@ && exit 1
#Si on a un argument mais que ce n'est pas un dossier : erreur
[ $# -eq 1 ] && [ ! -d "$1" ] && echo "Usage : $0 <rep>" && exit 1
#Si on a pas d'argument on prend le repertoire courant, l'argument sinon
[ $# -eq 0 ] && rep="." || rep=$1

#initialisation
chaineRETOUR=""

#On doit recupérer tout ce qui est dans le repertoire
chaineRETOUR=`stat -c "%n // " "$rep"/* 2> /dev/null` #si le dossier est vide il met une erreur: on s'en fou

#On regard s'il y a d'autre dossier dans le repertoire
nomRep=""
for i in $chaineRETOUR
do
    #Si $i n'est pas un séparateur c'est que c'est un bout de monRep
    [ "$i" != "//" ] && nomRep="$nomRep $i"  || {
        # Si on rentre ici c'est qu'on a récupéré tout le chemin d'un fichier/reperoire dans nomRep
        # Si c'est un dossier on recupere tout ce qu'il y a dedans (et on enleve l'espace du debut)
        [ -d "${nomRep:1:${#nomRep}}" ] && chaineRETOUR="$chaineRETOUR `./util/recupRec.sh "${nomRep:1:${#nomRep}}"`"
        #On vide la chaine
        nomRep=""
    }
done

echo $chaineRETOUR
