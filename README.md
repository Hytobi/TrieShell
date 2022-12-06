# projetUNIX

 Trier en Shell
 
 Réaliseé par Patrick PLOUVIN et Patrice PLOUVIN 
 
 Répartition du travail
 Ce document et les tries m,l,e,t par Patrick
 Le main, les utils et les tries n,s,p,g par Patrice
 
 Information:
 1)Pour gérer les espaces, nous récupérons tout les nom avec la fonction stat,
   et on les garde dans une chaine de caractère séparé par les 4 caracteres " // " 
   En effet un fichier ne peut contenir un "/" dans son nom et "//" pour exclu le cas d'un fichier sans nom 
 
 2)Le mode de trie -d est réaliste seulement en inversant la chaine apres tout les tries. 
 
 3)chSansRetour.sh sert a enlever les "\n" que donne la fonction stat pour séparer ses noms de fichiers.
 
 4)La fonctions stat permet de récupérer des éléments d'un fichier/dossier grâce a des options;
   c'est pour cela qu'ils sont traité dans le même fichier de tri en rajoutant au début du parametre le mode
   on aurait pu passer à ce ficier deux parametres "option" et "chaine" mais c'etait moins amusant.

5) On trie toujours du plus petit vers le plus grand
