{
 	File:		GXPrinting.p
 
 	Contains:	This file contains all printing APIs except for driver/extension specific ones.
 
 	Version:	Technology:	Quickdraw GX 1.1
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
 UNIT GXPrinting;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __GXPRINTING__}
{$SETC __GXPRINTING__ := 1}

{$I+}
{$SETC GXPrintingIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __COLLECTIONS__}
{$I Collections.p}
{$ENDC}
{	Types.p														}
{		ConditionalMacros.p										}
{	MixedMode.p													}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}

{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{	Errors.p													}
{	Memory.p													}
{	Menus.p														}
{		Quickdraw.p												}
{			QuickdrawText.p										}
{	Controls.p													}
{	Windows.p													}
{		Events.p												}
{			OSUtils.p											}
{	TextEdit.p													}

{$IFC UNDEFINED __ERRORS__}
{$I Errors.p}
{$ENDC}

{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{	Finder.p													}

{$IFC UNDEFINED __GXFONTS__}
{$I GXFonts.p}
{$ENDC}
{	GXMath.p													}
{		FixMath.p												}
{	GXTypes.p													}
{	ScalerTypes.p												}
{		SFNTTypes.p												}

{$IFC UNDEFINED __GXMATH__}
{$I GXMath.p}
{$ENDC}

{$IFC UNDEFINED __GXTYPES__}
{$I GXTypes.p}
{$ENDC}

{$IFC UNDEFINED __LISTS__}
{$I Lists.p}
{$ENDC}

{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}

{$IFC UNDEFINED __GXMESSAGES__}
{$I GXMessages.p}
{$ENDC}

{$IFC UNDEFINED __PRINTING__}
{$I Printing.p}
{$ENDC}

{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	gestaltGXPrintingMgrVersion	= 'pmgr';
	gestaltGXVersion			= 'qdgx';

	
TYPE
	gxOwnerSignature = LONGINT;

{$IFC OLDROUTINENAMES }
	Signature = LONGINT;

{$ENDC}
	gxPrinter = Ptr;

	gxJob = Ptr;

	gxFormat = Ptr;

	gxPaperType = Ptr;

	gxPrintFile = Ptr;

	gxLoopStatus = BOOLEAN;


CONST
	gxStopLooping				= false;
	gxKeepLooping				= true;

TYPE
	gxViewDeviceProcPtr = ProcPtr;  { FUNCTION gxViewDevice(aViewDevice: gxViewDevice; refCon: UNIV Ptr): gxLoopStatus; }
	gxViewDeviceUPP = UniversalProcPtr;

CONST
	uppgxViewDeviceProcInfo = $000003D0; { FUNCTION (4 byte param, 4 byte param): 1 byte result; }

FUNCTION NewgxViewDeviceProc(userRoutine: gxViewDeviceProcPtr): gxViewDeviceUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallgxViewDeviceProc(aViewDevice: gxViewDevice; refCon: UNIV Ptr; userRoutine: gxViewDeviceUPP): gxLoopStatus;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
TYPE
	gxFormatProcPtr = ProcPtr;  { FUNCTION gxFormat(aFormat: gxFormat; refCon: UNIV Ptr): gxLoopStatus; }
	gxFormatUPP = UniversalProcPtr;

CONST
	uppgxFormatProcInfo = $000003D0; { FUNCTION (4 byte param, 4 byte param): 1 byte result; }

FUNCTION NewgxFormatProc(userRoutine: gxFormatProcPtr): gxFormatUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallgxFormatProc(aFormat: gxFormat; refCon: UNIV Ptr; userRoutine: gxFormatUPP): gxLoopStatus;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
TYPE
	gxPaperTypeProcPtr = ProcPtr;  { FUNCTION gxPaperType(aPapertype: gxPaperType; refCon: UNIV Ptr): gxLoopStatus; }
	gxPaperTypeUPP = UniversalProcPtr;

CONST
	uppgxPaperTypeProcInfo = $000003D0; { FUNCTION (4 byte param, 4 byte param): 1 byte result; }

FUNCTION NewgxPaperTypeProc(userRoutine: gxPaperTypeProcPtr): gxPaperTypeUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallgxPaperTypeProc(aPapertype: gxPaperType; refCon: UNIV Ptr; userRoutine: gxPaperTypeUPP): gxLoopStatus;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
TYPE
	gxPrintingFlattenProcPtr = ProcPtr;  { FUNCTION gxPrintingFlatten(size: LONGINT; data: UNIV Ptr; refCon: UNIV Ptr): OSErr; }
	gxPrintingFlattenUPP = UniversalProcPtr;

CONST
	uppgxPrintingFlattenProcInfo = $00000FE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewgxPrintingFlattenProc(userRoutine: gxPrintingFlattenProcPtr): gxPrintingFlattenUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallgxPrintingFlattenProc(size: LONGINT; data: UNIV Ptr; refCon: UNIV Ptr; userRoutine: gxPrintingFlattenUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	gxViewDeviceProc = gxViewDeviceUPP;

	gxFormatProc = gxFormatUPP;

	gxPaperTypeProc = gxPaperTypeUPP;

	gxPrintingFlattenProc = gxPrintingFlattenUPP;

{
	The following constants are used to set collection item flags in printing
	collections. The Printing Manager purges certain items whenever a driver
	switch occurs. If the formatting driver changes, all items marked as
	gxVolatileFormattingDriverCategory will be purged.  If the output driver
	changes, all items marked as gxVolatileOutputDriverCategory will be purged.
	Note that to prevent items from being flattened when GXFlattenJob is called,
	you should unset the collectionPersistenceBit (defined in Collections.h),
	which is on by default.
}
{ Structure stored in collection items' user attribute bits }
	gxCollectionCategory = INTEGER;


CONST
	gxNoCollectionCategory		= $0000;
	gxOutputDriverCategory		= $0001;
	gxFormattingDriverCategory	= $0002;
	gxDriverVolatileCategory	= $0004;
	gxVolatileOutputDriverCategory = gxOutputDriverCategory + gxDriverVolatileCategory;
	gxVolatileFormattingDriverCategory = gxFormattingDriverCategory + gxDriverVolatileCategory;

{

	>>>>>> JOB COLLECTION ITEMS <<<<<<

}
{ gxJobInfo COLLECTION ITEM }
	gxJobTag					= 'job ';


TYPE
	gxJobInfo = RECORD
		numPages:				LONGINT;								{ Number of pages in the document }
		priority:				LONGINT;								{ Priority of this job plus "is it on hold?" }
		timeToPrint:			LONGINT;								{ When to print job, if scheduled }
		jobTimeout:				LONGINT;								{ Timeout value, in ticks }
		firstPageToPrint:		LONGINT;								{ Start printing from this page }
		jobAlert:				INTEGER;								{ How to alert user when printing }
		appName:				Str31;									{ Which application printed the document }
		documentName:			Str31;									{ The name of the document being printed }
		userName:				Str31;									{ The owner name of the machine that printed the document }
	END;

{ priority field constants }

CONST
	gxPrintJobHoldingBit		= $00001000;					{ This bit is set if the job is on hold. }

	gxPrintJobUrgent			= $00000001;
	gxPrintJobAtTime			= $00000002;
	gxPrintJobASAP				= $00000003;
	gxPrintJobHolding			= 0+(gxPrintJobHoldingBit + gxPrintJobASAP);
	gxPrintJobHoldingAtTime		= 0+(gxPrintJobHoldingBit + gxPrintJobAtTime);
	gxPrintJobHoldingUrgent		= 0+(gxPrintJobHoldingBit + gxPrintJobUrgent);

{ jobAlert field constants }
	gxNoPrintTimeAlert			= 0;							{ Don't alert user when we print }
	gxAlertBefore				= 1;							{ Alert user before we print }
	gxAlertAfter				= 2;							{ Alert user after we print }
	gxAlertBothTimes			= 3;							{ Alert before and after we print }

{ jobTimeout field constants }
	gxThirtySeconds				= 1800;							{ 30 seconds in ticks }
	gxTwoMinutes				= 7200;							{ 2 minutes in ticks }

{ gxCollationTag COLLECTION ITEM }
	gxCollationTag				= 'sort';


TYPE
	gxCollationInfo = RECORD
		collation:				BOOLEAN;								{ True if copies are to be collated }
		padByte:				CHAR;
	END;

{ gxCopiesTag COLLECTION ITEM }

CONST
	gxCopiesTag					= 'copy';


TYPE
	gxCopiesInfo = RECORD
		copies:					LONGINT;								{ Number of copies of the document to print }
	END;

{ gxPageRangeTag COLLECTION ITEM }

CONST
	gxPageRangeTag				= 'rang';


TYPE
	gxSimplePageRangeInfo = RECORD
		optionChosen:			CHAR;									{ From options listed below }
		printAll:				BOOLEAN;								{ True if user wants to print all pages }
		fromPage:				LONGINT;								{ For gxDefaultPageRange, current value }
		toPage:					LONGINT;								{ For gxDefaultPageRange, current value }
	END;

	gxPageRangeInfo = RECORD
		simpleRange:			gxSimplePageRangeInfo;					{ Info which will be returned for GetJobPageRange }
		fromString:				Str31;									{ For gxCustomizePageRange, current value }
		toString:				Str31;									{ For gxCustomizePageRange, current value }
		minFromPage:			LONGINT;								{ For gxDefaultPageRange, we parse with this, ignored if nil }
		maxToPage:				LONGINT;								{ For gxDefaultPageRange, we parse with this, ignored if nil }
		replaceString:			ARRAY [0..0] OF CHAR;					{ For gxReplacePageRange, string to display }
	END;

{ optionChosen field constants for SimplePageRangeInfo }

CONST
	gxDefaultPageRange			= 0;
	gxReplacePageRange			= 1;
	gxCustomizePageRange		= 2;

{ gxQualityTag COLLECTION ITEM }
	gxQualityTag				= 'qual';


TYPE
	gxQualityInfo = RECORD
		disableQuality:			BOOLEAN;								{ True to disable standard quality controls }
		padByte:				CHAR;
		defaultQuality:			INTEGER;								{ The default quality value }
		currentQuality:			INTEGER;								{ The current quality value }
		qualityCount:			INTEGER;								{ The number of quality menu items in popup menu }
		qualityNames:			ARRAY [0..0] OF CHAR;					{ An array of packed pascal strings for popup menu titles }
	END;

{ gxFileDestinationTag COLLECTION ITEM }

CONST
	gxFileDestinationTag		= 'dest';


TYPE
	gxFileDestinationInfo = RECORD
		toFile:					BOOLEAN;								{ True if destination is a file }
		padByte:				CHAR;
	END;

{ gxFileLocationTag COLLECTION ITEM }

CONST
	gxFileLocationTag			= 'floc';


TYPE
	gxFileLocationInfo = RECORD
		fileSpec:				FSSpec;									{ Location to put file, if destination is file }
	END;

{ gxFileFormatTag COLLECTION ITEM }

CONST
	gxFileFormatTag				= 'ffmt';


TYPE
	gxFileFormatInfo = RECORD
		fileFormatName:			Str31;									{ Name of file format (e.g. "PostScript") if destination is file }
	END;

{ gxFileFontsTag COLLECTION ITEM }

CONST
	gxFileFontsTag				= 'incf';


TYPE
	gxFileFontsInfo = RECORD
		includeFonts:			CHAR;									{ Which fonts to include, if destination is file }
		padByte:				CHAR;
	END;

{ includeFonts field constants }

CONST
	gxIncludeNoFonts			= 1;							{ Include no fonts }
	gxIncludeAllFonts			= 2;							{ Include all fonts }
	gxIncludeNonStandardFonts	= 3;							{ Include only fonts that aren't in the standard LW set }

{ gxPaperFeedTag COLLECTION ITEM }
	gxPaperFeedTag				= 'feed';


TYPE
	gxPaperFeedInfo = RECORD
		autoFeed:				BOOLEAN;								{ True if automatic feed, false if manual }
		padByte:				CHAR;
	END;

{ gxTrayFeedTag COLLECTION ITEM }

CONST
	gxTrayFeedTag				= 'tray';

	
TYPE
	gxTrayIndex = LONGINT;

	gxTrayFeedInfo = RECORD
		feedTrayIndex:			gxTrayIndex;							{ Tray to feed paper from }
		manualFeedThisPage:		BOOLEAN;								{ Signals manual feeding for the page }
		padByte:				CHAR;
	END;

{ gxManualFeedTag COLLECTION ITEM }

CONST
	gxManualFeedTag				= 'manf';


TYPE
	gxManualFeedInfo = RECORD
		numPaperTypeNames:		LONGINT;								{ Number of paperTypes to manually feed }
		paperTypeNames:			ARRAY [0..0] OF Str31;					{ Array of names of paperTypes to manually feed }
	END;

{ gxNormalMappingTag COLLECTION ITEM }

CONST
	gxNormalMappingTag			= 'nmap';


TYPE
	gxNormalMappingInfo = RECORD
		normalPaperMapping:		BOOLEAN;								{ True if not overriding normal paper mapping }
		padByte:				CHAR;
	END;

{ gxSpecialMappingTag COLLECTION ITEM }

CONST
	gxSpecialMappingTag			= 'smap';


TYPE
	gxSpecialMappingInfo = RECORD
		specialMapping:			CHAR;									{ Enumerated redirect, scale or tile setting }
		padByte:				CHAR;
	END;

{ specialMapping field constants }

CONST
	gxRedirectPages				= 1;							{ Redirect pages to a papertype and clip if necessary }
	gxScalePages				= 2;							{ Scale pages if necessary }
	gxTilePages					= 3;							{ Tile pages if necessary }

{ gxTrayMappingTag COLLECTION ITEM }
	gxTrayMappingTag			= 'tmap';


TYPE
	gxTrayMappingInfo = RECORD
		mapPaperToTray:			gxTrayIndex;							{ Tray to map all paper to }
	END;

{ gxPaperMappingTag COLLECTION ITEM }
{ This collection item contains a flattened paper type resource }

CONST
	gxPaperMappingTag			= 'pmap';

{ gxPrintPanelTag COLLECTION ITEM }
	gxPrintPanelTag				= 'ppan';


TYPE
	gxPrintPanelInfo = RECORD
		startPanelName:			Str31;									{ Name of starting panel in Print dialog }
	END;

{ gxFormatPanelTag COLLECTION ITEM }

CONST
	gxFormatPanelTag			= 'fpan';


TYPE
	gxFormatPanelInfo = RECORD
		startPanelName:			Str31;									{ Name of starting panel in Format dialog }
	END;

{ gxTranslatedDocumentTag COLLECTION ITEM }

CONST
	gxTranslatedDocumentTag		= 'trns';


TYPE
	gxTranslatedDocumentInfo = RECORD
		translatorInfo:			LONGINT;								{ Information from the translation process }
	END;

{

	>>>>>> FORMAT COLLECTION ITEMS <<<<<<

}
{ gxPaperTypeLockTag COLLECTION ITEM }

CONST
	gxPaperTypeLockTag			= 'ptlk';


TYPE
	gxPaperTypeLockInfo = RECORD
		paperTypeLocked:		BOOLEAN;								{ True if format's paperType is locked }
		padByte:				CHAR;
	END;

{ gxOrientationTag COLLECTION ITEM }

CONST
	gxOrientationTag			= 'layo';


TYPE
	gxOrientationInfo = RECORD
		orientation:			CHAR;									{ An enumerated orientation value }
		padByte:				CHAR;
	END;

{ orientation field constants }

CONST
	gxPortraitLayout			= 0;							{ Portrait }
	gxLandscapeLayout			= 1;							{ Landscape }
	gxRotatedPortraitLayout		= 2;							{ Portrait, rotated 180° }
	gxRotatedLandscapeLayout	= 3;							{ Landscape, rotated 180°  }

{ gxScalingTag COLLECTION ITEM }
	gxScalingTag				= 'scal';


TYPE
	gxScalingInfo = RECORD
		horizontalScaleFactor:	Fixed;									{ Current horizontal scaling factor }
		verticalScaleFactor:	Fixed;									{ Current vertical scaling factor }
		minScaling:				INTEGER;								{ Minimum scaling allowed }
		maxScaling:				INTEGER;								{ Maximum scaling allowed }
	END;

{ gxDirectModeTag COLLECTION ITEM }

CONST
	gxDirectModeTag				= 'dirm';


TYPE
	gxDirectModeInfo = RECORD
		directModeOn:			BOOLEAN;								{ True if a direct mode is enabled }
		padByte:				CHAR;
	END;

{ gxFormatHalftoneTag COLLECTION ITEM }

CONST
	gxFormatHalftoneTag			= 'half';


TYPE
	gxFormatHalftoneInfo = RECORD
		numHalftones:			LONGINT;								{ Number of halftone records }
		halftones:				ARRAY [0..0] OF gxHalftone;				{ The halftone records }
	END;

{ gxInvertPageTag COLLECTION ITEM }

CONST
	gxInvertPageTag				= 'invp';


TYPE
	gxInvertPageInfo = RECORD
		padByte:				CHAR;
		invert:					BOOLEAN;								{ If true, invert page }
	END;

{ gxFlipPageHorizontalTag COLLECTION ITEM }

CONST
	gxFlipPageHorizontalTag		= 'flph';


TYPE
	gxFlipPageHorizontalInfo = RECORD
		padByte:				CHAR;
		flipHorizontal:			BOOLEAN;								{ If true, flip x coordinates on page }
	END;

{ gxFlipPageVerticalTag COLLECTION ITEM }

CONST
	gxFlipPageVerticalTag		= 'flpv';


TYPE
	gxFlipPageVerticalInfo = RECORD
		padByte:				CHAR;
		flipVertical:			BOOLEAN;								{ If true, flip y coordinates on page }
	END;

{ gxPreciseBitmapsTag COLLECTION ITEM }

CONST
	gxPreciseBitmapsTag			= 'pbmp';


TYPE
	gxPreciseBitmapInfo = RECORD
		preciseBitmaps:			BOOLEAN;								{ If true, scale page by 96% }
		padByte:				CHAR;
	END;

{

	>>>>>> PAPERTYPE COLLECTION ITEMS <<<<<<

}
{ gxBaseTag COLLECTION ITEM }

CONST
	gxBaseTag					= 'base';


TYPE
	gxBaseInfo = RECORD
		baseType:				LONGINT;								{ PaperType's base type }
	END;

{ baseType field constants }

CONST
	gxUnknownBase				= 0;							{ Base paper type from which this paper type is }
	gxUSLetterBase				= 1;							{ derived.  This is not a complete set. }
	gxUSLegalBase				= 2;
	gxA4LetterBase				= 3;
	gxB5LetterBase				= 4;
	gxTabloidBase				= 5;

{ gxCreatorTag COLLECTION ITEM }
	gxCreatorTag				= 'crea';


TYPE
	gxCreatorInfo = RECORD
		creator:				OSType;									{ PaperType's creator }
	END;

{ gxUnitsTag COLLECTION ITEM }

CONST
	gxUnitsTag					= 'unit';


TYPE
	gxUnitsInfo = RECORD
		units:					CHAR;									{ PaperType's units (used by PaperType Editor). }
		padByte:				CHAR;
	END;

{ units field constants }

CONST
	gxPicas						= 0;							{ Pica measurement }
	gxMMs						= 1;							{ Millimeter measurement }
	gxInches					= 2;							{ Inches measurement }

{ gxFlagsTag COLLECTION ITEM }
	gxFlagsTag					= 'flag';


TYPE
	gxFlagsInfo = RECORD
		flags:					LONGINT;								{ PaperType's flags }
	END;

{ flags field constants }

CONST
	gxOldPaperTypeFlag			= $00800000;					{ Indicates a paper type for compatibility printing }
	gxNewPaperTypeFlag			= $00400000;					{ Indicates a paper type for QuickDraw GX-aware printing }
	gxOldAndNewFlag				= $00C00000;					{ Indicates a paper type that's both old and new }
	gxDefaultPaperTypeFlag		= $00100000;					{ Indicates the default paper type in the group }

{ gxCommentTag COLLECTION ITEM }
	gxCommentTag				= 'cmnt';


TYPE
	gxCommentInfo = RECORD
		comment:				Str255;									{ PaperType's comment }
	END;

{

	>>>>>> PRINTER VIEWDEVICE TAGS <<<<<<

}
{ gxPenTableTag COLLECTION ITEM }

CONST
	gxPenTableTag				= 'pent';


TYPE
	gxPenTableEntry = RECORD
		penName:				Str31;									{ Name of the pen }
		penColor:				gxColor;								{ Color to use from the color set }
		penThickness:			Fixed;									{ Size of the pen }
		penUnits:				INTEGER;								{ Specifies units in which pen thickness is defined }
		penPosition:			INTEGER;								{ Pen position in the carousel, -1 (kPenNotLoaded) if not loaded }
	END;

	gxPenTable = RECORD
		numPens:				LONGINT;								{ Number of pen entries in the following array }
		pens:					ARRAY [0..0] OF gxPenTableEntry;		{ Array of pen entries }
	END;

	gxPenTablePtr = ^gxPenTable;
	gxPenTableHdl = ^gxPenTablePtr;

{ penUnits field constants }

CONST
	gxDeviceUnits				= 0;
	gxMMUnits					= 1;
	gxInchesUnits				= 2;

{ penPosition field constants }
	gxPenNotLoaded				= -1;

{

	>>>>>> DIALOG-RELATED CONSTANTS AND TYPES <<<<<<

}
	
TYPE
	gxDialogResult = LONGINT;


CONST
	gxCancelSelected			= 0;
	gxOKSelected				= 1;
	gxRevertSelected			= 2;


TYPE
	gxEditMenuRecord = RECORD
		editMenuID:				INTEGER;
		cutItem:				INTEGER;
		copyItem:				INTEGER;
		pasteItem:				INTEGER;
		clearItem:				INTEGER;
		undoItem:				INTEGER;
	END;

{

	>>>>>> JOB FORMAT MODE CONSTANTS AND TYPES <<<<<<

}
	gxJobFormatMode = OSType;

	gxJobFormatModeTable = RECORD
		numModes:				LONGINT;								{ Number of job format modes to choose from }
		modes:					ARRAY [0..0] OF gxJobFormatMode;		{ The job format modes }
	END;

	gxJobFormatModeTablePtr = ^gxJobFormatModeTable;
	gxJobFormatModeTableHdl = ^gxJobFormatModeTablePtr;


CONST
	gxGraphicsJobFormatMode		= 'grph';
	gxTextJobFormatMode			= 'text';
	gxPostScriptJobFormatMode	= 'post';

	
TYPE
	gxQueryType = LONGINT;


CONST
	gxGetJobFormatLineConstraintQuery = 0;
	gxGetJobFormatFontsQuery	= 1;
	gxGetJobFormatFontCommonStylesQuery = 2;
	gxGetJobFormatFontConstraintQuery = 3;
	gxSetStyleJobFormatCommonStyleQuery = 4;

{ Structures used for Text mode field constants }

TYPE
	gxPositionConstraintTable = RECORD
		phase:					gxPoint;								{ Position phase }
		offset:					gxPoint;								{ Position offset }
		numSizes:				LONGINT;								{ Number of available font sizes }
		sizes:					ARRAY [0..0] OF Fixed;					{ The available font sizes }
	END;

	gxPositionConstraintTablePtr = ^gxPositionConstraintTable;
	gxPositionConstraintTableHdl = ^gxPositionConstraintTablePtr;

{ numSizes field constants }

CONST
	gxConstraintRange			= -1;


TYPE
	gxStyleNameTable = RECORD
		numStyleNames:			LONGINT;								{ Number of style names }
		styleNames:				ARRAY [0..0] OF Str255;					{ The style names }
	END;

	gxStyleNameTablePtr = ^gxStyleNameTable;
	gxStyleNameTableHdl = ^gxStyleNameTablePtr;

	gxFontTable = RECORD
		numFonts:				LONGINT;								{ Number of font references }
		fonts:					ARRAY [0..0] OF gxFont;					{ The font references }
	END;

	gxFontTablePtr = ^gxFontTable;
	gxFontTableHdl = ^gxFontTablePtr;

{ ------------------------------------------------------------------------------

								Printing Manager API Functions

-------------------------------------------------------------------------------- }

FUNCTION GXInitPrinting: OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 0, $ABFE;
	{$ENDC}
FUNCTION GXExitPrinting: OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 1, $ABFE;
	{$ENDC}
{
	Error-Handling Routines
}
FUNCTION GXGetJobError(aJob: gxJob): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 14, $ABFE;
	{$ENDC}
PROCEDURE GXSetJobError(aJob: gxJob; anErr: OSErr);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 15, $ABFE;
	{$ENDC}
{
	Job Routines
}
FUNCTION GXNewJob(VAR aJob: gxJob): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 2, $ABFE;
	{$ENDC}
FUNCTION GXDisposeJob(aJob: gxJob): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 3, $ABFE;
	{$ENDC}
PROCEDURE GXFlattenJob(aJob: gxJob; flattenProc: gxPrintingFlattenProc; aVoid: UNIV Ptr);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 4, $ABFE;
	{$ENDC}
FUNCTION GXUnflattenJob(aJob: gxJob; flattenProc: gxPrintingFlattenProc; aVoid: UNIV Ptr): gxJob;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 5, $ABFE;
	{$ENDC}
FUNCTION GXFlattenJobToHdl(aJob: gxJob; aHdl: Handle): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 6, $ABFE;
	{$ENDC}
FUNCTION GXUnflattenJobFromHdl(aJob: gxJob; aHdl: Handle): gxJob;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 7, $ABFE;
	{$ENDC}
PROCEDURE GXInstallApplicationOverride(aJob: gxJob; messageID: INTEGER; override: UNIV Ptr);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 8, $ABFE;
	{$ENDC}
FUNCTION GXGetJobCollection(aJob: gxJob): Collection;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 29, $ABFE;
	{$ENDC}
FUNCTION GXGetJobRefCon(aJob: gxJob): Ptr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 30, $ABFE;
	{$ENDC}
PROCEDURE GXSetJobRefCon(aJob: gxJob; refCon: UNIV Ptr);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 31, $ABFE;
	{$ENDC}
FUNCTION GXCopyJob(srcJob: gxJob; dstJob: gxJob): gxJob;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 32, $ABFE;
	{$ENDC}
PROCEDURE GXSelectJobFormattingPrinter(aJob: gxJob; VAR printerName: Str31);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 33, $ABFE;
	{$ENDC}
PROCEDURE GXSelectJobOutputPrinter(aJob: gxJob; VAR printerName: Str31);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 34, $ABFE;
	{$ENDC}
PROCEDURE GXForEachJobFormatDo(aJob: gxJob; formatProc: gxFormatProc; refCon: UNIV Ptr);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 35, $ABFE;
	{$ENDC}
FUNCTION GXCountJobFormats(aJob: gxJob): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 36, $ABFE;
	{$ENDC}
FUNCTION GXUpdateJob(aJob: gxJob): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 37, $ABFE;
	{$ENDC}
PROCEDURE GXConvertPrintRecord(aJob: gxJob; hPrint: THPrint);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 38, $ABFE;
	{$ENDC}
PROCEDURE GXIdleJob(aJob: gxJob);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 87, $ABFE;
	{$ENDC}
{
	Job Format Modes Routines
}
PROCEDURE GXSetAvailableJobFormatModes(aJob: gxJob; formatModeTable: gxJobFormatModeTableHdl);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 59, $ABFE;
	{$ENDC}
FUNCTION GXGetPreferredJobFormatMode(aJob: gxJob; VAR directOnly: BOOLEAN): gxJobFormatMode;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 60, $ABFE;
	{$ENDC}
FUNCTION GXGetJobFormatMode(aJob: gxJob): gxJobFormatMode;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 61, $ABFE;
	{$ENDC}
PROCEDURE GXSetJobFormatMode(aJob: gxJob; formatMode: gxJobFormatMode);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 62, $ABFE;
	{$ENDC}
PROCEDURE GXJobFormatModeQuery(aJob: gxJob; aQueryType: gxQueryType; srcData: UNIV Ptr; dstData: UNIV Ptr);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 63, $ABFE;
	{$ENDC}
{
	Format Routines
}
FUNCTION GXNewFormat(aJob: gxJob): gxFormat;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 9, $ABFE;
	{$ENDC}
PROCEDURE GXDisposeFormat(aFormat: gxFormat);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 10, $ABFE;
	{$ENDC}
FUNCTION GXGetJobFormat(aJob: gxJob; whichFormat: LONGINT): gxFormat;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 19, $ABFE;
	{$ENDC}
FUNCTION GXGetFormatJob(aFormat: gxFormat): gxJob;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 20, $ABFE;
	{$ENDC}
FUNCTION GXGetFormatPaperType(aFormat: gxFormat): gxPaperType;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 21, $ABFE;
	{$ENDC}
PROCEDURE GXGetFormatDimensions(aFormat: gxFormat; VAR pageSize: gxRectangle; VAR paperSize: gxRectangle);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 22, $ABFE;
	{$ENDC}
FUNCTION GXGetFormatCollection(aFormat: gxFormat): Collection;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 51, $ABFE;
	{$ENDC}
PROCEDURE GXChangedFormat(aFormat: gxFormat);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 52, $ABFE;
	{$ENDC}
FUNCTION GXCopyFormat(srcFormat: gxFormat; dstFormat: gxFormat): gxFormat;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 53, $ABFE;
	{$ENDC}
FUNCTION GXCloneFormat(aFormat: gxFormat): gxFormat;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 54, $ABFE;
	{$ENDC}
FUNCTION GXCountFormatOwners(aFormat: gxFormat): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 55, $ABFE;
	{$ENDC}
PROCEDURE GXGetFormatMapping(aFormat: gxFormat; VAR fmtMapping: gxMapping);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 56, $ABFE;
	{$ENDC}
FUNCTION GXGetFormatForm(aFormat: gxFormat; VAR mask: gxShape): gxShape;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 57, $ABFE;
	{$ENDC}
PROCEDURE GXSetFormatForm(aFormat: gxFormat; form: gxShape; mask: gxShape);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 58, $ABFE;
	{$ENDC}
{
	PaperType Routines
}
FUNCTION GXNewPaperType(aJob: gxJob; VAR name: Str31; VAR pageSize: gxRectangle; VAR paperSize: gxRectangle): gxPaperType;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 11, $ABFE;
	{$ENDC}
PROCEDURE GXDisposePaperType(aPaperType: gxPaperType);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 12, $ABFE;
	{$ENDC}
FUNCTION GXGetNewPaperType(aJob: gxJob; resID: INTEGER): gxPaperType;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 13, $ABFE;
	{$ENDC}
FUNCTION GXCountJobPaperTypes(aJob: gxJob; forFormatDevice: BOOLEAN): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 66, $ABFE;
	{$ENDC}
FUNCTION GXGetJobPaperType(aJob: gxJob; whichPaperType: LONGINT; forFormatDevice: BOOLEAN; aPaperType: gxPaperType): gxPaperType;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 67, $ABFE;
	{$ENDC}
PROCEDURE GXForEachJobPaperTypeDo(aJob: gxJob; aProc: gxPaperTypeProc; refCon: UNIV Ptr; forFormattingPrinter: BOOLEAN);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 68, $ABFE;
	{$ENDC}
FUNCTION GXCopyPaperType(srcPaperType: gxPaperType; dstPaperType: gxPaperType): gxPaperType;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 69, $ABFE;
	{$ENDC}
PROCEDURE GXGetPaperTypeName(aPaperType: gxPaperType; VAR papertypeName: Str31);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 70, $ABFE;
	{$ENDC}
PROCEDURE GXGetPaperTypeDimensions(aPaperType: gxPaperType; VAR pageSize: gxRectangle; VAR paperSize: gxRectangle);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 71, $ABFE;
	{$ENDC}
FUNCTION GXGetPaperTypeJob(aPaperType: gxPaperType): gxJob;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 72, $ABFE;
	{$ENDC}
FUNCTION GXGetPaperTypeCollection(aPaperType: gxPaperType): Collection;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 73, $ABFE;
	{$ENDC}
{
	Printer Routines
}
FUNCTION GXGetJobFormattingPrinter(aJob: gxJob): gxPrinter;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 39, $ABFE;
	{$ENDC}
FUNCTION GXGetJobOutputPrinter(aJob: gxJob): gxPrinter;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 40, $ABFE;
	{$ENDC}
FUNCTION GXGetJobPrinter(aJob: gxJob): gxPrinter;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 41, $ABFE;
	{$ENDC}
FUNCTION GXGetPrinterJob(aPrinter: gxPrinter): gxJob;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 42, $ABFE;
	{$ENDC}
PROCEDURE GXForEachPrinterViewDeviceDo(aPrinter: gxPrinter; aProc: gxViewDeviceProc; refCon: UNIV Ptr);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 43, $ABFE;
	{$ENDC}
FUNCTION GXCountPrinterViewDevices(aPrinter: gxPrinter): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 44, $ABFE;
	{$ENDC}
FUNCTION GXGetPrinterViewDevice(aPrinter: gxPrinter; whichViewDevice: LONGINT): gxViewDevice;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 45, $ABFE;
	{$ENDC}
PROCEDURE GXSelectPrinterViewDevice(aPrinter: gxPrinter; whichViewDevice: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 46, $ABFE;
	{$ENDC}
PROCEDURE GXGetPrinterName(aPrinter: gxPrinter; VAR printerName: Str31);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 47, $ABFE;
	{$ENDC}
FUNCTION GXGetPrinterType(aPrinter: gxPrinter): OSType;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 48, $ABFE;
	{$ENDC}
PROCEDURE GXGetPrinterDriverName(aPrinter: gxPrinter; VAR driverName: Str31);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 49, $ABFE;
	{$ENDC}
FUNCTION GXGetPrinterDriverType(aPrinter: gxPrinter): OSType;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 50, $ABFE;
	{$ENDC}
{
	Dialog Routines
}
FUNCTION GXJobDefaultFormatDialog(aJob: gxJob; VAR anEditMenuRec: gxEditMenuRecord): gxDialogResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 16, $ABFE;
	{$ENDC}
FUNCTION GXJobPrintDialog(aJob: gxJob; VAR anEditMenuRec: gxEditMenuRecord): gxDialogResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 17, $ABFE;
	{$ENDC}
FUNCTION GXFormatDialog(aFormat: gxFormat; VAR anEditMenuRec: gxEditMenuRecord; title: StringPtr): gxDialogResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 18, $ABFE;
	{$ENDC}
PROCEDURE GXEnableJobScalingPanel(aJob: gxJob; enabled: BOOLEAN);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 64, $ABFE;
	{$ENDC}
PROCEDURE GXGetJobPanelDimensions(aJob: gxJob; VAR panelArea: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 65, $ABFE;
	{$ENDC}
{
	Spooling Routines
}
PROCEDURE GXGetJobPageRange(theJob: gxJob; VAR firstPage: LONGINT; VAR lastPage: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 23, $ABFE;
	{$ENDC}
PROCEDURE GXStartJob(theJob: gxJob; docName: StringPtr; pageCount: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 24, $ABFE;
	{$ENDC}
PROCEDURE GXPrintPage(theJob: gxJob; pageNumber: LONGINT; theFormat: gxFormat; thePage: gxShape);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 25, $ABFE;
	{$ENDC}
FUNCTION GXStartPage(theJob: gxJob; pageNumber: LONGINT; theFormat: gxFormat; numViewPorts: LONGINT; VAR viewPortList: gxViewPort): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 26, $ABFE;
	{$ENDC}
PROCEDURE GXFinishPage(theJob: gxJob);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 27, $ABFE;
	{$ENDC}
PROCEDURE GXFinishJob(theJob: gxJob);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 28, $ABFE;
	{$ENDC}
{
	PrintFile Routines
}
FUNCTION GXOpenPrintFile(theJob: gxJob; anFSSpec: FSSpecPtr; permission: ByteParameter): gxPrintFile;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 74, $ABFE;
	{$ENDC}
PROCEDURE GXClosePrintFile(aPrintFile: gxPrintFile);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 75, $ABFE;
	{$ENDC}
FUNCTION GXGetPrintFileJob(aPrintFile: gxPrintFile): gxJob;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 76, $ABFE;
	{$ENDC}
FUNCTION GXCountPrintFilePages(aPrintFile: gxPrintFile): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 77, $ABFE;
	{$ENDC}
PROCEDURE GXReadPrintFilePage(aPrintFile: gxPrintFile; pageNumber: LONGINT; numViewPorts: LONGINT; VAR viewPortList: gxViewPort; VAR pgFormat: gxFormat; VAR pgShape: gxShape);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 78, $ABFE;
	{$ENDC}
PROCEDURE GXReplacePrintFilePage(aPrintFile: gxPrintFile; pageNumber: LONGINT; aFormat: gxFormat; aShape: gxShape);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 79, $ABFE;
	{$ENDC}
PROCEDURE GXInsertPrintFilePage(aPrintFile: gxPrintFile; atPageNumber: LONGINT; pgFormat: gxFormat; pgShape: gxShape);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 80, $ABFE;
	{$ENDC}
PROCEDURE GXDeletePrintFilePageRange(aPrintFile: gxPrintFile; fromPageNumber: LONGINT; toPageNumber: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 81, $ABFE;
	{$ENDC}
PROCEDURE GXSavePrintFile(aPrintFile: gxPrintFile; VAR anFSSpec: FSSpec);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 82, $ABFE;
	{$ENDC}
{
	ColorSync Routines
}
FUNCTION GXFindPrinterProfile(aPrinter: gxPrinter; searchData: UNIV Ptr; index: LONGINT; VAR returnedProfile: gxColorProfile): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 83, $ABFE;
	{$ENDC}
FUNCTION GXFindFormatProfile(aFormat: gxFormat; searchData: UNIV Ptr; index: LONGINT; VAR returnedProfile: gxColorProfile): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 84, $ABFE;
	{$ENDC}
PROCEDURE GXSetPrinterProfile(aPrinter: gxPrinter; oldProfile: gxColorProfile; newProfile: gxColorProfile);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 85, $ABFE;
	{$ENDC}
PROCEDURE GXSetFormatProfile(aFormat: gxFormat; oldProfile: gxColorProfile; newProfile: gxColorProfile);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 86, $ABFE;
	{$ENDC}
{***********************************************************************
						Start of old "GXPrintingResEquates.h/a/p" interface file.
				************************************************************************}
{	------------------------------------
				Basic client types
	------------------------------------ }

CONST
	gxPrintingManagerType		= 'pmgr';
	gxImagingSystemType			= 'gxis';
	gxPrinterDriverType			= 'pdvr';
	gxPrintingExtensionType		= 'pext';
	gxUnknownPrinterType		= 'none';
	gxAnyPrinterType			= 'univ';
	gxQuickdrawPrinterType		= 'qdrw';
	gxPortableDocPrinterType	= 'gxpd';
	gxRasterPrinterType			= 'rast';
	gxPostscriptPrinterType		= 'post';
	gxVectorPrinterType			= 'vect';

{ All pre-defined printing collection items have this ID }
	gxPrintingTagID				= -28672;

{	----------------------------------------------------------------------

		Resource types and IDs used by both extension and driver writers

	---------------------------------------------------------------------- }
{ Resources in a printer driver or extension must be based off of these IDs }
	gxPrintingDriverBaseID		= -27648;
	gxPrintingExtensionBaseID	= -27136;

{	Override resources tell the system what messages a driver or extension
		is overriding.  A driver may have a series of these resources. }
	gxOverrideType				= 'over';

{	--------------------------------------------------------------

		Message ID definitions by both extension and driver writers

	--------------------------------------------------------------- }
{ Identifiers for universal message overrides. }
	gxInitializeMsg				= 0;
	gxShutDownMsg				= 1;
	gxJobIdleMsg				= 2;
	gxJobStatusMsg				= 3;
	gxPrintingEventMsg			= 4;
	gxJobDefaultFormatDialogMsg	= 5;
	gxFormatDialogMsg			= 6;
	gxJobPrintDialogMsg			= 7;
	gxFilterPanelEventMsg		= 8;
	gxHandlePanelEventMsg		= 9;
	gxParsePageRangeMsg			= 10;
	gxDefaultJobMsg				= 11;
	gxDefaultFormatMsg			= 12;
	gxDefaultPaperTypeMsg		= 13;
	gxDefaultPrinterMsg			= 14;
	gxCreateSpoolFileMsg		= 15;
	gxSpoolPageMsg				= 16;
	gxSpoolDataMsg				= 17;
	gxSpoolResourceMsg			= 18;
	gxCompleteSpoolFileMsg		= 19;
	gxCountPagesMsg				= 20;
	gxDespoolPageMsg			= 21;
	gxDespoolDataMsg			= 22;
	gxDespoolResourceMsg		= 23;
	gxCloseSpoolFileMsg			= 24;
	gxStartJobMsg				= 25;
	gxFinishJobMsg				= 26;
	gxStartPageMsg				= 27;
	gxFinishPageMsg				= 28;
	gxPrintPageMsg				= 29;
	gxSetupImageDataMsg			= 30;
	gxImageJobMsg				= 31;
	gxImageDocumentMsg			= 32;
	gxImagePageMsg				= 33;
	gxRenderPageMsg				= 34;
	gxCreateImageFileMsg		= 35;
	gxOpenConnectionMsg			= 36;
	gxCloseConnectionMsg		= 37;
	gxStartSendPageMsg			= 38;
	gxFinishSendPageMsg			= 39;
	gxWriteDataMsg				= 40;
	gxBufferDataMsg				= 41;
	gxDumpBufferMsg				= 42;
	gxFreeBufferMsg				= 43;
	gxCheckStatusMsg			= 44;
	gxGetDeviceStatusMsg		= 45;
	gxFetchTaggedDataMsg		= 46;
	gxGetDTPMenuListMsg			= 47;
	gxDTPMenuSelectMsg			= 48;
	gxHandleAlertFilterMsg		= 49;
	gxJobFormatModeQueryMsg		= 50;
	gxWriteStatusToDTPWindowMsg	= 51;
	gxInitializeStatusAlertMsg	= 52;
	gxHandleAlertStatusMsg		= 53;
	gxHandleAlertEventMsg		= 54;
	gxCleanupStartJobMsg		= 55;
	gxCleanupStartPageMsg		= 56;
	gxCleanupOpenConnectionMsg	= 57;
	gxCleanupStartSendPageMsg	= 58;
	gxDefaultDesktopPrinterMsg	= 59;
	gxCaptureOutputDeviceMsg	= 60;
	gxOpenConnectionRetryMsg	= 61;
	gxExamineSpoolFileMsg		= 62;
	gxFinishSendPlaneMsg		= 63;
	gxDoesPaperFitMsg			= 64;
	gxChooserMessageMsg			= 65;
	gxFindPrinterProfileMsg		= 66;
	gxFindFormatProfileMsg		= 67;
	gxSetPrinterProfileMsg		= 68;
	gxSetFormatProfileMsg		= 69;
	gxHandleAltDestinationMsg	= 70;
	gxSetupPageImageDataMsg		= 71;

{ Identifiers for Quickdraw message overrides. }
	gxPrOpenDocMsg				= 0;
	gxPrCloseDocMsg				= 1;
	gxPrOpenPageMsg				= 2;
	gxPrClosePageMsg			= 3;
	gxPrintDefaultMsg			= 4;
	gxPrStlDialogMsg			= 5;
	gxPrJobDialogMsg			= 6;
	gxPrStlInitMsg				= 7;
	gxPrJobInitMsg				= 8;
	gxPrDlgMainMsg				= 9;
	gxPrValidateMsg				= 10;
	gxPrJobMergeMsg				= 11;
	gxPrGeneralMsg				= 12;
	gxConvertPrintRecordToMsg	= 13;
	gxConvertPrintRecordFromMsg	= 14;
	gxPrintRecordToJobMsg		= 15;

{ Identifiers for raster imaging message overrides. }
	gxRasterDataInMsg			= 0;
	gxRasterLineFeedMsg			= 1;
	gxRasterPackageBitmapMsg	= 2;

{ Identifiers for PostScript imaging message overrides. }
	gxPostscriptQueryPrinterMsg	= 0;
	gxPostscriptInitializePrinterMsg = 1;
	gxPostscriptResetPrinterMsg	= 2;
	gxPostscriptExitServerMsg	= 3;
	gxPostscriptGetStatusTextMsg = 4;
	gxPostscriptGetPrinterTextMsg = 5;
	gxPostscriptScanStatusTextMsg = 6;
	gxPostscriptScanPrinterTextMsg = 7;
	gxPostscriptGetDocumentProcSetListMsg = 8;
	gxPostscriptDownloadProcSetListMsg = 9;
	gxPostscriptGetPrinterGlyphsInformationMsg = 10;
	gxPostscriptStreamFontMsg	= 11;
	gxPostscriptDoDocumentHeaderMsg = 12;
	gxPostscriptDoDocumentSetUpMsg = 13;
	gxPostscriptDoDocumentTrailerMsg = 14;
	gxPostscriptDoPageSetUpMsg	= 15;
	gxPostscriptSelectPaperTypeMsg = 16;
	gxPostscriptDoPageTrailerMsg = 17;
	gxPostscriptEjectPageMsg	= 18;
	gxPostscriptProcessShapeMsg	= 19;
	gxPostScriptEjectPendingPageMsg = 20;

{ Identifiers for Vector imaging message overrides. }
	gxVectorPackageDataMsg		= 0;
	gxVectorLoadPensMsg			= 1;
	gxVectorVectorizeShapeMsg	= 2;

{ Dialog related resource types }
	gxPrintingAlertType			= 'plrt';
	gxStatusType				= 'stat';
	gxExtendedDITLType			= 'xdtl';
	gxPrintPanelType			= 'ppnl';
	gxCollectionType			= 'cltn';

{ Communication resource types }
{
	The looker resource is used by the Chooser PACK to determine what kind
	of communications this driver supports. (In order to generate/handle the 
	pop-up menu for "Connect via:".
	
	The looker resource is also used by PrinterShare to determine the AppleTalk NBP Type
	for servers created for this driver.
}
	gxLookerType				= 'look';
	gxLookerID					= -4096;

{ The communications method and private data used to connect to the printer }
	gxDeviceCommunicationsType	= 'comm';

{	-------------------------------------------------

	Resource types and IDs used by extension writers

	------------------------------------------------- }
	gxExtensionUniversalOverrideID = gxPrintingExtensionBaseID;

	gxExtensionImagingOverrideSelectorID = gxPrintingExtensionBaseID;

	gxExtensionScopeType		= 'scop';
	gxDriverScopeID				= gxPrintingExtensionBaseID;
	gxPrinterScopeID			= gxPrintingExtensionBaseID + 1;
	gxPrinterExceptionScopeID	= gxPrintingExtensionBaseID + 2;

	gxExtensionLoadType			= 'load';
	gxExtensionLoadID			= gxPrintingExtensionBaseID;

	gxExtensionLoadFirst		= $00000100;
	gxExtensionLoadAnywhere		= $7FFFFFFF;
	gxExtensionLoadLast			= $FFFFFF00;

	gxExtensionOptimizationType	= 'eopt';
	gxExtensionOptimizationID	= gxPrintingExtensionBaseID;

{	-----------------------------------------------

	Resource types and IDs used by driver writers

	----------------------------------------------- }
	gxDriverUniversalOverrideID	= gxPrintingDriverBaseID;
	gxDriverImagingOverrideID	= gxPrintingDriverBaseID + 1;
	gxDriverCompatibilityOverrideID = gxPrintingDriverBaseID + 2;

	gxDriverFileFormatType		= 'pfil';
	gxDriverFileFormatID		= gxPrintingDriverBaseID;

	gxDestinationAdditionType	= 'dsta';
	gxDestinationAdditionID		= gxPrintingDriverBaseID;

{ IMAGING RESOURCES }
{	The imaging system resource specifies which imaging system a printer
		driver wishes to use. }
	gxImagingSystemSelectorType	= 'isys';
	gxImagingSystemSelectorID	= gxPrintingDriverBaseID;

{ 'exft' resource ID -- exclude font list }
	kExcludeFontListType		= 'exft';
	kExcludeFontListID			= gxPrintingDriverBaseID;

{ Resource for type for color matching }
	gxColorMatchingDataType		= 'prof';
	gxColorMatchingDataID		= gxPrintingDriverBaseID;

{ Resource type and id for the tray count }
	gxTrayCountDataType			= 'tray';
	gxTrayCountDataID			= gxPrintingDriverBaseID;

{ Resource type for the tray names }
	gxTrayNameDataType			= 'tryn';

{ Resource type for manual feed preferences, stored in DTP. }
	gxManualFeedAlertPrefsType	= 'mfpr';
	gxManualFeedAlertPrefsID	= gxPrintingDriverBaseID;

{ Resource type for desktop printer output characteristics, stored in DTP. }
	gxDriverOutputType			= 'outp';
	gxDriverOutputTypeID		= 1;

{ IO Resources }
{ Resource type and ID for default IO and buffering resources }
	gxUniversalIOPrefsType		= 'iobm';
	gxUniversalIOPrefsID		= gxPrintingDriverBaseID;

{	Resource types and IDs for default implementation of CaptureOutputDevice.
		The default implementation of CaptureOutputDevice only handles PAP devices }
	gxCaptureType				= 'cpts';
	gxCaptureStringID			= gxPrintingDriverBaseID;
	gxReleaseStringID			= gxPrintingDriverBaseID + 1;
	gxUncapturedAppleTalkType	= gxPrintingDriverBaseID + 2;
	gxCapturedAppleTalkType		= gxPrintingDriverBaseID + 3;

{ Resource type and ID for custom halftone matrix }
	gxCustomMatrixType			= 'dmat';
	gxCustomMatrixID			= gxPrintingDriverBaseID;

{ Resource type and ID for raster driver rendering preferences }
	gxRasterPrefsType			= 'rdip';
	gxRasterPrefsID				= gxPrintingDriverBaseID;

{ Resource type for specifiying a colorset }
	gxColorSetResType			= 'crst';

{ Resource type and ID for raster driver packaging preferences }
	gxRasterPackType			= 'rpck';
	gxRasterPackID				= gxPrintingDriverBaseID;

{ Resource type and ID for raster driver packaging options }
	gxRasterNumNone				= 0;							{ Number isn't output at all }
	gxRasterNumDirect			= 1;							{ Lowest minWidth bytes as data }
	gxRasterNumToASCII			= 2;							{ minWidth ASCII characters }

	gxRasterPackOptionsType		= 'ropt';
	gxRasterPackOptionsID		= gxPrintingDriverBaseID;

{ Resource type for the PostScript imaging system procedure set control resource }
	gxPostscriptProcSetControlType = 'prec';

{ Resource type for the PostScript imaging system printer font resource }
	gxPostscriptPrinterFontType	= 'pfnt';

{ Resource type and id for the PostScript imaging system imaging preferences }
	gxPostscriptPrefsType		= 'pdip';
	gxPostscriptPrefsID			= gxPrintingDriverBaseID;

{ Resource type and id for the PostScript imaging system default scanning code }
	gxPostscriptScanningType	= 'scan';
	gxPostscriptScanningID		= gxPrintingDriverBaseID;

{ Old Application Support Resources }
	gxCustType					= 'cust';
	gxCustID					= -8192;

	gxReslType					= 'resl';
	gxReslID					= -8192;

	gxDiscreteResolution		= 0;

	gxStlDialogResID			= -8192;

	gxJobDialogResID			= -8191;

	gxScaleTableType			= 'stab';
	gxDITLControlType			= 'dctl';

{	The default implementation of gxPrintDefault loads and
	PrValidates a print record stored in the following driver resource. }
	gxPrintRecordType			= 'PREC';
	gxDefaultPrintRecordID		= 0;

{
	-----------------------------------------------

	Resource types and IDs used in papertype files

	-----------------------------------------------
}
{ Resource type and ID for driver papertypes placed in individual files }
	gxSignatureType				= 'sig ';
	gxPapertypeSignatureID		= 0;

{ Papertype creator types }
	gxDrvrPaperType				= 'drpt';
	gxSysPaperType				= 'sypt';						{ System paper type creator }
	gxUserPaperType				= 'uspt';						{ User paper type creator }
{ Driver creator types == driver file's creator value }
	gxPaperTypeType				= 'ptyp';

{********************************************************************
					Start of old "GXPrintingMessages.h/a/p" interface file.
			*********************************************************************}
{ ------------------------------------------------------------------------------

									Constants and Types

-------------------------------------------------------------------------------- }
{

	ABSTRACT DATA TYPES

}
	
TYPE
	gxSpoolFile = Ptr;

	gxPanelEvent = LONGINT;

{ Dialog panel event equates }

CONST
	gxPanelNoEvt				= 0;
	gxPanelOpenEvt				= 1;							{ Initialize and draw }
	gxPanelCloseEvt				= 2;							{ Your panel is going away (panel switch, confirm or cancel) }
	gxPanelHitEvt				= 3;							{ There's a hit in your panel }
	gxPanelActivateEvt			= 4;							{ The dialog window has just been activated }
	gxPanelDeactivateEvt		= 5;							{ The dialog window is about to be deactivated }
	gxPanelIconFocusEvt			= 6;							{ The focus changes from the panel to the icon list }
	gxPanelPanelFocusEvt		= 7;							{ The focus changes from the icon list to the panel }
	gxPanelFilterEvt			= 8;							{ Every event is filtered }
	gxPanelCancelEvt			= 9;							{ The user has cancelled the dialog }
	gxPanelConfirmEvt			= 10;							{ The user has confirmed the dialog }
	gxPanelDialogEvt			= 11;							{ Event to be handle by dialoghandler }
	gxPanelOtherEvt				= 12;							{ osEvts, etc. }
	gxPanelUserWillConfirmEvt	= 13;							{ User has selected confirm, time to parse panel interdependencies }

{ Constants for panel responses to dialog handler calls }
	
TYPE
	gxPanelResult = LONGINT;


CONST
	gxPanelNoResult				= 0;
	gxPanelCancelConfirmation	= 1;							{ Only valid from panelUserWillConfirmEvt - used to keep the dialog from going away }

{ Panel event info record for FilterPanelEvent and HandlePanelEvent messages }

TYPE
	gxPanelInfoRecord = RECORD
		panelEvt:				gxPanelEvent;							{ Why we were called }
		panelResId:				INTEGER;								{ 'ppnl' resource id of current panel }
		pDlg:					DialogPtr;								{ Pointer to dialog }
		theEvent:				^EventRecord;							{ Pointer to event }
		itemHit:				INTEGER;								{ Actual item number as Dialog Mgr thinks }
		itemCount:				INTEGER;								{ Number of items before your items }
		evtAction:				INTEGER;								{ Once this event is processed, the action that will result }
		{ (evtAction is only meaningful during filtering) }
		errorStringId:			INTEGER;								{ STR id of string to put in error alert (0 means no string) }
		theFormat:				gxFormat;								{ The current format (only meaningful in a format dialog) }
		refCon:					Ptr;									{ refCon passed in PanelSetupRecord }
	END;

{ Constants for the evtAction field in PanelInfoRecord }

CONST
	gxOtherAction				= 0;							{ Current item will not change }
	gxClosePanelAction			= 1;							{ Panel will be closed }
	gxCancelDialogAction		= 2;							{ Dialog will be cancelled }
	gxConfirmDialogAction		= 3;							{ Dialog will be confirmed }

{ Constants for the panelKind field in gxPanelSetupRecord }
	
TYPE
	gxPrintingPanelKind = LONGINT;

{ The gxPanelSetupInfo structure is passed to GXSetupDialogPanel }
	gxPanelSetupRecord = RECORD
		panelKind:				gxPrintingPanelKind;
		panelResId:				INTEGER;
		resourceRefNum:			INTEGER;
		refCon:					Ptr;
	END;


CONST
	gxApplicationPanel			= 0;
	gxExtensionPanel			= 1;
	gxDriverPanel				= 2;

{ Constants returned by gxParsePageRange message }
	
TYPE
	gxParsePageRangeResult = LONGINT;


CONST
	gxRangeNotParsed			= 0;							{ Default initial value }
	gxRangeParsed				= 1;							{ Range has been parsed }
	gxRangeBadFromValue			= 2;							{ From value is bad }
	gxRangeBadToValue			= 3;							{ To value is bad }

{

	STATUS-RELATED CONSTANTS AND TYPES

}
{ Structure for status messages }

TYPE
	gxStatusRecord = RECORD
		statusType:				INTEGER;								{ One of the ids listed above (nonFatalError, etc. ) }
		statusId:				INTEGER;								{ Specific status (out of paper, etc.) }
		statusAlertId:			INTEGER;								{	Printing alert id (if any) for status }
		statusOwner:			gxOwnerSignature;						{ Creator type of status owner }
		statResId:				INTEGER;								{ ID for 'stat' resource }
		statResIndex:			INTEGER;								{ Index into 'stat' resource for this status }
		dialogResult:			INTEGER;								{ ID of button string selected on dismissal of printing alert }
		bufferLen:				INTEGER;								{ Number of bytes in status buffer - total record size must be <= 512 }
		statusBuffer:			ARRAY [0..0] OF CHAR;					{ User response from alert }
	END;

{ Constants for statusType field of gxStatusRecord }

CONST
	gxNonFatalError				= 1;							{ An error occurred, but the job can continue }
	gxFatalError				= 2;							{ A fatal error occurred-- halt job }
	gxPrinterReady				= 3;							{ Tells QDGX to leave alert mode }
	gxUserAttention				= 4;							{ Signals initiation of a modal alert }
	gxUserAlert					= 5;							{ Signals initiation of a moveable modal alert }
	gxPageTransmission			= 6;							{ Signals page sent to printer, increments page count in strings to user }
	gxOpenConnectionStatus		= 7;							{ Signals QDGX to begin animation on printer icon }
	gxInformationalStatus		= 8;							{ Default status type, no side effects }
	gxSpoolingPageStatus		= 9;							{ Signals page spooled, increments page count in spooling dialog }
	gxEndStatus					= 10;							{ Signals end of spooling }
	gxPercentageStatus			= 11;							{ Signals QDGX as to the amount of the job which is currently complete }

{ Structure for gxWriteStatusToDTPWindow message }

TYPE
	gxDisplayRecord = RECORD
		useText:				BOOLEAN;								{ Use text as opposed to a picture }
		padByte:				CHAR;
		hPicture:				Handle;									{ if !useText, the picture handle }
		theText:				Str255;									{ if useText, the text }
	END;

{-----------------------------------------------}
{ paper mapping-related constants and types...  }
{-----------------------------------------------}
	gxTrayMapping = LONGINT;


CONST
	gxDefaultTrayMapping		= 0;
	gxConfiguredTrayMapping		= 1;

{ ------------------------------------------------------------------------------

				API Functions callable only from within message overrides

-------------------------------------------------------------------------------- }
{$IFC NOT GENERATINGPOWERPC }
{$ENDC}

FUNCTION GXGetJob: gxJob; C;
FUNCTION GXGetMessageHandlerResFile: INTEGER; C;
FUNCTION GXSpoolingAborted: BOOLEAN; C;
FUNCTION GXJobIdle: OSErr; C;
FUNCTION GXReportStatus(statusID: LONGINT; statusIndex: LONGINT): OSErr; C;
FUNCTION GXAlertTheUser(VAR statusRec: gxStatusRecord): OSErr; C;
FUNCTION GXSetupDialogPanel(VAR panelRec: gxPanelSetupRecord): OSErr; C;
FUNCTION GXCountTrays(VAR numTrays: gxTrayIndex): OSErr; C;
FUNCTION GXGetTrayName(trayNumber: gxTrayIndex; VAR trayName: Str31): OSErr; C;
FUNCTION GXSetTrayPaperType(whichTray: gxTrayIndex; aPapertype: gxPaperType): OSErr; C;
FUNCTION GXGetTrayPaperType(whichTray: gxTrayIndex; aPapertype: gxPaperType): OSErr; C;
FUNCTION GXGetTrayMapping(VAR trayMapping: gxTrayMapping): OSErr; C;
PROCEDURE GXCleanupStartJob; C;
PROCEDURE GXCleanupStartPage; C;
PROCEDURE GXCleanupOpenConnection; C;
PROCEDURE GXCleanupStartSendPage; C;
{ ------------------------------------------------------------------------------

					Constants and types for Universal Printing Messages

-------------------------------------------------------------------------------- }
{ Options for gxCreateSpoolFile message }

CONST
	gxNoCreateOptions			= $00000000;					{ Just create the file }
	gxInhibitAlias				= $00000001;					{ Do not create an alias in the PMD folder }
	gxInhibitUniqueName			= $00000002;					{ Do not append to the filename to make it unique }
	gxResolveBitmapAlias		= $00000004;					{ Resolve bitmap aliases and duplicate data in file }

{ Options for gxCloseSpoolFile message }
	gxNoCloseOptions			= $00000000;					{ Just close the file }
	gxDeleteOnClose				= $00000001;					{ Delete the file rather than closing it }
	gxUpdateJobData				= $00000002;					{ Write current job information into file prior to closing }
	gxMakeRemoteFile			= $00000004;					{ Mark job as a remote file }

{ Options for gxCreateImageFile message }
	gxNoImageFile				= $00000000;					{ Don't create image file }
	gxMakeImageFile				= $00000001;					{ Create an image file }
	gxEachPlane					= $00000002;					{ Only save up planes before rewinding }
	gxEachPage					= $00000004;					{ Save up entire pages before rewinding }
	gxEntireFile				= gxEachPlane + gxEachPage;		{ Save up the entire file before rewinding }

{ Options for gxBufferData message }
	gxNoBufferOptions			= $00000000;
	gxMakeBufferHex				= $00000001;
	gxDontSplitBuffer			= $00000002;

{ Structure for gxDumpBuffer and gxFreeBuffer messages }

TYPE
	gxPrintingBuffer = RECORD
		size:					LONGINT;								{ Size of buffer in bytes }
		userData:				LONGINT;								{ Client assigned id for the buffer }
		data:					ARRAY [0..0] OF CHAR;					{ Array of size bytes }
	END;

{ Structure for gxRenderPage message }
	gxPageInfoRecord = RECORD
		docPageNum:				LONGINT;								{ Number of page being printed }
		copyNum:				LONGINT;								{ Copy number being printed }
		formatChanged:			BOOLEAN;								{ True if format changed from last page }
		pageChanged:			BOOLEAN;								{ True if page contents changed from last page }
		internalUse:			LONGINT;								{ Private }
	END;

{ ------------------------------------------------------------------------------

								Universal Printing Messages

-------------------------------------------------------------------------------- }
	GXJobIdleProcPtr = ProcPtr;  { FUNCTION GXJobIdle: OSErr; }
	GXJobIdleUPP = UniversalProcPtr;

CONST
	uppGXJobIdleProcInfo = $00000021; { FUNCTION : 2 byte result; }

FUNCTION NewGXJobIdleProc(userRoutine: GXJobIdleProcPtr): GXJobIdleUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXJobIdleProc(userRoutine: GXJobIdleUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXJobIdleProc = GXJobIdleUPP;


FUNCTION Send_GXJobIdle: OSErr; C;
FUNCTION Forward_GXJobIdle: OSErr; C;
TYPE
	GXJobStatusProcPtr = ProcPtr;  { FUNCTION GXJobStatus(VAR pStatus: gxStatusRecord): OSErr; }
	GXJobStatusUPP = UniversalProcPtr;

CONST
	uppGXJobStatusProcInfo = $000000E1; { FUNCTION (4 byte param): 2 byte result; }

FUNCTION NewGXJobStatusProc(userRoutine: GXJobStatusProcPtr): GXJobStatusUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXJobStatusProc(VAR pStatus: gxStatusRecord; userRoutine: GXJobStatusUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXJobStatusProc = GXJobStatusUPP;


FUNCTION Send_GXJobStatus(VAR pStatus: gxStatusRecord): OSErr; C;
FUNCTION Forward_GXJobStatus(VAR pStatus: gxStatusRecord): OSErr; C;
TYPE
	GXPrintingEventProcPtr = ProcPtr;  { FUNCTION GXPrintingEvent(VAR evtRecord: EventRecord; filterEvent: BOOLEAN): OSErr; }
	GXPrintingEventUPP = UniversalProcPtr;

CONST
	uppGXPrintingEventProcInfo = $000001E1; { FUNCTION (4 byte param, 1 byte param): 2 byte result; }

FUNCTION NewGXPrintingEventProc(userRoutine: GXPrintingEventProcPtr): GXPrintingEventUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXPrintingEventProc(VAR evtRecord: EventRecord; filterEvent: BOOLEAN; userRoutine: GXPrintingEventUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXPrintingEventProc = GXPrintingEventUPP;


FUNCTION Send_GXPrintingEvent(VAR evtRecord: EventRecord; filterEvent: BOOLEAN): OSErr; C;
FUNCTION Forward_GXPrintingEvent(VAR evtRecord: EventRecord; filterEvent: BOOLEAN): OSErr; C;
TYPE
	GXJobDefaultFormatDialogProcPtr = ProcPtr;  { FUNCTION GXJobDefaultFormatDialog(VAR dlgResult: gxDialogResult): OSErr; }
	GXJobDefaultFormatDialogUPP = UniversalProcPtr;

CONST
	uppGXJobDefaultFormatDialogProcInfo = $000000E1; { FUNCTION (4 byte param): 2 byte result; }

FUNCTION NewGXJobDefaultFormatDialogProc(userRoutine: GXJobDefaultFormatDialogProcPtr): GXJobDefaultFormatDialogUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXJobDefaultFormatDialogProc(VAR dlgResult: gxDialogResult; userRoutine: GXJobDefaultFormatDialogUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXJobDefaultFormatDialogProc = GXJobDefaultFormatDialogUPP;


FUNCTION Send_GXJobDefaultFormatDialog(VAR dlgResult: gxDialogResult): OSErr; C;
FUNCTION Forward_GXJobDefaultFormatDialog(VAR dlgResult: gxDialogResult): OSErr; C;
TYPE
	GXFormatDialogProcPtr = ProcPtr;  { FUNCTION GXFormatDialog(theFormat: gxFormat; title: StringPtr; VAR dlgResult: gxDialogResult): OSErr; }
	GXFormatDialogUPP = UniversalProcPtr;

CONST
	uppGXFormatDialogProcInfo = $00000FE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXFormatDialogProc(userRoutine: GXFormatDialogProcPtr): GXFormatDialogUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXFormatDialogProc(theFormat: gxFormat; title: StringPtr; VAR dlgResult: gxDialogResult; userRoutine: GXFormatDialogUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXFormatDialogProc = GXFormatDialogUPP;


FUNCTION Send_GXFormatDialog(theFormat: gxFormat; title: StringPtr; VAR dlgResult: gxDialogResult): OSErr; C;
FUNCTION Forward_GXFormatDialog(theFormat: gxFormat; title: StringPtr; VAR dlgResult: gxDialogResult): OSErr; C;
TYPE
	GXJobPrintDialogProcPtr = ProcPtr;  { FUNCTION GXJobPrintDialog(VAR dlgResult: gxDialogResult): OSErr; }
	GXJobPrintDialogUPP = UniversalProcPtr;

CONST
	uppGXJobPrintDialogProcInfo = $000000E1; { FUNCTION (4 byte param): 2 byte result; }

FUNCTION NewGXJobPrintDialogProc(userRoutine: GXJobPrintDialogProcPtr): GXJobPrintDialogUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXJobPrintDialogProc(VAR dlgResult: gxDialogResult; userRoutine: GXJobPrintDialogUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXJobPrintDialogProc = GXJobPrintDialogUPP;


FUNCTION Send_GXJobPrintDialog(VAR dlgResult: gxDialogResult): OSErr; C;
FUNCTION Forward_GXJobPrintDialog(VAR dlgResult: gxDialogResult): OSErr; C;
TYPE
	GXFilterPanelEventProcPtr = ProcPtr;  { FUNCTION GXFilterPanelEvent(VAR pHitInfo: gxPanelInfoRecord; VAR returnImmed: BOOLEAN): OSErr; }
	GXFilterPanelEventUPP = UniversalProcPtr;

CONST
	uppGXFilterPanelEventProcInfo = $000003E1; { FUNCTION (4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXFilterPanelEventProc(userRoutine: GXFilterPanelEventProcPtr): GXFilterPanelEventUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXFilterPanelEventProc(VAR pHitInfo: gxPanelInfoRecord; VAR returnImmed: BOOLEAN; userRoutine: GXFilterPanelEventUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXFilterPanelEventProc = GXFilterPanelEventUPP;


FUNCTION Send_GXFilterPanelEvent(VAR pHitInfo: gxPanelInfoRecord; VAR returnImmed: BOOLEAN): OSErr; C;
TYPE
	GXHandlePanelEventProcPtr = ProcPtr;  { FUNCTION GXHandlePanelEvent(VAR pHitInfo: gxPanelInfoRecord; VAR panelResponse: gxPanelResult): OSErr; }
	GXHandlePanelEventUPP = UniversalProcPtr;

CONST
	uppGXHandlePanelEventProcInfo = $000003E1; { FUNCTION (4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXHandlePanelEventProc(userRoutine: GXHandlePanelEventProcPtr): GXHandlePanelEventUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXHandlePanelEventProc(VAR pHitInfo: gxPanelInfoRecord; VAR panelResponse: gxPanelResult; userRoutine: GXHandlePanelEventUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXHandlePanelEventProc = GXHandlePanelEventUPP;


FUNCTION Send_GXHandlePanelEvent(VAR pHitInfo: gxPanelInfoRecord; VAR panelResponse: gxPanelResult): OSErr; C;
TYPE
	GXParsePageRangeProcPtr = ProcPtr;  { FUNCTION GXParsePageRange(fromString: StringPtr; toString: StringPtr; VAR result: gxParsePageRangeResult): OSErr; }
	GXParsePageRangeUPP = UniversalProcPtr;

CONST
	uppGXParsePageRangeProcInfo = $00000FE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXParsePageRangeProc(userRoutine: GXParsePageRangeProcPtr): GXParsePageRangeUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXParsePageRangeProc(fromString: StringPtr; toString: StringPtr; VAR result: gxParsePageRangeResult; userRoutine: GXParsePageRangeUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXParsePageRangeProc = GXParsePageRangeUPP;


FUNCTION Send_GXParsePageRange(fromString: StringPtr; toString: StringPtr; VAR result: gxParsePageRangeResult): OSErr; C;
FUNCTION Forward_GXParsePageRange(fromString: StringPtr; toString: StringPtr; VAR result: gxParsePageRangeResult): OSErr; C;
TYPE
	GXDefaultJobProcPtr = ProcPtr;  { FUNCTION GXDefaultJob: OSErr; }
	GXDefaultJobUPP = UniversalProcPtr;

CONST
	uppGXDefaultJobProcInfo = $00000021; { FUNCTION : 2 byte result; }

FUNCTION NewGXDefaultJobProc(userRoutine: GXDefaultJobProcPtr): GXDefaultJobUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXDefaultJobProc(userRoutine: GXDefaultJobUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXDefaultJobProc = GXDefaultJobUPP;


FUNCTION Send_GXDefaultJob: OSErr; C;
FUNCTION Forward_GXDefaultJob: OSErr; C;
TYPE
	GXDefaultFormatProcPtr = ProcPtr;  { FUNCTION GXDefaultFormat(theFormat: gxFormat): OSErr; }
	GXDefaultFormatUPP = UniversalProcPtr;

CONST
	uppGXDefaultFormatProcInfo = $000000E1; { FUNCTION (4 byte param): 2 byte result; }

FUNCTION NewGXDefaultFormatProc(userRoutine: GXDefaultFormatProcPtr): GXDefaultFormatUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXDefaultFormatProc(theFormat: gxFormat; userRoutine: GXDefaultFormatUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXDefaultFormatProc = GXDefaultFormatUPP;


FUNCTION Send_GXDefaultFormat(theFormat: gxFormat): OSErr; C;
FUNCTION Forward_GXDefaultFormat(theFormat: gxFormat): OSErr; C;
TYPE
	GXDefaultPaperTypeProcPtr = ProcPtr;  { FUNCTION GXDefaultPaperType(thePaperType: gxPaperType): OSErr; }
	GXDefaultPaperTypeUPP = UniversalProcPtr;

CONST
	uppGXDefaultPaperTypeProcInfo = $000000E1; { FUNCTION (4 byte param): 2 byte result; }

FUNCTION NewGXDefaultPaperTypeProc(userRoutine: GXDefaultPaperTypeProcPtr): GXDefaultPaperTypeUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXDefaultPaperTypeProc(thePaperType: gxPaperType; userRoutine: GXDefaultPaperTypeUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXDefaultPaperTypeProc = GXDefaultPaperTypeUPP;


FUNCTION Send_GXDefaultPaperType(thePaperType: gxPaperType): OSErr; C;
FUNCTION Forward_GXDefaultPaperType(thePaperType: gxPaperType): OSErr; C;
TYPE
	GXDefaultPrinterProcPtr = ProcPtr;  { FUNCTION GXDefaultPrinter(thePrinter: gxPrinter): OSErr; }
	GXDefaultPrinterUPP = UniversalProcPtr;

CONST
	uppGXDefaultPrinterProcInfo = $000000E1; { FUNCTION (4 byte param): 2 byte result; }

FUNCTION NewGXDefaultPrinterProc(userRoutine: GXDefaultPrinterProcPtr): GXDefaultPrinterUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXDefaultPrinterProc(thePrinter: gxPrinter; userRoutine: GXDefaultPrinterUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXDefaultPrinterProc = GXDefaultPrinterUPP;


FUNCTION Send_GXDefaultPrinter(thePrinter: gxPrinter): OSErr; C;
FUNCTION Forward_GXDefaultPrinter(thePrinter: gxPrinter): OSErr; C;
TYPE
	GXCreateSpoolFileProcPtr = ProcPtr;  { FUNCTION GXCreateSpoolFile(pFileSpec: FSSpecPtr; createOptions: LONGINT; VAR theSpoolFile: gxSpoolFile): OSErr; }
	GXCreateSpoolFileUPP = UniversalProcPtr;

CONST
	uppGXCreateSpoolFileProcInfo = $00000FE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXCreateSpoolFileProc(userRoutine: GXCreateSpoolFileProcPtr): GXCreateSpoolFileUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXCreateSpoolFileProc(pFileSpec: FSSpecPtr; createOptions: LONGINT; VAR theSpoolFile: gxSpoolFile; userRoutine: GXCreateSpoolFileUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXCreateSpoolFileProc = GXCreateSpoolFileUPP;


FUNCTION Send_GXCreateSpoolFile(pFileSpec: FSSpecPtr; createOptions: LONGINT; VAR theSpoolFile: gxSpoolFile): OSErr; C;
FUNCTION Forward_GXCreateSpoolFile(pFileSpec: FSSpecPtr; createOptions: LONGINT; VAR theSpoolFile: gxSpoolFile): OSErr; C;
TYPE
	GXSpoolPageProcPtr = ProcPtr;  { FUNCTION GXSpoolPage(theSpoolFile: gxSpoolFile; theFormat: gxFormat; thePage: gxShape): OSErr; }
	GXSpoolPageUPP = UniversalProcPtr;

CONST
	uppGXSpoolPageProcInfo = $00000FE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXSpoolPageProc(userRoutine: GXSpoolPageProcPtr): GXSpoolPageUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXSpoolPageProc(theSpoolFile: gxSpoolFile; theFormat: gxFormat; thePage: gxShape; userRoutine: GXSpoolPageUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXSpoolPageProc = GXSpoolPageUPP;


FUNCTION Send_GXSpoolPage(theSpoolFile: gxSpoolFile; theFormat: gxFormat; thePage: gxShape): OSErr; C;
FUNCTION Forward_GXSpoolPage(theSpoolFile: gxSpoolFile; theFormat: gxFormat; thePage: gxShape): OSErr; C;
TYPE
	GXSpoolDataProcPtr = ProcPtr;  { FUNCTION GXSpoolData(theSpoolFile: gxSpoolFile; data: Ptr; VAR length: LONGINT): OSErr; }
	GXSpoolDataUPP = UniversalProcPtr;

CONST
	uppGXSpoolDataProcInfo = $00000FE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXSpoolDataProc(userRoutine: GXSpoolDataProcPtr): GXSpoolDataUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXSpoolDataProc(theSpoolFile: gxSpoolFile; data: Ptr; VAR length: LONGINT; userRoutine: GXSpoolDataUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXSpoolDataProc = GXSpoolDataUPP;


FUNCTION Send_GXSpoolData(theSpoolFile: gxSpoolFile; data: Ptr; VAR length: LONGINT): OSErr; C;
FUNCTION Forward_GXSpoolData(theSpoolFile: gxSpoolFile; data: Ptr; VAR length: LONGINT): OSErr; C;
TYPE
	GXSpoolResourceProcPtr = ProcPtr;  { FUNCTION GXSpoolResource(theSpoolFile: gxSpoolFile; theResource: Handle; theType: ResType; id: LONGINT): OSErr; }
	GXSpoolResourceUPP = UniversalProcPtr;

CONST
	uppGXSpoolResourceProcInfo = $00003FE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXSpoolResourceProc(userRoutine: GXSpoolResourceProcPtr): GXSpoolResourceUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXSpoolResourceProc(theSpoolFile: gxSpoolFile; theResource: Handle; theType: ResType; id: LONGINT; userRoutine: GXSpoolResourceUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXSpoolResourceProc = GXSpoolResourceUPP;


FUNCTION Send_GXSpoolResource(theSpoolFile: gxSpoolFile; theResource: Handle; theType: ResType; id: LONGINT): OSErr; C;
FUNCTION Forward_GXSpoolResource(theSpoolFile: gxSpoolFile; theResource: Handle; theType: ResType; id: LONGINT): OSErr; C;
TYPE
	GXCompleteSpoolFileProcPtr = ProcPtr;  { FUNCTION GXCompleteSpoolFile(theSpoolFile: gxSpoolFile): OSErr; }
	GXCompleteSpoolFileUPP = UniversalProcPtr;

CONST
	uppGXCompleteSpoolFileProcInfo = $000000E1; { FUNCTION (4 byte param): 2 byte result; }

FUNCTION NewGXCompleteSpoolFileProc(userRoutine: GXCompleteSpoolFileProcPtr): GXCompleteSpoolFileUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXCompleteSpoolFileProc(theSpoolFile: gxSpoolFile; userRoutine: GXCompleteSpoolFileUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXCompleteSpoolFileProc = GXCompleteSpoolFileUPP;


FUNCTION Send_GXCompleteSpoolFile(theSpoolFile: gxSpoolFile): OSErr; C;
FUNCTION Forward_GXCompleteSpoolFile(theSpoolFile: gxSpoolFile): OSErr; C;
TYPE
	GXCountPagesProcPtr = ProcPtr;  { FUNCTION GXCountPages(theSpoolFile: gxSpoolFile; VAR numPages: LONGINT): OSErr; }
	GXCountPagesUPP = UniversalProcPtr;

CONST
	uppGXCountPagesProcInfo = $000003E1; { FUNCTION (4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXCountPagesProc(userRoutine: GXCountPagesProcPtr): GXCountPagesUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXCountPagesProc(theSpoolFile: gxSpoolFile; VAR numPages: LONGINT; userRoutine: GXCountPagesUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXCountPagesProc = GXCountPagesUPP;


FUNCTION Send_GXCountPages(theSpoolFile: gxSpoolFile; VAR numPages: LONGINT): OSErr; C;
FUNCTION Forward_GXCountPages(theSpoolFile: gxSpoolFile; VAR numPages: LONGINT): OSErr; C;
TYPE
	GXDespoolPageProcPtr = ProcPtr;  { FUNCTION GXDespoolPage(theSpoolFile: gxSpoolFile; numPages: LONGINT; theFormat: gxFormat; VAR thePage: gxShape; VAR formatChanged: BOOLEAN): OSErr; }
	GXDespoolPageUPP = UniversalProcPtr;

CONST
	uppGXDespoolPageProcInfo = $0000FFE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXDespoolPageProc(userRoutine: GXDespoolPageProcPtr): GXDespoolPageUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXDespoolPageProc(theSpoolFile: gxSpoolFile; numPages: LONGINT; theFormat: gxFormat; VAR thePage: gxShape; VAR formatChanged: BOOLEAN; userRoutine: GXDespoolPageUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXDespoolPageProc = GXDespoolPageUPP;


FUNCTION Send_GXDespoolPage(theSpoolFile: gxSpoolFile; numPages: LONGINT; theFormat: gxFormat; VAR thePage: gxShape; VAR formatChanged: BOOLEAN): OSErr; C;
FUNCTION Forward_GXDespoolPage(theSpoolFile: gxSpoolFile; numPages: LONGINT; theFormat: gxFormat; VAR thePage: gxShape; VAR formatChanged: BOOLEAN): OSErr; C;
TYPE
	GXDespoolDataProcPtr = ProcPtr;  { FUNCTION GXDespoolData(theSpoolFile: gxSpoolFile; data: Ptr; VAR length: LONGINT): OSErr; }
	GXDespoolDataUPP = UniversalProcPtr;

CONST
	uppGXDespoolDataProcInfo = $00000FE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXDespoolDataProc(userRoutine: GXDespoolDataProcPtr): GXDespoolDataUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXDespoolDataProc(theSpoolFile: gxSpoolFile; data: Ptr; VAR length: LONGINT; userRoutine: GXDespoolDataUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXDespoolDataProc = GXDespoolDataUPP;


FUNCTION Send_GXDespoolData(theSpoolFile: gxSpoolFile; data: Ptr; VAR length: LONGINT): OSErr; C;
FUNCTION Forward_GXDespoolData(theSpoolFile: gxSpoolFile; data: Ptr; VAR length: LONGINT): OSErr; C;
TYPE
	GXDespoolResourceProcPtr = ProcPtr;  { FUNCTION GXDespoolResource(theSpoolFile: gxSpoolFile; theType: ResType; id: LONGINT; VAR theResource: Handle): OSErr; }
	GXDespoolResourceUPP = UniversalProcPtr;

CONST
	uppGXDespoolResourceProcInfo = $00003FE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXDespoolResourceProc(userRoutine: GXDespoolResourceProcPtr): GXDespoolResourceUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXDespoolResourceProc(theSpoolFile: gxSpoolFile; theType: ResType; id: LONGINT; VAR theResource: Handle; userRoutine: GXDespoolResourceUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXDespoolResourceProc = GXDespoolResourceUPP;


FUNCTION Send_GXDespoolResource(theSpoolFile: gxSpoolFile; theType: ResType; id: LONGINT; VAR theResource: Handle): OSErr; C;
FUNCTION Forward_GXDespoolResource(theSpoolFile: gxSpoolFile; theType: ResType; id: LONGINT; VAR theResource: Handle): OSErr; C;
TYPE
	GXCloseSpoolFileProcPtr = ProcPtr;  { FUNCTION GXCloseSpoolFile(theSpoolFile: gxSpoolFile; closeOptions: LONGINT): OSErr; }
	GXCloseSpoolFileUPP = UniversalProcPtr;

CONST
	uppGXCloseSpoolFileProcInfo = $000003E1; { FUNCTION (4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXCloseSpoolFileProc(userRoutine: GXCloseSpoolFileProcPtr): GXCloseSpoolFileUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXCloseSpoolFileProc(theSpoolFile: gxSpoolFile; closeOptions: LONGINT; userRoutine: GXCloseSpoolFileUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXCloseSpoolFileProc = GXCloseSpoolFileUPP;


FUNCTION Send_GXCloseSpoolFile(theSpoolFile: gxSpoolFile; closeOptions: LONGINT): OSErr; C;
FUNCTION Forward_GXCloseSpoolFile(theSpoolFile: gxSpoolFile; closeOptions: LONGINT): OSErr; C;
TYPE
	GXStartJobProcPtr = ProcPtr;  { FUNCTION GXStartJob(docName: StringPtr; pageCount: LONGINT): OSErr; }
	GXStartJobUPP = UniversalProcPtr;

CONST
	uppGXStartJobProcInfo = $000003E1; { FUNCTION (4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXStartJobProc(userRoutine: GXStartJobProcPtr): GXStartJobUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXStartJobProc(docName: StringPtr; pageCount: LONGINT; userRoutine: GXStartJobUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXStartJobProc = GXStartJobUPP;


FUNCTION Send_GXStartJob(docName: StringPtr; pageCount: LONGINT): OSErr; C;
FUNCTION Forward_GXStartJob(docName: StringPtr; pageCount: LONGINT): OSErr; C;
TYPE
	GXFinishJobProcPtr = ProcPtr;  { FUNCTION GXFinishJob: OSErr; }
	GXFinishJobUPP = UniversalProcPtr;

CONST
	uppGXFinishJobProcInfo = $00000021; { FUNCTION : 2 byte result; }

FUNCTION NewGXFinishJobProc(userRoutine: GXFinishJobProcPtr): GXFinishJobUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXFinishJobProc(userRoutine: GXFinishJobUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXFinishJobProc = GXFinishJobUPP;


FUNCTION Send_GXFinishJob: OSErr; C;
FUNCTION Forward_GXFinishJob: OSErr; C;
TYPE
	GXStartPageProcPtr = ProcPtr;  { FUNCTION GXStartPage(theFormat: gxFormat; numViewPorts: LONGINT; VAR viewPortList: gxViewPort): OSErr; }
	GXStartPageUPP = UniversalProcPtr;

CONST
	uppGXStartPageProcInfo = $00000FE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXStartPageProc(userRoutine: GXStartPageProcPtr): GXStartPageUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXStartPageProc(theFormat: gxFormat; numViewPorts: LONGINT; VAR viewPortList: gxViewPort; userRoutine: GXStartPageUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXStartPageProc = GXStartPageUPP;


FUNCTION Send_GXStartPage(theFormat: gxFormat; numViewPorts: LONGINT; VAR viewPortList: gxViewPort): OSErr; C;
FUNCTION Forward_GXStartPage(theFormat: gxFormat; numViewPorts: LONGINT; VAR viewPortList: gxViewPort): OSErr; C;
TYPE
	GXFinishPageProcPtr = ProcPtr;  { FUNCTION GXFinishPage: OSErr; }
	GXFinishPageUPP = UniversalProcPtr;

CONST
	uppGXFinishPageProcInfo = $00000021; { FUNCTION : 2 byte result; }

FUNCTION NewGXFinishPageProc(userRoutine: GXFinishPageProcPtr): GXFinishPageUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXFinishPageProc(userRoutine: GXFinishPageUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXFinishPageProc = GXFinishPageUPP;


FUNCTION Send_GXFinishPage: OSErr; C;
FUNCTION Forward_GXFinishPage: OSErr; C;
TYPE
	GXPrintPageProcPtr = ProcPtr;  { FUNCTION GXPrintPage(theFormat: gxFormat; thePage: gxShape): OSErr; }
	GXPrintPageUPP = UniversalProcPtr;

CONST
	uppGXPrintPageProcInfo = $000003E1; { FUNCTION (4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXPrintPageProc(userRoutine: GXPrintPageProcPtr): GXPrintPageUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXPrintPageProc(theFormat: gxFormat; thePage: gxShape; userRoutine: GXPrintPageUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXPrintPageProc = GXPrintPageUPP;


FUNCTION Send_GXPrintPage(theFormat: gxFormat; thePage: gxShape): OSErr; C;
FUNCTION Forward_GXPrintPage(theFormat: gxFormat; thePage: gxShape): OSErr; C;
TYPE
	GXSetupImageDataProcPtr = ProcPtr;  { FUNCTION GXSetupImageData(imageData: UNIV Ptr): OSErr; }
	GXSetupImageDataUPP = UniversalProcPtr;

CONST
	uppGXSetupImageDataProcInfo = $000000E1; { FUNCTION (4 byte param): 2 byte result; }

FUNCTION NewGXSetupImageDataProc(userRoutine: GXSetupImageDataProcPtr): GXSetupImageDataUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXSetupImageDataProc(imageData: UNIV Ptr; userRoutine: GXSetupImageDataUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXSetupImageDataProc = GXSetupImageDataUPP;


FUNCTION Send_GXSetupImageData(imageData: UNIV Ptr): OSErr; C;
FUNCTION Forward_GXSetupImageData(imageData: UNIV Ptr): OSErr; C;
TYPE
	GXImageJobProcPtr = ProcPtr;  { FUNCTION GXImageJob(theSpoolFile: gxSpoolFile; VAR closeOptions: LONGINT): OSErr; }
	GXImageJobUPP = UniversalProcPtr;

CONST
	uppGXImageJobProcInfo = $000003E1; { FUNCTION (4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXImageJobProc(userRoutine: GXImageJobProcPtr): GXImageJobUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXImageJobProc(theSpoolFile: gxSpoolFile; VAR closeOptions: LONGINT; userRoutine: GXImageJobUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXImageJobProc = GXImageJobUPP;


FUNCTION Send_GXImageJob(theSpoolFile: gxSpoolFile; VAR closeOptions: LONGINT): OSErr; C;
FUNCTION Forward_GXImageJob(theSpoolFile: gxSpoolFile; VAR closeOptions: LONGINT): OSErr; C;
TYPE
	GXImageDocumentProcPtr = ProcPtr;  { FUNCTION GXImageDocument(theSpoolFile: gxSpoolFile; imageData: UNIV Ptr): OSErr; }
	GXImageDocumentUPP = UniversalProcPtr;

CONST
	uppGXImageDocumentProcInfo = $000003E1; { FUNCTION (4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXImageDocumentProc(userRoutine: GXImageDocumentProcPtr): GXImageDocumentUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXImageDocumentProc(theSpoolFile: gxSpoolFile; imageData: UNIV Ptr; userRoutine: GXImageDocumentUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXImageDocumentProc = GXImageDocumentUPP;


FUNCTION Send_GXImageDocument(theSpoolFile: gxSpoolFile; imageData: UNIV Ptr): OSErr; C;
FUNCTION Forward_GXImageDocument(theSpoolFile: gxSpoolFile; imageData: UNIV Ptr): OSErr; C;
TYPE
	GXImagePageProcPtr = ProcPtr;  { FUNCTION GXImagePage(theSpoolFile: gxSpoolFile; pageNumber: LONGINT; theFormat: gxFormat; imageData: UNIV Ptr): OSErr; }
	GXImagePageUPP = UniversalProcPtr;

CONST
	uppGXImagePageProcInfo = $00003FE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXImagePageProc(userRoutine: GXImagePageProcPtr): GXImagePageUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXImagePageProc(theSpoolFile: gxSpoolFile; pageNumber: LONGINT; theFormat: gxFormat; imageData: UNIV Ptr; userRoutine: GXImagePageUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXImagePageProc = GXImagePageUPP;


FUNCTION Send_GXImagePage(theSpoolFile: gxSpoolFile; pageNumber: LONGINT; theFormat: gxFormat; imageData: UNIV Ptr): OSErr; C;
FUNCTION Forward_GXImagePage(theSpoolFile: gxSpoolFile; pageNumber: LONGINT; theFormat: gxFormat; imageData: UNIV Ptr): OSErr; C;
TYPE
	GXRenderPageProcPtr = ProcPtr;  { FUNCTION GXRenderPage(theFormat: gxFormat; thePage: gxShape; VAR pageInfo: gxPageInfoRecord; imageData: UNIV Ptr): OSErr; }
	GXRenderPageUPP = UniversalProcPtr;

CONST
	uppGXRenderPageProcInfo = $00003FE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXRenderPageProc(userRoutine: GXRenderPageProcPtr): GXRenderPageUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXRenderPageProc(theFormat: gxFormat; thePage: gxShape; VAR pageInfo: gxPageInfoRecord; imageData: UNIV Ptr; userRoutine: GXRenderPageUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXRenderPageProc = GXRenderPageUPP;


FUNCTION Send_GXRenderPage(theFormat: gxFormat; thePage: gxShape; VAR pageInfo: gxPageInfoRecord; imageData: UNIV Ptr): OSErr; C;
FUNCTION Forward_GXRenderPage(theFormat: gxFormat; thePage: gxShape; VAR pageInfo: gxPageInfoRecord; imageData: UNIV Ptr): OSErr; C;
TYPE
	GXCreateImageFileProcPtr = ProcPtr;  { FUNCTION GXCreateImageFile(pFileSpec: FSSpecPtr; imageFileOptions: LONGINT; VAR theImageFile: LONGINT): OSErr; }
	GXCreateImageFileUPP = UniversalProcPtr;

CONST
	uppGXCreateImageFileProcInfo = $00000FE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXCreateImageFileProc(userRoutine: GXCreateImageFileProcPtr): GXCreateImageFileUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXCreateImageFileProc(pFileSpec: FSSpecPtr; imageFileOptions: LONGINT; VAR theImageFile: LONGINT; userRoutine: GXCreateImageFileUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXCreateImageFileProc = GXCreateImageFileUPP;


FUNCTION Send_GXCreateImageFile(pFileSpec: FSSpecPtr; imageFileOptions: LONGINT; VAR theImageFile: LONGINT): OSErr; C;
FUNCTION Forward_GXCreateImageFile(pFileSpec: FSSpecPtr; imageFileOptions: LONGINT; VAR theImageFile: LONGINT): OSErr; C;
TYPE
	GXOpenConnectionProcPtr = ProcPtr;  { FUNCTION GXOpenConnection: OSErr; }
	GXOpenConnectionUPP = UniversalProcPtr;

CONST
	uppGXOpenConnectionProcInfo = $00000021; { FUNCTION : 2 byte result; }

FUNCTION NewGXOpenConnectionProc(userRoutine: GXOpenConnectionProcPtr): GXOpenConnectionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXOpenConnectionProc(userRoutine: GXOpenConnectionUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXOpenConnectionProc = GXOpenConnectionUPP;


FUNCTION Send_GXOpenConnection: OSErr; C;
FUNCTION Forward_GXOpenConnection: OSErr; C;
TYPE
	GXCloseConnectionProcPtr = ProcPtr;  { FUNCTION GXCloseConnection: OSErr; }
	GXCloseConnectionUPP = UniversalProcPtr;

CONST
	uppGXCloseConnectionProcInfo = $00000021; { FUNCTION : 2 byte result; }

FUNCTION NewGXCloseConnectionProc(userRoutine: GXCloseConnectionProcPtr): GXCloseConnectionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXCloseConnectionProc(userRoutine: GXCloseConnectionUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXCloseConnectionProc = GXCloseConnectionUPP;


FUNCTION Send_GXCloseConnection: OSErr; C;
FUNCTION Forward_GXCloseConnection: OSErr; C;
TYPE
	GXStartSendPageProcPtr = ProcPtr;  { FUNCTION GXStartSendPage(theFormat: gxFormat): OSErr; }
	GXStartSendPageUPP = UniversalProcPtr;

CONST
	uppGXStartSendPageProcInfo = $000000E1; { FUNCTION (4 byte param): 2 byte result; }

FUNCTION NewGXStartSendPageProc(userRoutine: GXStartSendPageProcPtr): GXStartSendPageUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXStartSendPageProc(theFormat: gxFormat; userRoutine: GXStartSendPageUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXStartSendPageProc = GXStartSendPageUPP;


FUNCTION Send_GXStartSendPage(theFormat: gxFormat): OSErr; C;
FUNCTION Forward_GXStartSendPage(theFormat: gxFormat): OSErr; C;
TYPE
	GXFinishSendPageProcPtr = ProcPtr;  { FUNCTION GXFinishSendPage: OSErr; }
	GXFinishSendPageUPP = UniversalProcPtr;

CONST
	uppGXFinishSendPageProcInfo = $00000021; { FUNCTION : 2 byte result; }

FUNCTION NewGXFinishSendPageProc(userRoutine: GXFinishSendPageProcPtr): GXFinishSendPageUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXFinishSendPageProc(userRoutine: GXFinishSendPageUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXFinishSendPageProc = GXFinishSendPageUPP;


FUNCTION Send_GXFinishSendPage: OSErr; C;
FUNCTION Forward_GXFinishSendPage: OSErr; C;
TYPE
	GXWriteDataProcPtr = ProcPtr;  { FUNCTION GXWriteData(data: Ptr; length: LONGINT): OSErr; }
	GXWriteDataUPP = UniversalProcPtr;

CONST
	uppGXWriteDataProcInfo = $000003E1; { FUNCTION (4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXWriteDataProc(userRoutine: GXWriteDataProcPtr): GXWriteDataUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXWriteDataProc(data: Ptr; length: LONGINT; userRoutine: GXWriteDataUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXWriteDataProc = GXWriteDataUPP;


FUNCTION Send_GXWriteData(data: Ptr; length: LONGINT): OSErr; C;
FUNCTION Forward_GXWriteData(data: Ptr; length: LONGINT): OSErr; C;
TYPE
	GXBufferDataProcPtr = ProcPtr;  { FUNCTION GXBufferData(data: Ptr; length: LONGINT; bufferOptions: LONGINT): OSErr; }
	GXBufferDataUPP = UniversalProcPtr;

CONST
	uppGXBufferDataProcInfo = $00000FE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXBufferDataProc(userRoutine: GXBufferDataProcPtr): GXBufferDataUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXBufferDataProc(data: Ptr; length: LONGINT; bufferOptions: LONGINT; userRoutine: GXBufferDataUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXBufferDataProc = GXBufferDataUPP;


FUNCTION Send_GXBufferData(data: Ptr; length: LONGINT; bufferOptions: LONGINT): OSErr; C;
FUNCTION Forward_GXBufferData(data: Ptr; length: LONGINT; bufferOptions: LONGINT): OSErr; C;
TYPE
	GXDumpBufferProcPtr = ProcPtr;  { FUNCTION GXDumpBuffer(VAR theBuffer: gxPrintingBuffer): OSErr; }
	GXDumpBufferUPP = UniversalProcPtr;

CONST
	uppGXDumpBufferProcInfo = $000000E1; { FUNCTION (4 byte param): 2 byte result; }

FUNCTION NewGXDumpBufferProc(userRoutine: GXDumpBufferProcPtr): GXDumpBufferUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXDumpBufferProc(VAR theBuffer: gxPrintingBuffer; userRoutine: GXDumpBufferUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXDumpBufferProc = GXDumpBufferUPP;


FUNCTION Send_GXDumpBuffer(VAR theBuffer: gxPrintingBuffer): OSErr; C;
FUNCTION Forward_GXDumpBuffer(VAR theBuffer: gxPrintingBuffer): OSErr; C;
TYPE
	GXFreeBufferProcPtr = ProcPtr;  { FUNCTION GXFreeBuffer(VAR theBuffer: gxPrintingBuffer): OSErr; }
	GXFreeBufferUPP = UniversalProcPtr;

CONST
	uppGXFreeBufferProcInfo = $000000E1; { FUNCTION (4 byte param): 2 byte result; }

FUNCTION NewGXFreeBufferProc(userRoutine: GXFreeBufferProcPtr): GXFreeBufferUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXFreeBufferProc(VAR theBuffer: gxPrintingBuffer; userRoutine: GXFreeBufferUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXFreeBufferProc = GXFreeBufferUPP;


FUNCTION Send_GXFreeBuffer(VAR theBuffer: gxPrintingBuffer): OSErr; C;
FUNCTION Forward_GXFreeBuffer(VAR theBuffer: gxPrintingBuffer): OSErr; C;
TYPE
	GXCheckStatusProcPtr = ProcPtr;  { FUNCTION GXCheckStatus(data: Ptr; length: LONGINT; statusType: LONGINT; owner: gxOwnerSignature): OSErr; }
	GXCheckStatusUPP = UniversalProcPtr;

CONST
	uppGXCheckStatusProcInfo = $00003FE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXCheckStatusProc(userRoutine: GXCheckStatusProcPtr): GXCheckStatusUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXCheckStatusProc(data: Ptr; length: LONGINT; statusType: LONGINT; owner: gxOwnerSignature; userRoutine: GXCheckStatusUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXCheckStatusProc = GXCheckStatusUPP;


FUNCTION Send_GXCheckStatus(data: Ptr; length: LONGINT; statusType: LONGINT; owner: gxOwnerSignature): OSErr; C;
FUNCTION Forward_GXCheckStatus(data: Ptr; length: LONGINT; statusType: LONGINT; owner: gxOwnerSignature): OSErr; C;
TYPE
	GXGetDeviceStatusProcPtr = ProcPtr;  { FUNCTION GXGetDeviceStatus(cmdData: Ptr; cmdSize: LONGINT; responseData: Ptr; VAR responseSize: LONGINT; VAR termination: Str255): OSErr; }
	GXGetDeviceStatusUPP = UniversalProcPtr;

CONST
	uppGXGetDeviceStatusProcInfo = $0000FFE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXGetDeviceStatusProc(userRoutine: GXGetDeviceStatusProcPtr): GXGetDeviceStatusUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXGetDeviceStatusProc(cmdData: Ptr; cmdSize: LONGINT; responseData: Ptr; VAR responseSize: LONGINT; VAR termination: Str255; userRoutine: GXGetDeviceStatusUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXGetDeviceStatusProc = GXGetDeviceStatusUPP;


FUNCTION Send_GXGetDeviceStatus(cmdData: Ptr; cmdSize: LONGINT; responseData: Ptr; VAR responseSize: LONGINT; VAR termination: Str255): OSErr; C;
FUNCTION Forward_GXGetDeviceStatus(cmdData: Ptr; cmdSize: LONGINT; responseData: Ptr; VAR responseSize: LONGINT; VAR termination: Str255): OSErr; C;
TYPE
	GXFetchTaggedDataProcPtr = ProcPtr;  { FUNCTION GXFetchTaggedData(theType: ResType; id: LONGINT; VAR dataHdl: Handle; owner: gxOwnerSignature): OSErr; }
	GXFetchTaggedDataUPP = UniversalProcPtr;

CONST
	uppGXFetchTaggedDataProcInfo = $00003FE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXFetchTaggedDataProc(userRoutine: GXFetchTaggedDataProcPtr): GXFetchTaggedDataUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXFetchTaggedDataProc(theType: ResType; id: LONGINT; VAR dataHdl: Handle; owner: gxOwnerSignature; userRoutine: GXFetchTaggedDataUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXFetchTaggedDataProc = GXFetchTaggedDataUPP;


FUNCTION Send_GXFetchTaggedData(theType: ResType; id: LONGINT; VAR dataHdl: Handle; owner: gxOwnerSignature): OSErr; C;
FUNCTION Forward_GXFetchTaggedData(theType: ResType; id: LONGINT; VAR dataHdl: Handle; owner: gxOwnerSignature): OSErr; C;
TYPE
	GXGetDTPMenuListProcPtr = ProcPtr;  { FUNCTION GXGetDTPMenuList(menuHdl: MenuHandle): OSErr; }
	GXGetDTPMenuListUPP = UniversalProcPtr;

CONST
	uppGXGetDTPMenuListProcInfo = $000000E1; { FUNCTION (4 byte param): 2 byte result; }

FUNCTION NewGXGetDTPMenuListProc(userRoutine: GXGetDTPMenuListProcPtr): GXGetDTPMenuListUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXGetDTPMenuListProc(menuHdl: MenuHandle; userRoutine: GXGetDTPMenuListUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXGetDTPMenuListProc = GXGetDTPMenuListUPP;


FUNCTION Send_GXGetDTPMenuList(menuHdl: MenuHandle): OSErr; C;
FUNCTION Forward_GXGetDTPMenuList(menuHdl: MenuHandle): OSErr; C;
TYPE
	GXDTPMenuSelectProcPtr = ProcPtr;  { FUNCTION GXDTPMenuSelect(id: LONGINT): OSErr; }
	GXDTPMenuSelectUPP = UniversalProcPtr;

CONST
	uppGXDTPMenuSelectProcInfo = $000000E1; { FUNCTION (4 byte param): 2 byte result; }

FUNCTION NewGXDTPMenuSelectProc(userRoutine: GXDTPMenuSelectProcPtr): GXDTPMenuSelectUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXDTPMenuSelectProc(id: LONGINT; userRoutine: GXDTPMenuSelectUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXDTPMenuSelectProc = GXDTPMenuSelectUPP;


FUNCTION Send_GXDTPMenuSelect(id: LONGINT): OSErr; C;
FUNCTION Forward_GXDTPMenuSelect(id: LONGINT): OSErr; C;
TYPE
	GXHandleAlertFilterProcPtr = ProcPtr;  { FUNCTION GXHandleAlertFilter(theJob: gxJob; VAR pStatusRec: gxStatusRecord; pDialog: DialogPtr; VAR theEvent: EventRecord; VAR itemHit: INTEGER; VAR returnImmed: BOOLEAN): OSErr; }
	GXHandleAlertFilterUPP = UniversalProcPtr;

CONST
	uppGXHandleAlertFilterProcInfo = $0003FFE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXHandleAlertFilterProc(userRoutine: GXHandleAlertFilterProcPtr): GXHandleAlertFilterUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXHandleAlertFilterProc(theJob: gxJob; VAR pStatusRec: gxStatusRecord; pDialog: DialogPtr; VAR theEvent: EventRecord; VAR itemHit: INTEGER; VAR returnImmed: BOOLEAN; userRoutine: GXHandleAlertFilterUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXHandleAlertFilterProc = GXHandleAlertFilterUPP;


FUNCTION Send_GXHandleAlertFilter(theJob: gxJob; VAR pStatusRec: gxStatusRecord; pDialog: DialogPtr; VAR theEvent: EventRecord; VAR itemHit: INTEGER; VAR returnImmed: BOOLEAN): OSErr; C;
FUNCTION Forward_GXHandleAlertFilter(theJob: gxJob; VAR pStatusRec: gxStatusRecord; pDialog: DialogPtr; VAR theEvent: EventRecord; VAR itemHit: INTEGER; VAR returnImmed: BOOLEAN): OSErr; C;
TYPE
	GXJobFormatModeQueryProcPtr = ProcPtr;  { FUNCTION GXJobFormatModeQuery(theQuery: gxQueryType; srcData: UNIV Ptr; dstData: UNIV Ptr): OSErr; }
	GXJobFormatModeQueryUPP = UniversalProcPtr;

CONST
	uppGXJobFormatModeQueryProcInfo = $00000FE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXJobFormatModeQueryProc(userRoutine: GXJobFormatModeQueryProcPtr): GXJobFormatModeQueryUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXJobFormatModeQueryProc(theQuery: gxQueryType; srcData: UNIV Ptr; dstData: UNIV Ptr; userRoutine: GXJobFormatModeQueryUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXJobFormatModeQueryProc = GXJobFormatModeQueryUPP;


FUNCTION Send_GXJobFormatModeQuery(theQuery: gxQueryType; srcData: UNIV Ptr; dstData: UNIV Ptr): OSErr; C;
FUNCTION Forward_GXJobFormatModeQuery(theQuery: gxQueryType; srcData: UNIV Ptr; dstData: UNIV Ptr): OSErr; C;
TYPE
	GXWriteStatusToDTPWindowProcPtr = ProcPtr;  { FUNCTION GXWriteStatusToDTPWindow(VAR pStatusRec: gxStatusRecord; VAR pDisplay: gxDisplayRecord): OSErr; }
	GXWriteStatusToDTPWindowUPP = UniversalProcPtr;

CONST
	uppGXWriteStatusToDTPWindowProcInfo = $000003E1; { FUNCTION (4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXWriteStatusToDTPWindowProc(userRoutine: GXWriteStatusToDTPWindowProcPtr): GXWriteStatusToDTPWindowUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXWriteStatusToDTPWindowProc(VAR pStatusRec: gxStatusRecord; VAR pDisplay: gxDisplayRecord; userRoutine: GXWriteStatusToDTPWindowUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXWriteStatusToDTPWindowProc = GXWriteStatusToDTPWindowUPP;


FUNCTION Send_GXWriteStatusToDTPWindow(VAR pStatusRec: gxStatusRecord; VAR pDisplay: gxDisplayRecord): OSErr; C;
FUNCTION Forward_GXWriteStatusToDTPWindow(VAR pStatusRec: gxStatusRecord; VAR pDisplay: gxDisplayRecord): OSErr; C;
TYPE
	GXInitializeStatusAlertProcPtr = ProcPtr;  { FUNCTION GXInitializeStatusAlert(VAR pStatusRec: gxStatusRecord; VAR pDialog: DialogPtr): OSErr; }
	GXInitializeStatusAlertUPP = UniversalProcPtr;

CONST
	uppGXInitializeStatusAlertProcInfo = $000003E1; { FUNCTION (4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXInitializeStatusAlertProc(userRoutine: GXInitializeStatusAlertProcPtr): GXInitializeStatusAlertUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXInitializeStatusAlertProc(VAR pStatusRec: gxStatusRecord; VAR pDialog: DialogPtr; userRoutine: GXInitializeStatusAlertUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXInitializeStatusAlertProc = GXInitializeStatusAlertUPP;


FUNCTION Send_GXInitializeStatusAlert(VAR pStatusRec: gxStatusRecord; VAR pDialog: DialogPtr): OSErr; C;
FUNCTION Forward_GXInitializeStatusAlert(VAR pStatusRec: gxStatusRecord; VAR pDialog: DialogPtr): OSErr; C;
TYPE
	GXHandleAlertStatusProcPtr = ProcPtr;  { FUNCTION GXHandleAlertStatus(VAR pStatusRec: gxStatusRecord): OSErr; }
	GXHandleAlertStatusUPP = UniversalProcPtr;

CONST
	uppGXHandleAlertStatusProcInfo = $000000E1; { FUNCTION (4 byte param): 2 byte result; }

FUNCTION NewGXHandleAlertStatusProc(userRoutine: GXHandleAlertStatusProcPtr): GXHandleAlertStatusUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXHandleAlertStatusProc(VAR pStatusRec: gxStatusRecord; userRoutine: GXHandleAlertStatusUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXHandleAlertStatusProc = GXHandleAlertStatusUPP;


FUNCTION Send_GXHandleAlertStatus(VAR pStatusRec: gxStatusRecord): OSErr; C;
FUNCTION Forward_GXHandleAlertStatus(VAR pStatusRec: gxStatusRecord): OSErr; C;
TYPE
	GXHandleAlertEventProcPtr = ProcPtr;  { FUNCTION GXHandleAlertEvent(VAR pStatusRec: gxStatusRecord; pDialog: DialogPtr; VAR theEvent: EventRecord; VAR response: INTEGER): OSErr; }
	GXHandleAlertEventUPP = UniversalProcPtr;

CONST
	uppGXHandleAlertEventProcInfo = $00003FE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXHandleAlertEventProc(userRoutine: GXHandleAlertEventProcPtr): GXHandleAlertEventUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXHandleAlertEventProc(VAR pStatusRec: gxStatusRecord; pDialog: DialogPtr; VAR theEvent: EventRecord; VAR response: INTEGER; userRoutine: GXHandleAlertEventUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXHandleAlertEventProc = GXHandleAlertEventUPP;


FUNCTION Send_GXHandleAlertEvent(VAR pStatusRec: gxStatusRecord; pDialog: DialogPtr; VAR theEvent: EventRecord; VAR response: INTEGER): OSErr; C;
FUNCTION Forward_GXHandleAlertEvent(VAR pStatusRec: gxStatusRecord; pDialog: DialogPtr; VAR theEvent: EventRecord; VAR response: INTEGER): OSErr; C;
TYPE
	GXCleanupStartJobProcPtr = ProcPtr;  { PROCEDURE GXCleanupStartJob; }
	GXCleanupStartJobUPP = UniversalProcPtr;

CONST
	uppGXCleanupStartJobProcInfo = $00000001; { PROCEDURE ; }

FUNCTION NewGXCleanupStartJobProc(userRoutine: GXCleanupStartJobProcPtr): GXCleanupStartJobUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallGXCleanupStartJobProc(userRoutine: GXCleanupStartJobUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXCleanupStartJobProc = GXCleanupStartJobUPP;


PROCEDURE Send_GXCleanupStartJob; C;
PROCEDURE Forward_GXCleanupStartJob; C;
TYPE
	GXCleanupStartPageProcPtr = ProcPtr;  { PROCEDURE GXCleanupStartPage; }
	GXCleanupStartPageUPP = UniversalProcPtr;

CONST
	uppGXCleanupStartPageProcInfo = $00000001; { PROCEDURE ; }

FUNCTION NewGXCleanupStartPageProc(userRoutine: GXCleanupStartPageProcPtr): GXCleanupStartPageUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallGXCleanupStartPageProc(userRoutine: GXCleanupStartPageUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXCleanupStartPageProc = GXCleanupStartPageUPP;


PROCEDURE Send_GXCleanupStartPage; C;
PROCEDURE Forward_GXCleanupStartPage; C;
TYPE
	GXCleanupOpenConnectionProcPtr = ProcPtr;  { PROCEDURE GXCleanupOpenConnection; }
	GXCleanupOpenConnectionUPP = UniversalProcPtr;

CONST
	uppGXCleanupOpenConnectionProcInfo = $00000001; { PROCEDURE ; }

FUNCTION NewGXCleanupOpenConnectionProc(userRoutine: GXCleanupOpenConnectionProcPtr): GXCleanupOpenConnectionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallGXCleanupOpenConnectionProc(userRoutine: GXCleanupOpenConnectionUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXCleanupOpenConnectionProc = GXCleanupOpenConnectionUPP;


PROCEDURE Send_GXCleanupOpenConnection; C;
PROCEDURE Forward_GXCleanupOpenConnection; C;
TYPE
	GXCleanupStartSendPageProcPtr = ProcPtr;  { PROCEDURE GXCleanupStartSendPage; }
	GXCleanupStartSendPageUPP = UniversalProcPtr;

CONST
	uppGXCleanupStartSendPageProcInfo = $00000001; { PROCEDURE ; }

FUNCTION NewGXCleanupStartSendPageProc(userRoutine: GXCleanupStartSendPageProcPtr): GXCleanupStartSendPageUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallGXCleanupStartSendPageProc(userRoutine: GXCleanupStartSendPageUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXCleanupStartSendPageProc = GXCleanupStartSendPageUPP;


PROCEDURE Send_GXCleanupStartSendPage; C;
PROCEDURE Forward_GXCleanupStartSendPage; C;
TYPE
	GXDefaultDesktopPrinterProcPtr = ProcPtr;  { FUNCTION GXDefaultDesktopPrinter(VAR dtpName: Str31): OSErr; }
	GXDefaultDesktopPrinterUPP = UniversalProcPtr;

CONST
	uppGXDefaultDesktopPrinterProcInfo = $000000E1; { FUNCTION (4 byte param): 2 byte result; }

FUNCTION NewGXDefaultDesktopPrinterProc(userRoutine: GXDefaultDesktopPrinterProcPtr): GXDefaultDesktopPrinterUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXDefaultDesktopPrinterProc(VAR dtpName: Str31; userRoutine: GXDefaultDesktopPrinterUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXDefaultDesktopPrinterProc = GXDefaultDesktopPrinterUPP;


FUNCTION Send_GXDefaultDesktopPrinter(VAR dtpName: Str31): OSErr; C;
FUNCTION Forward_GXDefaultDesktopPrinter(VAR dtpName: Str31): OSErr; C;
TYPE
	GXCaptureOutputDeviceProcPtr = ProcPtr;  { FUNCTION GXCaptureOutputDevice(capture: BOOLEAN): OSErr; }
	GXCaptureOutputDeviceUPP = UniversalProcPtr;

CONST
	uppGXCaptureOutputDeviceProcInfo = $00000061; { FUNCTION (1 byte param): 2 byte result; }

FUNCTION NewGXCaptureOutputDeviceProc(userRoutine: GXCaptureOutputDeviceProcPtr): GXCaptureOutputDeviceUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXCaptureOutputDeviceProc(capture: BOOLEAN; userRoutine: GXCaptureOutputDeviceUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXCaptureOutputDeviceProc = GXCaptureOutputDeviceUPP;


FUNCTION Send_GXCaptureOutputDevice(capture: BOOLEAN): OSErr; C;
FUNCTION Forward_GXCaptureOutputDevice(capture: BOOLEAN): OSErr; C;
TYPE
	GXOpenConnectionRetryProcPtr = ProcPtr;  { FUNCTION GXOpenConnectionRetry(theType: ResType; aVoid: UNIV Ptr; VAR retryopenPtr: BOOLEAN; anErr: OSErr): OSErr; }
	GXOpenConnectionRetryUPP = UniversalProcPtr;

CONST
	uppGXOpenConnectionRetryProcInfo = $00002FE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 2 byte param): 2 byte result; }

FUNCTION NewGXOpenConnectionRetryProc(userRoutine: GXOpenConnectionRetryProcPtr): GXOpenConnectionRetryUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXOpenConnectionRetryProc(theType: ResType; aVoid: UNIV Ptr; VAR retryopenPtr: BOOLEAN; anErr: OSErr; userRoutine: GXOpenConnectionRetryUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXOpenConnectionRetryProc = GXOpenConnectionRetryUPP;


FUNCTION Send_GXOpenConnectionRetry(theType: ResType; aVoid: UNIV Ptr; VAR retryopenPtr: BOOLEAN; anErr: OSErr): OSErr; C;
FUNCTION Forward_GXOpenConnectionRetry(theType: ResType; aVoid: UNIV Ptr; VAR retryopenPtr: BOOLEAN; anErr: OSErr): OSErr; C;
TYPE
	GXExamineSpoolFileProcPtr = ProcPtr;  { FUNCTION GXExamineSpoolFile(theSpoolFile: gxSpoolFile): OSErr; }
	GXExamineSpoolFileUPP = UniversalProcPtr;

CONST
	uppGXExamineSpoolFileProcInfo = $000000E1; { FUNCTION (4 byte param): 2 byte result; }

FUNCTION NewGXExamineSpoolFileProc(userRoutine: GXExamineSpoolFileProcPtr): GXExamineSpoolFileUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXExamineSpoolFileProc(theSpoolFile: gxSpoolFile; userRoutine: GXExamineSpoolFileUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXExamineSpoolFileProc = GXExamineSpoolFileUPP;


FUNCTION Send_GXExamineSpoolFile(theSpoolFile: gxSpoolFile): OSErr; C;
FUNCTION Forward_GXExamineSpoolFile(theSpoolFile: gxSpoolFile): OSErr; C;
TYPE
	GXFinishSendPlaneProcPtr = ProcPtr;  { FUNCTION GXFinishSendPlane: OSErr; }
	GXFinishSendPlaneUPP = UniversalProcPtr;

CONST
	uppGXFinishSendPlaneProcInfo = $00000021; { FUNCTION : 2 byte result; }

FUNCTION NewGXFinishSendPlaneProc(userRoutine: GXFinishSendPlaneProcPtr): GXFinishSendPlaneUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXFinishSendPlaneProc(userRoutine: GXFinishSendPlaneUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXFinishSendPlaneProc = GXFinishSendPlaneUPP;


FUNCTION Send_GXFinishSendPlane: OSErr; C;
FUNCTION Forward_GXFinishSendPlane: OSErr; C;
TYPE
	GXDoesPaperFitProcPtr = ProcPtr;  { FUNCTION GXDoesPaperFit(whichTray: gxTrayIndex; paper: gxPaperType; VAR fits: BOOLEAN): OSErr; }
	GXDoesPaperFitUPP = UniversalProcPtr;

CONST
	uppGXDoesPaperFitProcInfo = $00000FE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXDoesPaperFitProc(userRoutine: GXDoesPaperFitProcPtr): GXDoesPaperFitUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXDoesPaperFitProc(whichTray: gxTrayIndex; paper: gxPaperType; VAR fits: BOOLEAN; userRoutine: GXDoesPaperFitUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXDoesPaperFitProc = GXDoesPaperFitUPP;


FUNCTION Send_GXDoesPaperFit(whichTray: gxTrayIndex; paper: gxPaperType; VAR fits: BOOLEAN): OSErr; C;
FUNCTION Forward_GXDoesPaperFit(whichTray: gxTrayIndex; paper: gxPaperType; VAR fits: BOOLEAN): OSErr; C;
TYPE
	GXChooserMessageProcPtr = ProcPtr;  { FUNCTION GXChooserMessage(message: LONGINT; caller: LONGINT; objName: StringPtr; zoneName: StringPtr; theList: ListHandle; p2: LONGINT): OSErr; }
	GXChooserMessageUPP = UniversalProcPtr;

CONST
	uppGXChooserMessageProcInfo = $0003FFE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXChooserMessageProc(userRoutine: GXChooserMessageProcPtr): GXChooserMessageUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXChooserMessageProc(message: LONGINT; caller: LONGINT; objName: StringPtr; zoneName: StringPtr; theList: ListHandle; p2: LONGINT; userRoutine: GXChooserMessageUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXChooserMessageProc = GXChooserMessageUPP;


FUNCTION Send_GXChooserMessage(message: LONGINT; caller: LONGINT; objName: StringPtr; zoneName: StringPtr; theList: ListHandle; p2: LONGINT): OSErr; C;
FUNCTION Forward_GXChooserMessage(message: LONGINT; caller: LONGINT; objName: StringPtr; zoneName: StringPtr; theList: ListHandle; p2: LONGINT): OSErr; C;
TYPE
	GXFindPrinterProfileProcPtr = ProcPtr;  { FUNCTION GXFindPrinterProfile(thePrinter: gxPrinter; searchData: UNIV Ptr; index: LONGINT; VAR returnedProfile: gxColorProfile; VAR numProfiles: LONGINT): OSErr; }
	GXFindPrinterProfileUPP = UniversalProcPtr;

CONST
	uppGXFindPrinterProfileProcInfo = $0000FFE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXFindPrinterProfileProc(userRoutine: GXFindPrinterProfileProcPtr): GXFindPrinterProfileUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXFindPrinterProfileProc(thePrinter: gxPrinter; searchData: UNIV Ptr; index: LONGINT; VAR returnedProfile: gxColorProfile; VAR numProfiles: LONGINT; userRoutine: GXFindPrinterProfileUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXFindPrinterProfileProc = GXFindPrinterProfileUPP;


FUNCTION Send_GXFindPrinterProfile(thePrinter: gxPrinter; searchData: UNIV Ptr; index: LONGINT; VAR returnedProfile: gxColorProfile; VAR numProfiles: LONGINT): OSErr; C;
FUNCTION Forward_GXFindPrinterProfile(thePrinter: gxPrinter; searchData: UNIV Ptr; index: LONGINT; VAR returnedProfile: gxColorProfile; VAR numProfiles: LONGINT): OSErr; C;
TYPE
	GXFindFormatProfileProcPtr = ProcPtr;  { FUNCTION GXFindFormatProfile(theFormat: gxFormat; searchData: UNIV Ptr; index: LONGINT; VAR returnedProfile: gxColorProfile; VAR numProfiles: LONGINT): OSErr; }
	GXFindFormatProfileUPP = UniversalProcPtr;

CONST
	uppGXFindFormatProfileProcInfo = $0000FFE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXFindFormatProfileProc(userRoutine: GXFindFormatProfileProcPtr): GXFindFormatProfileUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXFindFormatProfileProc(theFormat: gxFormat; searchData: UNIV Ptr; index: LONGINT; VAR returnedProfile: gxColorProfile; VAR numProfiles: LONGINT; userRoutine: GXFindFormatProfileUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXFindFormatProfileProc = GXFindFormatProfileUPP;


FUNCTION Send_GXFindFormatProfile(theFormat: gxFormat; searchData: UNIV Ptr; index: LONGINT; VAR returnedProfile: gxColorProfile; VAR numProfiles: LONGINT): OSErr; C;
FUNCTION Forward_GXFindFormatProfile(theFormat: gxFormat; searchData: UNIV Ptr; index: LONGINT; VAR returnedProfile: gxColorProfile; VAR numProfiles: LONGINT): OSErr; C;
TYPE
	GXSetPrinterProfileProcPtr = ProcPtr;  { FUNCTION GXSetPrinterProfile(thePrinter: gxPrinter; oldProfile: gxColorProfile; newProfile: gxColorProfile): OSErr; }
	GXSetPrinterProfileUPP = UniversalProcPtr;

CONST
	uppGXSetPrinterProfileProcInfo = $00000FE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXSetPrinterProfileProc(userRoutine: GXSetPrinterProfileProcPtr): GXSetPrinterProfileUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXSetPrinterProfileProc(thePrinter: gxPrinter; oldProfile: gxColorProfile; newProfile: gxColorProfile; userRoutine: GXSetPrinterProfileUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXSetPrinterProfileProc = GXSetPrinterProfileUPP;


FUNCTION Send_GXSetPrinterProfile(thePrinter: gxPrinter; oldProfile: gxColorProfile; newProfile: gxColorProfile): OSErr; C;
FUNCTION Forward_GXSetPrinterProfile(thePrinter: gxPrinter; oldProfile: gxColorProfile; newProfile: gxColorProfile): OSErr; C;
TYPE
	GXSetFormatProfileProcPtr = ProcPtr;  { FUNCTION GXSetFormatProfile(theFormat: gxFormat; oldProfile: gxColorProfile; newProfile: gxColorProfile): OSErr; }
	GXSetFormatProfileUPP = UniversalProcPtr;

CONST
	uppGXSetFormatProfileProcInfo = $00000FE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXSetFormatProfileProc(userRoutine: GXSetFormatProfileProcPtr): GXSetFormatProfileUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXSetFormatProfileProc(theFormat: gxFormat; oldProfile: gxColorProfile; newProfile: gxColorProfile; userRoutine: GXSetFormatProfileUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXSetFormatProfileProc = GXSetFormatProfileUPP;


FUNCTION Send_GXSetFormatProfile(theFormat: gxFormat; oldProfile: gxColorProfile; newProfile: gxColorProfile): OSErr; C;
FUNCTION Forward_GXSetFormatProfile(theFormat: gxFormat; oldProfile: gxColorProfile; newProfile: gxColorProfile): OSErr; C;
TYPE
	GXHandleAltDestinationProcPtr = ProcPtr;  { FUNCTION GXHandleAltDestination(VAR userCancels: BOOLEAN): OSErr; }
	GXHandleAltDestinationUPP = UniversalProcPtr;

CONST
	uppGXHandleAltDestinationProcInfo = $000000E1; { FUNCTION (4 byte param): 2 byte result; }

FUNCTION NewGXHandleAltDestinationProc(userRoutine: GXHandleAltDestinationProcPtr): GXHandleAltDestinationUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXHandleAltDestinationProc(VAR userCancels: BOOLEAN; userRoutine: GXHandleAltDestinationUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXHandleAltDestinationProc = GXHandleAltDestinationUPP;


FUNCTION Send_GXHandleAltDestination(VAR userCancels: BOOLEAN): OSErr; C;
FUNCTION Forward_GXHandleAltDestination(VAR userCancels: BOOLEAN): OSErr; C;
TYPE
	GXSetupPageImageDataProcPtr = ProcPtr;  { FUNCTION GXSetupPageImageData(theFormat: gxFormat; thePage: gxShape; imageData: UNIV Ptr): OSErr; }
	GXSetupPageImageDataUPP = UniversalProcPtr;

CONST
	uppGXSetupPageImageDataProcInfo = $00000FE1; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGXSetupPageImageDataProc(userRoutine: GXSetupPageImageDataProcPtr): GXSetupPageImageDataUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGXSetupPageImageDataProc(theFormat: gxFormat; thePage: gxShape; imageData: UNIV Ptr; userRoutine: GXSetupPageImageDataUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GXSetupPageImageDataProc = GXSetupPageImageDataUPP;


FUNCTION Send_GXSetupPageImageData(theFormat: gxFormat; thePage: gxShape; imageData: UNIV Ptr): OSErr; C;
FUNCTION Forward_GXSetupPageImageData(theFormat: gxFormat; thePage: gxShape; imageData: UNIV Ptr): OSErr; C;
{******************************************************************
					Start of old "GXPrintingErrors.h/a/p" interface file.
			*******************************************************************}

CONST
	gxPrintingResultBase		= -510;							{First QuickDraw GX printing error code.}

{RESULT CODES FOR QUICKDRAW GX PRINTING OPERATIONS}
	gxAioTimeout				= 0+(gxPrintingResultBase);		{-510 : Timeout condition occurred during operation}
	gxAioBadRqstState			= 0+(gxPrintingResultBase - 1);	{-511 : Async I/O request in invalid state for operation}
	gxAioBadConn				= 0+(gxPrintingResultBase - 2);	{-512 : Invalid Async I/O connection refnum}
	gxAioInvalidXfer			= 0+(gxPrintingResultBase - 3);	{-513 : Read data transfer structure contained bad values}
	gxAioNoRqstBlks				= 0+(gxPrintingResultBase - 4);	{-514 : No available request blocks to process request}
	gxAioNoDataXfer				= 0+(gxPrintingResultBase - 5);	{-515 : Data transfer structure pointer not specified}
	gxAioTooManyAutos			= 0+(gxPrintingResultBase - 6);	{-516 : Auto status request already active}
	gxAioNoAutoStat				= 0+(gxPrintingResultBase - 7);	{-517 : Connection not configured for auto status}
	gxAioBadRqstID				= 0+(gxPrintingResultBase - 8);	{-518 : Invalid I/O request identifier}
	gxAioCantKill				= 0+(gxPrintingResultBase - 9);	{-519 : Comm. protocol doesn't support I/O term}
	gxAioAlreadyExists			= 0+(gxPrintingResultBase - 10); {-520 : Protocol spec. data already specified}
	gxAioCantFind				= 0+(gxPrintingResultBase - 11); {-521 : Protocol spec. data does not exist}
	gxAioDeviceDisconn			= 0+(gxPrintingResultBase - 12); {-522 : Machine disconnected from printer}
	gxAioNotImplemented			= 0+(gxPrintingResultBase - 13); {-523 : Function not implemented}
	gxAioOpenPending			= 0+(gxPrintingResultBase - 14); {-524 : Opening a connection for protocol, but another open pending}
	gxAioNoProtocolData			= 0+(gxPrintingResultBase - 15); {-525 : No protocol specific data specified in request}
	gxAioRqstKilled				= 0+(gxPrintingResultBase - 16); {-526 : I/O request was terminated}
	gxBadBaudRate				= 0+(gxPrintingResultBase - 17); {-527 : Invalid baud rate specified}
	gxBadParity					= 0+(gxPrintingResultBase - 18); {-528 : Invalid parity specified}
	gxBadStopBits				= 0+(gxPrintingResultBase - 19); {-529 : Invalid stop bits specified}
	gxBadDataBits				= 0+(gxPrintingResultBase - 20); {-530 : Invalid data bits specified}
	gxBadPrinterName			= 0+(gxPrintingResultBase - 21); {-531 : Bad printer name specified}
	gxAioBadMsgType				= 0+(gxPrintingResultBase - 22); {-532 : Bad masType field in transfer info structure}
	gxAioCantFindDevice			= 0+(gxPrintingResultBase - 23); {-533 : Cannot locate target device}
	gxAioOutOfSeq				= 0+(gxPrintingResultBase - 24); {-534 : Non-atomic SCSI requests submitted out of sequence}
	gxPrIOAbortErr				= 0+(gxPrintingResultBase - 25); {-535 : I/O operation aborted}
	gxPrUserAbortErr			= 0+(gxPrintingResultBase - 26); {-536 : User aborted}
	gxCantAddPanelsNowErr		= 0+(gxPrintingResultBase - 27); {-537 : Can only add panels during driver switch or dialog setup}
	gxBadxdtlKeyErr				= 0+(gxPrintingResultBase - 28); {-538 : Unknown key for xdtl - must be radiobutton, etc}
	gxXdtlItemOutOfRangeErr		= 0+(gxPrintingResultBase - 29); {-539 : Referenced item does not belong to panel}
	gxNoActionButtonErr			= 0+(gxPrintingResultBase - 30); {-540 : Action button is nil}
	gxTitlesTooLongErr			= 0+(gxPrintingResultBase - 31); {-541 : Length of buttons exceeds alert maximum width}
	gxUnknownAlertVersionErr	= 0+(gxPrintingResultBase - 32); {-542 : Bad version for printing alerts}
	gxGBBufferTooSmallErr		= 0+(gxPrintingResultBase - 33); {-543 : Buffer too small.}
	gxInvalidPenTable			= 0+(gxPrintingResultBase - 34); {-544 : Invalid vector driver pen table.}
	gxIncompletePrintFileErr	= 0+(gxPrintingResultBase - 35); {-545 : Print file was not completely spooled}
	gxCrashedPrintFileErr		= 0+(gxPrintingResultBase - 36); {-546 : Print file is corrupted}
	gxInvalidPrintFileVersion	= 0+(gxPrintingResultBase - 37); {-547 : Print file is incompatible with current QuickDraw GX version}
	gxSegmentLoadFailedErr		= 0+(gxPrintingResultBase - 38); {-548 : Segment loader error}
	gxExtensionNotFoundErr		= 0+(gxPrintingResultBase - 39); {-549 : Requested printing extension could not be found}
	gxDriverVersionErr			= 0+(gxPrintingResultBase - 40); {-550 : Driver too new for current version of QuickDraw GX}
	gxImagingSystemVersionErr	= 0+(gxPrintingResultBase - 41); {-551 : Imaging system too new for current version of QuickDraw GX}
	gxFlattenVersionTooNew		= 0+(gxPrintingResultBase - 42); {-552 : Flattened object format too new for current version of QDGX}
	gxPaperTypeNotFound			= 0+(gxPrintingResultBase - 43); {-553 : Requested papertype could not be found}
	gxNoSuchPTGroup				= 0+(gxPrintingResultBase - 44); {-554 : Requested papertype group could not be found}
	gxNotEnoughPrinterMemory	= 0+(gxPrintingResultBase - 45); {-555 : Printer does not have enough memory for fonts in document}
	gxDuplicatePanelNameErr		= 0+(gxPrintingResultBase - 46); {-556 : Attempt to add more than 10 panels with the same name}
	gxExtensionVersionErr		= 0+(gxPrintingResultBase - 47); {-557 : Extension too new for current version of QuickDraw GX}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := GXPrintingIncludes}

{$ENDC} {__GXPRINTING__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
