{
Created: Monday, August 21, 1989 at 4:36 PM
	QDOffscreen.p
	Pascal Interface to the Macintosh Libraries

	Copyright Apple Computer, Inc.	1985-1989
	All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT QDOffscreen;
	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingQDOffscreen}
{$SETC UsingQDOffscreen := 1}

{$I+}
{$SETC QDOffscreenIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingQuickdraw}
{$I $$Shell(PInterfaces)Quickdraw.p}
{$ENDC}
{$SETC UsingIncludes := QDOffscreenIncludes}

CONST

{ New error codes }

cDepthErr = -157;	{invalid pixel depth}


TYPE

GWorldFlags = SET OF (pixPurge,noNewDevice,GWorldFlags2,GWorldFlags3,GWorldFlags4,
	GWorldFlags5,pixelsPurgeable,pixelsLocked,GWorldFlags8,GWorldFlags9,GWorldFlags10,
	GWorldFlags11,GWorldFlags12,GWorldFlags13,GWorldFlags14,GWorldFlags15,
	mapPix,newDepth,alignPix,newRowBytes,reallocPix,GWorldFlags21,GWorldFlags22,
	GWorldFlags23,GWorldFlags24,GWorldFlags25,GWorldFlags26,GWorldFlags27,
	clipPix,stretchPix,ditherPix,gwFlagErr);


GWorldPtr = CGrafPtr;



FUNCTION NewGWorld(VAR offscreenGWorld: GWorldPtr;PixelDepth: INTEGER;boundsRect: Rect;
	cTable: CTabHandle;aGDevice: GDHandle;flags: GWorldFlags): QDErr;
	INLINE $7000,$AB1D;
FUNCTION LockPixels(pm: PixMapHandle): BOOLEAN;
	INLINE $7001,$AB1D;
PROCEDURE UnlockPixels(pm: PixMapHandle);
	INLINE $7002,$AB1D;
FUNCTION UpdateGWorld(VAR offscreenGWorld: GWorldPtr;pixelDepth: INTEGER;
	boundsRect: Rect;cTable: CTabHandle;aGDevice: GDHandle;flags: GWorldFlags): GWorldFlags;
	INLINE $7003,$AB1D;
PROCEDURE DisposeGWorld(offscreenGWorld: GWorldPtr);
	INLINE $7004,$AB1D;
PROCEDURE GetGWorld(VAR port: CGrafPtr;VAR gdh: GDHandle);
	INLINE $7005,$AB1D;
PROCEDURE SetGWorld(port: CGrafPtr;gdh: GDHandle);
	INLINE $7006,$AB1D;
PROCEDURE CTabChanged(ctab: CTabHandle);
	INLINE $7007,$AB1D;
PROCEDURE PixPatChanged(ppat: PixPatHandle);
	INLINE $7008,$AB1D;
PROCEDURE PortChanged(port: GrafPtr);
	INLINE $7009,$AB1D;
PROCEDURE GDeviceChanged(gdh: GDHandle);
	INLINE $700A,$AB1D;
PROCEDURE AllowPurgePixels(pm: PixMapHandle);
	INLINE $700B,$AB1D;
PROCEDURE NoPurgePixels(pm: PixMapHandle);
	INLINE $700C,$AB1D;
FUNCTION GetPixelsState(pm: PixMapHandle): GWorldFlags;
	INLINE $700D,$AB1D;
PROCEDURE SetPixelsState(pm: PixMapHandle;state: GWorldFlags);
	INLINE $700E,$AB1D;
FUNCTION GetPixBaseAddr(pm: PixMapHandle): Ptr;
	INLINE $700F,$AB1D;
FUNCTION NewScreenBuffer(globalRect: Rect;purgeable: BOOLEAN;VAR gdh: GDHandle;
	VAR offscreenPixMap: PixMapHandle): QDErr;
	INLINE $7010,$AB1D;
PROCEDURE DisposeScreenBuffer(offscreenPixMap: PixMapHandle);
	INLINE $7011,$AB1D;
FUNCTION GetGWorldDevice(offscreenGWorld: GWorldPtr): GDHandle;
	INLINE $7012,$AB1D;

{$ENDC}    { UsingQDOffscreen }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}

