/*
     File:       Navigation.h
 
     Contains:   Navigation Services Interfaces
 
     Version:    Technology: Navigation 3.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1996-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __NAVIGATION__
#define __NAVIGATION__

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif

#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif

#ifndef __TRANSLATION__
#include <Translation.h>
#endif

#ifndef __MACWINDOWS__
#include <MacWindows.h>
#endif

#ifndef __CODEFRAGMENTS__
#include <CodeFragments.h>
#endif

#ifndef __MACERRORS__
#include <MacErrors.h>
#endif

#ifndef __CFARRAY__
#include <CFArray.h>
#endif

#ifndef __CFSTRING__
#include <CFString.h>
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

typedef UInt32 NavAskSaveChangesAction;
enum {
                                        /* input action codes for NavAskSaveChanges() */
  kNavSaveChangesClosingDocument = 1,
  kNavSaveChangesQuittingApplication = 2,
  kNavSaveChangesOther          = 0
};


typedef UInt32 NavAskSaveChangesResult;
enum {
                                        /* result codes for NavAskSaveChanges() */
  kNavAskSaveChangesSave        = 1,
  kNavAskSaveChangesCancel      = 2,
  kNavAskSaveChangesDontSave    = 3
};


typedef UInt32 NavAskDiscardChangesResult;
enum {
                                        /* result codes for NavAskDiscardChanges() */
  kNavAskDiscardChanges         = 1,
  kNavAskDiscardChangesCancel   = 2
};


typedef SInt16 NavFilterModes;
enum {
                                        /* which elements are being filtered for objects: */
  kNavFilteringBrowserList      = 0,
  kNavFilteringFavorites        = 1,
  kNavFilteringRecents          = 2,
  kNavFilteringShortCutVolumes  = 3,
  kNavFilteringLocationPopup    = 4     /* for v1.1 or greater */
};


enum {
  kNavFileOrFolderVersion       = 1
};

struct NavFileOrFolderInfo {
  UInt16              version;
  Boolean             isFolder;
  Boolean             visible;
  UInt32              creationDate;
  UInt32              modificationDate;
  union {
    struct {
      Boolean             locked;             /* file is locked */
      Boolean             resourceOpen;       /* resource fork is opened */
      Boolean             dataOpen;           /* data fork is opened */
      Boolean             reserved1;
      UInt32              dataSize;           /* size of the data fork */
      UInt32              resourceSize;       /* size of the resource fork */
      FInfo               finderInfo;         /* more file info: */
      FXInfo              finderXInfo;
    }                       fileInfo;
    struct {
      Boolean             shareable;
      Boolean             sharePoint;
      Boolean             mounted;
      Boolean             readable;
      Boolean             writeable;
      Boolean             reserved2;
      UInt32              numberOfFiles;
      DInfo               finderDInfo;
      DXInfo              finderDXInfo;
      OSType              folderType;         /* package type, For struct version >= 1 */
      OSType              folderCreator;      /* package creator, For struct version >= 1 */
      char                reserved3[206];
    }                       folderInfo;

  }                       fileAndFolder;
};
typedef struct NavFileOrFolderInfo      NavFileOrFolderInfo;
union NavEventDataInfo {
  EventRecord *       event;                  /* for event processing */
  void *              param;                  /* points to event specific data */
};
typedef union NavEventDataInfo          NavEventDataInfo;
struct NavEventData {
  NavEventDataInfo    eventDataParms;         /* the event data */
  SInt16              itemHit;                /* the dialog item number, for v1.1 or greater */
};
typedef struct NavEventData             NavEventData;

/*
 *  NavDialogRef
 *  
 *  Summary:
 *    Opaque Navigation Services dialog identifier
 *  
 *  Discussion:
 *    A NavDialogRef is an opaque reference to an instance of a
 *    Navigation Services dialog. A new NavDialogRef is returned from
 *    any of the NavCreateXXXDialog functions and is later disposed
 *    with the NavDialogDispose function. NavDialogRef is the new name
 *    for the NavContext type, and thus when a client's event proc is
 *    called, the value of the NavCBRec.context field is the same as
 *    the NavDialogRef returned from the corresponding
 *    NavCreateXXXDialog. A NavDialogRef is distinct from, and is not
 *    interchangable with, a Dialog Manager DialogRef.
 */
typedef struct __NavDialog*             NavDialogRef;
#if CALL_NOT_IN_CARBON
/* NavContext is the old name for NavDialogRef */

typedef NavDialogRef                    NavContext;
#endif  /* CALL_NOT_IN_CARBON */


/*
 *  NavUserAction
 *  
 *  Summary:
 *    Indicates which user action dismissed a dialog
 *  
 *  Discussion:
 *    The following values indicate which action was taken by the user
 *    to dismiss a Navigation Services dialog. NavUserAction is used
 *    only with Carbon dialogs (dialogs created with the
 *    NavCreateXXXDialog functions).
 */

  /*
   * No action taken. The dialog is still running or was terminated
   * programmatically.
   */
typedef UInt32 NavUserAction;
enum {
  kNavUserActionNone            = 0,

  /*
   * The user cancelled the dialog.
   */
  kNavUserActionCancel          = 1,

  /*
   * The user clicked the Open button in the GetFile dialog.
   */
  kNavUserActionOpen            = 2,

  /*
   * The user clicked the Save button in the PutFile dialog.
   */
  kNavUserActionSaveAs          = 3,

  /*
   * The user clicked the Choose button in the ChooseFile,
   * ChooseFolder, ChooseVolume or ChooseObject dialogs.
   */
  kNavUserActionChoose          = 4,

  /*
   * The user clicked the New Folder button in the New Folder dialog.
   */
  kNavUserActionNewFolder       = 5,

  /*
   * The user clicked the Save button in an AskSaveChanges dialog.
   */
  kNavUserActionSaveChanges     = 6,

  /*
   * The user clicked the Don't Save button in an AskSaveChanges dialog.
   */
  kNavUserActionDontSaveChanges = 7,

  /*
   * The user clicked the Discard button in the AskDiscardChanges
   * dialog.
   */
  kNavUserActionDiscardChanges  = 8
};


enum {
  kNavCBRecVersion              = 1
};


/*
 *  NavCBRec
 *  
 *  Summary:
 *    A structure passed to event and preview callbacks
 *  
 *  Discussion:
 *    The NavCBRec structure is passed to the client's event proc or
 *    custom preview proc. It provides information that is specific to
 *    each event type. New for Carbon: the userAction field.
 */
