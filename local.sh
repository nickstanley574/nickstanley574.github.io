#!/bin/bash

PORT=4000

if netstat -tulpn | grep -q $PORT; then
    sudo kill $(sudo lsof -t -i:$PORT)
fi

bundle exec jekyll serve $1 $2
