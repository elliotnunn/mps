{
     File:       ENET.p
 
     Contains:   Ethernet Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1990-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	ENetSetGeneral				= 253;							{ Set "general" mode }
	ENetGetInfo					= 252;							{ Get info }
	ENetRdCancel				= 251;							{ Cancel read }
	ENetRead					= 250;							{ Read }
	ENetWrite					= 249;							{ Write }
	ENetDetachPH				= 248;							{ Detach protocol handler }
	ENetAttachPH				= 247;							{ Attach protocol handler }
	ENetAddMulti				= 246;							{ Add a multicast address }
	ENetDelMulti				= 245;							{ Delete a multicast address }

	EAddrRType					= 'eadr';						{ Alternate address resource type }


TYPE
	EParamBlockPtr = ^EParamBlock;
	EParamBlkPtr						= ^EParamBlock;
{$IFC TYPED_FUNCTION_POINTERS}
	ENETCompletionProcPtr = PROCEDURE(thePBPtr: EParamBlkPtr);
{$ELSEC}
	ENETCompletionProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ENETCompletionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ENETCompletionUPP = UniversalProcPtr;
{$ENDC}	
	EParamBlock = PACKED RECORD
		qLink:					QElemPtr;								{ General EParams }
		qType:					INTEGER;								{ queue type }
		ioTrap:					INTEGER;								{ routine trap }
		ioCmdAddr:				Ptr;									{ routine address }
		ioCompletion:			ENETCompletionUPP;						{ completion routine }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{ ->filename }
		ioVRefNum:				INTEGER;								{ volume reference or drive number }
		ioRefNum:				INTEGER;								{ driver reference number }
		csCode:					INTEGER;								{ Call command code }
		CASE INTEGER OF
		0: (
			eProtType:			INTEGER;								{ Ethernet protocol type }
			ePointer:			Ptr;									{ No support for PowerPC code }
			eBuffSize:			INTEGER;								{ buffer size }
			eDataSize:			INTEGER;								{ number of bytes read }
		   );
		1: (
			eMultiAddr:			PACKED ARRAY [0..5] OF Byte;			{ Multicast Address }
		   );
	END;


CONST
	uppENETCompletionProcInfo = $00009802;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewENETCompletionUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewENETCompletionUPP(userRoutine: ENETCompletionProcPtr): ENETCompletionUPP; { old name was NewENETCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeENETCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeENETCompletionUPP(userUPP: ENETCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeENETCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeENETCompletionUPP(thePBPtr: EParamBlkPtr; userRoutine: ENETCompletionUPP); { old name was CallENETCompletionProc }
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  EWrite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EWrite(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;

{
 *  EAttachPH()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EAttachPH(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;

{
 *  EDetachPH()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EDetachPH(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;

{
 *  ERead()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ERead(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;

{
 *  ERdCancel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ERdCancel(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;

{
 *  EGetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EGetInfo(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;

{
 *  ESetGeneral()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ESetGeneral(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;

{
 *  EAddMulti()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EAddMulti(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;

{
 *  EDelMulti()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EDelMulti(thePBptr: EParamBlkPtr; async: BOOLEAN): OSErr;



{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ENETIncludes}

{$ENDC} {__ENET__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
