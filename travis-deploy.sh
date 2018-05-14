#!/bin/bash
set -e

for mod in $LTS_MODS; do
	mkdir -p install/$mod
	pushd $mod
	echo Packaging $mod...
	./qtmodules-travis/ci/$TRAVIS_OS_NAME/upload-prepare.sh
	#rename build_ ${mod}_build_ install/*.tar.xz
	find install/ -type f -printf "%f\0" | xargs --null -I{} mv install/{} "install/${mod}_{}"
	cp install/*.tar.xz ../install
	popd
done

find install/
