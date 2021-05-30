{
 	File:		CMConversions.p
 
 	Contains:	ColorSync base <-> derived color space conversion Component interface
 
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
 UNIT CMConversions;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CMCONVERSIONS__}
{$SETC __CMCONVERSIONS__ := 1}

{$I+}
{$SETC CMConversionsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{	MixedMode.p													}

{$IFC UNDEFINED __CMAPPLICATION__}
{$I CMApplication.p}
{$ENDC}
{	Quickdraw.p													}
{		QuickdrawText.p											}
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
	CMConversionInterfaceVersion = 1;

{ Component function selectors }
	kCMXYZToLab					= 0;
	kCMLabToXYZ					= 1;
	kCMXYZToLuv					= 2;
	kCMLuvToXYZ					= 3;
	kCMXYZToYxy					= 4;
	kCMYxyToXYZ					= 5;
	kCMRGBToHLS					= 6;
	kCMHLSToRGB					= 7;
	kCMRGBToHSV					= 8;
	kCMHSVToRGB					= 9;
	kCMRGBToGRAY				= 10;
	kCMXYZToFixedXYZ			= 11;
	kCMFixedXYZToXYZ			= 12;


FUNCTION CMXYZToLab(ci: ComponentInstance; {CONST}VAR src: CMColor; {CONST}VAR white: CMXYZColor; VAR dst: CMColor; count: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 16, 0, $7000, $A82A;
	{$ENDC}
FUNCTION CMLabToXYZ(ci: ComponentInstance; {CONST}VAR src: CMColor; {CONST}VAR white: CMXYZColor; VAR dst: CMColor; count: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 16, 1, $7000, $A82A;
	{$ENDC}
FUNCTION CMXYZToLuv(ci: ComponentInstance; {CONST}VAR src: CMColor; {CONST}VAR white: CMXYZColor; VAR dst: CMColor; count: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 16, 2, $7000, $A82A;
	{$ENDC}
FUNCTION CMLuvToXYZ(ci: ComponentInstance; {CONST}VAR src: CMColor; {CONST}VAR white: CMXYZColor; VAR dst: CMColor; count: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 16, 3, $7000, $A82A;
	{$ENDC}
FUNCTION CMXYZToYxy(ci: ComponentInstance; {CONST}VAR src: CMColor; VAR dst: CMColor; count: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 12, 4, $7000, $A82A;
	{$ENDC}
FUNCTION CMYxyToXYZ(ci: ComponentInstance; {CONST}VAR src: CMColor; VAR dst: CMColor; count: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 12, 5, $7000, $A82A;
	{$ENDC}
FUNCTION CMRGBToHLS(ci: ComponentInstance; {CONST}VAR src: CMColor; VAR dst: CMColor; count: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 12, 6, $7000, $A82A;
	{$ENDC}
FUNCTION CMHLSToRGB(ci: ComponentInstance; {CONST}VAR src: CMColor; VAR dst: CMColor; count: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 12, 7, $7000, $A82A;
	{$ENDC}
FUNCTION CMRGBToHSV(ci: ComponentInstance; {CONST}VAR src: CMColor; VAR dst: CMColor; count: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 12, 8, $7000, $A82A;
	{$ENDC}
FUNCTION CMHSVToRGB(ci: ComponentInstance; {CONST}VAR src: CMColor; VAR dst: CMColor; count: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 12, 9, $7000, $A82A;
	{$ENDC}
FUNCTION CMRGBToGray(ci: ComponentInstance; {CONST}VAR src: CMColor; VAR dst: CMColor; count: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 12, 10, $7000, $A82A;
	{$ENDC}
FUNCTION CMXYZToFixedXYZ(ci: ComponentInstance; {CONST}VAR src: CMXYZColor; VAR dst: CMFixedXYZColor; count: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 12, 11, $7000, $A82A;
	{$ENDC}
FUNCTION CMFixedXYZToXYZ(ci: ComponentInstance; {CONST}VAR src: CMFixedXYZColor; VAR dst: CMXYZColor; count: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 12, 12, $7000, $A82A;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMConversionsIncludes}

{$ENDC} {__CMCONVERSIONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