struct NavCBRec {
  UInt16              version;
  NavDialogRef        context;
  WindowRef           window;
  Rect                customRect;
  Rect                previewRect;
  NavEventData        eventData;
  NavUserAction       userAction;
  char                reserved[218];
};
typedef struct NavCBRec                 NavCBRec;
typedef NavCBRec *                      NavCBRecPtr;

/*
 *  NavEventCallbackMessage
 *  
 *  Summary:
 *    Identifies the message type being sent to the client's event proc
 */

  /*
   * An OS event has occurred. A pointer to the EventRecord is in the
   * eventData.eventDataParms.event field of the NavCBRec.
   */
typedef SInt32 NavEventCallbackMessage;
enum {
  kNavCBEvent                   = 0,

  /*
   * Negotiate for custom control space. Client can set change the
   * customRect field in the NavCBRec to create space for a custom
   * area. Nav Services will continue to send the kNavCBCustomize
   * message until the client leaves the customRect field unchanged.
   */
  kNavCBCustomize               = 1,

  /*
   * This message is sent after custom area negotiation, just before
   * the dialog is made visible. Add your custom controls when you
   * receive this message.
   */
  kNavCBStart                   = 2,

  /*
   * This is the last message sent, after the dialog has been hidden.
   */
  kNavCBTerminate               = 3,

  /*
   * Sent when the dialog has been resized. Check the customRect and or
   * previewRect values to see if any relayout is needed. Nav Services
   * automatically moves controls in the custom area.
   */
  kNavCBAdjustRect              = 4,

  /*
   * The target folder of the dialog has changed. The
   * NavCBRec.eventData.eventDataParms.param field is an AEDesc*
   * containing an descriptor of the new location (ususally an FSSpec
   * or an FSRef).
   */
  kNavCBNewLocation             = 5,

  /*
   * The target folder has changed to the user's desktop folder.
   */
  kNavCBShowDesktop             = 6,

  /*
   * The user has selected or deselected a file or folder. The
   * NavCBRec.eventData.eventDataParms.param field is an AEDescList*
   * identifying the currently selected items.
   */
  kNavCBSelectEntry             = 7,

  /*
   * The value of the Show/Format popup menu has changed. The
   * NavCBRec.eventData.eventDataParms.param is a NavMenuItemSpec*
   * identifying the menu item selected. If the dialog was created
   * using the Carbon-only NavCreateXXXDialog APIs, then the menuType
   * field of the NavMenuItemSpec is set to the index into the client's
   * CFArray of popupExtension strings (see NavDialogCreationOptions).
   */
  kNavCBPopupMenuSelect         = 8,

  /*
   * Sent when the user has accepted.
   */
  kNavCBAccept                  = 9,

  /*
   * Sent when the user has cancelled the dialog.
   */
  kNavCBCancel                  = 10,

  /*
   * The custom preview area state has changed. The
   * NavCBRec.eventData.eventDataParms.param is a Boolean* set to true
   * if the preview area is visible or false if it is not.
   */
  kNavCBAdjustPreview           = 11,

  /*
   * The user has taken an action that dismisses the dialog. The
   * NavCBRec.userAction field indicates which action was taken (Carbon
   * dialogs only).
   */
  kNavCBUserAction              = 12,

  /*
   * The user has opened a folder or chosen a file. The client can
   * block navigation or dismissal by setting the appropriate action
   * state with the kNavCtlSetActionState NavCustomControl selector.
   */
  kNavCBOpenSelection           = (long)0x80000000
};

