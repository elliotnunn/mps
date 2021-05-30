{
     File:       QDOffscreen.p
 
     Contains:   Quickdraw Offscreen GWorld Interfaces.
 
     Version:    Technology: Mac OS 8
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
    NOTE:   GWorldFlags is no longer defined as a SET.  Instead it is a LONGINT
            and the set elements are bit masks.  You will need to use Bit-OR's 
            to build a set and Bit-AND's to test sets.
}

CONST
	pixPurgeBit					= 0;
	noNewDeviceBit				= 1;
	useTempMemBit				= 2;
	keepLocalBit				= 3;
	useDistantHdwrMemBit		= 4;
	useLocalHdwrMemBit			= 5;
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

	pixPurge					= $00000001;
	noNewDevice					= $00000002;
	useTempMem					= $00000004;
	keepLocal					= $00000008;
	useDistantHdwrMem			= $00000010;
	useLocalHdwrMem				= $00000020;
	pixelsPurgeable				= $00000040;
	pixelsLocked				= $00000080;
	kAllocDirectDrawSurface		= $00004000;
	mapPix						= $00010000;
	newDepth					= $00020000;
	alignPix					= $00040000;
	newRowBytes					= $00080000;
	reallocPix					= $00100000;
	clipPix						= $10000000;
	stretchPix					= $20000000;
	ditherPix					= $40000000;
	gwFlagErr					= $80000000;


TYPE
	GWorldFlags							= UInt32;
	{	 Type definition of a GWorldPtr 	}
	GWorldPtr							= CGrafPtr;
	{
	 *  NewGWorld()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewGWorld(VAR offscreenGWorld: GWorldPtr; PixelDepth: INTEGER; {CONST}VAR boundsRect: Rect; cTable: CTabHandle; aGDevice: GDHandle; flags: GWorldFlags): QDErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0016, $0000, $AB1D;
	{$ENDC}

{  GDevice attribute bits for Carbon and QuickTime 3.0 }

CONST
	deviceIsIndirect			= $00000001;
	deviceNeedsLock				= $00000002;
	deviceIsStatic				= $00000004;
	deviceIsExternalBuffer		= $00000008;
	deviceIsDDSurface			= $00000010;
	deviceIsDCISurface			= $00000020;
	deviceIsGDISurface			= $00000040;
	deviceIsAScreen				= $00000080;
	deviceIsOverlaySurface		= $00000100;

{$IFC TARGET_OS_WIN32 }
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  GetGDeviceSurface()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION GetGDeviceSurface(gdh: GDHandle): Ptr;

{
 *  GetGDeviceAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetGDeviceAttributes(gdh: GDHandle): UInt32;

{ to allocate non-mac-rgb GWorlds use QTNewGWorld (ImageCompression.h) }
{
 *  NewGWorldFromHBITMAP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewGWorldFromHBITMAP(VAR offscreenGWorld: GWorldPtr; cTable: CTabHandle; aGDevice: GDHandle; flags: GWorldFlags; newHBITMAP: UNIV Ptr; newHDC: UNIV Ptr): QDErr;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_OS_WIN32}

{
 *  NewGWorldFromPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewGWorldFromPtr(VAR offscreenGWorld: GWorldPtr; PixelFormat: UInt32; {CONST}VAR boundsRect: Rect; cTable: CTabHandle; aGDevice: GDHandle; flags: GWorldFlags; newBuffer: Ptr; rowBytes: LONGINT): QDErr;

{
 *  LockPixels()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LockPixels(pm: PixMapHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0001, $AB1D;
	{$ENDC}

{
 *  UnlockPixels()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE UnlockPixels(pm: PixMapHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0002, $AB1D;
	{$ENDC}

{
 *  UpdateGWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UpdateGWorld(VAR offscreenGWorld: GWorldPtr; pixelDepth: INTEGER; {CONST}VAR boundsRect: Rect; cTable: CTabHandle; aGDevice: GDHandle; flags: GWorldFlags): GWorldFlags;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0016, $0003, $AB1D;
	{$ENDC}

{
 *  DisposeGWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeGWorld(offscreenGWorld: GWorldPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0004, $AB1D;
	{$ENDC}

{
 *  GetGWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetGWorld(VAR port: CGrafPtr; VAR gdh: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0005, $AB1D;
	{$ENDC}

{
 *  SetGWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetGWorld(port: CGrafPtr; gdh: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0006, $AB1D;
	{$ENDC}

{
 *  CTabChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CTabChanged(ctab: CTabHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0007, $AB1D;
	{$ENDC}

{
 *  PixPatChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PixPatChanged(ppat: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0008, $AB1D;
	{$ENDC}

{
 *  PortChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PortChanged(port: GrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0009, $AB1D;
	{$ENDC}

{
 *  GDeviceChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GDeviceChanged(gdh: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $000A, $AB1D;
	{$ENDC}

{
 *  AllowPurgePixels()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE AllowPurgePixels(pm: PixMapHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $000B, $AB1D;
	{$ENDC}

{
 *  NoPurgePixels()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE NoPurgePixels(pm: PixMapHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $000C, $AB1D;
	{$ENDC}

{
 *  GetPixelsState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPixelsState(pm: PixMapHandle): GWorldFlags;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $000D, $AB1D;
	{$ENDC}

{
 *  SetPixelsState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetPixelsState(pm: PixMapHandle; state: GWorldFlags);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $000E, $AB1D;
	{$ENDC}

{
 *  GetPixBaseAddr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPixBaseAddr(pm: PixMapHandle): Ptr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $000F, $AB1D;
	{$ENDC}

{
 *  GetPixRowBytes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPixRowBytes(pm: PixMapHandle): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0018, $AB1D;
	{$ENDC}

{
 *  NewScreenBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewScreenBuffer({CONST}VAR globalRect: Rect; purgeable: BOOLEAN; VAR gdh: GDHandle; VAR offscreenPixMap: PixMapHandle): QDErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000E, $0010, $AB1D;
	{$ENDC}

{
 *  DisposeScreenBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeScreenBuffer(offscreenPixMap: PixMapHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0011, $AB1D;
	{$ENDC}

{
 *  GetGWorldDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetGWorldDevice(offscreenGWorld: GWorldPtr): GDHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0012, $AB1D;
	{$ENDC}

{
 *  QDDone()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QDDone(port: GrafPtr): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0013, $AB1D;
	{$ENDC}

{
 *  OffscreenVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OffscreenVersion: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7014, $AB1D;
	{$ENDC}

{
 *  NewTempScreenBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewTempScreenBuffer({CONST}VAR globalRect: Rect; purgeable: BOOLEAN; VAR gdh: GDHandle; VAR offscreenPixMap: PixMapHandle): QDErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000E, $0015, $AB1D;
	{$ENDC}

{
 *  PixMap32Bit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PixMap32Bit(pmHandle: PixMapHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0016, $AB1D;
	{$ENDC}

{
 *  GetGWorldPixMap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetGWorldPixMap(offscreenGWorld: GWorldPtr): PixMapHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0017, $AB1D;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QDOffscreenIncludes}

{$ENDC} {__QDOFFSCREEN__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
