{
     File:       FileMapping.p
 
     Contains:   File Mapping APIs
 
     Version:    Technology: 1.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1998-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT FileMapping;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FILEMAPPING__}
{$SETC __FILEMAPPING__ := 1}

{$I+}
{$SETC FileMappingIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __PROCESSES__}
{$I Processes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


{
 *  BackingFileID
 *  
 *  Discussion:
 *    A BackingFileID is used to access a mapped file fork.
 }

TYPE
	BackingFileID    = ^LONGINT; { an opaque 32-bit type }
	BackingFileIDPtr = ^BackingFileID;  { when a VAR xx:BackingFileID parameter can be nil, it is changed to xx: BackingFileIDPtr }

	{
	 *  MappingPrivileges
	 *  
	 *  Discussion:
	 *    A set of flags that describe what operations can be performed on
	 *    a mapped file fork.
	 	}
	MappingPrivileges 			= UInt32;
CONST
	kInvalidMappedPrivileges	= $00000000;
	kCanReadMappedFile			= $00000001;					{  mapped file fork has read access  }
	kCanWriteMappedFile			= $00000002;					{  mapped file fork has write access  }
	kNoProcessMappedFile		= $80000000;					{  mapped file fork and views are not tracked by process  }
	kValidMappingPrivilegesMask	= $80000003;



	{
	 *  MappedFileAttributes
	 *  
	 *  Discussion:
	 *    A set of flags returned by GetMappedFileInformation that describe
	 *    the attributes of a mapped file fork.
	 	}

TYPE
	MappedFileAttributes 		= UInt32;
CONST
	kIsMappedScratchFile		= $00000001;					{  mapped file fork is scratch file  }


	{
	 	}
	kMappedFileInformationVersion1 = 1;							{  version 1 of MappedFileInformation  }



	{
	 *  MappedFileInformation
	 *  
	 *  Discussion:
	 *    Receives the information supplied by GetMappedFileInformation.
	 *    The current version of this struct is
	 *    kMappedFileInformationVersion1.
	 	}

TYPE
	MappedFileInformationPtr = ^MappedFileInformation;
	MappedFileInformation = RECORD
		owningProcess:			ProcessSerialNumber;					{  owning process  }
		ref:					FSRefPtr;								{  pointer to FSRef or NULL  }
		forkName:				HFSUniStr255Ptr;						{  pointer to HFSUniStr255 or NULL  }
		privileges:				MappingPrivileges;						{  mapping privileges  }
		currentSize:			UInt64;									{  size in bytes  }
		attributes:				MappedFileAttributes;					{  attributes  }
	END;


	{
	 *  FileViewAccess
	 *  
	 *  Discussion:
	 *    Values of type FileViewAccess represent allowable access to the
	 *    memory in a mapped file view.
	 	}
	FileViewAccess 				= UInt32;
CONST
	kFileViewAccessReadBit		= 0;							{  Reads allowed  }
	kFileViewAccessWriteBit		= 1;							{  Writes allowed  }
	kFileViewAccessExecuteBit	= 2;							{  Instruction execution permitted  }
	kFileViewAccessReadMask		= $00000001;					{  Reads allowed  }
	kFileViewAccessWriteMask	= $00000002;					{  Writes allowed  }
	kFileViewAccessExecuteMask	= $00000004;					{  Instruction execution permitted  }
	kFileViewAccessExcluded		= 0;							{  All access is prohibited  }
	kFileViewAccessReadOnly		= $00000005;
	kFileViewAccessReadWrite	= $00000007;



	{
	 *  FileViewOptions
	 *  
	 *  Discussion:
	 *    Values of type FileViewOptions specify desired characteristics of
	 *    the mapped file view being created. At this time, only
	 *    kNilOptions is supported.
	 	}

TYPE
	FileViewOptions						= OptionBits;

	{
	 	}

CONST
	kMapEntireFork				= -1;							{  map from backingBase to logical end-of-file  }



	{
	 *  FileViewID
	 *  
	 *  Discussion:
	 *    A FileViewID is used to access a mapped file view.
	 	}

TYPE
	FileViewID    = ^LONGINT; { an opaque 32-bit type }
	FileViewIDPtr = ^FileViewID;  { when a VAR xx:FileViewID parameter can be nil, it is changed to xx: FileViewIDPtr }

	{
	 	}

CONST
	kFileViewInformationVersion1 = 1;							{  version 1 of MappedFileInformation  }



	{
	 *  FileViewInformation
	 *  
	 *  Discussion:
	 *    Receives the information supplied by GetFileViewInformation. The
	 *    current version of this struct is kFileViewInformationVersion1.
	 	}

TYPE
	FileViewInformationPtr = ^FileViewInformation;
	FileViewInformation = RECORD
		owningProcess:			ProcessSerialNumber;					{  owning process  }
		viewBase:				LogicalAddress;							{  starting address of mapped file view  }
		viewLength:				ByteCount;								{  length of the mapped file view  }
		backingFile:			BackingFileID;							{  the mapped file fork  }
		backingBase:			UInt64;									{  offset into mapped file fork  }
		access:					FileViewAccess;							{  the FileViewAccess  }
		guardLength:			ByteCount;								{  size of the guard ranges  }
		options:				FileViewOptions;						{  the FileViewOptions  }
	END;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  OpenMappedFile()
	 *  
	 *  Summary:
	 *    Opens a file fork with the privileges requested for use as
	 *    backing storage.
	 *  
	 *  Discussion:
	 *    The OpenMappedFile function opens the fork specified by the
	 *    forkNameLength and forkName parameters of the file specified by
	 *    the ref parameter and returns a BackingFileID in the backingFile
	 *    parameter. You can pass the BackingFileID to other routines which
	 *    accept a BackingFileID as an input parameter. The privileges
	 *    parameter specifies what operations you want to perform on the
	 *    mapped file fork. Programs can request either kCanReadMappedFile
	 *    privileges, or both kCanReadMappedFile and kCanWriteMappedFile
	 *    privileges. To disable Process Manager tracking of the mapped
	 *    file fork and its mapped file views, you may also request
	 *    kNoProcessMappedFile privileges.
	 *  
	 *  Parameters:
	 *    
	 *    ref:
	 *      The file to map.
	 *    
	 *    forkNameLength:
	 *      The fork name length in Unicode characters.
	 *    
	 *    forkName:
	 *      The fork name in Unicode (NULL = data fork).
	 *    
	 *    privileges:
	 *      The requested MappingPrivileges.
	 *    
	 *    backingFile:
	 *      Receives a BackingFileID which you can use to access the mapped
	 *      file fork.
	 *  
	 *  Result:
	 *    An operating system result code: noErr, paramErr,
	 *    vmMappingPrivilegesErr, or various File Manager and Memory
	 *    Manager errors.
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION OpenMappedFile({CONST}VAR ref: FSRef; forkNameLength: UniCharCount; {CONST}VAR forkName: UniChar; privileges: MappingPrivileges; VAR backingFile: BackingFileID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $AA81;
	{$ENDC}


{
 *  FSpOpenMappedFile()
 *  
 *  Summary:
 *    Opens a file fork with the privileges requested for use as
 *    backing storage.
 *  
 *  Discussion:
 *    The FSpOpenMappedFile function opens the fork specified by the
 *    mapResFork parameter of the file specified by the spec parameter
 *    and returns a BackingFileID in the backingFile parameter. You can
 *    pass the BackingFileID to other routines which accept a
 *    BackingFileID as an input parameter. The privileges parameter
 *    specifies what operations you want to perform on the mapped file
 *    fork. Programs can request either kCanReadMappedFile privileges,
 *    or both kCanReadMappedFile and kCanWriteMappedFile privileges. To
 *    disable Process Manager tracking of the mapped file fork and its
 *    mapped file views, you may also request kNoProcessMappedFile
 *    privileges.
 *  
 *  Parameters:
 *    
 *    spec:
 *      The file to map.
 *    
 *    mapResFork:
 *      Fork to map: false = data fork; true = resource fork.
 *    
 *    privileges:
 *      The requested MappingPrivileges.
 *    
 *    backingFile:
 *      Receives a BackingFileID which you can use to access the mapped
 *      file fork.
 *  
 *  Result:
 *    An operating system result code: noErr, paramErr,
 *    vmMappingPrivilegesErr, or various File Manager and Memory
 *    Manager errors.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FSpOpenMappedFile({CONST}VAR spec: FSSpec; mapResFork: BOOLEAN; privileges: MappingPrivileges; VAR backingFile: BackingFileID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $AA81;
	{$ENDC}


{
 *  OpenMappedScratchFile()
 *  
 *  Summary:
 *    Creates and opens a scratch file with the privileges requested
 *    for use as backing storage.
 *  
 *  Discussion:
 *    The OpenMappedScratchFile function creates a file with the size
 *    specified by the fileSize parameter on the volume specified by
 *    the volume parameter. If kFSInvalidVolumeRefNum is passed as the
 *    volume parameter, the system code will choose the location of the
 *    file. OpenMappedScratchFile then opens the file and returns a
 *    BackingFileID in the backingFile parameter. You can pass the
 *    BackingFileID to other routines which accept a BackingFileID as
 *    an input parameter. The privileges parameter specifies what
 *    operations you want to perform on the mapped file fork. Programs
 *    can request either kCanReadMappedFile privileges, or both
 *    kCanReadMappedFile and kCanWriteMappedFile privileges. To disable
 *    Process Manager tracking of the mapped file fork and its mapped
 *    file views, you may also request kNoProcessMappedFile privileges.
 *    The data for a scratch file is only valid in an open mapped file
 *    view. When a mapped file view is first created for a scratch file
 *    with MapFileView, data on disk is not paged into memory. When
 *    that mapped file view is unmapped with UnmapFileView, changes are
 *    not flushed from memory to disk.
 *  
 *  Parameters:
 *    
 *    volume:
 *      The volume where scratch file should be created or
 *      kFSInvalidVolumeRefNum to let the system choose the volume.
 *    
 *    fileSize:
 *      The size of the scratch file.
 *    
 *    privileges:
 *      The requested MappingPrivileges.
 *    
 *    backingFile:
 *      Receives a BackingFileID which you can use to access the mapped
 *      file fork.
 *  
 *  Result:
 *    An operating system result code: noErr, paramErr,
 *    vmMappingPrivilegesErr, or various File Manager and Memory
 *    Manager errors.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OpenMappedScratchFile(volume: FSVolumeRefNum; fileSize: ByteCount; privileges: MappingPrivileges; VAR backingFile: BackingFileID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $AA81;
	{$ENDC}


{
 *  CloseMappedFile()
 *  
 *  Summary:
 *    Closes a mapped file fork.
 *  
 *  Discussion:
 *    The CloseMappedFile function closes the mapped file fork
 *    specified by the backingFile parameter. All mapped file views
 *    using the BackingFileID must be closed before closing the mapped
 *    file fork. If the BackingFileID is for a scratch file created
 *    with OpenMappedScratchFile, the scratch file is deleted by
 *    CloseMappedFile after it is closed.
 *  
 *  Parameters:
 *    
 *    backingFile:
 *      The mapped file fork to close.
 *  
 *  Result:
 *    An operating system result code: noErr,
 *    vmInvalidBackingFileIDErr, vmInvalidOwningProcessErr,
 *    vmBusyBackingFileErr, or various File Manager errors.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CloseMappedFile(backingFile: BackingFileID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $AA81;
	{$ENDC}


{
 *  GetMappedFileInformation()
 *  
 *  Summary:
 *    Returns information about a mapped file fork.
 *  
 *  Discussion:
 *    The GetMappedFileInformation function returns information about
 *    the mapped file fork specified by the backingFile parameter. The
 *    struct version of the mappedFileInfo parameter is passed in the
 *    version parameter. The mapped file fork information is returned
 *    in the mappedFileInfo parameter.
 *  
 *  Parameters:
 *    
 *    backingFile:
 *      The mapped file fork.
 *    
 *    version:
 *      The version of the MappedFileInformation struct passed.
 *    
 *    mappedFileInfo:
 *      A pointer to the MappedFileInformation struct where the
 *      information about a mapped file fork is returned.
 *  
 *  Result:
 *    An operating system result code: noErr, paramErr,
 *    vmInvalidBackingFileIDErr, or various File Manager errors.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetMappedFileInformation(backingFile: BackingFileID; version: PBVersion; VAR mappedFileInfo: MappedFileInformation): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $AA81;
	{$ENDC}


{
 *  GetNextMappedFile()
 *  
 *  Summary:
 *    Gets a list of mapped file forks.
 *  
 *  Discussion:
 *    The GetNextMappedFile function returns the BackingFileID of the
 *    mapped file fork next in the list of mapped file forks. You can
 *    enumerate through the list of mapped file forks by passing
 *    kInvalidID as the backingFile parameter and then repetitively
 *    calling GetNextMappedFile with the last BackingFileID returned
 *    until the result code vmNoMoreBackingFilesErr is returned.
 *  
 *  Parameters:
 *    
 *    backingFile:
 *      Input: The last BackingFileID returned by GetNextMappedFile, or
 *      kInvalidID to get the first mapped file fork. Output: If noErr,
 *      receives the BackingFileID of the next mapped file fork.
 *  
 *  Result:
 *    An operating system result code: noErr,
 *    vmInvalidBackingFileIDErr, or vmNoMoreBackingFilesErr.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetNextMappedFile(VAR backingFile: BackingFileID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $AA81;
	{$ENDC}


{
 *  SetMappedFileSize()
 *  
 *  Summary:
 *    Changes the size (logical end-of-file) of a mapped file fork.
 *  
 *  Discussion:
 *    The SetMappedFileSize function sets the logical end-of-file of
 *    the mapped file fork specified by backingFile. The new logical
 *    end-of-file is specified by the positionMode and positionOffset
 *    parameters.
 *  
 *  Parameters:
 *    
 *    backingFile:
 *      The mapped file fork to change the size of.
 *    
 *    positionMode:
 *      The base location for the new size: fsAtMark, fsFromStart,
 *      fsFromLEOF, or fsFromMark.
 *    
 *    positionOffset:
 *      Pointer to a SInt64 which contains the offset of the size from
 *      the base.
 *  
 *  Result:
 *    An operating system result code: noErr, paramErr, or various File
 *    Manager errors.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SetMappedFileSize(backingFile: BackingFileID; positionMode: UInt16; {CONST}VAR positionOffset: SInt64): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $AA81;
	{$ENDC}


{
 *  GetFileViewAccessOptions()
 *  
 *  Summary:
 *    Returns the valid FileViewAccess and FileViewOptions bits.
 *  
 *  Discussion:
 *    The GetFileViewAccessOptions function returns the valid
 *    FileViewAccess and FileViewOptions bits. Programs can use it to
 *    determine what FileViewAccess and FileViewOptions are available.
 *  
 *  Parameters:
 *    
 *    access:
 *      Receives the valid memory access flags.
 *    
 *    options:
 *      Receives the valid view options.
 *  
 *  Result:
 *    An operating system result code: noErr, or paramErr.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetFileViewAccessOptions(VAR access: FileViewAccess; VAR options: FileViewOptions): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7007, $AA81;
	{$ENDC}


{
 *  MapFileView()
 *  
 *  Summary:
 *    Creates a mapped file view into a mapped file fork.
 *  
 *  Discussion:
 *    The MapFileView function creates a mapped file view into the
 *    mapped file fork specified by the backingFile parameter.
 *    MapFileView returns a FileViewID in the theView parameter. You
 *    can pass the FileViewID to other routines which accept a
 *    FileViewID as an input parameter. The backingBase and
 *    backingLength parameters specify what part of the mapped file
 *    fork will be mapped to memory. The access parameter specifies the
 *    allowable access to the memory in a mapped file view. The
 *    guardLength parameter specifies the size, in bytes, of the
 *    excluded logical address ranges to place adjacent to each end of
 *    the mapped file view. The options parameter specifies the desired
 *    characteristics of the mapped file view. The viewBase parameter,
 *    as an optional input, specifies the requested viewBase. The
 *    backingBase parameter must be a whole multiple of the logical
 *    page size. If kMapEntireFork is passed as backingLength, accesses
 *    past the mapped file fork's logical end-of-file will not cause
 *    exceptions, but will have undefined behavior. Only accesses up to
 *    viewLength should be considered valid. The starting address of
 *    the mapped file view is returned in the viewBase parameter. The
 *    length of the mapped file view is returned in the viewLength
 *    parameter.
 *  
 *  Parameters:
 *    
 *    backingFile:
 *      The mapped file fork to create a mapped file view from.
 *    
 *    backingBase:
 *      Pointer to the offset into mapped file fork. Passing a NULL
 *      pointer is the same as passing an offset of zero.
 *    
 *    backingLength:
 *      The number of bytes to map, or kMapEntireFork to map from
 *      backingBase to the mapped file fork's logical end-of-file.
 *    
 *    access:
 *      The FileViewAccess.
 *    
 *    guardLength:
 *      The size, in bytes, of the excluded logical address ranges to
 *      place adjacent to each end of the mapped file view.
 *    
 *    options:
 *      The desired characteristics of the mapped file view.
 *    
 *    viewBase:
 *      Input: The requested viewBase. Output: Receives the starting
 *      address of mapped file view.
 *    
 *    viewLength:
 *      Receives the mapped file view length.
 *    
 *    theView:
 *      Receives a FileViewID which you can use to access the mapped
 *      file view.
 *  
 *  Result:
 *    An operating system result code: noErr, paramErr,
 *    vmInvalidBackingFileIDErr, vmInvalidOwningProcessErr,
 *    vmFileViewAccessErr, or various File Manager and Memory Manager
 *    errors.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MapFileView(backingFile: BackingFileID; backingBase: {Const}UInt64Ptr; backingLength: ByteCount; access: FileViewAccess; guardLength: ByteCount; options: FileViewOptions; VAR viewBase: LogicalAddress; VAR viewLength: ByteCount; VAR theView: FileViewID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $AA81;
	{$ENDC}


{
 *  UnmapFileView()
 *  
 *  Summary:
 *    Unmaps a mapped file view.
 *  
 *  Discussion:
 *    The UnmapFileView function unmaps a mapped file view specified by
 *    the theView parameter from memory. All modified memory is flushed
 *    to the mapped file fork before the mapped file view is unmapped
 *    unless the mapped file view is to a scratch file.
 *  
 *  Parameters:
 *    
 *    theView:
 *      The mapped file view to unmap.
 *  
 *  Result:
 *    An operating system result code: noErr, vmInvalidFileViewIDErr,
 *    vmInvalidOwningProcessErr, or various File Manager and Memory
 *    Manager errors.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UnmapFileView(theView: FileViewID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7009, $AA81;
	{$ENDC}


{
 *  GetFileViewInformation()
 *  
 *  Summary:
 *    Returns information about a mapped file view.
 *  
 *  Discussion:
 *    The GetFileViewInformation function returns information about the
 *    mapped file view specified by the theView parameter. The struct
 *    version of the fileViewInfo parameter is passed in the version
 *    parameter. The mapped file view information is returned in the
 *    fileViewInfo parameter.
 *  
 *  Parameters:
 *    
 *    theView:
 *      The mapped file view.
 *    
 *    version:
 *      The version of the FileViewInformation struct passed.
 *    
 *    fileViewInfo:
 *      A pointer to the FileViewInformation struct where the
 *      information about a mapped file view is returned.
 *  
 *  Result:
 *    An operating system result code: noErr, paramErr, or
 *    vmInvalidFileViewIDErr.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetFileViewInformation(theView: FileViewID; version: PBVersion; VAR fileViewInfo: FileViewInformation): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700A, $AA81;
	{$ENDC}


{
 *  GetFileViewFromAddress()
 *  
 *  Summary:
 *    Returns the FileViewID for a given address.
 *  
 *  Discussion:
 *    The GetFileViewFromAddress function returns the FileViewID for
 *    address specified in the address parameter.
 *  
 *  Parameters:
 *    
 *    address:
 *      The memory address.
 *    
 *    theView:
 *      Receives a FileViewID for the given memory address.
 *  
 *  Result:
 *    An operating system result code: noErr, paramErr, or
 *    vmAddressNotInFileViewErr.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetFileViewFromAddress(address: LogicalAddress; VAR theView: FileViewID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700B, $AA81;
	{$ENDC}


{
 *  GetNextFileView()
 *  
 *  Summary:
 *    Gets a list of mapped file views.
 *  
 *  Discussion:
 *    The GetNextView function returns the FileViewID of the mapped
 *    file view next in the list of mapped file views. You can
 *    enumerate through the list of mapped file views by passing
 *    kInvalidID as the theView parameter and then repetitively calling
 *    GetNextView with the last FileViewID returned until the result
 *    code vmNoMoreFileViewsErr is returned.
 *  
 *  Parameters:
 *    
 *    theView:
 *      Input: The last FileViewID returned by GetNextView, or
 *      kInvalidID to get the first mapped file view. Output: If noErr,
 *      receives the FileViewID of the next mapped file view.
 *  
 *  Result:
 *    An operating system result code: noErr, paramErr,
 *    vmInvalidFileViewIDErr, or vmNoMoreFileViewsErr.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetNextFileView(VAR theView: FileViewID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $AA81;
	{$ENDC}


{
 *  SetFileViewAccess()
 *  
 *  Summary:
 *    Changes a mapped file view's FileViewAccess.
 *  
 *  Discussion:
 *    The SetViewAccess function changes the FileViewAccess of the
 *    mapped file view specified by the theView parameter. The new
 *    FileViewAccess is specified by the accessLevel parameter.
 *  
 *  Parameters:
 *    
 *    theView:
 *      The mapped file view.
 *    
 *    access:
 *      The new FileViewAccess.
 *  
 *  Result:
 *    An operating system result code: noErr, paramErr,
 *    vmInvalidFileViewIDErr, or vmFileViewAccessErr.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SetFileViewAccess(theView: FileViewID; access: FileViewAccess): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700D, $AA81;
	{$ENDC}


{
 *  SetFileViewBackingBase()
 *  
 *  Summary:
 *    Changes the backing base of a mapped file view.
 *  
 *  Discussion:
 *    The SetFileViewBackingBase function changes the backing base of
 *    the mapped file view specified by theView. The new backing base
 *    is specified by the newBackingBase parameter.
 *  
 *  Parameters:
 *    
 *    theView:
 *      The mapped file view.
 *    
 *    newBackingBase:
 *      Pointer to the offset into mapped file fork. Passing a NULL
 *      pointer is the same as passing an offset of zero.
 *  
 *  Result:
 *    An operating system result code: noErr, vmInvalidFileViewIDErr,
 *    or paramErr.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SetFileViewBackingBase(theView: FileViewID; newBackingBase: {Const}UInt64Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700E, $AA81;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FileMappingIncludes}

{$ENDC} {__FILEMAPPING__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