typedef void *                          NavCallBackUserData;
/* for events and customization: */
typedef CALLBACK_API( void , NavEventProcPtr )(NavEventCallbackMessage callBackSelector, NavCBRecPtr callBackParms, void *callBackUD);
/* for preview support: */
typedef CALLBACK_API( Boolean , NavPreviewProcPtr )(NavCBRecPtr callBackParms, void *callBackUD);
/* filtering callback information: */
typedef CALLBACK_API( Boolean , NavObjectFilterProcPtr )(AEDesc *theItem, void *info, void *callBackUD, NavFilterModes filterMode);
typedef STACK_UPP_TYPE(NavEventProcPtr)                         NavEventUPP;
typedef STACK_UPP_TYPE(NavPreviewProcPtr)                       NavPreviewUPP;
typedef STACK_UPP_TYPE(NavObjectFilterProcPtr)                  NavObjectFilterUPP;
/*
 *  NewNavEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( NavEventUPP )
NewNavEventUPP(NavEventProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppNavEventProcInfo = 0x00000FC0 };  /* pascal no_return_value Func(4_bytes, 4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline NavEventUPP NewNavEventUPP(NavEventProcPtr userRoutine) { return (NavEventUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppNavEventProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewNavEventUPP(userRoutine) (NavEventUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppNavEventProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewNavPreviewUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( NavPreviewUPP )
NewNavPreviewUPP(NavPreviewProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppNavPreviewProcInfo = 0x000003D0 };  /* pascal 1_byte Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline NavPreviewUPP NewNavPreviewUPP(NavPreviewProcPtr userRoutine) { return (NavPreviewUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppNavPreviewProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewNavPreviewUPP(userRoutine) (NavPreviewUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppNavPreviewProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewNavObjectFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( NavObjectFilterUPP )
NewNavObjectFilterUPP(NavObjectFilterProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppNavObjectFilterProcInfo = 0x00002FD0 };  /* pascal 1_byte Func(4_bytes, 4_bytes, 4_bytes, 2_bytes) */
  #ifdef __cplusplus
    inline NavObjectFilterUPP NewNavObjectFilterUPP(NavObjectFilterProcPtr userRoutine) { return (NavObjectFilterUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppNavObjectFilterProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewNavObjectFilterUPP(userRoutine) (NavObjectFilterUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppNavObjectFilterProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  DisposeNavEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposeNavEventUPP(NavEventUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeNavEventUPP(NavEventUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeNavEventUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeNavPreviewUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposeNavPreviewUPP(NavPreviewUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeNavPreviewUPP(NavPreviewUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeNavPreviewUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeNavObjectFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposeNavObjectFilterUPP(NavObjectFilterUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeNavObjectFilterUPP(NavObjectFilterUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeNavObjectFilterUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  InvokeNavEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
InvokeNavEventUPP(
  NavEventCallbackMessage  callBackSelector,
  NavCBRecPtr              callBackParms,
  void *                   callBackUD,
  NavEventUPP              userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void InvokeNavEventUPP(NavEventCallbackMessage callBackSelector, NavCBRecPtr callBackParms, void * callBackUD, NavEventUPP userUPP) { CALL_THREE_PARAMETER_UPP(userUPP, uppNavEventProcInfo, callBackSelector, callBackParms, callBackUD); }
  #else
    #define InvokeNavEventUPP(callBackSelector, callBackParms, callBackUD, userUPP) CALL_THREE_PARAMETER_UPP((userUPP), uppNavEventProcInfo, (callBackSelector), (callBackParms), (callBackUD))
  #endif
#endif

/*
 *  InvokeNavPreviewUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
InvokeNavPreviewUPP(
  NavCBRecPtr    callBackParms,
  void *         callBackUD,
  NavPreviewUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline Boolean InvokeNavPreviewUPP(NavCBRecPtr callBackParms, void * callBackUD, NavPreviewUPP userUPP) { return (Boolean)CALL_TWO_PARAMETER_UPP(userUPP, uppNavPreviewProcInfo, callBackParms, callBackUD); }
  #else
    #define InvokeNavPreviewUPP(callBackParms, callBackUD, userUPP) (Boolean)CALL_TWO_PARAMETER_UPP((userUPP), uppNavPreviewProcInfo, (callBackParms), (callBackUD))
  #endif
#endif

/*
 *  InvokeNavObjectFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
InvokeNavObjectFilterUPP(
  AEDesc *            theItem,
  void *              info,
  void *              callBackUD,
  NavFilterModes      filterMode,
  NavObjectFilterUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline Boolean InvokeNavObjectFilterUPP(AEDesc * theItem, void * info, void * callBackUD, NavFilterModes filterMode, NavObjectFilterUPP userUPP) { return (Boolean)CALL_FOUR_PARAMETER_UPP(userUPP, uppNavObjectFilterProcInfo, theItem, info, callBackUD, filterMode); }
  #else
    #define InvokeNavObjectFilterUPP(theItem, info, callBackUD, filterMode, userUPP) (Boolean)CALL_FOUR_PARAMETER_UPP((userUPP), uppNavObjectFilterProcInfo, (theItem), (info), (callBackUD), (filterMode))
  #endif
#endif

#if CALL_NOT_IN_CARBON || OLDROUTINENAMES
    /* support for pre-Carbon UPP routines: New...Proc and Call...Proc */
    #define NewNavEventProc(userRoutine)                        NewNavEventUPP(userRoutine)
    #define NewNavPreviewProc(userRoutine)                      NewNavPreviewUPP(userRoutine)
    #define NewNavObjectFilterProc(userRoutine)                 NewNavObjectFilterUPP(userRoutine)
    #define CallNavEventProc(userRoutine, callBackSelector, callBackParms, callBackUD) InvokeNavEventUPP(callBackSelector, callBackParms, callBackUD, userRoutine)
    #define CallNavPreviewProc(userRoutine, callBackParms, callBackUD) InvokeNavPreviewUPP(callBackParms, callBackUD, userRoutine)
    #define CallNavObjectFilterProc(userRoutine, theItem, info, callBackUD, filterMode) InvokeNavObjectFilterUPP(theItem, info, callBackUD, filterMode, userRoutine)
#endif /* CALL_NOT_IN_CARBON */

typedef SInt32 NavCustomControlMessage;
enum {
  kNavCtlShowDesktop            = 0,    /*    show desktop,           parms = nil */
  kNavCtlSortBy                 = 1,    /*    sort key field,       parms->NavSortKeyField */
  kNavCtlSortOrder              = 2,    /*    sort order,              parms->NavSortOrder */
  kNavCtlScrollHome             = 3,    /*    scroll list home,       parms = nil */
  kNavCtlScrollEnd              = 4,    /*    scroll list end,      parms = nil */
  kNavCtlPageUp                 = 5,    /*    page list up,          parms = nil */
  kNavCtlPageDown               = 6,    /*    page list down,          parms = nil */
  kNavCtlGetLocation            = 7,    /*    get current location,   parms<-AEDesc* */
  kNavCtlSetLocation            = 8,    /*    set current location,   parms->AEDesc* */
  kNavCtlGetSelection           = 9,    /*    get current selection,     parms<-AEDescList* */
  kNavCtlSetSelection           = 10,   /*    set current selection,     parms->AEDescList* */
  kNavCtlShowSelection          = 11,   /*    make selection visible,       parms = nil */
  kNavCtlOpenSelection          = 12,   /*    open view of selection,       parms = nil */
  kNavCtlEjectVolume            = 13,   /*    eject volume,          parms->vRefNum */
  kNavCtlNewFolder              = 14,   /*    create a new folder,     parms->StringPtr */
  kNavCtlCancel                 = 15,   /*    cancel dialog,          parms = nil */
  kNavCtlAccept                 = 16,   /*    accept dialog default,     parms = nil */
  kNavCtlIsPreviewShowing       = 17,   /*    query preview status,   parms<-Boolean */
  kNavCtlAddControl             = 18,   /*  add one control to dialog,    parms->ControlHandle */
  kNavCtlAddControlList         = 19,   /*    add control list to dialog,    parms->Handle (DITL rsrc) */
  kNavCtlGetFirstControlID      = 20,   /*    get 1st control ID,         parms<-UInt16 */
  kNavCtlSelectCustomType       = 21,   /*    select a custom menu item  parms->NavMenuItemSpec* */
  kNavCtlSelectAllType          = 22,   /*  select an "All" menu item parms->SInt16 */
  kNavCtlGetEditFileName        = 23,   /*    get save dlog's file name  parms<-StringPtr */
  kNavCtlSetEditFileName        = 24,   /*    set save dlog's file name  parms->StringPtr */
  kNavCtlSelectEditFileName     = 25,   /*    select save dlog file name parms->ControlEditTextSelectionRec*, v1.1 or greater */
  kNavCtlBrowserSelectAll       = 26,   /*  re-scan the browser list  parms = nil, v2.0 or greater */
  kNavCtlGotoParent             = 27,   /*  navigate to parent         parms = nil, v2.0 or greater */
  kNavCtlSetActionState         = 28,   /*  restrict navigation      parms->NavActionState (flags), v2.0 or greater */
  kNavCtlBrowserRedraw          = 29,   /*  rescan browser list      parms = nil, v2.0 or greater */
  kNavCtlTerminate              = 30    /*  terminate/dismiss dialog  parms = nil, v2.0 or greater */
};

typedef UInt32 NavActionState;
enum {
  kNavNormalState               = 0x00000000, /* normal/default state */
  kNavDontOpenState             = 0x00000001, /* disallow opening files/folders */
  kNavDontSaveState             = 0x00000002, /* disallow saving files */
  kNavDontChooseState           = 0x00000004, /* disallow choosing objects */
  kNavDontNewFolderState        = 0x00000010 /* disallow creating new folders */
};

typedef UInt16 NavPopupMenuItem;
enum {
  kNavAllKnownFiles             = 0,
  kNavAllReadableFiles          = 1,
  kNavAllFiles                  = 2
};

typedef UInt16 NavSortKeyField;
enum {
  kNavSortNameField             = 0,
  kNavSortDateField             = 1
};


typedef UInt16 NavSortOrder;
enum {
  kNavSortAscending             = 0,
  kNavSortDescending            = 1
};


typedef UInt32 NavDialogOptionFlags;
enum {
  kNavDefaultNavDlogOptions     = 0x000000E4, /* use defaults for all the options */
  kNavNoTypePopup               = 0x00000001, /* don't show file type/extension popup on Open/Save */
  kNavDontAutoTranslate         = 0x00000002, /* don't automatically translate on Open */
  kNavDontAddTranslateItems     = 0x00000004, /* don't add translation choices on Open/Save */
  kNavAllFilesInPopup           = 0x00000010, /* "All Files" menu item in the type popup on Open */
  kNavAllowStationery           = 0x00000020, /* allow saving of stationery files */
  kNavAllowPreviews             = 0x00000040, /* allow preview to show */
  kNavAllowMultipleFiles        = 0x00000080, /* allow multiple items to be selected */
  kNavAllowInvisibleFiles       = 0x00000100, /* allow invisible items to be shown */
  kNavDontResolveAliases        = 0x00000200, /* don't resolve aliases */
  kNavSelectDefaultLocation     = 0x00000400, /* make the default location the browser selection */
  kNavSelectAllReadableItem     = 0x00000800, /* make the dialog select "All Readable Documents" on open */
  kNavSupportPackages           = 0x00001000, /* recognize file system packages, v2.0 or greater */
  kNavAllowOpenPackages         = 0x00002000, /* allow opening of packages, v2.0 or greater */
  kNavDontAddRecents            = 0x00004000, /* don't add chosen objects to the recents list, v2.0 or greater */
  kNavDontUseCustomFrame        = 0x00008000, /* don't draw the custom area bevel frame, v2.0 or greater */
  kNavDontConfirmReplacement    = 0x00010000 /* don't show the "Replace File?" alert on save conflict, v3.0 or greater */
};

typedef UInt32 NavTranslationOptions;
enum {
  kNavTranslateInPlace          = 0,    /*    translate in place, replacing translation source file (default for Save) */
  kNavTranslateCopy             = 1     /*    translate to a copy of the source file (default for Open) */
};


enum {
  kNavMenuItemSpecVersion       = 0
};

struct NavMenuItemSpec {
  UInt16              version;
  OSType              menuCreator;
  OSType              menuType;
  Str255              menuItemName;
  char                reserved[245];
};
typedef struct NavMenuItemSpec          NavMenuItemSpec;
typedef NavMenuItemSpec *               NavMenuItemSpecArrayPtr;
typedef NavMenuItemSpecArrayPtr *       NavMenuItemSpecArrayHandle;
typedef NavMenuItemSpecArrayPtr         NavMenuItemSpecPtr;
typedef NavMenuItemSpecArrayHandle      NavMenuItemSpecHandle;
enum {
  kNavGenericSignature          = FOUR_CHAR_CODE('****')
};

struct NavTypeList {
  OSType              componentSignature;
  short               reserved;
  short               osTypeCount;
  OSType              osType[1];
};
typedef struct NavTypeList              NavTypeList;
typedef NavTypeList *                   NavTypeListPtr;
typedef NavTypeListPtr *                NavTypeListHandle;
enum {
  kNavDialogOptionsVersion      = 0
};

struct NavDialogOptions {
  UInt16              version;
  NavDialogOptionFlags  dialogOptionFlags;    /* option flags for affecting the dialog's behavior */
  Point               location;               /* top-left location of the dialog, or {-1,-1} for default position */
  Str255              clientName;
  Str255              windowTitle;
  Str255              actionButtonLabel;      /* label of the default button (or null string for default) */
  Str255              cancelButtonLabel;      /* label of the cancel button (or null string for default) */
  Str255              savedFileName;          /* default name for text box in NavPutFile (or null string for default) */
  Str255              message;                /* custom message prompt (or null string for default) */
  UInt32              preferenceKey;          /* a key for to managing preferences for using multiple utility dialogs */
  NavMenuItemSpecArrayHandle  popupExtension; /* extended popup menu items, an array of NavMenuItemSpecs */
  char                reserved[494];
};
typedef struct NavDialogOptions         NavDialogOptions;
enum {
  kNavReplyRecordVersion        = 1
};


/*
 *  NavReplyRecord
 *  
 *  Summary:
 *    A structure describing the results of a Nav Services dialog
 *  
 *  Discussion:
 *    A reply record is the result of a Nav Services file dialog. Using
 *    the older API, which is always modal, the client passes the
 *    address of a reply record when invoking the dialog. In the Carbon
 *    API, dialogs may also be window modal or modeless, so the client
 *    requests the reply record when the dialog is complete using
 *    NavDialogGetReply. Either way, a reply record should be disposed
 *    of using NavDisposeReply.
 */
struct NavReplyRecord {
  UInt16              version;
  Boolean             validRecord;
  Boolean             replacing;
  Boolean             isStationery;
  Boolean             translationNeeded;
  AEDescList          selection;
  ScriptCode          keyScript;
  FileTranslationSpecArrayHandle  fileTranslation;
  UInt32              reserved1;
  CFStringRef         saveFileName;
  char                reserved[227];
};
typedef struct NavReplyRecord           NavReplyRecord;
/*
 *  NavLoad()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
NavLoad(void);


/*
 *  NavUnload()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
NavUnload(void);


/*
 *  NavLibraryVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( UInt32 )
NavLibraryVersion(void);


/*
 *  NavGetDefaultDialogOptions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSErr )
NavGetDefaultDialogOptions(NavDialogOptions * dialogOptions);



/*
 *  NavGetFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSErr )
NavGetFile(
  AEDesc *             defaultLocation,       /* can be NULL */
  NavReplyRecord *     reply,
  NavDialogOptions *   dialogOptions,         /* can be NULL */
  NavEventUPP          eventProc,             /* can be NULL */
  NavPreviewUPP        previewProc,           /* can be NULL */
  NavObjectFilterUPP   filterProc,            /* can be NULL */
  NavTypeListHandle    typeList,              /* can be NULL */
  void *               callBackUD);           /* can be NULL */


/*
 *  NavPutFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSErr )
NavPutFile(
  AEDesc *            defaultLocation,       /* can be NULL */
  NavReplyRecord *    reply,
  NavDialogOptions *  dialogOptions,         /* can be NULL */
  NavEventUPP         eventProc,             /* can be NULL */
  OSType              fileType,
  OSType              fileCreator,
  void *              callBackUD);           /* can be NULL */


/*
 *  NavAskSaveChanges()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSErr )
NavAskSaveChanges(
  NavDialogOptions *         dialogOptions,
  NavAskSaveChangesAction    action,
  NavAskSaveChangesResult *  reply,
  NavEventUPP                eventProc,           /* can be NULL */
  void *                     callBackUD);         /* can be NULL */


/*
 *  NavCustomAskSaveChanges()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSErr )
NavCustomAskSaveChanges(
  NavDialogOptions *         dialogOptions,
  NavAskSaveChangesResult *  reply,
  NavEventUPP                eventProc,           /* can be NULL */
  void *                     callBackUD);         /* can be NULL */


/*
 *  NavAskDiscardChanges()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSErr )
NavAskDiscardChanges(
  NavDialogOptions *            dialogOptions,
  NavAskDiscardChangesResult *  reply,
  NavEventUPP                   eventProc,           /* can be NULL */
  void *                        callBackUD);         /* can be NULL */


/*
 *  NavChooseFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSErr )
NavChooseFile(
  AEDesc *             defaultLocation,       /* can be NULL */
  NavReplyRecord *     reply,
  NavDialogOptions *   dialogOptions,         /* can be NULL */
  NavEventUPP          eventProc,             /* can be NULL */
  NavPreviewUPP        previewProc,           /* can be NULL */
  NavObjectFilterUPP   filterProc,            /* can be NULL */
  NavTypeListHandle    typeList,              /* can be NULL */
  void *               callBackUD);           /* can be NULL */


/*
 *  NavChooseFolder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSErr )
NavChooseFolder(
  AEDesc *             defaultLocation,       /* can be NULL */
  NavReplyRecord *     reply,
  NavDialogOptions *   dialogOptions,         /* can be NULL */
  NavEventUPP          eventProc,             /* can be NULL */
  NavObjectFilterUPP   filterProc,            /* can be NULL */
  void *               callBackUD);           /* can be NULL */


/*
 *  NavChooseVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSErr )
NavChooseVolume(
  AEDesc *             defaultSelection,       /* can be NULL */
  NavReplyRecord *     reply,
  NavDialogOptions *   dialogOptions,          /* can be NULL */
  NavEventUPP          eventProc,              /* can be NULL */
  NavObjectFilterUPP   filterProc,             /* can be NULL */
  void *               callBackUD);            /* can be NULL */


/*
 *  NavChooseObject()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSErr )
NavChooseObject(
  AEDesc *             defaultLocation,       /* can be NULL */
  NavReplyRecord *     reply,
  NavDialogOptions *   dialogOptions,         /* can be NULL */
  NavEventUPP          eventProc,             /* can be NULL */
  NavObjectFilterUPP   filterProc,            /* can be NULL */
  void *               callBackUD);           /* can be NULL */


/*
 *  NavNewFolder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSErr )
NavNewFolder(
  AEDesc *            defaultLocation,       /* can be NULL */
  NavReplyRecord *    reply,
  NavDialogOptions *  dialogOptions,         /* can be NULL */
  NavEventUPP         eventProc,             /* can be NULL */
  void *              callBackUD);           /* can be NULL */


