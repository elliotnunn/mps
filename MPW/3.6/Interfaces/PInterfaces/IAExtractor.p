{
     File:       IAExtractor.p
 
     Contains:   Interfaces to Find by Content Plugins that scan files
 
     Version:    Technology: Mac OS 8.6
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT IAExtractor;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __IAEXTRACTOR__}
{$SETC __IAEXTRACTOR__ := 1}

{$I+}
{$SETC IAExtractorIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ modes for IASetDocAccessorReadPositionProc }

CONST
	kIAFromStartMode			= 0;
	kIAFromCurrMode				= 1;
	kIAFromEndMode				= 2;

	{	 versions for plug-ins 	}
	kIAExtractorVersion1		= $00010001;
	kIAExtractorCurrentVersion	= $00010001;

	{	 types 	}

TYPE
	IAResult							= OSStatus;
	IAPluginRef    = ^LONGINT; { an opaque 32-bit type }
	IAPluginRefPtr = ^IAPluginRef;  { when a VAR xx:IAPluginRef parameter can be nil, it is changed to xx: IAPluginRefPtr }
	IADocAccessorRef    = ^LONGINT; { an opaque 32-bit type }
	IADocAccessorRefPtr = ^IADocAccessorRef;  { when a VAR xx:IADocAccessorRef parameter can be nil, it is changed to xx: IADocAccessorRefPtr }
	IADocRef    = ^LONGINT; { an opaque 32-bit type }
	IADocRefPtr = ^IADocRef;  { when a VAR xx:IADocRef parameter can be nil, it is changed to xx: IADocRefPtr }
	{	 IAPluginInitBlock functions 	}
{$IFC TYPED_FUNCTION_POINTERS}
	IAAllocProcPtr = FUNCTION(inSize: UInt32): Ptr; C;
{$ELSEC}
	IAAllocProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	IAFreeProcPtr = PROCEDURE(inObject: UNIV Ptr); C;
{$ELSEC}
	IAFreeProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	IAIdleProcPtr = FUNCTION: ByteParameter; C;
{$ELSEC}
	IAIdleProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	IAAllocUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	IAAllocUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	IAFreeUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	IAFreeUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	IAIdleUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	IAIdleUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppIAAllocProcInfo = $000000F1;
	uppIAFreeProcInfo = $000000C1;
	uppIAIdleProcInfo = $00000011;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewIAAllocUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewIAAllocUPP(userRoutine: IAAllocProcPtr): IAAllocUPP; { old name was NewIAAllocProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewIAFreeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewIAFreeUPP(userRoutine: IAFreeProcPtr): IAFreeUPP; { old name was NewIAFreeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewIAIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewIAIdleUPP(userRoutine: IAIdleProcPtr): IAIdleUPP; { old name was NewIAIdleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeIAAllocUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeIAAllocUPP(userUPP: IAAllocUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeIAFreeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeIAFreeUPP(userUPP: IAFreeUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeIAIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeIAIdleUPP(userUPP: IAIdleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeIAAllocUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeIAAllocUPP(inSize: UInt32; userRoutine: IAAllocUPP): Ptr; { old name was CallIAAllocProc }
{
 *  InvokeIAFreeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeIAFreeUPP(inObject: UNIV Ptr; userRoutine: IAFreeUPP); { old name was CallIAFreeProc }
{
 *  InvokeIAIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeIAIdleUPP(userRoutine: IAIdleUPP): ByteParameter; { old name was CallIAIdleProc }
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	IAPluginInitBlockPtr = ^IAPluginInitBlock;
	IAPluginInitBlock = RECORD
		Alloc:					IAAllocUPP;
		Free:					IAFreeUPP;
		Idle:					IAIdleUPP;
	END;

	{	 IADocAccessorRecord  functions 	}
{$IFC TYPED_FUNCTION_POINTERS}
	IADocAccessorOpenProcPtr = FUNCTION(inAccessor: IADocAccessorRef): OSStatus; C;
{$ELSEC}
	IADocAccessorOpenProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	IADocAccessorCloseProcPtr = FUNCTION(inAccessor: IADocAccessorRef): OSStatus; C;
{$ELSEC}
	IADocAccessorCloseProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	IADocAccessorReadProcPtr = FUNCTION(inAccessor: IADocAccessorRef; buffer: UNIV Ptr; VAR ioSize: UInt32): OSStatus; C;
{$ELSEC}
	IADocAccessorReadProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	IASetDocAccessorReadPositionProcPtr = FUNCTION(inAccessor: IADocAccessorRef; inMode: SInt32; inOffset: SInt32): OSStatus; C;
{$ELSEC}
	IASetDocAccessorReadPositionProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	IAGetDocAccessorReadPositionProcPtr = FUNCTION(inAccessor: IADocAccessorRef; VAR outPostion: SInt32): OSStatus; C;
{$ELSEC}
	IAGetDocAccessorReadPositionProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	IAGetDocAccessorEOFProcPtr = FUNCTION(inAccessor: IADocAccessorRef; VAR outEOF: SInt32): OSStatus; C;
{$ELSEC}
	IAGetDocAccessorEOFProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	IADocAccessorOpenUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	IADocAccessorOpenUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	IADocAccessorCloseUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	IADocAccessorCloseUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	IADocAccessorReadUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	IADocAccessorReadUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	IASetDocAccessorReadPositionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	IASetDocAccessorReadPositionUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	IAGetDocAccessorReadPositionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	IAGetDocAccessorReadPositionUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	IAGetDocAccessorEOFUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	IAGetDocAccessorEOFUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppIADocAccessorOpenProcInfo = $000000F1;
	uppIADocAccessorCloseProcInfo = $000000F1;
	uppIADocAccessorReadProcInfo = $00000FF1;
	uppIASetDocAccessorReadPositionProcInfo = $00000FF1;
	uppIAGetDocAccessorReadPositionProcInfo = $000003F1;
	uppIAGetDocAccessorEOFProcInfo = $000003F1;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewIADocAccessorOpenUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewIADocAccessorOpenUPP(userRoutine: IADocAccessorOpenProcPtr): IADocAccessorOpenUPP; { old name was NewIADocAccessorOpenProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewIADocAccessorCloseUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewIADocAccessorCloseUPP(userRoutine: IADocAccessorCloseProcPtr): IADocAccessorCloseUPP; { old name was NewIADocAccessorCloseProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewIADocAccessorReadUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewIADocAccessorReadUPP(userRoutine: IADocAccessorReadProcPtr): IADocAccessorReadUPP; { old name was NewIADocAccessorReadProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewIASetDocAccessorReadPositionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewIASetDocAccessorReadPositionUPP(userRoutine: IASetDocAccessorReadPositionProcPtr): IASetDocAccessorReadPositionUPP; { old name was NewIASetDocAccessorReadPositionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewIAGetDocAccessorReadPositionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewIAGetDocAccessorReadPositionUPP(userRoutine: IAGetDocAccessorReadPositionProcPtr): IAGetDocAccessorReadPositionUPP; { old name was NewIAGetDocAccessorReadPositionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewIAGetDocAccessorEOFUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewIAGetDocAccessorEOFUPP(userRoutine: IAGetDocAccessorEOFProcPtr): IAGetDocAccessorEOFUPP; { old name was NewIAGetDocAccessorEOFProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeIADocAccessorOpenUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeIADocAccessorOpenUPP(userUPP: IADocAccessorOpenUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeIADocAccessorCloseUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeIADocAccessorCloseUPP(userUPP: IADocAccessorCloseUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeIADocAccessorReadUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeIADocAccessorReadUPP(userUPP: IADocAccessorReadUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeIASetDocAccessorReadPositionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeIASetDocAccessorReadPositionUPP(userUPP: IASetDocAccessorReadPositionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeIAGetDocAccessorReadPositionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeIAGetDocAccessorReadPositionUPP(userUPP: IAGetDocAccessorReadPositionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeIAGetDocAccessorEOFUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeIAGetDocAccessorEOFUPP(userUPP: IAGetDocAccessorEOFUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeIADocAccessorOpenUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeIADocAccessorOpenUPP(inAccessor: IADocAccessorRef; userRoutine: IADocAccessorOpenUPP): OSStatus; { old name was CallIADocAccessorOpenProc }
{
 *  InvokeIADocAccessorCloseUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeIADocAccessorCloseUPP(inAccessor: IADocAccessorRef; userRoutine: IADocAccessorCloseUPP): OSStatus; { old name was CallIADocAccessorCloseProc }
{
 *  InvokeIADocAccessorReadUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeIADocAccessorReadUPP(inAccessor: IADocAccessorRef; buffer: UNIV Ptr; VAR ioSize: UInt32; userRoutine: IADocAccessorReadUPP): OSStatus; { old name was CallIADocAccessorReadProc }
{
 *  InvokeIASetDocAccessorReadPositionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeIASetDocAccessorReadPositionUPP(inAccessor: IADocAccessorRef; inMode: SInt32; inOffset: SInt32; userRoutine: IASetDocAccessorReadPositionUPP): OSStatus; { old name was CallIASetDocAccessorReadPositionProc }
{
 *  InvokeIAGetDocAccessorReadPositionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeIAGetDocAccessorReadPositionUPP(inAccessor: IADocAccessorRef; VAR outPostion: SInt32; userRoutine: IAGetDocAccessorReadPositionUPP): OSStatus; { old name was CallIAGetDocAccessorReadPositionProc }
{
 *  InvokeIAGetDocAccessorEOFUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeIAGetDocAccessorEOFUPP(inAccessor: IADocAccessorRef; VAR outEOF: SInt32; userRoutine: IAGetDocAccessorEOFUPP): OSStatus; { old name was CallIAGetDocAccessorEOFProc }
{$ENDC}  {CALL_NOT_IN_CARBON}

{ IADocAccessorRecord }

TYPE
	IADocAccessorRecordPtr = ^IADocAccessorRecord;
	IADocAccessorRecord = RECORD
		docAccessor:			IADocAccessorRef;
		OpenDoc:				IADocAccessorOpenUPP;
		CloseDoc:				IADocAccessorCloseUPP;
		ReadDoc:				IADocAccessorReadUPP;
		SetReadPosition:		IASetDocAccessorReadPositionUPP;
		GetReadPosition:		IAGetDocAccessorReadPositionUPP;
		GetEOF:					IAGetDocAccessorEOFUPP;
	END;

	IADocAccessorPtr					= ^IADocAccessorRecord;
	{	
	    A Sherlock Plugin is a CFM shared library that implements the following functions:
		}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  IAPluginInit()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION IAPluginInit(initBlock: IAPluginInitBlockPtr; VAR outPluginRef: IAPluginRef): OSStatus; C;

{
 *  IAPluginTerm()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IAPluginTerm(inPluginRef: IAPluginRef): OSStatus; C;

{
 *  IAGetExtractorVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IAGetExtractorVersion(inPluginRef: IAPluginRef; VAR outPluginVersion: UInt32): OSStatus; C;

{
 *  IACountSupportedDocTypes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IACountSupportedDocTypes(inPluginRef: IAPluginRef; VAR outCount: UInt32): OSStatus; C;

{
 *  IAGetIndSupportedDocType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IAGetIndSupportedDocType(inPluginRef: IAPluginRef; inIndex: UInt32; VAR outMIMEType: CStringPtr): OSStatus; C;

{
 *  IAOpenDocument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IAOpenDocument(inPluginRef: IAPluginRef; VAR inDoc: IADocAccessorRecord; VAR outDoc: IADocRef): OSStatus; C;

{
 *  IACloseDocument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IACloseDocument(inDoc: IADocRef): OSStatus; C;

{
 *  IAGetNextTextRun()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IAGetNextTextRun(inDoc: IADocRef; buffer: UNIV Ptr; VAR ioSize: UInt32): OSStatus; C;

{
 *  IAGetTextRunInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IAGetTextRunInfo(inDoc: IADocRef; VAR outEncoding: CStringPtr; VAR outLanguage: CStringPtr): OSStatus; C;







{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := IAExtractorIncludes}

{$ENDC} {__IAEXTRACTOR__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
