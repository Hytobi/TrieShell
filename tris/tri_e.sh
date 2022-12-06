#!/bin/bash

#   -e : tri suivant l’extension des entrées (caractères se trouvant après le dernier point du nom de l’entrée ;
#        les répertoires n’ont pas d’extension) ;

# Test si le nombre de parametre est correct
[ $# -eq 0 ] && echo "Pas d'arguments" && exit 1

#initialisation
chaineRETOUR=""     # La chaine qui sera retournée         
chaineNOM="$@"      # On récupère les noms des fichiers / dossier etc... 
chaineEXT=""      # Cette chaine stock les fichiers qui ont une extension
chaineNONEXT=""      # Cette chaine stock les fichiers qui n'ont pas d'extension
lesExt=""      # Cette chaine stock les extensions
aExt=0 #boolean qui indique si le fichier a une extension
coordPoint=0 #Coordonnée du point dans le nom du fichier

#On recupère les noms du propriétaire ou la taille selon le tri
i=0 && j=0
# Tant qu'on a pas fini de parcourire la chaine
while [ $i -lt ${#chaineNOM} ]
do
    # Tant qu'on a pas de separateur on incremente i
    while [ "${chaineNOM:$i:3}" != " //" ] 
    do 
        i=$[$i+1]
        [ "${chaineNOM:$i:1}" == "." ] && [ "${chaineNOM:$i:2}" != "./" ] && [ $aExt -eq 0 ] && aExt=1 && coordPoint=$i
    done
    
    if [ $aExt -eq 1 ]
    then
        chaineEXT="$chaineEXT${chaineNOM:$j:$[$i-$j]} // "
        lesExt="$lesExt${chaineNOM:$coordPoint:$[$i-$coordPoint]} // "
    else
        chaineNONEXT="$chaineNONEXT${chaineNOM:$j:$[$i-$j]} // "
    fi
    j=$[$i+4] && i=$[$i+3] && aExt=0
done

#on supprime les doublons
i=0 && j=0 && deja=0
lesExtint=""
for mot in $lesExt
do
    [ "$mot" = "//" ] && continue
    for mot2 in $lesExtint
    do
        [ "$mot" = "$mot2" ] && deja=1 && break
    done
    [ $deja -eq 1 ] && deja=0 && continue
    lesExtint="$lesExtint$mot // "
    
done

# On affiche la chaine
lesExtint=`./tris/tri_n.sh $lesExtint`


# On recupère le nombre de mot dans la chaine
nbMot=`./util/compteMot.sh $chaineEXT`
i=0 && j=0 
# Tant qu'on a pas recupere tout les mots
while [ $nbMot -gt 0 ]
do
    for ext in $lesExtint
    do
        [ "$ext" = "//" ] && continue
        
        while [ $i -lt ${#chaineEXT} ]
        do
            while [ "${chaineEXT:$i:3}" != " //" ]
            do
                i=$[$i+1]
                [ "${chaineEXT:$i:1}" == "." ] && [ "${chaineEXT:$i:2}" != "./" ] && coordPoint=$i
            done
            # $j est la position de la premiere lettre du mot et $i la pos de la derniere
            mot=${chaineEXT:$j:$[$i-$j]}
            if [ "${chaineEXT:$coordPoint:$[$i-$coordPoint]}" = "$ext" ]
            then
                chaineRETOUR="$chaineRETOUR$mot // "
                nbMot=$[$nbMot-1]
            fi
            j=$[$i+4] && i=$[$i+4]
        done
        i=0 && j=0 
    done
done
echo "$chaineRETOUR${chaineNONEXT:0:$[${#chaineNONEXT}-1]}"
exit 0