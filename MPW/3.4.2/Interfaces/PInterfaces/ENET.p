{
 	File:		ENET.p
 
 	Contains:	Ethernet Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ENET;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ENET__}
{$SETC __ENET__ := 1}

{$I+}
{$SETC ENETIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}
{	MixedMode.p													}
{	Memory.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	ENetSetGeneral				= 253;							{Set "general" mode}
	ENetGetInfo					= 252;							{Get info}
	ENetRdCancel				= 251;							{Cancel read}
	ENetRead					= 250;							{Read}
	ENetWrite					= 249;							{Write}
	ENetDetachPH				= 248;							{Detach protocol handler}
	ENetAttachPH				= 247;							{Attach protocol handler}
	ENetAddMulti				= 246;							{Add a multicast address}
	ENetDelMulti				= 245;							{Delete a multicast address}
	EAddrRType					= 'eadr';

	
TYPE
	EParamBlkPtr = ^EParamBlock;

	{
		ENETCompletionProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => thePBPtr    	A0.L
	}
	ENETCompletionProcPtr = Register68kProcPtr;  { register PROCEDURE ENETCompletion(thePBPtr: EParamBlkPtr); }
	ENETCompletionUPP = UniversalProcPtr;

	EParamBlock = PACKED RECORD
		qLink:					^QElem;									{General EParams}
		qType:					INTEGER;								{queue type}
		ioTrap:					INTEGER;								{routine trap}
		ioCmdAddr:				Ptr;									{routine address}
		ioCompletion:			ENETCompletionUPP;						{completion routine}
		ioResult:				OSErr;									{result code}
		ioNamePtr:				StringPtr;								{->filename}
		ioVRefNum:				INTEGER;								{volume reference or drive number}
		ioRefNum:				INTEGER;								{driver reference number}
		csCode:					INTEGER;								{Call command code}
		CASE INTEGER OF
		0: (
			eProtType:					INTEGER;							{Ethernet protocol type}
			ePointer:					Ptr;								{No support for PowerPC code}
			eBuffSize:					INTEGER;							{buffer size}
			eDataSize:					INTEGER;							{number of bytes read}
		   );
		1: (
			eMultiAddr:					PACKED ARRAY [0..5] OF Byte;		{Multicast Address}
		   );
	END;

CONST
	uppENETCompletionProcInfo = $00009802; { Register PROCEDURE (4 bytes in A0); }

PROCEDURE CallENETCompletionProc(thePBPtr: EParamBlkPtr; userRoutine: ENETCompletionUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

FUNCTION NewENETCompletionProc(userRoutine: ENETCompletionProcPtr): ENETCompletionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION EWrite(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;
FUNCTION EAttachPH(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;
FUNCTION EDetachPH(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;
FUNCTION ERead(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;
FUNCTION ERdCancel(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;
FUNCTION EGetInfo(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;
FUNCTION ESetGeneral(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;
FUNCTION EAddMulti(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;
FUNCTION EDelMulti(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ENETIncludes}

{$ENDC} {__ENET__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
