{
     File:       AppleHelp.p
 
     Contains:   Apple Help
 
     Version:    Technology: Mac OS X/CarbonLib 1.1
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT AppleHelp;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __APPLEHELP__}
{$SETC __APPLEHELP__ := 1}

{$I+}
{$SETC AppleHelpIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ AppleHelp Error Codes }

CONST
	kAHInternalErr				= -10790;
	kAHInternetConfigPrefErr	= -10791;



TYPE
	AHTOCType 					= SInt16;
CONST
	kAHTOCTypeUser				= 0;
	kAHTOCTypeDeveloper			= 1;

	{
	 *  AHSearch()
	 *  
	 *  Discussion:
	 *    Delivers a request to perform the specified search to the Help
	 *    Viewer application.
	 *  
	 *  Parameters:
	 *    
	 *    bookname:
	 *      Optionally, the AppleTitle of the Help book to be searched. If
	 *      NULL, all installed Help books are searched.
	 *    
	 *    query:
	 *      The query to be made. This string can, if desired, have boolean
	 *      operators or be a natural language phrase.
	 *  
	 *  Result:
	 *    An operating system result code that indicates whether the
	 *    request was successfully sent to the Help Viewer application.
	 *    Possible values: noErr, paramErr, kAHInternalErr,
	 *    kAHInternetConfigPrefErr.
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION AHSearch(bookname: CFStringRef; query: CFStringRef): OSStatus; C;

{
 *  AHGotoMainTOC()
 *  
 *  Discussion:
 *    Delivers a request to load the main table of contents of
 *    installed help books to the Help Viewer application.
 *  
 *  Parameters:
 *    
 *    toctype:
 *      The type of table of contents to be loaded: user or developer.
 *  
 *  Result:
 *    An operating system result code that indicates whether the
 *    request was successfully sent to the Help Viewer application.
 *    Possible values: noErr, paramErr, kAHInternalErr,
 *    kAHInternetConfigPrefErr.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AHGotoMainTOC(toctype: AHTOCType): OSStatus; C;

{
 *  AHGotoPage()
 *  
 *  Discussion:
 *    Delivers a request to load a specific text/html file to the Help
 *    Viewer application.
 *  
 *  Parameters:
 *    
 *    bookname:
 *      Optionally, the AppleTitle of an installed Help book. If NULL,
 *      the path parameter must be a full file: URL to the file to be
 *      opened.
 *    
 *    path:
 *      Optionally, one of two types of paths: 1) a URL-style path to a
 *      file that is relative to the main folder of the book supplied
 *      in the bookname parameter, or 2) if bookname is NULL, a full
 *      file: URL to the file to be opened. If this parameter is NULL,
 *      then bookname must not be NULL, and is used to open the Help
 *      Viewer to the main page of Help content for the specified book.
 *    
 *    anchor:
 *      Optionally, the name of anchor tag to scroll to in the newly
 *      opened file. Can be NULL.
 *  
 *  Result:
 *    An operating system result code that indicates whether the
 *    request was successfully sent to the Help Viewer application.
 *    Possible values: noErr, paramErr, kAHInternalErr,
 *    kAHInternetConfigPrefErr.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AHGotoPage(bookname: CFStringRef; path: CFStringRef; anchor: CFStringRef): OSStatus; C;

{
 *  AHLookupAnchor()
 *  
 *  Discussion:
 *    Delivers a request to perform an anchor lookup to the Help Viewer
 *    application. Note: anchor lookups will fail unless you have
 *    indexed your help content with anchor indexing turned on in the
 *    indexing tool's preferences panel.
 *  
 *  Parameters:
 *    
 *    bookname:
 *      Optionally, the AppleTitle of the Help book to searched. If
 *      NULL, the anchor lookup is performed using all installed Help
 *      books.
 *    
 *    anchor:
 *      The name of the anchor tag to look up.
 *  
 *  Result:
 *    An operating system result code that indicates whether the
 *    request was successfully sent to the Help Viewer application.
 *    Possible values: noErr, paramErr, kAHInternalErr,
 *    kAHInternetConfigPrefErr.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AHLookupAnchor(bookname: CFStringRef; anchor: CFStringRef): OSStatus; C;


{
 *  AHRegisterHelpBook()
 *  
 *  Discussion:
 *    Registers a book of Help content such that the book will appear
 *    in the current user's main table of contents (Help Center) in the
 *    Help Viewer application. To be used when help books reside
 *    outside of the known help folders (i.e. help books that are kept
 *    inside of application bundles).
 *  
 *  Parameters:
 *    
 *    appBundleRef:
 *      An FSRef pointer to the bundle within which one or more Help
 *      books is stored. This is likely an FSRef to your application's
 *      main bundle.
 *  
 *  Result:
 *    An operating system result code that indicates whether all help
 *    books contained within the specified bundle were registered.
 *    Possible values: noErr, paramErr, kAHInternalErr, dirNFErr.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AHRegisterHelpBook({CONST}VAR appBundleRef: FSRef): OSStatus; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AppleHelpIncludes}

{$ENDC} {__APPLEHELP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
