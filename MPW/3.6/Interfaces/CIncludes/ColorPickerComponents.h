/*
     File:       ColorPickerComponents.h
 
     Contains:   Color Picker Component Interfaces.
 
     Version:    Technology: Mac OS 8.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __COLORPICKERCOMPONENTS__
#define __COLORPICKERCOMPONENTS__

#ifndef __COLORPICKER__
#include <ColorPicker.h>
#endif

#ifndef __COMPONENTS__
#include <Components.h>
#endif

#ifndef __MIXEDMODE__
#include <MixedMode.h>
#endif

#ifndef __BALLOONS__
#include <Balloons.h>
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

enum {
  kPickerComponentType          = FOUR_CHAR_CODE('cpkr')
};

enum {
  kPickerInit                   = 0,
  kPickerTestGraphicsWorld      = 1,
  kPickerGetDialog              = 2,
  kPickerGetItemList            = 3,
  kPickerGetColor               = 4,
  kPickerSetColor               = 5,
  kPickerEvent                  = 6,
  kPickerEdit                   = 7,
  kPickerSetVisibility          = 8,
  kPickerDisplay                = 9,
  kPickerItemHit                = 10,
  kPickerSetBaseItem            = 11,
  kPickerGetProfile             = 12,
  kPickerSetProfile             = 13,
  kPickerGetPrompt              = 14,
  kPickerSetPrompt              = 15,
  kPickerGetIconData            = 16,
  kPickerGetEditMenuState       = 17,
  kPickerSetOrigin              = 18,
  kPickerExtractHelpItem        = 19,
  kPickerSetColorChangedProc    = 20,
  kNPickerGetColor              = 21,
  kNPickerSetColor              = 22,
  kNPickerGetProfile            = 23,
  kNPickerSetProfile            = 24,
  kNPickerSetColorChangedProc   = 25
};

/* These structs were moved here from the ColorPicker header.*/
typedef SInt16 PickerAction;
enum {
  kPickerDidNothing             = 0,    /* was kDidNothing */
  kPickerColorChanged           = 1,    /* was kColorChanged */
  kPickerOkHit                  = 2,    /* was kOkHit */
  kPickerCancelHit              = 3,    /* was kCancelHit */
  kPickerNewPickerChosen        = 4,    /* was kNewPickerChosen */
  kPickerApplItemHit            = 5     /* was kApplItemHit */
};

typedef SInt16 PickerColorType;
enum {
  kOriginalColor                = 0,
  kNewColor                     = 1
};

typedef SInt16 PickerEditOperation;
enum {
  kPickerCut                    = 0,    /* was kCut */
  kPickerCopy                   = 1,    /* was kCopy */
  kPickerPaste                  = 2,    /* was kPaste */
  kPickerClear                  = 3,    /* was kClear */
  kPickerUndo                   = 4     /* was kUndo */
};

typedef SInt16 PickerItemModifier;
enum {
  kPickerMouseDown              = 0,    /* was kMouseDown */
  kPickerKeyDown                = 1,    /* was kKeyDown */
  kPickerFieldEntered           = 2,    /* was kFieldEntered */
  kPickerFieldLeft              = 3,    /* was kFieldLeft */
  kPickerCutOp                  = 4,    /* was kCutOp */
  kPickerCopyOp                 = 5,    /* was kCopyOp */
  kPickerPasteOp                = 6,    /* was kPasteOp */
  kPickerClearOp                = 7,    /* was kClearOp */
  kPickerUndoOp                 = 8     /* was kUndoOp */
};

/* These are for the flags field in the picker's 'thng' resource. */
enum {
  kPickerCanDoColor             = 1,    /* was CanDoColor */
  kPickerCanDoBlackWhite        = 2,    /* was CanDoBlackWhite */
  kPickerAlwaysModifiesPalette  = 4,    /* was AlwaysModifiesPalette */
  kPickerMayModifyPalette       = 8,    /* was MayModifyPalette */
  kPickerIsColorSyncAware       = 16,   /* was PickerIsColorSyncAware */
  kPickerCanDoSystemDialog      = 32,   /* was CanDoSystemDialog */
  kPickerCanDoApplDialog        = 64,   /* was CanDoApplDialog */
  kPickerHasOwnDialog           = 128,  /* was HasOwnDialog */
  kPickerCanDetach              = 256,  /* was CanDetach */
  kPickerIsColorSync2Aware      = 512   /* was PickerIsColorSync2Aware */
};

typedef SInt16 PickerEventForcaster;
enum {
  kPickerNoForcast              = 0,    /* was kNoForcast */
  kPickerMenuChoice             = 1,    /* was kMenuChoice */
  kPickerDialogAccept           = 2,    /* was kDialogAccept */
  kPickerDialogCancel           = 3,    /* was kDialogCancel */
  kPickerLeaveFocus             = 4,    /* was kLeaveFocus */
  kPickerSwitch                 = 5,
  kPickerNormalKeyDown          = 6,    /* was kNormalKeyDown */
  kPickerNormalMouseDown        = 7     /* was kNormalMouseDown */
};

struct PickerIconData {
  short               scriptCode;
  short               iconSuiteID;
  ResType             helpResType;
  short               helpResID;
};
typedef struct PickerIconData           PickerIconData;
struct PickerInitData {
  DialogRef           pickerDialog;
  DialogRef           choicesDialog;
  long                flags;
  Picker              yourself;
};
typedef struct PickerInitData           PickerInitData;
struct PickerMenuState {
  Boolean             cutEnabled;
  Boolean             copyEnabled;
  Boolean             pasteEnabled;
  Boolean             clearEnabled;
  Boolean             undoEnabled;
  SInt8               filler;
  Str255              undoString;
};
typedef struct PickerMenuState          PickerMenuState;
struct SystemDialogInfo {
  long                flags;
  long                pickerType;
  DialogPlacementSpec  placeWhere;
  Point               dialogOrigin;
  PickerMenuItemInfo  mInfo;
};
typedef struct SystemDialogInfo         SystemDialogInfo;
struct PickerDialogInfo {
  long                flags;
  long                pickerType;
  Point *             dialogOrigin;
  PickerMenuItemInfo  mInfo;
};
typedef struct PickerDialogInfo         PickerDialogInfo;
struct ApplicationDialogInfo {
  long                flags;
  long                pickerType;
  DialogRef           theDialog;
  Point               pickerOrigin;
  PickerMenuItemInfo  mInfo;
};
typedef struct ApplicationDialogInfo    ApplicationDialogInfo;
struct PickerEventData {
  EventRecord *       event;
  PickerAction        action;
  short               itemHit;
  Boolean             handled;
  SInt8               filler;
  ColorChangedUPP     colorProc;
  long                colorProcData;
  PickerEventForcaster  forcast;
};
typedef struct PickerEventData          PickerEventData;
struct PickerEditData {
  PickerEditOperation  theEdit;
  PickerAction        action;
  Boolean             handled;
  SInt8               filler;
};
typedef struct PickerEditData           PickerEditData;
struct PickerItemHitData {
  short               itemHit;
  PickerItemModifier  iMod;
  PickerAction        action;
  ColorChangedUPP     colorProc;
  long                colorProcData;
  Point               where;
};
typedef struct PickerItemHitData        PickerItemHitData;
struct PickerHelpItemInfo {
  long                options;
  Point               tip;
  Rect                altRect;
  short               theProc;
  short               helpVariant;
  HMMessageRecord     helpMessage;
};
typedef struct PickerHelpItemInfo       PickerHelpItemInfo;
#if OLDROUTINENAMES
enum {
  kInitPicker                   = kPickerInit,
  kTestGraphicsWorld            = kPickerTestGraphicsWorld,
  kGetDialog                    = kPickerGetDialog,
  kGetItemList                  = kPickerGetItemList,
  kGetColor                     = kPickerGetColor,
  kSetColor                     = kPickerSetColor,
  kEvent                        = kPickerEvent,
  kEdit                         = kPickerEdit,
  kSetVisibility                = kPickerSetVisibility,
  kDrawPicker                   = kPickerDisplay,
  kItemHit                      = kPickerItemHit,
  kSetBaseItem                  = kPickerSetBaseItem,
  kGetProfile                   = kPickerGetProfile,
  kSetProfile                   = kPickerSetProfile,
  kGetPrompt                    = kPickerGetPrompt,
  kSetPrompt                    = kPickerSetPrompt,
  kGetIconData                  = kPickerGetIconData,
  kGetEditMenuState             = kPickerGetEditMenuState,
  kSetOrigin                    = kPickerSetOrigin,
  kExtractHelpItem              = kPickerExtractHelpItem
};

enum {
  kDidNothing                   = kPickerDidNothing,
  kColorChanged                 = kPickerColorChanged,
  kOkHit                        = kPickerOkHit,
  kCancelHit                    = kPickerCancelHit,
  kNewPickerChosen              = kPickerNewPickerChosen,
  kApplItemHit                  = kPickerApplItemHit
};

enum {
  kCut                          = kPickerCut,
  kCopy                         = kPickerCopy,
  kPaste                        = kPickerPaste,
  kClear                        = kPickerClear,
  kUndo                         = kPickerUndo
};

