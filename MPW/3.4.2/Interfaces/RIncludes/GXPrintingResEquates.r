/*
	File:		GXPrintingResEquates.r

	Contains:	This module contains resource constants which can be
				included by the Rez compiler.  These constants are
				used by creators of Printer Drivers or Printing Extensions.

	Version:	Quickdraw GX 1.1 for ETO #18

	Copyright:	© 1994-1995 by Apple Computer, Inc., all rights reserved.
*/


#ifndef _GXPRINTINGRESEQUATES_
#define _GXPRINTINGRESEQUATES_

// -------------------------------------------------------------------------------
// Basic client types
// -------------------------------------------------------------------------------

#define gxPrintingManagerType		'pmgr'

#define gxImagingSystemType			'gxis'
#define gxPrinterDriverType			'pdvr'
#define gxPrintingExtensionType		'pext'

#define	gxUnknownPrinterType		'none'
#define	gxAnyPrinterType			'univ'
#define	gxQuickdrawPrinterType		'qdrw'
#define	gxPortableDocPrinterType	'gxpd'

#define	gxRasterPrinterType			'rast'
#define	gxPostscriptPrinterType		'post'
#define	gxVectorPrinterType			'vect'


// -------------------------------------------------------------------------------
// Printing collection tags have the following ID
// -------------------------------------------------------------------------------


#define gxPrintingTagID (-28672)


// -------------------------------------------------------------------------------
// Resource types and IDs used by both extension and driver writers
// -------------------------------------------------------------------------------


// Resources in a printer driver or extension must be based off of this ID

#define gxPrintingDriverBaseID (-27648)
#define gxPrintingExtensionBaseID (-27136)

// override resources tell the system what messages a driver or extension
// is overriding.  A driver may have a series of these resources.

#define	gxOverrideType			'over'
	

// -------------------------------------------------------------------------------
// Message ID definitions by both extension and driver writers
// -------------------------------------------------------------------------------


// identifiers for universal message overrides...


#define gxInitialize				0
#define gxShutDown					1

#define gxJobIdle					2
#define gxJobStatus					3
#define gxPrintingEvent				4

#define gxJobDefaultFormatDialog	5
#define gxFormatDialog				6
#define gxJobPrintDialog			7
#define gxFilterPanelEvent			8
#define gxHandlePanelEvent			9
#define gxParsePageRange			10

#define gxDefaultJob				11
#define gxDefaultFormat				12
#define gxDefaultPaperType			13
#define gxDefaultPrinter			14

#define gxCreateSpoolFile			15
#define gxSpoolPage					16
#define gxSpoolData					17
#define gxSpoolResource				18
#define gxCompleteSpoolFile			19

#define gxCountPages				20
#define gxDespoolPage				21
#define gxDespoolData				22
#define gxDespoolResource			23
#define gxCloseSpoolFile			24

#define gxStartJob					25
#define gxFinishJob					26
#define gxStartPage					27
#define gxFinishPage				28
#define gxPrintPage					29

#define gxSetupImageData			30
#define gxImageJob					31
#define gxImageDocument				32
#define gxImagePage					33
#define gxRenderPage				34
#define gxCreateImageFile			35

#define gxOpenConnection			36
#define gxCloseConnection			37
#define gxStartSendPage				38
#define gxFinishSendPage			39

#define gxWriteData					40
#define gxBufferData				41
#define gxDumpBuffer				42
#define gxFreeBuffer				43

#define gxCheckStatus				44
#define gxGetDeviceStatus			45

#define gxFetchTaggedData			46

#define gxGetDTPMenuList			47
#define gxDTPMenuSelect				48
#define gxHandleAlertFilter			49

#define gxJobFormatModeQuery		50

#define gxWriteStatusToDTPWindow	51
#define gxInitializeStatusAlert		52
#define gxHandleAlertStatus			53
#define gxHandleAlertEvent			54

#define gxCleanupStartJob			55
#define gxCleanupStartPage			56
#define gxCleanupOpenConnection		57
#define gxCleanupStartSendPage		58

#define gxDefaultDesktopPrinter		59
#define gxCaptureOutputDevice		60

#define gxOpenConnectionRetry		61
#define gxExamineSpoolFile			62

#define gxFinishSendPlane			63
#define gxDoesPaperFit				64
#define gxChooserMessage			65

#define gxFindPrinterProfile		66
#define	gxFindFormatProfile			67
#define gxSetPrinterProfile			68
#define gxSetFormatProfile			69

#define gxHandleAltDestination		70
#define gxSetupPageImageData		71

// identifiers for Quickdraw message overrides...


