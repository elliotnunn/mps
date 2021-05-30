{
 	File:		Resources.p
 
 	Contains:	Resource Manager Interfaces.
 
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
 UNIT Resources;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __RESOURCES__}
{$SETC __RESOURCES__ := 1}

{$I+}
{$SETC ResourcesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}

{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{	OSUtils.p													}
{		Memory.p												}
{	Finder.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	resSysHeap					= 64;							{System or application heap?}
	resPurgeable				= 32;							{Purgeable resource?}
	resLocked					= 16;							{Load it in locked?}
	resProtected				= 8;							{Protected?}
	resPreload					= 4;							{Load in on OpenResFile?}
	resChanged					= 2;							{Resource changed?}
	mapReadOnly					= 128;							{Resource file read-only}
	mapCompact					= 64;							{Compact resource file}
	mapChanged					= 32;							{Write map out at update}
	resSysRefBit				= 7;							{reference to system/local reference}
	resSysHeapBit				= 6;							{In system/in application heap}
	resPurgeableBit				= 5;							{Purgeable/not purgeable}
	resLockedBit				= 4;							{Locked/not locked}
	resProtectedBit				= 3;							{Protected/not protected}
	resPreloadBit				= 2;							{Read in at OpenResource?}
	resChangedBit				= 1;							{Existing resource changed since last update}
	mapReadOnlyBit				= 7;							{is this file read-only?}
	mapCompactBit				= 6;							{Is a compact necessary?}
	mapChangedBit				= 5;							{Is it necessary to write map?}
	kResFileNotOpened			= -1;							{ref num return as error when opening a resource file}
	kSystemResFile				= 0;							{this is the default ref num to the system file}

TYPE
	{
		ResErrProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => thErr       	D0.W
	}
	ResErrProcPtr = Register68kProcPtr;  { register PROCEDURE ResErr(thErr: OSErr); }
	ResErrUPP = UniversalProcPtr;

CONST
	uppResErrProcInfo = $00001002; { Register PROCEDURE (2 bytes in D0); }

FUNCTION NewResErrProc(userRoutine: ResErrProcPtr): ResErrUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallResErrProc(thErr: OSErr; userRoutine: ResErrUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

FUNCTION InitResources: INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A995;
	{$ENDC}
PROCEDURE RsrcZoneInit;
	{$IFC NOT GENERATINGCFM}
	INLINE $A996;
	{$ENDC}

PROCEDURE CloseResFile(refNum: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A99A;
	{$ENDC}
FUNCTION ResError: INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9AF;
	{$ENDC}
FUNCTION CurResFile: INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A994;
	{$ENDC}
FUNCTION HomeResFile(theResource: Handle): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9A4;
	{$ENDC}
PROCEDURE CreateResFile(fileName: ConstStr255Param);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9B1;
	{$ENDC}
FUNCTION OpenResFile(fileName: ConstStr255Param): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A997;
	{$ENDC}
PROCEDURE UseResFile(refNum: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A998;
	{$ENDC}
FUNCTION CountTypes: INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A99E;
	{$ENDC}
FUNCTION Count1Types: INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A81C;
	{$ENDC}
PROCEDURE GetIndType(VAR theType: ResType; index: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A99F;
	{$ENDC}
PROCEDURE Get1IndType(VAR theType: ResType; index: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A80F;
	{$ENDC}
PROCEDURE SetResLoad(load: BOOLEAN);
	{$IFC NOT GENERATINGCFM}
	INLINE $A99B;
	{$ENDC}
FUNCTION CountResources(theType: ResType): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A99C;
	{$ENDC}
FUNCTION Count1Resources(theType: ResType): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A80D;
	{$ENDC}
FUNCTION GetIndResource(theType: ResType; index: INTEGER): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A99D;
	{$ENDC}
FUNCTION Get1IndResource(theType: ResType; index: INTEGER): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A80E;
	{$ENDC}
FUNCTION GetResource(theType: ResType; theID: INTEGER): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9A0;
	{$ENDC}
FUNCTION Get1Resource(theType: ResType; theID: INTEGER): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A81F;
	{$ENDC}
FUNCTION GetNamedResource(theType: ResType; name: ConstStr255Param): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9A1;
	{$ENDC}
FUNCTION Get1NamedResource(theType: ResType; name: ConstStr255Param): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A820;
	{$ENDC}
PROCEDURE LoadResource(theResource: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9A2;
	{$ENDC}
PROCEDURE ReleaseResource(theResource: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9A3;
	{$ENDC}
PROCEDURE DetachResource(theResource: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A992;
	{$ENDC}
FUNCTION UniqueID(theType: ResType): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9C1;
	{$ENDC}
FUNCTION Unique1ID(theType: ResType): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A810;
	{$ENDC}
FUNCTION GetResAttrs(theResource: Handle): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9A6;
	{$ENDC}
PROCEDURE GetResInfo(theResource: Handle; VAR theID: INTEGER; VAR theType: ResType; VAR name: Str255);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9A8;
	{$ENDC}
PROCEDURE SetResInfo(theResource: Handle; theID: INTEGER; name: ConstStr255Param);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9A9;
	{$ENDC}
PROCEDURE AddResource(theData: Handle; theType: ResType; theID: INTEGER; name: ConstStr255Param);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9AB;
	{$ENDC}
FUNCTION GetResourceSizeOnDisk(theResource: Handle): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9A5;
	{$ENDC}
FUNCTION GetMaxResourceSize(theResource: Handle): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A821;
	{$ENDC}
FUNCTION RsrcMapEntry(theResource: Handle): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9C5;
	{$ENDC}
PROCEDURE SetResAttrs(theResource: Handle; attrs: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9A7;
	{$ENDC}
PROCEDURE ChangedResource(theResource: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9AA;
	{$ENDC}
PROCEDURE RemoveResource(theResource: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9AD;
	{$ENDC}
PROCEDURE UpdateResFile(refNum: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A999;
	{$ENDC}
PROCEDURE WriteResource(theResource: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9B0;
	{$ENDC}
PROCEDURE SetResPurge(install: BOOLEAN);
	{$IFC NOT GENERATINGCFM}
	INLINE $A993;
	{$ENDC}
FUNCTION GetResFileAttrs(refNum: INTEGER): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9F6;
	{$ENDC}
PROCEDURE SetResFileAttrs(refNum: INTEGER; attrs: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9F7;
	{$ENDC}
FUNCTION OpenRFPerm(fileName: ConstStr255Param; vRefNum: INTEGER; permission: ByteParameter): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9C4;
	{$ENDC}
FUNCTION RGetResource(theType: ResType; theID: INTEGER): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A80C;
	{$ENDC}
{$IFC SystemSevenOrLater }
FUNCTION HOpenResFile(vRefNum: INTEGER; dirID: LONGINT; fileName: ConstStr255Param; permission: ByteParameter): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A81A;
	{$ENDC}
{$ELSEC}
FUNCTION HOpenResFile(vRefNum: INTEGER; dirID: LONGINT; fileName: ConstStr255Param; permission: ByteParameter): INTEGER;
{$ENDC}
{$IFC SystemSevenOrLater }
PROCEDURE HCreateResFile(vRefNum: INTEGER; dirID: LONGINT; fileName: ConstStr255Param);
	{$IFC NOT GENERATINGCFM}
	INLINE $A81B;
	{$ENDC}
{$ELSEC}
PROCEDURE HCreateResFile(vRefNum: INTEGER; dirID: LONGINT; fileName: ConstStr255Param);
{$ENDC}
FUNCTION FSpOpenResFile({CONST}VAR spec: FSSpec; permission: ByteParameter): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $700D, $AA52;
	{$ENDC}
PROCEDURE FSpCreateResFile({CONST}VAR spec: FSSpec; creator: OSType; fileType: OSType; scriptTag: ScriptCode);
	{$IFC NOT GENERATINGCFM}
	INLINE $700E, $AA52;
	{$ENDC}
{  partial resource calls  }
PROCEDURE ReadPartialResource(theResource: Handle; offset: LONGINT; buffer: UNIV Ptr; count: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $7001, $A822;
	{$ENDC}
PROCEDURE WritePartialResource(theResource: Handle; offset: LONGINT; buffer: UNIV Ptr; count: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $7002, $A822;
	{$ENDC}
PROCEDURE SetResourceSize(theResource: Handle; newSize: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $7003, $A822;
	{$ENDC}
FUNCTION GetNextFOND(fondHandle: Handle): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $700A, $A822;
	{$ENDC}
{ Use TempInsertROMMap to force the ROM resource map to be
   inserted into the chain in front of the system. Note that
   this call is only temporary - the modified resource chain
   is only used for the next call to the resource manager.
   See IM IV 19 for more information. }
PROCEDURE TempInsertROMMap(tempResLoad: BOOLEAN);
{$IFC OLDROUTINENAMES }
FUNCTION SizeResource(theResource: Handle): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9A5;
	{$ENDC}
FUNCTION MaxSizeRsrc(theResource: Handle): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A821;
	{$ENDC}
PROCEDURE RmveResource(theResource: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9AD;
	{$ENDC}
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ResourcesIncludes}

{$ENDC} {__RESOURCES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