/*
 *  NavTranslateFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSErr )
NavTranslateFile(
  NavReplyRecord *        reply,
  NavTranslationOptions   howToTranslate);


/*
 *  NavCompleteSave()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSErr )
NavCompleteSave(
  NavReplyRecord *        reply,
  NavTranslationOptions   howToTranslate);


/*
 *  NavCustomControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSErr )
NavCustomControl(
  NavDialogRef              dialog,
  NavCustomControlMessage   selector,
  void *                    parms);


/*
 *  NavCreatePreview()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSErr )
NavCreatePreview(
  AEDesc *      theObject,
  OSType        previewDataType,
  const void *  previewData,
  Size          previewDataSize);


/*
 *  NavDisposeReply()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSErr )
NavDisposeReply(NavReplyRecord * reply);


/*
 *  NavServicesCanRun()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 */
EXTERN_API( Boolean )
NavServicesCanRun(void);



#if TARGET_RT_MAC_CFM
#ifdef __cplusplus
    inline pascal Boolean NavServicesAvailable() { return ((NavLibraryVersion != (void*)kUnresolvedCFragSymbolAddress) && NavServicesCanRun()); }
#else
    #define NavServicesAvailable()  ((NavLibraryVersion != (void*)kUnresolvedCFragSymbolAddress) && NavServicesCanRun())
