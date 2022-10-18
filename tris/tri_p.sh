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

# on trie la chaine en fonction du nom du proprietaire sans utiliser ls et sort
chaineNOM=`stat -c "%n" $@`     # On récupère le nom du fichier 
chainePROPRIO=`stat -c "%U" $@` # On récupère le nom du propriétaire


# On tri chainePROPRIO, si on change le proprio de place on change le nom de fichier corespondant de place

#On recupere le premier proprietere dans la liste pour le comparer aux autres
while [ ${chainePROPRIO:$i:1} != " " ]
do
    interPROPRIO1="$interPROPRIO${chainePROPRIO:$i:1}"
    i=$[$i+1]
done

# Tant que ma chaine retour n'est pas a la meme taille que ma chaine nom, on a du travail
while [ ${#chaineRETOUR} != ${#chaineNOM} ]
do
    #chercher le proprio avec le nom le plus petit dans l'ordre alpha
    



# On affiche la chaine
echo $chaineRETOUR
