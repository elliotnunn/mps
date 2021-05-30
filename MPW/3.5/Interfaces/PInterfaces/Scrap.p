{
     File:       Scrap.p
 
     Contains:   Scrap Manager Interfaces.
 
     Version:    Technology: Mac OS 9
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
 UNIT Scrap;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SCRAP__}
{$SETC __SCRAP__ := 1}

{$I+}
{$SETC ScrapIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
    ________________________________________________________________
    UNIVERSAL SCRAP MANAGER INTERFACES
    ________________________________________________________________
    The following interfaces are available when compiling for BOTH
    Carbon AND Mac OS 8.
    ________________________________________________________________
}
{
    While were in here mucking about, we defined a new type to
    to put some confusion to rest. The old calls, as well as the
    new calls, use the new type. Existing clients should be
    blissfully ignorant.
}


TYPE
	ScrapFlavorType						= FourCharCode;
	{
	    Newsflash! After 15 years of arduous toil, it's finally possible
	    for specially trained typists wielding advanced text editing
	    technology to define symbolic names for commonly used scrap
	    flavor type constants! Apple triumphs again!
	}

CONST
	kScrapFlavorTypePicture		= 'PICT';						{  contents of a PicHandle }
	kScrapFlavorTypeText		= 'TEXT';						{  stream of characters }
	kScrapFlavorTypeTextStyle	= 'styl';						{  see TEGetStyleScrapHandle }
	kScrapFlavorTypeMovie		= 'moov';						{  reference to a movie }
	kScrapFlavorTypeSound		= 'snd ';						{  see SndRecord and SndPlay }
	kScrapFlavorTypeUnicode		= 'utxt';						{  stream of UTF16 characters }
	kScrapFlavorTypeUnicodeStyle = 'ustl';						{  ATSUI defines; Textension uses }

	{
	    If you are a Carbon client and you need to run on Mac OS 8,
	    you may still need to load and unload the scrap. Under Mac OS
	    X, the scrap is held by the pasteboard server instead of in a
	    handle in your app's heap, so LoadScrap and UnloadScrap do
	    nothing when called under Mac OS X.
	}

	{
	 *  LoadScrap()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION LoadScrap: OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9FB;
	{$ENDC}

{
 *  UnloadScrap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UnloadScrap: OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9FA;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
    ________________________________________________________________
    MAC OS 8 SCRAP MANAGER INTERFACES
    ________________________________________________________________
    The following interfaces are available only when compiling for
    plain vanilla Mac OS 8. We didn't add comments to them because
    Inside Mac covers them in detail.
    ________________________________________________________________
}

TYPE
	ScrapStuffPtr = ^ScrapStuff;
	ScrapStuff = RECORD
		scrapSize:				SInt32;
		scrapHandle:			Handle;
		scrapCount:				SInt16;
		scrapState:				SInt16;
		scrapName:				StringPtr;
	END;

	PScrapStuff							= ^ScrapStuff;
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  InfoScrap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InfoScrap: ScrapStuffPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9F9;
	{$ENDC}

{
 *  GetScrap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetScrap(destination: Handle; flavorType: ScrapFlavorType; VAR offset: SInt32): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9FD;
	{$ENDC}

{
 *  ZeroScrap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ZeroScrap: OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9FC;
	{$ENDC}

{
 *  PutScrap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PutScrap(sourceBufferByteCount: SInt32; flavorType: ScrapFlavorType; sourceBuffer: UNIV Ptr): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9FE;
	{$ENDC}


{
    ________________________________________________________________
    CARBON SCRAP MANAGER INTERFACES
    ________________________________________________________________
    The following interfaces are available only when compiling for
    Carbon.
    ________________________________________________________________
}

{
    When promising a scrap flavor, it's OK if you
    don't yet know how big the flavor data will be.
    In this case, just pass kScrapFlavorSizeUnknown
    for the flavor data size.
}

{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	kScrapFlavorSizeUnknown		= -1;

	{
	    kScrapReservedFlavorType is a flavor type which is reserved
	    for use by Scrap Manager. If you pass it to Scrap Manager,
	    it will be rejected.
	}

	kScrapReservedFlavorType	= 'srft';

	{	
	    We've added scrap flavor flags ala Drag Manager.
	
	    kScrapFlavorMaskNone means you want none of the flags.
	
	    kScrapFlavorSenderOnlyMask means only the process which
	    put the flavor on the scrap can see it. If some other
	    process put a flavor with this flag on the scrap,
	    your process will never see the flavor, so there's
	    no point in testing for this flag.
	
	    kScrapFlavorTranslated means the flavor was translated
	    from some other flavor in the scrap by Translation Manager.
	    Most callers should not care about this bit.
		}
	kScrapFlavorMaskNone		= $00000000;
	kScrapFlavorMaskSenderOnly	= $00000001;
	kScrapFlavorMaskTranslated	= $00000002;


TYPE
	ScrapFlavorFlags					= UInt32;
	{
	    ScrapFlavorInfo describes a single flavor within
	    a scrap.
	}
	ScrapFlavorInfoPtr = ^ScrapFlavorInfo;
	ScrapFlavorInfo = RECORD
		flavorType:				ScrapFlavorType;
		flavorFlags:			ScrapFlavorFlags;
	END;

	{
	    Under a future version of Carbon, there may be multiple scraps.
	    We'll need ScrapRefs to tell them apart.
	}
	ScrapRef    = ^LONGINT; { an opaque 32-bit type }
	ScrapRefPtr = ^ScrapRef;  { when a VAR xx:ScrapRef parameter can be nil, it is changed to xx: ScrapRefPtr }
	{
	    GetCurrentScrap obtains a reference to the current scrap.
	    The ScrapRef obtained via GetCurrentScrap will become
	    invalid and unusable after the scrap is cleared.
	}
	{
	 *  GetCurrentScrap()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION GetCurrentScrap(VAR scrap: ScrapRef): OSStatus;

{
    GetScrapFlavorFlags tells you [a] whether the scrap contains
    data for a particular flavor and [b] some things about that
    flavor if it exists. This call never blocks, and is useful
    for deciding whether to enable the Paste item in your Edit
    menu, among other things.
}

{
 *  GetScrapFlavorFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetScrapFlavorFlags(scrap: ScrapRef; flavorType: ScrapFlavorType; VAR flavorFlags: ScrapFlavorFlags): OSStatus;

{
    GetScrapFlavorSize gets the size of the data of the specified
    flavor. This function blocks until the specified flavor
    data is available. GetScrapFlavorSize is intended as a prelude
    to allocating memory and calling GetScrapFlavorData.
}

{
 *  GetScrapFlavorSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetScrapFlavorSize(scrap: ScrapRef; flavorType: ScrapFlavorType; VAR byteCount: Size): OSStatus;

{
    GetScrapFlavorData gets the data from the specified flavor in the
    specified scrap. This function blocks until the specified flavor
    data is available. Specify the maximum size your buffer can contain;
    on output, this function produces the number of bytes that were
    available (even if this is more than you requested).
}

{
 *  GetScrapFlavorData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetScrapFlavorData(scrap: ScrapRef; flavorType: ScrapFlavorType; VAR byteCount: Size; destination: UNIV Ptr): OSStatus;

{
    ClearCurrentScrap clears the current scrap. Call this
    first when the user requests a Copy or Cut operation --
    even if you maintain a private scrap! You should not wait
    until receiving a suspend event to call ClearCurrentScrap. Call
    it immediately after the user requests a Copy or Cut operation.
    You don't need to put any data on the scrap immediately (although
    it's perfectly fine to do so). You DO need to call GetCurrentScrap
    after ClearCurrentScrap so you'll have a valid ScrapRef to pass
    to other functions.
}

{
 *  ClearCurrentScrap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ClearCurrentScrap: OSStatus;

{
    PutScrapFlavor is a lot like PutScrap, with two differences:
    we added a ScrapRef parameter at the beginning and you can
    "promise" various aspects of a flavor. If you pass a NIL
    data pointer, this is a promise that in the future you
    will provide data for this flavor. Provide the data
    through a subsequent call to PutScrapFlavor, either later
    in the same code flow or during a scrap promise keeper proc.
    If you know how big the data is, you can pass the size as
    well, and this may allow subsequent callers of GetScrapFlavorInfo
    to avoid blocking. If you don't know the size, pass -1.
    If you pass a 0 size, you are telling Scrap Manager not to
    expect any data for this flavor. In this case, the flavor
    data pointer is ignored. NOTE: the last time you can provide
    scrap flavor data is when your scrap promise keeper gets
    called. It is NOT possible to call PutScrapFlavor while
    handling a suspend event; suspend events under Carbon
    simply don't work the way they do under Mac OS 8.
}

{
 *  PutScrapFlavor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PutScrapFlavor(scrap: ScrapRef; flavorType: ScrapFlavorType; flavorFlags: ScrapFlavorFlags; flavorSize: Size; flavorData: UNIV Ptr): OSStatus;

{
    ScrapPromiseKeeper is a function you write which is called by
    Scrap Manager as needed to keep your earlier promise of a
    particular scrap flavor. When your function is called, deliver
    the requested data by calling PutScrapFlavor.
}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ScrapPromiseKeeperProcPtr = FUNCTION(scrap: ScrapRef; flavorType: ScrapFlavorType; userData: UNIV Ptr): OSStatus;
{$ELSEC}
	ScrapPromiseKeeperProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ScrapPromiseKeeperUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ScrapPromiseKeeperUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppScrapPromiseKeeperProcInfo = $00000FF0;
	{
	 *  NewScrapPromiseKeeperUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewScrapPromiseKeeperUPP(userRoutine: ScrapPromiseKeeperProcPtr): ScrapPromiseKeeperUPP; { old name was NewScrapPromiseKeeperProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeScrapPromiseKeeperUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeScrapPromiseKeeperUPP(userUPP: ScrapPromiseKeeperUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeScrapPromiseKeeperUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeScrapPromiseKeeperUPP(scrap: ScrapRef; flavorType: ScrapFlavorType; userData: UNIV Ptr; userRoutine: ScrapPromiseKeeperUPP): OSStatus; { old name was CallScrapPromiseKeeperProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
    SetScrapPromiseKeeper associates a ScrapPromiseKeeper with a
    scrap. You can remove a ScrapPromiseKeeper from a scrap by
    passing a NIL ScrapPromiseKeeper to SetScrapPromiseKeeper.
    Pass whatever you like in the last parameter; its value will
    be passed to your ScrapPromiseKeeper, which can do whatever
    it likes with the value. You might choose to pass a pointer
    or handle to some private scrap data which the
    ScrapPromiseKeeper could use in fabricating one or more
    promised flavors.
}
{
 *  SetScrapPromiseKeeper()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetScrapPromiseKeeper(scrap: ScrapRef; upp: ScrapPromiseKeeperUPP; userData: UNIV Ptr): OSStatus;

{
    GetScrapFlavorCount produces the number of
    items which can be obtained by GetScrapFlavorInfoList.
}

{
 *  GetScrapFlavorCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetScrapFlavorCount(scrap: ScrapRef; VAR infoCount: UInt32): OSStatus;

{
    GetScrapFlavorInfoList fills a list (array)
    of items which each describe the corresponding
    flavor in the scrap. It fills no more array
    elements as are specified. On exit, it produces
    the count of elements it filled (which may be
    smaller than the count requested). Yes, YOU
    must provide the memory for the array.
}

{
 *  GetScrapFlavorInfoList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetScrapFlavorInfoList(scrap: ScrapRef; VAR infoCount: UInt32; info: ScrapFlavorInfoPtr): OSStatus;


{
    CallInScrapPromises forces all promises to be kept.
    If your application promises at least one flavor
    AND it does NOT adopt the new event model, you
    should call this function when your application
    is about to quit. If your app promises no flavors,
    there is no need to call this function, and if
    your app adopts the new event model, this function
    will be called automagically for you. It doesn't
    hurt to call this function more than once, though
    promise keepers may be asked to keep promises
    they already tried and failed.
}

{
 *  CallInScrapPromises()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CallInScrapPromises: OSStatus;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ScrapIncludes}

{$ENDC} {__SCRAP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
