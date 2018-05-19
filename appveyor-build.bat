@echo off

if "%PLATFORM%" == "winrt_x64_msvc2017" set LTS_MODS=qtjsonserializer qtrestclient qtdatasync
if "%PLATFORM%" == "winrt_x86_msvc2017" set LTS_MODS=qtjsonserializer qtrestclient qtdatasync
if "%PLATFORM%" == "winrt_armv7_msvc2017" set LTS_MODS=qtjsonserializer qtrestclient
if "%PLATFORM%" == "mingw53_32" set LTS_MODS=qtjsonserializer qtrestclient
if "%PLATFORM%" == "static" set LTS_MODS=qtrestclient

setlocal
for %%m in (%LTS_MODS%) do (
	:: prepare install dir link
	mklink /D C:\projects\%%m C:\projects\qtmodules-lts\%%m
	
	cd %%m
	:: copy over ci + build
	mklink /D qtmodules-travis ..\qtmodules-travis
	if "%%m" == "qtdatasync" call .\src\3rdparty\cryptopp\appveyor.bat || exit /B 1
	echo Building %%m ...
	call .\qtmodules-travis\ci\win\build.bat || exit /B 1
	:: copy install stuff into qt install
	xcopy /e /s /i install\* C:\ || exit /B 1
	cd ..
)
