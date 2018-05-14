@echo on
setlocal

if "%PLATFORM%" == "winrt_x64_msvc2017" set LTS_MODS=qtjsonserializer qtrestclient qtdatasync
if "%PLATFORM%" == "winrt_x86_msvc2017" set LTS_MODS=qtjsonserializer qtrestclient qtdatasync
if "%PLATFORM%" == "winrt_armv7_msvc2017" set LTS_MODS=qtjsonserializer qtrestclient
if "%PLATFORM%" == "mingw53_32" set LTS_MODS=qtjsonserializer qtrestclient qtautoupdater
if "%PLATFORM%" == "static" set LTS_MODS=qtrestclient

for %%m in (%LTS_MODS%) do (
	mkdir -p install\%%m
	cd %%m
	echo Packaging %%m ...
	call .\qtmodules-travis\ci\win\upload-prepare.bat || exit /B 1
	cd install
	rename *.zip %%m_??????????????????????????????????.* || exit /B 1
	cd ..
	xcopy /e /s /i install\*.zip ..\install\ || exit /B 1
	cd ..
)

cd install
dir
