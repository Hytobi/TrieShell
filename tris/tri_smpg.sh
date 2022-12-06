#!/bin/bash

# On trie toujours du plus petit vers le plus grand
#   -s : tri suivant la taille des entrées ;
#   -m : tri suivant la date de dernière modification des entrées ;
#   -p : tri suivant le nom du propriétaire de l’entrée ;
#   -g : tri suivant le groupe du propriétaire de l’entrée.

# Test si le nombre de parametre est correct
[ $# -eq 0 ] && echo "Pas d'arguments" && exit 1

#initialisation
chaineRETOUR=""     # La chaine qui sera retournée         
chaineNOM="$@"      # On récupère les noms des fichiers / dossier etc... 
chaineINTER=""      # Cette chaine stock les proprietaires (User/groupe) ou la taille ou la date en seconde depuis le temps 0 de la machine selon le tri demandé

mode="%${chaineNOM:0:1}"                # On recupère le mode : U G s ou Y
chaineNOM=${chaineNOM:1:${#chaineNOM}}  # On enleve le mode de la chaine

# On recupère le nombre de mot dans la chaine
nbMot=`./util/compteMot.sh "$@"`

#On recupère les noms du propriétaire ou la taille selon le tri
i=0 && j=0

# Tant qu'on a pas fini de parcourire la chaine
while [ $i -lt ${#chaineNOM} ]
do
    # Tant qu'on a pas de separateur on incremente i
    while [ "${chaineNOM:$i:3}" != " //" ] ; do i=$[$i+1] ; done
    # On ajoute la stat du tri qu'on a recupéré dans la chaineINTER et on passe le séparateur
    chaineINTER=$chaineINTER`stat -c "$mode // " "${chaineNOM:$j:$[$i-$j]}"` && j=$[$i+4] && i=$[$i+3]
done

# On la trie par nom/taille grace a tri_n.sh (marche pour les noms et les tailles)
chaineINTER=`./tris/tri_n.sh $chaineINTER`

nb=0            # Compteur de mot dans la chaineRETOUR
nb2=0           # Compteur de mot dans la chaineINTER
nbMotN=$nbMot   # Nombre de mot dans la chaineNOM
i=0 && j=0
# Tant que notre chaine retour n'est pas pleine
while [ $nb -lt $nbMot ]
do
    # On recupere les elements de la chaineINTER (nom_user ou nom_group ou taille)
    for element in $chaineINTER
    do
        # Si l'élément' est un séparateur on passe au suivant
        [ $element = "//" ] && continue 

        # On parcours la chaine de nom
        while [ $nb2 -lt $nbMotN ]
        do
            # On recupere le nom
            while [ "${chaineNOM:$i:3}" != " //" ] ; do i=$[$i+1] ; done
            
            # On regard si sa stat mode est le meme que element
            if [ `stat -c "$mode" "${chaineNOM:$j:$[$i-$j]}"` = "$element" ] 
            then
                # Si oui on l'ajoute a la chaine de retour
                chaineRETOUR=$chaineRETOUR${chaineNOM:$j:$[$i-$j]}" // " 
                # On met a jour la chaines de nom
                chaineNOM=${chaineNOM:0:$j}${chaineNOM:$[$i+4]}
                # On augmente le nombre de mot dans la chaine de retour 
                nb=$[$nb+1]
                # On met a jour le nombre de mot dans chaineNOM 
                nb2=$[$nb2+1] 
                # On recommence à 0 (au cas ou on a enlever le premier mot)
                i=0 && j=0 && continue 
            fi
            #On avance dans la chaineNOM en passant le séparateur
            i=$[$i+4] && j=$i && nb2=$[$nb2+1]
        done
    # On recommence a 0 et on met a jour le nombre de mot dans la chaineNOM
    i=0 && j=0 && nb2=0 && nbMotN=$[$nbMot-$nb]
    done
done

# On affiche la chaine de retour (en enlevant le dernier espace causé par la ligne de code 57)
echo ${chaineRETOUR:0:$[${#chaineRETOUR}-1]}

exit 0