#endif
#elif TARGET_RT_MAC_MACHO
/* Navigation is always available on OS X */
#ifdef __cplusplus
    inline pascal Boolean NavServicesAvailable() { return true; }
#else
    #define NavServicesAvailable()  (true)
#endif
#else
/* NavServicesAvailable() is implemented in Navigation.o for classic 68K clients*/
#if CALL_NOT_IN_CARBON
/*
 *  NavServicesAvailable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Boolean )
NavServicesAvailable(void);


#endif  /* CALL_NOT_IN_CARBON */

#endif  /*  */

/* Carbon API */
/* Includes support for Unicode and long file names (where available). */

enum {
  kNavDialogCreationOptionsVersion = 0
};



/*
 *  NavDialogCreationOptions
 *  
 *  Summary:
 *    Options used to control the appearance and operation of a Nav
 *    Services dialog
 *  
 *  Discussion:
 *    NavDialogCreationOptions is a preferred replacement for
 *    NavDialogOptions. The new structure uses CFStrings in place of
 *    Pascal strings, and adds fields for setting the dialog modality
 *    and the parent window (for sheet dialogs). A
 *    NavDialogCreationOptions structure can be initialized using
 *    NavDialogGetDefaultCreationOptions. Each of the
 *    NavCreateXXXDialog functions accepts a pointer to the client's
 *    NavDialogCreationOptions structure.
 */
