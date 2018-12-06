@echo off
echo Fusion640 Setup
echo(
echo How to get to detailed RS232 Parameters:
echo Press Data I/O
echo Press Tape
echo Press Param
echo Press Param Detail
echo(		
echo Set the "TAP" Parameters as follows:
echo Tap1 = 1
echo Tap4 = 1
echo Tap5 = 1
echo Tap26 = 0000 0001
echo Tap28 = 0011 1010
echo Tap29 = 50
echo Tap30 = 10
echo Tap31 = 0
echo The rest of the "TAP" Parameters are Zero.
echo( 
echo "On the initial PARAM. Display, Set baud rate, data bits (8), Parity(None), StopBit(2), Hand Shake(Dc Control), Wait time(10.5sec), Format(ISO),"
echo "Same Wk.No(Alarm), Port(Com1)"		
echo(
pause
GOTO:EOF