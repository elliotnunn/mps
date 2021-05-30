{
     File:       IterateDirectory.p
 
     Contains:   File Manager directory iterator routines.
 
     Version:    Technology: MoreFiles
                 Release:    1.5.1
 
     Copyright:  © 1995-2001 by Jim Luther and Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}

{
    You may incorporate this sample code into your applications without
    restriction, though the sample code has been provided "AS IS" and the
    responsibility for its operation is 100% yours.  However, what you are
    not permitted to do is to redistribute the source as "DSC Sample Code"
    after having made changes. If you're going to re-distribute the source,
    we require that you make it clear in the source that the code was
    descended from Apple Sample Code, but that you've made changes.
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT IterateDirectory;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ITERATEDIRECTORY__}
{$SETC __ITERATEDIRECTORY__ := 1}

{$I+}
{$SETC IterateDirectoryIncludes := UsingIncludes}
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

{***************************************************************************}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	IterateFilterProcPtr = PROCEDURE({CONST}VAR cpbPtr: CInfoPBRec; VAR quitFlag: BOOLEAN; yourDataPtr: UNIV Ptr);
{$ELSEC}
	IterateFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	IterateFilterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	IterateFilterUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppIterateFilterProcInfo = $00000FC0;
FUNCTION NewIterateFilterUPP(userRoutine: IterateFilterProcPtr): IterateFilterUPP; { old name was NewIterateFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeIterateFilterUPP(userUPP: IterateFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeIterateFilterUPP({CONST}VAR cpbPtr: CInfoPBRec; VAR quitFlag: BOOLEAN; yourDataPtr: UNIV Ptr; userRoutine: IterateFilterUPP); { old name was CallIterateFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
    This is the prototype for the IterateFilterProc function which is
    called once for each file and directory found by IterateDirectory. The
    IterateFilterProc gets a pointer to the CInfoPBRec that IterateDirectory
    used to call PBGetCatInfo. The IterateFilterProc can use the read-only
    data in the CInfoPBRec for whatever it wants.
    
    If the IterateFilterProc wants to stop IterateDirectory, it can set
    quitFlag to true (quitFlag will be passed to the IterateFilterProc
    false).
    
    The yourDataPtr parameter can point to whatever data structure you might
    want to access from within the IterateFilterProc.

    cpbPtr      input:  A pointer to the CInfoPBRec that IterateDirectory
                        used to call PBGetCatInfo. The CInfoPBRec and the
                        data it points to must not be changed by your
                        IterateFilterProc.
    quitFlag    output: Your IterateFilterProc can set quitFlag to true
                        if it wants to stop IterateDirectory.
    yourDataPtr input:  A pointer to whatever data structure you might
                        want to access from within the IterateFilterProc.
    
    __________
    
    Also see:   IterateDirectory, FSpIterateDirectory
}

{***************************************************************************}

FUNCTION IterateDirectory(vRefNum: INTEGER; dirID: LONGINT; name: Str255; maxLevels: UInt16; iterateFilter: IterateFilterProcPtr; yourDataPtr: UNIV Ptr): OSErr;

{
    The IterateDirectory function performs a recursive iteration (scan) of
    the specified directory and calls your IterateFilterProc function once
    for each file and directory found.
    
    The maxLevels parameter lets you control how deep the recursion goes.
    If maxLevels is 1, IterateDirectory only scans the specified directory;
    if maxLevels is 2, IterateDirectory scans the specified directory and
    one subdirectory below the specified directory; etc. Set maxLevels to
    zero to scan all levels.
    
    The yourDataPtr parameter can point to whatever data structure you might
    want to access from within the IterateFilterProc.

    vRefNum         input:  Volume specification.
    dirID           input:  Directory ID.
    name            input:  Pointer to object name, or nil when dirID
                            specifies a directory that's the object.
    maxLevels       input:  Maximum number of directory levels to scan or
                            zero to scan all directory levels.
    iterateFilter   input:  A pointer to the routine you want called once
                            for each file and directory found by
                            IterateDirectory.
    yourDataPtr     input:  A pointer to whatever data structure you might
                            want to access from within the IterateFilterProc.
    
    Result Codes
        noErr               0       No error
        nsvErr              -35     No such volume
        ioErr               -36     I/O error
        bdNamErr            -37     Bad filename
        fnfErr              -43     File not found
        paramErr            -50     No default volume or iterateFilter was NULL
        dirNFErr            -120    Directory not found or incomplete pathname
                                    or a file was passed instead of a directory
        afpAccessDenied     -5000   User does not have the correct access
        afpObjectTypeErr    -5025   Directory not found or incomplete pathname
        
    __________
    
    See also:   IterateFilterProcPtr, FSpIterateDirectory
}

{***************************************************************************}

FUNCTION FSpIterateDirectory({CONST}VAR spec: FSSpec; maxLevels: UInt16; iterateFilter: IterateFilterProcPtr; yourDataPtr: UNIV Ptr): OSErr;

{
    The FSpIterateDirectory function performs a recursive iteration (scan)
    of the specified directory and calls your IterateFilterProc function once
    for each file and directory found.
    
    The maxLevels parameter lets you control how deep the recursion goes.
    If maxLevels is 1, FSpIterateDirectory only scans the specified directory;
    if maxLevels is 2, FSpIterateDirectory scans the specified directory and
    one subdirectory below the specified directory; etc. Set maxLevels to
    zero to scan all levels.
    
    The yourDataPtr parameter can point to whatever data structure you might
    want to access from within the IterateFilterProc.

    spec            input:  An FSSpec record specifying the directory to scan.
    maxLevels       input:  Maximum number of directory levels to scan or
                            zero to scan all directory levels.
    iterateFilter   input:  A pointer to the routine you want called once
                            for each file and directory found by
                            FSpIterateDirectory.
    yourDataPtr     input:  A pointer to whatever data structure you might
                            want to access from within the IterateFilterProc.
    
    Result Codes
        noErr               0       No error
        nsvErr              -35     No such volume
        ioErr               -36     I/O error
        bdNamErr            -37     Bad filename
        fnfErr              -43     File not found
        paramErr            -50     No default volume or iterateFilter was NULL
        dirNFErr            -120    Directory not found or incomplete pathname
        afpAccessDenied     -5000   User does not have the correct access
        afpObjectTypeErr    -5025   Directory not found or incomplete pathname
        
    __________
    
    See also:   IterateFilterProcPtr, IterateDirectory
}

{***************************************************************************}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := IterateDirectoryIncludes}

{$ENDC} {__ITERATEDIRECTORY__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
