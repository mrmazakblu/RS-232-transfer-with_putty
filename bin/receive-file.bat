@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )
title RECEIVE FILE
color C0
for /f "delims=" %%a in ('wmic os get LocalDateTime  ^| findstr ^[0-9]') do set "dt=%%a"
set "timestamp=%dt:~0,4%-%dt:~4,2%-%dt:~6,2%_%dt:~8,2%-%dt:~10,2%"	
SET /P filename="What would you like to name file?"
echo Close window when file transfer is complete
plink -serial com%com% -sercfg %baud%,%data%,%parity%,%stop%,%flow%  > "./from-machine/%filename%_%timestamp%.txt"
GOTO:EOF
