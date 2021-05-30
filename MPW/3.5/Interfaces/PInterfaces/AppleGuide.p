{
     File:       AppleGuide.p
 
     Contains:   Apple Guide Interfaces.
 
     Version:    Technology: Mac OS 8
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT AppleGuide;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __APPLEGUIDE__}
{$SETC __APPLEGUIDE__ := 1}

{$I+}
{$SETC AppleGuideIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{  Types }

TYPE
	AGRefNum							= UInt32;
	AGCoachRefNum						= UInt32;
	AGContextRefNum						= UInt32;
	AGAppInfoPtr = ^AGAppInfo;
	AGAppInfo = RECORD
		eventId:				AEEventID;
		refCon:					LONGINT;
		contextObj:				Ptr;									{  private system field }
	END;

	AGAppInfoHdl						= ^AGAppInfoPtr;
{$IFC TYPED_FUNCTION_POINTERS}
	CoachReplyProcPtr = FUNCTION(VAR pRect: Rect; name: Ptr; refCon: LONGINT): OSErr;
{$ELSEC}
	CoachReplyProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ContextReplyProcPtr = FUNCTION(pInputData: Ptr; inputDataSize: Size; VAR ppOutputData: Ptr; VAR pOutputDataSize: Size; hAppInfo: AGAppInfoHdl): OSErr;
{$ELSEC}
	ContextReplyProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	CoachReplyUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	CoachReplyUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ContextReplyUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ContextReplyUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppCoachReplyProcInfo = $00000FE0;
	uppContextReplyProcInfo = $0000FFE0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewCoachReplyUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewCoachReplyUPP(userRoutine: CoachReplyProcPtr): CoachReplyUPP; { old name was NewCoachReplyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewContextReplyUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewContextReplyUPP(userRoutine: ContextReplyProcPtr): ContextReplyUPP; { old name was NewContextReplyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeCoachReplyUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeCoachReplyUPP(userUPP: CoachReplyUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeContextReplyUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeContextReplyUPP(userUPP: ContextReplyUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeCoachReplyUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeCoachReplyUPP(VAR pRect: Rect; name: Ptr; refCon: LONGINT; userRoutine: CoachReplyUPP): OSErr; { old name was CallCoachReplyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeContextReplyUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeContextReplyUPP(pInputData: Ptr; inputDataSize: Size; VAR ppOutputData: Ptr; VAR pOutputDataSize: Size; hAppInfo: AGAppInfoHdl; userRoutine: ContextReplyUPP): OSErr; { old name was CallContextReplyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{  Constants }



CONST
	kAGDefault					= 0;
	kAGFrontDatabase			= 1;
	kAGNoMixin					= -1;


	kAGViewFullHowdy			= 1;							{  Full-size Howdy }
	kAGViewTopicAreas			= 2;							{  Full-size Topic Areas }
	kAGViewIndex				= 3;							{  Full-size Index Terms }
	kAGViewLookFor				= 4;							{  Full-size Look-For (Search) }
	kAGViewSingleHowdy			= 5;							{  Single-list-size Howdy }
	kAGViewSingleTopics			= 6;							{  Single-list-size Topics }


	kAGFileMain					= 'poco';
	kAGFileMixin				= 'mixn';

	{  To test against AGGetAvailableDBTypes }
	kAGDBTypeBitAny				= $00000001;
	kAGDBTypeBitHelp			= $00000002;
	kAGDBTypeBitTutorial		= $00000004;
	kAGDBTypeBitShortcuts		= $00000008;
	kAGDBTypeBitAbout			= $00000010;
	kAGDBTypeBitOther			= $00000080;



TYPE
	AGStatus							= UInt16;
	{  Returned by AGGetStatus }

CONST
	kAGIsNotRunning				= 0;
	kAGIsSleeping				= 1;
	kAGIsActive					= 2;

	{  Flags used in AGOpen, AGOpenWithSearch, AGOpenWithView }
	kHelpViewerSearchAll		= $01;


TYPE
	AGWindowKind						= UInt16;
	{  Returned by AGGetFrontWindowKind }

CONST
	kAGNoWindow					= 0;
	kAGAccessWindow				= 1;
	kAGPresentationWindow		= 2;

	{  Error Codes }

	{  Not an enum, because other OSErrs are valid. }

TYPE
	AGErr								= SInt16;
	{  Apple Guide error codes }

CONST
																{  -------------------- Apple event reply codes }
	kAGErrUnknownEvent			= -2900;
	kAGErrCantStartup			= -2901;
	kAGErrNoAccWin				= -2902;
	kAGErrNoPreWin				= -2903;
	kAGErrNoSequence			= -2904;
	kAGErrNotOopsSequence		= -2905;
	kAGErrReserved06			= -2906;
	kAGErrNoPanel				= -2907;
	kAGErrContentNotFound		= -2908;
	kAGErrMissingString			= -2909;
	kAGErrInfoNotAvail			= -2910;
	kAGErrEventNotAvailable		= -2911;
	kAGErrCannotMakeCoach		= -2912;
	kAGErrSessionIDsNotMatch	= -2913;
	kAGErrMissingDatabaseSpec	= -2914;
	kAGMissingSequenceMap		= -2915;						{  -------------------- Coach's Chalkboard reply codes }
	kAGErrItemNotFound			= -2925;
	kAGErrBalloonResourceNotFound = -2926;
	kAGErrChalkResourceNotFound	= -2927;
	kAGErrChdvResourceNotFound	= -2928;
	kAGErrAlreadyShowing		= -2929;
	kAGErrBalloonResourceSkip	= -2930;
	kAGErrItemNotVisible		= -2931;
	kAGErrReserved32			= -2932;
	kAGErrNotFrontProcess		= -2933;
	kAGErrMacroResourceNotFound	= -2934;						{  -------------------- API reply codes }
	kAGErrAppleGuideNotAvailable = -2951;
	kAGErrCannotInitCoach		= -2952;
	kAGErrCannotInitContext		= -2953;
	kAGErrCannotOpenAliasFile	= -2954;
	kAGErrNoAliasResource		= -2955;
	kAGErrDatabaseNotAvailable	= -2956;
	kAGErrDatabaseNotOpen		= -2957;
	kAGErrMissingAppInfoHdl		= -2958;
	kAGErrMissingContextObject	= -2959;
	kAGErrInvalidRefNum			= -2960;
	kAGErrDatabaseOpen			= -2961;
	kAGErrInsufficientMemory	= -2962;

	{  Events }

	{  Not an enum because we want to make assignments. }

TYPE
	AGEvent								= UInt32;
	{  Handy events for AGGeneral. }

CONST
																{  Panel actions (Require a presentation window). }
	kAGEventDoCoach				= 'doco';
	kAGEventDoHuh				= 'dhuh';
	kAGEventGoNext				= 'gonp';
	kAGEventGoPrev				= 'gopp';
	kAGEventHidePanel			= 'pahi';
	kAGEventReturnBack			= 'gobk';
	kAGEventShowPanel			= 'pash';
	kAGEventTogglePanel			= 'patg';

	{  Functions }

	{
	   AGClose
	   Close the database associated with the AGRefNum.
	}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  AGClose()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in AppleGuideLib 2.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION AGClose(VAR refNum: AGRefNum): AGErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7011, $AA6E;
	{$ENDC}

{
   AGGeneral
   Cause various events to happen.
}

{
 *  AGGeneral()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGGeneral(refNum: AGRefNum; theEvent: AGEvent): AGErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700D, $AA6E;
	{$ENDC}

{
   AGGetAvailableDBTypes
   Return the database types available for this application.
}

{
 *  AGGetAvailableDBTypes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGGetAvailableDBTypes: UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $AA6E;
	{$ENDC}

{
   AGGetFrontWindowKind
   Return the kind of the front window.
}

{
 *  AGGetFrontWindowKind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGGetFrontWindowKind(refNum: AGRefNum): AGWindowKind;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $AA6E;
	{$ENDC}

{
   AGGetFSSpec
   Return the FSSpec for the AGRefNum.
}

{
 *  AGGetFSSpec()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGGetFSSpec(refNum: AGRefNum; VAR fileSpec: FSSpec): AGErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700F, $AA6E;
	{$ENDC}

{
   AGGetStatus
   Return the status of Apple Guide.
}

{
 *  AGGetStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGGetStatus: AGStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7009, $AA6E;
	{$ENDC}

{
   AGInstallCoachHandler
   Install a Coach object location query handler.
}

{
 *  AGInstallCoachHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGInstallCoachHandler(coachReplyProc: CoachReplyUPP; refCon: LONGINT; VAR resultRefNum: AGCoachRefNum): AGErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7012, $AA6E;
	{$ENDC}

{
   AGInstallContextHandler
   Install a context check query handler.
}

{
 *  AGInstallContextHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGInstallContextHandler(contextReplyProc: ContextReplyUPP; eventID: AEEventID; refCon: LONGINT; VAR resultRefNum: AGContextRefNum): AGErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7013, $AA6E;
	{$ENDC}

{
   AGIsDatabaseOpen
   Return true if the database associated with the AGRefNum is open.
}

{
 *  AGIsDatabaseOpen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGIsDatabaseOpen(refNum: AGRefNum): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $AA6E;
	{$ENDC}

{
   AGOpen
   Open a guide database.
}

{
 *  AGOpen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGOpen(fileSpec: ConstFSSpecPtr; flags: UInt32; mixinControl: Handle; VAR resultRefNum: AGRefNum): AGErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $AA6E;
	{$ENDC}

{
   AGOpenWithSearch
   Open a guide database and preset a search string.
}

{
 *  AGOpenWithSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGOpenWithSearch(fileSpec: ConstFSSpecPtr; flags: UInt32; mixinControl: Handle; searchString: Str255; VAR resultRefNum: AGRefNum): AGErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $AA6E;
	{$ENDC}

{
   AGOpenWithSequence
   Open a guide database and display a presentation window sequence.
}

{
 *  AGOpenWithSequence()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGOpenWithSequence(fileSpec: ConstFSSpecPtr; flags: UInt32; mixinControl: Handle; sequenceID: INTEGER; VAR resultRefNum: AGRefNum): AGErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $AA6E;
	{$ENDC}

{
   AGOpenWithView
   Open a guide database and override the default view.
}

{
 *  AGOpenWithView()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGOpenWithView(fileSpec: ConstFSSpecPtr; flags: UInt32; mixinControl: Handle; viewNum: INTEGER; VAR resultRefNum: AGRefNum): AGErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $AA6E;
	{$ENDC}

{
   AGQuit
   Make Apple Guide quit.
}

{
 *  AGQuit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGQuit: AGErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7010, $AA6E;
	{$ENDC}

{
   AGRemoveCoachHandler
   Remove the Coach object location query handler.
}

{
 *  AGRemoveCoachHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGRemoveCoachHandler(VAR resultRefNum: AGCoachRefNum): AGErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7014, $AA6E;
	{$ENDC}

{
   AGRemoveContextHandler
   Remove the context check query handler.
}

{
 *  AGRemoveContextHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGRemoveContextHandler(VAR resultRefNum: AGContextRefNum): AGErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7015, $AA6E;
	{$ENDC}

{
   AGStart
   Start up Apple Guide in the background.
}

{
 *  AGStart()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGStart: AGErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700A, $AA6E;
	{$ENDC}



{  typedef's }

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	AGFileFSSpecType					= FSSpec;
	AGFileFSSpecTypePtr 				= ^AGFileFSSpecType;
	AGFileSelectorCountType				= INTEGER;
	AGFileSelectorIndexType				= INTEGER;
	AGFileSelectorType					= OSType;
	AGFileSelectorValueType				= LONGINT;
	AGFileDBType						= INTEGER;
	AGFileDBMenuNamePtr					= Str63;
	AGFileDBScriptType					= INTEGER;
	AGFileDBRegionType					= INTEGER;
	AGFileMajorRevType					= INTEGER;
	AGFileMinorRevType					= INTEGER;
	AGFileCountType						= INTEGER;
	{  Database types (for AGFileDBType parameter). }

CONST
	kAGFileDBTypeAny			= 0;
	kAGFileDBTypeHelp			= 1;
	kAGFileDBTypeTutorial		= 2;
	kAGFileDBTypeShortcuts		= 3;
	kAGFileDBTypeAbout			= 4;
	kAGFileDBTypeOther			= 8;



{$IFC CALL_NOT_IN_CARBON }
	{
	 *  AGFileGetDBMenuName()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in AppleGuideLib 2.2 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION AGFileGetDBMenuName({CONST}VAR fileSpec: FSSpec; VAR menuItemNameString: Str63): OSErr;

{  Get the database type. }
{
 *  AGFileGetDBType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGFileGetDBType({CONST}VAR fileSpec: FSSpec; VAR databaseType: AGFileDBType): OSErr;

{
   Get the version of the software
   that created this database.
}
{
 *  AGFileGetDBVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGFileGetDBVersion({CONST}VAR fileSpec: FSSpec; VAR majorRev: AGFileMajorRevType; VAR minorRev: AGFileMinorRevType): OSErr;

{  Get the database script and region information. }
{
 *  AGFileGetDBCountry()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGFileGetDBCountry({CONST}VAR fileSpec: FSSpec; VAR script: AGFileDBScriptType; VAR region: AGFileDBRegionType): OSErr;

{  Return the number of selectors in database. }
{
 *  AGFileGetSelectorCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGFileGetSelectorCount({CONST}VAR fileSpec: FSSpec): AGFileSelectorCountType;

{
   Get the i-th database selector (1 to AGFileSelectorCountType)
   and its value.
}
{
 *  AGFileGetSelector()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGFileGetSelector({CONST}VAR fileSpec: FSSpec; selectorNumber: AGFileSelectorIndexType; VAR selector: AGFileSelectorType; VAR value: AGFileSelectorValueType): OSErr;

{  Return true if database is mixin. }
{
 *  AGFileIsMixin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGFileIsMixin({CONST}VAR fileSpec: FSSpec): BOOLEAN;

{
   Return the number of database files
   of the specified databaseType and main/mixin.
   Any file creator is acceptible,
   but type must be kAGFileMain or kAGFileMixin.
}
{
 *  AGFileGetDBCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGFileGetDBCount(vRefNum: INTEGER; dirID: LONGINT; databaseType: AGFileDBType; wantMixin: BOOLEAN): AGFileCountType;

{
   Get the FSSpec for the dbIndex-th database
   of the specified databaseType and main/mixin.
   Any file creator is acceptible,
   but type must be kAGFileMain or kAGFileMixin.
}
{
 *  AGFileGetIndDB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGFileGetIndDB(vRefNum: INTEGER; dirID: LONGINT; databaseType: AGFileDBType; wantMixin: BOOLEAN; dbIndex: INTEGER; VAR fileSpec: FSSpec): OSErr;

{
   This selector must match with the application
   creator in order for this file to appear in the 
   application's Help menu. Ignored for mixin files
   because they never appear in the Help menu anyway.
   If empty (zeros), will appear in the Help menu
   of any host application.
}
{
 *  AGFileGetHelpMenuAppCreator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGFileGetHelpMenuAppCreator({CONST}VAR fileSpec: FSSpec; VAR helpMenuAppCreator: OSType): OSErr;

{
   This selector must match in the main and mixin
   files in order for the mixin to mix-in with the main.
   Empty (zeros) selectors are valid matches.
   A '****' selector will mix-in with any main.
}
{
 *  AGFileGetMixinMatchSelector()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGFileGetMixinMatchSelector({CONST}VAR fileSpec: FSSpec; VAR mixinMatchSelector: OSType): OSErr;

{
   This is the text of the balloon for the
   Help menu item for this database.
}
{
 *  AGFileGetHelpMenuBalloonText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGFileGetHelpMenuBalloonText({CONST}VAR fileSpec: FSSpec; VAR helpMenuBalloonString: Str255): OSErr;


{
 *  AGGetSystemDB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleGuideLib 2.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AGGetSystemDB(databaseType: AGFileDBType; wantMixin: BOOLEAN; VAR pFileSpec: FSSpec): OSErr;

{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AppleGuideIncludes}

{$ENDC} {__APPLEGUIDE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
