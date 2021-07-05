@echo off
rem Public domain
rem http://unlicense.org/
rem Created by Grigore Stefan <g_stefan@yahoo.com>

echo -^> sign vendor-ninja-build

pushd temp\ninja-build\bin
for /r %%i in (*.dll) do call grigore-stefan.sign "apr" "%%i"
for /r %%i in (*.exe) do call grigore-stefan.sign "apr" "%%i"
popd
