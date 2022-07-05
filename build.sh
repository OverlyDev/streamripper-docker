#!/bin/bash

mkdir -p _context
cd _context

cp ../entrypoint.sh .
cp ../rip.sh .

docker build -t overlydev/streamripper-docker -f ../docker/Dockerfile .

docker image prune -f