struct NavDialogCreationOptions {
  UInt16              version;
  NavDialogOptionFlags  optionFlags;
  Point               location;
  CFStringRef         clientName;
  CFStringRef         windowTitle;
  CFStringRef         actionButtonLabel;
  CFStringRef         cancelButtonLabel;
  CFStringRef         saveFileName;
  CFStringRef         message;
  UInt32              preferenceKey;
  CFArrayRef          popupExtension;
  WindowModality      modality;
  WindowRef           parentWindow;
  char                reserved[16];
};
typedef struct NavDialogCreationOptions NavDialogCreationOptions;
/*
 *  NavGetDefaultDialogCreationOptions()
 *  
 *  Summary:
 *    Initialize the input structure to default values
 *  
 *  Discussion:
 *    Provided as a convenience to obtain the preferred default options
 *    for use in creating any Nav Services dialog.
 *  
 *  Parameters:
 *    
 *    outOptions:
 *      A pointer to the client-allocated options structure to
 *      initialize
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
NavGetDefaultDialogCreationOptions(NavDialogCreationOptions * outOptions);



/*
 *  NavCreateGetFileDialog()
 *  
 *  Summary:
 *    Create a GetFile dialog
 *  
 *  Discussion:
 *    Use this function to create a dialog designed for opening
 *    document files. This function replaces NavGetFile, allowing new
 *    window modalities, and adding Unicode support. Upon successful
 *    creation, the dialog is not visible. Present and run the dialog
 *    with NavDialogRun. After the dialog is complete, dispose of it
 *    with NavDialogDispose.
 *  
 *  Parameters:
 *    
 *    inOptions:
 *      Options controlling the appearance and behavior of the dialog
 *    
 *    inTypeList:
 *      A creator signature and list of file types to show in the
 *      dialog file browser. If NULL, show all files.
 *    
 *    inEventProc:
 *      The UPP for the client's event callack, or NULL for no event
 *      callback
 *    
 *    inPreviewProc:
 *      The UPP for the client's custom file preview callback, or NULL
 *      for standard previews
 *    
 *    inFilterProc:
 *      The UPP for the client's custom filter callback, or NULL for no
 *      custom file filtering
 *    
 *    inClientData:
 *      A client-defined context value passed to all callback functions
 *    
 *    outDialog:
 *      Upon successful completion, a reference to the created dialog
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
NavCreateGetFileDialog(
  const NavDialogCreationOptions *  inOptions,           /* can be NULL */
  NavTypeListHandle                 inTypeList,          /* can be NULL */
  NavEventUPP                       inEventProc,         /* can be NULL */
  NavPreviewUPP                     inPreviewProc,       /* can be NULL */
  NavObjectFilterUPP                inFilterProc,        /* can be NULL */
  void *                            inClientData,        /* can be NULL */
  NavDialogRef *                    outDialog);



/*
 *  NavCreatePutFileDialog()
 *  
 *  Summary:
 *    Create a PutFile dialog
 *  
 *  Discussion:
 *    Use this function to create a dialog designed for setting the
 *    name and location of a document file prior to saving. This
 *    function replaces NavPutFile, allowing new window modalities, and
 *    adding Unicode support. Upon successful creation, the dialog is
 *    not visible. Present and run the dialog with NavDialogRun. After
 *    the dialog is complete, dispose of it with NavDialogDispose.
 *  
 *  Parameters:
 *    
 *    inOptions:
 *      Options controlling the appearance and behavior of the dialog
 *    
 *    inFileType:
 *      The type of the file to be saved. This parameter is used in
 *      conjunction with the inFileCreator parameter to look up the
 *      kind string for the Format popup menu, and to drive the
 *      identification of translation options.
 *    
 *    inFileCreator:
 *      The creator signature of the file to be saved (see inFileType
 *      parameter)
 *    
 *    inEventProc:
 *      The UPP for the client's event callack, or NULL for no event
 *      callback
 *    
 *    inClientData:
 *      A client-defined context value passed to all callback functions
 *    
 *    outDialog:
 *      Upon successful completion, a reference to the created dialog
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
NavCreatePutFileDialog(
  const NavDialogCreationOptions *  inOptions,           /* can be NULL */
  OSType                            inFileType,
  OSType                            inFileCreator,
  NavEventUPP                       inEventProc,         /* can be NULL */
  void *                            inClientData,        /* can be NULL */
  NavDialogRef *                    outDialog);



/*
 *  NavCreateAskSaveChangesDialog()
 *  
 *  Summary:
 *    Create an AskSaveChanges dialog
 *  
 *  Discussion:
 *    Use this function to create dialog which asks the user to save,
 *    don't save or cancel closing a document with unsaved changes.
 *    This function replaces NavAskSaveChanges and
 *    NavCustomAskSaveChanges, allowing new window modalities, and
 *    adding Unicode support. Upon successful creation, the dialog is
 *    not visible. Present and run the dialog with NavDialogRun. After
 *    the dialog is complete, dispose of it with NavDialogDispose. To
 *    provide a customized message for the alert, specify an non-NULL
 *    message value in the options structure.
 *  
 *  Parameters:
 *    
 *    inOptions:
 *      Options controlling the appearance and behavior of the dialog
 *    
 *    inAction:
 *      Indicates this usage context for this dialog: closing a
 *      document or quitting an application. This setting affects the
 *      message text displayed to the user.
 *    
 *    inEventProc:
 *      The UPP for the client's event callack, or NULL for no event
 *      callback
 *    
 *    inClientData:
 *      A client-defined context value passed to all callback functions
 *    
 *    outDialog:
 *      Upon successful completion, a reference to the created dialog
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
NavCreateAskSaveChangesDialog(
  const NavDialogCreationOptions *  inOptions,
  NavAskSaveChangesAction           inAction,
  NavEventUPP                       inEventProc,        /* can be NULL */
  void *                            inClientData,       /* can be NULL */
  NavDialogRef *                    outDialog);



/*
 *  NavCreateAskDiscardChangesDialog()
 *  
 *  Summary:
 *    Create an AskDiscardChanges dialog
 *  
 *  Discussion:
 *    Use this function to create a dialog which asks the user to
 *    discard changes to a document or cancel. This is most often use
 *    when the user wants to revert a a document to the last saved
 *    revision. This function replaces NavAskDiscardChanges, allowing
 *    new window modalities, and adding Unicode support. Upon
 *    successful creation, the dialog is not visible. Present and run
 *    the dialog with NavDialogRun. After the dialog is complete,
 *    dispose of it with NavDialogDispose.
 *  
 *  Parameters:
 *    
 *    inOptions:
 *      Options controlling the appearance and behavior of the dialog
 *    
 *    inEventProc:
 *      The UPP for the client's event callack, or NULL for no event
 *      callback
 *    
 *    inClientData:
 *      A client-defined context value passed to all callback functions
 *    
 *    outDialog:
 *      Upon successful completion, a reference to the created dialog
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
NavCreateAskDiscardChangesDialog(
  const NavDialogCreationOptions *  inOptions,
  NavEventUPP                       inEventProc,        /* can be NULL */
  void *                            inClientData,       /* can be NULL */
  NavDialogRef *                    outDialog);



