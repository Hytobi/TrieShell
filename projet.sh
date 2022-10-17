#!/bin/bash

# Programme qui trie les entrées d’un répertoire suivant différents critères.
# Syntaxe de votre commande sera : trishell [-R] [-d] [-nsmletpg] <rep>

# 1 – -R : tri le contenu de l’arborescence débutant au répertoire rep. Dans ce cas on triera par rapport aux
#          noms des entrées mais on affichera le chemin d’accès ;

# 2 – -d : tri dans l’ordre décroissant, par défaut le tri est effectué dans l’ordre croissant ;

# 3 – -nsdletpg : permet de spécifier le critère de tri utilisé. 
# Ces critères peuvent être combinés, si deux fichiers sont identiques pour le premier critère, le second critère les départegera etc.
#   -n : tri suivant le nom des entrées ;
#   -s : tri suivant la taille des entrées ;
#   -m : tri suivant la date de dernière modification des entrées ;
#   -l : tri suivant le nombre de lignes des entrées ;
#   -e : tri suivant l’extension des entrées (caractères se trouvant après le dernier point du nom de l’entrée ;
#   -t : tri suivant le type de fichier (ordre : répertoire, fichier, liens, fichier spécial de type bloc, fichier spécial de type caractère, tube nommé, socket) ;
#   -p : tri suivant le nom du propriétaire de l’entrée ;
#   -g : tri suivant le groupe du propriétaire de l’entrée.

# 4 – <rep> : répertoire à trier.

# 5 – Si aucun critère n’est spécifié, le tri se fait par défaut sur le nom des entrées.
# 6 – Si aucun répertoire n’est spécifié, le répertoire courant est utilisé.
# 7 – Si aucun critère n’est spécifié et aucun répertoire n’est spécifié, le tri se fait par défaut sur le nom des entrées du répertoire courant.

#Exemple : trishell -R -d -pse /home trie, par ordre décroissant, l’arborescence débutant à /home en fonction
#des propriétaires des entrées comme premier critère, de la taille des entrées comme second critère et de l’extension
#des entrées comme dernier critère.

# Teste sur la taille des entrées
[ $# -eq 0 ] && echo "Pas d'argument : comme un ls normale" && $0 -n && exit 0
[ $# -gt 4 ] && echo "Usage : $0 [-R] [-d] [-nsmletpg] <rep>" && exit 1

#On initialise les variables a 0 et on les passe a 1 si elles sont activées
rActive=0       # sans -R c'est a dire on rentre pas dans les auttre dossier
decroissant=0   # sans -d
option=0        # sans -nsmletpg
rep=.           # repertoire courant par defaut

#Si le premier argument est -R
[ $# -gt 0 ] && [ $1 = "-R" ] && rActive=1 && shift

#Si le deuxième argument est -d
[ $# -gt 0 ] && [ $1 = "-d" ] && decroissant=1 && shift 

#Si c'est pas le rep c'est que c'est une option
[ $# -gt 0 ] && [ ! -d $1 ] && option=$1 && shift

#Si il reste un argument c'est forcement le rep
[ $# -gt 0 ] && [ -d $1 ] && rep=$1 && shift

#Si il reste des arguments c'est qu'il y a une erreur
[ $# -gt 0 ] && echo "Usage : $0 [-R] [-d] [-nsmletpg] <rep>" && exit 1


#Decortiquer -nsmletpg
if [ $option != 0 ]
then
    for (( i=0; i<${#option}; i++ )) # ${#2} est la taille du 2eme argument
    do
        # ${2:$i:1} dans le 2eme argument, i pour l'indice dans la chaine, 1 pour la taille de la chaine qu'on recupere
        case ${option:$i:1} in 
            n) nom=1;;     
            s) taille=1;;
            m) modif=1;;
            l) ligne=1;;
            e) extension=1;;
            t) type=1;;
            p) proprietaire=1;;
            g) groupe=1;;
            #n) chaineFINAL=`./trie_n.sh chaineFINAL`;;
            #s) chaineFINAL=`./trie_s.sh chaineFINAL`;;
            #m) chaineFINAL=`./trie_m.sh chaineFINAL`;;
            #l) chaineFINAL=`./trie_l.sh chaineFINAL`;;
            #e) chaineFINAL=`./trie_e.sh chaineFINAL`;;
            #t) chaineFINAL=`./trie_t.sh chaineFINAL`;;
            #p) chaineFINAL=`./trie_p.sh chaineFINAL`;;
            #g) chaineFINAL=`./trie_g.sh chaineFINAL`;;
        esac
    done
else
    #Si on a pas d'option on trie par defaut sur le nom
    nom=1

fi

echo "rActive : $rActive"
echo "decroissant : $decroissant"
echo "option : $option"
echo "rep : $rep"


#On affiche
i=0
# a un endroit on a une chaine avec tout les nom des fichiers
while [ $i -lt ${#chaineFINAL} ]
do
    pr=${chaineFINAL:$i:1}
    [ pr != " " ] && echo -n ${chaineFINAL:$i:1} && i=[$i+1] && continue
    i=$[$i+1] && echo
done



#On rentre dans les autres dossiers si -R
#if [ $rActive = 1 ]
#then
#    for dossier in $(ls -d $rep/*)
 #   do
  #      if [ -d $dossier ]
   #     then
    #        $0 $option $dossier
     #   fi
   # done
#fi
