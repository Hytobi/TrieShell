#!/bin/bash

echo "<$#>"
[ $# -eq 3 ] && echo "3 arguments" && exit 1

chaineNOM=`stat -c "%n" $@`
for i in $chaineNOM
do
    echo $i
done