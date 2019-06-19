@echo on
setlocal

if "%PLATFORM%" == "msvc2015_64" set LTS_MODS=qtjsonserializer qtrestclient qtmvvm qtautoupdater qtapng
if "%PLATFORM%" == "winrt_x64_msvc2017" set LTS_MODS=qtjsonserializer qtrestclient qtservice qtdatasync qtmvvm qtapng
if "%PLATFORM%" == "winrt_x86_msvc2017" set LTS_MODS=qtjsonserializer qtrestclient qtservice qtdatasync qtmvvm qtapng
if "%PLATFORM%" == "winrt_armv7_msvc2017" set LTS_MODS=qtjsonserializer qtrestclient qtservice qtdatasync qtmvvm qtapng

mkdir install
for %%m in (%LTS_MODS%) do (
	mkdir install\%%m
	cd %%m
	echo Packaging %%m ...
	call .\qtmodules-travis\ci\win\upload-prepare.bat || exit /B 1
	xcopy /e /s /i install\*.zip ..\install\ || exit /B 1
	cd ..
)

cd install
dir
