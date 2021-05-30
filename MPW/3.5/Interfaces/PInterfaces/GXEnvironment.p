{
     File:       GXEnvironment.p
 
     Contains:   QuickDraw GX environment constants and interfaces
 
     Version:    Technology: Quickdraw GX 1.1
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT GXEnvironment;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __GXENVIRONMENT__}
{$SETC __GXENVIRONMENT__ := 1}

{$I+}
{$SETC GXEnvironmentIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __GXTYPES__}
{$I GXTypes.p}
{$ENDC}
{$IFC UNDEFINED __CMAPPLICATION__}
{$I CMApplication.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	defaultPollingHandlerFlags	= $00;
	okToSwitchDuringPollFlag	= $00;
	dontSwitchDuringPollFlag	= $01;


TYPE
	gxPollingHandlerFlags				= LONGINT;
{$IFC TYPED_FUNCTION_POINTERS}
	gxPollingHandlerProcPtr = PROCEDURE(reference: LONGINT; flags: gxPollingHandlerFlags); C;
{$ELSEC}
	gxPollingHandlerProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	gxPollingHandlerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	gxPollingHandlerUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppgxPollingHandlerProcInfo = $000003C1;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewgxPollingHandlerUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewgxPollingHandlerUPP(userRoutine: gxPollingHandlerProcPtr): gxPollingHandlerUPP; { old name was NewgxPollingHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposegxPollingHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposegxPollingHandlerUPP(userUPP: gxPollingHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokegxPollingHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokegxPollingHandlerUPP(reference: LONGINT; flags: gxPollingHandlerFlags; userRoutine: gxPollingHandlerUPP); { old name was CallgxPollingHandlerProc }
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  GXGetGraphicsPollingHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetGraphicsPollingHandler(VAR reference: LONGINT): gxPollingHandlerUPP; C;
{
 *  GXSetGraphicsPollingHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetGraphicsPollingHandler(handler: gxPollingHandlerUPP; reference: LONGINT); C;

{ QD to QD GX Translator typedefs }
{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	gxDefaultOptionsTranslation	= $0000;
	gxOptimizedTranslation		= $0001;
	gxReplaceLineWidthTranslation = $0002;
	gxSimpleScalingTranslation	= $0004;
	gxSimpleGeometryTranslation	= $0008;						{  implies simple scaling  }
	gxSimpleLinesTranslation	= $000C;						{  implies simple geometry & scaling  }
	gxLayoutTextTranslation		= $0010;						{  turn on gxLine layout (normally off)  }
	gxRasterTargetTranslation	= $0020;
	gxPostScriptTargetTranslation = $0040;
	gxVectorTargetTranslation	= $0080;
	gxPDDTargetTranslation		= $0100;
	gxDontConvertPatternsTranslation = $1000;
	gxDontSplitBitmapsTranslation = $2000;


TYPE
	gxTranslationOption					= LONGINT;

CONST
	gxContainsFormsBegin		= $0001;
	gxContainsFormsEnd			= $0002;
	gxContainsPostScript		= $0004;
	gxContainsEmptyPostScript	= $0008;


TYPE
	gxTranslationStatistic				= LONGINT;

CONST
	gxQuickDrawPictTag			= 'pict';


TYPE
	gxQuickDrawPictPtr = ^gxQuickDrawPict;
	gxQuickDrawPict = RECORD
																		{  translator inputs  }
		options:				gxTranslationOption;
		srcRect:				Rect;
		styleStretch:			Point;
																		{  size of quickdraw picture data  }
		dataLength:				UInt32;
																		{  file alias  }
		alias:					gxBitmapDataSourceAlias;
	END;

	{	 WindowRecord utilities 	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  GXNewWindowViewPort()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION GXNewWindowViewPort(qdWindow: WindowRef): gxViewPort; C;
{
 *  GXGetWindowViewPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetWindowViewPort(qdWindow: WindowRef): gxViewPort; C;
{
 *  GXGetViewPortWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewPortWindow(portOrder: gxViewPort): WindowRef; C;
{ GDevice utilities }
{
 *  GXGetViewDeviceGDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewDeviceGDevice(theDevice: gxViewDevice): GDHandle; C;
{
 *  GXGetGDeviceViewDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetGDeviceViewDevice(qdGDevice: GDHandle): gxViewDevice; C;
{ gxPoint utilities }
{
 *  GXConvertQDPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXConvertQDPoint({CONST}VAR shortPt: Point; portOrder: gxViewPort; VAR fixedPt: gxPoint); C;
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	gxShapeSpoolProcPtr = FUNCTION(toSpool: gxShape; refCon: LONGINT): OSErr; C;
{$ELSEC}
	gxShapeSpoolProcPtr = ProcPtr;
{$ENDC}

	{	 printing utilities typedef 	}
{$IFC TYPED_FUNCTION_POINTERS}
	gxUserViewPortFilterProcPtr = PROCEDURE(toFilter: gxShape; portOrder: gxViewPort; refCon: LONGINT); C;
{$ELSEC}
	gxUserViewPortFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	gxConvertQDFontProcPtr = FUNCTION(dst: gxStyle; txFont: LONGINT; txFace: LONGINT): LONGINT; C;
{$ELSEC}
	gxConvertQDFontProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	gxShapeSpoolUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	gxShapeSpoolUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	gxUserViewPortFilterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	gxUserViewPortFilterUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	gxConvertQDFontUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	gxConvertQDFontUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppgxShapeSpoolProcInfo = $000003E1;
	uppgxUserViewPortFilterProcInfo = $00000FC1;
	uppgxConvertQDFontProcInfo = $00000FF1;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewgxShapeSpoolUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewgxShapeSpoolUPP(userRoutine: gxShapeSpoolProcPtr): gxShapeSpoolUPP; { old name was NewgxShapeSpoolProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewgxUserViewPortFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewgxUserViewPortFilterUPP(userRoutine: gxUserViewPortFilterProcPtr): gxUserViewPortFilterUPP; { old name was NewgxUserViewPortFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewgxConvertQDFontUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewgxConvertQDFontUPP(userRoutine: gxConvertQDFontProcPtr): gxConvertQDFontUPP; { old name was NewgxConvertQDFontProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposegxShapeSpoolUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposegxShapeSpoolUPP(userUPP: gxShapeSpoolUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposegxUserViewPortFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposegxUserViewPortFilterUPP(userUPP: gxUserViewPortFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposegxConvertQDFontUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposegxConvertQDFontUPP(userUPP: gxConvertQDFontUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokegxShapeSpoolUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokegxShapeSpoolUPP(toSpool: gxShape; refCon: LONGINT; userRoutine: gxShapeSpoolUPP): OSErr; { old name was CallgxShapeSpoolProc }
{
 *  InvokegxUserViewPortFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokegxUserViewPortFilterUPP(toFilter: gxShape; portOrder: gxViewPort; refCon: LONGINT; userRoutine: gxUserViewPortFilterUPP); { old name was CallgxUserViewPortFilterProc }
{
 *  InvokegxConvertQDFontUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokegxConvertQDFontUPP(dst: gxStyle; txFont: LONGINT; txFace: LONGINT; userRoutine: gxConvertQDFontUPP): LONGINT; { old name was CallgxConvertQDFontProc }
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	gxShapeSpoolFunction				= gxShapeSpoolProcPtr;
	gxUserViewPortFilter				= gxUserViewPortFilterProcPtr;
	gxConvertQDFontFunction				= gxConvertQDFontProcPtr;
	{	 mouse utilities 	}
	{	 return mouse location in fixed-gxPoint global space 	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  GXGetGlobalMouse()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE GXGetGlobalMouse(VAR globalPt: gxPoint); C;
{ return fixed-gxPoint local mouse (gxViewPort == 0 --> default) }
{
 *  GXGetViewPortMouse()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXGetViewPortMouse(portOrder: gxViewPort; VAR localPt: gxPoint); C;
{ printing utilities }
{
 *  GXGetViewPortFilter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewPortFilter(portOrder: gxViewPort; VAR refCon: LONGINT): gxUserViewPortFilterUPP; C;
{
 *  GXSetViewPortFilter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetViewPortFilter(portOrder: gxViewPort; filter: gxUserViewPortFilterUPP; refCon: LONGINT); C;
{ QD to QD GX Translator functions }
{
 *  GXInstallQDTranslator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXInstallQDTranslator(port: GrafPtr; options: gxTranslationOption; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect; styleStrech: Point; userFunction: gxShapeSpoolUPP; reference: UNIV Ptr); C;
{
 *  GXRemoveQDTranslator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXRemoveQDTranslator(port: GrafPtr; VAR statistic: gxTranslationStatistic): gxTranslationStatistic; C;
{
 *  GXConvertPICTToShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXConvertPICTToShape(pict: PicHandle; options: gxTranslationOption; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect; styleStretch: Point; destination: gxShape; VAR stats: gxTranslationStatistic): gxShape; C;
{ Find the best GX style given a QD font and face. Called by the QD->GX translator }
{
 *  GXConvertQDFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXConvertQDFont(theStyle: gxStyle; txFont: LONGINT; txFace: LONGINT): LONGINT; C;
{
 *  GXGetConvertQDFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetConvertQDFont: gxConvertQDFontUPP; C;
{
 *  GXSetConvertQDFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetConvertQDFont(userFunction: gxConvertQDFontUPP); C;
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	gxProfilePoolAttributes				= UInt32;
	gxFlatProfileListItemPtr = ^gxFlatProfileListItem;
	gxFlatProfileListItem = RECORD
		attributes:				gxProfilePoolAttributes;				{  information about this particular profile's source }
		profileRef:				CMProfileRef;							{  reference to profile, only valid before shape is disposed }
		identifier:				CMProfileIdentifier;					{  information on how to find the profile upon unflattening }
	END;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := GXEnvironmentIncludes}

{$ENDC} {__GXENVIRONMENT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
