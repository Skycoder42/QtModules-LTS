#!/bin/bash
set -e

for mod in $LTS_MODS; do
	mkdir -p install/$mod
	pushd $mod
	echo Packaging $mod...
	./qtmodules-travis/ci/$TRAVIS_OS_NAME/upload-prepare.sh
	cp install/*.tar.xz ../install/$mod
	popd
done

find install/
