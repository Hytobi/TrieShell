#!/bin/bash

#   -t : tri suivant le type de fichier (ordre : répertoire, fichier, liens, fichier spécial de type bloc, fichier spécial de type caractère, tube nommé, socket) ;

# Test si le nombre de parametre est correct
[ $# -eq 0 ] && echo "Pas d'arguments" && exit 1

#initialisation       
chaineNOM="$@"      # On récupère les noms des fichiers / dossier etc... 
i=0 && j=0

# (ordre : répertoire, fichier, liens, fichier spécial de type bloc, fichier spécial de type caractère, tube nommé, socket) 
rep="" && fich="" && liens="" && bloc="" && carac="" && tube="" && socket=""

# Tant qu'on a pas fini de parcourir la chaine
while [ $i -lt ${#chaineNOM} ]
do
    # Tant qu'on a pas de separateur on incremente i
    while [ "${chaineNOM:$i:3}" != " //" ] ; do i=$[$i+1] ; done
    # On a le nom du fichier, on regarde son type
    nom="${chaineNOM:$j:$[$i-$j]}"
    [ -d "$nom" ] && rep="$rep$nom // " 
    [ -f "$nom" ] && fich="$fich$nom // " 
    [ -h "$nom" ] && liens="$liens$nom // " 
    [ -b "$nom" ] && bloc="$bloc$nom // " 
    [ -c "$nom" ] && carac="$carac$nom // " 
    [ -p "$nom" ] && tube="$tube$nom // " 
    [ -S "$nom" ] && socket="$socket$nom // " 
    j=$[$i+4] && i=$[$i+3]
done

# On affiche le resultat
echo $rep$fich$liens$bloc$carac$tube$socket
exit 0
