{
 	File:		CMMComponent.p
 
 	Contains:	ColorSync CMM Components
 
 	Version:	Technology:	ColorSync 2.0
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
 UNIT CMMComponent;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CMMCOMPONENT__}
{$SETC __CMMCOMPONENT__ := 1}

{$I+}
{$SETC CMMComponentIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{	MixedMode.p													}
{	QuickdrawText.p												}

{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}

{$IFC UNDEFINED __CMAPPLICATION__}
{$I CMApplication.p}
{$ENDC}
{	Files.p														}
{		OSUtils.p												}
{			Memory.p											}
{		Finder.p												}
{	Printing.p													}
{		Errors.p												}
{		Dialogs.p												}
{			Menus.p												}
{			Controls.p											}
{			Windows.p											}
{				Events.p										}
{			TextEdit.p											}
{	CMICCProfile.p												}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	CMMInterfaceVersion			= 1;

{ Component function selectors }
{ Required }
	kCMMInit					= 0;
	kNCMMInit					= 6;
	kCMMMatchColors				= 1;
	kCMMCheckColors				= 2;

{ Optional }
	kCMMValidateProfile			= 8;
	kCMMFlattenProfile			= 14;
	kCMMUnflattenProfile		= 15;
	kCMMMatchBitmap				= 9;
	kCMMCheckBitmap				= 10;
	kCMMMatchPixMap				= 3;
	kCMMCheckPixMap				= 4;
	kCMMConcatenateProfiles		= 5;
	kCMMConcatInit				= 7;
	kCMMNewLinkProfile			= 16;
	kCMMGetPS2ColorSpace		= 11;
	kCMMGetPS2ColorRenderingIntent = 12;
	kCMMGetPS2ColorRendering	= 13;
	kCMMGetPS2ColorRenderingVMSize = 17;


FUNCTION NCMInit(CMSession: ComponentInstance; srcProfile: CMProfileRef; dstProfile: CMProfileRef): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 8, 6, $7000, $A82A;
	{$ENDC}
FUNCTION CMInit(CMSession: ComponentInstance; srcProfile: CMProfileHandle; dstProfile: CMProfileHandle): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 8, 0, $7000, $A82A;
	{$ENDC}
FUNCTION CMMatchColors(CMSession: ComponentInstance; VAR myColors: CMColor; count: LONGINT): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 8, 1, $7000, $A82A;
	{$ENDC}
FUNCTION CMCheckColors(CMSession: ComponentInstance; VAR myColors: CMColor; count: LONGINT; VAR result: LONGINT): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 12, 2, $7000, $A82A;
	{$ENDC}
{ Optional functions }
FUNCTION CMMValidateProfile(CMSession: ComponentInstance; prof: CMProfileRef; VAR valid: BOOLEAN): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 8, 8, $7000, $A82A;
	{$ENDC}
FUNCTION CMMFlattenProfile(CMSession: ComponentInstance; prof: CMProfileRef; flags: LONGINT; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 16, 14, $7000, $A82A;
	{$ENDC}
FUNCTION CMMUnflattenProfile(CMSession: ComponentInstance; VAR resultFileSpec: FSSpec; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 12, 15, $7000, $A82A;
	{$ENDC}
FUNCTION CMMatchBitmap(CMSession: ComponentInstance; {CONST}VAR bitmap: CMBitmap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr; VAR matchedBitmap: CMBitmap): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 16, 9, $7000, $A82A;
	{$ENDC}
FUNCTION CMCheckBitmap(CMSession: ComponentInstance; {CONST}VAR bitmap: CMBitmap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr; VAR resultBitmap: CMBitmap): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 16, 10, $7000, $A82A;
	{$ENDC}
FUNCTION CMMatchPixMap(CMSession: ComponentInstance; VAR myPixMap: PixMap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 12, 3, $7000, $A82A;
	{$ENDC}
FUNCTION CMCheckPixMap(CMSession: ComponentInstance; {CONST}VAR myPixMap: PixMap; progressProc: CMBitmapCallBackUPP; VAR myBitMap: BitMap; refCon: UNIV Ptr): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 16, 4, $7000, $A82A;
	{$ENDC}
FUNCTION CMConcatInit(CMSession: ComponentInstance; VAR profileSet: CMConcatProfileSet): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 4, 7, $7000, $A82A;
	{$ENDC}
FUNCTION CMNewLinkProfile(CMSession: ComponentInstance; VAR prof: CMProfileRef; {CONST}VAR targetLocation: CMProfileLocation; VAR profileSet: CMConcatProfileSet): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 12, 16, $7000, $A82A;
	{$ENDC}
FUNCTION CMMGetPS2ColorSpace(CMSession: ComponentInstance; srcProf: CMProfileRef; flags: LONGINT; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 16, 11, $7000, $A82A;
	{$ENDC}
FUNCTION CMMGetPS2ColorRenderingIntent(CMSession: ComponentInstance; srcProf: CMProfileRef; flags: LONGINT; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 16, 12, $7000, $A82A;
	{$ENDC}
FUNCTION CMMGetPS2ColorRendering(CMSession: ComponentInstance; srcProf: CMProfileRef; dstProf: CMProfileRef; flags: LONGINT; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 20, 13, $7000, $A82A;
	{$ENDC}
FUNCTION CMMGetPS2ColorRenderingVMSize(CMSession: ComponentInstance; srcProf: CMProfileRef; dstProf: CMProfileRef; VAR vmSize: LONGINT): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 12, 17, $7000, $A82A;
	{$ENDC}
FUNCTION CMConcatenateProfiles(CMSession: ComponentInstance; thru: CMProfileHandle; dst: CMProfileHandle; VAR newDst: CMProfileHandle): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 12, 5, $7000, $A82A;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMMComponentIncludes}

{$ENDC} {__CMMCOMPONENT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
