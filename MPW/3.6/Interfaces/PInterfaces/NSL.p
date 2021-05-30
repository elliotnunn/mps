{
     File:       NSL.p
 
     Contains:   Interface to API for using the NSL User Interface
 
     Version:    Technology: Mac OS X
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
 UNIT NSL;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __NSL__}
{$SETC __NSL__ := 1}

{$I+}
{$SETC NSLIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __NSLCORE__}
{$I NSLCore.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}



TYPE
	NSLDialogOptionFlags 		= UInt32;
CONST
	kNSLDefaultNSLDlogOptions	= $00000000;					{  use defaults for all the options  }
	kNSLNoURLTEField			= $00000001;					{  don't show url text field for manual entry  }
	kNSLAddServiceTypes			= $00000002;					{  add the service type if a user enters an incomplete URL  }
	kNSLClientHandlesRecents	= $00000004;					{  Stops NSLStandardGetURL from adding the selection to the recent items folder  }


TYPE
	NSLDialogOptionsPtr = ^NSLDialogOptions;
	NSLDialogOptions = RECORD
		version:				UInt16;
		dialogOptionFlags:		NSLDialogOptionFlags;					{  option flags for affecting the dialog's behavior  }
		windowTitle:			Str255;
		actionButtonLabel:		Str255;									{  label of the default button (or null string for default)  }
		cancelButtonLabel:		Str255;									{  label of the cancel button (or null string for default)  }
		message:				Str255;									{  custom message prompt (or null string for default)  }
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	NSLURLFilterProcPtr = FUNCTION(url: CStringPtr; VAR displayString: Str255): BOOLEAN;
{$ELSEC}
	NSLURLFilterProcPtr = ProcPtr;
{$ENDC}

	{  you can provide for calls to NSLStandardGetURL }
{$IFC TYPED_FUNCTION_POINTERS}
	NSLEventProcPtr = PROCEDURE(VAR newEvent: EventRecord; userContext: UNIV Ptr);
{$ELSEC}
	NSLEventProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	NSLURLFilterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	NSLURLFilterUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	NSLEventUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	NSLEventUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppNSLURLFilterProcInfo = $000003D0;
	uppNSLEventProcInfo = $000003C0;
	{
	 *  NewNSLURLFilterUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewNSLURLFilterUPP(userRoutine: NSLURLFilterProcPtr): NSLURLFilterUPP; { old name was NewNSLURLFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewNSLEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewNSLEventUPP(userRoutine: NSLEventProcPtr): NSLEventUPP; { old name was NewNSLEventProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeNSLURLFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeNSLURLFilterUPP(userUPP: NSLURLFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeNSLEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeNSLEventUPP(userUPP: NSLEventUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeNSLURLFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeNSLURLFilterUPP(url: CStringPtr; VAR displayString: Str255; userRoutine: NSLURLFilterUPP): BOOLEAN; { old name was CallNSLURLFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeNSLEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeNSLEventUPP(VAR newEvent: EventRecord; userContext: UNIV Ptr; userRoutine: NSLEventUPP); { old name was CallNSLEventProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{ <--- function returns OSStatus of the operation.  noErr will be returned if valid, kNSLUserCanceled will be returned if the user cancels }
{ ---> dialogOptions }
{ ---> eventProc }
{ ---> eventProcContextPtr }
{ ---> filterProc }
{ ---> serviceTypeList }
{ <--- userSelectedURL }
{ NSLDialogOptions* dialogOptions }
{
   dialogOptions is a user defined structure defining the look, feel and operation of NSLStandardGetURL dialog
   default behavior can be achieved by passing in a pointer to a structure that has been filled out by a previous
   call to NSLGetDefaultDialogOptions or by passing in NULL.
}
{ NSLEventUPP eventProc }
{
   the eventProc is a callback NSLURLFilterUPP that will
   get called with Events that the dialog doesn't handle.  If you pass in nil,
   you won't get update events while the NSLStandardGetURL dialog is open.
}
{ void* eventProcContextPtr }
{  you can provide a pointer to some contextual data that you want to have sent to your eventProc filter }
{ NSLURLFilterProcPtr filterProc }
{
   the filter param is a callback NSLURLFilterUPP that
   will get called (if not nil) for each url that is going to be displayed in
   the dialog's result list.  A result of false will not include the url for the
   user to select from.  You also have the option of handling the way the url looks
   in the dialog listing by copying the preferred name into the displayString
   parameter.  (If left alone, NSLStandardGetURL dialog will strip the service type
   portion off the url).
}
{ char* serviceTypeList }
{
   the serviceTypeList parameter is a null terminated string that will 
   directly affect the contents of the services popup in the dialog.
   The structure of this string is a set of tuples as follows:
   Name of ServiceType as to be represented in the popup followed by
   a comma delimted list of service descriptors (ie http,https) that will
   used in the search of that type.  Each comma delimited tuple is delimited
   by semi-colons.
}
{
   For example:
   If you want to search for services of type http (web), https (secure web),
   and ftp, you could pass in the string "Web Servers,http,https;FTP Servers,ftp".
   This would result in a popup list with two items ("Web Servers" and "FTP Servers")
   and searches performed on them will provide results of type http and https for the
   first, and ftp for the second.
}

{
   Results list Icons:
   NSLStandardGetURL provides icons in its listings for the following types:
   "http", "https", "ftp", "afp", "lpr", "LaserWriter", "AFPServer"
   any other types will get a generic icon.  However, you can provide icons
   if you wish by including an '#ics8' resource id at the end of your comma
   delimited list.  The dialog will then use that icon if found in its results
   list.  This icon will be used for all types in a tuple.
   For example:
   The param "Web Servers,http,https;Telnet Servers,telnet;NFS Servers,nfs,129"
   would result in lists of http and https services to be shown with their default
   icons, telnet servers would be shown with the default misc. icon and nfs
   servers would be shown with your icon at resource id 129.
}

{ char** url }
{
   pass in the address of a char* and it will point to the resulting url.  If the user
   cancels (the function returns false), the pointer will be set to nil.  If the function
   returns true (user selected a url), then you must call NSLFreeURL on the pointer when
   you are done with it.
}
{
   Call this to have the user select a url based service from a dialog.
   Function takes on input an optional filter proc, a serviceTypeList, and an address to a Ptr.
   Function sets the value of the Ptr to a newly created c-style null terminated string
   containing the user's choice of URL.
}

{
 *  NSLStandardGetURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NSLPPCLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NSLStandardGetURL(dialogOptions: NSLDialogOptionsPtr; eventProc: NSLEventUPP; eventProcContextPtr: UNIV Ptr; filterProc: NSLURLFilterUPP; serviceTypeList: CStringPtr; VAR userSelectedURL: CStringPtr): OSStatus;

{
 *  NSLGetDefaultDialogOptions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NSLPPCLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NSLGetDefaultDialogOptions(VAR dialogOptions: NSLDialogOptions): OSStatus;

{ <--- function returns null (useful for setting variable at same time as freeing it }
{ ---> url is memory created by a call to NSLStandardGetURL }
{
 *  NSLFreeURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NSLPPCLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NSLFreeURL(url: CStringPtr): CStringPtr;

{ <--- function returns kNSLErrNullPtrError, file mgr errors, or resource mgr errors }
{ ---> folderSelectorType is one of the well-known folders defined in Folders.h }
{ ---> url is any valid url }
{ ---> userFriendlyName is used for the file name and the display name (in the UI) }
{
 *  NSLSaveURLAliasToFolder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NSLPPCLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NSLSaveURLAliasToFolder(folderSelectorType: OSType; url: ConstCStringPtr; userFriendlyName: ConstCStringPtr): OSErr;



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := NSLIncludes}

{$ENDC} {__NSL__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