/*
 *  NavCreateChooseFileDialog()
 *  
 *  Summary:
 *    Create a ChooseFile dialog
 *  
 *  Discussion:
 *    Use this function to create a dialog designed for selecting one
 *    file as the target of an operation. A ChooseFile dialog is a
 *    simple version a GetFile dialog. This function replaces
 *    NavChooseFile, allowing new window modalities, and adding Unicode
 *    support. Upon successful creation, the dialog is not visible.
 *    Present and run the dialog with NavDialogRun. After the dialog is
 *    complete, dispose of it with NavDialogDispose.
 *  
 *  Parameters:
 *    
 *    inOptions:
 *      Options controlling the appearance and behavior of the dialog
 *    
 *    inTypeList:
 *      A creator signature and list of file types to show in the
 *      dialog file browser. If NULL, show all files.
 *    
 *    inEventProc:
 *      The UPP for the client's event callack, or NULL for no event
 *      callback
 *    
 *    inPreviewProc:
 *      The UPP for the client's custom file preview callback, or NULL
 *      for standard previews
 *    
 *    inFilterProc:
 *      The UPP for the client's custom filter callback, or NULL for no
 *      custom file filtering
 *    
 *    inClientData:
 *      A client-defined context value passed to all callback functions
 *    
 *    outDialog:
 *      Upon successful completion, a reference to the created dialog
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
NavCreateChooseFileDialog(
  const NavDialogCreationOptions *  inOptions,           /* can be NULL */
  NavTypeListHandle                 inTypeList,          /* can be NULL */
  NavEventUPP                       inEventProc,         /* can be NULL */
  NavPreviewUPP                     inPreviewProc,       /* can be NULL */
  NavObjectFilterUPP                inFilterProc,        /* can be NULL */
  void *                            inClientData,        /* can be NULL */
  NavDialogRef *                    outDialog);



/*
 *  NavCreateChooseFolderDialog()
 *  
 *  Summary:
 *    Create a ChooseFolder dialog
 *  
 *  Discussion:
 *    Use this function to create a dialog designed for selecting a
 *    folder as the target of an operation. This function replaces
 *    NavChooseFolder, allowing new window modalities, and adding
 *    Unicode support. Upon successful creation, the dialog is not
 *    visible. Present and run the dialog with NavDialogRun. After the
 *    dialog is complete, dispose of it with NavDialogDispose.
 *  
 *  Parameters:
 *    
 *    inOptions:
 *      Options controlling the appearance and behavior of the dialog
 *    
 *    inEventProc:
 *      The UPP for the client's event callack, or NULL for no event
 *      callback
 *    
 *    inFilterProc:
 *      The UPP for the client's custom filter callback, or NULL for no
 *      custom file filtering
 *    
 *    inClientData:
 *      A client-defined context value passed to all callback functions
 *    
 *    outDialog:
 *      Upon successful completion, a reference to the created dialog
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
NavCreateChooseFolderDialog(
  const NavDialogCreationOptions *  inOptions,          /* can be NULL */
  NavEventUPP                       inEventProc,        /* can be NULL */
  NavObjectFilterUPP                inFilterProc,       /* can be NULL */
  void *                            inClientData,       /* can be NULL */
  NavDialogRef *                    outDialog);



/*
 *  NavCreateChooseVolumeDialog()
 *  
 *  Summary:
 *    Create a ChooseVolume dialog
 *  
 *  Discussion:
 *    Use this function to create a dialog designed for selecting a
 *    volume as the target of an operation. This function replaces
 *    NavChooseVolume, allowing new window modalities, and adding
 *    Unicode support. Upon successful creation, the dialog is not
 *    visible. Present and run the dialog with NavDialogRun. After the
 *    dialog is complete, dispose of it with NavDialogDispose.
 *  
 *  Parameters:
 *    
 *    inOptions:
 *      Options controlling the appearance and behavior of the dialog
 *    
 *    inEventProc:
 *      The UPP for the client's event callack, or NULL for no event
 *      callback
 *    
 *    inFilterProc:
 *      The UPP for the client's custom filter callback, or NULL for no
 *      custom file filtering
 *    
 *    inClientData:
 *      A client-defined context value passed to all callback functions
 *    
 *    outDialog:
 *      Upon successful completion, a reference to the created dialog
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
NavCreateChooseVolumeDialog(
  const NavDialogCreationOptions *  inOptions,          /* can be NULL */
  NavEventUPP                       inEventProc,        /* can be NULL */
  NavObjectFilterUPP                inFilterProc,       /* can be NULL */
  void *                            inClientData,       /* can be NULL */
  NavDialogRef *                    outDialog);



/*
 *  NavCreateChooseObjectDialog()
 *  
 *  Summary:
 *    Create a ChooseObject dialog
 *  
 *  Discussion:
 *    Use this function to create a dialog designed for selecting a
 *    file, folder, or volume as the target of an operation. This
 *    function replaces NavChooseObject, allowing new window
 *    modalities, and adding Unicode support. Upon successful creation,
 *    the dialog is not visible. Present and run the dialog with
 *    NavDialogRun. After the dialog is complete, dispose of it with
 *    NavDialogDispose.
 *  
 *  Parameters:
 *    
 *    inOptions:
 *      Options controlling the appearance and behavior of the dialog
 *    
 *    inEventProc:
 *      The UPP for the client's event callack, or NULL for no event
 *      callback
 *    
 *    inPreviewProc:
 *      The UPP for the client's custom file preview callback, or NULL
 *      for standard previews
 *    
 *    inFilterProc:
 *      The UPP for the client's custom filter callback, or NULL for no
 *      custom file filtering
 *    
 *    inClientData:
 *      A client-defined context value passed to all callback functions
 *    
 *    outDialog:
 *      Upon successful completion, a reference to the created dialog
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
NavCreateChooseObjectDialog(
  const NavDialogCreationOptions *  inOptions,           /* can be NULL */
  NavEventUPP                       inEventProc,         /* can be NULL */
  NavPreviewUPP                     inPreviewProc,       /* can be NULL */
  NavObjectFilterUPP                inFilterProc,        /* can be NULL */
  void *                            inClientData,        /* can be NULL */
  NavDialogRef *                    outDialog);



