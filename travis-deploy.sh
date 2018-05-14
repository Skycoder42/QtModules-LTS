#!/bin/bash
set -e

if [ "$TRAVIS_OS_NAME" == "osx" ]; then
	brew upgrade findutils || brew install findutils
	FIND=gfind
	XARGS=gxargs
else
	FIND=find
	XARGS=xargs
fi

for mod in $LTS_MODS; do
	mkdir -p install/$mod
	pushd $mod
	echo Packaging $mod...
	./qtmodules-travis/ci/$TRAVIS_OS_NAME/upload-prepare.sh
	#rename build_ ${mod}_build_ install/*.tar.xz
	$FIND install/ -type f -name "*.tar.xz" -maxdepth 1 -printf "%f\0" | $XARGS --null -I{} mv install/{} "install/${mod}_{}"
	cp install/*.tar.xz ../install
	popd
done

$FIND install/
