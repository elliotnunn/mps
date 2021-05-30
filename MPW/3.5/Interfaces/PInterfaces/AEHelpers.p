{
     File:       AEHelpers.p
 
     Contains:   AEPrint, AEBuild and AEStream for Carbon
 
     Version:    Technology: Mac OS X, CarbonLib
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{
 * Originally from AEGIzmos by Jens Alfke, circa 1992.
 }
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT AEHelpers;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __AEHELPERS__}
{$SETC __AEHELPERS__ := 1}

{$I+}
{$SETC AEHelpersIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED __AEDATAMODEL__}
{$I AEDataModel.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
 * AEBuild is only available for C programmers.
 }
{
 * AEPrintDescToHandle
 *
 * AEPrintDescToHandle provides a way to turn an AEDesc into a textual
 * representation.  This is most useful for debugging calls to
 * AEBuildDesc and friends.  The Handle returned should be disposed by
 * the caller.  The size of the handle is the actual number of
 * characters in the string.
 }
{
 *  AEPrintDescToHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEPrintDescToHandle({CONST}VAR desc: AEDesc; VAR result: Handle): OSStatus; C;

{
 * AEStream:
 *
 * The AEStream interface allows you to build AppleEvents by appending
 * to an opaque structure (an AEStreamRef) and then turning this
 * structure into an AppleEvent.  The basic idea is to open the
 * stream, write data, and then close it - closing it produces an
 * AEDesc, which may be partially complete, or may be a complete
 * AppleEvent.
 }

TYPE
	AEStreamRef    = ^LONGINT; { an opaque 32-bit type }
	AEStreamRefPtr = ^AEStreamRef;  { when a VAR xx:AEStreamRef parameter can be nil, it is changed to xx: AEStreamRefPtr }
	{
	   Create and return an AEStreamRef
	   Returns NULL on memory allocation failure
	}
	{
	 *  AEStreamOpen()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION AEStreamOpen: AEStreamRef; C;

{
   Closes and disposes of an AEStreamRef, producing
   results in the desc.  You must dispose of the desc yourself.
   If you just want to dispose of the AEStreamRef, you can pass NULL for desc.
}
{
 *  AEStreamClose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEStreamClose(ref: AEStreamRef; VAR desc: AEDesc): OSStatus; C;

{
   Prepares an AEStreamRef for appending data to a newly created desc.
   You append data with AEStreamWriteData
}
{
 *  AEStreamOpenDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEStreamOpenDesc(ref: AEStreamRef; newType: DescType): OSStatus; C;

{  Append data to the previously opened desc. }
{
 *  AEStreamWriteData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEStreamWriteData(ref: AEStreamRef; data: UNIV Ptr; length: Size): OSStatus; C;

{
   Finish a desc.  After this, you can close the stream, or adding new
   descs, if you're assembling a list.
}
{
 *  AEStreamCloseDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEStreamCloseDesc(ref: AEStreamRef): OSStatus; C;

{  Write data as a desc to the stream }
{
 *  AEStreamWriteDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEStreamWriteDesc(ref: AEStreamRef; newType: DescType; data: UNIV Ptr; length: Size): OSStatus; C;

{  Write an entire desc to the stream }
{
 *  AEStreamWriteAEDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEStreamWriteAEDesc(ref: AEStreamRef; {CONST}VAR desc: AEDesc): OSStatus; C;

{
   Begin a list.  You can then append to the list by doing
   AEStreamOpenDesc, or AEStreamWriteDesc.
}
{
 *  AEStreamOpenList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEStreamOpenList(ref: AEStreamRef): OSStatus; C;

{  Finish a list. }
{
 *  AEStreamCloseList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEStreamCloseList(ref: AEStreamRef): OSStatus; C;

{
   Begin a record.  A record usually has type 'reco', however, this is
   rather generic, and frequently a different type is used.
}
{
 *  AEStreamOpenRecord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEStreamOpenRecord(ref: AEStreamRef; newType: DescType): OSStatus; C;

{  Change the type of a record. }
{
 *  AEStreamSetRecordType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEStreamSetRecordType(ref: AEStreamRef; newType: DescType): OSStatus; C;

{  Finish a record }
{
 *  AEStreamCloseRecord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEStreamCloseRecord(ref: AEStreamRef): OSStatus; C;

{
   Add a keyed descriptor to a record.  This is analogous to AEPutParamDesc.
   it can only be used when writing to a record.
}
{
 *  AEStreamWriteKeyDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEStreamWriteKeyDesc(ref: AEStreamRef; key: AEKeyword; newType: DescType; data: UNIV Ptr; length: Size): OSStatus; C;

{
   OpenDesc for a keyed record entry.  You can youse AEStreamWriteData
   after opening a keyed desc.
}
{
 *  AEStreamOpenKeyDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEStreamOpenKeyDesc(ref: AEStreamRef; key: AEKeyword; newType: DescType): OSStatus; C;

{  Write a key to the stream - you can follow this with an AEWriteDesc. }
{
 *  AEStreamWriteKey()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEStreamWriteKey(ref: AEStreamRef; key: AEKeyword): OSStatus; C;

{
   Create a complete AppleEvent.  This creates and returns a new stream.
   Use this call to populate the meta fields in an AppleEvent record.
   After this, you can add your records, lists and other parameters.
}
{
 *  AEStreamCreateEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEStreamCreateEvent(clazz: AEEventClass; id: AEEventID; targetType: DescType; targetData: UNIV Ptr; targetLength: LONGINT; returnID: INTEGER; transactionID: LONGINT): AEStreamRef; C;

{
   This call lets you augment an existing AppleEvent using the stream
   APIs.  This would be useful, for example, in constructing the reply
   record in an AppleEvent handler.  Note that AEStreamOpenEvent will
   consume the AppleEvent passed in - you can't access it again until the
   stream is closed.  When you're done building the event, AEStreamCloseStream
    will reconstitute it.
}
{
 *  AEStreamOpenEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEStreamOpenEvent(VAR event: AppleEvent): AEStreamRef; C;

{  Mark a keyword as being an optional parameter. }
{
 *  AEStreamOptionalParam()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEStreamOptionalParam(ref: AEStreamRef; key: AEKeyword): OSStatus; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AEHelpersIncludes}

{$ENDC} {__AEHELPERS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
