#!/bin/bash

[ $# -lt 2 ] && echo "Usage : $0 ch1 ch2" && exit 1

[ $1 == $2 ] && echo "egale" && exit 1
if test $1 \< $2
then
echo OK
else
echo KO
fi
