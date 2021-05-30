/*
     File:       PMApplication.h
 
     Contains:   Carbon Printing Manager Interfaces.
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1998-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __PMAPPLICATION__
#define __PMAPPLICATION__

#ifndef __PMCORE__
#include <PMCore.h>
#endif

#ifndef __DIALOGS__
#include <Dialogs.h>
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

/* Callbacks */
typedef CALLBACK_API( void , PMItemProcPtr )(DialogRef theDialog, short item);
typedef CALLBACK_API( void , PMPrintDialogInitProcPtr )(PMPrintSettings printSettings, PMDialog *theDialog);
typedef CALLBACK_API( void , PMPageSetupDialogInitProcPtr )(PMPageFormat pageFormat, PMDialog *theDialog);
typedef CALLBACK_API( void , PMSheetDoneProcPtr )(PMPrintSession printSession, WindowRef documentWindow, Boolean accepted);
typedef STACK_UPP_TYPE(PMItemProcPtr)                           PMItemUPP;
typedef STACK_UPP_TYPE(PMPrintDialogInitProcPtr)                PMPrintDialogInitUPP;
typedef STACK_UPP_TYPE(PMPageSetupDialogInitProcPtr)            PMPageSetupDialogInitUPP;
typedef STACK_UPP_TYPE(PMSheetDoneProcPtr)                      PMSheetDoneUPP;
/*
 *  NewPMItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( PMItemUPP )
NewPMItemUPP(PMItemProcPtr userRoutine);

/*
 *  NewPMPrintDialogInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( PMPrintDialogInitUPP )
NewPMPrintDialogInitUPP(PMPrintDialogInitProcPtr userRoutine);

/*
 *  NewPMPageSetupDialogInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( PMPageSetupDialogInitUPP )
NewPMPageSetupDialogInitUPP(PMPageSetupDialogInitProcPtr userRoutine);

/*
 *  NewPMSheetDoneUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( PMSheetDoneUPP )
NewPMSheetDoneUPP(PMSheetDoneProcPtr userRoutine);

/*
 *  DisposePMItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposePMItemUPP(PMItemUPP userUPP);

/*
 *  DisposePMPrintDialogInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposePMPrintDialogInitUPP(PMPrintDialogInitUPP userUPP);

/*
 *  DisposePMPageSetupDialogInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposePMPageSetupDialogInitUPP(PMPageSetupDialogInitUPP userUPP);

/*
 *  DisposePMSheetDoneUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposePMSheetDoneUPP(PMSheetDoneUPP userUPP);

/*
 *  InvokePMItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
InvokePMItemUPP(
  DialogRef  theDialog,
  short      item,
  PMItemUPP  userUPP);

/*
 *  InvokePMPrintDialogInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
InvokePMPrintDialogInitUPP(
  PMPrintSettings       printSettings,
  PMDialog *            theDialog,
  PMPrintDialogInitUPP  userUPP);

/*
 *  InvokePMPageSetupDialogInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
InvokePMPageSetupDialogInitUPP(
  PMPageFormat              pageFormat,
  PMDialog *                theDialog,
  PMPageSetupDialogInitUPP  userUPP);

/*
 *  InvokePMSheetDoneUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
InvokePMSheetDoneUPP(
  PMPrintSession  printSession,
  WindowRef       documentWindow,
  Boolean         accepted,
  PMSheetDoneUPP  userUPP);

#if PM_USE_SESSION_APIS
/* Print loop */
/*
 *  PMSessionBeginDocument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionBeginDocument(
  PMPrintSession    printSession,
  PMPrintSettings   printSettings,
  PMPageFormat      pageFormat);


/*
 *  PMSessionEndDocument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionEndDocument(PMPrintSession printSession);


/*
 *  PMSessionBeginPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionBeginPage(
  PMPrintSession   printSession,
  PMPageFormat     pageFormat,
  const PMRect *   pageFrame);


/*
 *  PMSessionEndPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionEndPage(PMPrintSession printSession);


/* Session Printing Dialogs */
/*
 *  PMSessionPageSetupDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionPageSetupDialog(
  PMPrintSession   printSession,
  PMPageFormat     pageFormat,
  Boolean *        accepted);


/*
 *  PMSessionPrintDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionPrintDialog(
  PMPrintSession    printSession,
  PMPrintSettings   printSettings,
  PMPageFormat      constPageFormat,
  Boolean *         accepted);


/*
 *  PMSessionPageSetupDialogInit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionPageSetupDialogInit(
  PMPrintSession   printSession,
  PMPageFormat     pageFormat,
  PMDialog *       newDialog);


/*
 *  PMSessionPrintDialogInit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionPrintDialogInit(
  PMPrintSession    printSession,
  PMPrintSettings   printSettings,
  PMPageFormat      constPageFormat,
  PMDialog *        newDialog);


/*
 *  PMSessionPrintDialogMain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionPrintDialogMain(
  PMPrintSession         printSession,
  PMPrintSettings        printSettings,
  PMPageFormat           constPageFormat,
  Boolean *              accepted,
  PMPrintDialogInitUPP   myInitProc);


/*
 *  PMSessionPageSetupDialogMain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionPageSetupDialogMain(
  PMPrintSession             printSession,
  PMPageFormat               pageFormat,
  Boolean *                  accepted,
  PMPageSetupDialogInitUPP   myInitProc);


/************************/
/*  Sheets are not available on classic. */
/************************/
/*
 *  PMSessionUseSheets()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.2 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSessionUseSheets(
  PMPrintSession   printSession,
  WindowRef        documentWindow,
  PMSheetDoneUPP   sheetDoneProc);


#else
/* Print loop */
/*
 *  PMBeginDocument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMBeginDocument(
  PMPrintSettings   printSettings,
  PMPageFormat      pageFormat,
  PMPrintContext *  printContext);


/*
 *  PMEndDocument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMEndDocument(PMPrintContext printContext);


/*
 *  PMBeginPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMBeginPage(
  PMPrintContext   printContext,
  const PMRect *   pageFrame);


/*
 *  PMEndPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMEndPage(PMPrintContext printContext);


/* Printing Dialogs */
/*
 *  PMPageSetupDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMPageSetupDialog(
  PMPageFormat   pageFormat,
  Boolean *      accepted);


/*
 *  PMPrintDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMPrintDialog(
  PMPrintSettings   printSettings,
  PMPageFormat      constPageFormat,
  Boolean *         accepted);


/*
 *  PMPageSetupDialogInit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMPageSetupDialogInit(
  PMPageFormat   pageFormat,
  PMDialog *     newDialog);


/************************/
/*  PMPrintDialogInit is not recommended. You should instead use */
/*  PMPrintDialogInitWithPageFormat or PMSessionPrintDialogInit */
/************************/
/*
 *  PMPrintDialogInit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMPrintDialogInit(
  PMPrintSettings   printSettings,
  PMDialog *        newDialog);


/*
 *  PMPrintDialogInitWithPageFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMPrintDialogInitWithPageFormat(
  PMPrintSettings   printSettings,
  PMPageFormat      constPageFormat,
  PMDialog *        newDialog);


/*
 *  PMPrintDialogMain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMPrintDialogMain(
  PMPrintSettings        printSettings,
  PMPageFormat           constPageFormat,
  Boolean *              accepted,
  PMPrintDialogInitUPP   myInitProc);


/*
 *  PMPageSetupDialogMain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMPageSetupDialogMain(
  PMPageFormat               pageFormat,
  Boolean *                  accepted,
  PMPageSetupDialogInitUPP   myInitProc);


#endif  /* PM_USE_SESSION_APIS */

