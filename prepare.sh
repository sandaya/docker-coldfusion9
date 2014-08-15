#!/bin/sh

cd $(dirname "$0")
cd build/install

if [ ! -f "ColdFusion_10_WWEJ_linux64.bin" ]
then
	wget http://198.183.217.181/ColdFusion_10_WWEJ_linux64.bin
	chmod 755 ColdFusion_10_WWEJ_linux64.bin
fi

if [ ! -f "hotfix_013.jar" ]
then
	wget http://198.183.217.181/hotfix_013.jar
	chmod 755 hotfix_013.jar
fi

if [ ! -f "cf10_mdt_updt.jar" ]
then
	wget http://198.183.217.181/cf10_mdt_updt.jar
	chmod 755 cf10_mdt_updt.jar
fi
