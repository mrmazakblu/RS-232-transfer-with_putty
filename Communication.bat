@echo off
title 		RS3232 FILE TRANSFER WITH PUTTY
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )
cd "%~dp0"
Setlocal EnableDelayedExpansion
IF EXIST "%~dp0\bin" SET PATH=%PATH%;"%~dp0\bin"
IF EXIST "%~dp0\putty" SET PATH=%PATH%;"%~dp0\putty"
IF NOT EXIST "%~dp0\from-machine" mkdir "%~dp0\from-machine"
IF NOT EXIST "%~dp0\to-machine" mkdir "%~dp0\to-machine"
echo CHECKING FOR NEWEST VERSION
"%~dp0bin\wget" -O "%~dp0bin\current_version.txt" https://raw.githubusercontent.com/mrmazakblu/RS-232-transfer-with_putty/master/bin/current_version.txt
< "%~dp0bin\current_version.txt" ( set /p "newver=" )
IF "%newver%" == "" SET newver=Failed_To_Retreave
set ver=V-3
set baud=4800
set stop=2
set data=7
set parity=e
set flow=X
set com=1
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:main
cls && color 9F
echo( 
echo               *****************************************
echo               *         MAZAK PROGRAM TRANSFER        *
echo               *          TOOL   "%newver%"            *
echo               *****************************************
echo( 
echo          ****************************************************
echo          * Com port is set to : %com%                           *
echo          * Baudrate is set at : %baud%                        *
echo          * Data bits is set to : %data%                          *
echo          * Parity is set to : %parity%                             *
echo          * Stop bits is set to : %stop%                          *
echo          * Flow-Control is set to : %flow%                       *
echo          * Capitol X=Xon/Xoff N=None R=RTS/CTS D=DSR/DTR    *
echo          ****************************************************
echo(
echo 		 Choose what you need to work on.
echo(
echo 	][******************************************************][
echo 	][ 1.  SEND TO MACHINE  ][ 2.  RECEIVE FROM MACHINE     ][
echo 	][******************************************************][
echo 	][ 3.  SETTINGS         ][ 4.  PARAMETERS               ][
echo 	][******************************************************][
echo 	][ 5.                 EXIT                              ][
echo 	][******************************************************][
echo(
CHOICE  /C 12345 /M "Choose Operation"
IF ERRORLEVEL 5 goto exit
IF ERRORLEVEL 4 goto params
IF ERRORLEVEL 3 goto settings
IF ERRORLEVEL 2 start receive-file.bat && goto main
IF ERRORLEVEL 1 start send-file.bat && goto main
goto main
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:settings
cls
echo Defaults are set in the Batch file.
echo(
echo DO YOU WANT TO MAKE CHANGES
CHOICE  /C 12 /M " 1=YES or 2=NO"
IF ERRORLEVEL 2 GOTO main
IF ERRORLEVEL 1 GOTO change1
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:change1 baudrate
echo     CHANGE BAUDRATE ?
CHOICE  /C 12 /M " 1=YES or 2=NO"
IF ERRORLEVEL 2 GOTO change2
IF ERRORLEVEL 1 GOTO change_baud
GOTO main
:change_baud
CHOICE  /C 123 /M " 1=4800  2=9600  3=19200 "
IF ERRORLEVEL 3 set baud=19200 && GOTO change2
IF ERRORLEVEL 2 set baud=9600 && GOTO change2
IF ERRORLEVEL 1 set baud=4800 && GOTO change2
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:change2 Com Port
echo Available COM PORTS
mode
echo    CHANGE COM PORT ?
CHOICE  /C 12 /M " 1=YES or 2=NO"
IF ERRORLEVEL 2 GOTO change3
IF ERRORLEVEL 1 GOTO change_com
:change_com
echo Default com port will reset when open program again
echo Curret port is set to %com%
set /P com="ENTER YOUR COM NUMBER ? " && GOTO change3
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:change3 Stop Bits
echo    Change Stop Bits ?
CHOICE  /C 12 /M " 1=YES or 2=NO"
IF ERRORLEVEL 2 GOTO change4
IF ERRORLEVEL 1 GOTO change_stop
:change_stop
CHOICE  /C 123 /M " 1= 1stop bit  2= 1.5 stop bit  3= 2 stop bit "
IF ERRORLEVEL 3 set stop=2 && GOTO change4
IF ERRORLEVEL 2 set stop=1.5 && GOTO change4
IF ERRORLEVEL 1 set stop=1 && GOTO change4
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:change4 Data Bits
echo    Change Data Bits ?
CHOICE  /C 12 /M " 1=YES or 2=NO"
IF ERRORLEVEL 2 GOTO change5
IF ERRORLEVEL 1 GOTO change_data
:change_data
CHOICE  /C 12 /M " 1= 7 data bits  2= 8 data bits "
IF ERRORLEVEL 2 set stop=8 && GOTO change5
IF ERRORLEVEL 1 set stop=7 && GOTO change5
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:change5 Parity
echo    Change Parity ?
CHOICE  /C 12 /M " 1=YES or 2=NO"
IF ERRORLEVEL 2 GOTO change6
IF ERRORLEVEL 1 GOTO change_parity
:change_parity
CHOICE  /C 123 /M " 1= even  2= odd  3= none "
IF ERRORLEVEL 3 set stop=n && GOTO change6
IF ERRORLEVEL 2 set stop=o && GOTO change6
IF ERRORLEVEL 1 set stop=e && GOTO change6
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:change6 Flow-Control
echo    Change Flow-Control ?
CHOICE  /C 12 /M " 1=YES or 2=NO"
IF ERRORLEVEL 2 GOTO main
IF ERRORLEVEL 1 GOTO change_flow
:change_flow
CHOICE  /C 1234 /M " 1=RTS/CTS 2=None 3=Xon/Xoff 4=DSR/DTR "
IF ERRORLEVEL 4 set stop=D && GOTO main
IF ERRORLEVEL 3 set stop=X && GOTO main
IF ERRORLEVEL 2 set stop=N && GOTO main
IF ERRORLEVEL 1 set stop=R && GOTO main
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:params
cls
CHOICE  /C 123 /M " 1= T-Plus  2= M-Plus  3= 640 "
IF ERRORLEVEL 3 call %~dp0bin\640-params.bat || goto main
IF ERRORLEVEL 2 call %~dp0bin\M-plus-params.bat || goto main
IF ERRORLEVEL 1 call %~dp0bin\T-plus-params.bat || goto main
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:exit
cls && color 00
exit
