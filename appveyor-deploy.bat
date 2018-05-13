#!/bin/bash
set -e

mkdir -p install
for mod in $LTS_MODS; do
	pushd $mod
	echo Packaging $mod...
	./qtmodules-travis/ci/$TRAVIS_OS_NAME/upload-prepare.sh
	cp install/*.tar.xz ../install/
	popd
done

ls -lsa install/
