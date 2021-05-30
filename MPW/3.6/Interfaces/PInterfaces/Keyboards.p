{
     File:       Keyboards.p
 
     Contains:   Keyboard API.
 
     Version:    Technology: Keyboard 1.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1997-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Keyboards;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __KEYBOARDS__}
{$SETC __KEYBOARDS__ := 1}

{$I+}
{$SETC KeyboardsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{——————————————————————————————————————————————————————————————————————————————————}
{ Keyboard API constants                                                           }
{——————————————————————————————————————————————————————————————————————————————————}
{ Keyboard API Trap Number. Should be moved to Traps.i }

CONST
	_KeyboardDispatch			= $AA7A;

	{	 Gestalt selector and values for the Keyboard API 	}
	gestaltKeyboardsAttr		= 'kbds';
	gestaltKBPS2Keyboards		= 1;
	gestaltKBPS2SetIDToAny		= 2;
	gestaltKBPS2SetTranslationTable = 4;

	{	 Keyboard API Error Codes 	}
	{
	   I stole the range blow from the empty space in the Allocation project but should
	   be updated to the officially registered range.
	}
	errKBPS2KeyboardNotAvailable = -30850;
	errKBIlligalParameters		= -30851;
	errKBFailSettingID			= -30852;
	errKBFailSettingTranslationTable = -30853;
	errKBFailWritePreference	= -30854;


	{	 Keyboard HW Layout Types 	}
	kKeyboardJIS				= 'JIS ';
	kKeyboardANSI				= 'ANSI';
	kKeyboardISO				= 'ISO ';
	kKeyboardUnknown			= $3F3F3F3F;					{  '????' }


	{	——————————————————————————————————————————————————————————————————————————————————	}
	{	 Keyboard API types                                                               	}
	{	——————————————————————————————————————————————————————————————————————————————————	}



	{	——————————————————————————————————————————————————————————————————————————————————	}
	{	 Keyboard API routines                                                            	}
	{	——————————————————————————————————————————————————————————————————————————————————	}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  KBInitialize()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION KBInitialize: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0000, $AA7A;
	{$ENDC}

{
 *  KBSetupPS2Keyboard()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION KBSetupPS2Keyboard(keyboardType: SInt16; VAR alternativeTable: SInt8): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0001, $AA7A;
	{$ENDC}

{
 *  KBGetPS2KeyboardID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION KBGetPS2KeyboardID(VAR keyboardType: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0002, $AA7A;
	{$ENDC}

{
 *  KBIsPS2KeyboardConnected()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION KBIsPS2KeyboardConnected: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0003, $AA7A;
	{$ENDC}

{
 *  KBIsPS2KeyboardEnabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION KBIsPS2KeyboardEnabled: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0004, $AA7A;
	{$ENDC}

{
 *  KBGetPS2KeyboardAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION KBGetPS2KeyboardAttributes: SInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0005, $AA7A;
	{$ENDC}

{
 *  KBSetKCAPForPS2Keyboard()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION KBSetKCAPForPS2Keyboard(kcapHandle: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0006, $AA7A;
	{$ENDC}

{
 *  KBSetupPS2KeyboardFromLayoutType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION KBSetupPS2KeyboardFromLayoutType(layoutType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0008, $AA7A;
	{$ENDC}

{
 *  KBGetPS2KeyboardLayoutType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION KBGetPS2KeyboardLayoutType(VAR layoutType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0009, $AA7A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  KBGetLayoutType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KBGetLayoutType(keyboardType: SInt16): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0007, $AA7A;
	{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := KeyboardsIncludes}

{$ENDC} {__KEYBOARDS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
