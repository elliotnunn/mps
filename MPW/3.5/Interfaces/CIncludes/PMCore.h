/*
     File:       PMCore.h
 
     Contains:   Carbon Printing Manager Interfaces.
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1998-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __PMCORE__
#define __PMCORE__

#ifndef __MACERRORS__
#include <MacErrors.h>
#endif

#ifndef __FILES__
#include <Files.h>
#endif

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#ifndef __CMAPPLICATION__
#include <CMApplication.h>
#endif

#ifndef __PMDEFINITIONS__
#include <PMDefinitions.h>
#endif

#ifndef __CFSTRING__
#include <CFString.h>
#endif

#ifndef __CFURL__
#include <CFURL.h>
#endif



#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
    #pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
    #pragma pack(2)
#endif

#ifndef PM_USE_SESSION_APIS
#define PM_USE_SESSION_APIS 1
#endif  /* !defined(PM_USE_SESSION_APIS) */

/* Callbacks */
typedef CALLBACK_API( void , PMIdleProcPtr )(void);
typedef STACK_UPP_TYPE(PMIdleProcPtr)                           PMIdleUPP;
/*
 *  NewPMIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( PMIdleUPP )
NewPMIdleUPP(PMIdleProcPtr userRoutine);

/*
 *  DisposePMIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposePMIdleUPP(PMIdleUPP userUPP);

/*
 *  InvokePMIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
InvokePMIdleUPP(PMIdleUPP userUPP);

#if PM_USE_SESSION_APIS
/* Session routines */
/* Session support */
/*
 *  PMRetain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMRetain(PMObject object);


/*
 *  PMRelease()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMRelease(PMObject object);


/* Session Print loop */
/************************/
/* A session is created with a refcount of 1. */
/************************/
/*
 *  PMCreateSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMCreateSession(PMPrintSession * printSession);


/* Session PMPageFormat */
/************************/
/* A pageformat is created with a refcount of 1. */
/************************/
/*
 *  PMCreatePageFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMCreatePageFormat(PMPageFormat * pageFormat);


/*
 *  PMSessionDefaultPageFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionDefaultPageFormat(
  PMPrintSession   printSession,
  PMPageFormat     pageFormat);


/*
 *  PMSessionValidatePageFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionValidatePageFormat(
  PMPrintSession   printSession,
  PMPageFormat     pageFormat,
  Boolean *        result);


/* Session PMPrintSettings */
/************************/
/* A printSettings is created with a refcount of 1. */
/************************/
/*
 *  PMCreatePrintSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMCreatePrintSettings(PMPrintSettings * printSettings);


/*
 *  PMSessionDefaultPrintSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionDefaultPrintSettings(
  PMPrintSession    printSession,
  PMPrintSettings   printSettings);


/*
 *  PMSessionValidatePrintSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionValidatePrintSettings(
  PMPrintSession    printSession,
  PMPrintSettings   printSettings,
  Boolean *         result);


/*
 *  PMGetJobNameCFString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetJobNameCFString(
  PMPrintSettings   printSettings,
  CFStringRef *     name);


/*
 *  PMSetJobNameCFString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSetJobNameCFString(
  PMPrintSettings   printSettings,
  CFStringRef       name);


/* Session Classic support */
/*
 *  PMSessionGeneral()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionGeneral(
  PMPrintSession   printSession,
  Ptr              pData);


/*
 *  PMSessionConvertOldPrintRecord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionConvertOldPrintRecord(
  PMPrintSession     printSession,
  Handle             printRecordHandle,
  PMPrintSettings *  printSettings,
  PMPageFormat *     pageFormat);


/*
 *  PMSessionMakeOldPrintRecord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionMakeOldPrintRecord(
  PMPrintSession    printSession,
  PMPrintSettings   printSettings,
  PMPageFormat      pageFormat,
  Handle *          printRecordHandle);


/* Session Driver Information */
/*
 *  PMPrinterGetDescriptionURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMPrinterGetDescriptionURL(
  PMPrinter     printer,
  CFStringRef   descriptionType,
  CFURLRef *    fileURL);


/*
 *  PMSessionGetCurrentPrinter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionGetCurrentPrinter(
  PMPrintSession   printSession,
  PMPrinter *      currentPrinter);


/*
 *  PMPrinterGetLanguageInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMPrinterGetLanguageInfo(
  PMPrinter         printer,
  PMLanguageInfo *  info);


/*
 *  PMPrinterGetDriverCreator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMPrinterGetDriverCreator(
  PMPrinter   printer,
  OSType *    creator);


/*
 *  PMPrinterGetDriverReleaseInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMPrinterGetDriverReleaseInfo(
  PMPrinter   printer,
  VersRec *   release);


/*
 *  PMPrinterGetPrinterResolutionCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMPrinterGetPrinterResolutionCount(
  PMPrinter   printer,
  UInt32 *    count);


/*
 *  PMPrinterGetPrinterResolution()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMPrinterGetPrinterResolution(
  PMPrinter       printer,
  PMTag           tag,
  PMResolution *  res);


/*
 *  PMPrinterGetIndexedPrinterResolution()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMPrinterGetIndexedPrinterResolution(
  PMPrinter       printer,
  UInt32          index,
  PMResolution *  res);


/* Session ColorSync & PostScript Support */
/*
 *  PMSessionEnableColorSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionEnableColorSync(PMPrintSession printSession);


/*
 *  PMSessionDisableColorSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionDisableColorSync(PMPrintSession printSession);


/*
 *  PMSessionPostScriptBegin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionPostScriptBegin(PMPrintSession printSession);


/*
 *  PMSessionPostScriptEnd()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionPostScriptEnd(PMPrintSession printSession);


/*
 *  PMSessionPostScriptHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionPostScriptHandle(
  PMPrintSession   printSession,
  Handle           psHandle);


/*
 *  PMSessionPostScriptData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionPostScriptData(
  PMPrintSession   printSession,
  Ptr              psPtr,
  Size             len);


/*
 *  PMSessionPostScriptFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionPostScriptFile(
  PMPrintSession   printSession,
  FSSpec *         psFile);


/*
 *  PMSessionSetPSInjectionData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionSetPSInjectionData(
  PMPrintSession    printSession,
  PMPrintSettings   printSettings,
  CFArrayRef        injectionDictArray);


/* Session Error */
/*
 *  PMSessionError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionError(PMPrintSession printSession);


/*
 *  PMSessionSetError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionSetError(
  PMPrintSession   printSession,
  OSStatus         printError);


/* Other Session routines */
/*
 *  PMSessionGetDocumentFormatGeneration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionGetDocumentFormatGeneration(
  PMPrintSession   printSession,
  CFArrayRef *     docFormats);


/*
 *  PMSessionSetDocumentFormatGeneration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionSetDocumentFormatGeneration(
  PMPrintSession   printSession,
  CFStringRef      docFormat,
  CFArrayRef       graphicsContextTypes,
  CFTypeRef        options);


/*
 *  PMSessionGetDocumentFormatSupported()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionGetDocumentFormatSupported(
  PMPrintSession   printSession,
  CFArrayRef *     docFormats,
  UInt32           limit);


/*
 *  PMSessionIsDocumentFormatSupported()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionIsDocumentFormatSupported(
  PMPrintSession   printSession,
  CFStringRef      docFormat,
  Boolean *        supported);


/*
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
 */
