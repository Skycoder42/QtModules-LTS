#!/bin/bash
set -e

for mod in $LTS_MODS; do
	pushd $mod
	ln -s ../qtmodules-travis
	echo Building $mod...
	./qtmodules-travis/ci/$TRAVIS_OS_NAME/build.sh
	sudo cp -RT install/ /
	popd
done
