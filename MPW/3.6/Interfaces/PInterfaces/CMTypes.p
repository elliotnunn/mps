{
     File:       CMTypes.p
 
     Contains:   xxx put contents here xxx
 
     Version:    Technology: ColorSync 3
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
 UNIT CMTypes;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CMTYPES__}
{$SETC __CMTYPES__ := 1}

{$I+}
{$SETC CMTypesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}




{ Standard type for ColorSync and other system error codes }

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CMError								= LONGINT;
	{	 Abstract data type for memory-based Profile 	}
	CMProfileRef    = ^LONGINT; { an opaque 32-bit type }
	CMProfileRefPtr = ^CMProfileRef;  { when a VAR xx:CMProfileRef parameter can be nil, it is changed to xx: CMProfileRefPtr }
	{	 Abstract data type for Profile search result 	}
	CMProfileSearchRef    = ^LONGINT; { an opaque 32-bit type }
	CMProfileSearchRefPtr = ^CMProfileSearchRef;  { when a VAR xx:CMProfileSearchRef parameter can be nil, it is changed to xx: CMProfileSearchRefPtr }
	{	 Abstract data type for BeginMatching(…) reference 	}
	CMMatchRef    = ^LONGINT; { an opaque 32-bit type }
	CMMatchRefPtr = ^CMMatchRef;  { when a VAR xx:CMMatchRef parameter can be nil, it is changed to xx: CMMatchRefPtr }
	{	 Abstract data type for ColorWorld reference 	}
	CMWorldRef    = ^LONGINT; { an opaque 32-bit type }
	CMWorldRefPtr = ^CMWorldRef;  { when a VAR xx:CMWorldRef parameter can be nil, it is changed to xx: CMWorldRefPtr }
	{	 Data type for ColorSync DisplayID reference 	}
	{	 On 8 & 9 this is a AVIDType 	}
	{	 On X this is a CGSDisplayID 	}
	CMDisplayIDType						= UInt32;

	{	 Caller-supplied flatten function 	}
{$IFC TYPED_FUNCTION_POINTERS}
	CMFlattenProcPtr = FUNCTION(command: LONGINT; VAR size: LONGINT; data: UNIV Ptr; refCon: UNIV Ptr): OSErr;
{$ELSEC}
	CMFlattenProcPtr = ProcPtr;
{$ENDC}

	{	 Caller-supplied progress function for Bitmap & PixMap matching routines 	}
{$IFC TYPED_FUNCTION_POINTERS}
	CMBitmapCallBackProcPtr = FUNCTION(progress: LONGINT; refCon: UNIV Ptr): BOOLEAN;
{$ELSEC}
	CMBitmapCallBackProcPtr = ProcPtr;
{$ENDC}

	{	 Caller-supplied progress function for NCMMConcatInit & NCMMNewLinkProfile routines 	}
{$IFC TYPED_FUNCTION_POINTERS}
	CMConcatCallBackProcPtr = FUNCTION(progress: LONGINT; refCon: UNIV Ptr): BOOLEAN;
{$ELSEC}
	CMConcatCallBackProcPtr = ProcPtr;
{$ENDC}

	{	 Caller-supplied filter function for Profile search 	}
{$IFC TYPED_FUNCTION_POINTERS}
	CMProfileFilterProcPtr = FUNCTION(prof: CMProfileRef; refCon: UNIV Ptr): BOOLEAN;
{$ELSEC}
	CMProfileFilterProcPtr = ProcPtr;
{$ENDC}

	{	 Caller-supplied function for profile access 	}
{$IFC TYPED_FUNCTION_POINTERS}
	CMProfileAccessProcPtr = FUNCTION(command: LONGINT; offset: LONGINT; VAR size: LONGINT; data: UNIV Ptr; refCon: UNIV Ptr): OSErr;
{$ELSEC}
	CMProfileAccessProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	CMFlattenUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	CMFlattenUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	CMBitmapCallBackUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	CMBitmapCallBackUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	CMConcatCallBackUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	CMConcatCallBackUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	CMProfileFilterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	CMProfileFilterUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	CMProfileAccessUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	CMProfileAccessUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppCMFlattenProcInfo = $00003FE0;
	uppCMBitmapCallBackProcInfo = $000003D0;
	uppCMConcatCallBackProcInfo = $000003D0;
	uppCMProfileFilterProcInfo = $000003D0;
	uppCMProfileAccessProcInfo = $0000FFE0;
	{
	 *  NewCMFlattenUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in 3.0 and later
	 	}
FUNCTION NewCMFlattenUPP(userRoutine: CMFlattenProcPtr): CMFlattenUPP; { old name was NewCMFlattenProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewCMBitmapCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION NewCMBitmapCallBackUPP(userRoutine: CMBitmapCallBackProcPtr): CMBitmapCallBackUPP; { old name was NewCMBitmapCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewCMConcatCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION NewCMConcatCallBackUPP(userRoutine: CMConcatCallBackProcPtr): CMConcatCallBackUPP; { old name was NewCMConcatCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewCMProfileFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION NewCMProfileFilterUPP(userRoutine: CMProfileFilterProcPtr): CMProfileFilterUPP; { old name was NewCMProfileFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewCMProfileAccessUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION NewCMProfileAccessUPP(userRoutine: CMProfileAccessProcPtr): CMProfileAccessUPP; { old name was NewCMProfileAccessProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeCMFlattenUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
PROCEDURE DisposeCMFlattenUPP(userUPP: CMFlattenUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeCMBitmapCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
PROCEDURE DisposeCMBitmapCallBackUPP(userUPP: CMBitmapCallBackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeCMConcatCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
PROCEDURE DisposeCMConcatCallBackUPP(userUPP: CMConcatCallBackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeCMProfileFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
PROCEDURE DisposeCMProfileFilterUPP(userUPP: CMProfileFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeCMProfileAccessUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
PROCEDURE DisposeCMProfileAccessUPP(userUPP: CMProfileAccessUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeCMFlattenUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION InvokeCMFlattenUPP(command: LONGINT; VAR size: LONGINT; data: UNIV Ptr; refCon: UNIV Ptr; userRoutine: CMFlattenUPP): OSErr; { old name was CallCMFlattenProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeCMBitmapCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION InvokeCMBitmapCallBackUPP(progress: LONGINT; refCon: UNIV Ptr; userRoutine: CMBitmapCallBackUPP): BOOLEAN; { old name was CallCMBitmapCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeCMConcatCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION InvokeCMConcatCallBackUPP(progress: LONGINT; refCon: UNIV Ptr; userRoutine: CMConcatCallBackUPP): BOOLEAN; { old name was CallCMConcatCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeCMProfileFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION InvokeCMProfileFilterUPP(prof: CMProfileRef; refCon: UNIV Ptr; userRoutine: CMProfileFilterUPP): BOOLEAN; { old name was CallCMProfileFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeCMProfileAccessUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION InvokeCMProfileAccessUPP(command: LONGINT; offset: LONGINT; VAR size: LONGINT; data: UNIV Ptr; refCon: UNIV Ptr; userRoutine: CMProfileAccessUPP): OSErr; { old name was CallCMProfileAccessProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMTypesIncludes}

{$ENDC} {__CMTYPES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
