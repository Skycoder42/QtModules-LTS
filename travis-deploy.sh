#!/bin/bash
set -ex

find .

for mod in $LTS_MODS; do
	df
	export TARGET_NAME=$mod
	mkdir -p install/$mod
	pushd $mod
	echo Packaging $mod...
	./qtmodules-travis/ci/$TRAVIS_OS_NAME/upload-prepare.sh
	cp install/*.tar.xz ../install
	popd
done

ls -lsa install/
