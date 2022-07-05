#!/bin/bash

if [ -z $URL ]; then
	echo "Missing URL environment variable"
	exit 1
fi

if [ -z $USER_AGENT ]; then
	echo "Missing USER_AGENT environment variable"
	exit 1
fi

streamripper $URL -u $USER_AGENT
