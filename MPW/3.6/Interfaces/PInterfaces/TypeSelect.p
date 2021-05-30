{
     File:       TypeSelect.p
 
     Contains:   TypeSelect Utilties
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT TypeSelect;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TYPESELECT__}
{$SETC __TYPESELECT__ := 1}

{$I+}
{$SETC TypeSelectIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	TSCode 						= SInt16;
CONST
	tsPreviousSelectMode		= -1;
	tsNormalSelectMode			= 0;
	tsNextSelectMode			= 1;


TYPE
	TypeSelectRecordPtr = ^TypeSelectRecord;
	TypeSelectRecord = RECORD
		tsrLastKeyTime:			UInt32;
		tsrScript:				ScriptCode;
		tsrKeyStrokes:			Str63;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	IndexToStringProcPtr = FUNCTION(item: INTEGER; VAR itemsScript: ScriptCode; VAR itemsStringPtr: StringPtr; yourDataPtr: UNIV Ptr): BOOLEAN;
{$ELSEC}
	IndexToStringProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	IndexToStringUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	IndexToStringUPP = UniversalProcPtr;
{$ENDC}	
	{
	 *  TypeSelectClear()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
PROCEDURE TypeSelectClear(VAR tsr: TypeSelectRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0028, $A9ED;
	{$ENDC}

{
        Long ago the implementation of TypeSelectNewKey had a bug that
        required the high word of D0 to be zero or the function did not work.
        Although fixed now, we are continuing to clear the high word
        just in case someone tries to run on an older system.
    }
{
 *  TypeSelectNewKey()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TypeSelectNewKey({CONST}VAR theEvent: EventRecord; VAR tsr: TypeSelectRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $3F3C, $002A, $A9ED;
	{$ENDC}

{
 *  TypeSelectFindItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TypeSelectFindItem({CONST}VAR tsr: TypeSelectRecord; listSize: INTEGER; selectMode: TSCode; getStringProc: IndexToStringUPP; yourDataPtr: UNIV Ptr): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $002C, $A9ED;
	{$ENDC}


{
 *  TypeSelectCompare()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TypeSelectCompare({CONST}VAR tsr: TypeSelectRecord; testStringScript: ScriptCode; testStringPtr: StringPtr): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $002E, $A9ED;
	{$ENDC}


CONST
	uppIndexToStringProcInfo = $00003F90;
	{
	 *  NewIndexToStringUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewIndexToStringUPP(userRoutine: IndexToStringProcPtr): IndexToStringUPP; { old name was NewIndexToStringProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeIndexToStringUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeIndexToStringUPP(userUPP: IndexToStringUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeIndexToStringUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeIndexToStringUPP(item: INTEGER; VAR itemsScript: ScriptCode; VAR itemsStringPtr: StringPtr; yourDataPtr: UNIV Ptr; userRoutine: IndexToStringUPP): BOOLEAN; { old name was CallIndexToStringProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}




{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TypeSelectIncludes}

{$ENDC} {__TYPESELECT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
