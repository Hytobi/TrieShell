#!/bin/bash

#   -e : tri suivant l’extension des entrées (caractères se trouvant après le dernier point du nom de l’entrée ;

# Test si le nombre de parametre est correct
[ $# -eq 0 ] && echo "Pas d'arguments" && exit 1

#initialisation
chaineRETOUR=""     # La chaine qui sera retournée         
chaineNOM="$@"      # On récupère les noms des fichiers / dossier etc... 
chaineEXT=""        # Cette chaine stock les fichiers qui ont une extension
chaineNONEXT=""     # Cette chaine stock les fichiers qui n'ont pas d'extension
lesExt=""           # Cette chaine stock les extensions
aExt=0              # Boolean qui indique si le fichier a une extension
coordPoint=0        # Coordonnée du point dans le nom du fichier

# On parcours la chaine de nom
i=0 && j=0
# Tant qu'on a pas fini de parcourire la chaine
while [ $i -lt ${#chaineNOM} ]
do
    # Tant qu'on a pas de separateur on incremente i
    while [ "${chaineNOM:$i:3}" != " //" ] 
    do 
        i=$[$i+1]
        # Si on trouve l'extension on passe aExt a 1
        [ "${chaineNOM:$i:1}" == "." ] && [ "${chaineNOM:$i:2}" != "./" ] && [ $aExt -eq 0 ] && aExt=1 && coordPoint=$i
    done
    # Si on a une extension 
    if [ $aExt -eq 1 ]
    then
        # On ajoute le nom du fichier a la chaine des fichiers avec extension
        chaineEXT="$chaineEXT${chaineNOM:$j:$[$i-$j]} // "
        # On ajoute l'extension a la chaine des extensions
        lesExt="$lesExt${chaineNOM:$coordPoint:$[$i-$coordPoint]} // "
    else
        # Sinon on ajoute le nom du fichier a la chaine des fichiers sans extension
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

# On trie les extensions pour les mettre dans l'ordre
lesExtint=`./tris/tri_n.sh $lesExtint`

# On recupère le nombre de mot dans la chaine
nbMot=`./util/compteMot.sh $chaineEXT`

i=0 && j=0 
# Tant qu'on a pas recupere tout les mots
while [ $nbMot -gt 0 ]
do
    # On parcours la chaine des extensions
    for ext in $lesExtint
    do
        # Si on a un séparateur on passe
        [ "$ext" = "//" ] && continue
        
        # Tant qu'on a pas parcouru toute la chaine des fichiers avec extension
        while [ $i -lt ${#chaineEXT} ]
        do
            # on récupère le mot et la coordonnée du point
            while [ "${chaineEXT:$i:3}" != " //" ]
            do
                i=$[$i+1]
                [ "${chaineEXT:$i:1}" == "." ] && [ "${chaineEXT:$i:2}" != "./" ] && coordPoint=$i
            done
            mot=${chaineEXT:$j:$[$i-$j]}
            
            # Si l'extension du mot est celle qu'on cherche
            if [ "${chaineEXT:$coordPoint:$[$i-$coordPoint]}" = "$ext" ]
            then
                # On ajoute le mot a la chaine de retour
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