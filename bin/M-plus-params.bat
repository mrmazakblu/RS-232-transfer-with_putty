@echo off
echo Mplus Com Parameters
echo(
echo(
echo Parameter	CMT	Tape	Description
echo G1		2	2	BAUD RATE
echo G2		3	3	STOP BITS
echo G3		0	1	PARITY TYPE
echo G4		0	0	PARITY CHECK
echo G5		3	3	DATA BITS
echo G6		1	1	TERM TYPE
echo G7		0	0	TERM CODE1
echo G8		0	0	TERM CODE2
echo G9		0	1	CR LF
echo G10		3	3	HAND SHAKE
echo G11		1	1	DC CODE
echo G12		0	0	DC CODE
echo G13		3000	150	REPLY TIMER
echo G14-16		0	0	RESERVED
echo(			
echo(			
echo(
echo PARAM	VALUE		PARAM	VALUE
echo G17	00000000		G35	0
echo G18	0		G36	0
echo G19	0		G37	0
echo G20	0		G38	0
echo G21	0		G39	00000000
echo G22	0		G40	00000001
echo G23	0		G41	0
echo G24	0		G42	0
echo G25	0		G43	0
echo G26	0		G44	0
echo G27	0		G45	0
echo G28	0		G46	0
echo G29	0		G47	0
echo G30	0		G48	0
echo G31	00000000		G49	00000000
echo G32	0		G50	^&45(E)
echo G33	0		G51	^&4E(N)
echo G34	0		G52	^&44(D)
echo(
pause
GOTO:EOF
