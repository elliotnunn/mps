{
 	File:		QDOffscreen.p
 
 	Contains:	QuickDraw Offscreen GWorld Interfaces.
 
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
 UNIT QDOffscreen;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QDOFFSCREEN__}
{$SETC __QDOFFSCREEN__ := 1}

{$I+}
{$SETC QDOffscreenIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __ERRORS__}
{$I Errors.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{	Types.p														}
{	MixedMode.p													}
{	QuickdrawText.p												}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	pixPurgeBit					= 0;
	noNewDeviceBit				= 1;
	useTempMemBit				= 2;
	keepLocalBit				= 3;
	pixelsPurgeableBit			= 6;
	pixelsLockedBit				= 7;
	mapPixBit					= 16;
	newDepthBit					= 17;
	alignPixBit					= 18;
	newRowBytesBit				= 19;
	reallocPixBit				= 20;
	clipPixBit					= 28;
	stretchPixBit				= 29;
	ditherPixBit				= 30;
	gwFlagErrBit				= 31;

	pixPurge					= 1 * (2**(pixPurgeBit));
	noNewDevice					= 1 * (2**(noNewDeviceBit));
	useTempMem					= 1 * (2**(useTempMemBit));
	keepLocal					= 1 * (2**(keepLocalBit));
	pixelsPurgeable				= 1 * (2**(pixelsPurgeableBit));
	pixelsLocked				= 1 * (2**(pixelsLockedBit));
	mapPix						= 1 * (2**(mapPixBit));
	newDepth					= 1 * (2**(newDepthBit));
	alignPix					= 1 * (2**(alignPixBit));
	newRowBytes					= 1 * (2**(newRowBytesBit));
	reallocPix					= 1 * (2**(reallocPixBit));
	clipPix						= 1 * (2**(clipPixBit));
	stretchPix					= 1 * (2**(stretchPixBit));
	ditherPix					= 1 * (2**(ditherPixBit));
	gwFlagErr					= 1 * (2**(gwFlagErrBit));

	
TYPE
	GWorldFlags = LONGINT;

{ Type definition of a GWorldPtr }
	GWorldPtr = CGrafPtr;


FUNCTION NewGWorld(VAR offscreenGWorld: GWorldPtr; PixelDepth: INTEGER; {CONST}VAR boundsRect: Rect; cTable: CTabHandle; aGDevice: GDHandle; flags: GWorldFlags): QDErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0016, $0000, $AB1D;
	{$ENDC}
FUNCTION LockPixels(pm: PixMapHandle): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0001, $AB1D;
	{$ENDC}
PROCEDURE UnlockPixels(pm: PixMapHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0002, $AB1D;
	{$ENDC}
FUNCTION UpdateGWorld(VAR offscreenGWorld: GWorldPtr; pixelDepth: INTEGER; {CONST}VAR boundsRect: Rect; cTable: CTabHandle; aGDevice: GDHandle; flags: GWorldFlags): GWorldFlags;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0016, $0003, $AB1D;
	{$ENDC}
PROCEDURE DisposeGWorld(offscreenGWorld: GWorldPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0004, $AB1D;
	{$ENDC}
PROCEDURE GetGWorld(VAR port: CGrafPtr; VAR gdh: GDHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $0005, $AB1D;
	{$ENDC}
PROCEDURE SetGWorld(port: CGrafPtr; gdh: GDHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $0006, $AB1D;
	{$ENDC}
PROCEDURE CTabChanged(ctab: CTabHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0007, $AB1D;
	{$ENDC}
PROCEDURE PixPatChanged(ppat: PixPatHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0008, $AB1D;
	{$ENDC}
PROCEDURE PortChanged(port: GrafPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0009, $AB1D;
	{$ENDC}
PROCEDURE GDeviceChanged(gdh: GDHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $000A, $AB1D;
	{$ENDC}
PROCEDURE AllowPurgePixels(pm: PixMapHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $000B, $AB1D;
	{$ENDC}
PROCEDURE NoPurgePixels(pm: PixMapHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $000C, $AB1D;
	{$ENDC}
FUNCTION GetPixelsState(pm: PixMapHandle): GWorldFlags;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $000D, $AB1D;
	{$ENDC}
PROCEDURE SetPixelsState(pm: PixMapHandle; state: GWorldFlags);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $000E, $AB1D;
	{$ENDC}
FUNCTION GetPixBaseAddr(pm: PixMapHandle): Ptr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $000F, $AB1D;
	{$ENDC}
FUNCTION NewScreenBuffer({CONST}VAR globalRect: Rect; purgeable: BOOLEAN; VAR gdh: GDHandle; VAR offscreenPixMap: PixMapHandle): QDErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000E, $0010, $AB1D;
	{$ENDC}
PROCEDURE DisposeScreenBuffer(offscreenPixMap: PixMapHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0011, $AB1D;
	{$ENDC}
FUNCTION GetGWorldDevice(offscreenGWorld: GWorldPtr): GDHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0012, $AB1D;
	{$ENDC}
FUNCTION QDDone(port: GrafPtr): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0013, $AB1D;
	{$ENDC}
FUNCTION OffscreenVersion: LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $7014, $AB1D;
	{$ENDC}
FUNCTION NewTempScreenBuffer({CONST}VAR globalRect: Rect; purgeable: BOOLEAN; VAR gdh: GDHandle; VAR offscreenPixMap: PixMapHandle): QDErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000E, $0015, $AB1D;
	{$ENDC}
FUNCTION PixMap32Bit(pmHandle: PixMapHandle): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0016, $AB1D;
	{$ENDC}
FUNCTION GetGWorldPixMap(offscreenGWorld: GWorldPtr): PixMapHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0017, $AB1D;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QDOffscreenIncludes}

{$ENDC} {__QDOFFSCREEN__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