/* Printing Dialog accessors */
/*
 *  PMGetDialogPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetDialogPtr(
  PMDialog     pmDialog,
  DialogRef *  theDialog);


#define PMGetDialogRef PMGetDialogPtr
/*
 *  PMGetModalFilterProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetModalFilterProc(
  PMDialog          pmDialog,
  ModalFilterUPP *  filterProc);


/*
 *  PMSetModalFilterProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSetModalFilterProc(
  PMDialog         pmDialog,
  ModalFilterUPP   filterProc);


/*
 *  PMGetItemProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetItemProc(
  PMDialog     pmDialog,
  PMItemUPP *  itemProc);


/*
 *  PMSetItemProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSetItemProc(
  PMDialog    pmDialog,
  PMItemUPP   itemProc);


/*
 *  PMGetDialogAccepted()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetDialogAccepted(
  PMDialog   pmDialog,
  Boolean *  process);


/*
 *  PMSetDialogAccepted()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSetDialogAccepted(
  PMDialog   pmDialog,
  Boolean    process);


/*
 *  PMGetDialogDone()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMGetDialogDone(
  PMDialog   pmDialog,
  Boolean *  done);


/*
 *  PMSetDialogDone()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PMSetDialogDone(
  PMDialog   pmDialog,
  Boolean    done);



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

#endif /* __PMAPPLICATION__ */

