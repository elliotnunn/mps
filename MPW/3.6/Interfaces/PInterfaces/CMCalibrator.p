{
     File:       CMCalibrator.p
 
     Contains:   ColorSync Calibration API
 
     Version:    Technology: ColorSync 2.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1998-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CMCalibrator;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CMCALIBRATOR__}
{$SETC __CMCALIBRATOR__ := 1}

{$I+}
{$SETC CMCalibratorIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CMAPPLICATION__}
{$I CMApplication.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	CalibrateEventProcPtr = PROCEDURE(VAR event: EventRecord);
{$ELSEC}
	CalibrateEventProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	CalibrateEventUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	CalibrateEventUPP = UniversalProcPtr;
{$ENDC}	

	{  Interface for new ColorSync monitor calibrators (ColorSync 2.6 and greater)  }


CONST
	kCalibratorNamePrefix		= 'cali';


TYPE
	CalibratorInfoPtr = ^CalibratorInfo;
	CalibratorInfo = RECORD
		dataSize:				UInt32;									{  Size of this structure - compatibility  }
		displayID:				CMDisplayIDType;						{  Contains an hDC on Win32  }
		profileLocationSize:	UInt32;									{  Max size for returned profile location  }
		profileLocationPtr:		CMProfileLocationPtr;					{  For returning the profile  }
		eventProc:				CalibrateEventUPP;						{  Ignored on Win32  }
		isGood:					BOOLEAN;								{  true or false  }
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	CanCalibrateProcPtr = FUNCTION(displayID: CMDisplayIDType; VAR errMessage: Str255): BOOLEAN;
{$ELSEC}
	CanCalibrateProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CalibrateProcPtr = FUNCTION(VAR theInfo: CalibratorInfo): OSErr;
{$ELSEC}
	CalibrateProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	CanCalibrateUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	CanCalibrateUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	CalibrateUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	CalibrateUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppCalibrateEventProcInfo = $000000C0;
	uppCanCalibrateProcInfo = $000003D0;
	uppCalibrateProcInfo = $000000E0;
	{
	 *  NewCalibrateEventUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewCalibrateEventUPP(userRoutine: CalibrateEventProcPtr): CalibrateEventUPP; { old name was NewCalibrateEventProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewCanCalibrateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION NewCanCalibrateUPP(userRoutine: CanCalibrateProcPtr): CanCalibrateUPP; { old name was NewCanCalibrateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewCalibrateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION NewCalibrateUPP(userRoutine: CalibrateProcPtr): CalibrateUPP; { old name was NewCalibrateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeCalibrateEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeCalibrateEventUPP(userUPP: CalibrateEventUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeCanCalibrateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
PROCEDURE DisposeCanCalibrateUPP(userUPP: CanCalibrateUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeCalibrateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
PROCEDURE DisposeCalibrateUPP(userUPP: CalibrateUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeCalibrateEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeCalibrateEventUPP(VAR event: EventRecord; userRoutine: CalibrateEventUPP); { old name was CallCalibrateEventProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeCanCalibrateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION InvokeCanCalibrateUPP(displayID: CMDisplayIDType; VAR errMessage: Str255; userRoutine: CanCalibrateUPP): BOOLEAN; { old name was CallCanCalibrateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeCalibrateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION InvokeCalibrateUPP(VAR theInfo: CalibratorInfo; userRoutine: CalibrateUPP): OSErr; { old name was CallCalibrateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  CMCalibrateDisplay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CMCalibrateDisplay(VAR theInfo: CalibratorInfo): OSErr;


{$IFC OLDROUTINENAMES }
{  Interface for original ColorSync monitor calibrators (ColorSync 2.5.x)  }

CONST
	kOldCalibratorNamePrefix	= 'Cali';


TYPE
	OldCalibratorInfoPtr = ^OldCalibratorInfo;
	OldCalibratorInfo = RECORD
		displayID:				CMDisplayIDType;						{  Contains an hDC on Win32  }
		profileLocation:		CMProfileLocation;
		eventProc:				CalibrateEventUPP;						{  Ignored on Win32  }
		reserved:				UInt32;									{  Unused  }
		flags:					UInt32;									{  Unused  }
		isGood:					BOOLEAN;								{  true or false  }
		byteFiller:				SInt8;									{  Unused  }
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	OldCanCalibrateProcPtr = FUNCTION(displayID: CMDisplayIDType): BOOLEAN;
{$ELSEC}
	OldCanCalibrateProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	OldCalibrateProcPtr = FUNCTION(VAR theInfo: OldCalibratorInfo): OSErr;
{$ELSEC}
	OldCalibrateProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	OldCanCalibrateUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	OldCanCalibrateUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	OldCalibrateUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	OldCalibrateUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppOldCanCalibrateProcInfo = $000000D0;
	uppOldCalibrateProcInfo = $000000E0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewOldCanCalibrateUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewOldCanCalibrateUPP(userRoutine: OldCanCalibrateProcPtr): OldCanCalibrateUPP; { old name was NewOldCanCalibrateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewOldCalibrateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewOldCalibrateUPP(userRoutine: OldCalibrateProcPtr): OldCalibrateUPP; { old name was NewOldCalibrateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeOldCanCalibrateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeOldCanCalibrateUPP(userUPP: OldCanCalibrateUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeOldCalibrateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeOldCalibrateUPP(userUPP: OldCalibrateUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeOldCanCalibrateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeOldCanCalibrateUPP(displayID: CMDisplayIDType; userRoutine: OldCanCalibrateUPP): BOOLEAN; { old name was CallOldCanCalibrateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeOldCalibrateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeOldCalibrateUPP(VAR theInfo: OldCalibratorInfo; userRoutine: OldCalibrateUPP): OSErr; { old name was CallOldCalibrateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OLDROUTINENAMES}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMCalibratorIncludes}

{$ENDC} {__CMCALIBRATOR__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
