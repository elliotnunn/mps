{
     File:       PMDefinitions.p
 
     Contains:   Carbon Printing Manager Interfaces.
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1998-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT PMDefinitions;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PMDEFINITIONS__}
{$SETC __PMDEFINITIONS__ := 1}

{$I+}
{$SETC PMDefinitionsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Printing objects }

TYPE
	PMObject							= Ptr;
	PMDialog    = ^LONGINT; { an opaque 32-bit type }
	PMDialogPtr = ^PMDialog;  { when a VAR xx:PMDialog parameter can be nil, it is changed to xx: PMDialogPtr }
	PMPrintSettings    = ^LONGINT; { an opaque 32-bit type }
	PMPrintSettingsPtr = ^PMPrintSettings;  { when a VAR xx:PMPrintSettings parameter can be nil, it is changed to xx: PMPrintSettingsPtr }
	PMPageFormat    = ^LONGINT; { an opaque 32-bit type }
	PMPageFormatPtr = ^PMPageFormat;  { when a VAR xx:PMPageFormat parameter can be nil, it is changed to xx: PMPageFormatPtr }
	PMPrintContext    = ^LONGINT; { an opaque 32-bit type }
	PMPrintContextPtr = ^PMPrintContext;  { when a VAR xx:PMPrintContext parameter can be nil, it is changed to xx: PMPrintContextPtr }
	PMPrintSession    = ^LONGINT; { an opaque 32-bit type }
	PMPrintSessionPtr = ^PMPrintSession;  { when a VAR xx:PMPrintSession parameter can be nil, it is changed to xx: PMPrintSessionPtr }
	PMPrinter    = ^LONGINT; { an opaque 32-bit type }
	PMPrinterPtr = ^PMPrinter;  { when a VAR xx:PMPrinter parameter can be nil, it is changed to xx: PMPrinterPtr }

CONST
	kPMCancel					= $0080;						{  user hit cancel button in dialog  }

{$IFC NOT UNDEFINED MWERKS}
	{	 for parameters which take a PrintSettings reference 	}
{$IFC NOT UNDEFINED MWERKS}
	kPMNoPrintSettings			= nil;
{$ENDC}
	{	 for parameters which take a PageFormat reference 	}
{$IFC NOT UNDEFINED MWERKS}
	kPMNoPageFormat				= nil;
{$ENDC}
{$ENDC}


TYPE
	PMDestinationType 			= UInt16;
CONST
	kPMDestinationPrinter		= 1;
	kPMDestinationFile			= 2;
	kPMDestinationFax			= 3;


TYPE
	PMTag 						= UInt32;
CONST
																{  common tags  }
	kPMCurrentValue				= 'curr';						{  current setting or value  }
	kPMDefaultValue				= 'dflt';						{  default setting or value  }
	kPMMinimumValue				= 'minv';						{  the minimum setting or value  }
	kPMMaximumValue				= 'maxv';						{  the maximum setting or value  }
																{  profile tags  }
	kPMSourceProfile			= 'srcp';						{  source profile  }
																{  resolution tags  }
	kPMMinRange					= 'mnrg';						{  Min range supported by a printer  }
	kPMMaxRange					= 'mxrg';						{  Max range supported by a printer  }
	kPMMinSquareResolution		= 'mins';						{  Min with X and Y resolution equal  }
	kPMMaxSquareResolution		= 'maxs';						{  Max with X and Y resolution equal  }
	kPMDefaultResolution		= 'dftr';						{  printer default resolution  }



TYPE
	PMOrientation 				= UInt16;
CONST
	kPMPortrait					= 1;
	kPMLandscape				= 2;
	kPMReversePortrait			= 3;							{  will revert to kPortrait for current drivers  }
	kPMReverseLandscape			= 4;							{  will revert to kLandscape for current drivers  }

	kSizeOfTPrint				= 120;							{  size of old TPrint record  }


TYPE
	PMColorMode 				= UInt16;
CONST
	kPMBlackAndWhite			= 1;
	kPMGray						= 2;
	kPMColor					= 3;
	kPMColorModeDuotone			= 4;							{  2 channels  }
	kPMColorModeSpecialColor	= 5;							{  to allow for special colors such as metalic, light cyan, etc.  }

	{	 Constants to define the ColorSync Intents. These intents may be used 	}
	{	 to set an intent part way through a page or for an entire document. 	}

TYPE
	PMColorSyncIntent 			= UInt32;
