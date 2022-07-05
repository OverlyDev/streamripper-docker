#!/bin/bash

mkdir -p _context
cd _context

cp ../entrypoint.sh .

docker build --no-cache -t overlydev/streamripper-docker -f ../docker/Dockerfile .

docker image prune -f
