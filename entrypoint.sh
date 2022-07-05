#!/bin/bash

# Make sure we have all the environment variables

if [ -z $PUID ]; then
	echo "Missing PUID environment variable"
	exit 1
fi

if [ -z $PGID ]; then
	echo "Missing PGID environment variable"
	exit 1
fi

if [ -z $URL ]; then
	echo "Missing URL environment variable"
	exit 1
fi

if [ -z $USER_AGENT ]; then
	echo "Missing USER_AGENT environment variable"
	exit 1
fi

if [ -z $OUTPUT_DIR ]; then
	echo "Missing OUTPUT_DIR environment variable"
	exit 1
fi

# set up PUID and PGID
PUID=${PUID:-911}
PGID=${PGID:-911}

groupmod -o -g "$PGID" abc
usermod -o -u "$PUID" abc

chown abc:abc /songs
chown abc:abc /ripper

# drop to abc user and begin
su abc --command "/scripts/rip.sh"
