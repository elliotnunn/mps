{
 	File:		GXPrinterDrivers.p
 
 	Contains:	This file defines data types and API functions for printer driver development.
 
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
 UNIT GXPrinterDrivers;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __GXPRINTERDRIVERS__}
{$SETC __GXPRINTERDRIVERS__ := 1}

{$I+}
{$SETC GXPrinterDriversIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __SCALERTYPES__}
{$I ScalerTypes.p}
{$ENDC}
{	Types.p														}
{		ConditionalMacros.p										}
{	MixedMode.p													}
{	GXMath.p													}
{		FixMath.p												}
{	SFNTTypes.p													}
{		GXTypes.p												}

{$IFC UNDEFINED __PRINTING__}
{$I Printing.p}
{$ENDC}
{	Errors.p													}
{	Quickdraw.p													}
{		QuickdrawText.p											}
{	Dialogs.p													}
{		Memory.p												}
{		Menus.p													}
{		Controls.p												}
{		Windows.p												}
{			Events.p											}
{				OSUtils.p										}
{		TextEdit.p												}

{$IFC UNDEFINED __GXPRINTING__}
{$I GXPrinting.p}
{$ENDC}
{	Collections.p												}
{	Files.p														}
{		Finder.p												}
{	GXFonts.p													}
{	Lists.p														}
{	GXMessages.p												}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

