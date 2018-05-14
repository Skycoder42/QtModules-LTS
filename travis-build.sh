#!/bin/bash
set -e

# run submodule setup scripts where needed
if [[ $LTS_MODS = *qtdatasync* ]]; then
	pushd qtdatasync
	./src/3rdparty/cryptopp/travis.sh
	popd
fi

if [ "$TRAVIS_OS_NAME" == "linux" ]; then
	# inject code to keep qt mods over each image
	buildFile=qtmodules-travis/ci/$TRAVIS_OS_NAME/build-docker.sh
	mv $buildFile /tmp/build-docker.sh
	echo '#!/bin/bash' > $buildFile
	echo 'set -e' >> $buildFile
	echo 'cp -R ./qtmods/* /' >> $buildFile
	cat /tmp/build-docker.sh >> $buildFile
	chmod +x $buildFile

	mkdir qtmods
	touch qtmods/dummy.txt
	for mod in $LTS_MODS; do
		pushd $mod
		cp -R ../qtmodules-travis qtmodules-travis
		cp -R ../qtmods qtmods
		echo Building $mod...
		./qtmodules-travis/ci/$TRAVIS_OS_NAME/build.sh
		cp -R install/* ../qtmods/
		popd
	done
else
	for mod in $LTS_MODS; do
		pushd $mod
		ln -s ../qtmodules-travis qtmodules-travis
		echo Building $mod...
		./qtmodules-travis/ci/$TRAVIS_OS_NAME/build.sh
		sudo cp -R install/* /
		popd
	done
fi
