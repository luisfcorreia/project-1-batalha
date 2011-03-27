#!/bin/sh

echo "getting own IP and starting up Löve\n"

ifconfig | grep 'inet addr:' | grep -v '127.0.0.1' | cut -d: -f2 | awk '{print $1}' | qrencode -s3 -m 1 -o ownip.png 

love .