TYPE
	gxManualFeedAlertPrefs = RECORD
		alertFlags:				LONGINT;								{	Flags--first word is for driver's private use, the rest is predefined. }
	END;

	gxManualFeedAlertPrefsPtr = ^gxManualFeedAlertPrefs;
	gxManualFeedAlertPrefsHdl = ^gxManualFeedAlertPrefsPtr;

{ Constants for the alertFlags field of gxManualFeedAlertPrefs.}

CONST
	gxShowAlerts				= $00000001;					{ Show alerts for this desktop printer. }
	gxAlertOnPaperChange		= $00000002;					{ …only if the papertype changes. }

	gxDefaultMFeedAlertSettings	= 0+(gxShowAlerts + gxAlertOnPaperChange);

{ Driver output settings structure for desktop printer gxDriverOutputType resource }

TYPE
	gxDriverOutputSettings = RECORD
		driverflags:			LONGINT;								{	Flags -- for use by driver. }
		outputSettings:			LONGINT;								{	Flags -- predefined. }
	END;

	gxDriverOutputSettingsPtr = ^gxDriverOutputSettings;
	gxDriverOutputSettingsHdl = ^gxDriverOutputSettingsPtr;

{ Constants for the outputSettings field of gxDriverOutputSettings. }

CONST
	gxCanConfigureTrays			= $00000001;					{ Desktop printer represents a device with a paper feed. }

{ ------------------------------------------------------------------------------

						Printing Driver Constants and Types

-------------------------------------------------------------------------------- }
	gxInputTraysMenuItem		= -1;							{ Menu item number for "Input Trays..." }

{ Buffering and IO preferences-- this structure mirrors the 'iobm' resource }

TYPE
	gxIOPrefsRec = RECORD
		communicationsOptions:	LONGINT;								{ Standard or nonstandard I/O? }
		numBuffers:				LONGINT;								{ Requested number of buffers for QDGX to create }
		bufferSize:				LONGINT;								{ The size of each buffer }
		numReqBlocks:			LONGINT;								{ The number of async I/O request blocks which will be needed }
		openCloseTimeout:		LONGINT;								{ The open/close timeout (in ticks) }
		readWriteTimeout:		LONGINT;								{ The read/write timeout (in ticks) }
	END;

	gxIOPrefsPtr = ^gxIOPrefsRec;
	gxIOPrefsHdl = ^gxIOPrefsPtr;

{ Constants for the communicationsOptions field of IOPrefsRec. }

CONST
	gxUseCustomIO				= $00000001;					{ Driver uses a non-standard IO mechanism }

{ Information about writing to a file }

TYPE
	gxPrintDestinationRec = RECORD
		printToFile:			BOOLEAN;								{ True if output is to go to a file }
		padByte:				CHAR;
		fSpec:					FSSpec;									{ If going to a file, the FSSpec for the file }
		includeFonts:			CHAR;									{ True if fonts are to be included }
		fileFormat:				Str31;									{ Format to write file }
	END;

	gxPrintDestinationPtr = ^gxPrintDestinationRec;
	gxPrintDestinationHdl = ^gxPrintDestinationPtr;

{ This structure is the content of each cell in the standard PACK LDEF }
	gxPortListRec = RECORD
		firstMarker:			CHAR;									{ Markers to indicate icon or non-icon version }
		secondMarker:			CHAR;									{ if these are ≈ and ≈, then the cell is an icon cell. }
		{ Otherwise, it is assumed to be a standard text LDEF }
		{ cell }
		iconSuiteHandle:		Handle;									{ The icon suite to draw for this cell }
		outputDriverName:		Handle;									{ Handle to the output driver name (for serial) }
		inputDriverName:		Handle;									{ Handle to the input driver name (for serial) }
		iconName:				Str255;									{ Name to draw under the icon }
	END;

	gxPortListPtr = ^gxPortListRec;

{ ------------------------------------------------------------------------------

						Printing Driver Constants for resources in the desktop printer

-------------------------------------------------------------------------------- }

CONST
	gxDeviceCommunicationsID	= 0;

{ ----------------------------------• 'prod' •---------------------------------- }
{
	  For PostScript devices, the device and version names of the device.
	  (0) product name is of type PString
	  (1) version is of type PString
	  (2) revision is of type PString
	  (3) vm available is of type long
	  (4) font stream type is of type scalerStreamTypeFlag
	  (5) language level is of type long
}
	gxPostscriptProductInfoType	= 'prod';
	gxPostscriptProductNameID	= 0;
	gxPostscriptVersionID		= 1;
	gxPostscriptRevisionID		= 2;
	gxPostscriptVMAvailableID	= 3;
	gxPostscriptFontStreamTypeID = 4;
	gxPostscriptLanguageLevelID	= 5;

{ ------------------------------------------------------------------------------

						Printing Driver Constants for status alerts

-------------------------------------------------------------------------------- }
{ Structure passed in statusBuffer of StatusRecord for manual feed alert }

TYPE
	gxManualFeedRecord = RECORD
		canAutoFeed:			BOOLEAN;								{ True if driver can switch to auto feed }
		paperTypeName:			Str31;									{ Name of paperType to feed manually }
	END;

{ Structure passed in statusBuffer of StatusRecord for out of paper alert }
	gxOutOfPaperRecord = RECORD
		paperTypeName:			Str31;									{ Name of printing document }
	END;

{ The DITL id for the auto feed button in the manual feed alert }

CONST
	gxAutoFeedButtonId			= 3;

{ Status resource id for the alerts }
	gxUnivAlertStatusResourceId	= -28508;

{ Status resource indices for alerts }
	gxUnivManualFeedIndex		= 2;
	gxUnivFailToPrintIndex		= 3;
	gxUnivPaperJamIndex			= 4;
	gxUnivOutOfPaperIndex		= 5;
	gxUnivNoPaperTrayIndex		= 6;
	gxUnivPrinterReadyIndex		= 7;
	gxUnivAlertBeforeIndex		= 9;
	gxUnivAlertAfterIndex		= 10;

{ Allocation sizes for status buffers needed for automatic alerts }
	gxDefaultStatusBufferSize	= 10;
	gxManualFeedStatusBufferSize = 34;
	gxOutOfPaperStatusBufferSize = 42;

{ ------------------------------------------------------------------------------

								Old Application Support

-------------------------------------------------------------------------------- }
{ The format of a 'cust' resource  }

TYPE
	gxCustomizationRec = RECORD
		horizontalResolution:	INTEGER;								{ Horizontal res (integral part) }
		verticalResolution:		INTEGER;								{ Vertical res (integral part) }
		upDriverType:			INTEGER;								{ "upDriver" emulation type }
		patternStretch:			Point;									{ Pattern stretch factor }
		translatorSettings:		INTEGER;								{ Translator settings to use }
	END;

	gxCustomizationPtr = ^gxCustomizationRec;
	gxCustomizationHdl = ^gxCustomizationPtr;

{ The format of a 'resl' resource }
	gxResolutionRec = RECORD
		rangeType:				INTEGER;								{ Always 1 }
		xMinimumResolution:		INTEGER;								{ Min X resolution available }
		xMaximumResolution:		INTEGER;								{ Max X resolution available }
		yMinimumResolution:		INTEGER;								{ Min Y resolution available }
		yMaximumResolution:		INTEGER;								{ Max Y resolution available }
		resolutionCount:		INTEGER;								{ Number of resolutions }
		resolutions:			ARRAY [0..0] OF Point;					{ Array of resolutions }
	END;

	gxResolutionPtr = ^gxResolutionRec;
	gxResolutionHdl = ^gxResolutionPtr;

{

		Constants for the "universal" print record.

}
{ Constant for version number in universal print record }

CONST
	gxPrintRecordVersion		= 8;

{ Constants for feed field in universal print record }
	gxAutoFeed					= 0;
	gxManualFeed				= 1;

{ Constants for options field in universal print record }
	gxPreciseBitmap				= $0001;						{ Tall adjusted (IW), precise bitmap (LW, SC) }
	gxBiggerPages				= $0002;						{ No gaps (IW), larger print area (LW) }
	gxGraphicSmoothing			= $0004;						{ Graphic smoothing (LW) }
	gxTextSmoothing				= $0008;						{ Text smoothing (SC) }
	gxFontSubstitution			= $0010;						{ Font substitution }
	gxInvertPage				= $0020;						{ B/W invert image }
	gxFlipPageHoriz				= $0040;						{ Flip horizontal }
	gxFlipPageVert				= $0080;						{ Flip vertical }
	gxColorMode					= $0100;						{ Color printing }
	gxBidirectional				= $0200;						{ Bidirectional printing }
	gxUserFlag0					= $0400;						{ User flag 0 }
	gxUserFlag1					= $0800;						{ User flag 1 }
	gxUserFlag2					= $1000;						{ User flag 2 }
	gxReservedFlag0				= $2000;						{ Reserved flag 0 }
	gxReservedFlag1				= $4000;						{ Reserved flag 1 }
	gxReservedFlag2				= $8000;						{ Reserved flag 2 }

{ Constants for orientation field in universal print record }
	gxPortraitOrientation		= 0;
	gxLandscapeOrientation		= 1;
	gxAltPortraitOrientation	= 2;
	gxAltLandscapeOrientation	= 3;

{ Constants for qualityMode field in universal print record }
	gxBestQuality				= 0;
	gxFasterQuality				= 1;
	gxDraftQuality				= 2;

{ Constants for firstTray and remainingTray fields in universal print record }
	gxFirstTray					= 0;
	gxSecondTray				= 1;
	gxThirdTray					= 2;

{ Constants for coverPage field in universal print record }
	gxNoCoverPage				= 0;
	gxFirstPageCover			= 1;
	gxLastPageCover				= 2;

{ Constants for headMotion field in universal print record }
	gxUnidirectionalMotion		= 0;
	gxBidirectionalMotion		= 1;

{ Constants for saveFile field in universal print record }
	gxNoFile					= 0;
	gxPostScriptFile			= 1;

{ The format of the "universal" print record }

TYPE
	gxUniversalPrintRecord = RECORD
		prVersion:				INTEGER;								{ Print record version }
		{
														prInfo subrecord
												}
		appDev:					INTEGER;								{ Device kind, always 0 }
		appVRes:				INTEGER;								{ Application vertical resolution }
		appHRes:				INTEGER;								{ Application horizontal resolution }
		appPage:				Rect;									{ Page size, in application resolution }
		appPaper:				Rect;									{ Paper rectangle [offset from rPage] }
		{
														prStl subrecord
												}
		devType:				INTEGER;								{ Device type, always 0xA900 (was wDev) }
		pageV:					INTEGER;								{ Page height in 120ths of an inch }
		pageH:					INTEGER;								{ Page width in 120ths of an inch }
		fillByte:				CHAR;									{ Page calculation mode }
		feed:					CHAR;									{ Feed mode }
		{
														prInfoPT subrecord
												}
		devKind:				INTEGER;								{ Device kind, always 0 }
		devVRes:				INTEGER;								{ Device vertical resolution }
		devHRes:				INTEGER;								{ Device horizontal resolution }
		devPage:				Rect;									{ Device page size }
		{
														prXInfo subrecord
												}
		actualCopies:			INTEGER;								{ Actual number of copies for this job }
		options:				INTEGER;								{ Options for this device }
		reduction:				INTEGER;								{ Reduce/enlarge factor }
		orientation:			CHAR;									{ Orientation of paper ( 0=portrait, 1=landscape ) }
		{
														Clusters and PopUps
												}
		qualityMode:			CHAR;									{ Quality mode }
		coverPage:				CHAR;									{ Cover page }
		firstTray:				CHAR;									{ First feed tray }
		remainingTray:			CHAR;									{ Remaining feed tray }
		headMotion:				CHAR;									{ Head motion }
		saveFile:				CHAR;									{ Save file }
		userCluster1:			CHAR;									{ Three clusters left over }
		userCluster2:			CHAR;
		userCluster3:			CHAR;
		{
														prJob subrecord
												}
		firstPage:				INTEGER;								{ First page }
		lastPage:				INTEGER;								{ Last page }
		copies:					INTEGER;								{ Number of copies, always 1 }
		reserved1:				CHAR;									{ Always true, unused }
		reserved2:				CHAR;									{ Always true, unused }
		pIdleProc:				PrIdleUPP;								{ Idle proc }
		pFileName:				Ptr;									{ Spool file name pointer }
		fileVol:				INTEGER;								{ Spool file vRefNum }
		fileVers:				CHAR;									{ File version, must be 0 }
		reserved3:				CHAR;									{ Always 0 }
		printX:					ARRAY [0..18] OF INTEGER;				{ Internal use }
	END;

	gxUniversalPrintRecordPtr = ^gxUniversalPrintRecord;
	gxUniversalPrintRecordHdl = ^gxUniversalPrintRecordPtr;

{ ------------------------------------------------------------------------------

							Compatibility Printing Messages

-------------------------------------------------------------------------------- }

FUNCTION Forward_GXPrOpenDoc(hPrint: THPrint; VAR pPort: TPPrPort): OSErr; C;
FUNCTION Forward_GXPrCloseDoc(pPort: TPPrPort): OSErr; C;
FUNCTION Forward_GXPrOpenPage(pPort: TPPrPort; pRect: TPRect; resolution: Point): OSErr; C;
FUNCTION Forward_GXPrClosePage(pPort: TPPrPort): OSErr; C;
FUNCTION Forward_GXPrintDefault(hPrint: THPrint): OSErr; C;
FUNCTION Forward_GXPrStlDialog(hPrint: THPrint; VAR confirmed: BOOLEAN): OSErr; C;
FUNCTION Forward_GXPrJobDialog(hPrint: THPrint; VAR confirmed: BOOLEAN): OSErr; C;
FUNCTION Forward_GXPrStlInit(hPrint: THPrint; VAR pDlg: TPPrDlgRef): OSErr; C;
FUNCTION Forward_GXPrJobInit(hPrint: THPrint; VAR pDlg: TPPrDlgRef): OSErr; C;
FUNCTION Forward_GXPrDlgMain(hPrint: THPrint; initProc: PDlgInitUPP; VAR confirmed: BOOLEAN): OSErr; C;
FUNCTION Forward_GXPrValidate(hPrint: THPrint; VAR changedPrintRecord: BOOLEAN): OSErr; C;
FUNCTION Forward_GXPrJobMerge(srcPrint: THPrint; destPrint: THPrint): OSErr; C;
FUNCTION Forward_GXPrGeneral(dataPtr: Ptr): OSErr; C;
FUNCTION Forward_GXConvertPrintRecordTo(hPrint: THPrint): OSErr; C;
FUNCTION Forward_GXConvertPrintRecordFrom(hPrint: THPrint): OSErr; C;
FUNCTION Forward_GXPrintRecordToJob(hPrint: THPrint; aJob: gxJob): OSErr; C;
{ ------------------------------------------------------------------------------

						Raster Driver Contants and Types

-------------------------------------------------------------------------------- }
	
TYPE
	gxRasterPlaneOptions = LONGINT;

{ Input structure for setting up the offscreen }
	gxPlaneSetupRec = RECORD
		planeOptions:			gxRasterPlaneOptions;					{ Options for the offscreen package }
		planeHalftone:			gxHalftone;								{ OPTIONAL: halftone structure for this plane }
		planeSpace:				gxColorSpace;							{ OPTIONAL: noSpace will get the graphics default }
		planeSet:				gxColorSet;								{ OPTIONAL: NIL gets the default }
		planeProfile:			gxColorProfile;							{ OPTIONAL: NIL gets no matching }
	END;

{ Constants for planeOptions field in gxPlaneSetupRec }

CONST
	gxDefaultOffscreen			= $00000000;					{ Default value - bits are allocated for the client, halftoning takes place }
	gxDontSetHalftone			= $00000001;					{ Don't call SetViewPortHalftone }
	gxDotTypeIsDitherLevel		= $00000002;					{ Call SetViewPortDither using the dotType as the level }


TYPE
	gxOffscreenSetupRec = RECORD
		width:					INTEGER;								{ Width in pixels }
		minHeight:				INTEGER;								{ Minimum height in pixels - actual height returned here }
		maxHeight:				INTEGER;								{ Maximum height in pixels }
		ramPercentage:			Fixed;									{ Maximum percentage of RAM to take }
		ramSlop:				LONGINT;								{ Amount of RAM to be sure to leave }
		depth:					INTEGER;								{ Depths in bits of each plane }
		vpMapping:				gxMapping;								{ Mapping to assign to offscreen viewPorts }
		vdMapping:				gxMapping;								{ Mapping to assign to offscreen viewDevices }
		planes:					INTEGER;								{ Number of planes to allocate of depth bits each (can be more than 4) }
		planeSetup:				ARRAY [0..3] OF gxPlaneSetupRec;		{ Parameters for each plane, 4 is provided because it is most handy for writers of devices }
	END;

{ The format of one plane in the offscreen planar area }
	gxOffscreenPlaneRec = RECORD
		theViewPort:			gxViewPort;								{ viewPort for the offscreen }
		theDevice:				gxViewDevice;							{ viewDevice for the offscreen }
		theViewGroup:			gxViewGroup;							{ The viewGroup that they share }
		theBitmap:				gxShape;								{ The offscreen bitmap shape }
		theBits:				gxBitmap;								{ The bits of the offscreen }
	END;

{ The format of an entire offscreen area }
	gxOffscreenRec = RECORD
		numberOfPlanes:			INTEGER;								{ Number of planes we have }
		offscreenStorage:		Handle;									{ Handle containing the bitmaps image data }
		thePlanes:				ARRAY [0..0] OF gxOffscreenPlaneRec;	{ Planes to draw in }
	END;

	gxOffscreenPtr = ^gxOffscreenRec;
	gxOffscreenHdl = ^gxOffscreenPtr;

	gxRasterRenderOptions = LONGINT;

{ Structure that mirrors 'rdip' resource. }
	gxRasterPrefsRec = RECORD
		renderOptions:			gxRasterRenderOptions;					{ Options for the raster imaging system }
		hImageRes:				Fixed;									{ Horizontal resolution to image at }
		vImageRes:				Fixed;									{ Vertical resolution to image at }
		minBandSize:			INTEGER;								{ Minimum band size to use (in pixels) }
		maxBandSize:			INTEGER;								{ Maximum band size to use (in pixels), 0 == entire page }
		ramPercentage:			Fixed;									{ Maximum percentage of RAM to take }
		ramSlop:				LONGINT;								{ Amount of RAM to be sure to leave }
		depth:					INTEGER;								{ Depth in pixels (PER PLANE!) }
		numPlanes:				INTEGER;								{ Number of planes to render }
		planeSetup:				ARRAY [0..0] OF gxPlaneSetupRec;		{ One for each plane }
	END;

{ Constants for renderOptions field in gxRasterPrefsRec. }

CONST
	gxDefaultRaster				= $00000000;					{ Default raster options }
	gxDontResolveTransferModes	= $00000001;					{ 0=Resolve, 1=Don't Resolve }
	gxRenderInReverse			= $00000002;					{ Traverse image in reverse order }
	gxOnePlaneAtATime			= $00000004;					{ Render each plane separately }
	gxSendAllBands				= $00000008;					{ Send even empty bands }

	
TYPE
	gxRasterPrefsPtr = ^gxRasterPrefsRec;
	gxRasterPrefsHdl = ^gxRasterPrefsPtr;

	gxRasterPackageOptions = LONGINT;

{ Structure that mirrors 'rpck' resource. }
	gxRasterPackageRec = RECORD
		bufferSize:				Ptr;									{ Buffer size for packaging (>= maximum head pass size) }
		colorPasses:			INTEGER;								{ 1 (b/w) or 4 (CMYK) is typical }
		headHeight:				INTEGER;								{ Printhead height in pixels }
		numberPasses:			INTEGER;								{ Number of head passes it takes to == iHeadHeight }
		passOffset:				INTEGER;								{ Offset between passes, in pixels }
		packageOptions:			gxRasterPackageOptions;					{ Packaging options }
	END;

	gxRasterPackagePtr = ^gxRasterPackageRec;
	gxRasterPackageHdl = ^gxRasterPackagePtr;

{ Constants for packageOptions field in gxRasterPackageRec. }

CONST
	gxSendAllColors				= $00000001;					{ Send even clean bands through }
	gxInterlaceColor			= $00000002;					{ Ribbon contamination is a concern }
	gxOverlayColor				= $00000004;					{ Color printer without a ribbon problem }
	gxUseColor					= 0+(gxInterlaceColor + gxOverlayColor); { This is a color printer }

{ Structure for RasterPackageBitmap message }

TYPE
	gxRasterPackageBitmapRec = RECORD
		bitmapToPackage:		^gxBitmap;								{ Bitmap containing the data to package }
		startRaster:			INTEGER;								{ Raster to begin the packaging from }
		colorBand:				INTEGER;								{ For which color pass this is a packaging request }
		isBandDirty:			BOOLEAN;								{ Whether there are any dirty bits in this band }
		padByte:				CHAR;
		dirtyRect:				Rect;									{ Which bits are dirty }
	END;

{ Structure of number record in gxRasterPackageControlsRec }
	gxStandardNumberRec = RECORD
		numberType:				INTEGER;								{ Type of numberic output desired }
		minWidth:				INTEGER;								{ Minimum output width of the number }
		padChar:				CHAR;									{ Pad character for numbers shorter than the minWidth }
		padChar2:				CHAR;
		startString:			Str31;									{ Prefix string }
		endString:				Str31;									{ Postfix string }
	END;

	gxStandardNumberPtr = ^gxStandardNumberRec;

{ Structure that mirrors 'ropt' resource }
	gxRasterPackageControlsRec = RECORD
		startPageStringID:		INTEGER;								{ 'wstr' to send to the device at start of page }
		formFeedStringID:		INTEGER;								{ 'wstr' to send to the device to cause a form feed }
		forwardMax:				INTEGER;								{ Line feed strings }
		forwardLineFeed:		gxStandardNumberRec;					{ Number record for forward line feed }
		reverseMax:				INTEGER;								{ Max number of reverse line feeds device can do }
		reverseLineFeed:		gxStandardNumberRec;					{ Number record for forward line feed }
	END;

	gxRasterPackageControlsPtr = ^gxRasterPackageControlsRec;
	gxRasterPackageControlsHdl = ^gxRasterPackageControlsPtr;

{ Raster imaging system imageData structure }
	gxRasterImageDataRec = RECORD
		renderOptions:			gxRasterRenderOptions;					{ Options for the raster imaging system }
		hImageRes:				Fixed;									{ horizontal resolution to image at }
		vImageRes:				Fixed;									{ vertical resolution to image at }
		minBandSize:			INTEGER;								{ smallest band that makes sense for this device }
		maxBandSize:			INTEGER;								{ biggest band that makes sense, or 0 for "full page" }
		pageSize:				gxRectangle;							{ size of page for device }
		{
			Values used within the RasterDataIn message
	}
		currentYPos:			INTEGER;								{ Current position moving down the page }
		packagingInfo:			gxRasterPackageRec;						{ Raster packaging record }
		{
			Values used within the remaining messages
	}
		optionsValid:			BOOLEAN;								{ Were options specified by the driver? }
		padByte:				CHAR;
		packageControls:		gxRasterPackageControlsRec;				{ Options for the packaging messages }
		theSetup:				gxOffscreenSetupRec;					{ setup for the offscreen code, variable length componant }
	END;

	gxRasterImageDataPtr = ^gxRasterImageDataRec;
	gxRasterImageDataHdl = ^gxRasterImageDataPtr;

{ ------------------------------------------------------------------------------

								Raster Driver Imaging Messages

-------------------------------------------------------------------------------- }

FUNCTION Send_GXRasterDataIn(offScreen: gxOffscreenHdl; VAR bandRectangle: gxRectangle; VAR dirtyRectangle: gxRectangle): OSErr; C;
FUNCTION Forward_GXRasterDataIn(offScreen: gxOffscreenHdl; VAR bandRectangle: gxRectangle; VAR dirtyRectangle: gxRectangle): OSErr; C;
FUNCTION Send_GXRasterLineFeed(VAR lineFeedSize: LONGINT; buffer: Ptr; VAR bufferPos: LONGINT; imageDataHdl: gxRasterImageDataHdl): OSErr; C;
FUNCTION Forward_GXRasterLineFeed(VAR lineFeedSize: LONGINT; buffer: Ptr; VAR bufferPos: LONGINT; imageDataHdl: gxRasterImageDataHdl): OSErr; C;
FUNCTION Send_GXRasterPackageBitmap(VAR whatToPackage: gxRasterPackageBitmapRec; buffer: Ptr; VAR bufferPos: LONGINT; imageDataHdl: gxRasterImageDataHdl): OSErr; C;
FUNCTION Forward_GXRasterPackageBitmap(VAR whatToPackage: gxRasterPackageBitmapRec; buffer: Ptr; VAR bufferPos: LONGINT; imageDataHdl: gxRasterImageDataHdl): OSErr; C;
{ ------------------------------------------------------------------------------

						Vector Driver Contants and Types

-------------------------------------------------------------------------------- }
{ Vector device halftone component record }

TYPE
	gxVHalftoneCompRec = RECORD
		angle:					Fixed;									{ Angle to halftone at. Must be 0, 90, 45 or 135 }
		penIndex:				LONGINT;								{ index of the pen to draw this component with }
	END;

{ Vector device halftone record }
	gxVHalftoneRec = RECORD
		halftoneSpace:			gxColorSpace;
		halftoneComps:			ARRAY [0..3] OF gxVHalftoneCompRec;		{ Info for each color component }
		penIndexForBW:			LONGINT;								{ Pen index to draw one bit deep or black and white bitmap with }
	END;

{ Vector shape rendering information }
	gxVectorShapeOptions = LONGINT;

	gxVectorShapeDataRec = RECORD
		shapeOptions:			gxVectorShapeOptions;					{ Options to control shape handling }
		maxPolyPoints:			LONGINT;								{ Maximum number of polygon points that device can support }
		shapeError:				Fixed;									{ Defines allowed deviation from the original shape }
		textSize:				Fixed;									{ Text above this size is filled; text below this size is outlined }
		frameSize:				Fixed;									{ Frame's smaller than this -> shape stroked; frame's larger -> shape is filled }
	END;

{ Constants for shapeOptions field in gxVectorShapeDataRec. }

CONST
	gxUnidirectionalFill		= $00000001;					{ Generate scanlines in one direction only.  Useful for transparencies }
	gxAlsoOutlineFilledShape	= $00000002;					{ Turn on this bit to also outline solid filled shapes }

{ Vector device rendering information }
	
TYPE
	gxVectorRenderOptions = LONGINT;

{ Vector imaging system imageData structure }
	gxVectorImageDataRec = RECORD
		renderOptions:			gxVectorRenderOptions;					{ Options to control rendering: color sort, clipping, etc. }
		devRes:					Fixed;									{ Device resolution }
		devTransform:			gxTransform;							{ Mapping, clip and halftoning information for colored bitmaps }
		clrSet:					gxColorSet;								{ Entire set of colors; usually indexed color space for pen plotters }
		bgColor:				gxColor;								{ The background color in the color space specified by the clrSpace field }
		halftoneInfo:			gxVHalftoneRec;							{ Defines halftone information for color bitmaps }
		hPenTable:				gxPenTableHdl;							{ Complete list of pens along with their pen positions and thickness }
		pageRect:				gxRectangle;							{ Page dimensions }
		shapeData:				gxVectorShapeDataRec;					{ Information on how to render a shape }
	END;

	gxVectorImageDataPtr = ^gxVectorImageDataRec;
	gxVectorImageDataHdl = ^gxVectorImageDataPtr;

{ Constants for renderOptions field in gxVectorImageDataRec. }

CONST
	gxColorSort					= $00000001;					{ Set for pen plotters }
	gxATransferMode				= $00000002;					{ Set if transfer modes need to be resolved }
	gxNoOverlap					= $00000004;					{ Set if non-overlapping output is desired}
	gxAColorBitmap				= $00000008;					{ Set if color bitmap output is desired }
	gxSortbyPenPos				= $00000010;					{ Set if shapes are to be drawn in the order of the pen index }
{ in the pen table. NOTE: this is not the pen position in the carousel }
	gxPenLessPlotter			= $00000020;					{ Indicates raster printer/plotter }
	gxCutterPlotter				= $00000040;					{ Indicates cutter }
	gxNoBackGround				= $00000080;					{ Set if shapes that map to the background color should not be sent to driver }

{ ------------------------------------------------------------------------------

								Vector Driver Imaging Messages

-------------------------------------------------------------------------------- }

FUNCTION Send_GXVectorPackageShape(theShape: gxShape; penIndex: LONGINT): OSErr; C;
FUNCTION Forward_GXVectorPackageShape(theShape: gxShape; penIndex: LONGINT): OSErr; C;
FUNCTION Send_GXVectorLoadPens(penTable: gxPenTableHdl; VAR shapeCounts: LONGINT; VAR penTableChanged: BOOLEAN): OSErr; C;
FUNCTION Forward_GXVectorLoadPens(penTable: gxPenTableHdl; VAR shapeCounts: LONGINT; VAR penTableChanged: BOOLEAN): OSErr; C;
FUNCTION Send_GXVectorVectorizeShape(theShape: gxShape; penIndex: LONGINT; VAR vectorData: gxVectorShapeDataRec): OSErr; C;
FUNCTION Forward_GXVectorVectorizeShape(theShape: gxShape; penIndex: LONGINT; VAR vectorData: gxVectorShapeDataRec): OSErr; C;
{ ------------------------------------------------------------------------------

							PostScript Driver Contants and Types

-------------------------------------------------------------------------------- }

CONST
	gxPostSynonym				= 'post';

{ PostScript glyphs record }

TYPE
	gxPrinterGlyphsRec = RECORD
		theFont:				gxFont;									{  ---> Font reference }
		nGlyphs:				LONGINT;								{  ---> Number of glyphs in the font }
		platform:				gxFontPlatform;							{ <---  How printer font is encoded }
		script:					gxFontScript;							{ <---  Script if platform != glyphPlatform }
		language:				gxFontLanguage;							{ <---  Language if platform != glyphPlatform }
		vmUsage:				LONGINT;								{ <---  How much PostScript VM font uses }
		{ Size of this array is long-alligned(nGlyphs) }
		glyphBits:				ARRAY [0..0] OF LONGINT;				{ <---  Bit array of which system glyphs are in printer }
	END;

{ PostScript device rendering information }
	gxPostScriptRenderOptions = LONGINT;

	gxPostScriptImageDataRec = RECORD
		languageLevel:			INTEGER;								{ PostScript language level }
		devCSpace:				gxColorSpace;							{ The printer's color space }
		devCProfile:			gxColorProfile;							{ The printer's color profile for matching }
		renderOptions:			gxPostScriptRenderOptions;				{ Options for the imaging system }
		pathLimit:				LONGINT;								{ Maximum path size }
		gsaveLimit:				INTEGER;								{ Maximum number of gsaves allowed }
		opStackLimit:			INTEGER;								{ Operand stack limit }
		fontType:				scalerStreamTypeFlag;					{ These are the font types that the printer supports  }
		printerVM:				LONGINT;								{ How much memory is in the printer }
		reserved0:				LONGINT;
	END;

	gxPostScriptImageDataPtr = ^gxPostScriptImageDataRec;
	gxPostScriptImageDataHdl = ^gxPostScriptImageDataPtr;

{ Constants for renderOptions field in gxPostScriptImageDataRec. }

CONST
	gxNeedsHexOption			= $00000001;					{ Convert all binary data to hex }
	gxNeedsCommentsOption		= $00000002;					{ Issue PostScript comments }
	gxBoundingBoxesOption		= $00000004;					{ Calculate the values for %%BoundingBox: and %%PageBoundingBox: -- requires needsCommentsOption }
	gxPortablePostScriptOption	= $00000008;					{ Generate portable PostScript }
	gxTextClipsToPathOption		= $00000010;					{ Convert all clips that are composed of text to path shapes }
	gxFlattenClipPathOption		= $00000020;					{ Convert all clips that are path shapes to polygons (helps better control point limit) }
	gxUseCharpath1Option		= $00000040;					{ (ignored if text clips are converted to paths)  When the clip is text,  }
{ Do it one glyph at a time, redrawing the main shape each time }
	gxUseLevel2ColorOption		= $00000080;					{ When printing to level-2 use level-2 device independent color }
	gxNoEPSIllegalOperators		= $00000100;					{ Don't use any operators prohibited by the Encapsulated PostScript File Format V3.0 }
	gxEPSTargetOption			= gxNoEPSIllegalOperators + gxNeedsCommentsOption + gxBoundingBoxesOption; { PostScript intended for EPS Use. }

{ Structure for gxPostScriptGetProcSetList / gxPostScriptDownLoadProcSetList }

TYPE
	gxProcSetListRec = RECORD
		clientid:				gxOwnerSignature;
		controlType:			OSType;									{ The driver will call FetchTaggedData on each of these resources }
		controlid:				INTEGER;
		dataType:				OSType;
		reserved0:				LONGINT;
	END;

	gxProcSetListPtr = ^gxProcSetListRec;
	gxProcSetListHdl = ^gxProcSetListPtr;

{ Possible results of querying printer (returned by gxPostScriptQueryPrinter message) }

CONST
	gxPrinterOK					= 0;
	gxIntializePrinter			= 1;
	gxFilePrinting				= 2;
	gxResetPrinter				= 128;

{ ------------------------------------------------------------------------------

								PostScript Driver Imaging Messages

-------------------------------------------------------------------------------- }

FUNCTION Send_GXPostScriptQueryPrinter(VAR queryData: LONGINT): OSErr; C;
FUNCTION Forward_GXPostScriptQueryPrinter(VAR queryData: LONGINT): OSErr; C;
FUNCTION Send_GXPostScriptInitializePrinter: OSErr; C;
FUNCTION Forward_GXPostScriptInitializePrinter: OSErr; C;
FUNCTION Send_GXPostScriptResetPrinter: OSErr; C;
FUNCTION Forward_GXPostScriptResetPrinter: OSErr; C;
FUNCTION Send_GXPostScriptExitServer: OSErr; C;
FUNCTION Forward_GXPostScriptExitServer: OSErr; C;
{

		Device communication messages

}
FUNCTION Send_GXPostScriptGetStatusText(textHdl: Handle): OSErr; C;
FUNCTION Forward_GXPostScriptGetStatusText(textHdl: Handle): OSErr; C;
FUNCTION Send_GXPostScriptGetPrinterText(textHdl: Handle): OSErr; C;
FUNCTION Forward_GXPostScriptGetPrinterText(textHdl: Handle): OSErr; C;
FUNCTION Send_GXPostScriptScanStatusText(textHdl: Handle): OSErr; C;
FUNCTION Forward_GXPostScriptScanStatusText(textHdl: Handle): OSErr; C;
FUNCTION Send_GXPostScriptScanPrinterText(textHdl: Handle): OSErr; C;
FUNCTION Forward_GXPostScriptScanPrinterText(textHdl: Handle): OSErr; C;
{

		Proc set management messages

}
FUNCTION Send_GXPostScriptGetDocumentProcSetList(procSet: gxProcSetListHdl; imageDataHdl: gxPostScriptImageDataHdl): OSErr; C;
FUNCTION Forward_GXPostScriptGetDocumentProcSetList(procSet: gxProcSetListHdl; imageDataHdl: gxPostScriptImageDataHdl): OSErr; C;
FUNCTION Send_GXPostScriptDownloadProcSetList(procSet: gxProcSetListHdl; imageDataHdl: gxPostScriptImageDataHdl): OSErr; C;
FUNCTION Forward_GXPostScriptDownloadProcSetList(procSet: gxProcSetListHdl; imageDataHdl: gxPostScriptImageDataHdl): OSErr; C;
{

		Font management messages

}
FUNCTION Send_GXPostScriptGetPrinterGlyphsInformation(VAR glyphsInfo: gxPrinterGlyphsRec): OSErr; C;
FUNCTION Forward_GXPostScriptGetPrinterGlyphsInformation(VAR glyphsInfo: gxPrinterGlyphsRec): OSErr; C;
FUNCTION Send_GXPostScriptStreamFont(fontref: gxFont; VAR streamPtr: scalerStream): OSErr; C;
FUNCTION Forward_GXPostScriptStreamFont(fontref: gxFont; VAR streamPtr: scalerStream): OSErr; C;
{

		Document structuring and formatting messages

}
FUNCTION Send_GXPostScriptDoDocumentHeader(imageDataHdl: gxPostScriptImageDataHdl): OSErr; C;
FUNCTION Forward_GXPostScriptDoDocumentHeader(imageDataHdl: gxPostScriptImageDataHdl): OSErr; C;
FUNCTION Send_GXPostScriptDoDocumentSetup(imageDataHdl: gxPostScriptImageDataHdl): OSErr; C;
FUNCTION Forward_GXPostScriptDoDocumentSetup(imageDataHdl: gxPostScriptImageDataHdl): OSErr; C;
FUNCTION Send_GXPostScriptDoDocumentTrailer(imageDataHdl: gxPostScriptImageDataHdl): OSErr; C;
FUNCTION Forward_GXPostScriptDoDocumentTrailer(imageDataHdl: gxPostScriptImageDataHdl): OSErr; C;
{

		Page structuring and formatting messages

}
FUNCTION Send_GXPostScriptDoPageSetup(pageFormat: gxFormat; thePage: LONGINT; imageDataHdl: gxPostScriptImageDataHdl): OSErr; C;
FUNCTION Forward_GXPostScriptDoPageSetup(pageFormat: gxFormat; thePage: LONGINT; imageDataHdl: gxPostScriptImageDataHdl): OSErr; C;
FUNCTION Send_GXPostScriptSelectPaperType(thePapertype: gxPaperType; thePage: LONGINT; imageDataHdl: gxPostScriptImageDataHdl): OSErr; C;
FUNCTION Forward_GXPostScriptSelectPaperType(thePapertype: gxPaperType; thePage: LONGINT; imageDataHdl: gxPostScriptImageDataHdl): OSErr; C;
FUNCTION Send_GXPostScriptDoPageTrailer(imageDataHdl: gxPostScriptImageDataHdl): OSErr; C;
FUNCTION Forward_GXPostScriptDoPageTrailer(imageDataHdl: gxPostScriptImageDataHdl): OSErr; C;
FUNCTION Send_GXPostScriptEjectPage(thePapertype: gxPaperType; pagenumber: LONGINT; copiescount: LONGINT; erasepage: LONGINT; imageDataHdl: gxPostScriptImageDataHdl): OSErr; C;
FUNCTION Forward_GXPostScriptEjectPage(thePapertype: gxPaperType; pagenumber: LONGINT; copiescount: LONGINT; erasepage: LONGINT; imageDataHdl: gxPostScriptImageDataHdl): OSErr; C;
FUNCTION Send_GXPostScriptEjectPendingPage(VAR pageWasEjected: BOOLEAN): OSErr; C;
FUNCTION Forward_GXPostScriptEjectPendingPage(VAR pageWasEjected: BOOLEAN): OSErr; C;
{

		Shape imaging messages

}
FUNCTION Send_GXPostScriptProcessShape(page: gxShape; trcount: LONGINT; trlist: gxTransform): OSErr; C;
FUNCTION Forward_GXPostScriptProcessShape(page: gxShape; trcount: LONGINT; trlist: gxTransform): OSErr; C;
{ ------------------------------------------------------------------------------

											Driver API Functions

-------------------------------------------------------------------------------- }

CONST
	gxMissingImagePointer		= -4;


FUNCTION GXAddPrinterViewDevice(thePrinter: gxPrinter; theViewDevice: gxViewDevice): OSErr; C;
FUNCTION GXGetAvailableJobFormatModes(VAR theFormatModes: gxJobFormatModeTableHdl): OSErr; C;
FUNCTION GXSetPreferredJobFormatMode(theFormatMode: gxJobFormatMode; directOnly: BOOLEAN): OSErr; C;
FUNCTION GXPrintingAlert(iconId: LONGINT; txtSize: LONGINT; defaultTitleNum: LONGINT; cancelTitleNum: LONGINT; textLength: LONGINT; pAlertMsg: Ptr; actionTitle: StringPtr; title2: StringPtr; title3: StringPtr; msgFont: StringPtr; filterProc: ModalFilterUPP; VAR itemHit: INTEGER; alertTitle: StringPtr): OSErr; C;
FUNCTION GXGetPrintingAlert(alertResId: LONGINT; filterProc: ModalFilterUPP; VAR itemHit: INTEGER): OSErr; C;
FUNCTION GXFetchDTPData(VAR dtpName: Str31; theType: OSType; theID: LONGINT; VAR theData: Handle): OSErr; C;
FUNCTION GXWriteDTPData(VAR dtpName: Str31; theType: OSType; theID: LONGINT; theData: Handle): OSErr; C;
FUNCTION GXHandleChooserMessage(VAR aJob: gxJob; VAR driverName: Str31; message: LONGINT; caller: LONGINT; objName: StringPtr; zoneName: StringPtr; theList: ListHandle; p2: LONGINT): OSErr; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := GXPrinterDriversIncludes}

{$ENDC} {__GXPRINTERDRIVERS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
