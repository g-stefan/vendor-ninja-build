@echo off
rem Public domain
rem http://unlicense.org/
rem Created by Grigore Stefan <g_stefan@yahoo.com>

call build\msvc.config.cmd

set ACTION=%1
if "%1" == "" set ACTION=make
if not exist build\platform.%ACTION%.cmd goto BuildStepError
call build\platform.%ACTION%.cmd
if errorlevel 1 goto BuildStepError
goto :eof
:BuildStepError
exit 1