CONST
	kPMColorIntentUndefined		= $0000;						{  User or application have not declared an intent, use the printer's default.  }
	kPMColorIntentAutomatic		= $0001;						{  Automatically match for photos and graphics anywhere on the page.  }
	kPMColorIntentPhoto			= $0002;						{  Use Photographic (cmPerceptual) intent for all contents.  }
	kPMColorIntentBusiness		= $0004;						{  Use Business Graphics (cmSaturation) intent for all contents.  }
	kPMColorIntentRelColor		= $0008;						{  Use Relative Colormetrics (Logo Colors) for the page.  }
	kPMColorIntentAbsColor		= $0010;						{  Use absolute colormetric for the page.  }
	kPMColorIntentUnused		= $FFE0;						{  Remaining bits unused at this time.  }

	{	 Print quality modes "standard options" 	}

TYPE
	PMQualityMode 				= UInt32;
CONST
	kPMQualityLowest			= $0000;						{  Absolute lowest print quality  }
	kPMQualityInkSaver			= $0001;						{  Saves ink but may be slower  }
	kPMQualityDraft				= $0004;						{  Print at highest speed, ink used is secondary consideration  }
	kPMQualityNormal			= $0008;						{  Print in printers "general usage" mode for good balance between quality and speed  }
	kPMQualityPhoto				= $000B;						{  Optimize quality of photos on the page. Speed is not a concern  }
	kPMQualityBest				= $000D;						{  Get best quality output for all objects and photos.  }
	kPMQualityHighest			= $000F;						{  Absolute highest quality attained from a printers  }


	{	 Constants for our "standard" paper types 	}

TYPE
	PMPaperType 				= UInt32;
CONST
	kPMPaperTypeUnknown			= $0000;						{  Not sure yet what paper type we have.  }
	kPMPaperTypePlain			= $0001;						{  Plain paper  }
	kPMPaperTypeCoated			= $0002;						{  Has a special coating for sharper images and text  }
	kPMPaperTypePremium			= $0003;						{  Special premium coated paper  }
	kPMPaperTypeGlossy			= $0004;						{  High gloss special coating  }
	kPMPaperTypeTransparency	= $0005;						{  Used for overheads  }
	kPMPaperTypeTShirt			= $0006;						{  Used to iron on t-shirts  }

	{	 Scaling alignment: 	}

TYPE
	PMScalingAlignment 			= UInt16;
CONST
	kPMScalingPinTopLeft		= 1;
	kPMScalingPinTopRight		= 2;
	kPMScalingPinBottomLeft		= 3;
	kPMScalingPinBottomRight	= 4;
	kPMScalingCenterOnPaper		= 5;
	kPMScalingCenterOnImgArea	= 6;

	{	 Duplex binding directions: 	}

TYPE
	PMDuplexBinding 			= UInt16;
CONST
	kPMDuplexBindingLeftRight	= 1;
	kPMDuplexBindingTopDown		= 2;

	{	 Layout directions: 	}

TYPE
	PMLayoutDirection 			= UInt16;
CONST
																{  Horizontal-major directions:  }
	kPMLayoutLeftRightTopBottom	= 1;							{  English reading direction.  }
	kPMLayoutLeftRightBottomTop	= 2;
	kPMLayoutRightLeftTopBottom	= 3;
	kPMLayoutRightLeftBottomTop	= 4;							{  Vertical-major directions:  }
	kPMLayoutTopBottomLeftRight	= 5;
	kPMLayoutTopBottomRightLeft	= 6;
	kPMLayoutBottomTopLeftRight	= 7;
	kPMLayoutBottomTopRightLeft	= 8;

	{	 Page borders: 	}

TYPE
	PMBorderType 				= UInt16;
CONST
	kPMBorderSingleHairline		= 1;
	kPMBorderDoubleHairline		= 2;
	kPMBorderSingleThickline	= 3;
	kPMBorderDoubleThickline	= 4;

	{	 Useful Constants for PostScript Injection 	}
	kPSPageInjectAllPages		= -1;							{  specifies to inject on all pages  }
	kPSInjectionMaxDictSize		= 5;							{  maximum size of a dictionary used for PSInjection  }

	{	 PostScript Injection values for kPSInjectionPlacementKey 	}

TYPE
	PSInjectionPlacement 		= UInt16;
CONST
	kPSInjectionBeforeSubsection = 1;
	kPSInjectionAfterSubsection	= 2;
	kPSInjectionReplaceSubsection = 3;

	{	 PostScript Injection values for kPSInjectionSectionKey 	}

TYPE
	PSInjectionSection 			= SInt32;
CONST
																{  Job  }
	kInjectionSectJob			= 1;							{  CoverPage  }
	kInjectionSectCoverPage		= 2;

	{	 PostScript Injection values for kPSInjectionSubSectionKey 	}

TYPE
	PSInjectionSubsection 		= SInt32;
CONST
	kInjectionSubPSAdobe		= 1;							{  %!PS-Adobe            }
	kInjectionSubPSAdobeEPS		= 2;							{  %!PS-Adobe-3.0 EPSF-3.0     }
	kInjectionSubBoundingBox	= 3;							{  BoundingBox           }
	kInjectionSubEndComments	= 4;							{  EndComments           }
	kInjectionSubOrientation	= 5;							{  Orientation           }
	kInjectionSubPages			= 6;							{  Pages             }
	kInjectionSubPageOrder		= 7;							{  PageOrder           }
	kInjectionSubBeginProlog	= 8;							{  BeginProlog           }
	kInjectionSubEndProlog		= 9;							{  EndProlog           }
	kInjectionSubBeginSetup		= 10;							{  BeginSetup           }
	kInjectionSubEndSetup		= 11;							{  EndSetup              }
	kInjectionSubBeginDefaults	= 12;							{  BeginDefaults        }
	kInjectionSubEndDefaults	= 13;							{  EndDefaults           }
	kInjectionSubDocFonts		= 14;							{  DocumentFonts        }
	kInjectionSubDocNeededFonts	= 15;							{  DocumentNeededFonts        }
	kInjectionSubDocSuppliedFonts = 16;							{  DocumentSuppliedFonts   }
	kInjectionSubDocNeededRes	= 17;							{  DocumentNeededResources     }
	kInjectionSubDocSuppliedRes	= 18;							{  DocumentSuppliedResources }
	kInjectionSubDocCustomColors = 19;							{  DocumentCustomColors      }
	kInjectionSubDocProcessColors = 20;							{  DocumentProcessColors   }
	kInjectionSubPlateColor		= 21;							{  PlateColor           }
	kInjectionSubPageTrailer	= 22;							{  PageTrailer            }
	kInjectionSubTrailer		= 23;							{  Trailer               }
	kInjectionSubEOF			= 24;							{  EOF                  }
	kInjectionSubBeginFont		= 25;							{  BeginFont           }
	kInjectionSubEndFont		= 26;							{  EndFont               }
	kInjectionSubBeginResource	= 27;							{  BeginResource        }
	kInjectionSubEndResource	= 28;							{  EndResource           }
	kInjectionSubPage			= 29;							{  Page                }
	kInjectionSubBeginPageSetup	= 30;							{  BeginPageSetup         }
	kInjectionSubEndPageSetup	= 31;							{  EndPageSetup           }


	{	 Description types 	}
	{ kPMPPDDescriptionType = CFSTR("PMPPDDescriptionType"); }
	{	 Document format strings 	}
	{ kPMDocumentFormatDefault = CFSTR("com.apple.documentformat.default"); }
	{ kPMDocumentFormatPDF = CFSTR("application/pdf"); }
	{ kPMDocumentFormatPICT = CFSTR("application/vnd.apple.printing-pict"); }
	{ kPMDocumentFormatPICTPS = CFSTR("application/vnd.apple.printing-pict-ps"); }
	{ kPMDocumentFormatPostScript = CFSTR("application/postscript"); }
	{	 Graphic context strings 	}
	{ kPMGraphicsContextDefault = CFSTR("com.apple.graphicscontext.default"); }
	{ kPMGraphicsContextQuickdraw = CFSTR("com.apple.graphicscontext.quickdraw"); }
	{ kPMGraphicsContextCoreGraphics = CFSTR("com.apple.graphicscontext.coregraphics"); }
	{	 Data format strings 	}
	{ kPMDataFormatPS = CFSTR(kPMDocumentFormatPostScript); }
	{ kPMDataFormatPDF = CFSTR(kPMDocumentFormatPDF); }
	{ kPMDataFormatPICT = CFSTR(kPMDocumentFormatPICT); }
	{ kPMDataFormatPICTwPS = CFSTR(kPMDocumentFormatPICTPS); }
	{	 PostScript Injection Dictionary Keys 	}
	{ kPSInjectionSectionKey = CFSTR("section"); }
	{ kPSInjectionSubSectionKey = CFSTR("subsection"); }
	{ kPSInjectionPageKey = CFSTR("page"); }
	{ kPSInjectionPlacementKey = CFSTR("place"); }
	{ kPSInjectionPostScriptKey = CFSTR("psdata"); }
	{	 OSStatus return codes 	}
	kPMNoError					= 0;
	kPMGeneralError				= -30870;
	kPMOutOfScope				= -30871;						{  an API call is out of scope  }
	kPMInvalidParameter			= -50;							{  a required parameter is missing or invalid  }
	kPMNoDefaultPrinter			= -30872;						{  no default printer selected  }
	kPMNotImplemented			= -30873;						{  this API call is not supported  }
	kPMNoSuchEntry				= -30874;						{  no such entry  }
	kPMInvalidPrintSettings		= -30875;						{  the printsettings reference is invalid  }
	kPMInvalidPageFormat		= -30876;						{  the pageformat reference is invalid  }
	kPMValueOutOfRange			= -30877;						{  a value passed in is out of range  }
	kPMLockIgnored				= -30878;						{  the lock value was ignored  }

	kPMInvalidPrintSession		= -30879;						{  the print session is invalid  }
	kPMInvalidPrinter			= -30880;						{  the printer reference is invalid  }
	kPMObjectInUse				= -30881;						{  the object is in use  }


	kPMPrintAllPages			= -1;


TYPE
	PMRectPtr = ^PMRect;
	PMRect = RECORD
		top:					Double;
		left:					Double;
		bottom:					Double;
		right:					Double;
	END;

	PMResolutionPtr = ^PMResolution;
	PMResolution = RECORD
		hRes:					Double;
		vRes:					Double;
	END;

	PMLanguageInfoPtr = ^PMLanguageInfo;
	PMLanguageInfo = RECORD
		level:					Str32;
		version:				Str32;
		release:				Str32;
	END;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PMDefinitionsIncludes}

{$ENDC} {__PMDEFINITIONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
