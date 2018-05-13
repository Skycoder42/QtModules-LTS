#!/bin/bash
set -e

for mod in $LTS_MODS; do
	pushd $mod
	cp -R ../qtmodules-travis qtmodules-travis
	echo Building $mod...
	./qtmodules-travis/ci/$TRAVIS_OS_NAME/build.sh
	sudo cp -R install/* /
	popd
done
