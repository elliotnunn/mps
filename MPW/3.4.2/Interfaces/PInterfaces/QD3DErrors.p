{
 	File:		QD3DErrors.p
 
 	Contains:	Error API and error codes										
 
 	Version:	Technology:	Quickdraw 3D 1.0.6
 				Release:	Universal Interfaces 2.1.5
 
 	Copyright:	© 1984-1997 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QD3DErrors;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DERRORS__}
{$SETC __QD3DERRORS__ := 1}

{$I+}
{$SETC QD3DErrorsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}
{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}

{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{
*****************************************************************************
 **																			 **
 **							Error Types and Codes							 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3Error 					= LONGINT;
CONST
	kQ3ErrorNone				= {TQ3Error}0;					{  Fatal Errors  }
	kQ3ErrorInternalError		= {TQ3Error}-28500;
	kQ3ErrorNoRecovery			= {TQ3Error}-28499;
	kQ3ErrorLastFatalError		= {TQ3Error}-28498;				{  System Errors  }
	kQ3ErrorNotInitialized		= {TQ3Error}-28490;
	kQ3ErrorAlreadyInitialized	= {TQ3Error}-28489;
	kQ3ErrorUnimplemented		= {TQ3Error}-28488;
	kQ3ErrorRegistrationFailed	= {TQ3Error}-28487;				{  OS Errors  }
	kQ3ErrorUnixError			= {TQ3Error}-28486;
	kQ3ErrorMacintoshError		= {TQ3Error}-28485;
	kQ3ErrorX11Error			= {TQ3Error}-28484;				{  Memory Errors  }
	kQ3ErrorMemoryLeak			= {TQ3Error}-28483;
	kQ3ErrorOutOfMemory			= {TQ3Error}-28482;				{  Parameter errors  }
	kQ3ErrorNULLParameter		= {TQ3Error}-28481;
	kQ3ErrorParameterOutOfRange	= {TQ3Error}-28480;
	kQ3ErrorInvalidParameter	= {TQ3Error}-28479;
	kQ3ErrorInvalidData			= {TQ3Error}-28478;
	kQ3ErrorAcceleratorAlreadySet = {TQ3Error}-28477;
	kQ3ErrorVector3DNotUnitLength = {TQ3Error}-28476;
	kQ3ErrorVector3DZeroLength	= {TQ3Error}-28475;				{  Object Errors  }
	kQ3ErrorInvalidObject		= {TQ3Error}-28474;
	kQ3ErrorInvalidObjectClass	= {TQ3Error}-28473;
	kQ3ErrorInvalidObjectType	= {TQ3Error}-28472;
	kQ3ErrorInvalidObjectName	= {TQ3Error}-28471;
	kQ3ErrorObjectClassInUse	= {TQ3Error}-28470;
	kQ3ErrorAccessRestricted	= {TQ3Error}-28469;
	kQ3ErrorMetaHandlerRequired	= {TQ3Error}-28468;
	kQ3ErrorNeedRequiredMethods	= {TQ3Error}-28467;
	kQ3ErrorNoSubClassType		= {TQ3Error}-28466;
	kQ3ErrorUnknownElementType	= {TQ3Error}-28465;
	kQ3ErrorNotSupported		= {TQ3Error}-28464;				{  Extension Errors  }
	kQ3ErrorNoExtensionsFolder	= {TQ3Error}-28463;
	kQ3ErrorExtensionError		= {TQ3Error}-28462;
	kQ3ErrorPrivateExtensionError = {TQ3Error}-28461;			{  Geometry Errors  }
	kQ3ErrorDegenerateGeometry	= {TQ3Error}-28460;
	kQ3ErrorGeometryInsufficientNumberOfPoints = {TQ3Error}-28459; {  IO Errors  }
	kQ3ErrorNoStorageSetForFile	= {TQ3Error}-28458;
	kQ3ErrorEndOfFile			= {TQ3Error}-28457;
	kQ3ErrorFileCancelled		= {TQ3Error}-28456;
	kQ3ErrorInvalidMetafile		= {TQ3Error}-28455;
	kQ3ErrorInvalidMetafilePrimitive = {TQ3Error}-28454;
	kQ3ErrorInvalidMetafileLabel = {TQ3Error}-28453;
	kQ3ErrorInvalidMetafileObject = {TQ3Error}-28452;
	kQ3ErrorInvalidMetafileSubObject = {TQ3Error}-28451;
	kQ3ErrorInvalidSubObjectForObject = {TQ3Error}-28450;
	kQ3ErrorUnresolvableReference = {TQ3Error}-28449;
	kQ3ErrorUnknownObject		= {TQ3Error}-28448;
	kQ3ErrorStorageInUse		= {TQ3Error}-28447;
	kQ3ErrorStorageAlreadyOpen	= {TQ3Error}-28446;
	kQ3ErrorStorageNotOpen		= {TQ3Error}-28445;
	kQ3ErrorStorageIsOpen		= {TQ3Error}-28444;
	kQ3ErrorFileAlreadyOpen		= {TQ3Error}-28443;
	kQ3ErrorFileNotOpen			= {TQ3Error}-28442;
	kQ3ErrorFileIsOpen			= {TQ3Error}-28441;
	kQ3ErrorBeginWriteAlreadyCalled = {TQ3Error}-28440;
	kQ3ErrorBeginWriteNotCalled	= {TQ3Error}-28439;
	kQ3ErrorEndWriteNotCalled	= {TQ3Error}-28438;
	kQ3ErrorReadStateInactive	= {TQ3Error}-28437;
	kQ3ErrorStateUnavailable	= {TQ3Error}-28436;
	kQ3ErrorWriteStateInactive	= {TQ3Error}-28435;
	kQ3ErrorSizeNotLongAligned	= {TQ3Error}-28434;
	kQ3ErrorFileModeRestriction	= {TQ3Error}-28433;
	kQ3ErrorInvalidHexString	= {TQ3Error}-28432;
	kQ3ErrorWroteMoreThanSize	= {TQ3Error}-28431;
	kQ3ErrorWroteLessThanSize	= {TQ3Error}-28430;
	kQ3ErrorReadLessThanSize	= {TQ3Error}-28429;
	kQ3ErrorReadMoreThanSize	= {TQ3Error}-28428;
	kQ3ErrorNoBeginGroup		= {TQ3Error}-28427;
	kQ3ErrorSizeMismatch		= {TQ3Error}-28426;
	kQ3ErrorStringExceedsMaximumLength = {TQ3Error}-28425;
	kQ3ErrorValueExceedsMaximumSize = {TQ3Error}-28424;
	kQ3ErrorNonUniqueLabel		= {TQ3Error}-28423;
	kQ3ErrorEndOfContainer		= {TQ3Error}-28422;
	kQ3ErrorUnmatchedEndGroup	= {TQ3Error}-28421;
	kQ3ErrorFileVersionExists	= {TQ3Error}-28420;				{  View errors  }
	kQ3ErrorViewNotStarted		= {TQ3Error}-28419;
	kQ3ErrorViewIsStarted		= {TQ3Error}-28418;
	kQ3ErrorRendererNotSet		= {TQ3Error}-28417;
	kQ3ErrorRenderingIsActive	= {TQ3Error}-28416;
	kQ3ErrorImmediateModeUnderflow = {TQ3Error}-28415;
	kQ3ErrorDisplayNotSet		= {TQ3Error}-28414;
	kQ3ErrorCameraNotSet		= {TQ3Error}-28413;
	kQ3ErrorDrawContextNotSet	= {TQ3Error}-28412;
	kQ3ErrorNonInvertibleMatrix	= {TQ3Error}-28411;
	kQ3ErrorRenderingNotStarted	= {TQ3Error}-28410;
	kQ3ErrorPickingNotStarted	= {TQ3Error}-28409;
	kQ3ErrorBoundsNotStarted	= {TQ3Error}-28408;
	kQ3ErrorDataNotAvailable	= {TQ3Error}-28407;
	kQ3ErrorNothingToPop		= {TQ3Error}-28406;				{  Renderer Errors  }
	kQ3ErrorUnknownStudioType	= {TQ3Error}-28405;
	kQ3ErrorAlreadyRendering	= {TQ3Error}-28404;
	kQ3ErrorStartGroupRange		= {TQ3Error}-28403;
	kQ3ErrorUnsupportedGeometryType = {TQ3Error}-28402;
	kQ3ErrorInvalidGeometryType	= {TQ3Error}-28401;
	kQ3ErrorUnsupportedFunctionality = {TQ3Error}-28400;		{  Group Errors  }
	kQ3ErrorInvalidPositionForGroup = {TQ3Error}-28399;
	kQ3ErrorInvalidObjectForGroup = {TQ3Error}-28398;
	kQ3ErrorInvalidObjectForPosition = {TQ3Error}-28397;		{  Transform Errors  }
	kQ3ErrorScaleOfZero			= {TQ3Error}-28396;				{  String Errors  }
	kQ3ErrorBadStringType		= {TQ3Error}-28395;				{  Attribute Errors  }
	kQ3ErrorAttributeNotContained = {TQ3Error}-28394;
	kQ3ErrorAttributeInvalidType = {TQ3Error}-28393;			{  Camera Errors  }
	kQ3ErrorInvalidCameraValues	= {TQ3Error}-28392;				{  DrawContext Errors  }
	kQ3ErrorBadDrawContextType	= {TQ3Error}-28391;
	kQ3ErrorBadDrawContextFlag	= {TQ3Error}-28390;
	kQ3ErrorBadDrawContext		= {TQ3Error}-28389;
	kQ3ErrorUnsupportedPixelDepth = {TQ3Error}-28388;


TYPE
	TQ3Warning 					= LONGINT;
CONST
	kQ3WarningNone				= {TQ3Warning}0;				{  General System  }
	kQ3WarningInternalException	= {TQ3Warning}-28300;			{  Object Warnings  }
	kQ3WarningNoObjectSupportForDuplicateMethod = {TQ3Warning}-28299;
	kQ3WarningNoObjectSupportForDrawMethod = {TQ3Warning}-28298;
	kQ3WarningNoObjectSupportForWriteMethod = {TQ3Warning}-28297;
	kQ3WarningNoObjectSupportForReadMethod = {TQ3Warning}-28296;
	kQ3WarningUnknownElementType = {TQ3Warning}-28295;
	kQ3WarningTypeAndMethodAlreadyDefined = {TQ3Warning}-28294;
	kQ3WarningTypeIsOutOfRange	= {TQ3Warning}-28293;
	kQ3WarningTypeHasNotBeenRegistered = {TQ3Warning}-28292;	{  Parameter Warnings  }
	kQ3WarningVector3DNotUnitLength = {TQ3Warning}-28291;		{  IO Warnings  }
	kQ3WarningInvalidSubObjectForObject = {TQ3Warning}-28290;
	kQ3WarningInvalidHexString	= {TQ3Warning}-28289;
	kQ3WarningUnknownObject		= {TQ3Warning}-28288;
	kQ3WarningInvalidMetafileObject = {TQ3Warning}-28287;
	kQ3WarningUnmatchedBeginGroup = {TQ3Warning}-28286;
	kQ3WarningUnmatchedEndGroup	= {TQ3Warning}-28285;
	kQ3WarningInvalidTableOfContents = {TQ3Warning}-28284;
	kQ3WarningUnresolvableReference = {TQ3Warning}-28283;
	kQ3WarningNoAttachMethod	= {TQ3Warning}-28282;
	kQ3WarningInconsistentData	= {TQ3Warning}-28281;
	kQ3WarningReadLessThanSize	= {TQ3Warning}-28280;
	kQ3WarningFilePointerResolutionFailed = {TQ3Warning}-28279;
	kQ3WarningFilePointerRedefined = {TQ3Warning}-28278;
	kQ3WarningStringExceedsMaximumLength = {TQ3Warning}-28277;	{  Memory Warnings  }
	kQ3WarningLowMemory			= {TQ3Warning}-28276;
	kQ3WarningPossibleMemoryLeak = {TQ3Warning}-28275;			{  View Warnings  }
	kQ3WarningViewTraversalInProgress = {TQ3Warning}-28274;
	kQ3WarningNonInvertibleMatrix = {TQ3Warning}-28273;			{  Quaternion Warning  }
	kQ3WarningQuaternionEntriesAreZero = {TQ3Warning}-28272;	{  Renderer Warning  }
	kQ3WarningFunctionalityNotSupported = {TQ3Warning}-28271;	{  DrawContext Warning  }
	kQ3WarningInvalidPaneDimensions = {TQ3Warning}-28270;		{  Pick Warning  }
	kQ3WarningPickParamOutside	= {TQ3Warning}-28269;			{  Scale Warnings  }
	kQ3WarningScaleEntriesAllZero = {TQ3Warning}-28268;
	kQ3WarningScaleContainsNegativeEntries = {TQ3Warning}-28267; {  Generic Warnings  }
	kQ3WarningParameterOutOfRange = {TQ3Warning}-28266;


TYPE
	TQ3Notice 					= LONGINT;
CONST
	kQ3NoticeNone				= {TQ3Notice}0;
	kQ3NoticeDataAlreadyEmpty	= {TQ3Notice}-28100;			{  General  }
	kQ3NoticeMethodNotSupported	= {TQ3Notice}-28099;
	kQ3NoticeObjectAlreadySet	= {TQ3Notice}-28098;
	kQ3NoticeParameterOutOfRange = {TQ3Notice}-28097;			{  IO Notices  }
	kQ3NoticeFileAliasWasChanged = {TQ3Notice}-28096;			{  Geometry  }
	kQ3NoticeMeshVertexHasNoComponent = {TQ3Notice}-28095;
	kQ3NoticeMeshInvalidVertexFacePair = {TQ3Notice}-28094;
	kQ3NoticeMeshEdgeVertexDoNotCorrespond = {TQ3Notice}-28093;
	kQ3NoticeMeshEdgeIsNotBoundary = {TQ3Notice}-28092;			{  Draw Context  }
	kQ3NoticeDrawContextNotSetUsingInternalDefaults = {TQ3Notice}-28091; {  Lights  }
	kQ3NoticeInvalidAttenuationTypeUsingInternalDefaults = {TQ3Notice}-28090;
	kQ3NoticeBrightnessGreaterThanOne = {TQ3Notice}-28089;		{   Scale   }
	kQ3NoticeScaleContainsZeroEntries = {TQ3Notice}-28088;


TYPE
	TQ3ErrorMethod = ProcPtr;  { PROCEDURE TQ3ErrorMethod(firstError: TQ3Error; lastError: TQ3Error; reference: LONGINT); C; }

	TQ3WarningMethod = ProcPtr;  { PROCEDURE TQ3WarningMethod(firstWarning: TQ3Warning; lastWarning: TQ3Warning; reference: LONGINT); C; }

	TQ3NoticeMethod = ProcPtr;  { PROCEDURE TQ3NoticeMethod(firstNotice: TQ3Notice; lastNotice: TQ3Notice; reference: LONGINT); C; }

{
*****************************************************************************
 **																			 **
 **								Error Routines								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Error_Register(errorPost: TQ3ErrorMethod; reference: LONGINT): TQ3Status; C;
FUNCTION Q3Warning_Register(warningPost: TQ3WarningMethod; reference: LONGINT): TQ3Status; C;
FUNCTION Q3Notice_Register(noticePost: TQ3NoticeMethod; reference: LONGINT): TQ3Status; C;
{
 *  Getting error codes -
 *	Clears error type on next entry into system (except all of these 
 *  error calls), and returns the last error, and optionally the 
 *	first error. The parameter to these "_Get" calls may be NULL.
}
FUNCTION Q3Error_Get(VAR firstError: TQ3Error): TQ3Error; C;
FUNCTION Q3Error_IsFatalError(error: TQ3Error): TQ3Boolean; C;
FUNCTION Q3Warning_Get(VAR firstWarning: TQ3Warning): TQ3Warning; C;
FUNCTION Q3Notice_Get(VAR firstNotice: TQ3Notice): TQ3Notice; C;
FUNCTION Q3MacintoshError_Get(VAR firstMacErr: OSErr): OSErr; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DErrorsIncludes}

{$ENDC} {__QD3DERRORS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
