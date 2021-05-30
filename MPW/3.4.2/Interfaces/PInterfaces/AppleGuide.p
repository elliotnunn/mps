{
 	File:		AppleGuide.p
 
 	Contains:	Apple Guide Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.3
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.
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
 UNIT AppleGuide;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __APPLEGUIDE__}
{$SETC __APPLEGUIDE__ := 1}

{$I+}
{$SETC AppleGuideIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{	Errors.p													}
{		ConditionalMacros.p										}
{	Types.p														}
{	Memory.p													}
{		MixedMode.p												}
{	OSUtils.p													}
{	Events.p													}
{		Quickdraw.p												}
{			QuickdrawText.p										}
{	EPPC.p														}
{		AppleTalk.p												}
{		Files.p													}
{			Finder.p											}
{		PPCToolbox.p											}
{		Processes.p												}
{	Notification.p												}

{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
	
TYPE
	AGRefNum = UInt32;

	AGCoachRefNum = UInt32;

	AGContextRefNum = UInt32;

	AGAppInfo = RECORD
		eventId:				AEEventID;
		refCon:					LONGINT;
		contextObj:				Ptr;									{ private system field}
	END;

	AGAppInfoPtr = ^AGAppInfo;
	AGAppInfoHdl = ^AGAppInfoPtr;

	CoachReplyProcPtr = ProcPtr;  { FUNCTION CoachReply(VAR pRect: Rect; name: Ptr; refCon: LONGINT): OSErr; }
	ContextReplyProcPtr = ProcPtr;  { FUNCTION ContextReply(pInputData: Ptr; inputDataSize: Size; VAR ppOutputData: Ptr; VAR pOutputDataSize: Size; hAppInfo: AGAppInfoHdl): OSErr; }
	CoachReplyUPP = UniversalProcPtr;
	ContextReplyUPP = UniversalProcPtr;

CONST
	uppCoachReplyProcInfo = $00000FE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }
	uppContextReplyProcInfo = $0000FFE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewCoachReplyProc(userRoutine: CoachReplyProcPtr): CoachReplyUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewContextReplyProc(userRoutine: ContextReplyProcPtr): ContextReplyUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallCoachReplyProc(VAR pRect: Rect; name: Ptr; refCon: LONGINT; userRoutine: CoachReplyUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallContextReplyProc(pInputData: Ptr; inputDataSize: Size; VAR ppOutputData: Ptr; VAR pOutputDataSize: Size; hAppInfo: AGAppInfoHdl; userRoutine: ContextReplyUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

CONST
	gestaltAppleGuidePresent	= 31;
	gestaltAppleGuideIsDebug	= 30;
	kAGDefault					= 0;
	kAGFrontDatabase			= 1;
	kAGNoMixin					= 0+(-1);

	kAGViewFullHowdy			= 1;							{ Full-size Howdy}
	kAGViewTopicAreas			= 2;							{ Full-size Topic Areas}
	kAGViewIndex				= 3;							{ Full-size Index Terms}
	kAGViewLookFor				= 4;							{ Full-size Look-For (Search)}
	kAGViewSingleHowdy			= 5;							{ Single-list-size Howdy}
	kAGViewSingleTopics			= 6;							{ Single-list-size Topics}

	kAGFileMain					= 'poco';
	kAGFileMixin				= 'mixn';

{ To test against AGGetAvailableDBTypes}
	kAGDBTypeBitAny				= $00000001;
	kAGDBTypeBitHelp			= $00000002;
	kAGDBTypeBitTutorial		= $00000004;
	kAGDBTypeBitShortcuts		= $00000008;
	kAGDBTypeBitAbout			= $00000010;
	kAGDBTypeBitOther			= $00000080;

	
TYPE
	AGStatus = UInt16;

{ Returned by AGGetStatus}

CONST
	kAGIsNotRunning				= 0;
	kAGIsSleeping				= 1;
	kAGIsActive					= 2;

	
TYPE
	AGWindowKind = UInt16;

{ Returned by AGGetFrontWindowKind}

CONST
	kAGNoWindow					= 0;
	kAGAccessWindow				= 1;
	kAGPresentationWindow		= 2;

{ Error Codes}
{ Not an enum, because other OSErrs are valid.}
	
TYPE
	AGErr = SInt16;

{ Apple Guide error codes}

CONST
{ -------------------- Apple event reply codes}
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
{ -------------------- Coach's Chalkboard reply codes}
	kAGErrItemNotFound			= -2925;
	kAGErrBalloonResourceNotFound = -2926;
	kAGErrChalkResourceNotFound	= -2927;
	kAGErrChdvResourceNotFound	= -2928;
	kAGErrAlreadyShowing		= -2929;
	kAGErrBalloonResourceSkip	= -2930;
	kAGErrItemNotVisible		= -2931;
	kAGErrReserved32			= -2932;
	kAGErrNotFrontProcess		= -2933;
	kAGErrMacroResourceNotFound	= -2934;
{ -------------------- API reply codes}
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

{ Events}
{ Not an enum because we want to make assignments.}
	
TYPE
	AGEvent = UInt32;

{ Handy events for AGGeneral.}

CONST
{ Panel actions (Require a presentation window).}
	kAGEventDoCoach				= 'doco';
	kAGEventDoHuh				= 'dhuh';
	kAGEventGoNext				= 'gonp';
	kAGEventGoPrev				= 'gopp';
	kAGEventHidePanel			= 'pahi';
	kAGEventReturnBack			= 'gobk';
	kAGEventShowPanel			= 'pash';
	kAGEventTogglePanel			= 'patg';

{ Functions}
{ AGClose}
{ Close the database associated with the AGRefNum.}

FUNCTION AGClose(VAR refNum: AGRefNum): AGErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7011, $AA6E;
	{$ENDC}
{ AGGeneral}
{ Cause various events to happen.}
FUNCTION AGGeneral(refNum: AGRefNum; theEvent: AGEvent): AGErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700D, $AA6E;
	{$ENDC}
{ AGGetAvailableDBTypes}
{ Return the database types available for this application.}
FUNCTION AGGetAvailableDBTypes: UInt32;
	{$IFC NOT GENERATINGCFM}
	INLINE $7008, $AA6E;
	{$ENDC}
{ AGGetFrontWindowKind}
{ Return the kind of the front window.}
FUNCTION AGGetFrontWindowKind(refNum: AGRefNum): AGWindowKind;
	{$IFC NOT GENERATINGCFM}
	INLINE $700C, $AA6E;
	{$ENDC}
{ AGGetFSSpec}
{ Return the FSSpec for the AGRefNum.}
FUNCTION AGGetFSSpec(refNum: AGRefNum; fileSpec: ConstFSSpecPtr): AGErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700F, $AA6E;
	{$ENDC}
{ AGGetStatus}
{ Return the status of Apple Guide.}
FUNCTION AGGetStatus: AGStatus;
	{$IFC NOT GENERATINGCFM}
	INLINE $7009, $AA6E;
	{$ENDC}
{ AGInstallCoachHandler}
{ Install a Coach object location query handler.}
FUNCTION AGInstallCoachHandler(coachReplyProc: CoachReplyUPP; refCon: LONGINT; VAR resultRefNum: AGCoachRefNum): AGErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7012, $AA6E;
	{$ENDC}
{ AGInstallContextHandler}
{ Install a context check query handler.}
FUNCTION AGInstallContextHandler(contextReplyProc: ContextReplyUPP; eventID: AEEventID; refCon: LONGINT; VAR resultRefNum: AGContextRefNum): AGErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7013, $AA6E;
	{$ENDC}
{ AGIsDatabaseOpen}
{ Return true if the database associated with the AGRefNum is open.}
FUNCTION AGIsDatabaseOpen(refNum: AGRefNum): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $7006, $AA6E;
	{$ENDC}
{ AGOpen}
{ Open a guide database.}
FUNCTION AGOpen(fileSpec: ConstFSSpecPtr; flags: UInt32; mixinControl: Handle; VAR resultRefNum: AGRefNum): AGErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7001, $AA6E;
	{$ENDC}
{ AGOpenWithSearch}
{ Open a guide database and preset a search string.}
FUNCTION AGOpenWithSearch(fileSpec: ConstFSSpecPtr; flags: UInt32; mixinControl: Handle; searchString: ConstStr255Param; VAR resultRefNum: AGRefNum): AGErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7002, $AA6E;
	{$ENDC}
{ AGOpenWithSequence}
{ Open a guide database and display a presentation window sequence.}
FUNCTION AGOpenWithSequence(fileSpec: ConstFSSpecPtr; flags: UInt32; mixinControl: Handle; sequenceID: INTEGER; VAR resultRefNum: AGRefNum): AGErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7004, $AA6E;
	{$ENDC}
{ AGOpenWithView}
{ Open a guide database and override the default view.}
FUNCTION AGOpenWithView(fileSpec: ConstFSSpecPtr; flags: UInt32; mixinControl: Handle; viewNum: INTEGER; VAR resultRefNum: AGRefNum): AGErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7005, $AA6E;
	{$ENDC}
{ AGQuit}
{ Make Apple Guide quit.}
FUNCTION AGQuit: AGErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7010, $AA6E;
	{$ENDC}
{ AGRemoveCoachHandler}
{ Remove the Coach object location query handler.}
FUNCTION AGRemoveCoachHandler(VAR resultRefNum: AGCoachRefNum): AGErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7014, $AA6E;
	{$ENDC}
{ AGRemoveContextHandler}
{ Remove the context check query handler.}
FUNCTION AGRemoveContextHandler(VAR resultRefNum: AGContextRefNum): AGErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7015, $AA6E;
	{$ENDC}
{ AGStart}
{ Start up Apple Guide in the background.}
FUNCTION AGStart: AGErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700A, $AA6E;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AppleGuideIncludes}

{$ENDC} {__APPLEGUIDE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