#define	gxPrOpenDoc 	 				0
#define	gxPrCloseDoc 	 				1
#define	gxPrOpenPage 	 				2
#define	gxPrClosePage  					3
#define	gxPrintDefault 					4
#define	gxPrStlDialog  					5
#define	gxPrJobDialog  					6
#define	gxPrStlInit 					7
#define	gxPrJobInit 	 				8
#define	gxPrDlgMain 	 				9
#define	gxPrValidate 	 				10
#define	gxPrJobMerge 	 				11
#define	gxPrGeneral 	 				12
#define	gxConvertPrintRecordTo 			13
#define	gxConvertPrintRecordFrom 		14
#define	gxPrintRecordToJob 	 			15


// identifiers for raster imaging message overrides...


#define gxRasterDataIn				0
#define gxRasterLineFeed			1
#define gxRasterPackageBitmap		2


// identifiers for PostScript imaging message overrides...


#define 	gxPostscriptQueryPrinter					0
#define 	gxPostscriptInitializePrinter				1
#define 	gxPostscriptResetPrinter					2
#define 	gxPostscriptExitServer						3
#define 	gxPostscriptGetStatusText					4
#define 	gxPostscriptGetPrinterText					5
#define		gxPostscriptScanStatusText					6
#define		gxPostscriptScanPrinterText					7
#define		gxPostscriptGetDocumentProcSetList			8
#define 	gxPostscriptDownloadProcSetList				9
#define 	gxPostscriptGetPrinterGlyphsInformation		10
#define		gxPostscriptStreamFont						11
#define 	gxPostscriptDoDocumentHeader				12
#define 	gxPostscriptDoDocumentSetUp					13
#define 	gxPostscriptDoDocumentTrailer				14
#define 	gxPostscriptDoPageSetUp						15
#define 	gxPostscriptSelectPaperType					16
#define 	gxPostscriptDoPageTrailer					17
#define		gxPostscriptEjectPage						18
#define 	gxPostscriptProcessShape					19
#define		gxPostScriptEjectPendingPage				20


// identifiers for Vector imaging message overrides...


#define gxVectorPackageData		0
#define gxVectorLoadPens	 	1
#define gxVectorVectorizeShape	2

// printing alert type

#define gxPrintingAlertType		'plrt'


#define gxStatusType			'stat'
#define gxExtendedDITLType		'xdtl'
#define gxPrintPanelType		'ppnl'

#define gxCollectionType		'cltn'

// communication resource types 

/*
	The looker resource is used by the Chooser PACK to determine what kind
	of communications this driver supports. (In order to generate/handle the 
	pop-up menu for "Connect via:".
	
	The looker resource is also used by PrinterShare to determine the AppleTalk NBP Type
	for servers created for this driver.
*/
#define gxLookerType	'look'
#define gxLookerID		-4096

// ----------------------------------• 'comm' •----------------------------------

// The communications method and private data used to connect to the printer
#define gxDeviceCommunicationsType			'comm'


// -------------------------------------------------------------------------------
// Resource types and IDs used by extension writers
// -------------------------------------------------------------------------------


#define	gxExtensionUniversalOverrideID		gxPrintingExtensionBaseID

#define gxExtensionImagingOverrideSelectorID	gxPrintingExtensionBaseID

#define	gxExtensionScopeType			'scop'
	#define gxDriverScopeID					gxPrintingExtensionBaseID
	#define gxPrinterScopeID				gxPrintingExtensionBaseID + 1
	#define gxPrinterExceptionScopeID		gxPrintingExtensionBaseID + 2

#define	gxExtensionLoadType				'load'
	#define gxExtensionLoadID				gxPrintingExtensionBaseID
	
	#define gxExtensionLoadFirst			0x00000100
	#define gxExtensionLoadAnywhere			0x7FFFFFFF
	#define gxExtensionLoadLast				0xFFFFFF00

#define	gxExtensionOptimizationType		'eopt'
	#define gxExtensionOptimizationID		gxPrintingExtensionBaseID


// -------------------------------------------------------------------------------
// Resource types and IDs used by driver writers
// -------------------------------------------------------------------------------


#define	gxDriverUniversalOverrideID		(gxPrintingDriverBaseID)
#define	gxDriverImagingOverrideID		(gxPrintingDriverBaseID + 1)
#define	gxDriverCompatibilityOverrideID	(gxPrintingDriverBaseID + 2)


#define gxDriverFileFormatType				'pfil'
#define gxDriverFileFormatID				(gxPrintingDriverBaseID)

#define gxDestinationAdditionType			'dsta'
#define gxDestinationAdditionID				(gxPrintingDriverBaseID)


