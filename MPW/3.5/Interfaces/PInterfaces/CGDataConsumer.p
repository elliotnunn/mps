{
     File:       CGDataConsumer.p
 
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
 UNIT CGDataConsumer;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CGDATACONSUMER__}
{$SETC __CGDATACONSUMER__ := 1}

{$I+}
{$SETC CGDataConsumerIncludes := UsingIncludes}
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
	CGDataConsumerRef    = ^LONGINT; { an opaque 32-bit type }
	CGDataConsumerRefPtr = ^CGDataConsumerRef;  { when a VAR xx:CGDataConsumerRef parameter can be nil, it is changed to xx: CGDataConsumerRefPtr }
{$IFC TYPED_FUNCTION_POINTERS}
	CGPutBytesProcPtr = FUNCTION(info: UNIV Ptr; buffer: UNIV Ptr; count: size_t): size_t; C;
{$ELSEC}
	CGPutBytesProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CGReleaseConsumerProcPtr = PROCEDURE(info: UNIV Ptr); C;
{$ELSEC}
	CGReleaseConsumerProcPtr = ProcPtr;
{$ENDC}

	{	 Callbacks for accessing data.
	 * `putBytes' copies `count' bytes from `buffer' to the consumer, and
	 * returns the number of bytes copied.  It should return 0 if no more data
	 * can be written to the consumer.
	 * `releaseConsumer', if non-NULL, is called when the consumer is freed. 	}
	CGDataConsumerCallbacksPtr = ^CGDataConsumerCallbacks;
	CGDataConsumerCallbacks = RECORD
		putBytes:				CGPutBytesProcPtr;
		releaseConsumer:		CGReleaseConsumerProcPtr;
	END;

	{	 Create a data consumer using `callbacks' to handle the data.  `info' is
	 * passed to each of the callback functions. 	}
	{
	 *  CGDataConsumerCreate()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CGDataConsumerCreate(info: UNIV Ptr; {CONST}VAR callbacks: CGDataConsumerCallbacks): CGDataConsumerRef; C;

{ Create a data consumer which writes data to `url'. }
{
 *  CGDataConsumerCreateWithURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDataConsumerCreateWithURL(url: CFURLRef): CGDataConsumerRef; C;

{ Increment the retain count of `consumer' and return it.  All data
 * consumers are created with an initial retain count of 1. }
{
 *  CGDataConsumerRetain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDataConsumerRetain(consumer: CGDataConsumerRef): CGDataConsumerRef; C;

{ Decrement the retain count of `consumer'.  If the retain count reaches
 * 0, then release it and any associated resources. }
{
 *  CGDataConsumerRelease()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CGDataConsumerRelease(consumer: CGDataConsumerRef); C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CGDataConsumerIncludes}

{$ENDC} {__CGDATACONSUMER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
