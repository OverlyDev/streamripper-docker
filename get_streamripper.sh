#!/bin/bash

function get_streamripper() {
	mkdir -p temp
	cd temp

	if [ ! -d streamripper* ]; then
		echo "obtaining streamripper"
		wget -O streamripper.tar.gz https://sourceforge.net/projects/streamripper/files/streamripper%20%28current%29/1.64.6/streamripper-1.64.6.tar.gz/download
		tar -zxf streamripper.tar.gz
		rm -rf streamripper.tar.gz
	fi

	cd streamripper*

	if [ ! -f streamripper ]; then
		echo "compiling streamripper"
		./configure
		make
	fi

	cp streamripper ../../.
}

if [ ! -f streamripper ]; then
	echo "streamripper binary missing"
	get_streamripper
	
fi