// IMAGING RESOURCES

// The imaging system resource specifies which imaging system a printer
// driver wishes to use.

#define	gxImagingSystemSelectorType			'isys'
#define gxImagingSystemSelectorID			(gxPrintingDriverBaseID)


// 'exft' resource ID -- exclude font list
#define kExcludeFontListType				'exft'
#define kExcludeFontListID					(gxPrintingDriverBaseID)

// Resource for type for color matching

#define gxColorMatchingDataType				'prof'
#define gxColorMatchingDataID				(gxPrintingDriverBaseID)


// Resource type and id for the tray count

#define gxTrayCountDataType					'tray'
#define gxTrayCountDataID					(gxPrintingDriverBaseID)


// Resource type for the tray names

#define gxTrayNameDataType				'tryn'


// Resource type for manual feed preferences, stored in DTP.

#define gxManualFeedAlertPrefsType		'mfpr'
#define gxManualFeedAlertPrefsID		(gxPrintingDriverBaseID)


// Resource type for desktop printer output characteristics, stored in DTP.

#define gxDriverOutputType				'outp'
#define gxDriverOutputTypeID			(1)


// IO Resources

// Resource type and ID for default IO and buffering resources

#define gxUniversalIOPrefsType			'iobm'
#define gxUniversalIOPrefsID				(gxPrintingDriverBaseID)


// Resource types and IDs for default implementation of CaptureOutputDevice.
// The default implementation of CaptureOutputDevice only handles PAP devices

#define gxCaptureType							'cpts'
#define gxCaptureStringID						(gxPrintingDriverBaseID)
#define gxReleaseStringID						(gxPrintingDriverBaseID + 1)
#define gxUncapturedAppleTalkType				(gxPrintingDriverBaseID + 2)
#define gxCapturedAppleTalkType					(gxPrintingDriverBaseID + 3)


// Resource type and ID for custom halftone matrix
#define gxCustomMatrixType					'dmat'
#define gxCustomMatrixID					(gxPrintingDriverBaseID)

// Resource type and ID for raster driver rendering preferences

#define gxRasterPrefsType					'rdip'
#define gxRasterPrefsID					(gxPrintingDriverBaseID)


// Resource type for specifiying a colorSet

#define gxColorSetResType	'crst'


// Resource type and ID for raster driver packaging preferences

#define gxRasterPackType					'rpck'
#define gxRasterPackID						(gxPrintingDriverBaseID)


// Resource type and ID for raster driver packaging options

#define gxRasterNumNone			0	// number isn't output at all
#define gxRasterNumDirect		1	// lowest minWidth bytes as data
#define gxRasterNumToASCII		2	// minWidth ASCII characters

#define gxRasterPackOptionsType				'ropt'
#define gxRasterPackOptionsID				(gxPrintingDriverBaseID)


// Resource type for the PostScript imaging system procedure set control resource

#define gxPostscriptProcSetControlType	'prec'


// Resource type for the PostScript imaging system printer font resource

#define gxPostscriptPrinterFontType 		'pfnt'


// Resource type and id for the PostScript imaging system imaging preferences

#define gxPostscriptPrefsType				'pdip'
#define gxPostscriptPrefsID				(gxPrintingDriverBaseID)

// Resource type and id for the PostScript imaging system default scanning code

#define gxPostscriptScanningType			'scan'
#define	gxPostscriptScanningID			(gxPrintingDriverBaseID)


// Old Application Support Resources

#define	gxCustType 			'cust'
#define	gxCustID 			-8192

#define	gxReslType 			'resl'
#define	gxReslID 	 		-8192
#define gxDiscreteResolution 0

#define	gxStlDialogResID 		-8192
#define	gxJobDialogResID 		-8191

#define gxScaleTableType	'stab'
#define gxDITLControlType 'dctl'

// The default implementation of gxPrintDefault loads and
// PrValidates a print record stored in the following resource.

#define gxPrintRecordType			'PREC'
#define gxDefaultPrintRecordID		0


// -------------------------------------------------------------------------------
// Resource types and IDs used in papertype files
// -------------------------------------------------------------------------------


// Resource type and ID for driver papertypes placed in individual files

#define	gxSignatureType					'sig '
#define	gxPapertypeSignatureID			0


// file type for driver papertypes placed in individual files

#define	gxDrvrPaperType					'drpt'

// Paper Type Creators (OSType's)

#define		gxSysPaperType	'sypt'	// System paper type creator
#define		gxUserPaperType	'uspt'	// User paper type creators
									// Driver creator types = driver file's creator value

#define		gxPaperTypeType		'ptyp'

#endif
