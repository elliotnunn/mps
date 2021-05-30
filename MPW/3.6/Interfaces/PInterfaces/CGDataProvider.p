{
     File:       CGDataProvider.p
 
     Contains:   xxx put contents here xxx
 
     Version:    Technology: from CoreGraphics-70.root
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
 UNIT CGDataProvider;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CGDATAPROVIDER__}
{$SETC __CGDATAPROVIDER__ := 1}

{$I+}
{$SETC CGDataProviderIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CGBASE__}
{$I CGBase.p}
{$ENDC}
{$IFC UNDEFINED __CFURL__}
{$I CFURL.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CGDataProviderRef    = ^LONGINT; { an opaque 32-bit type }
	CGDataProviderRefPtr = ^CGDataProviderRef;  { when a VAR xx:CGDataProviderRef parameter can be nil, it is changed to xx: CGDataProviderRefPtr }
{$IFC TYPED_FUNCTION_POINTERS}
	CGGetBytesProcPtr = FUNCTION(info: UNIV Ptr; buffer: UNIV Ptr; count: size_t): size_t; C;
{$ELSEC}
	CGGetBytesProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CGSkipBytesProcPtr = PROCEDURE(info: UNIV Ptr; count: size_t); C;
{$ELSEC}
	CGSkipBytesProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CGRewindProcPtr = PROCEDURE(info: UNIV Ptr); C;
{$ELSEC}
	CGRewindProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CGReleaseProviderProcPtr = PROCEDURE(info: UNIV Ptr); C;
{$ELSEC}
	CGReleaseProviderProcPtr = ProcPtr;
{$ENDC}

	{	 Callbacks for sequentially accessing data.
	 * `getBytes' is called to copy `count' bytes from the provider's data to
	 * `buffer'.  It should return the number of bytes copied, or 0 if there's
	 * no more data.
	 * `skipBytes' is called to skip ahead in the provider's data by `count' bytes.
	 * `rewind' is called to rewind the provider to the beginning of the data.
	 * `releaseProvider', if non-NULL, is called when the provider is freed. 	}
	CGDataProviderCallbacksPtr = ^CGDataProviderCallbacks;
	CGDataProviderCallbacks = RECORD
		getBytes:				CGGetBytesProcPtr;
		skipBytes:				CGSkipBytesProcPtr;
		rewind:					CGRewindProcPtr;
		releaseProvider:		CGReleaseProviderProcPtr;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	CGGetBytePointerProcPtr = FUNCTION(info: UNIV Ptr): Ptr; C;
{$ELSEC}
	CGGetBytePointerProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CGReleaseByteProcPtr = PROCEDURE(info: UNIV Ptr; pointer: UNIV Ptr); C;
{$ELSEC}
	CGReleaseByteProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CGGetBytesDirectProcPtr = FUNCTION(info: UNIV Ptr; buffer: UNIV Ptr; offset: size_t; count: size_t): size_t; C;
{$ELSEC}
	CGGetBytesDirectProcPtr = ProcPtr;
{$ENDC}

	{	 Callbacks for directly accessing data.
	 * `getBytePointer', if non-NULL, is called to return a pointer to the
	 * provider's entire block of data.
	 * `releaseBytePointer', if non-NULL, is called to release a pointer to
	 * the provider's entire block of data.
	 * `getBytes', if non-NULL, is called to copy `count' bytes at offset
	 * `offset' from the provider's data to `buffer'.  It should return the
	 * number of bytes copied, or 0 if there's no more data.
	 * `releaseProvider', if non-NULL, is called when the provider is freed.
	 * At least one of `getBytePointer' or `getBytes' must be non-NULL.  	}
	CGDataProviderDirectAccessCallbacksPtr = ^CGDataProviderDirectAccessCallbacks;
	CGDataProviderDirectAccessCallbacks = RECORD
		getBytePointer:			CGGetBytePointerProcPtr;
		releaseBytePointer:		CGReleaseByteProcPtr;
		getBytes:				CGGetBytesDirectProcPtr;
		releaseProvider:		CGReleaseProviderProcPtr;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	CGReleaseDataProcPtr = PROCEDURE(info: UNIV Ptr; data: UNIV Ptr; size: size_t); C;
{$ELSEC}
	CGReleaseDataProcPtr = ProcPtr;
{$ENDC}

	{	 Create a sequential-access data provider using `callbacks' to provide
	 * the data.  `info' is passed to each of the callback functions. 	}
	{
	 *  CGDataProviderCreate()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CGDataProviderCreate(info: UNIV Ptr; {CONST}VAR callbacks: CGDataProviderCallbacks): CGDataProviderRef; C;

{ Create a direct-access data provider using `callbacks' to supply `size'
 * bytes of data. `info' is passed to each of the callback functions. }
{
 *  CGDataProviderCreateDirectAccess()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDataProviderCreateDirectAccess(info: UNIV Ptr; size: size_t; {CONST}VAR callbacks: CGDataProviderDirectAccessCallbacks): CGDataProviderRef; C;

{ Create a direct-access data provider using `data', an array of `size'
 * bytes.  `releaseData' is called when the data provider is freed, and is
 * passed `info' as its first argument. }
{
 *  CGDataProviderCreateWithData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDataProviderCreateWithData(info: UNIV Ptr; data: UNIV Ptr; size: size_t; releaseData: CGReleaseDataProcPtr): CGDataProviderRef; C;

{ Create a data provider using `url'. }
{
 *  CGDataProviderCreateWithURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDataProviderCreateWithURL(url: CFURLRef): CGDataProviderRef; C;

{ Increment the retain count of `provider' and return it.  All data
 * providers are created with an initial retain count of 1. }
{
 *  CGDataProviderRetain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDataProviderRetain(provider: CGDataProviderRef): CGDataProviderRef; C;

{ Decrement the retain count of `provider'.  If the retain count reaches
 * 0, then free `provider' and any associated resources. }
{
 *  CGDataProviderRelease()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CGDataProviderRelease(provider: CGDataProviderRef); C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CGDataProviderIncludes}

{$ENDC} {__CGDATAPROVIDER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
