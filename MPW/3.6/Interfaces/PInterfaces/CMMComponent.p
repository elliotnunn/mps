{
     File:       CMMComponent.p
 
     Contains:   ColorSync CMM Component API
 
     Version:    Technology: ColorSync 2.6
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
 UNIT CMMComponent;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CMMCOMPONENT__}
{$SETC __CMMCOMPONENT__ := 1}

{$I+}
{$SETC CMMComponentIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CMAPPLICATION__}
{$I CMApplication.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Component-based CMM interface version }

CONST
	CMMInterfaceVersion			= 1;


	{	 Component-based CMM function selectors 	}
																{  Required  }
	kCMMOpen					= -1;							{  kComponentOpenSelect, }
	kCMMClose					= -2;							{  kComponentCloseSelect, }
	kCMMGetInfo					= -4;							{  kComponentVersionSelect }
	kNCMMInit					= 6;
	kCMMMatchColors				= 1;
	kCMMCheckColors				= 2;							{  }
																{  }
																{  Optional  }
	kCMMValidateProfile			= 8;
	kCMMMatchBitmap				= 9;
	kCMMCheckBitmap				= 10;
	kCMMConcatenateProfiles		= 5;
	kCMMConcatInit				= 7;
	kCMMNewLinkProfile			= 16;
	kNCMMConcatInit				= 18;
	kNCMMNewLinkProfile			= 19;
	kCMMGetPS2ColorSpace		= 11;
	kCMMGetPS2ColorRenderingIntent = 12;
	kCMMGetPS2ColorRendering	= 13;
	kCMMGetPS2ColorRenderingVMSize = 17;						{  }
																{  }
																{  obsolete with ColorSync 2.5  }
	kCMMFlattenProfile			= 14;
	kCMMUnflattenProfile		= 15;							{  }
																{  }
																{  obsolete with ColorSync 2.6  }
	kCMMInit					= 0;
	kCMMGetNamedColorInfo		= 70;
	kCMMGetNamedColorValue		= 71;
	kCMMGetIndNamedColorValue	= 72;
	kCMMGetNamedColorIndex		= 73;
	kCMMGetNamedColorName		= 74;							{  }
																{  }
																{  obsolete with ColorSync 3.0  }
	kCMMMatchPixMap				= 3;
	kCMMCheckPixMap				= 4;


{$IFC TARGET_API_MAC_OS8 }

