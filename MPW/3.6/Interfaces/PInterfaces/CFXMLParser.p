{
     File:       CFXMLParser.p
 
     Contains:   CoreFoundation XML parser
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CFXMLParser;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFXMLPARSER__}
{$SETC __CFXMLPARSER__ := 1}

{$I+}
{$SETC CFXMLParserIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}
{$IFC UNDEFINED __CFARRAY__}
{$I CFArray.p}
{$ENDC}
{$IFC UNDEFINED __CFDATA__}
{$I CFData.p}
{$ENDC}
{$IFC UNDEFINED __CFDICTIONARY__}
{$I CFDictionary.p}
{$ENDC}
{$IFC UNDEFINED __CFTREE__}
{$I CFTree.p}
{$ENDC}
{$IFC UNDEFINED __CFURL__}
{$I CFURL.p}
{$ENDC}
{$IFC UNDEFINED __CFXMLNODE__}
{$I CFXMLNode.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CFXMLParserRef    = ^LONGINT; { an opaque 32-bit type }
	CFXMLParserRefPtr = ^CFXMLParserRef;  { when a VAR xx:CFXMLParserRef parameter can be nil, it is changed to xx: CFXMLParserRefPtr }
	{	 These are the various options you can configure the parser with.  These are
	   chosen such that an option flag of 0 (kCFXMLParserNoOptions) leaves the XML
	   as "intact" as possible (reports all structures; performs no replacements).
	   Hence, to make the parser do the most work, returning only the pure element
	   tree, set the option flag to kCFXMLParserAllOptions.
	
	kCFXMLParserValidateDocument -
	   validate the document against its grammar from the DTD, reporting any errors.
	   Currently not supported.
	
	kCFXMLParserSkipMetaData -
	   silently skip over metadata constructs (the DTD and comments)
	
	kCFXMLParserReplacePhysicalEntities -
	   replace declared entities like &lt;.  Note that other than the 5 predefined
	   entities (lt, gt, quot, amp, apos), these must be defined in the DTD.
	   Currently not supported.
	
	kCFXMLParserSkipWhitespace -
	   skip over all whitespace that does not abut non-whitespace character data.
	   In other words, given <foo>  <bar> blah </bar></foo>, the whitespace between
	   foo's open tag and bar's open tag would be suppressed, but the whitespace
	   around blah would be preserved.
	
	kCFXMLParserAddImpliedAttributes -
	   where the DTD specifies implied attribute-value pairs for a particular element,
	   add those pairs to any occurances of the element in the element tree.
	   Currently not supported.
		}
	CFXMLParserOptions 			= SInt32;
CONST
	kCFXMLParserValidateDocument = $01;
	kCFXMLParserSkipMetaData	= $02;
	kCFXMLParserReplacePhysicalEntities = $04;
	kCFXMLParserSkipWhitespace	= $08;
	kCFXMLParserResolveExternalEntities = $10;
	kCFXMLParserAddImpliedAttributes = $20;
	kCFXMLParserAllOptions		= $00FFFFFF;
	kCFXMLParserNoOptions		= 0;

	{	 This list is expected to grow 	}

TYPE
	CFXMLParserStatusCode 		= SInt32;
CONST
	kCFXMLStatusParseNotBegun	= -2;
	kCFXMLStatusParseInProgress	= -1;
	kCFXMLStatusParseSuccessful	= 0;
	kCFXMLErrorUnexpectedEOF	= 1;
	kCFXMLErrorUnknownEncoding	= 2;
	kCFXMLErrorEncodingConversionFailure = 3;
	kCFXMLErrorMalformedProcessingInstruction = 4;
	kCFXMLErrorMalformedDTD		= 5;
	kCFXMLErrorMalformedName	= 6;
	kCFXMLErrorMalformedCDSect	= 7;
	kCFXMLErrorMalformedCloseTag = 8;
	kCFXMLErrorMalformedStartTag = 9;
	kCFXMLErrorMalformedDocument = 10;
	kCFXMLErrorElementlessDocument = 11;
	kCFXMLErrorMalformedComment	= 12;
	kCFXMLErrorMalformedCharacterReference = 13;
	kCFXMLErrorMalformedParsedCharacterData = 14;
	kCFXMLErrorNoData			= 15;

	{	  These functions are called as a parse progresses.
	
	createXMLStructure -
	  called as new XML structures are encountered by the parser.  May return NULL to indicate
	  that the given structure should be skipped; if NULL is returned for a given structure,
	  only minimal parsing is done for that structure (enough to correctly determine its end,
	  and to extract any data necessary for the remainder of the parse, such as Entity definitions).
	  createXMLStructure (or indeed, any of the tree-creation callbacks) will not be called for any
	  children of the skipped structure.  The only exception is that the top-most element will always
	  be reported even if NULL was returned for the document as a whole.  NOTE: for performance reasons,
	  the node passed to createXMLStructure cannot be safely retained by the client; the node as
	  a whole must be copied (via CFXMLNodeCreateCopy), or its contents must be extracted and copied.
	
	addChild -
	  called as children are parsed and are ready to be added to the tree.  If createXMLStructure
	  returns NULL for a given structure, that structure is omitted entirely, and addChild will
	  NOT be called for either a NULL child or parent.
	
	endXMLStructure -
	  called once a structure (and all its children) are completely parsed.  As elements are encountered,
	  createXMLStructure is called for them first, then addChild to add the new structure to its parent,
	  then addChild (potentially several times) to add the new structure's children to it, then finally
	  endXMLStructure to show that the structure has been fully parsed.
	
	createXMLStructure, addChild, and endXMLStructure are all REQUIRED TO BE NON-NULL.
	
	resolveExternalEntity -
	  called when external entities are referenced (NOT when they are simply defined).  If the function
	  pointer is NULL, the parser uses its internal routines to try and resolve the entity.  If the
	  function pointer is set, and the function returns NULL, a place holder for the external entity
	  is inserted into the tree.  In this manner, the parser's client can prevent any external network
	  or file accesses.
	
	handleError - called as errors/warnings are encountered in the data stream.  At some point, we will
	  have an enum of the expected errors, some of which will be fatal, others of which will not.  If
	  the function pointer is NULL, the parser will silently attempt to recover.  The
	  handleError function may always return FALSE to force the parser to stop; if handleError returns
	  TRUE, the parser will attempt to recover (fatal errors will still cause the parse to abort
	  immediately).
		}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	CFXMLParserCreateXMLStructureCallBack = FUNCTION(parser: CFXMLParserRef; nodeDesc: CFXMLNodeRef; info: UNIV Ptr): Ptr; C;
{$ELSEC}
	CFXMLParserCreateXMLStructureCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFXMLParserAddChildCallBack = PROCEDURE(parser: CFXMLParserRef; parent: UNIV Ptr; child: UNIV Ptr; info: UNIV Ptr); C;
{$ELSEC}
	CFXMLParserAddChildCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFXMLParserEndXMLStructureCallBack = PROCEDURE(parser: CFXMLParserRef; xmlType: UNIV Ptr; info: UNIV Ptr); C;
{$ELSEC}
	CFXMLParserEndXMLStructureCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFXMLParserResolveExternalEntityCallBack = FUNCTION(parser: CFXMLParserRef; VAR extID: CFXMLExternalID; info: UNIV Ptr): CFDataRef; C;
{$ELSEC}
	CFXMLParserResolveExternalEntityCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFXMLParserHandleErrorCallBack = FUNCTION(parser: CFXMLParserRef; error: CFXMLParserStatusCode; info: UNIV Ptr): BOOLEAN; C;
{$ELSEC}
	CFXMLParserHandleErrorCallBack = ProcPtr;
{$ENDC}

	CFXMLParserCallBacksPtr = ^CFXMLParserCallBacks;
	CFXMLParserCallBacks = RECORD
		version:				CFIndex;
		createXMLStructure:		CFXMLParserCreateXMLStructureCallBack;
		addChild:				CFXMLParserAddChildCallBack;
		endXMLStructure:		CFXMLParserEndXMLStructureCallBack;
		resolveExternalEntity:	CFXMLParserResolveExternalEntityCallBack;
		handleError:			CFXMLParserHandleErrorCallBack;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	CFXMLParserRetainCallBack = FUNCTION(info: UNIV Ptr): Ptr; C;
{$ELSEC}
	CFXMLParserRetainCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFXMLParserReleaseCallBack = PROCEDURE(info: UNIV Ptr); C;
{$ELSEC}
	CFXMLParserReleaseCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFXMLParserCopyDescriptionCallBack = FUNCTION(info: UNIV Ptr): CFStringRef; C;
{$ELSEC}
	CFXMLParserCopyDescriptionCallBack = ProcPtr;
{$ENDC}

	CFXMLParserContextPtr = ^CFXMLParserContext;
	CFXMLParserContext = RECORD
		version:				CFIndex;
		info:					Ptr;
		retain:					CFXMLParserRetainCallBack;
		release:				CFXMLParserReleaseCallBack;
		copyDescription:		CFXMLParserCopyDescriptionCallBack;
	END;

	{
	 *  CFXMLParserGetTypeID()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.3 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CFXMLParserGetTypeID: CFTypeID; C;

{ Creates a parser which will parse the given data with the given options.  xmlData may not be NULL.
   dataSource should be the URL from which the data came, and may be NULL; it is used to resolve any
   relative references found in xmlData. versionOfNodes determines which version CFXMLNodes are produced
   by the parser; see CFXMLNode.h for more details.  callBacks are the callbacks called by the parser as
   the parse progresses; callBacks, callBacks->createXMLStructure, callBacks->addChild, and
   callBacks->endXMLStructure must all be non-NULL.  context determines what if any info pointer is
   passed to the callbacks as the parse progresses; context may be NULL.  }
{
 *  CFXMLParserCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFXMLParserCreate(allocator: CFAllocatorRef; xmlData: CFDataRef; dataSource: CFURLRef; parseOptions: CFOptionFlags; versionOfNodes: CFIndex; VAR callBacks: CFXMLParserCallBacks; VAR context: CFXMLParserContext): CFXMLParserRef; C;

{ Arguments as above, except that the data to be parsed is loaded directly
   from dataSource.  dataSource may not be NULL.  }
{
 *  CFXMLParserCreateWithDataFromURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFXMLParserCreateWithDataFromURL(allocator: CFAllocatorRef; dataSource: CFURLRef; parseOptions: CFOptionFlags; versionOfNodes: CFIndex; VAR callBacks: CFXMLParserCallBacks; VAR context: CFXMLParserContext): CFXMLParserRef; C;

{
 *  CFXMLParserGetContext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFXMLParserGetContext(parser: CFXMLParserRef; VAR context: CFXMLParserContext); C;

{
 *  CFXMLParserGetCallBacks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFXMLParserGetCallBacks(parser: CFXMLParserRef; VAR callBacks: CFXMLParserCallBacks); C;

{
 *  CFXMLParserGetSourceURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFXMLParserGetSourceURL(parser: CFXMLParserRef): CFURLRef; C;

{ Returns the character index of the current parse location }
{
 *  CFXMLParserGetLocation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFXMLParserGetLocation(parser: CFXMLParserRef): CFIndex; C;

{ Returns the line number of the current parse location }
{
 *  CFXMLParserGetLineNumber()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFXMLParserGetLineNumber(parser: CFXMLParserRef): CFIndex; C;

{ Returns the top-most object returned by the createXMLStructure callback }
{
 *  CFXMLParserGetDocument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFXMLParserGetDocument(parser: CFXMLParserRef): Ptr; C;

{ Get the status code or a user-readable description of the last error that occurred in a parse.
   If no error has occurred, a null description string is returned.  See the enum above for
   possible status returns }
{
 *  CFXMLParserGetStatusCode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFXMLParserGetStatusCode(parser: CFXMLParserRef): CFXMLParserStatusCode; C;

{
 *  CFXMLParserCopyErrorDescription()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFXMLParserCopyErrorDescription(parser: CFXMLParserRef): CFStringRef; C;

{ Cause any in-progress parse to abort with the given error code and description.  errorCode
   must be positive, and errorDescription may not be NULL.  Cannot be called asynchronously
   (i.e. must be called from within a parser callback) }
{
 *  CFXMLParserAbort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFXMLParserAbort(parser: CFXMLParserRef; errorCode: CFXMLParserStatusCode; errorDescription: CFStringRef); C;

{ Starts a parse of the data the parser was created with; returns success or failure.
   Upon success, use CFXMLParserGetDocument() to get the product of the parse.  Upon
   failure, use CFXMLParserGetErrorCode() or CFXMLParserCopyErrorDescription() to get
   information about the error.  It is an error to call CFXMLParserParse() while a
   parse is already underway. }
{
 *  CFXMLParserParse()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFXMLParserParse(parser: CFXMLParserRef): BOOLEAN; C;

{ These functions provide a higher-level interface.  The XML data is parsed to a
   special CFTree (an CFXMLTree) with known contexts and callbacks.  See CFXMLNode.h
   for full details on using an CFXMLTree and the CFXMLNodes contained therein.
}
{ Parse to an CFXMLTreeRef.  parseOptions are as above. versionOfNodes determines
   what version CFXMLNodes are used to populate the tree.  }
{
 *  CFXMLTreeCreateFromData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFXMLTreeCreateFromData(allocator: CFAllocatorRef; xmlData: CFDataRef; dataSource: CFURLRef; parseOptions: CFOptionFlags; versionOfNodes: CFIndex): CFXMLTreeRef; C;

{ Loads the data to be parsed directly from dataSource.  Arguments as above. }
{
 *  CFXMLTreeCreateWithDataFromURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFXMLTreeCreateWithDataFromURL(allocator: CFAllocatorRef; dataSource: CFURLRef; parseOptions: CFOptionFlags; versionOfNodes: CFIndex): CFXMLTreeRef; C;

{ Generate the XMLData (ready to be written to whatever permanent storage is to be
   used) from an CFXMLTree.  Will NOT regenerate entity references (except those
   required for syntactic correctness) if they were replaced at the parse time;
   clients that wish this should walk the tree and re-insert any entity references
   that should appear in the final output file. }
{
 *  CFXMLTreeCreateXMLData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFXMLTreeCreateXMLData(allocator: CFAllocatorRef; xmlTree: CFXMLTreeRef): CFDataRef; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFXMLParserIncludes}

{$ENDC} {__CFXMLPARSER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