EXTERN_API( OSStatus )
PMSessionGetGraphicsContext(
  PMPrintSession   printSession,
  CFStringRef      graphicsContextType,
  void **          graphicsContext);


/*
 *  PMSessionSetIdleProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionSetIdleProc(
  PMPrintSession   printSession,
  PMIdleUPP        idleProc);


/*
 *  PMSessionSetDataInSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionSetDataInSession(
  PMPrintSession   printSession,
  CFStringRef      key,
  CFTypeRef        data);


/*
 *  PMSessionGetDataFromSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionGetDataFromSession(
  PMPrintSession   printSession,
  CFStringRef      key,
  CFTypeRef *      data);


#else
/*
 *  PMSetIdleProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSetIdleProc(PMIdleUPP idleProc);


/* Print loop */
/*
 *  PMBegin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMBegin(void);


/*
 *  PMEnd()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMEnd(void);


/************************/
/*  Valid only within a PMBeginPage/PMEndPage block. You should retrieve the printing */
/*  port with this call and set it before imaging a page. */
/************************/
/*
 *  PMGetGrafPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetGrafPtr(
  PMPrintContext   printContext,
  GrafPtr *        grafPort);


/* PMPageFormat */
/*
 *  PMNewPageFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMNewPageFormat(PMPageFormat * pageFormat);


/*
 *  PMDisposePageFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMDisposePageFormat(PMPageFormat pageFormat);


/*
 *  PMDefaultPageFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMDefaultPageFormat(PMPageFormat pageFormat);


/*
 *  PMValidatePageFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMValidatePageFormat(
  PMPageFormat   pageFormat,
  Boolean *      result);


/* PMPrintSettings */
/*
 *  PMNewPrintSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMNewPrintSettings(PMPrintSettings * printSettings);


/*
 *  PMDisposePrintSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMDisposePrintSettings(PMPrintSettings printSettings);


/*
 *  PMDefaultPrintSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMDefaultPrintSettings(PMPrintSettings printSettings);


/*
 *  PMValidatePrintSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMValidatePrintSettings(
  PMPrintSettings   printSettings,
  Boolean *         result);


/* Classic Support */
/*
 *  PMGeneral()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGeneral(Ptr pData);


/*
 *  PMConvertOldPrintRecord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMConvertOldPrintRecord(
  Handle             printRecordHandle,
  PMPrintSettings *  printSettings,
  PMPageFormat *     pageFormat);


/*
 *  PMMakeOldPrintRecord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMMakeOldPrintRecord(
  PMPrintSettings   printSettings,
  PMPageFormat      pageFormat,
  Handle *          printRecordHandle);


/* Driver Information */
/*
 *  PMIsPostScriptDriver()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMIsPostScriptDriver(Boolean * isPostScript);


/*
 *  PMGetLanguageInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetLanguageInfo(PMLanguageInfo * info);


/*
 *  PMGetDriverCreator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetDriverCreator(OSType * creator);


/*
 *  PMGetDriverReleaseInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetDriverReleaseInfo(VersRec * release);


/*
 *  PMGetPrinterResolutionCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetPrinterResolutionCount(UInt32 * count);


/*
 *  PMGetPrinterResolution()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetPrinterResolution(
  PMTag           tag,
  PMResolution *  res);


/*
 *  PMGetIndexedPrinterResolution()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetIndexedPrinterResolution(
  UInt32          index,
  PMResolution *  res);


/************************/
/*  PMEnableColorSync and PMDisableColorSync are valid within */
/*  BeginPage/EndPage block */
/************************/
/* ColorSync & PostScript Support */
/*
 *  PMEnableColorSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMEnableColorSync(void);


/*
 *  PMDisableColorSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMDisableColorSync(void);


/************************/
/*  The PMPostScriptxxx calls are valid within a */
/*  BeginPage/EndPage block */
/************************/
/*
 *  PMPostScriptBegin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMPostScriptBegin(void);


/*
 *  PMPostScriptEnd()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMPostScriptEnd(void);


/************************/
/*  These PMPostScriptxxx calls are valid within a */
/*  PMPostScriptBegin/PMPostScriptEnd block */
/************************/
/*
 *  PMPostScriptHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMPostScriptHandle(Handle psHandle);


/*
 *  PMPostScriptData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMPostScriptData(
  Ptr    psPtr,
  Size   len);


/*
 *  PMPostScriptFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMPostScriptFile(FSSpec * psFile);


/* Error */
/*
 *  PMError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMError(void);


/*
 *  PMSetError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSetError(OSStatus printError);


#endif  /* PM_USE_SESSION_APIS */

