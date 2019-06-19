#!/bin/bash
set -ex

for mod in $LTS_MODS; do
	ls -lsa "$mod/"
	ls -lsa "$mod/install/"

	export TARGET_NAME=$mod
	mkdir -p install/$mod
	pushd $mod
	echo Packaging $mod...
	./qtmodules-travis/ci/$TRAVIS_OS_NAME/upload-prepare.sh
	cp install/*.tar.xz ../install
	popd
done

ls -lsa install/
