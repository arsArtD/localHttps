#!/bin/sh
outpath=./out
cnfpath=./conf
#serial=0x1111
serial=0x1113
rm -f $outpath/*
openssl req -x509 -newkey rsa:2048 -out $outpath/ca.crt -outform PEM -keyout $outpath/ca.key -days 36500 -verbose -config $cnfpath/ca.cnf -nodes -sha256 -subj "/CN=Comp CA"
openssl req -newkey rsa:2048 -keyout $outpath/server.key -out $outpath/server.req -subj /CN=localhost  -sha256 -nodes
openssl x509 -req -CA $outpath/ca.crt -CAkey $outpath/ca.key -in $outpath/server.req -out $outpath/server.crt -days 3650 -extfile $cnfpath/local.ext -sha256 -set_serial $serial
openssl pkcs12 -export -out $outpath/ca.P12 -inkey $outpath/ca.key -in $outpath/ca.crt