TYPE
	CMMComponentInst					= ComponentInstance;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NCMMInit()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NCMMInit(cmm: CMMComponentInst; srcProfile: CMProfileRef; dstProfile: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0006, $7000, $A82A;
	{$ENDC}

{
 *  CMMInit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMInit(cmm: CMMComponentInst; srcProfile: CMProfileHandle; dstProfile: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0000, $7000, $A82A;
	{$ENDC}

{
 *  CMMMatchColors()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMMatchColors(cmm: CMMComponentInst; VAR colors: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0001, $7000, $A82A;
	{$ENDC}

{
 *  CMMCheckColors()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMCheckColors(cmm: CMMComponentInst; VAR colors: CMColor; count: UInt32; VAR result: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0002, $7000, $A82A;
	{$ENDC}

{
 *  CMMValidateProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMValidateProfile(cmm: CMMComponentInst; prof: CMProfileRef; VAR valid: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0008, $7000, $A82A;
	{$ENDC}

{
 *  CMMFlattenProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMFlattenProfile(cmm: CMMComponentInst; prof: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $000E, $7000, $A82A;
	{$ENDC}

{
 *  CMMUnflattenProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMUnflattenProfile(cmm: CMMComponentInst; VAR resultFileSpec: FSSpec; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000F, $7000, $A82A;
	{$ENDC}

{
 *  CMMMatchBitmap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMMatchBitmap(cmm: CMMComponentInst; VAR bitmap: CMBitmap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr; VAR matchedBitmap: CMBitmap): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0009, $7000, $A82A;
	{$ENDC}

{
 *  CMMCheckBitmap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMCheckBitmap(cmm: CMMComponentInst; {CONST}VAR bitmap: CMBitmap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr; VAR resultBitmap: CMBitmap): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $000A, $7000, $A82A;
	{$ENDC}

{
 *  CMMMatchPixMap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMMatchPixMap(cmm: CMMComponentInst; VAR pixMap: PixMap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0003, $7000, $A82A;
	{$ENDC}

{
 *  CMMCheckPixMap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMCheckPixMap(cmm: CMMComponentInst; {CONST}VAR pixMap: PixMap; progressProc: CMBitmapCallBackUPP; VAR bitMap: BitMap; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0004, $7000, $A82A;
	{$ENDC}

{
 *  CMMConcatInit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMConcatInit(cmm: CMMComponentInst; VAR profileSet: CMConcatProfileSet): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}

{
 *  NCMMConcatInit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NCMMConcatInit(cmm: CMMComponentInst; VAR profileSet: NCMConcatProfileSet; proc: CMConcatCallBackUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0012, $7000, $A82A;
	{$ENDC}

{
 *  CMMNewLinkProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMNewLinkProfile(cmm: CMMComponentInst; VAR prof: CMProfileRef; {CONST}VAR targetLocation: CMProfileLocation; VAR profileSet: CMConcatProfileSet): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0010, $7000, $A82A;
	{$ENDC}

{
 *  NCMMNewLinkProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NCMMNewLinkProfile(cmm: CMMComponentInst; prof: CMProfileRef; VAR profileSet: NCMConcatProfileSet; proc: CMConcatCallBackUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0013, $7000, $A82A;
	{$ENDC}

{
 *  CMMGetPS2ColorSpace()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMGetPS2ColorSpace(cmm: CMMComponentInst; srcProf: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $000B, $7000, $A82A;
	{$ENDC}

{
 *  CMMGetPS2ColorRenderingIntent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMGetPS2ColorRenderingIntent(cmm: CMMComponentInst; srcProf: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $000C, $7000, $A82A;
	{$ENDC}

{
 *  CMMGetPS2ColorRendering()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMGetPS2ColorRendering(cmm: CMMComponentInst; srcProf: CMProfileRef; dstProf: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $000D, $7000, $A82A;
	{$ENDC}

{
 *  CMMGetPS2ColorRenderingVMSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMGetPS2ColorRenderingVMSize(cmm: CMMComponentInst; srcProf: CMProfileRef; dstProf: CMProfileRef; VAR vmSize: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0011, $7000, $A82A;
	{$ENDC}

{
 *  CMMConcatenateProfiles()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMConcatenateProfiles(cmm: CMMComponentInst; thru: CMProfileHandle; dst: CMProfileHandle; VAR newDst: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0005, $7000, $A82A;
	{$ENDC}

{
 *  CMMGetNamedColorInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMGetNamedColorInfo(cmm: CMMComponentInst; srcProf: CMProfileRef; VAR deviceChannels: UInt32; VAR deviceColorSpace: OSType; VAR PCSColorSpace: OSType; VAR count: UInt32; prefix: StringPtr; suffix: StringPtr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $001C, $0046, $7000, $A82A;
	{$ENDC}

{
 *  CMMGetNamedColorValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMGetNamedColorValue(cmm: CMMComponentInst; prof: CMProfileRef; name: StringPtr; VAR deviceColor: CMColor; VAR PCSColor: CMColor): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0047, $7000, $A82A;
	{$ENDC}

{
 *  CMMGetIndNamedColorValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMGetIndNamedColorValue(cmm: CMMComponentInst; prof: CMProfileRef; index: UInt32; VAR deviceColor: CMColor; VAR PCSColor: CMColor): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0048, $7000, $A82A;
	{$ENDC}

{
 *  CMMGetNamedColorIndex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMGetNamedColorIndex(cmm: CMMComponentInst; prof: CMProfileRef; name: StringPtr; VAR index: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0049, $7000, $A82A;
	{$ENDC}

{
 *  CMMGetNamedColorName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMGetNamedColorName(cmm: CMMComponentInst; prof: CMProfileRef; index: UInt32; name: StringPtr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $004A, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_API_MAC_OS8}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMMComponentIncludes}

{$ENDC} {__CMMCOMPONENT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
