{
     File:       Start.p
 
     Contains:   Start Manager Interfaces.
 
     Version:    Technology: Mac OS 8.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1987-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Start;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __START__}
{$SETC __START__ := 1}

{$I+}
{$SETC StartIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
    Important: When the major version number of kExtensionTableVersion and the value
    returned by gestaltExtensionTableVersion change, it indicates that the Extension
    Table startup mechanism has radically changed and code that doesn't know about
    the new major version must not attempt to use the Extension Table startup
    mechanism.
    
    Changes to the minor version number of kExtensionTableVersion indicate that the
    definition of the ExtensionElement structure has been extended, but the fields
    defined for previous minor versions of kExtensionTableVersion have not changed.
}

CONST
	kExtensionTableVersion		= $00000100;					{  current ExtensionTable version (1.0.0)  }

	{	 ExtensionNotification message codes 	}
	extNotificationBeforeFirst	= 0;							{  Before any extensions have loaded  }
	extNotificationAfterLast	= 1;							{  After all extensions have loaded  }
	extNotificationBeforeCurrent = 2;							{  Before extension at extElementIndex is loaded  }
	extNotificationAfterCurrent	= 3;							{  After extension at extElementIndex is loaded  }


TYPE
	ExtensionElementPtr = ^ExtensionElement;
	ExtensionElement = RECORD
		fileName:				Str31;									{  The file name  }
		parentDirID:			LONGINT;								{  the file's parent directory ID  }
																		{  and everything after ioNamePtr in the HParamBlockRec.fileParam variant  }
		ioVRefNum:				INTEGER;								{  always the real volume reference number (not a drive, default, or working dirID)  }
		ioFRefNum:				INTEGER;
		ioFVersNum:				SInt8;
		filler1:				SInt8;
		ioFDirIndex:			INTEGER;								{  always 0 in table  }
		ioFlAttrib:				SInt8;
		ioFlVersNum:			SInt8;
		ioFlFndrInfo:			FInfo;
		ioDirID:				LONGINT;
		ioFlStBlk:				UInt16;
		ioFlLgLen:				LONGINT;
		ioFlPyLen:				LONGINT;
		ioFlRStBlk:				UInt16;
		ioFlRLgLen:				LONGINT;
		ioFlRPyLen:				LONGINT;
		ioFlCrDat:				UInt32;
		ioFlMdDat:				UInt32;
	END;

	ExtensionTableHeaderPtr = ^ExtensionTableHeader;
	ExtensionTableHeader = RECORD
		extTableHeaderSize:		UInt32;									{  size of ExtensionTable header ( equal to offsetof(ExtensionTable, extElements[0]) )  }
		extTableVersion:		UInt32;									{  current ExtensionTable version (same as returned by gestaltExtTableVersion Gestalt selector)  }
		extElementIndex:		UInt32;									{  current index into ExtensionElement records (zero-based)  }
		extElementSize:			UInt32;									{  size of ExtensionElement  }
		extElementCount:		UInt32;									{  number of ExtensionElement records in table (1-based)  }
	END;

	ExtensionTablePtr = ^ExtensionTable;
	ExtensionTable = RECORD
		extTableHeader:			ExtensionTableHeader;					{  the ExtensionTableHeader  }
		extElements:			ARRAY [0..0] OF ExtensionElement;		{  one element for each extension to load  }
	END;

	ExtensionTableHandle				= ^ExtensionTablePtr;
{$IFC TYPED_FUNCTION_POINTERS}
	ExtensionNotificationProcPtr = PROCEDURE(message: UInt32; param: UNIV Ptr; extElement: ExtensionElementPtr);
{$ELSEC}
	ExtensionNotificationProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ExtensionTableHandlerProcPtr = PROCEDURE(message: UInt32; param: UNIV Ptr; extTableHandle: ExtensionTableHandle);
{$ELSEC}
	ExtensionTableHandlerProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ExtensionNotificationUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ExtensionNotificationUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ExtensionTableHandlerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ExtensionTableHandlerUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppExtensionNotificationProcInfo = $00000FC0;
	uppExtensionTableHandlerProcInfo = $00000FC0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewExtensionNotificationUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewExtensionNotificationUPP(userRoutine: ExtensionNotificationProcPtr): ExtensionNotificationUPP; { old name was NewExtensionNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewExtensionTableHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewExtensionTableHandlerUPP(userRoutine: ExtensionTableHandlerProcPtr): ExtensionTableHandlerUPP; { old name was NewExtensionTableHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeExtensionNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeExtensionNotificationUPP(userUPP: ExtensionNotificationUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeExtensionTableHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeExtensionTableHandlerUPP(userUPP: ExtensionTableHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeExtensionNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeExtensionNotificationUPP(message: UInt32; param: UNIV Ptr; extElement: ExtensionElementPtr; userRoutine: ExtensionNotificationUPP); { old name was CallExtensionNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeExtensionTableHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeExtensionTableHandlerUPP(message: UInt32; param: UNIV Ptr; extTableHandle: ExtensionTableHandle; userRoutine: ExtensionTableHandlerUPP); { old name was CallExtensionTableHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	DefStartRecPtr = ^DefStartRec;
	DefStartRec = RECORD
		CASE INTEGER OF
		0: (
			sdExtDevID:			SignedByte;
			sdPartition:		SignedByte;
			sdSlotNum:			SignedByte;
			sdSRsrcID:			SignedByte;
		   );
		1: (
			sdReserved1:		SignedByte;
			sdReserved2:		SignedByte;
			sdRefNum:			INTEGER;
		   );
	END;

	DefStartPtr							= ^DefStartRec;
	DefStartPtrPtr 						= ^DefStartPtr;
	DefVideoRecPtr = ^DefVideoRec;
	DefVideoRec = RECORD
		sdSlot:					SignedByte;
		sdsResource:			SignedByte;
	END;

	DefVideoPtr							= ^DefVideoRec;
	DefOSRecPtr = ^DefOSRec;
	DefOSRec = RECORD
		sdReserved:				SignedByte;
		sdOSType:				SignedByte;
	END;

	DefOSPtr							= ^DefOSRec;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  GetDefaultStartup()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE GetDefaultStartup(paramBlock: DefStartPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A07D;
	{$ENDC}

{
 *  SetDefaultStartup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetDefaultStartup(paramBlock: DefStartPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A07E;
	{$ENDC}

{
 *  GetVideoDefault()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GetVideoDefault(paramBlock: DefVideoPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A080;
	{$ENDC}

{
 *  SetVideoDefault()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetVideoDefault(paramBlock: DefVideoPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A081;
	{$ENDC}

{
 *  GetOSDefault()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GetOSDefault(paramBlock: DefOSPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A084;
	{$ENDC}

{
 *  SetOSDefault()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetOSDefault(paramBlock: DefOSPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A083;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  SetTimeout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetTimeout(count: INTEGER);

{
 *  GetTimeout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GetTimeout(VAR count: INTEGER);

{$ENDC}  {CALL_NOT_IN_CARBON}

{
    InstallExtensionNotificationProc

    Installs an ExtensionNotificationUPP.

    Parameters:
        extNotificationProc The ExtensionNotificationUPP to install.

    Results:
        noErr       0       The ExtensionNotificationUPP was installed.
        paramErr    -50     This ExtensionNotificationUPP has already been installed.
        memFullErr  -108    Not enough memory to install the ExtensionNotificationUPP.
}
{$IFC CALL_NOT_IN_CARBON }
{
 *  InstallExtensionNotificationProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InstallExtensionNotificationProc(extNotificationProc: ExtensionNotificationUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $AA7D;
	{$ENDC}


{
    RemoveExtensionNotificationProc

    Removes an ExtensionNotificationUPP.
    
    Note:   ExtensionNotificationUPPs can't call RemoveExtensionNotificationProc.

    Parameters:
        extNotificationProc The ExtensionNotificationUPP to remove.

    Results:
        noErr       0       The ExtensionNotificationUPP was removed.
        paramErr    -50     The ExtensionNotificationUPP was not found, or
                            RemoveExtensionNotificationProc was called from within
                            a ExtensionNotificationUPP (ExtensionNotificationUPPs can't
                            call RemoveExtensionNotificationProc).
}
{
 *  RemoveExtensionNotificationProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RemoveExtensionNotificationProc(extNotificationProc: ExtensionNotificationUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $AA7D;
	{$ENDC}


{
    InstallExtensionTableHandlerProc

    Installs an ExtensionTableHandlerUPP. Control is taken away from the system's default
    handler and the ExtensionTableHandlerUPP is responsible for all changes to the
    ExtensionTable (except for incrementing extElementIndex between extensions). This is
    always the first handler called with extNotificationBeforeFirst and
    extNotificationBeforeCurrent messages and the last handler called with
    extNotificationAfterLast and extNotificationAfterCurrent messages. extElementIndex
    is always incremented immediately after the ExtensionTableHandlerUPP is called with
    the extNotificationAfterCurrent message.
    
    There can only be one ExtensionTableHandler installed.
    
    Warning:    The only safe time to change what ExtensionElement is at
                ExtensionTable.extElements[extElementIndex] is when your
                ExtensionTableHandlerUPP is called with the extNotificationAfterCurrent
                message. You may change the ExtensionTable or the extElementIndex at other
                times, but you must ensure that the ExtensionElement at
                ExtensionTable.extElements[extElementIndex] stays the same.
                
    Note:       If the ExtensionTable or the contents of the folders included in the
                ExtensionTable are changed after installing an ExtensionTableHandler,
                RemoveExtensionTableHandlerProc cannot be called.

    Parameters:
        extMgrProc          The ExtensionTableHandlerUPP to install.
        extTable            A pointer to an ExtensionTableHandle where
                            InstallExtensionTableHandlerProc will return the current
                            ExtensionTableHandle. You don't own the handle itself and
                            must not dispose of it, but you can change the extElementIndex.
                            the extElementCount, and the ExtensionElements in the table.

    Results:
        noErr       0       The ExtensionTableHandlerUPP was installed.
        paramErr    -50     Another ExtensionTableHandlerUPP has already been installed.
        memFullErr  -108    Not enough memory to install the ExtensionTableHandlerUPP.
}
{
 *  InstallExtensionTableHandlerProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InstallExtensionTableHandlerProc(extMgrProc: ExtensionTableHandlerUPP; VAR extTable: ExtensionTableHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $AA7D;
	{$ENDC}


{
    RemoveExtensionTableHandlerProc

    Remove an ExtensionTableUPP. Control is passed back to the default handler.

    Parameters:
        extMgrProc          The ExtensionTableUPP to remove.

    Results:
        noErr       0       The ExtensionTableUPP was removed.
        paramErr    -50     This ExtensionTableUPP was not installed,
                            or the ExtensionTable no longer matches the
                            original boot ExtensionTable.
}
{
 *  RemoveExtensionTableHandlerProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RemoveExtensionTableHandlerProc(extMgrProc: ExtensionTableHandlerUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $AA7D;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 * Native StartLib calls - these are implemented ONLY on NewWorld machines (iMac, etc.)
 *
 * These functions should be weak linked.  If unavailable, use older method (Get/SetDefaultStartup)
 }
{
 * The enums below define pseudo startup devices, such as a network disk.  They can be used in place
 * of driveNums in various StartLib calls
 *
 * NOTE - the values are chosen to avoid conflict with vRefNums (low negative numbers), wdRefNums
 *      (large negative numbers) and drive numbers (low positive numbers)
 }

CONST
	kNetworkStartupDevice		= 32767;
	kLocalStartupDevice			= 32766;

	{	
	 * The enums below determine the maximum string size of parameters for network startup device calls.
	 	}
	kSMProtocolStringSize		= 16;
	kSMAddressStringSize		= 16;
	kSMBootFilenameSize			= 128;

	{	
	 * GetSelectedStartupDevice - return the driveNum of the currently selected startup device.  This refers
	 * to the device selected by the user via Startup Disk control panel, which may or may not be the
	 * device currently booted.
	 	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  GetSelectedStartupDevice()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in StartLib 1.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION GetSelectedStartupDevice(VAR driveNum: UInt16): OSErr; C;

{
 * GetSelectedStartupDeviceType - return the type of the currently selected startup device.  This refers
 * to the device selected by the user via Startup Disk control panel, which may or may not be the
 * device currently booted.  Returned types are based on kdgInterface  DriverGestalt response 
 * ('scsi', 'ata ', 'fire', etc.)
 }
{
 *  GetSelectedStartupDeviceType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in StartLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetSelectedStartupDeviceType(VAR interfaceType: OSType): OSErr; C;

{
 * GetSelectedFirewireStartupDeviceInfo - for a startup device of type Firewire, get pertinent info, including
 * GUID, mao and lun.  This refers to the device selected by the user via Startup Disk control panel, which 
 * may or may not be the device currently booted.
 *
 * GetSelectedFirewireStartupDeviceInfo should only be called if GetSelectedStartupDeviceType returns
 * the type kdgFireWireIntf.  If the selected startup device is not kdgFireWireIntf,
 * GetSelectedFirewireStartupDeviceInfo returns an error (nsDrvErr) and the return parameters are
 * undefined.
 }
{
 *  GetSelectedFirewireStartupDeviceInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in StartLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetSelectedFirewireStartupDeviceInfo(VAR GUID: UnsignedWide; VAR mao: UInt32; VAR lun: UInt32): OSErr; C;

{
 * GetSelectedNetworkStartupDeviceInfo - for a network startup device, return relevant information (this refers
 * to the device selected by the user via Startup Disk control panel, which may or may not be the
 * device currently booted):
 *
 * See the Open Firmware netbooting recommended practices:
 *      http://playground.sun.com/1275/practice/obp-tftp/tftp1_0.pdf
 *
 * The possible parameters for this call are:
 *
 *      [bootp,]siaddr,filename,ciaddr,giaddr,bootp-retries,tftp-retries
 *
 *          bootp...specifies the use of BOOTP as the “discovery” protocol to be used.
 *          siaddr is the IP address of the intended server.
 *          filename is the filename of the file that is to be loaded by TFTP from the server.
 *          ciaddr is the IP address of the client (i.e., the system being booted).
 *          giaddr is the IP address of the BOOTP ‘gateway’.
 *          bootp-retries is the maximum number of retries that are attempted before the BOOTP process is determined to have failed.
 *          tftp-retries is the maximum number of retries that are attempted before the TFTP process is stopped.
 *
 *      Address parameters are specified as strings, not binary (e.g., "128.1.1.1") and are limited to kSMAddressStringSize
 *      (16 bytes) in length.  filename parameter is limited to kSMBootFilenameSize (128 bytes) in length.  protocol 
 *      parameter is limited to kSMProtocolStringSize in length
 }
{
 *  GetSelectedNetworkStartupDeviceInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in StartLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetSelectedNetworkStartupDeviceInfo(protocol: CStringPtr; siaddr: CStringPtr; filename: CStringPtr; ciaddr: CStringPtr; giaddr: CStringPtr; VAR bootpRetries: UInt32; VAR tftpRetries: UInt32; reserved: UInt32): OSErr; C;

{
 * IsDriveSelectable - determines if the drive specified by driveNum is a candidate for booting.  This
 * checks criteria, such as necessary driver support and Open Firmware support, which are minimal for
 * the device to be considered as a startup device.  This call does not check other criteria, such as
 * whether or not a valid System Folder is present on the volume.
 }
{
 *  IsDriveSelectable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in StartLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IsDriveSelectable(driveNum: UInt16): BOOLEAN; C;

{
 * SetSelectedStartupDevice - set the device referred to by driveNum to be the startup device.  Passing
 * the pseudo-device kNetworkStartupDevice sets default enet:bootp behavior.  For more complex 
 * scenarios, use SetSelectedNetworkStartupDevice (q.v.).
 }
{
 *  SetSelectedStartupDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in StartLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SetSelectedStartupDevice(driveNum: UInt16): OSErr; C;

{
 * SetSelectedNetworkStartupDevice - set a network device as the startup device.  This is for more
 * complex setup than handled by SetSelectedStartupDevice.
 *
 * See the Open Firmware netbooting recommended practices:
 *      http://playground.sun.com/1275/practice/obp-tftp/tftp1_0.pdf
 *
 * The possible parameters for this call are:
 *
 *      [bootp,]siaddr,filename,ciaddr,giaddr,bootp-retries,tftp-retries
 *
 *          bootp...specifies the use of BOOTP as the “discovery” protocol to be used.
 *              if not specified (parameter is nil), bootp is used by default
 *          siaddr is the IP address of the intended server.
 *          filename is the filename of the file that is to be loaded by TFTP from the server.
 *          ciaddr is the IP address of the client (i.e., the system being booted).
 *          giaddr is the IP address of the BOOTP ‘gateway’.
 *          bootp-retries is the maximum number of retries that are attempted before the BOOTP process is determined to have failed.
 *          tftp-retries is the maximum number of retries that are attempted before the TFTP process is stopped.
 *
 *      Address parameters are specified as strings, not binary (e.g., "128.1.1.1") and are limited to kSMAddressStringSize
 *      (16 bytes) in length.  filename parameter is limited to kSMBootFilenameSize (128 bytes) in length.  protocol 
 *      parameter is limited to kSMProtocolStringSize in length
 *
 *  NOTE - unspecified parameters should be specified as nil, except for retry parameters which should be zero.
 }
{
 *  SetSelectedNetworkStartupDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in StartLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SetSelectedNetworkStartupDevice(protocol: CStringPtr; siaddr: CStringPtr; filename: CStringPtr; ciaddr: CStringPtr; giaddr: CStringPtr; bootpRetries: UInt32; tftpRetries: UInt32; reserved: UInt32): OSErr; C;

{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := StartIncludes}

{$ENDC} {__START__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
