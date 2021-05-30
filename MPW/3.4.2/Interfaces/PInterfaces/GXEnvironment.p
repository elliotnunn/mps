{
 	File:		GXEnvironment.p
 
 	Contains:	QuickDraw GX environment constants and interfaces
 
 	Version:	Technology:	Quickdraw GX 1.1
 				Release:	Universal Interfaces 2.1.4
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
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
{$IFC UNDEFINED __WINDOWS__}
{$I Windows.p}
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
	gxPollingHandlerProcPtr = ProcPtr;  { PROCEDURE gxPollingHandler(reference: LONGINT; flags: gxPollingHandlerFlags); C; }

	gxPollingHandlerUPP = UniversalProcPtr;

CONST
	uppgxPollingHandlerProcInfo = $000003C1;

FUNCTION NewgxPollingHandlerProc(userRoutine: gxPollingHandlerProcPtr): gxPollingHandlerUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallgxPollingHandlerProc(reference: LONGINT; flags: gxPollingHandlerFlags; userRoutine: gxPollingHandlerUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}
FUNCTION GXGetGraphicsPollingHandler(VAR reference: LONGINT): gxPollingHandlerUPP; C;
PROCEDURE GXSetGraphicsPollingHandler(handler: gxPollingHandlerUPP; reference: LONGINT); C;
{  QD to QD GX Translator typedefs  }

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
		dataLength:				LONGINT;
																		{  file alias  }
		alias:					gxBitmapDataSourceAlias;
	END;

{  WindowRecord utilities  }
FUNCTION GXNewWindowViewPort(qdWindow: WindowRef): gxViewPort; C;
FUNCTION GXGetWindowViewPort(qdWindow: WindowRef): gxViewPort; C;
FUNCTION GXGetViewPortWindow(portOrder: gxViewPort): WindowRef; C;
{  GDevice utilities  }
FUNCTION GXGetViewDeviceGDevice(theDevice: gxViewDevice): GDHandle; C;
FUNCTION GXGetGDeviceViewDevice(qdGDevice: GDHandle): gxViewDevice; C;
{  gxPoint utilities  }
PROCEDURE GXConvertQDPoint({CONST}VAR shortPt: Point; portOrder: gxViewPort; VAR fixedPt: gxPoint); C;

TYPE
	gxShapeSpoolProcPtr = ProcPtr;  { FUNCTION gxShapeSpool(toSpool: gxShape; refCon: LONGINT): OSErr; C; }

{  printing utilities typedef  }
	gxUserViewPortFilterProcPtr = ProcPtr;  { PROCEDURE gxUserViewPortFilter(toFilter: gxShape; portOrder: gxViewPort; refCon: LONGINT); C; }

	gxConvertQDFontProcPtr = ProcPtr;  { FUNCTION gxConvertQDFont(dst: gxStyle; txFont: LONGINT; txFace: LONGINT): LONGINT; C; }

	gxShapeSpoolUPP = UniversalProcPtr;
	gxUserViewPortFilterUPP = UniversalProcPtr;
	gxConvertQDFontUPP = UniversalProcPtr;

CONST
	uppgxShapeSpoolProcInfo = $000003E1;
	uppgxUserViewPortFilterProcInfo = $00000FC1;
	uppgxConvertQDFontProcInfo = $00000FF1;

FUNCTION NewgxShapeSpoolProc(userRoutine: gxShapeSpoolProcPtr): gxShapeSpoolUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewgxUserViewPortFilterProc(userRoutine: gxUserViewPortFilterProcPtr): gxUserViewPortFilterUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewgxConvertQDFontProc(userRoutine: gxConvertQDFontProcPtr): gxConvertQDFontUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallgxShapeSpoolProc(toSpool: gxShape; refCon: LONGINT; userRoutine: gxShapeSpoolUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

PROCEDURE CallgxUserViewPortFilterProc(toFilter: gxShape; portOrder: gxViewPort; refCon: LONGINT; userRoutine: gxUserViewPortFilterUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

FUNCTION CallgxConvertQDFontProc(dst: gxStyle; txFont: LONGINT; txFace: LONGINT; userRoutine: gxConvertQDFontUPP): LONGINT;
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

TYPE
	gxShapeSpoolFunction				= gxShapeSpoolProcPtr;
	gxUserViewPortFilter				= gxUserViewPortFilterProcPtr;
	gxConvertQDFontFunction				= gxConvertQDFontProcPtr;
{  mouse utilities  }
{  return mouse location in fixed-gxPoint global space  }
PROCEDURE GXGetGlobalMouse(VAR globalPt: gxPoint); C;
{  return fixed-gxPoint local mouse (gxViewPort == 0 --> default)  }
PROCEDURE GXGetViewPortMouse(portOrder: gxViewPort; VAR localPt: gxPoint); C;
{  printing utilities  }
FUNCTION GXGetViewPortFilter(portOrder: gxViewPort; VAR refCon: LONGINT): gxUserViewPortFilterUPP; C;
PROCEDURE GXSetViewPortFilter(portOrder: gxViewPort; filter: gxUserViewPortFilterUPP; refCon: LONGINT); C;
{  QD to QD GX Translator functions  }
PROCEDURE GXInstallQDTranslator(port: GrafPtr; options: gxTranslationOption; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect; styleStrech: Point; userFunction: gxShapeSpoolUPP; reference: UNIV Ptr); C;
FUNCTION GXRemoveQDTranslator(port: GrafPtr; VAR statistic: gxTranslationStatistic): gxTranslationStatistic; C;
FUNCTION GXConvertPICTToShape(pict: PicHandle; options: gxTranslationOption; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect; styleStretch: Point; destination: gxShape; VAR stats: gxTranslationStatistic): gxShape; C;
{  Find the best GX style given a QD font and face. Called by the QD->GX translator  }
FUNCTION GXConvertQDFont(theStyle: gxStyle; txFont: LONGINT; txFace: LONGINT): LONGINT; C;
FUNCTION GXGetConvertQDFont: gxConvertQDFontUPP; C;
PROCEDURE GXSetConvertQDFont(userFunction: gxConvertQDFontUPP); C;
{  ColorSync 2.0 interface related routines  }
PROCEDURE GXSetColorProfileReference(profile: gxColorProfile; reference: CMProfileRef); C;
FUNCTION GXGetColorProfileReference(profile: gxColorProfile): CMProfileRef; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := GXEnvironmentIncludes}

{$ENDC} {__GXENVIRONMENT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
