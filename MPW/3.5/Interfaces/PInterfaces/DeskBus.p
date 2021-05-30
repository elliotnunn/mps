{
     File:       DeskBus.p
 
     Contains:   Apple Desktop Bus (ADB) Interfaces.
 
     Version:    Technology: System 8.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1987-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT DeskBus;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DESKBUS__}
{$SETC __DESKBUS__ := 1}

{$I+}
{$SETC DeskBusIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$IFC TARGET_OS_MAC }

TYPE
	ADBAddress							= SInt8;
{$IFC TYPED_FUNCTION_POINTERS}
	ADBCompletionProcPtr = PROCEDURE(buffer: Ptr; refCon: Ptr; command: LONGINT);
{$ELSEC}
	ADBCompletionProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ADBDeviceDriverProcPtr = PROCEDURE(devAddress: SInt8; devType: SInt8);
{$ELSEC}
	ADBDeviceDriverProcPtr = Register68kProcPtr;
{$ENDC}

	{	
	    TempADBServiceRoutineUPP is needed because of circular definition of
	    ADBServiceRoutineProcPtr and ADBServiceRoutineUPP depending on each other.
		}
	TempADBServiceRoutineUPP			= ProcPtr;
{$IFC TYPED_FUNCTION_POINTERS}
	ADBServiceRoutineProcPtr = PROCEDURE(buffer: Ptr; completionProc: TempADBServiceRoutineUPP; refCon: Ptr; command: LONGINT);
{$ELSEC}
	ADBServiceRoutineProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ADBInitProcPtr = PROCEDURE(callOrder: SInt8);
{$ELSEC}
	ADBInitProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ADBCompletionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ADBCompletionUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ADBDeviceDriverUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ADBDeviceDriverUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ADBServiceRoutineUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ADBServiceRoutineUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ADBInitUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ADBInitUPP = UniversalProcPtr;
{$ENDC}	
	ADBDataBlockPtr = ^ADBDataBlock;
	ADBDataBlock = PACKED RECORD
		devType:				SInt8;									{  original handler ID  }
		origADBAddr:			SInt8;									{  original ADB Address  }
		dbServiceRtPtr:			ADBServiceRoutineUPP;					{  service routine pointer  }
		dbDataAreaAddr:			Ptr;									{  this field is passed as the refCon parameter to the service routine  }
	END;

	ADBDBlkPtr							= ^ADBDataBlock;
	ADBSetInfoBlockPtr = ^ADBSetInfoBlock;
	ADBSetInfoBlock = RECORD
		siService:				ADBServiceRoutineUPP;					{  service routine pointer  }
		siDataAreaAddr:			Ptr;									{  this field is passed as the refCon parameter to the service routine  }
	END;

	ADBSInfoPtr							= ^ADBSetInfoBlock;
	{	 ADBOpBlock is only used when calling ADBOp from 68k assembly code 	}
	ADBOpBlockPtr = ^ADBOpBlock;
	ADBOpBlock = RECORD
		dataBuffPtr:			Ptr;									{  buffer: pointer to variable length data buffer  }
		opServiceRtPtr:			ADBServiceRoutineUPP;					{  completionProc: completion routine pointer  }
		opDataAreaPtr:			Ptr;									{  refCon: this field is passed as the refCon parameter to the completion routine  }
	END;

	ADBOpBPtr							= ^ADBOpBlock;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  ADBReInit()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE ADBReInit;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A07B;
	{$ENDC}

{
    ADBOp has a different interface for 68k assembly than for everything else
    for 68k assembly the interface is 
    #pragma parameter __D0 ADBOp(__A0,__D0)
    OSErr ADBOp( ADBOpBlock * pb, short commandNum );
}
{
    IMPORTANT NOTE:
    "Inside Macintosh: Devices" documents the completion routine for ADBOp will be called with
    four parameters using 68k register based calling conventions, specifically the completion routine
    passed in should be of type ADBServiceRoutineProcPtr. However, when upp types were first added
    to this interface file, the type ADBCompletionUPP was mistakenly used for the second parameter
    to ADBOp. Since applications have shipped using completion routines of type ADBCompletionUPP,
    the mistake cannot be corrected.
    The only difference between ADBServiceRoutineUPP and ADBCompletionUPP is the former takes an extra
    argument which is a pointer to itself, fortunately not needed for PowerPC code.
    For compatibility with existing 68k code, when an ADBOp completion routine is called,
    68k register A1 will point to the completion routine, as documented in Inside Mac.
}
{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC CALL_NOT_IN_CARBON }
{
 *  ADBOp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ADBOp(refCon: Ptr; compRout: ADBCompletionUPP; buffer: Ptr; commandNum: INTEGER): OSErr;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC CALL_NOT_IN_CARBON }
{
 *  CountADBs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CountADBs: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A077, $3E80;
	{$ENDC}

{
 *  GetIndADB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetIndADB(VAR info: ADBDataBlock; devTableIndex: INTEGER): ADBAddress;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A078, $1E80;
	{$ENDC}

{
 *  GetADBInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetADBInfo(VAR info: ADBDataBlock; adbAddr: ADBAddress): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $205F, $A079, $3E80;
	{$ENDC}

{
 *  SetADBInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SetADBInfo({CONST}VAR info: ADBSetInfoBlock; adbAddr: ADBAddress): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $205F, $A07A, $3E80;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

CONST
	uppADBCompletionProcInfo = $007B9802;
	uppADBDeviceDriverProcInfo = $00050802;
	uppADBServiceRoutineProcInfo = $0F779802;
	uppADBInitProcInfo = $00000802;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewADBCompletionUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewADBCompletionUPP(userRoutine: ADBCompletionProcPtr): ADBCompletionUPP; { old name was NewADBCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewADBDeviceDriverUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewADBDeviceDriverUPP(userRoutine: ADBDeviceDriverProcPtr): ADBDeviceDriverUPP; { old name was NewADBDeviceDriverProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewADBServiceRoutineUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewADBServiceRoutineUPP(userRoutine: ADBServiceRoutineProcPtr): ADBServiceRoutineUPP; { old name was NewADBServiceRoutineProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewADBInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewADBInitUPP(userRoutine: ADBInitProcPtr): ADBInitUPP; { old name was NewADBInitProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeADBCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeADBCompletionUPP(userUPP: ADBCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeADBDeviceDriverUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeADBDeviceDriverUPP(userUPP: ADBDeviceDriverUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeADBServiceRoutineUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeADBServiceRoutineUPP(userUPP: ADBServiceRoutineUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeADBInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeADBInitUPP(userUPP: ADBInitUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeADBCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeADBCompletionUPP(buffer: Ptr; refCon: Ptr; command: LONGINT; userRoutine: ADBCompletionUPP); { old name was CallADBCompletionProc }
{
 *  InvokeADBDeviceDriverUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeADBDeviceDriverUPP(devAddress: SInt8; devType: SInt8; userRoutine: ADBDeviceDriverUPP); { old name was CallADBDeviceDriverProc }
{
 *  InvokeADBServiceRoutineUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeADBServiceRoutineUPP(buffer: Ptr; completionProc: TempADBServiceRoutineUPP; refCon: Ptr; command: LONGINT; userRoutine: ADBServiceRoutineUPP); { old name was CallADBServiceRoutineProc }
{
 *  InvokeADBInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeADBInitUPP(callOrder: SInt8; userRoutine: ADBInitUPP); { old name was CallADBInitProc }
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_OS_MAC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DeskBusIncludes}

{$ENDC} {__DESKBUS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
