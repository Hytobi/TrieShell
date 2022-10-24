#!/bin/bash

# Programme qui trie les parametres tri suivant le nom du propriétaire de l’entrée ;

#initialisation
chaineRETOUR=""
interPROPRIO1="" #On va comparer proprio1 avec proprio2
interPROPRIO2=""
i=0         #pour se deplacer dans chainePROPRIO
j=0         #pour se deplacer dans chaineNOM
k=0
cmpESP=0    #pour compter les espaces dans chainePROPRIO et nous reperer dans chaineNOM


chaineNOM="$@"     # On récupère le nom du fichier 
chainePROPRIO="" # On récupère le nom du propriétaire

echo $chaineNOM

maChaine="$@"           # $@ contient deja tout les noms de fichier
chaineRETOUR=""         # La chaine qu'on renvoie
nbMot=0                 # Nombre de mot dans la chaine   
i=0

# On recupère le nombre de mot dans la chaine
nbMot=`./util/compteMot.sh "$@"`

#On recupère le nom du propriétaire de chaque fichier
while [ $i -lt ${#maChaine} ]
do
    while [ "${maChaine:$i:3}" != " //" ]
    do
        i=$[$i+1]
    done
    mot=${maChaine:$j:$[$i-$j]}
    echo $mot
    chainePROPRIO=$chainePROPRIO`stat -c "%U // " "$mot"` 
    j=$[$i+4] && i=$[$i+3]
done
echo $chainePROPRIO

# On affiche la chaine
echo $chaineRETOUR