enum {
  kMouseDown                    = kPickerMouseDown,
  kKeyDown                      = kPickerKeyDown,
  kFieldEntered                 = kPickerFieldEntered,
  kFieldLeft                    = kPickerFieldLeft,
  kCutOp                        = kPickerCutOp,
  kCopyOp                       = kPickerCopyOp,
  kPasteOp                      = kPickerPasteOp,
  kClearOp                      = kPickerClearOp,
  kUndoOp                       = kPickerUndoOp
};

enum {
  kNoForcast                    = kPickerNoForcast,
  kMenuChoice                   = kPickerMenuChoice,
  kDialogAccept                 = kPickerDialogAccept,
  kDialogCancel                 = kPickerDialogCancel,
  kLeaveFocus                   = kPickerLeaveFocus,
  kNormalKeyDown                = kPickerNormalKeyDown,
  kNormalMouseDown              = kPickerNormalMouseDown
};


typedef short                           ColorType;
typedef short                           EditOperation;
typedef short                           ItemModifier;
typedef short                           EventForcaster;
struct EventData {
  EventRecord *       event;
  PickerAction        action;
  short               itemHit;
  Boolean             handled;
  SInt8               filler;
  ColorChangedUPP     colorProc;
  long                colorProcData;
  EventForcaster      forcast;
};
typedef struct EventData                EventData;
struct EditData {
  EditOperation       theEdit;
  PickerAction        action;
  Boolean             handled;
  SInt8               filler;
};
typedef struct EditData                 EditData;
struct ItemHitData {
  short               itemHit;
  ItemModifier        iMod;
  PickerAction        action;
  ColorChangedUPP     colorProc;
  long                colorProcData;
  Point               where;
};
typedef struct ItemHitData              ItemHitData;
struct HelpItemInfo {
  long                options;
  Point               tip;
  Rect                altRect;
  short               theProc;
  short               helpVariant;
  HMMessageRecord     helpMessage;
};
typedef struct HelpItemInfo             HelpItemInfo;
#endif  /* OLDROUTINENAMES */

