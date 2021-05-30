{
     File:       SegLoad.p
 
     Contains:   Segment Loader Interfaces.
 
     Version:    Technology: Mac OS 8
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT SegLoad;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SEGLOAD__}
{$SETC __SEGLOAD__ := 1}

{$I+}
{$SETC SegLoadIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$IFC TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM OR NOT TARGET_OS_MAC }
{
   CountAppFiles, GetAppFiles, ClrAppFiles, GetAppParms, getappparms, 
   and the AppFile data structure and enums are obsolete. 
   They are still supported for writing old style 68K apps, 
   but they are not supported for CFM-based apps.
   Use AppleEvents to determine which files are to be 
   opened or printed from the Finder.
}

CONST
	appOpen						= 0;							{ Open the Document (s) }
	appPrint					= 1;							{ Print the Document (s) }


TYPE
	AppFilePtr = ^AppFile;
	AppFile = RECORD
		vRefNum:				INTEGER;
		fType:					OSType;
		versNum:				INTEGER;								{ versNum in high byte }
		fName:					Str255;
	END;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  CountAppFiles()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE CountAppFiles(VAR message: INTEGER; VAR count: INTEGER);

{
 *  GetAppFiles()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GetAppFiles(index: INTEGER; VAR theFile: AppFile);

{
 *  ClrAppFiles()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE ClrAppFiles(index: INTEGER);

{
 *  GetAppParms()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GetAppParms(VAR apName: Str255; VAR apRefNum: INTEGER; VAR apParam: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9F5;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{
   Because PowerPC applications don’t have segments.
   But, in order to allow applications to not have conditionalized
   source code, UnloadSeg is macro'ed away for PowerPC.
}
{$IFC TARGET_CPU_68K }
{$IFC CALL_NOT_IN_CARBON }
{
 *  UnloadSeg()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE UnloadSeg(routineAddr: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9F1;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ELSEC}
{$ENDC}  {TARGET_CPU_68K}

{  ExitToShell() has moved to Process.h }




{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SegLoadIncludes}

{$ENDC} {__SEGLOAD__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
