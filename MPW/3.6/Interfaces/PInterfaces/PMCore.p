{
     File:       PMCore.p
 
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
 UNIT PMCore;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PMCORE__}
{$SETC __PMCORE__ := 1}

{$I+}
{$SETC PMCoreIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __CMAPPLICATION__}
{$I CMApplication.p}
{$ENDC}
{$IFC UNDEFINED __PMDEFINITIONS__}
{$I PMDefinitions.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}
{$IFC UNDEFINED __CFURL__}
{$I CFURL.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$IFC UNDEFINED PM_USE_SESSION_APIS }
{$SETC PM_USE_SESSION_APIS := 1 }
{$ENDC}

{ Callbacks }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PMIdleProcPtr = PROCEDURE;
{$ELSEC}
	PMIdleProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	PMIdleUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PMIdleUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppPMIdleProcInfo = $00000000;
	{
	 *  NewPMIdleUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewPMIdleUPP(userRoutine: PMIdleProcPtr): PMIdleUPP;
{
 *  DisposePMIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposePMIdleUPP(userUPP: PMIdleUPP);
{
 *  InvokePMIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokePMIdleUPP(userRoutine: PMIdleUPP);
{$IFC PM_USE_SESSION_APIS }
{ Session routines }
{ Session support }
{
 *  PMRetain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMRetain(object: PMObject): OSStatus;

{
 *  PMRelease()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMRelease(object: PMObject): OSStatus;

{ Session Print loop }
{**********************}
{ A session is created with a refcount of 1. }
{**********************}
{
 *  PMCreateSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMCreateSession(VAR printSession: PMPrintSession): OSStatus;

{ Session PMPageFormat }
{**********************}
{ A pageformat is created with a refcount of 1. }
{**********************}
{
 *  PMCreatePageFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMCreatePageFormat(VAR pageFormat: PMPageFormat): OSStatus;

{
 *  PMSessionDefaultPageFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionDefaultPageFormat(printSession: PMPrintSession; pageFormat: PMPageFormat): OSStatus;

{
 *  PMSessionValidatePageFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionValidatePageFormat(printSession: PMPrintSession; pageFormat: PMPageFormat; VAR result: BOOLEAN): OSStatus;

{ Session PMPrintSettings }
{**********************}
{ A printSettings is created with a refcount of 1. }
{**********************}
{
 *  PMCreatePrintSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMCreatePrintSettings(VAR printSettings: PMPrintSettings): OSStatus;

{
 *  PMSessionDefaultPrintSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionDefaultPrintSettings(printSession: PMPrintSession; printSettings: PMPrintSettings): OSStatus;

{
 *  PMSessionValidatePrintSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionValidatePrintSettings(printSession: PMPrintSession; printSettings: PMPrintSettings; VAR result: BOOLEAN): OSStatus;

{
 *  PMGetJobNameCFString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetJobNameCFString(printSettings: PMPrintSettings; VAR name: CFStringRef): OSStatus;

{
 *  PMSetJobNameCFString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSetJobNameCFString(printSettings: PMPrintSettings; name: CFStringRef): OSStatus;

{ Session Classic support }
{
 *  PMSessionGeneral()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionGeneral(printSession: PMPrintSession; pData: Ptr): OSStatus;

{
 *  PMSessionConvertOldPrintRecord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionConvertOldPrintRecord(printSession: PMPrintSession; printRecordHandle: Handle; VAR printSettings: PMPrintSettings; VAR pageFormat: PMPageFormat): OSStatus;

{
 *  PMSessionMakeOldPrintRecord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionMakeOldPrintRecord(printSession: PMPrintSession; printSettings: PMPrintSettings; pageFormat: PMPageFormat; VAR printRecordHandle: Handle): OSStatus;

{ Session Driver Information }
{
 *  PMPrinterGetDescriptionURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMPrinterGetDescriptionURL(printer: PMPrinter; descriptionType: CFStringRef; VAR fileURL: CFURLRef): OSStatus;

{
 *  PMSessionGetCurrentPrinter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionGetCurrentPrinter(printSession: PMPrintSession; VAR currentPrinter: PMPrinter): OSStatus;

{
 *  PMPrinterGetLanguageInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMPrinterGetLanguageInfo(printer: PMPrinter; VAR info: PMLanguageInfo): OSStatus;

{
 *  PMPrinterGetDriverCreator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMPrinterGetDriverCreator(printer: PMPrinter; VAR creator: OSType): OSStatus;

{
 *  PMPrinterGetDriverReleaseInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMPrinterGetDriverReleaseInfo(printer: PMPrinter; VAR release: VersRec): OSStatus;

{
 *  PMPrinterGetPrinterResolutionCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMPrinterGetPrinterResolutionCount(printer: PMPrinter; VAR count: UInt32): OSStatus;

{
 *  PMPrinterGetPrinterResolution()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMPrinterGetPrinterResolution(printer: PMPrinter; tag: PMTag; VAR res: PMResolution): OSStatus;

{
 *  PMPrinterGetIndexedPrinterResolution()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMPrinterGetIndexedPrinterResolution(printer: PMPrinter; index: UInt32; VAR res: PMResolution): OSStatus;

{ Session ColorSync & PostScript Support }
{
 *  PMSessionEnableColorSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionEnableColorSync(printSession: PMPrintSession): OSStatus;

{
 *  PMSessionDisableColorSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionDisableColorSync(printSession: PMPrintSession): OSStatus;

{
 *  PMSessionPostScriptBegin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionPostScriptBegin(printSession: PMPrintSession): OSStatus;

{
 *  PMSessionPostScriptEnd()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionPostScriptEnd(printSession: PMPrintSession): OSStatus;

{
 *  PMSessionPostScriptHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionPostScriptHandle(printSession: PMPrintSession; psHandle: Handle): OSStatus;

{
 *  PMSessionPostScriptData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionPostScriptData(printSession: PMPrintSession; psPtr: Ptr; len: Size): OSStatus;

{
 *  PMSessionPostScriptFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionPostScriptFile(printSession: PMPrintSession; VAR psFile: FSSpec): OSStatus;

{
 *  PMSessionSetPSInjectionData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionSetPSInjectionData(printSession: PMPrintSession; printSettings: PMPrintSettings; injectionDictArray: CFArrayRef): OSStatus;

{ Session Error }
{
 *  PMSessionError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionError(printSession: PMPrintSession): OSStatus;

{
 *  PMSessionSetError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionSetError(printSession: PMPrintSession; printError: OSStatus): OSStatus;

{ Other Session routines }
{
 *  PMSessionGetDocumentFormatGeneration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionGetDocumentFormatGeneration(printSession: PMPrintSession; VAR docFormats: CFArrayRef): OSStatus;

{
 *  PMSessionSetDocumentFormatGeneration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionSetDocumentFormatGeneration(printSession: PMPrintSession; docFormat: CFStringRef; graphicsContextTypes: CFArrayRef; options: CFTypeRef): OSStatus;

{
 *  PMSessionGetDocumentFormatSupported()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionGetDocumentFormatSupported(printSession: PMPrintSession; VAR docFormats: CFArrayRef; limit: UInt32): OSStatus;

{
 *  PMSessionIsDocumentFormatSupported()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionIsDocumentFormatSupported(printSession: PMPrintSession; docFormat: CFStringRef; VAR supported: BOOLEAN): OSStatus;

{
 *  PMSessionGetGraphicsContext()
 *  
 *  Parameters:
 *    
 *    printSession:
 *      the session
 *    
 *    graphicsContextType:
 *      either kPMGraphicsContextQuickdraw or
 *      kPMGraphicsContextCoreGraphics
 *    
 *    graphicsContext:
 *      returns a GrafPtr or a CGContextRef
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionGetGraphicsContext(printSession: PMPrintSession; graphicsContextType: CFStringRef; VAR graphicsContext: UNIV Ptr): OSStatus;

{
 *  PMSessionSetIdleProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionSetIdleProc(printSession: PMPrintSession; idleProc: PMIdleUPP): OSStatus;

{
 *  PMSessionSetDataInSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionSetDataInSession(printSession: PMPrintSession; key: CFStringRef; data: CFTypeRef): OSStatus;

{
 *  PMSessionGetDataFromSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionGetDataFromSession(printSession: PMPrintSession; key: CFStringRef; VAR data: CFTypeRef): OSStatus;

{$ELSEC}
{
 *  PMSetIdleProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSetIdleProc(idleProc: PMIdleUPP): OSStatus;

{ Print loop }
{
 *  PMBegin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMBegin: OSStatus;

{
 *  PMEnd()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMEnd: OSStatus;

{**********************}
{  Valid only within a PMBeginPage/PMEndPage block. You should retrieve the printing }
{  port with this call and set it before imaging a page. }
{**********************}
{
 *  PMGetGrafPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetGrafPtr(printContext: PMPrintContext; VAR grafPort: GrafPtr): OSStatus;

{ PMPageFormat }
{
 *  PMNewPageFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMNewPageFormat(VAR pageFormat: PMPageFormat): OSStatus;

{
 *  PMDisposePageFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMDisposePageFormat(pageFormat: PMPageFormat): OSStatus;

{
 *  PMDefaultPageFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMDefaultPageFormat(pageFormat: PMPageFormat): OSStatus;

{
 *  PMValidatePageFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMValidatePageFormat(pageFormat: PMPageFormat; VAR result: BOOLEAN): OSStatus;

{ PMPrintSettings }
{
 *  PMNewPrintSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMNewPrintSettings(VAR printSettings: PMPrintSettings): OSStatus;

{
 *  PMDisposePrintSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMDisposePrintSettings(printSettings: PMPrintSettings): OSStatus;

{
 *  PMDefaultPrintSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMDefaultPrintSettings(printSettings: PMPrintSettings): OSStatus;

{
 *  PMValidatePrintSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMValidatePrintSettings(printSettings: PMPrintSettings; VAR result: BOOLEAN): OSStatus;

{ Classic Support }
{
 *  PMGeneral()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGeneral(pData: Ptr): OSStatus;

{
 *  PMConvertOldPrintRecord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMConvertOldPrintRecord(printRecordHandle: Handle; VAR printSettings: PMPrintSettings; VAR pageFormat: PMPageFormat): OSStatus;

{
 *  PMMakeOldPrintRecord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMMakeOldPrintRecord(printSettings: PMPrintSettings; pageFormat: PMPageFormat; VAR printRecordHandle: Handle): OSStatus;

{ Driver Information }
{
 *  PMIsPostScriptDriver()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMIsPostScriptDriver(VAR isPostScript: BOOLEAN): OSStatus;

{
 *  PMGetLanguageInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetLanguageInfo(VAR info: PMLanguageInfo): OSStatus;

{
 *  PMGetDriverCreator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetDriverCreator(VAR creator: OSType): OSStatus;

{
 *  PMGetDriverReleaseInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetDriverReleaseInfo(VAR release: VersRec): OSStatus;

{
 *  PMGetPrinterResolutionCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetPrinterResolutionCount(VAR count: UInt32): OSStatus;

{
 *  PMGetPrinterResolution()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetPrinterResolution(tag: PMTag; VAR res: PMResolution): OSStatus;

{
 *  PMGetIndexedPrinterResolution()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetIndexedPrinterResolution(index: UInt32; VAR res: PMResolution): OSStatus;

{**********************}
{  PMEnableColorSync and PMDisableColorSync are valid within }
{  BeginPage/EndPage block }
{**********************}
{ ColorSync & PostScript Support }
{
 *  PMEnableColorSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMEnableColorSync: OSStatus;

{
 *  PMDisableColorSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMDisableColorSync: OSStatus;

{**********************}
{  The PMPostScriptxxx calls are valid within a }
{  BeginPage/EndPage block }
{**********************}
{
 *  PMPostScriptBegin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMPostScriptBegin: OSStatus;

{
 *  PMPostScriptEnd()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMPostScriptEnd: OSStatus;

{**********************}
{  These PMPostScriptxxx calls are valid within a }
{  PMPostScriptBegin/PMPostScriptEnd block }
{**********************}
{
 *  PMPostScriptHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMPostScriptHandle(psHandle: Handle): OSStatus;

{
 *  PMPostScriptData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMPostScriptData(psPtr: Ptr; len: Size): OSStatus;

{
 *  PMPostScriptFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMPostScriptFile(VAR psFile: FSSpec): OSStatus;

{ Error }
{
 *  PMError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMError: OSStatus;

{
 *  PMSetError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSetError(printError: OSStatus): OSStatus;

{$ENDC}  {PM_USE_SESSION_APIS}

{ PMPageFormat }
{
 *  PMCopyPageFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMCopyPageFormat(formatSrc: PMPageFormat; formatDest: PMPageFormat): OSStatus;

{**********************}
{  Flattening a page format should only be necessary if you intend to preserve }
{  the object settings along with a document. A page format will persist outside of a }
{  PMBegin/PMEnd block. This will allow you to use any accessors on the object without }
{  the need to flatten and unflatten. Keep in mind accessors make no assumption }
{  on the validity of the value you set. This can only be done thru PMValidatePageFormat }
{  in a PMBegin/PMEnd block or with PMSessionValidatePageFormat with a valid session. }
{  It is your responsibility for disposing of the handle. }
{**********************}
{
 *  PMFlattenPageFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMFlattenPageFormat(pageFormat: PMPageFormat; VAR flatFormat: Handle): OSStatus;

{
 *  PMUnflattenPageFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMUnflattenPageFormat(flatFormat: Handle; VAR pageFormat: PMPageFormat): OSStatus;

{ PMPageFormat Accessors }
{**********************}
{ PMSetxxx calls only saves the value inside the printing object. They make no assumption on the }
{ validity of the value. This should be done using PMValidatePageFormat/PMSessionValidatePageFormat }
{ Any dependant settings are also updated during a validate call. }
{ For example: }
{ PMGetAdjustedPaperRect - returns a rect of a certain size }
{ PMSetScale( aPageFormat, 500.0 )  }
{ PMGetAdjustedPaperRect - returns the SAME rect as the first call  }
{}
{ PMGetAdjustedPaperRect - returns a rect of a certain size }
{ PMSetScale( aPageFormat, 500.0 ) }
{ PMValidatePageFormat or PMSessionValidatePageFormat }
{ PMGetAdjustedPaperRect - returns a rect thats scaled 500% from the first call }
{**********************}
{
 *  PMGetPageFormatExtendedData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetPageFormatExtendedData(pageFormat: PMPageFormat; dataID: OSType; VAR size: UInt32; extendedData: UNIV Ptr): OSStatus;

{
 *  PMSetPageFormatExtendedData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSetPageFormatExtendedData(pageFormat: PMPageFormat; dataID: OSType; size: UInt32; extendedData: UNIV Ptr): OSStatus;

{**********************}
{  A value of 100.0 means 100% (no scaling). 50.0 means 50% scaling }
{**********************}
{
 *  PMGetScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetScale(pageFormat: PMPageFormat; VAR scale: Double): OSStatus;

{
 *  PMSetScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSetScale(pageFormat: PMPageFormat; scale: Double): OSStatus;

{**********************}
{  This is the drawing resolution of an app. This should not be confused with }
{  the resolution of the printer. You can call PMGetPrinterResolution to see }
{  what resolutions are avaliable for the current printer. }
{**********************}
{
 *  PMGetResolution()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetResolution(pageFormat: PMPageFormat; VAR res: PMResolution): OSStatus;

{
 *  PMSetResolution()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSetResolution(pageFormat: PMPageFormat; {CONST}VAR res: PMResolution): OSStatus;

{**********************}
{  This is the physical size of the paper without regard to resolution, orientation }
{  or scaling. It is returned as a 72dpi value. }
{**********************}
{
 *  PMGetPhysicalPaperSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetPhysicalPaperSize(pageFormat: PMPageFormat; VAR paperSize: PMRect): OSStatus;

{
 *  PMSetPhysicalPaperSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSetPhysicalPaperSize(pageFormat: PMPageFormat; {CONST}VAR paperSize: PMRect): OSStatus;

{**********************}
{  This is the physical size of the page without regard to resolution, orientation }
{  or scaling. It is returned as a 72dpi value. }
{**********************}
{
 *  PMGetPhysicalPageSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetPhysicalPageSize(pageFormat: PMPageFormat; VAR pageSize: PMRect): OSStatus;

{
 *  PMGetAdjustedPaperRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetAdjustedPaperRect(pageFormat: PMPageFormat; VAR paperRect: PMRect): OSStatus;

{
 *  PMGetAdjustedPageRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetAdjustedPageRect(pageFormat: PMPageFormat; VAR pageRect: PMRect): OSStatus;

{
 *  PMGetUnadjustedPaperRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetUnadjustedPaperRect(pageFormat: PMPageFormat; VAR paperRect: PMRect): OSStatus;

{
 *  PMSetUnadjustedPaperRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSetUnadjustedPaperRect(pageFormat: PMPageFormat; {CONST}VAR paperRect: PMRect): OSStatus;

{
 *  PMGetUnadjustedPageRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetUnadjustedPageRect(pageFormat: PMPageFormat; VAR pageRect: PMRect): OSStatus;

{
 *  PMSetAdjustedPageRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSetAdjustedPageRect(pageFormat: PMPageFormat; {CONST}VAR pageRect: PMRect): OSStatus;

{
 *  PMGetOrientation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetOrientation(pageFormat: PMPageFormat; VAR orientation: PMOrientation): OSStatus;

{
 *  PMSetOrientation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSetOrientation(pageFormat: PMPageFormat; orientation: PMOrientation; lock: BOOLEAN): OSStatus;

{ PMPrintSettings }
{
 *  PMCopyPrintSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMCopyPrintSettings(settingSrc: PMPrintSettings; settingDest: PMPrintSettings): OSStatus;

{**********************}
{  Flattening a print settings should only be necessary if you intend to preserve }
{  the object settings along with a document. A print settings will persist outside of a }
{  PMBegin/PMEnd block. This allows you to use any accessors on the object without }
{  the need to flatten and unflatten. Keep in mind the accessors make no assumption }
{  on the validity of the value. This can only be done thru PMValidatePrintSettings }
{  in a PMBegin/PMEnd block or with PMSessionValidatePrintSettings with a valid session. }
{  It is your responsibility for disposing of the handle. }
{**********************}
{
 *  PMFlattenPrintSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMFlattenPrintSettings(printSettings: PMPrintSettings; VAR flatSettings: Handle): OSStatus;

{
 *  PMUnflattenPrintSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMUnflattenPrintSettings(flatSettings: Handle; VAR printSettings: PMPrintSettings): OSStatus;

{ PMPrintSettings Accessors }
{
 *  PMGetPrintSettingsExtendedData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetPrintSettingsExtendedData(printSettings: PMPrintSettings; dataID: OSType; VAR size: UInt32; extendedData: UNIV Ptr): OSStatus;

{
 *  PMSetPrintSettingsExtendedData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSetPrintSettingsExtendedData(printSettings: PMPrintSettings; dataID: OSType; size: UInt32; extendedData: UNIV Ptr): OSStatus;

{
 *  PMGetDestination()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetDestination(printSettings: PMPrintSettings; VAR destType: PMDestinationType; VAR fileURL: CFURLRef): OSStatus;

{
 *  PMGetJobName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetJobName(printSettings: PMPrintSettings; name: StringPtr): OSStatus;

{
 *  PMSetJobName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSetJobName(printSettings: PMPrintSettings; name: StringPtr): OSStatus;

{
 *  PMGetCopies()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetCopies(printSettings: PMPrintSettings; VAR copies: UInt32): OSStatus;

{
 *  PMSetCopies()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSetCopies(printSettings: PMPrintSettings; copies: UInt32; lock: BOOLEAN): OSStatus;

{
 *  PMGetFirstPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetFirstPage(printSettings: PMPrintSettings; VAR first: UInt32): OSStatus;

{
 *  PMSetFirstPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSetFirstPage(printSettings: PMPrintSettings; first: UInt32; lock: BOOLEAN): OSStatus;

{
 *  PMGetLastPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetLastPage(printSettings: PMPrintSettings; VAR last: UInt32): OSStatus;

{
 *  PMSetLastPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSetLastPage(printSettings: PMPrintSettings; last: UInt32; lock: BOOLEAN): OSStatus;

{**********************}
{  The default page range is from 1-32000. The page range is something that is }
{  set by the application. It is NOT the first and last page to print. It serves }
{  as limits for setting the first and last page. You may pass kPMPrintAllPages for }
{  the maxPage value to specified that all pages are available for printing. }
{**********************}
{
 *  PMGetPageRange()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetPageRange(printSettings: PMPrintSettings; VAR minPage: UInt32; VAR maxPage: UInt32): OSStatus;

{**********************}
{ The first and last page are immediately clipped to the new range }
{**********************}
{
 *  PMSetPageRange()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSetPageRange(printSettings: PMPrintSettings; minPage: UInt32; maxPage: UInt32): OSStatus;

{
 *  PMSetProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSetProfile(printSettings: PMPrintSettings; tag: PMTag; {CONST}VAR profile: CMProfileLocation): OSStatus;

{
 *  PMGetColorMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetColorMode(printSettings: PMPrintSettings; VAR colorMode: PMColorMode): OSStatus;

{
 *  PMSetColorMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSetColorMode(printSettings: PMPrintSettings; colorMode: PMColorMode): OSStatus;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PMCoreIncludes}

{$ENDC} {__PMCORE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
