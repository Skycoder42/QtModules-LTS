@echo off

if "%PLATFORM%" == "msvc2015_64" set LTS_MODS=qtjsonserializer qtrestclient qtmvvm qtautoupdater qtapng
if "%PLATFORM%" == "winrt_x64_msvc2017" set LTS_MODS=qtjsonserializer qtrestclient qtservice qtdatasync qtmvvm qtapng
if "%PLATFORM%" == "winrt_x86_msvc2017" set LTS_MODS=qtjsonserializer qtrestclient qtservice qtdatasync qtmvvm qtapng
if "%PLATFORM%" == "winrt_armv7_msvc2017" set LTS_MODS=qtjsonserializer qtrestclient qtservice qtdatasync qtmvvm qtapng

setlocal
for %%m in (%LTS_MODS%) do (
	:: prepare install dir link
	mklink /D C:\projects\%%m C:\projects\qtmodules-lts\%%m
	
	cd %%m
	:: copy over ci + build
	mklink /D qtmodules-travis ..\qtmodules-travis
	echo Building %%m ...
	call .\qtmodules-travis\ci\win\build.bat || exit /B 1
	:: copy install stuff into qt install
	xcopy /e /s /i install\* C:\ || exit /B 1
	cd ..
)