typedef CALLBACK_API( ComponentResult , PickerOpenProcPtr )(long storage, ComponentInstance self);
typedef CALLBACK_API( ComponentResult , PickerCloseProcPtr )(long storage, ComponentInstance self);
typedef CALLBACK_API( ComponentResult , PickerCanDoProcPtr )(long storage, short selector);
typedef CALLBACK_API( ComponentResult , PickerVersionProcPtr )(long storage);
typedef CALLBACK_API( ComponentResult , PickerRegisterProcPtr )(long storage);
typedef CALLBACK_API( ComponentResult , PickerSetTargetProcPtr )(long storage, ComponentInstance topOfCallChain);
typedef STACK_UPP_TYPE(PickerOpenProcPtr)                       PickerOpenUPP;
typedef STACK_UPP_TYPE(PickerCloseProcPtr)                      PickerCloseUPP;
typedef STACK_UPP_TYPE(PickerCanDoProcPtr)                      PickerCanDoUPP;
typedef STACK_UPP_TYPE(PickerVersionProcPtr)                    PickerVersionUPP;
typedef STACK_UPP_TYPE(PickerRegisterProcPtr)                   PickerRegisterUPP;
typedef STACK_UPP_TYPE(PickerSetTargetProcPtr)                  PickerSetTargetUPP;
#if CALL_NOT_IN_CARBON
/*
 *  PickerInit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
PickerInit(
  long              storage,
  PickerInitData *  data)                                     FIVEWORDINLINE(0x2F3C, 0x0004, 0x0000, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , PickerInitProcPtr )(long storage, PickerInitData *data);
#if CALL_NOT_IN_CARBON
/*
 *  PickerTestGraphicsWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
PickerTestGraphicsWorld(
  long              storage,
  PickerInitData *  data)                                     FIVEWORDINLINE(0x2F3C, 0x0004, 0x0001, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , PickerTestGraphicsWorldProcPtr )(long storage, PickerInitData *data);
#if CALL_NOT_IN_CARBON
/*
 *  PickerGetDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
PickerGetDialog(long storage)                                 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0002, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , PickerGetDialogProcPtr )(long storage);
#if CALL_NOT_IN_CARBON
/*
 *  PickerGetItemList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
PickerGetItemList(long storage)                               FIVEWORDINLINE(0x2F3C, 0x0000, 0x0003, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , PickerGetItemListProcPtr )(long storage);
#if CALL_NOT_IN_CARBON
/*
 *  PickerGetColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
PickerGetColor(
  long              storage,
  PickerColorType   whichColor,
  PMColorPtr        color)                                    FIVEWORDINLINE(0x2F3C, 0x0006, 0x0004, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , PickerGetColorProcPtr )(long storage, PickerColorType whichColor, PMColorPtr color);
typedef STACK_UPP_TYPE(PickerInitProcPtr)                       PickerInitUPP;
typedef STACK_UPP_TYPE(PickerTestGraphicsWorldProcPtr)          PickerTestGraphicsWorldUPP;
typedef STACK_UPP_TYPE(PickerGetDialogProcPtr)                  PickerGetDialogUPP;
typedef STACK_UPP_TYPE(PickerGetItemListProcPtr)                PickerGetItemListUPP;
typedef STACK_UPP_TYPE(PickerGetColorProcPtr)                   PickerGetColorUPP;
#if CALL_NOT_IN_CARBON
/*
 *  NewPickerOpenUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerOpenUPP )
NewPickerOpenUPP(PickerOpenProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerOpenProcInfo = 0x000003F0 };  /* pascal 4_bytes Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline PickerOpenUPP NewPickerOpenUPP(PickerOpenProcPtr userRoutine) { return (PickerOpenUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerOpenProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerOpenUPP(userRoutine) (PickerOpenUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerOpenProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerCloseUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerCloseUPP )
NewPickerCloseUPP(PickerCloseProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerCloseProcInfo = 0x000003F0 };  /* pascal 4_bytes Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline PickerCloseUPP NewPickerCloseUPP(PickerCloseProcPtr userRoutine) { return (PickerCloseUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerCloseProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerCloseUPP(userRoutine) (PickerCloseUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerCloseProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerCanDoUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerCanDoUPP )
NewPickerCanDoUPP(PickerCanDoProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerCanDoProcInfo = 0x000002F0 };  /* pascal 4_bytes Func(4_bytes, 2_bytes) */
  #ifdef __cplusplus
    inline PickerCanDoUPP NewPickerCanDoUPP(PickerCanDoProcPtr userRoutine) { return (PickerCanDoUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerCanDoProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerCanDoUPP(userRoutine) (PickerCanDoUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerCanDoProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerVersionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerVersionUPP )
NewPickerVersionUPP(PickerVersionProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerVersionProcInfo = 0x000000F0 };  /* pascal 4_bytes Func(4_bytes) */
  #ifdef __cplusplus
    inline PickerVersionUPP NewPickerVersionUPP(PickerVersionProcPtr userRoutine) { return (PickerVersionUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerVersionProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerVersionUPP(userRoutine) (PickerVersionUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerVersionProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerRegisterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerRegisterUPP )
NewPickerRegisterUPP(PickerRegisterProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerRegisterProcInfo = 0x000000F0 };  /* pascal 4_bytes Func(4_bytes) */
  #ifdef __cplusplus
    inline PickerRegisterUPP NewPickerRegisterUPP(PickerRegisterProcPtr userRoutine) { return (PickerRegisterUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerRegisterProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerRegisterUPP(userRoutine) (PickerRegisterUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerRegisterProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerSetTargetUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerSetTargetUPP )
NewPickerSetTargetUPP(PickerSetTargetProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerSetTargetProcInfo = 0x000003F0 };  /* pascal 4_bytes Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline PickerSetTargetUPP NewPickerSetTargetUPP(PickerSetTargetProcPtr userRoutine) { return (PickerSetTargetUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerSetTargetProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerSetTargetUPP(userRoutine) (PickerSetTargetUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerSetTargetProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerInitUPP )
NewPickerInitUPP(PickerInitProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerInitProcInfo = 0x000003F0 };  /* pascal 4_bytes Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline PickerInitUPP NewPickerInitUPP(PickerInitProcPtr userRoutine) { return (PickerInitUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerInitProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerInitUPP(userRoutine) (PickerInitUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerInitProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerTestGraphicsWorldUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerTestGraphicsWorldUPP )
NewPickerTestGraphicsWorldUPP(PickerTestGraphicsWorldProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerTestGraphicsWorldProcInfo = 0x000003F0 };  /* pascal 4_bytes Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline PickerTestGraphicsWorldUPP NewPickerTestGraphicsWorldUPP(PickerTestGraphicsWorldProcPtr userRoutine) { return (PickerTestGraphicsWorldUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerTestGraphicsWorldProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerTestGraphicsWorldUPP(userRoutine) (PickerTestGraphicsWorldUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerTestGraphicsWorldProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerGetDialogUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerGetDialogUPP )
NewPickerGetDialogUPP(PickerGetDialogProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerGetDialogProcInfo = 0x000000F0 };  /* pascal 4_bytes Func(4_bytes) */
  #ifdef __cplusplus
    inline PickerGetDialogUPP NewPickerGetDialogUPP(PickerGetDialogProcPtr userRoutine) { return (PickerGetDialogUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerGetDialogProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerGetDialogUPP(userRoutine) (PickerGetDialogUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerGetDialogProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerGetItemListUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerGetItemListUPP )
NewPickerGetItemListUPP(PickerGetItemListProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerGetItemListProcInfo = 0x000000F0 };  /* pascal 4_bytes Func(4_bytes) */
  #ifdef __cplusplus
    inline PickerGetItemListUPP NewPickerGetItemListUPP(PickerGetItemListProcPtr userRoutine) { return (PickerGetItemListUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerGetItemListProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerGetItemListUPP(userRoutine) (PickerGetItemListUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerGetItemListProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerGetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerGetColorUPP )
NewPickerGetColorUPP(PickerGetColorProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerGetColorProcInfo = 0x00000EF0 };  /* pascal 4_bytes Func(4_bytes, 2_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline PickerGetColorUPP NewPickerGetColorUPP(PickerGetColorProcPtr userRoutine) { return (PickerGetColorUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerGetColorProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerGetColorUPP(userRoutine) (PickerGetColorUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerGetColorProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  DisposePickerOpenUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerOpenUPP(PickerOpenUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerOpenUPP(PickerOpenUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerOpenUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerCloseUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerCloseUPP(PickerCloseUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerCloseUPP(PickerCloseUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerCloseUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerCanDoUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerCanDoUPP(PickerCanDoUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerCanDoUPP(PickerCanDoUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerCanDoUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerVersionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerVersionUPP(PickerVersionUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerVersionUPP(PickerVersionUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerVersionUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerRegisterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerRegisterUPP(PickerRegisterUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerRegisterUPP(PickerRegisterUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerRegisterUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerSetTargetUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerSetTargetUPP(PickerSetTargetUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerSetTargetUPP(PickerSetTargetUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerSetTargetUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerInitUPP(PickerInitUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerInitUPP(PickerInitUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerInitUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerTestGraphicsWorldUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerTestGraphicsWorldUPP(PickerTestGraphicsWorldUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerTestGraphicsWorldUPP(PickerTestGraphicsWorldUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerTestGraphicsWorldUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerGetDialogUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerGetDialogUPP(PickerGetDialogUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerGetDialogUPP(PickerGetDialogUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerGetDialogUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerGetItemListUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerGetItemListUPP(PickerGetItemListUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerGetItemListUPP(PickerGetItemListUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerGetItemListUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerGetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerGetColorUPP(PickerGetColorUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerGetColorUPP(PickerGetColorUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerGetColorUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  InvokePickerOpenUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerOpenUPP(
  long               storage,
  ComponentInstance  self,
  PickerOpenUPP      userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerOpenUPP(long storage, ComponentInstance self, PickerOpenUPP userUPP) { return (ComponentResult)CALL_TWO_PARAMETER_UPP(userUPP, uppPickerOpenProcInfo, storage, self); }
  #else
    #define InvokePickerOpenUPP(storage, self, userUPP) (ComponentResult)CALL_TWO_PARAMETER_UPP((userUPP), uppPickerOpenProcInfo, (storage), (self))
  #endif
#endif

/*
 *  InvokePickerCloseUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerCloseUPP(
  long               storage,
  ComponentInstance  self,
  PickerCloseUPP     userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerCloseUPP(long storage, ComponentInstance self, PickerCloseUPP userUPP) { return (ComponentResult)CALL_TWO_PARAMETER_UPP(userUPP, uppPickerCloseProcInfo, storage, self); }
  #else
    #define InvokePickerCloseUPP(storage, self, userUPP) (ComponentResult)CALL_TWO_PARAMETER_UPP((userUPP), uppPickerCloseProcInfo, (storage), (self))
  #endif
#endif

/*
 *  InvokePickerCanDoUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerCanDoUPP(
  long            storage,
  short           selector,
  PickerCanDoUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerCanDoUPP(long storage, short selector, PickerCanDoUPP userUPP) { return (ComponentResult)CALL_TWO_PARAMETER_UPP(userUPP, uppPickerCanDoProcInfo, storage, selector); }
  #else
    #define InvokePickerCanDoUPP(storage, selector, userUPP) (ComponentResult)CALL_TWO_PARAMETER_UPP((userUPP), uppPickerCanDoProcInfo, (storage), (selector))
  #endif
#endif

/*
 *  InvokePickerVersionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerVersionUPP(
  long              storage,
  PickerVersionUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerVersionUPP(long storage, PickerVersionUPP userUPP) { return (ComponentResult)CALL_ONE_PARAMETER_UPP(userUPP, uppPickerVersionProcInfo, storage); }
  #else
    #define InvokePickerVersionUPP(storage, userUPP) (ComponentResult)CALL_ONE_PARAMETER_UPP((userUPP), uppPickerVersionProcInfo, (storage))
  #endif
#endif

/*
 *  InvokePickerRegisterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerRegisterUPP(
  long               storage,
  PickerRegisterUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerRegisterUPP(long storage, PickerRegisterUPP userUPP) { return (ComponentResult)CALL_ONE_PARAMETER_UPP(userUPP, uppPickerRegisterProcInfo, storage); }
  #else
    #define InvokePickerRegisterUPP(storage, userUPP) (ComponentResult)CALL_ONE_PARAMETER_UPP((userUPP), uppPickerRegisterProcInfo, (storage))
  #endif
#endif

/*
 *  InvokePickerSetTargetUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerSetTargetUPP(
  long                storage,
  ComponentInstance   topOfCallChain,
  PickerSetTargetUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerSetTargetUPP(long storage, ComponentInstance topOfCallChain, PickerSetTargetUPP userUPP) { return (ComponentResult)CALL_TWO_PARAMETER_UPP(userUPP, uppPickerSetTargetProcInfo, storage, topOfCallChain); }
  #else
    #define InvokePickerSetTargetUPP(storage, topOfCallChain, userUPP) (ComponentResult)CALL_TWO_PARAMETER_UPP((userUPP), uppPickerSetTargetProcInfo, (storage), (topOfCallChain))
  #endif
#endif

/*
 *  InvokePickerInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerInitUPP(
  long              storage,
  PickerInitData *  data,
  PickerInitUPP     userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerInitUPP(long storage, PickerInitData * data, PickerInitUPP userUPP) { return (ComponentResult)CALL_TWO_PARAMETER_UPP(userUPP, uppPickerInitProcInfo, storage, data); }
  #else
    #define InvokePickerInitUPP(storage, data, userUPP) (ComponentResult)CALL_TWO_PARAMETER_UPP((userUPP), uppPickerInitProcInfo, (storage), (data))
  #endif
#endif

/*
 *  InvokePickerTestGraphicsWorldUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerTestGraphicsWorldUPP(
  long                        storage,
  PickerInitData *            data,
  PickerTestGraphicsWorldUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerTestGraphicsWorldUPP(long storage, PickerInitData * data, PickerTestGraphicsWorldUPP userUPP) { return (ComponentResult)CALL_TWO_PARAMETER_UPP(userUPP, uppPickerTestGraphicsWorldProcInfo, storage, data); }
  #else
    #define InvokePickerTestGraphicsWorldUPP(storage, data, userUPP) (ComponentResult)CALL_TWO_PARAMETER_UPP((userUPP), uppPickerTestGraphicsWorldProcInfo, (storage), (data))
  #endif
#endif

/*
 *  InvokePickerGetDialogUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerGetDialogUPP(
  long                storage,
  PickerGetDialogUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerGetDialogUPP(long storage, PickerGetDialogUPP userUPP) { return (ComponentResult)CALL_ONE_PARAMETER_UPP(userUPP, uppPickerGetDialogProcInfo, storage); }
  #else
    #define InvokePickerGetDialogUPP(storage, userUPP) (ComponentResult)CALL_ONE_PARAMETER_UPP((userUPP), uppPickerGetDialogProcInfo, (storage))
  #endif
#endif

/*
 *  InvokePickerGetItemListUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerGetItemListUPP(
  long                  storage,
  PickerGetItemListUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerGetItemListUPP(long storage, PickerGetItemListUPP userUPP) { return (ComponentResult)CALL_ONE_PARAMETER_UPP(userUPP, uppPickerGetItemListProcInfo, storage); }
  #else
    #define InvokePickerGetItemListUPP(storage, userUPP) (ComponentResult)CALL_ONE_PARAMETER_UPP((userUPP), uppPickerGetItemListProcInfo, (storage))
  #endif
#endif

/*
 *  InvokePickerGetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerGetColorUPP(
  long               storage,
  PickerColorType    whichColor,
  PMColorPtr         color,
  PickerGetColorUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerGetColorUPP(long storage, PickerColorType whichColor, PMColorPtr color, PickerGetColorUPP userUPP) { return (ComponentResult)CALL_THREE_PARAMETER_UPP(userUPP, uppPickerGetColorProcInfo, storage, whichColor, color); }
  #else
    #define InvokePickerGetColorUPP(storage, whichColor, color, userUPP) (ComponentResult)CALL_THREE_PARAMETER_UPP((userUPP), uppPickerGetColorProcInfo, (storage), (whichColor), (color))
  #endif
#endif

#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON || OLDROUTINENAMES
    /* support for pre-Carbon UPP routines: New...Proc and Call...Proc */
    #define NewPickerOpenProc(userRoutine)                      NewPickerOpenUPP(userRoutine)
    #define NewPickerCloseProc(userRoutine)                     NewPickerCloseUPP(userRoutine)
    #define NewPickerCanDoProc(userRoutine)                     NewPickerCanDoUPP(userRoutine)
    #define NewPickerVersionProc(userRoutine)                   NewPickerVersionUPP(userRoutine)
    #define NewPickerRegisterProc(userRoutine)                  NewPickerRegisterUPP(userRoutine)
    #define NewPickerSetTargetProc(userRoutine)                 NewPickerSetTargetUPP(userRoutine)
    #define NewPickerInitProc(userRoutine)                      NewPickerInitUPP(userRoutine)
    #define NewPickerTestGraphicsWorldProc(userRoutine)         NewPickerTestGraphicsWorldUPP(userRoutine)
    #define NewPickerGetDialogProc(userRoutine)                 NewPickerGetDialogUPP(userRoutine)
    #define NewPickerGetItemListProc(userRoutine)               NewPickerGetItemListUPP(userRoutine)
    #define NewPickerGetColorProc(userRoutine)                  NewPickerGetColorUPP(userRoutine)
    #define CallPickerOpenProc(userRoutine, storage, self)      InvokePickerOpenUPP(storage, self, userRoutine)
    #define CallPickerCloseProc(userRoutine, storage, self)     InvokePickerCloseUPP(storage, self, userRoutine)
    #define CallPickerCanDoProc(userRoutine, storage, selector) InvokePickerCanDoUPP(storage, selector, userRoutine)
    #define CallPickerVersionProc(userRoutine, storage)         InvokePickerVersionUPP(storage, userRoutine)
    #define CallPickerRegisterProc(userRoutine, storage)        InvokePickerRegisterUPP(storage, userRoutine)
    #define CallPickerSetTargetProc(userRoutine, storage, topOfCallChain) InvokePickerSetTargetUPP(storage, topOfCallChain, userRoutine)
    #define CallPickerInitProc(userRoutine, storage, data)      InvokePickerInitUPP(storage, data, userRoutine)
    #define CallPickerTestGraphicsWorldProc(userRoutine, storage, data) InvokePickerTestGraphicsWorldUPP(storage, data, userRoutine)
    #define CallPickerGetDialogProc(userRoutine, storage)       InvokePickerGetDialogUPP(storage, userRoutine)
    #define CallPickerGetItemListProc(userRoutine, storage)     InvokePickerGetItemListUPP(storage, userRoutine)
    #define CallPickerGetColorProc(userRoutine, storage, whichColor, color) InvokePickerGetColorUPP(storage, whichColor, color, userRoutine)
#endif /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON
/*
 *  PickerSetColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
PickerSetColor(
  long              storage,
  PickerColorType   whichColor,
  PMColorPtr        color)                                    FIVEWORDINLINE(0x2F3C, 0x0006, 0x0005, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , PickerSetColorProcPtr )(long storage, PickerColorType whichColor, PMColorPtr color);
#if CALL_NOT_IN_CARBON
/*
 *  PickerEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
PickerEvent(
  long               storage,
  PickerEventData *  data)                                    FIVEWORDINLINE(0x2F3C, 0x0004, 0x0006, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , PickerEventProcPtr )(long storage, PickerEventData *data);
#if CALL_NOT_IN_CARBON
/*
 *  PickerEdit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
PickerEdit(
  long              storage,
  PickerEditData *  data)                                     FIVEWORDINLINE(0x2F3C, 0x0004, 0x0007, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , PickerEditProcPtr )(long storage, PickerEditData *data);
#if CALL_NOT_IN_CARBON
/*
 *  PickerSetVisibility()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
PickerSetVisibility(
  long      storage,
  Boolean   visible)                                          FIVEWORDINLINE(0x2F3C, 0x0002, 0x0008, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , PickerSetVisibilityProcPtr )(long storage, Boolean visible);
#if CALL_NOT_IN_CARBON
/*
 *  PickerDisplay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
PickerDisplay(long storage)                                   FIVEWORDINLINE(0x2F3C, 0x0000, 0x0009, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , PickerDisplayProcPtr )(long storage);
#if CALL_NOT_IN_CARBON
/*
 *  PickerItemHit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
PickerItemHit(
  long                 storage,
  PickerItemHitData *  data)                                  FIVEWORDINLINE(0x2F3C, 0x0004, 0x000A, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , PickerItemHitProcPtr )(long storage, PickerItemHitData *data);
#if CALL_NOT_IN_CARBON
/*
 *  PickerSetBaseItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
PickerSetBaseItem(
  long    storage,
  short   baseItem)                                           FIVEWORDINLINE(0x2F3C, 0x0002, 0x000B, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , PickerSetBaseItemProcPtr )(long storage, short baseItem);
#if CALL_NOT_IN_CARBON
/*
 *  PickerGetProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
PickerGetProfile(long storage)                                FIVEWORDINLINE(0x2F3C, 0x0000, 0x000C, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , PickerGetProfileProcPtr )(long storage);
#if CALL_NOT_IN_CARBON
/*
 *  PickerSetProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
PickerSetProfile(
  long              storage,
  CMProfileHandle   profile)                                  FIVEWORDINLINE(0x2F3C, 0x0004, 0x000D, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , PickerSetProfileProcPtr )(long storage, CMProfileHandle profile);
#if CALL_NOT_IN_CARBON
/*
 *  PickerGetPrompt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
PickerGetPrompt(
  long     storage,
  Str255   prompt)                                            FIVEWORDINLINE(0x2F3C, 0x0004, 0x000E, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , PickerGetPromptProcPtr )(long storage, Str255 prompt);
#if CALL_NOT_IN_CARBON
/*
 *  PickerSetPrompt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
PickerSetPrompt(
  long               storage,
  ConstStr255Param   prompt)                                  FIVEWORDINLINE(0x2F3C, 0x0004, 0x000F, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , PickerSetPromptProcPtr )(long storage, ConstStr255Param prompt);
#if CALL_NOT_IN_CARBON
/*
 *  PickerGetIconData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
PickerGetIconData(
  long              storage,
  PickerIconData *  data)                                     FIVEWORDINLINE(0x2F3C, 0x0004, 0x0010, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , PickerGetIconDataProcPtr )(long storage, PickerIconData *data);
#if CALL_NOT_IN_CARBON
/*
 *  PickerGetEditMenuState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
PickerGetEditMenuState(
  long               storage,
  PickerMenuState *  mState)                                  FIVEWORDINLINE(0x2F3C, 0x0004, 0x0011, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , PickerGetEditMenuStateProcPtr )(long storage, PickerMenuState *mState);
#if CALL_NOT_IN_CARBON
/*
 *  PickerSetOrigin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
PickerSetOrigin(
  long    storage,
  Point   where)                                              FIVEWORDINLINE(0x2F3C, 0x0004, 0x0012, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , PickerSetOriginProcPtr )(long storage, Point where);
/*  Below are the ColorPicker 2.1 routines.*/


#if CALL_NOT_IN_CARBON
/*
 *  PickerSetColorChangedProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
PickerSetColorChangedProc(
  long              storage,
  ColorChangedUPP   colorProc,
  long              colorProcData)                            FIVEWORDINLINE(0x2F3C, 0x0008, 0x0014, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , PickerSetColorChangedProcProcPtr )(long storage, NColorChangedUPP colorProc, long colorProcData);
/* New Color Picker 2.1 messages.  If you don't wish to support these you should already be... */
/* returning a badComponentSelector in your main entry routine.  They have new selectors*/
#if CALL_NOT_IN_CARBON
/*
 *  NPickerGetColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
NPickerGetColor(
  long              storage,
  PickerColorType   whichColor,
  NPMColor *        color)                                    FIVEWORDINLINE(0x2F3C, 0x0006, 0x0015, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , NPickerGetColorProcPtr )(long storage, PickerColorType whichColor, NPMColor *color);
#if CALL_NOT_IN_CARBON
/*
 *  NPickerSetColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
NPickerSetColor(
  long              storage,
  PickerColorType   whichColor,
  NPMColor *        color)                                    FIVEWORDINLINE(0x2F3C, 0x0006, 0x0016, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , NPickerSetColorProcPtr )(long storage, PickerColorType whichColor, NPMColor *color);
#if CALL_NOT_IN_CARBON
/*
 *  NPickerGetProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
NPickerGetProfile(
  long            storage,
  CMProfileRef *  profile)                                    FIVEWORDINLINE(0x2F3C, 0x0004, 0x0017, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , NPickerGetProfileProcPtr )(long storage, CMProfileRef *profile);
#if CALL_NOT_IN_CARBON
/*
 *  NPickerSetProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
NPickerSetProfile(
  long           storage,
  CMProfileRef   profile)                                     FIVEWORDINLINE(0x2F3C, 0x0004, 0x0018, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , NPickerSetProfileProcPtr )(long storage, CMProfileRef profile);
#if CALL_NOT_IN_CARBON
/*
 *  NPickerSetColorChangedProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
NPickerSetColorChangedProc(
  long               storage,
  NColorChangedUPP   colorProc,
  long               colorProcData)                           FIVEWORDINLINE(0x2F3C, 0x0008, 0x0019, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , NPickerSetColorChangedProcProcPtr )(long storage, NColorChangedUPP colorProc, long colorProcData);
#if CALL_NOT_IN_CARBON
/*
 *  PickerExtractHelpItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( ComponentResult )
PickerExtractHelpItem(
  long                  storage,
  short                 itemNo,
  short                 whichMsg,
  PickerHelpItemInfo *  helpInfo)                             FIVEWORDINLINE(0x2F3C, 0x0008, 0x0013, 0x7000, 0xA82A);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( ComponentResult , PickerExtractHelpItemProcPtr )(long storage, short itemNo, short whichMsg, PickerHelpItemInfo *helpInfo);
typedef STACK_UPP_TYPE(PickerSetColorProcPtr)                   PickerSetColorUPP;
typedef STACK_UPP_TYPE(PickerEventProcPtr)                      PickerEventUPP;
typedef STACK_UPP_TYPE(PickerEditProcPtr)                       PickerEditUPP;
typedef STACK_UPP_TYPE(PickerSetVisibilityProcPtr)              PickerSetVisibilityUPP;
typedef STACK_UPP_TYPE(PickerDisplayProcPtr)                    PickerDisplayUPP;
typedef STACK_UPP_TYPE(PickerItemHitProcPtr)                    PickerItemHitUPP;
typedef STACK_UPP_TYPE(PickerSetBaseItemProcPtr)                PickerSetBaseItemUPP;
typedef STACK_UPP_TYPE(PickerGetProfileProcPtr)                 PickerGetProfileUPP;
typedef STACK_UPP_TYPE(PickerSetProfileProcPtr)                 PickerSetProfileUPP;
typedef STACK_UPP_TYPE(PickerGetPromptProcPtr)                  PickerGetPromptUPP;
typedef STACK_UPP_TYPE(PickerSetPromptProcPtr)                  PickerSetPromptUPP;
typedef STACK_UPP_TYPE(PickerGetIconDataProcPtr)                PickerGetIconDataUPP;
typedef STACK_UPP_TYPE(PickerGetEditMenuStateProcPtr)           PickerGetEditMenuStateUPP;
typedef STACK_UPP_TYPE(PickerSetOriginProcPtr)                  PickerSetOriginUPP;
typedef STACK_UPP_TYPE(PickerSetColorChangedProcProcPtr)        PickerSetColorChangedProcUPP;
typedef STACK_UPP_TYPE(NPickerGetColorProcPtr)                  NPickerGetColorUPP;
typedef STACK_UPP_TYPE(NPickerSetColorProcPtr)                  NPickerSetColorUPP;
typedef STACK_UPP_TYPE(NPickerGetProfileProcPtr)                NPickerGetProfileUPP;
typedef STACK_UPP_TYPE(NPickerSetProfileProcPtr)                NPickerSetProfileUPP;
typedef STACK_UPP_TYPE(NPickerSetColorChangedProcProcPtr)       NPickerSetColorChangedProcUPP;
typedef STACK_UPP_TYPE(PickerExtractHelpItemProcPtr)            PickerExtractHelpItemUPP;
#if CALL_NOT_IN_CARBON
/*
 *  NewPickerSetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerSetColorUPP )
NewPickerSetColorUPP(PickerSetColorProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerSetColorProcInfo = 0x00000EF0 };  /* pascal 4_bytes Func(4_bytes, 2_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline PickerSetColorUPP NewPickerSetColorUPP(PickerSetColorProcPtr userRoutine) { return (PickerSetColorUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerSetColorProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerSetColorUPP(userRoutine) (PickerSetColorUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerSetColorProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerEventUPP )
NewPickerEventUPP(PickerEventProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerEventProcInfo = 0x000003F0 };  /* pascal 4_bytes Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline PickerEventUPP NewPickerEventUPP(PickerEventProcPtr userRoutine) { return (PickerEventUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerEventProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerEventUPP(userRoutine) (PickerEventUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerEventProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerEditUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerEditUPP )
NewPickerEditUPP(PickerEditProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerEditProcInfo = 0x000003F0 };  /* pascal 4_bytes Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline PickerEditUPP NewPickerEditUPP(PickerEditProcPtr userRoutine) { return (PickerEditUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerEditProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerEditUPP(userRoutine) (PickerEditUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerEditProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerSetVisibilityUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerSetVisibilityUPP )
NewPickerSetVisibilityUPP(PickerSetVisibilityProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerSetVisibilityProcInfo = 0x000001F0 };  /* pascal 4_bytes Func(4_bytes, 1_byte) */
  #ifdef __cplusplus
    inline PickerSetVisibilityUPP NewPickerSetVisibilityUPP(PickerSetVisibilityProcPtr userRoutine) { return (PickerSetVisibilityUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerSetVisibilityProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerSetVisibilityUPP(userRoutine) (PickerSetVisibilityUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerSetVisibilityProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerDisplayUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerDisplayUPP )
NewPickerDisplayUPP(PickerDisplayProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerDisplayProcInfo = 0x000000F0 };  /* pascal 4_bytes Func(4_bytes) */
  #ifdef __cplusplus
    inline PickerDisplayUPP NewPickerDisplayUPP(PickerDisplayProcPtr userRoutine) { return (PickerDisplayUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerDisplayProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerDisplayUPP(userRoutine) (PickerDisplayUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerDisplayProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerItemHitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerItemHitUPP )
NewPickerItemHitUPP(PickerItemHitProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerItemHitProcInfo = 0x000003F0 };  /* pascal 4_bytes Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline PickerItemHitUPP NewPickerItemHitUPP(PickerItemHitProcPtr userRoutine) { return (PickerItemHitUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerItemHitProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerItemHitUPP(userRoutine) (PickerItemHitUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerItemHitProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerSetBaseItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerSetBaseItemUPP )
NewPickerSetBaseItemUPP(PickerSetBaseItemProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerSetBaseItemProcInfo = 0x000002F0 };  /* pascal 4_bytes Func(4_bytes, 2_bytes) */
  #ifdef __cplusplus
    inline PickerSetBaseItemUPP NewPickerSetBaseItemUPP(PickerSetBaseItemProcPtr userRoutine) { return (PickerSetBaseItemUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerSetBaseItemProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerSetBaseItemUPP(userRoutine) (PickerSetBaseItemUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerSetBaseItemProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerGetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerGetProfileUPP )
NewPickerGetProfileUPP(PickerGetProfileProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerGetProfileProcInfo = 0x000000F0 };  /* pascal 4_bytes Func(4_bytes) */
  #ifdef __cplusplus
    inline PickerGetProfileUPP NewPickerGetProfileUPP(PickerGetProfileProcPtr userRoutine) { return (PickerGetProfileUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerGetProfileProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerGetProfileUPP(userRoutine) (PickerGetProfileUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerGetProfileProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerSetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerSetProfileUPP )
NewPickerSetProfileUPP(PickerSetProfileProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerSetProfileProcInfo = 0x000003F0 };  /* pascal 4_bytes Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline PickerSetProfileUPP NewPickerSetProfileUPP(PickerSetProfileProcPtr userRoutine) { return (PickerSetProfileUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerSetProfileProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerSetProfileUPP(userRoutine) (PickerSetProfileUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerSetProfileProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerGetPromptUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerGetPromptUPP )
NewPickerGetPromptUPP(PickerGetPromptProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerGetPromptProcInfo = 0x000003F0 };  /* pascal 4_bytes Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline PickerGetPromptUPP NewPickerGetPromptUPP(PickerGetPromptProcPtr userRoutine) { return (PickerGetPromptUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerGetPromptProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerGetPromptUPP(userRoutine) (PickerGetPromptUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerGetPromptProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerSetPromptUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerSetPromptUPP )
NewPickerSetPromptUPP(PickerSetPromptProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerSetPromptProcInfo = 0x000003F0 };  /* pascal 4_bytes Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline PickerSetPromptUPP NewPickerSetPromptUPP(PickerSetPromptProcPtr userRoutine) { return (PickerSetPromptUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerSetPromptProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerSetPromptUPP(userRoutine) (PickerSetPromptUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerSetPromptProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerGetIconDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerGetIconDataUPP )
NewPickerGetIconDataUPP(PickerGetIconDataProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerGetIconDataProcInfo = 0x000003F0 };  /* pascal 4_bytes Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline PickerGetIconDataUPP NewPickerGetIconDataUPP(PickerGetIconDataProcPtr userRoutine) { return (PickerGetIconDataUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerGetIconDataProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerGetIconDataUPP(userRoutine) (PickerGetIconDataUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerGetIconDataProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerGetEditMenuStateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerGetEditMenuStateUPP )
NewPickerGetEditMenuStateUPP(PickerGetEditMenuStateProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerGetEditMenuStateProcInfo = 0x000003F0 };  /* pascal 4_bytes Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline PickerGetEditMenuStateUPP NewPickerGetEditMenuStateUPP(PickerGetEditMenuStateProcPtr userRoutine) { return (PickerGetEditMenuStateUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerGetEditMenuStateProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerGetEditMenuStateUPP(userRoutine) (PickerGetEditMenuStateUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerGetEditMenuStateProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerSetOriginUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerSetOriginUPP )
NewPickerSetOriginUPP(PickerSetOriginProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerSetOriginProcInfo = 0x000003F0 };  /* pascal 4_bytes Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline PickerSetOriginUPP NewPickerSetOriginUPP(PickerSetOriginProcPtr userRoutine) { return (PickerSetOriginUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerSetOriginProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerSetOriginUPP(userRoutine) (PickerSetOriginUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerSetOriginProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerSetColorChangedProcUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerSetColorChangedProcUPP )
NewPickerSetColorChangedProcUPP(PickerSetColorChangedProcProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerSetColorChangedProcProcInfo = 0x00000FF0 };  /* pascal 4_bytes Func(4_bytes, 4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline PickerSetColorChangedProcUPP NewPickerSetColorChangedProcUPP(PickerSetColorChangedProcProcPtr userRoutine) { return (PickerSetColorChangedProcUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerSetColorChangedProcProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerSetColorChangedProcUPP(userRoutine) (PickerSetColorChangedProcUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerSetColorChangedProcProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewNPickerGetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( NPickerGetColorUPP )
NewNPickerGetColorUPP(NPickerGetColorProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppNPickerGetColorProcInfo = 0x00000EF0 };  /* pascal 4_bytes Func(4_bytes, 2_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline NPickerGetColorUPP NewNPickerGetColorUPP(NPickerGetColorProcPtr userRoutine) { return (NPickerGetColorUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppNPickerGetColorProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewNPickerGetColorUPP(userRoutine) (NPickerGetColorUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppNPickerGetColorProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewNPickerSetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( NPickerSetColorUPP )
NewNPickerSetColorUPP(NPickerSetColorProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppNPickerSetColorProcInfo = 0x00000EF0 };  /* pascal 4_bytes Func(4_bytes, 2_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline NPickerSetColorUPP NewNPickerSetColorUPP(NPickerSetColorProcPtr userRoutine) { return (NPickerSetColorUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppNPickerSetColorProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewNPickerSetColorUPP(userRoutine) (NPickerSetColorUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppNPickerSetColorProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewNPickerGetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( NPickerGetProfileUPP )
NewNPickerGetProfileUPP(NPickerGetProfileProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppNPickerGetProfileProcInfo = 0x000003F0 };  /* pascal 4_bytes Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline NPickerGetProfileUPP NewNPickerGetProfileUPP(NPickerGetProfileProcPtr userRoutine) { return (NPickerGetProfileUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppNPickerGetProfileProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewNPickerGetProfileUPP(userRoutine) (NPickerGetProfileUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppNPickerGetProfileProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewNPickerSetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( NPickerSetProfileUPP )
NewNPickerSetProfileUPP(NPickerSetProfileProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppNPickerSetProfileProcInfo = 0x000003F0 };  /* pascal 4_bytes Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline NPickerSetProfileUPP NewNPickerSetProfileUPP(NPickerSetProfileProcPtr userRoutine) { return (NPickerSetProfileUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppNPickerSetProfileProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewNPickerSetProfileUPP(userRoutine) (NPickerSetProfileUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppNPickerSetProfileProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewNPickerSetColorChangedProcUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( NPickerSetColorChangedProcUPP )
NewNPickerSetColorChangedProcUPP(NPickerSetColorChangedProcProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppNPickerSetColorChangedProcProcInfo = 0x00000FF0 };  /* pascal 4_bytes Func(4_bytes, 4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline NPickerSetColorChangedProcUPP NewNPickerSetColorChangedProcUPP(NPickerSetColorChangedProcProcPtr userRoutine) { return (NPickerSetColorChangedProcUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppNPickerSetColorChangedProcProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewNPickerSetColorChangedProcUPP(userRoutine) (NPickerSetColorChangedProcUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppNPickerSetColorChangedProcProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPickerExtractHelpItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PickerExtractHelpItemUPP )
NewPickerExtractHelpItemUPP(PickerExtractHelpItemProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPickerExtractHelpItemProcInfo = 0x00003AF0 };  /* pascal 4_bytes Func(4_bytes, 2_bytes, 2_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline PickerExtractHelpItemUPP NewPickerExtractHelpItemUPP(PickerExtractHelpItemProcPtr userRoutine) { return (PickerExtractHelpItemUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerExtractHelpItemProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPickerExtractHelpItemUPP(userRoutine) (PickerExtractHelpItemUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPickerExtractHelpItemProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  DisposePickerSetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerSetColorUPP(PickerSetColorUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerSetColorUPP(PickerSetColorUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerSetColorUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerEventUPP(PickerEventUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerEventUPP(PickerEventUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerEventUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerEditUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerEditUPP(PickerEditUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerEditUPP(PickerEditUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerEditUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerSetVisibilityUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerSetVisibilityUPP(PickerSetVisibilityUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerSetVisibilityUPP(PickerSetVisibilityUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerSetVisibilityUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerDisplayUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerDisplayUPP(PickerDisplayUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerDisplayUPP(PickerDisplayUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerDisplayUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerItemHitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerItemHitUPP(PickerItemHitUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerItemHitUPP(PickerItemHitUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerItemHitUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerSetBaseItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerSetBaseItemUPP(PickerSetBaseItemUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerSetBaseItemUPP(PickerSetBaseItemUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerSetBaseItemUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerGetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerGetProfileUPP(PickerGetProfileUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerGetProfileUPP(PickerGetProfileUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerGetProfileUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerSetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerSetProfileUPP(PickerSetProfileUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerSetProfileUPP(PickerSetProfileUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerSetProfileUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerGetPromptUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerGetPromptUPP(PickerGetPromptUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerGetPromptUPP(PickerGetPromptUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerGetPromptUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerSetPromptUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerSetPromptUPP(PickerSetPromptUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerSetPromptUPP(PickerSetPromptUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerSetPromptUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerGetIconDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerGetIconDataUPP(PickerGetIconDataUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerGetIconDataUPP(PickerGetIconDataUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerGetIconDataUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerGetEditMenuStateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerGetEditMenuStateUPP(PickerGetEditMenuStateUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerGetEditMenuStateUPP(PickerGetEditMenuStateUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerGetEditMenuStateUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerSetOriginUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerSetOriginUPP(PickerSetOriginUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerSetOriginUPP(PickerSetOriginUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerSetOriginUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerSetColorChangedProcUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerSetColorChangedProcUPP(PickerSetColorChangedProcUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerSetColorChangedProcUPP(PickerSetColorChangedProcUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerSetColorChangedProcUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeNPickerGetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeNPickerGetColorUPP(NPickerGetColorUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeNPickerGetColorUPP(NPickerGetColorUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeNPickerGetColorUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeNPickerSetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeNPickerSetColorUPP(NPickerSetColorUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeNPickerSetColorUPP(NPickerSetColorUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeNPickerSetColorUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeNPickerGetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeNPickerGetProfileUPP(NPickerGetProfileUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeNPickerGetProfileUPP(NPickerGetProfileUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeNPickerGetProfileUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeNPickerSetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeNPickerSetProfileUPP(NPickerSetProfileUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeNPickerSetProfileUPP(NPickerSetProfileUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeNPickerSetProfileUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeNPickerSetColorChangedProcUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeNPickerSetColorChangedProcUPP(NPickerSetColorChangedProcUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeNPickerSetColorChangedProcUPP(NPickerSetColorChangedProcUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeNPickerSetColorChangedProcUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePickerExtractHelpItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePickerExtractHelpItemUPP(PickerExtractHelpItemUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePickerExtractHelpItemUPP(PickerExtractHelpItemUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePickerExtractHelpItemUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  InvokePickerSetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerSetColorUPP(
  long               storage,
  PickerColorType    whichColor,
  PMColorPtr         color,
  PickerSetColorUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerSetColorUPP(long storage, PickerColorType whichColor, PMColorPtr color, PickerSetColorUPP userUPP) { return (ComponentResult)CALL_THREE_PARAMETER_UPP(userUPP, uppPickerSetColorProcInfo, storage, whichColor, color); }
  #else
    #define InvokePickerSetColorUPP(storage, whichColor, color, userUPP) (ComponentResult)CALL_THREE_PARAMETER_UPP((userUPP), uppPickerSetColorProcInfo, (storage), (whichColor), (color))
  #endif
#endif

/*
 *  InvokePickerEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerEventUPP(
  long               storage,
  PickerEventData *  data,
  PickerEventUPP     userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerEventUPP(long storage, PickerEventData * data, PickerEventUPP userUPP) { return (ComponentResult)CALL_TWO_PARAMETER_UPP(userUPP, uppPickerEventProcInfo, storage, data); }
  #else
    #define InvokePickerEventUPP(storage, data, userUPP) (ComponentResult)CALL_TWO_PARAMETER_UPP((userUPP), uppPickerEventProcInfo, (storage), (data))
  #endif
#endif

/*
 *  InvokePickerEditUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerEditUPP(
  long              storage,
  PickerEditData *  data,
  PickerEditUPP     userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerEditUPP(long storage, PickerEditData * data, PickerEditUPP userUPP) { return (ComponentResult)CALL_TWO_PARAMETER_UPP(userUPP, uppPickerEditProcInfo, storage, data); }
  #else
    #define InvokePickerEditUPP(storage, data, userUPP) (ComponentResult)CALL_TWO_PARAMETER_UPP((userUPP), uppPickerEditProcInfo, (storage), (data))
  #endif
#endif

/*
 *  InvokePickerSetVisibilityUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerSetVisibilityUPP(
  long                    storage,
  Boolean                 visible,
  PickerSetVisibilityUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerSetVisibilityUPP(long storage, Boolean visible, PickerSetVisibilityUPP userUPP) { return (ComponentResult)CALL_TWO_PARAMETER_UPP(userUPP, uppPickerSetVisibilityProcInfo, storage, visible); }
  #else
    #define InvokePickerSetVisibilityUPP(storage, visible, userUPP) (ComponentResult)CALL_TWO_PARAMETER_UPP((userUPP), uppPickerSetVisibilityProcInfo, (storage), (visible))
  #endif
#endif

/*
 *  InvokePickerDisplayUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerDisplayUPP(
  long              storage,
  PickerDisplayUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerDisplayUPP(long storage, PickerDisplayUPP userUPP) { return (ComponentResult)CALL_ONE_PARAMETER_UPP(userUPP, uppPickerDisplayProcInfo, storage); }
  #else
    #define InvokePickerDisplayUPP(storage, userUPP) (ComponentResult)CALL_ONE_PARAMETER_UPP((userUPP), uppPickerDisplayProcInfo, (storage))
  #endif
#endif

/*
 *  InvokePickerItemHitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerItemHitUPP(
  long                 storage,
  PickerItemHitData *  data,
  PickerItemHitUPP     userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerItemHitUPP(long storage, PickerItemHitData * data, PickerItemHitUPP userUPP) { return (ComponentResult)CALL_TWO_PARAMETER_UPP(userUPP, uppPickerItemHitProcInfo, storage, data); }
  #else
    #define InvokePickerItemHitUPP(storage, data, userUPP) (ComponentResult)CALL_TWO_PARAMETER_UPP((userUPP), uppPickerItemHitProcInfo, (storage), (data))
  #endif
#endif

/*
 *  InvokePickerSetBaseItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerSetBaseItemUPP(
  long                  storage,
  short                 baseItem,
  PickerSetBaseItemUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerSetBaseItemUPP(long storage, short baseItem, PickerSetBaseItemUPP userUPP) { return (ComponentResult)CALL_TWO_PARAMETER_UPP(userUPP, uppPickerSetBaseItemProcInfo, storage, baseItem); }
  #else
    #define InvokePickerSetBaseItemUPP(storage, baseItem, userUPP) (ComponentResult)CALL_TWO_PARAMETER_UPP((userUPP), uppPickerSetBaseItemProcInfo, (storage), (baseItem))
  #endif
#endif

/*
 *  InvokePickerGetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerGetProfileUPP(
  long                 storage,
  PickerGetProfileUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerGetProfileUPP(long storage, PickerGetProfileUPP userUPP) { return (ComponentResult)CALL_ONE_PARAMETER_UPP(userUPP, uppPickerGetProfileProcInfo, storage); }
  #else
    #define InvokePickerGetProfileUPP(storage, userUPP) (ComponentResult)CALL_ONE_PARAMETER_UPP((userUPP), uppPickerGetProfileProcInfo, (storage))
  #endif
#endif

/*
 *  InvokePickerSetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerSetProfileUPP(
  long                 storage,
  CMProfileHandle      profile,
  PickerSetProfileUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerSetProfileUPP(long storage, CMProfileHandle profile, PickerSetProfileUPP userUPP) { return (ComponentResult)CALL_TWO_PARAMETER_UPP(userUPP, uppPickerSetProfileProcInfo, storage, profile); }
  #else
    #define InvokePickerSetProfileUPP(storage, profile, userUPP) (ComponentResult)CALL_TWO_PARAMETER_UPP((userUPP), uppPickerSetProfileProcInfo, (storage), (profile))
  #endif
#endif

/*
 *  InvokePickerGetPromptUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerGetPromptUPP(
  long                storage,
  Str255              prompt,
  PickerGetPromptUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerGetPromptUPP(long storage, Str255 prompt, PickerGetPromptUPP userUPP) { return (ComponentResult)CALL_TWO_PARAMETER_UPP(userUPP, uppPickerGetPromptProcInfo, storage, prompt); }
  #else
    #define InvokePickerGetPromptUPP(storage, prompt, userUPP) (ComponentResult)CALL_TWO_PARAMETER_UPP((userUPP), uppPickerGetPromptProcInfo, (storage), (prompt))
  #endif
#endif

/*
 *  InvokePickerSetPromptUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerSetPromptUPP(
  long                storage,
  ConstStr255Param    prompt,
  PickerSetPromptUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerSetPromptUPP(long storage, ConstStr255Param prompt, PickerSetPromptUPP userUPP) { return (ComponentResult)CALL_TWO_PARAMETER_UPP(userUPP, uppPickerSetPromptProcInfo, storage, prompt); }
  #else
    #define InvokePickerSetPromptUPP(storage, prompt, userUPP) (ComponentResult)CALL_TWO_PARAMETER_UPP((userUPP), uppPickerSetPromptProcInfo, (storage), (prompt))
  #endif
#endif

/*
 *  InvokePickerGetIconDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerGetIconDataUPP(
  long                  storage,
  PickerIconData *      data,
  PickerGetIconDataUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerGetIconDataUPP(long storage, PickerIconData * data, PickerGetIconDataUPP userUPP) { return (ComponentResult)CALL_TWO_PARAMETER_UPP(userUPP, uppPickerGetIconDataProcInfo, storage, data); }
  #else
    #define InvokePickerGetIconDataUPP(storage, data, userUPP) (ComponentResult)CALL_TWO_PARAMETER_UPP((userUPP), uppPickerGetIconDataProcInfo, (storage), (data))
  #endif
#endif

/*
 *  InvokePickerGetEditMenuStateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerGetEditMenuStateUPP(
  long                       storage,
  PickerMenuState *          mState,
  PickerGetEditMenuStateUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerGetEditMenuStateUPP(long storage, PickerMenuState * mState, PickerGetEditMenuStateUPP userUPP) { return (ComponentResult)CALL_TWO_PARAMETER_UPP(userUPP, uppPickerGetEditMenuStateProcInfo, storage, mState); }
  #else
    #define InvokePickerGetEditMenuStateUPP(storage, mState, userUPP) (ComponentResult)CALL_TWO_PARAMETER_UPP((userUPP), uppPickerGetEditMenuStateProcInfo, (storage), (mState))
  #endif
#endif

/*
 *  InvokePickerSetOriginUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerSetOriginUPP(
  long                storage,
  Point               where,
  PickerSetOriginUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerSetOriginUPP(long storage, Point where, PickerSetOriginUPP userUPP) { return (ComponentResult)CALL_TWO_PARAMETER_UPP(userUPP, uppPickerSetOriginProcInfo, storage, where); }
  #else
    #define InvokePickerSetOriginUPP(storage, where, userUPP) (ComponentResult)CALL_TWO_PARAMETER_UPP((userUPP), uppPickerSetOriginProcInfo, (storage), (where))
  #endif
#endif

/*
 *  InvokePickerSetColorChangedProcUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerSetColorChangedProcUPP(
  long                          storage,
  NColorChangedUPP              colorProc,
  long                          colorProcData,
  PickerSetColorChangedProcUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerSetColorChangedProcUPP(long storage, NColorChangedUPP colorProc, long colorProcData, PickerSetColorChangedProcUPP userUPP) { return (ComponentResult)CALL_THREE_PARAMETER_UPP(userUPP, uppPickerSetColorChangedProcProcInfo, storage, colorProc, colorProcData); }
  #else
    #define InvokePickerSetColorChangedProcUPP(storage, colorProc, colorProcData, userUPP) (ComponentResult)CALL_THREE_PARAMETER_UPP((userUPP), uppPickerSetColorChangedProcProcInfo, (storage), (colorProc), (colorProcData))
  #endif
#endif

/*
 *  InvokeNPickerGetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokeNPickerGetColorUPP(
  long                storage,
  PickerColorType     whichColor,
  NPMColor *          color,
  NPickerGetColorUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokeNPickerGetColorUPP(long storage, PickerColorType whichColor, NPMColor * color, NPickerGetColorUPP userUPP) { return (ComponentResult)CALL_THREE_PARAMETER_UPP(userUPP, uppNPickerGetColorProcInfo, storage, whichColor, color); }
  #else
    #define InvokeNPickerGetColorUPP(storage, whichColor, color, userUPP) (ComponentResult)CALL_THREE_PARAMETER_UPP((userUPP), uppNPickerGetColorProcInfo, (storage), (whichColor), (color))
  #endif
#endif

/*
 *  InvokeNPickerSetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokeNPickerSetColorUPP(
  long                storage,
  PickerColorType     whichColor,
  NPMColor *          color,
  NPickerSetColorUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokeNPickerSetColorUPP(long storage, PickerColorType whichColor, NPMColor * color, NPickerSetColorUPP userUPP) { return (ComponentResult)CALL_THREE_PARAMETER_UPP(userUPP, uppNPickerSetColorProcInfo, storage, whichColor, color); }
  #else
    #define InvokeNPickerSetColorUPP(storage, whichColor, color, userUPP) (ComponentResult)CALL_THREE_PARAMETER_UPP((userUPP), uppNPickerSetColorProcInfo, (storage), (whichColor), (color))
  #endif
#endif

/*
 *  InvokeNPickerGetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokeNPickerGetProfileUPP(
  long                  storage,
  CMProfileRef *        profile,
  NPickerGetProfileUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokeNPickerGetProfileUPP(long storage, CMProfileRef * profile, NPickerGetProfileUPP userUPP) { return (ComponentResult)CALL_TWO_PARAMETER_UPP(userUPP, uppNPickerGetProfileProcInfo, storage, profile); }
  #else
    #define InvokeNPickerGetProfileUPP(storage, profile, userUPP) (ComponentResult)CALL_TWO_PARAMETER_UPP((userUPP), uppNPickerGetProfileProcInfo, (storage), (profile))
  #endif
#endif

/*
 *  InvokeNPickerSetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokeNPickerSetProfileUPP(
  long                  storage,
  CMProfileRef          profile,
  NPickerSetProfileUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokeNPickerSetProfileUPP(long storage, CMProfileRef profile, NPickerSetProfileUPP userUPP) { return (ComponentResult)CALL_TWO_PARAMETER_UPP(userUPP, uppNPickerSetProfileProcInfo, storage, profile); }
  #else
    #define InvokeNPickerSetProfileUPP(storage, profile, userUPP) (ComponentResult)CALL_TWO_PARAMETER_UPP((userUPP), uppNPickerSetProfileProcInfo, (storage), (profile))
  #endif
#endif

/*
 *  InvokeNPickerSetColorChangedProcUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokeNPickerSetColorChangedProcUPP(
  long                           storage,
  NColorChangedUPP               colorProc,
  long                           colorProcData,
  NPickerSetColorChangedProcUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokeNPickerSetColorChangedProcUPP(long storage, NColorChangedUPP colorProc, long colorProcData, NPickerSetColorChangedProcUPP userUPP) { return (ComponentResult)CALL_THREE_PARAMETER_UPP(userUPP, uppNPickerSetColorChangedProcProcInfo, storage, colorProc, colorProcData); }
  #else
    #define InvokeNPickerSetColorChangedProcUPP(storage, colorProc, colorProcData, userUPP) (ComponentResult)CALL_THREE_PARAMETER_UPP((userUPP), uppNPickerSetColorChangedProcProcInfo, (storage), (colorProc), (colorProcData))
  #endif
#endif

/*
 *  InvokePickerExtractHelpItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ComponentResult )
InvokePickerExtractHelpItemUPP(
  long                      storage,
  short                     itemNo,
  short                     whichMsg,
  PickerHelpItemInfo *      helpInfo,
  PickerExtractHelpItemUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline ComponentResult InvokePickerExtractHelpItemUPP(long storage, short itemNo, short whichMsg, PickerHelpItemInfo * helpInfo, PickerExtractHelpItemUPP userUPP) { return (ComponentResult)CALL_FOUR_PARAMETER_UPP(userUPP, uppPickerExtractHelpItemProcInfo, storage, itemNo, whichMsg, helpInfo); }
  #else
    #define InvokePickerExtractHelpItemUPP(storage, itemNo, whichMsg, helpInfo, userUPP) (ComponentResult)CALL_FOUR_PARAMETER_UPP((userUPP), uppPickerExtractHelpItemProcInfo, (storage), (itemNo), (whichMsg), (helpInfo))
  #endif
#endif

#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON || OLDROUTINENAMES
    /* support for pre-Carbon UPP routines: New...Proc and Call...Proc */
    #define NewPickerSetColorProc(userRoutine)                  NewPickerSetColorUPP(userRoutine)
    #define NewPickerEventProc(userRoutine)                     NewPickerEventUPP(userRoutine)
    #define NewPickerEditProc(userRoutine)                      NewPickerEditUPP(userRoutine)
    #define NewPickerSetVisibilityProc(userRoutine)             NewPickerSetVisibilityUPP(userRoutine)
    #define NewPickerDisplayProc(userRoutine)                   NewPickerDisplayUPP(userRoutine)
    #define NewPickerItemHitProc(userRoutine)                   NewPickerItemHitUPP(userRoutine)
    #define NewPickerSetBaseItemProc(userRoutine)               NewPickerSetBaseItemUPP(userRoutine)
    #define NewPickerGetProfileProc(userRoutine)                NewPickerGetProfileUPP(userRoutine)
    #define NewPickerSetProfileProc(userRoutine)                NewPickerSetProfileUPP(userRoutine)
    #define NewPickerGetPromptProc(userRoutine)                 NewPickerGetPromptUPP(userRoutine)
    #define NewPickerSetPromptProc(userRoutine)                 NewPickerSetPromptUPP(userRoutine)
    #define NewPickerGetIconDataProc(userRoutine)               NewPickerGetIconDataUPP(userRoutine)
    #define NewPickerGetEditMenuStateProc(userRoutine)          NewPickerGetEditMenuStateUPP(userRoutine)
    #define NewPickerSetOriginProc(userRoutine)                 NewPickerSetOriginUPP(userRoutine)
    #define NewPickerSetColorChangedProcProc(userRoutine)       NewPickerSetColorChangedProcUPP(userRoutine)
    #define NewNPickerGetColorProc(userRoutine)                 NewNPickerGetColorUPP(userRoutine)
    #define NewNPickerSetColorProc(userRoutine)                 NewNPickerSetColorUPP(userRoutine)
    #define NewNPickerGetProfileProc(userRoutine)               NewNPickerGetProfileUPP(userRoutine)
    #define NewNPickerSetProfileProc(userRoutine)               NewNPickerSetProfileUPP(userRoutine)
    #define NewNPickerSetColorChangedProcProc(userRoutine)      NewNPickerSetColorChangedProcUPP(userRoutine)
    #define NewPickerExtractHelpItemProc(userRoutine)           NewPickerExtractHelpItemUPP(userRoutine)
    #define CallPickerSetColorProc(userRoutine, storage, whichColor, color) InvokePickerSetColorUPP(storage, whichColor, color, userRoutine)
    #define CallPickerEventProc(userRoutine, storage, data)     InvokePickerEventUPP(storage, data, userRoutine)
    #define CallPickerEditProc(userRoutine, storage, data)      InvokePickerEditUPP(storage, data, userRoutine)
    #define CallPickerSetVisibilityProc(userRoutine, storage, visible) InvokePickerSetVisibilityUPP(storage, visible, userRoutine)
    #define CallPickerDisplayProc(userRoutine, storage)         InvokePickerDisplayUPP(storage, userRoutine)
    #define CallPickerItemHitProc(userRoutine, storage, data)   InvokePickerItemHitUPP(storage, data, userRoutine)
    #define CallPickerSetBaseItemProc(userRoutine, storage, baseItem) InvokePickerSetBaseItemUPP(storage, baseItem, userRoutine)
    #define CallPickerGetProfileProc(userRoutine, storage)      InvokePickerGetProfileUPP(storage, userRoutine)
    #define CallPickerSetProfileProc(userRoutine, storage, profile) InvokePickerSetProfileUPP(storage, profile, userRoutine)
    #define CallPickerGetPromptProc(userRoutine, storage, prompt) InvokePickerGetPromptUPP(storage, prompt, userRoutine)
    #define CallPickerSetPromptProc(userRoutine, storage, prompt) InvokePickerSetPromptUPP(storage, prompt, userRoutine)
    #define CallPickerGetIconDataProc(userRoutine, storage, data) InvokePickerGetIconDataUPP(storage, data, userRoutine)
    #define CallPickerGetEditMenuStateProc(userRoutine, storage, mState) InvokePickerGetEditMenuStateUPP(storage, mState, userRoutine)
    #define CallPickerSetOriginProc(userRoutine, storage, where) InvokePickerSetOriginUPP(storage, where, userRoutine)
    #define CallPickerSetColorChangedProcProc(userRoutine, storage, colorProc, colorProcData) InvokePickerSetColorChangedProcUPP(storage, colorProc, colorProcData, userRoutine)
    #define CallNPickerGetColorProc(userRoutine, storage, whichColor, color) InvokeNPickerGetColorUPP(storage, whichColor, color, userRoutine)
    #define CallNPickerSetColorProc(userRoutine, storage, whichColor, color) InvokeNPickerSetColorUPP(storage, whichColor, color, userRoutine)
    #define CallNPickerGetProfileProc(userRoutine, storage, profile) InvokeNPickerGetProfileUPP(storage, profile, userRoutine)
    #define CallNPickerSetProfileProc(userRoutine, storage, profile) InvokeNPickerSetProfileUPP(storage, profile, userRoutine)
    #define CallNPickerSetColorChangedProcProc(userRoutine, storage, colorProc, colorProcData) InvokeNPickerSetColorChangedProcUPP(storage, colorProc, colorProcData, userRoutine)
    #define CallPickerExtractHelpItemProc(userRoutine, storage, itemNo, whichMsg, helpInfo) InvokePickerExtractHelpItemUPP(storage, itemNo, whichMsg, helpInfo, userRoutine)
#endif /* CALL_NOT_IN_CARBON */


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

#endif /* __COLORPICKERCOMPONENTS__ */

