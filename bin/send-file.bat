@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )
title SEND FILE
color 11
call file-chooser.bat
echo Close window when file transfer is complete
plink -serial com%com% -sercfg %baud%,%data%,%parity%,%stop%,%flow%  < %file%
GOTO:EOF
