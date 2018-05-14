@echo on

if "%PLATFORM%" == "winrt_x64_msvc2017" set LTS_MODS=qtjsonserializer qtrestclient qtdatasync
if "%PLATFORM%" == "winrt_x86_msvc2017" set LTS_MODS=qtjsonserializer qtrestclient qtdatasync
if "%PLATFORM%" == "winrt_armv7_msvc2017" set LTS_MODS=qtjsonserializer qtrestclient
if "%PLATFORM%" == "mingw53_32" set LTS_MODS=qtjsonserializer qtrestclient qtautoupdater
if "%PLATFORM%" == "static" set LTS_MODS=qtrestclient

setlocal
for %%m in (%LTS_MODS%) do (
	cd %%m
	xcopy /e /s /t /i ..\qtmodules-travis qtmodules-travis || exit /B 1
	echo Building %%m ...
	.\qtmodules-travis\ci\%TRAVIS_OS_NAME%\build.bat || exit /B 1
	xcopy /e /s /t /i install C:\ || exit /B 1
	cd ..
)
