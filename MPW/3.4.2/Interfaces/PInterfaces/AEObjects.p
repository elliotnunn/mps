{
 	File:		AEObjects.p
 
 	Contains:	AppleEvents Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
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
 UNIT AEObjects;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __AEOBJECTS__}
{$SETC __AEOBJECTS__ := 1}

{$I+}
{$SETC AEObjectsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __MEMORY__}
{$I Memory.p}
{$ENDC}
{	Types.p														}
{		ConditionalMacros.p										}
{	MixedMode.p													}

{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}

{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{	QuickdrawText.p												}

{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}

{$IFC UNDEFINED __EPPC__}
{$I EPPC.p}
{$ENDC}
{	Errors.p													}
{	AppleTalk.p													}
{	Files.p														}
{		Finder.p												}
{	PPCToolbox.p												}
{	Processes.p													}

{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{	Notification.p												}

{$IFC UNDEFINED __ERRORS__}
{$I Errors.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	kAEAND						= 'AND ';						{  0x414e4420  }
	kAEOR						= 'OR  ';						{  0x4f522020  }
	kAENOT						= 'NOT ';						{  0x4e4f5420  }
{***	ABSOLUTE ORDINAL CONSTANTS	***}
	kAEFirst					= 'firs';						{  0x66697273  }
	kAELast						= 'last';						{  0x6c617374  }
	kAEMiddle					= 'midd';						{  0x6d696464  }
	kAEAny						= 'any ';						{  0x616e7920  }
	kAEAll						= 'all ';						{  0x616c6c20  }
{***	RELATIVE ORDINAL CONSTANTS	***}
	kAENext						= 'next';						{  0x6e657874  }
	kAEPrevious					= 'prev';						{  0x70726576  }
{***	KEYWORD CONSTANT 	***}
	keyAECompOperator			= 'relo';						{  0x72656c6f  }
	keyAELogicalTerms			= 'term';						{  0x7465726d  }
	keyAELogicalOperator		= 'logc';						{  0x6c6f6763  }
	keyAEObject1				= 'obj1';						{  0x6f626a31  }
	keyAEObject2				= 'obj2';						{  0x6f626a32  }
{	... for Keywords for getting fields out of object specifier records. }
	keyAEDesiredClass			= 'want';						{  0x77616e74  }
	keyAEContainer				= 'from';						{  0x66726f6d  }
	keyAEKeyForm				= 'form';						{  0x666f726d  }
	keyAEKeyData				= 'seld';

{	... for Keywords for getting fields out of Range specifier records. }
	keyAERangeStart				= 'star';						{  0x73746172  }
	keyAERangeStop				= 'stop';						{  0x73746f70  }
{	... special handler selectors for OSL Callbacks. }
	keyDisposeTokenProc			= 'xtok';						{  0x78746f6b  }
	keyAECompareProc			= 'cmpr';						{  0x636d7072  }
	keyAECountProc				= 'cont';						{  0x636f6e74  }
	keyAEMarkTokenProc			= 'mkid';						{  0x6d6b6964  }
	keyAEMarkProc				= 'mark';						{  0x6d61726b  }
	keyAEAdjustMarksProc		= 'adjm';						{  0x61646a6d  }
	keyAEGetErrDescProc			= 'indc';

{***	VALUE and TYPE CONSTANTS	***}
{	... possible values for the keyAEKeyForm field of an object specifier. }
	formAbsolutePosition		= 'indx';						{  0x696e6478  }
	formRelativePosition		= 'rele';						{  0x72656c65  }
	formTest					= 'test';						{  0x74657374  }
	formRange					= 'rang';						{  0x72616e67  }
	formPropertyID				= 'prop';						{  0x70726f70  }
	formName					= 'name';						{  0x6e616d65  }
{	... relevant types (some of these are often pared with forms above). }
	typeObjectSpecifier			= 'obj ';						{  0x6f626a20  }
	typeObjectBeingExamined		= 'exmn';						{  0x65786d6e  }
	typeCurrentContainer		= 'ccnt';						{  0x63636e74  }
	typeToken					= 'toke';						{  0x746f6b65  }
	typeRelativeDescriptor		= 'rel ';						{  0x72656c20  }
	typeAbsoluteOrdinal			= 'abso';						{  0x6162736f  }
	typeIndexDescriptor			= 'inde';						{  0x696e6465  }
	typeRangeDescriptor			= 'rang';						{  0x72616e67  }
	typeLogicalDescriptor		= 'logi';						{  0x6c6f6769  }
	typeCompDescriptor			= 'cmpd';						{  0x636d7064  }
	typeOSLTokenList			= 'ostl';

{ Possible values for flags parameter to AEResolve.  They're additive }
	kAEIDoMinimum				= $0000;
	kAEIDoWhose					= $0001;
	kAEIDoMarking				= $0004;
	kAEPassSubDescs				= $0008;
	kAEResolveNestedLists		= $0010;
	kAEHandleSimpleRanges		= $0020;
	kAEUseRelativeIterators		= $0040;

{*** SPECIAL CONSTANTS FOR CUSTOM WHOSE-CLAUSE RESOLUTION }
	typeWhoseDescriptor			= 'whos';						{  0x77686f73  }
	formWhose					= 'whos';						{  0x77686f73  }
	typeWhoseRange				= 'wrng';						{  0x77726e67  }
	keyAEWhoseRangeStart		= 'wstr';						{  0x77737472  }
	keyAEWhoseRangeStop			= 'wstp';						{  0x77737470  }
	keyAEIndex					= 'kidx';						{  0x6b696478  }
	keyAETest					= 'ktst';

{*
	used for rewriting tokens in place of 'ccnt' descriptors
	This record is only of interest to those who, when they...
	...get ranges as key data in their accessor procs, choose
	...to resolve them manually rather than call AEResolve again.
*}

TYPE
	ccntTokenRecord = RECORD
		tokenClass:				DescType;
		token:					AEDesc;
	END;

	ccntTokenRecPtr = ^ccntTokenRecord;
	ccntTokenRecHandle = ^ccntTokenRecPtr;

{$IFC OLDROUTINENAMES }
	DescPtr = ^AEDesc;
	DescHandle = ^DescPtr;

{$ENDC}
	OSLAccessorProcPtr = ProcPtr;  { FUNCTION OSLAccessor(desiredClass: DescType; (CONST)VAR container: AEDesc; containerClass: DescType; form: DescType; (CONST)VAR selectionData: AEDesc; VAR value: AEDesc; accessorRefcon: LONGINT): OSErr; }
	OSLCompareProcPtr = ProcPtr;  { FUNCTION OSLCompare(oper: DescType; (CONST)VAR obj1: AEDesc; (CONST)VAR obj2: AEDesc; VAR result: BOOLEAN): OSErr; }
	OSLCountProcPtr = ProcPtr;  { FUNCTION OSLCount(desiredType: DescType; containerClass: DescType; (CONST)VAR container: AEDesc; VAR result: LONGINT): OSErr; }
	OSLDisposeTokenProcPtr = ProcPtr;  { FUNCTION OSLDisposeToken(VAR unneededToken: AEDesc): OSErr; }
	OSLGetMarkTokenProcPtr = ProcPtr;  { FUNCTION OSLGetMarkToken((CONST)VAR dContainerToken: AEDesc; containerClass: DescType; VAR result: AEDesc): OSErr; }
	OSLGetErrDescProcPtr = ProcPtr;  { FUNCTION OSLGetErrDesc(VAR appDescPtr: AEDesc): OSErr; }
	OSLMarkProcPtr = ProcPtr;  { FUNCTION OSLMark((CONST)VAR dToken: AEDesc; (CONST)VAR markToken: AEDesc; index: LONGINT): OSErr; }
	OSLAdjustMarksProcPtr = ProcPtr;  { FUNCTION OSLAdjustMarks(newStart: LONGINT; newStop: LONGINT; (CONST)VAR markToken: AEDesc): OSErr; }
	OSLAccessorUPP = UniversalProcPtr;
	OSLCompareUPP = UniversalProcPtr;
	OSLCountUPP = UniversalProcPtr;
	OSLDisposeTokenUPP = UniversalProcPtr;
	OSLGetMarkTokenUPP = UniversalProcPtr;
	OSLGetErrDescUPP = UniversalProcPtr;
	OSLMarkUPP = UniversalProcPtr;
	OSLAdjustMarksUPP = UniversalProcPtr;

CONST
	uppOSLAccessorProcInfo = $000FFFE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }
	uppOSLCompareProcInfo = $00003FE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }
	uppOSLCountProcInfo = $00003FE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }
	uppOSLDisposeTokenProcInfo = $000000E0; { FUNCTION (4 byte param): 2 byte result; }
	uppOSLGetMarkTokenProcInfo = $00000FE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }
	uppOSLGetErrDescProcInfo = $000000E0; { FUNCTION (4 byte param): 2 byte result; }
	uppOSLMarkProcInfo = $00000FE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }
	uppOSLAdjustMarksProcInfo = $00000FE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewOSLAccessorProc(userRoutine: OSLAccessorProcPtr): OSLAccessorUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewOSLCompareProc(userRoutine: OSLCompareProcPtr): OSLCompareUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewOSLCountProc(userRoutine: OSLCountProcPtr): OSLCountUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewOSLDisposeTokenProc(userRoutine: OSLDisposeTokenProcPtr): OSLDisposeTokenUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewOSLGetMarkTokenProc(userRoutine: OSLGetMarkTokenProcPtr): OSLGetMarkTokenUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewOSLGetErrDescProc(userRoutine: OSLGetErrDescProcPtr): OSLGetErrDescUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewOSLMarkProc(userRoutine: OSLMarkProcPtr): OSLMarkUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewOSLAdjustMarksProc(userRoutine: OSLAdjustMarksProcPtr): OSLAdjustMarksUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallOSLAccessorProc(desiredClass: DescType; {CONST}VAR container: AEDesc; containerClass: DescType; form: DescType; {CONST}VAR selectionData: AEDesc; VAR value: AEDesc; accessorRefcon: LONGINT; userRoutine: OSLAccessorUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallOSLCompareProc(oper: DescType; {CONST}VAR obj1: AEDesc; {CONST}VAR obj2: AEDesc; VAR result: BOOLEAN; userRoutine: OSLCompareUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallOSLCountProc(desiredType: DescType; containerClass: DescType; {CONST}VAR container: AEDesc; VAR result: LONGINT; userRoutine: OSLCountUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallOSLDisposeTokenProc(VAR unneededToken: AEDesc; userRoutine: OSLDisposeTokenUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallOSLGetMarkTokenProc({CONST}VAR dContainerToken: AEDesc; containerClass: DescType; VAR result: AEDesc; userRoutine: OSLGetMarkTokenUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallOSLGetErrDescProc(VAR appDescPtr: AEDesc; userRoutine: OSLGetErrDescUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallOSLMarkProc({CONST}VAR dToken: AEDesc; {CONST}VAR markToken: AEDesc; index: LONGINT; userRoutine: OSLMarkUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallOSLAdjustMarksProc(newStart: LONGINT; newStop: LONGINT; {CONST}VAR markToken: AEDesc; userRoutine: OSLAdjustMarksUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION AEObjectInit: OSErr;
{ Not done by inline, but by direct linking into code.  It sets up the pack
  such that further calls can be via inline }
FUNCTION AESetObjectCallbacks(myCompareProc: OSLCompareUPP; myCountProc: OSLCountUPP; myDisposeTokenProc: OSLDisposeTokenUPP; myGetMarkTokenProc: OSLGetMarkTokenUPP; myMarkProc: OSLMarkUPP; myAdjustMarksProc: OSLAdjustMarksUPP; myGetErrDescProcPtr: OSLGetErrDescUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0E35, $A816;
	{$ENDC}
FUNCTION AEResolve({CONST}VAR objectSpecifier: AEDesc; callbackFlags: INTEGER; VAR theToken: AEDesc): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0536, $A816;
	{$ENDC}
FUNCTION AEInstallObjectAccessor(desiredClass: DescType; containerType: DescType; theAccessor: OSLAccessorUPP; accessorRefcon: LONGINT; isSysHandler: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0937, $A816;
	{$ENDC}
FUNCTION AERemoveObjectAccessor(desiredClass: DescType; containerType: DescType; theAccessor: OSLAccessorUPP; isSysHandler: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0738, $A816;
	{$ENDC}
FUNCTION AEGetObjectAccessor(desiredClass: DescType; containerType: DescType; VAR accessor: OSLAccessorUPP; VAR accessorRefcon: LONGINT; isSysHandler: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0939, $A816;
	{$ENDC}
FUNCTION AEDisposeToken(VAR theToken: AEDesc): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $023A, $A816;
	{$ENDC}
FUNCTION AECallObjectAccessor(desiredClass: DescType; {CONST}VAR containerToken: AEDesc; containerClass: DescType; keyForm: DescType; {CONST}VAR keyData: AEDesc; VAR token: AEDesc): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0C3B, $A816;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AEObjectsIncludes}

{$ENDC} {__AEOBJECTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
