#!/bin/bash

maChaine="$@"
nbMot=0
i=0

while [ $i -lt ${#maChaine} ]
do
    if [ "${maChaine:$i:3}" = " //" ]
    then
        nbMot=$[$nbMot+1]
        i=$[$i+3]
    fi
    i=$[$i+1]
done

echo $nbMot