/*
 *  NavCreateNewFolderDialog()
 *  
 *  Summary:
 *    Create a NewFolder dialog
 *  
 *  Discussion:
 *    Use this function to create a dialog designed for creating a new
 *    folder. Nav Services creates the folder as specified by the user
 *    and returns a reference to the folder in the selection field of
 *    the reply record. This function replaces NavNewFolder, allowing
 *    new window modalities, and adding Unicode support. Upon
 *    successful creation, the dialog is not visible. Present and run
 *    the dialog with NavDialogRun. After the dialog is complete,
 *    dispose of it with NavDialogDispose.
 *  
 *  Parameters:
 *    
 *    inOptions:
 *      Options controlling the appearance and behavior of the dialog
 *    
 *    inEventProc:
 *      The UPP for the client's event callack, or NULL for no event
 *      callback
 *    
 *    inClientData:
 *      A client-defined context value passed to all callback functions
 *    
 *    outDialog:
 *      Upon successful completion, a reference to the created dialog
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
NavCreateNewFolderDialog(
  const NavDialogCreationOptions *  inOptions,          /* can be NULL */
  NavEventUPP                       inEventProc,        /* can be NULL */
  void *                            inClientData,       /* can be NULL */
  NavDialogRef *                    outDialog);



/*
 *  NavDialogRun()
 *  
 *  Summary:
 *    Show and run a Nav Services dialog
 *  
 *  Discussion:
 *    After a dialog is created with a NavCreateXXXDialog function, the
 *    client can modify the dialog target folder or save file name
 *    using NavCustomControl with the appropriate selectors. The dialog
 *    is finally presented to the user by calling NavDialogRun. If the
 *    dialog is system modal or application modal
 *    (kWindowModalitySystemModal, kWindowModalityAppModal),
 *    NavDialogRun does not return until the dialog has been dismissed.
 *    If the dialog is modeless or window modal (kWindowModalityNone,
 *    kWindowModalityWindowModal), NavDialogRun shows the dialog and
 *    returns immediately. In order to know when the dialog has been
 *    dismissed, the client must watch for the kNavCBUserAction event
 *    sent to the client event proc. Note that on Mac OS 9 and earlier,
 *    all dialogs are modal, even if a modeless or window modal dialog
 *    is requested. However, the kNavCBUserAction event is still sent
 *    to the event proc, so it's possible to use a single programming
 *    model on OS 9 and OS X provided the client assumes NavDialogRun
 *    returns immediately after showing the dialog.
 *  
 *  Parameters:
 *    
 *    inDialog:
 *      The dialog to run
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
NavDialogRun(NavDialogRef inDialog);



/*
 *  NavDialogDispose()
 *  
 *  Summary:
 *    Dispose of a Nav Services dialog
 *  
 *  Discussion:
 *    Call this function when completely finished with a Nav Services
 *    dialog. After calling NavDialogDispose, the dialog reference is
 *    no longer valid.
 *  
 *  Parameters:
 *    
 *    inDialog:
 *      The dialog to dispose
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
NavDialogDispose(NavDialogRef inDialog);



/*
 *  NavDialogGetWindow()
 *  
 *  Summary:
 *    Return the window in which a Nav Services dialog appears
 *  
 *  Discussion:
 *    Note that a valid NavDialogRef may not have a window until
 *    NavDialogRun has been called. If no window exists for the dialog,
 *    NavDialogGetWindow returns NULL.
 *  
 *  Parameters:
 *    
 *    inDialog:
 *      Which dialog
 *  
 *  Result:
 *    The window reference
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( WindowRef )
NavDialogGetWindow(NavDialogRef inDialog);



/*
 *  NavDialogGetUserAction()
 *  
 *  Summary:
 *    Return the user action taken to dismiss a Nav Services dialog
 *  
 *  Discussion:
 *    The user action indicates which button was used to dismiss the
 *    dialog. If a dialog has not been dismissed,
 *    NavDialogGetUserAction returns kNavUserActionNone. If the dialog
 *    is terminated using the kNavCtlTerminate NavCustomControl
 *    selector, the final user action is kNavUserActionNone. For file
 *    dialogs, if the final user action is not kNavUserActionCancel,
 *    then there is a valid reply record which can be obtained with
 *    NavDialogGetReply. Although the user action is sent to the client
 *    event proc as a kNavCBUserAction event, this function is provided
 *    as a convenience for clients of modal dialogs who may find it
 *    easier to get the user action immediately after returning from
 *    NavDialogRun.
 *  
 *  Parameters:
 *    
 *    inDialog:
 *      Which dialog
 *  
 *  Result:
 *    The user action
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( NavUserAction )
NavDialogGetUserAction(NavDialogRef inDialog);



/*
 *  NavDialogGetReply()
 *  
 *  Summary:
 *    Fill in the provided reply record with the results of the
 *    dismissed dialog.
 *  
 *  Discussion:
 *    Call this function when a file dialog receives a user action
 *    other than kNavUserActionCancel. Upon successful completion, the
 *    reply record contains the results of the dialog session. The
 *    reply record should later be disposed of with NavDisposeReply.
 *  
 *  Parameters:
 *    
 *    inDialog:
 *      Which dialog
 *    
 *    outReply:
 *      A pointer to the client-allocated reply record to be filled in
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
NavDialogGetReply(
  NavDialogRef      inDialog,
  NavReplyRecord *  outReply);



/*
 *  NavDialogGetSaveFileName()
 *  
 *  Summary:
 *    Return the current value of the file name edit text field in a
 *    PutFile dialog
 *  
 *  Discussion:
 *    This function can be called at any time on a valid PutFile dialog
 *    to obtain the current value of the save file name. This function
 *    is a Unicode-based replacement for the kNavCtlGetEditFileName
 *    NavCustomControl selector.
 *  
 *  Parameters:
 *    
 *    inPutFileDialog:
 *      Which dialog
 *  
 *  Result:
 *    The save file name as a CFStringRef. The string is immutable. The
 *    client should retain the string if the reference is to be held
 *    beyond the life of the dialog (standard CF retain/release
 *    semantics).
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
NavDialogGetSaveFileName(NavDialogRef inPutFileDialog);



/*
 *  NavDialogSetSaveFileName()
 *  
 *  Summary:
 *    Set the current value of the file name edit text field in a
 *    PutFile dialog
 *  
 *  Discussion:
 *    This function can be called at any time to set the current save
 *    file name. Use it to set an initial name before calling
 *    NavDialogRun or to change the file name dynamically while a
 *    dialog is running. This function is a Unicode-based replacement
 *    for the kNavCtlSetEditFileName NavCustomControl selector.
 *  
 *  Parameters:
 *    
 *    inPutFileDialog:
 *      Which PutFile dialog
 *    
 *    inFileName:
 *      The file name to use
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
NavDialogSetSaveFileName(
  NavDialogRef   inPutFileDialog,
  CFStringRef    inFileName);




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

#endif /* __NAVIGATION__ */

