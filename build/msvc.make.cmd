@echo off
rem Public domain
rem http://unlicense.org/
rem Created by Grigore Stefan <g_stefan@yahoo.com>

set ACTION=%1
if "%1" == "" set ACTION=make

echo -^> %ACTION% vendor-ninja-build

goto cmdXDefined
:cmdX
%*
if errorlevel 1 goto cmdXError
goto :eof
:cmdXError
echo "Error: %ACTION%"
exit 1
:cmdXDefined

if not "%ACTION%" == "make" goto :eof

call :cmdX xyo-cc --mode=%ACTION% --source-has-archive ninja-build

if not exist temp\ mkdir temp

set INCLUDE=%XYO_PATH_REPOSITORY%\include;%INCLUDE%
set LIB=%XYO_PATH_REPOSITORY%\lib;%LIB%
set WORKSPACE_PATH=%CD%
set WORKSPACE_PATH_BUILD=%WORKSPACE_PATH%\temp

if exist %WORKSPACE_PATH_BUILD%\build.done.flag goto :eof

if not exist temp\cmake mkdir temp\cmake
pushd temp\cmake

SET CC=cl.exe
SET CXX=cl.exe

SET CMD_CONFIG=cmake
SET CMD_CONFIG=%CMD_CONFIG% ../../source
SET CMD_CONFIG=%CMD_CONFIG% -G "NMake Makefiles"
SET CMD_CONFIG=%CMD_CONFIG% -DCMAKE_BUILD_TYPE=Release
SET CMD_CONFIG=%CMD_CONFIG% -DCMAKE_INSTALL_PREFIX=%WORKSPACE_PATH_BUILD%\ninja-build

if not exist %WORKSPACE_PATH_BUILD%\build.configured.flag %CMD_CONFIG%
if errorlevel 1 goto makeError
if not exist %WORKSPACE_PATH_BUILD%\build.configured.flag echo configured > %WORKSPACE_PATH_BUILD%\build.configured.flag

nmake
if errorlevel 1 goto makeError
nmake install
if errorlevel 1 goto makeError
nmake clean
if errorlevel 1 goto makeError

goto buildDone

:makeError
popd
echo "Error: make"
exit 1

:buildDone
popd
echo done > %WORKSPACE_PATH_BUILD%\build.done.flag

