{
 	File:		AEUserTermTypes.p
 
 	Contains:	AppleEvents AEUT resource format Interfaces.
 
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
 UNIT AEUserTermTypes;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __AEUSERTERMTYPES__}
{$SETC __AEUSERTERMTYPES__ := 1}

{$I+}
{$SETC AEUserTermTypesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	kAEUserTerminology			= 'aeut';						{  0x61657574  }
	kAETerminologyExtension		= 'aete';						{  0x61657465  }
	kAEScriptingSizeResource	= 'scsz';

	kAEUTHasReturningParam		= 31;							{ if event has a keyASReturning param }
	kAEUTOptional				= 15;							{ if something is optional }
	kAEUTlistOfItems			= 14;							{ if property or reply is a list. }
	kAEUTEnumerated				= 13;							{ if property or reply is of an enumerated type. }
	kAEUTReadWrite				= 12;							{ if property is writable. }
	kAEUTChangesState			= 12;							{ if an event changes state. }
	kAEUTTightBindingFunction	= 12;							{ if this is a tight-binding precedence function. }
	kAEUTApostrophe				= 3;							{ if a term contains an apostrophe. }
	kAEUTFeminine				= 2;							{ if a term is feminine gender. }
	kAEUTMasculine				= 1;							{ if a term is masculine gender. }
	kAEUTPlural					= 0;							{ if a term is plural. }


TYPE
	TScriptingSizeResource = RECORD
		scriptingSizeFlags:		INTEGER;
		minStackSize:			LONGINT;
		preferredStackSize:		LONGINT;
		maxStackSize:			LONGINT;
		minHeapSize:			LONGINT;
		preferredHeapSize:		LONGINT;
		maxHeapSize:			LONGINT;
	END;


CONST
{	If kLaunchToGetTerminology is 0, 'aete' is read directly from res file.  If set
		to 1, then launch and use 'gdut' to get terminology. }
	kLaunchToGetTerminology		= 0+(1 * (2**(15)));
{	If kDontFindAppBySignature is 0, then find app with signature if lost.  If 1, 
		then don't }
	kDontFindAppBySignature		= 0+(1 * (2**(14)));
{ 	If kAlwaysSendSubject 0, then send subject when appropriate. If 1, then every 
		event has Subject Attribute }
	kAlwaysSendSubject			= 0+(1 * (2**(13)));

{ old names for above bits. }
	kReadExtensionTermsMask		= 0+(1 * (2**(15)));


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AEUserTermTypesIncludes}

{$ENDC} {__AEUSERTERMTYPES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
