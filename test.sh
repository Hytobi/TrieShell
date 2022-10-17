#!/bin/bash

echo "<$#>"
[ $# -eq 3 ] && echo "3 arguments" && exit 1

# si le premier param n'est pas un dossier on affiche 2
decroissant=0   # sans -d
nom=0           # sans -n
taille=0        # sans -s
modif=0         # sans -m
ligne=0         # sans -l
extension=0     # sans -e
type=0          # sans -t
proprietaire=0  # sans -p
groupe=0        # sans -g

for (( i=0; i<${#2}; i++ ))
    do
        case ${2:$i:1} in
            n) nom=1;;
            s) taille=1;;
            m) modif=1;;
            l) ligne=1;;
            e) extension=1;;
            t) type=1;;
            p) proprietaire=1;;
            g) groupe=1;;
        esac
    done



echo "${#2}"
echo "${2:1:2}"
shift
shift
echo $@
echo $#
#find / -exec stat --printf="Répertoire :\t%n\nDroits :\t%A = %a\nPropriétaire :\t%U\nGroupe :\t%G\n\n" { dosTest700 dosTest755 } \; 2>/dev/null   # Au cas où celui qui lance cette commande n'aurait pas accès à certaines branches du système
#stat --printf="Répertoire :\t%n\nDroits :\t%A = %a\nPropriétaire :\t%U\nGroupe :\t%G\n\n" $@
chaine=""
chaine=`stat -c "%n %U" $@`

echo $chaine