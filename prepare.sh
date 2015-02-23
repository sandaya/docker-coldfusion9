#!/bin/sh

cd $(dirname "$0")
cd build/install

if [ ! -f "ColdFusion_9_WWEJ_linux64.bin" ]
then
	wget https://copy.com/nhIbHZYZnmPN/ColdFusion+Repo/9.0.2/ColdFusion_9_WWEJ_linux64.bin?download=1
	chmod 755 ColdFusion_9_WWEJ_linux64.bin
fi
