/************************************************************

Created: Thursday, September 7, 1989 at 6:46 PM
	ROMDefs.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1986-1989
	All rights reserved

************************************************************/


#ifndef __ROMDEFS__
#define __ROMDEFS__

#define appleFormat 1						/*Format of Declaration Data (IEEE will assign real value)*/
#define romRevision 1						/*Revision of Declaration Data Format*/
#define testPattern 1519594439				/*FHeader long word test pattern*/
#define sCodeRev 2							/*Revision of code (For sExec)*/
#define sCPU68000 1 						/*CPU type = 68000*/
#define sCPU68020 2 						/*CPU type = 68020*/
#define sMacOS68000 1						/*Mac OS, CPU type = 68000*/
#define board 0 							/*Board sResource - Required on all boards*/
#define displayVideoAppleTFB 16843009		/*Video with Apple parameters for TFB card.*/
#define displayVideoAppleGM 16843010		/*Video with Apple parameters for GM card.*/
#define networkEtherNetApple3Com 33620225	/*Ethernet with apple parameters for 3-Comm card.*/
#define testSimpleAppleAny -2147417856		/*A simple test sResource.*/
#define endOfList 255						/*End of list*/
#define defaultTO 100						/*100 retries.*/
#define sRsrcType 1 						/*Type of sResource*/
#define sRsrcName 2 						/*Name of sResource*/
#define sRsrcIcon 3 						/*Icon*/
#define sRsrcDrvrDir 4						/*Driver directory*/
#define sRsrcLoadDir 5						/*Load directory*/
#define sRsrcBootRec 6						/*sBoot record*/
#define sRsrcFlags 7						/*sResource Flags*/
#define sMacOS68020 2						/*Mac OS, CPU type = 68020*/
#define sRsrcHWDevId 8						/*Hardware Device Id*/
#define minorBaseOS 10						/*Offset to base of sResource in minor space.*/
#define minorLength 11
#define majorBaseOS 12						/*Offset to base of sResource in Major space.*/
#define majorLength 13
#define sDRVRDir 16 						/*sDriver directory*/
#define drSwApple 1
#define drHwTFB 1
#define drHw3Com 1
#define drHwBSC 3
#define catBoard 1
#define catTest 2
#define catDisplay 3
#define catNetwork 4
#define boardId 32							/*Board Id*/
#define pRAMInitData 33 					/*sPRAM init data*/
#define primaryInit 34						/*Primary init record*/
#define timeOutConst 35 					/*Time out constant*/
#define vendorInfo 36						/*Vendor information List. See Vendor List, below*/
#define boardFlags 37						/*Board Flags*/
#define vendorId 1							/*Vendor Id*/
#define serialNum 2 						/*Serial number*/
#define revLevel 3							/*Revision level*/
#define partNum 4							/*Part number*/
#define date 5								/*Last revision date of the card*/
#define typeBoard 0
#define typeApple 1
#define typeVideo 1
#define typeEtherNet 1
#define testByte 32 						/*Test byte.*/
#define testWord 33 						/*0021*/
#define testLong 34 						/*Test Long.*/
#define testString 35						/*Test String.*/


#endif
