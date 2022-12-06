#!/bin/bash

# Programme qui trie les parametres tri suivant le nom du propriétaire de l’entrée ;

# Test si le nombre de parametre est correct
[ $# -eq 0 ] && echo "Pas d'arguments" && exit 1

#initialisation
chaineRETOUR=""     # La chaine qui sera retournée         
chaineNOM="$@"      # On récupère les noms des fichiers / dossier etc... 
chaineINTER=""      # Cette chaine stock les proprietaires (User/groupe) ou la taille selon le tri

i=0
j=0

# Test si le nombre de parametre est correct
[ $# -eq 0 ] && echo "Pas d'arguments" && exit 1    

# Tant qu'on a pas fini de parcourir la chaine
while [ $i -lt ${#chaineNOM} ]
do
    # Tant qu'on a pas de separateur on incremente i
    while [ "${chaineNOM:$i:3}" != " //" ] ; do i=$[$i+1] ; done
    # On ajoute la stat du tri qu'on a recupéré dans la chaineINTER et on passe le séparateur
    [ -d "${chaineNOM:$j:$[$i-$j]}" ] && rep="$rep${chaineNOM:$j:$[$i-$j]} // " #|| fich="$fich ${chaineNOM:$j:$[$i-$j]}"
    [ -f "${chaineNOM:$j:$[$i-$j]}" ] && fich="$fich${chaineNOM:$j:$[$i-$j]} // "
    [ -h "${chaineNOM:$j:$[$i-$j]}" ] && liens="$liens${chaineNOM:$j:$[$i-$j]} // "
    [ -b "${chaineNOM:$j:$[$i-$j]}" ] && bloc="$bloc${chaineNOM:$j:$[$i-$j]} // "
    [ -c "${chaineNOM:$j:$[$i-$j]}" ] && carac="$carac${chaineNOM:$j:$[$i-$j]} // "
    [ -p "${chaineNOM:$j:$[$i-$j]}" ] && tube="$tube${chaineNOM:$j:$[$i-$j]} // "
    [ -S "${chaineNOM:$j:$[$i-$j]}" ] && socket="$socket${chaineNOM:$j:$[$i-$j]} // "
    j=$[$i+4] && i=$[$i+3]
done



echo $rep$fich$liens$bloc$carac$tube$socket


exit 0
