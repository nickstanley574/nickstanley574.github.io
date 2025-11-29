#!/bin/bash

docker run --rm \
  --volume="/home/nick/workspace/nickstanley574.github.io:/srv/jekyll" \
  --publish 4000:4000 \
  jekyll/jekyll:latest \
  jekyll serve --watch --drafts --host 0.0.0.0
