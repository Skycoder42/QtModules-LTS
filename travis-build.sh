#!/bin/bash
set -e

if [ "$TRAVIS_OS_NAME" == "linux" ]; then
	# inject code to keep qt mods over each image
	buildFile=qtmodules-travis/ci/$TRAVIS_OS_NAME/build-docker.sh
	mv $buildFile /tmp/build-docker.sh
	echo '#!/bin/bash' > $buildFile
	echo 'set -e' >> $buildFile
	echo 'cp -Rp ./qtmods/* /' >> $buildFile
	cat /tmp/build-docker.sh >> $buildFile
	chmod +x $buildFile

	mkdir qtmods
	touch qtmods/dummy
	
	for mod in $LTS_MODS; do
		export TARGET_NAME=$mod
		pushd $mod
		cp -Rp ../qtmodules-travis qtmodules-travis
		cp -Rp ../qtmods qtmods
		echo Building $mod...
		./qtmodules-travis/ci/$TRAVIS_OS_NAME/build.sh
		cp -Rp install/* ../qtmods/
		popd
	done
else
	for mod in $LTS_MODS; do
		export TARGET_NAME=$mod
		pushd $mod
		ln -s ../qtmodules-travis qtmodules-travis
		echo Building $mod...
		./qtmodules-travis/ci/$TRAVIS_OS_NAME/build.sh
		sudo cp -Rp install/* /
		popd
	done
fi
