{
     File:       AEObjects.p
 
     Contains:   Object Support Library Interfaces.
 
     Version:    Technology: System 8.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1991-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT AEObjects;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __AEOBJECTS__}
{$SETC __AEOBJECTS__ := 1}

{$I+}
{$SETC AEObjectsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}
{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{ *** LOGICAL OPERATOR CONSTANTS  *** }
	kAEAND						= 'AND ';						{   0x414e4420   }
	kAEOR						= 'OR  ';						{   0x4f522020   }
	kAENOT						= 'NOT ';						{   0x4e4f5420   }
																{ *** ABSOLUTE ORDINAL CONSTANTS  *** }
	kAEFirst					= 'firs';						{   0x66697273   }
	kAELast						= 'last';						{   0x6c617374   }
	kAEMiddle					= 'midd';						{   0x6d696464   }
	kAEAny						= 'any ';						{   0x616e7920   }
	kAEAll						= 'all ';						{   0x616c6c20   }
																{ *** RELATIVE ORDINAL CONSTANTS  *** }
	kAENext						= 'next';						{   0x6e657874   }
	kAEPrevious					= 'prev';						{   0x70726576   }
																{ *** KEYWORD CONSTANT    *** }
	keyAECompOperator			= 'relo';						{   0x72656c6f   }
	keyAELogicalTerms			= 'term';						{   0x7465726d   }
	keyAELogicalOperator		= 'logc';						{   0x6c6f6763   }
	keyAEObject1				= 'obj1';						{   0x6f626a31   }
	keyAEObject2				= 'obj2';						{   0x6f626a32   }
																{     ... for Keywords for getting fields out of object specifier records.  }
	keyAEDesiredClass			= 'want';						{   0x77616e74   }
	keyAEContainer				= 'from';						{   0x66726f6d   }
	keyAEKeyForm				= 'form';						{   0x666f726d   }
	keyAEKeyData				= 'seld';						{   0x73656c64   }

																{     ... for Keywords for getting fields out of Range specifier records.  }
	keyAERangeStart				= 'star';						{   0x73746172   }
	keyAERangeStop				= 'stop';						{   0x73746f70   }
																{     ... special handler selectors for OSL Callbacks.  }
	keyDisposeTokenProc			= 'xtok';						{   0x78746f6b   }
	keyAECompareProc			= 'cmpr';						{   0x636d7072   }
	keyAECountProc				= 'cont';						{   0x636f6e74   }
	keyAEMarkTokenProc			= 'mkid';						{   0x6d6b6964   }
	keyAEMarkProc				= 'mark';						{   0x6d61726b   }
	keyAEAdjustMarksProc		= 'adjm';						{   0x61646a6d   }
	keyAEGetErrDescProc			= 'indc';						{   0x696e6463   }

	{	***   VALUE and TYPE CONSTANTS    ***	}
																{     ... possible values for the keyAEKeyForm field of an object specifier.  }
	formAbsolutePosition		= 'indx';						{   0x696e6478   }
	formRelativePosition		= 'rele';						{   0x72656c65   }
	formTest					= 'test';						{   0x74657374   }
	formRange					= 'rang';						{   0x72616e67   }
	formPropertyID				= 'prop';						{   0x70726f70   }
	formName					= 'name';						{   0x6e616d65   }
																{     ... relevant types (some of these are often pared with forms above).  }
	typeObjectSpecifier			= 'obj ';						{   0x6f626a20   }
	typeObjectBeingExamined		= 'exmn';						{   0x65786d6e   }
	typeCurrentContainer		= 'ccnt';						{   0x63636e74   }
	typeToken					= 'toke';						{   0x746f6b65   }
	typeRelativeDescriptor		= 'rel ';						{   0x72656c20   }
	typeAbsoluteOrdinal			= 'abso';						{   0x6162736f   }
	typeIndexDescriptor			= 'inde';						{   0x696e6465   }
	typeRangeDescriptor			= 'rang';						{   0x72616e67   }
	typeLogicalDescriptor		= 'logi';						{   0x6c6f6769   }
	typeCompDescriptor			= 'cmpd';						{   0x636d7064   }
	typeOSLTokenList			= 'ostl';						{   0x6F73746C   }

	{	 Possible values for flags parameter to AEResolve.  They're additive 	}
	kAEIDoMinimum				= $0000;
	kAEIDoWhose					= $0001;
	kAEIDoMarking				= $0004;
	kAEPassSubDescs				= $0008;
	kAEResolveNestedLists		= $0010;
	kAEHandleSimpleRanges		= $0020;
	kAEUseRelativeIterators		= $0040;

	{	*** SPECIAL CONSTANTS FOR CUSTOM WHOSE-CLAUSE RESOLUTION 	}
	typeWhoseDescriptor			= 'whos';						{   0x77686f73   }
	formWhose					= 'whos';						{   0x77686f73   }
	typeWhoseRange				= 'wrng';						{   0x77726e67   }
	keyAEWhoseRangeStart		= 'wstr';						{   0x77737472   }
	keyAEWhoseRangeStop			= 'wstp';						{   0x77737470   }
	keyAEIndex					= 'kidx';						{   0x6b696478   }
	keyAETest					= 'ktst';						{   0x6b747374   }

	{	
	    used for rewriting tokens in place of 'ccnt' descriptors
	    This record is only of interest to those who, when they...
	    ...get ranges as key data in their accessor procs, choose
	    ...to resolve them manually rather than call AEResolve again.
		}

TYPE
	ccntTokenRecordPtr = ^ccntTokenRecord;
	ccntTokenRecord = RECORD
		tokenClass:				DescType;
		token:					AEDesc;
	END;

	ccntTokenRecPtr						= ^ccntTokenRecord;
	ccntTokenRecHandle					= ^ccntTokenRecPtr;
{$IFC OLDROUTINENAMES }
	DescPtr								= ^AEDesc;
	DescHandle							= ^DescPtr;
{$ENDC}  {OLDROUTINENAMES}

	{	 typedefs providing type checking for procedure pointers 	}
{$IFC TYPED_FUNCTION_POINTERS}
	OSLAccessorProcPtr = FUNCTION(desiredClass: DescType; {CONST}VAR container: AEDesc; containerClass: DescType; form: DescType; {CONST}VAR selectionData: AEDesc; VAR value: AEDesc; accessorRefcon: LONGINT): OSErr;
{$ELSEC}
	OSLAccessorProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	OSLCompareProcPtr = FUNCTION(oper: DescType; {CONST}VAR obj1: AEDesc; {CONST}VAR obj2: AEDesc; VAR result: BOOLEAN): OSErr;
{$ELSEC}
	OSLCompareProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	OSLCountProcPtr = FUNCTION(desiredType: DescType; containerClass: DescType; {CONST}VAR container: AEDesc; VAR result: LONGINT): OSErr;
{$ELSEC}
	OSLCountProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	OSLDisposeTokenProcPtr = FUNCTION(VAR unneededToken: AEDesc): OSErr;
{$ELSEC}
	OSLDisposeTokenProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	OSLGetMarkTokenProcPtr = FUNCTION({CONST}VAR dContainerToken: AEDesc; containerClass: DescType; VAR result: AEDesc): OSErr;
{$ELSEC}
	OSLGetMarkTokenProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	OSLGetErrDescProcPtr = FUNCTION(VAR appDescPtr: AEDescPtr): OSErr;
{$ELSEC}
	OSLGetErrDescProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	OSLMarkProcPtr = FUNCTION({CONST}VAR dToken: AEDesc; {CONST}VAR markToken: AEDesc; index: LONGINT): OSErr;
{$ELSEC}
	OSLMarkProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	OSLAdjustMarksProcPtr = FUNCTION(newStart: LONGINT; newStop: LONGINT; {CONST}VAR markToken: AEDesc): OSErr;
{$ELSEC}
	OSLAdjustMarksProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	OSLAccessorUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	OSLAccessorUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	OSLCompareUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	OSLCompareUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	OSLCountUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	OSLCountUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	OSLDisposeTokenUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	OSLDisposeTokenUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	OSLGetMarkTokenUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	OSLGetMarkTokenUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	OSLGetErrDescUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	OSLGetErrDescUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	OSLMarkUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	OSLMarkUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	OSLAdjustMarksUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	OSLAdjustMarksUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppOSLAccessorProcInfo = $000FFFE0;
	uppOSLCompareProcInfo = $00003FE0;
	uppOSLCountProcInfo = $00003FE0;
	uppOSLDisposeTokenProcInfo = $000000E0;
	uppOSLGetMarkTokenProcInfo = $00000FE0;
	uppOSLGetErrDescProcInfo = $000000E0;
	uppOSLMarkProcInfo = $00000FE0;
	uppOSLAdjustMarksProcInfo = $00000FE0;
	{
	 *  NewOSLAccessorUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewOSLAccessorUPP(userRoutine: OSLAccessorProcPtr): OSLAccessorUPP; { old name was NewOSLAccessorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewOSLCompareUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewOSLCompareUPP(userRoutine: OSLCompareProcPtr): OSLCompareUPP; { old name was NewOSLCompareProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewOSLCountUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewOSLCountUPP(userRoutine: OSLCountProcPtr): OSLCountUPP; { old name was NewOSLCountProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewOSLDisposeTokenUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewOSLDisposeTokenUPP(userRoutine: OSLDisposeTokenProcPtr): OSLDisposeTokenUPP; { old name was NewOSLDisposeTokenProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewOSLGetMarkTokenUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewOSLGetMarkTokenUPP(userRoutine: OSLGetMarkTokenProcPtr): OSLGetMarkTokenUPP; { old name was NewOSLGetMarkTokenProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewOSLGetErrDescUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewOSLGetErrDescUPP(userRoutine: OSLGetErrDescProcPtr): OSLGetErrDescUPP; { old name was NewOSLGetErrDescProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewOSLMarkUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewOSLMarkUPP(userRoutine: OSLMarkProcPtr): OSLMarkUPP; { old name was NewOSLMarkProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewOSLAdjustMarksUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewOSLAdjustMarksUPP(userRoutine: OSLAdjustMarksProcPtr): OSLAdjustMarksUPP; { old name was NewOSLAdjustMarksProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeOSLAccessorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeOSLAccessorUPP(userUPP: OSLAccessorUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeOSLCompareUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeOSLCompareUPP(userUPP: OSLCompareUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeOSLCountUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeOSLCountUPP(userUPP: OSLCountUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeOSLDisposeTokenUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeOSLDisposeTokenUPP(userUPP: OSLDisposeTokenUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeOSLGetMarkTokenUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeOSLGetMarkTokenUPP(userUPP: OSLGetMarkTokenUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeOSLGetErrDescUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeOSLGetErrDescUPP(userUPP: OSLGetErrDescUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeOSLMarkUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeOSLMarkUPP(userUPP: OSLMarkUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeOSLAdjustMarksUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeOSLAdjustMarksUPP(userUPP: OSLAdjustMarksUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeOSLAccessorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeOSLAccessorUPP(desiredClass: DescType; {CONST}VAR container: AEDesc; containerClass: DescType; form: DescType; {CONST}VAR selectionData: AEDesc; VAR value: AEDesc; accessorRefcon: LONGINT; userRoutine: OSLAccessorUPP): OSErr; { old name was CallOSLAccessorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeOSLCompareUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeOSLCompareUPP(oper: DescType; {CONST}VAR obj1: AEDesc; {CONST}VAR obj2: AEDesc; VAR result: BOOLEAN; userRoutine: OSLCompareUPP): OSErr; { old name was CallOSLCompareProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeOSLCountUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeOSLCountUPP(desiredType: DescType; containerClass: DescType; {CONST}VAR container: AEDesc; VAR result: LONGINT; userRoutine: OSLCountUPP): OSErr; { old name was CallOSLCountProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeOSLDisposeTokenUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeOSLDisposeTokenUPP(VAR unneededToken: AEDesc; userRoutine: OSLDisposeTokenUPP): OSErr; { old name was CallOSLDisposeTokenProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeOSLGetMarkTokenUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeOSLGetMarkTokenUPP({CONST}VAR dContainerToken: AEDesc; containerClass: DescType; VAR result: AEDesc; userRoutine: OSLGetMarkTokenUPP): OSErr; { old name was CallOSLGetMarkTokenProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeOSLGetErrDescUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeOSLGetErrDescUPP(VAR appDescPtr: AEDescPtr; userRoutine: OSLGetErrDescUPP): OSErr; { old name was CallOSLGetErrDescProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeOSLMarkUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeOSLMarkUPP({CONST}VAR dToken: AEDesc; {CONST}VAR markToken: AEDesc; index: LONGINT; userRoutine: OSLMarkUPP): OSErr; { old name was CallOSLMarkProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeOSLAdjustMarksUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeOSLAdjustMarksUPP(newStart: LONGINT; newStop: LONGINT; {CONST}VAR markToken: AEDesc; userRoutine: OSLAdjustMarksUPP): OSErr; { old name was CallOSLAdjustMarksProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}




{
 *  AEObjectInit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEObjectInit: OSErr;

{ Not done by inline, but by direct linking into code.  It sets up the pack
  such that further calls can be via inline }
{
 *  AESetObjectCallbacks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AESetObjectCallbacks(myCompareProc: OSLCompareUPP; myCountProc: OSLCountUPP; myDisposeTokenProc: OSLDisposeTokenUPP; myGetMarkTokenProc: OSLGetMarkTokenUPP; myMarkProc: OSLMarkUPP; myAdjustMarksProc: OSLAdjustMarksUPP; myGetErrDescProcPtr: OSLGetErrDescUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0E35, $A816;
	{$ENDC}

{
 *  AEResolve()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEResolve({CONST}VAR objectSpecifier: AEDesc; callbackFlags: INTEGER; VAR theToken: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0536, $A816;
	{$ENDC}

{
 *  AEInstallObjectAccessor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEInstallObjectAccessor(desiredClass: DescType; containerType: DescType; theAccessor: OSLAccessorUPP; accessorRefcon: LONGINT; isSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0937, $A816;
	{$ENDC}

{
 *  AERemoveObjectAccessor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AERemoveObjectAccessor(desiredClass: DescType; containerType: DescType; theAccessor: OSLAccessorUPP; isSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0738, $A816;
	{$ENDC}

{
 *  AEGetObjectAccessor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEGetObjectAccessor(desiredClass: DescType; containerType: DescType; VAR accessor: OSLAccessorUPP; VAR accessorRefcon: LONGINT; isSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0939, $A816;
	{$ENDC}

{
 *  AEDisposeToken()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEDisposeToken(VAR theToken: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $023A, $A816;
	{$ENDC}

{
 *  AECallObjectAccessor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AECallObjectAccessor(desiredClass: DescType; {CONST}VAR containerToken: AEDesc; containerClass: DescType; keyForm: DescType; {CONST}VAR keyData: AEDesc; VAR token: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0C3B, $A816;
	{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AEObjectsIncludes}

{$ENDC} {__AEOBJECTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
