#!/bin/sh

echo "getting own IP and starting up Löve"

ifconfig | grep 'inet addr:' | grep -v '127.0.0.1' | cut -d: -f2 |awk '{print $1}' | qrencode -s4 -o ownip.png 

love .