/* PMPageFormat */
/*
 *  PMCopyPageFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMCopyPageFormat(
  PMPageFormat   formatSrc,
  PMPageFormat   formatDest);


/************************/
/*  Flattening a page format should only be necessary if you intend to preserve */
/*  the object settings along with a document. A page format will persist outside of a */
/*  PMBegin/PMEnd block. This will allow you to use any accessors on the object without */
/*  the need to flatten and unflatten. Keep in mind accessors make no assumption */
/*  on the validity of the value you set. This can only be done thru PMValidatePageFormat */
/*  in a PMBegin/PMEnd block or with PMSessionValidatePageFormat with a valid session. */
/*  It is your responsibility for disposing of the handle. */
/************************/
/*
 *  PMFlattenPageFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMFlattenPageFormat(
  PMPageFormat   pageFormat,
  Handle *       flatFormat);


/*
 *  PMUnflattenPageFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMUnflattenPageFormat(
  Handle          flatFormat,
  PMPageFormat *  pageFormat);


/* PMPageFormat Accessors */
/************************/
/* PMSetxxx calls only saves the value inside the printing object. They make no assumption on the */
/* validity of the value. This should be done using PMValidatePageFormat/PMSessionValidatePageFormat */
/* Any dependant settings are also updated during a validate call. */
/* For example: */
/* PMGetAdjustedPaperRect - returns a rect of a certain size */
/* PMSetScale( aPageFormat, 500.0 )  */
/* PMGetAdjustedPaperRect - returns the SAME rect as the first call  */
/**/
/* PMGetAdjustedPaperRect - returns a rect of a certain size */
/* PMSetScale( aPageFormat, 500.0 ) */
/* PMValidatePageFormat or PMSessionValidatePageFormat */
/* PMGetAdjustedPaperRect - returns a rect thats scaled 500% from the first call */
/************************/
/*
 *  PMGetPageFormatExtendedData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetPageFormatExtendedData(
  PMPageFormat   pageFormat,
  OSType         dataID,
  UInt32 *       size,
  void *         extendedData);


/*
 *  PMSetPageFormatExtendedData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSetPageFormatExtendedData(
  PMPageFormat   pageFormat,
  OSType         dataID,
  UInt32         size,
  void *         extendedData);


/************************/
/*  A value of 100.0 means 100% (no scaling). 50.0 means 50% scaling */
/************************/
/*
 *  PMGetScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetScale(
  PMPageFormat   pageFormat,
  double *       scale);


/*
 *  PMSetScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSetScale(
  PMPageFormat   pageFormat,
  double         scale);


/************************/
/*  This is the drawing resolution of an app. This should not be confused with */
/*  the resolution of the printer. You can call PMGetPrinterResolution to see */
/*  what resolutions are avaliable for the current printer. */
/************************/
/*
 *  PMGetResolution()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetResolution(
  PMPageFormat    pageFormat,
  PMResolution *  res);


/*
 *  PMSetResolution()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSetResolution(
  PMPageFormat          pageFormat,
  const PMResolution *  res);


/************************/
/*  This is the physical size of the paper without regard to resolution, orientation */
/*  or scaling. It is returned as a 72dpi value. */
/************************/
/*
 *  PMGetPhysicalPaperSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetPhysicalPaperSize(
  PMPageFormat   pageFormat,
  PMRect *       paperSize);


/*
 *  PMSetPhysicalPaperSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSetPhysicalPaperSize(
  PMPageFormat    pageFormat,
  const PMRect *  paperSize);


/************************/
/*  This is the physical size of the page without regard to resolution, orientation */
/*  or scaling. It is returned as a 72dpi value. */
/************************/
/*
 *  PMGetPhysicalPageSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetPhysicalPageSize(
  PMPageFormat   pageFormat,
  PMRect *       pageSize);


/*
 *  PMGetAdjustedPaperRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetAdjustedPaperRect(
  PMPageFormat   pageFormat,
  PMRect *       paperRect);


/*
 *  PMGetAdjustedPageRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetAdjustedPageRect(
  PMPageFormat   pageFormat,
  PMRect *       pageRect);


/*
 *  PMGetUnadjustedPaperRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetUnadjustedPaperRect(
  PMPageFormat   pageFormat,
  PMRect *       paperRect);


/*
 *  PMSetUnadjustedPaperRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSetUnadjustedPaperRect(
  PMPageFormat    pageFormat,
  const PMRect *  paperRect);


/*
 *  PMGetUnadjustedPageRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetUnadjustedPageRect(
  PMPageFormat   pageFormat,
  PMRect *       pageRect);


/*
 *  PMSetAdjustedPageRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSetAdjustedPageRect(
  PMPageFormat    pageFormat,
  const PMRect *  pageRect);


/*
 *  PMGetOrientation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetOrientation(
  PMPageFormat     pageFormat,
  PMOrientation *  orientation);


/*
 *  PMSetOrientation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSetOrientation(
  PMPageFormat    pageFormat,
  PMOrientation   orientation,
  Boolean         lock);


/* PMPrintSettings */
/*
 *  PMCopyPrintSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMCopyPrintSettings(
  PMPrintSettings   settingSrc,
  PMPrintSettings   settingDest);


/************************/
/*  Flattening a print settings should only be necessary if you intend to preserve */
/*  the object settings along with a document. A print settings will persist outside of a */
/*  PMBegin/PMEnd block. This allows you to use any accessors on the object without */
/*  the need to flatten and unflatten. Keep in mind the accessors make no assumption */
/*  on the validity of the value. This can only be done thru PMValidatePrintSettings */
/*  in a PMBegin/PMEnd block or with PMSessionValidatePrintSettings with a valid session. */
/*  It is your responsibility for disposing of the handle. */
/************************/
/*
 *  PMFlattenPrintSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMFlattenPrintSettings(
  PMPrintSettings   printSettings,
  Handle *          flatSettings);


/*
 *  PMUnflattenPrintSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMUnflattenPrintSettings(
  Handle             flatSettings,
  PMPrintSettings *  printSettings);


/* PMPrintSettings Accessors */
/*
 *  PMGetPrintSettingsExtendedData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetPrintSettingsExtendedData(
  PMPrintSettings   printSettings,
  OSType            dataID,
  UInt32 *          size,
  void *            extendedData);


/*
 *  PMSetPrintSettingsExtendedData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSetPrintSettingsExtendedData(
  PMPrintSettings   printSettings,
  OSType            dataID,
  UInt32            size,
  void *            extendedData);


/*
 *  PMGetDestination()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetDestination(
  PMPrintSettings      printSettings,
  PMDestinationType *  destType,
  CFURLRef *           fileURL);


/*
 *  PMGetJobName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetJobName(
  PMPrintSettings   printSettings,
  StringPtr         name);


/*
 *  PMSetJobName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSetJobName(
  PMPrintSettings   printSettings,
  StringPtr         name);


/*
 *  PMGetCopies()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetCopies(
  PMPrintSettings   printSettings,
  UInt32 *          copies);


/*
 *  PMSetCopies()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSetCopies(
  PMPrintSettings   printSettings,
  UInt32            copies,
  Boolean           lock);


/*
 *  PMGetFirstPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetFirstPage(
  PMPrintSettings   printSettings,
  UInt32 *          first);


/*
 *  PMSetFirstPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSetFirstPage(
  PMPrintSettings   printSettings,
  UInt32            first,
  Boolean           lock);


/*
 *  PMGetLastPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetLastPage(
  PMPrintSettings   printSettings,
  UInt32 *          last);


/*
 *  PMSetLastPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSetLastPage(
  PMPrintSettings   printSettings,
  UInt32            last,
  Boolean           lock);


/************************/
/*  The default page range is from 1-32000. The page range is something that is */
/*  set by the application. It is NOT the first and last page to print. It serves */
/*  as limits for setting the first and last page. You may pass kPMPrintAllPages for */
/*  the maxPage value to specified that all pages are available for printing. */
/************************/
/*
 *  PMGetPageRange()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetPageRange(
  PMPrintSettings   printSettings,
  UInt32 *          minPage,
  UInt32 *          maxPage);


/************************/
/* The first and last page are immediately clipped to the new range */
/************************/
/*
 *  PMSetPageRange()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSetPageRange(
  PMPrintSettings   printSettings,
  UInt32            minPage,
  UInt32            maxPage);


/*
 *  PMSetProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSetProfile(
  PMPrintSettings            printSettings,
  PMTag                      tag,
  const CMProfileLocation *  profile);


/*
 *  PMGetColorMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetColorMode(
  PMPrintSettings   printSettings,
  PMColorMode *     colorMode);


/*
 *  PMSetColorMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSetColorMode(
  PMPrintSettings   printSettings,
  PMColorMode       colorMode);



#if PRAGMA_STRUCT_ALIGN
    #pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
    #pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __PMCORE__ */

