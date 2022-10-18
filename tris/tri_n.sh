#!/bin/bash

#   -n : tri suivant le nom des entrées ;

[ $# -eq 0 ] && echo "Pas d'arguments" && exit 1
#[ $# -gt 1 ] && echo "Usage : $0 <rep>" && exit 1

#initialisation
chaineRETOUR=""

# L'argument contient deja tout les noms de fichier
chaineNOM=$@
#on fait autant de boucle que la taille, on cherche le mot le plus petit on le stock dans chaineRETOUR et on le supprime de chaineNOM


for (( i=0; i<$#; i++ ))
do
    chaineRETOUR=$chaineRETOUR"oui"
done



# On affiche la chaine
echo $chaineRETOUR