{
 	File:		DeskBus.p
 
 	Contains:	Apple Desktop Bus (ADB) Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.2 on ETO #20
 
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
 UNIT DeskBus;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DESKBUS__}
{$SETC __DESKBUS__ := 1}

{$I+}
{$SETC DeskBusIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
	
TYPE
	ADBAddress = SInt8;

	{
		ADBCompletionProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => dataBuffPtr 	A0.L
		 => opDataAreaPtr	A2.L
		 => command     	D0.L
	}
	ADBCompletionProcPtr = Register68kProcPtr;  { register PROCEDURE ADBCompletion(dataBuffPtr: Ptr; opDataAreaPtr: Ptr; command: LONGINT); }
	ADBCompletionUPP = UniversalProcPtr;

CONST
	uppADBCompletionProcInfo = $007B9802; { Register PROCEDURE (4 bytes in A0, 4 bytes in A2, 4 bytes in D0); }

FUNCTION NewADBCompletionProc(userRoutine: ADBCompletionProcPtr): ADBCompletionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallADBCompletionProc(dataBuffPtr: Ptr; opDataAreaPtr: Ptr; command: LONGINT; userRoutine: ADBCompletionUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}
TYPE
	{
		ADBDeviceDriverProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => devAddress  	D0.B
		 => devType     	D1.B
	}
	ADBDeviceDriverProcPtr = Register68kProcPtr;  { register PROCEDURE ADBDeviceDriver(devAddress: ByteParameter; devType: ByteParameter); }
	ADBDeviceDriverUPP = UniversalProcPtr;

CONST
	uppADBDeviceDriverProcInfo = $00050802; { Register PROCEDURE (1 byte in D0, 1 byte in D1); }

FUNCTION NewADBDeviceDriverProc(userRoutine: ADBDeviceDriverProcPtr): ADBDeviceDriverUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallADBDeviceDriverProc(devAddress: ByteParameter; devType: ByteParameter; userRoutine: ADBDeviceDriverUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}
TYPE
	{
		ADBServiceRoutineProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => dataBuffPtr 	A0.L
		 => completionProc	A1.L
		 => dataPtr     	A2.L
		 => command     	D0.L
	}
	ADBServiceRoutineProcPtr = Register68kProcPtr;  { register PROCEDURE ADBServiceRoutine(dataBuffPtr: Ptr; completionProc: ADBCompletionUPP; dataPtr: Ptr; command: LONGINT); }
	ADBServiceRoutineUPP = UniversalProcPtr;

CONST
	uppADBServiceRoutineProcInfo = $0F779802; { Register PROCEDURE (4 bytes in A0, 4 bytes in A1, 4 bytes in A2, 4 bytes in D0); }

FUNCTION NewADBServiceRoutineProc(userRoutine: ADBServiceRoutineProcPtr): ADBServiceRoutineUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallADBServiceRoutineProc(dataBuffPtr: Ptr; completionProc: ADBCompletionUPP; dataPtr: Ptr; command: LONGINT; userRoutine: ADBServiceRoutineUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}
TYPE
	{
		ADBInitProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => callOrder   	D0.B
	}
	ADBInitProcPtr = Register68kProcPtr;  { register PROCEDURE ADBInit(callOrder: ByteParameter); }
	ADBInitUPP = UniversalProcPtr;

CONST
	uppADBInitProcInfo = $00000802; { Register PROCEDURE (1 byte in D0); }

FUNCTION NewADBInitProc(userRoutine: ADBInitProcPtr): ADBInitUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallADBInitProc(callOrder: ByteParameter; userRoutine: ADBInitUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

TYPE
	ADBOpBlock = RECORD
		dataBuffPtr:			Ptr;									{ address of data buffer }
		opServiceRtPtr:			ADBServiceRoutineUPP;					{ service routine pointer }
		opDataAreaPtr:			Ptr;									{ optional data area address }
	END;

	ADBOpBPtr = ^ADBOpBlock;

	ADBDataBlock = PACKED RECORD
		devType:				SInt8;									{ device type }
		origADBAddr:			ADBAddress;								{ original ADB Address }
		dbServiceRtPtr:			ADBServiceRoutineUPP;					{ service routine pointer }
		dbDataAreaAddr:			Ptr;									{ data area address }
	END;

	ADBDBlkPtr = ^ADBDataBlock;

	ADBSetInfoBlock = RECORD
		siService:				ADBServiceRoutineUPP;					{ service routine pointer }
		siDataAreaAddr:			Ptr;									{ data area address }
	END;

	ADBSInfoPtr = ^ADBSetInfoBlock;


PROCEDURE ADBReInit;
	{$IFC NOT GENERATINGCFM}
	INLINE $A07B;
	{$ENDC}
FUNCTION ADBOp(data: Ptr; compRout: ADBCompletionUPP; buffer: Ptr; commandNum: INTEGER): OSErr;
FUNCTION CountADBs: INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A077, $3E80;
	{$ENDC}
FUNCTION GetIndADB(VAR info: ADBDataBlock; devTableIndex: INTEGER): ADBAddress;
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $205F, $A078, $1E80;
	{$ENDC}
FUNCTION GetADBInfo(VAR info: ADBDataBlock; adbAddr: ByteParameter): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $101F, $205F, $A079, $3E80;
	{$ENDC}
FUNCTION SetADBInfo({CONST}VAR info: ADBSetInfoBlock; adbAddr: ByteParameter): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $101F, $205F, $A07A, $3E80;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DeskBusIncludes}

{$ENDC} {__DESKBUS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
