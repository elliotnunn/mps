/*
 	File:		OCETemplates.h
 
 	Contains:	Apple Open Collaboration Environment Templates Interfaces.
 
 	Version:	Technology:	AOCE Toolbox 1.02
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __OCETEMPLATES__
#define __OCETEMPLATES__

#ifndef REZ

#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __EVENTS__
#include <Events.h>
#endif
/*	#include <Quickdraw.h>										*/
/*		#include <MixedMode.h>									*/
/*		#include <QuickdrawText.h>								*/
/*	#include <OSUtils.h>										*/
/*		#include <Memory.h>										*/

#ifndef __CONTROLS__
#include <Controls.h>
#endif
/*	#include <Menus.h>											*/

#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif
/*	#include <Errors.h>											*/
/*	#include <EPPC.h>											*/
/*		#include <AppleTalk.h>									*/
/*		#include <Files.h>										*/
/*			#include <Finder.h>									*/
/*		#include <PPCToolbox.h>									*/
/*		#include <Processes.h>									*/
/*	#include <Notification.h>									*/

#ifndef __DIALOGS__
#include <Dialogs.h>
#endif
/*	#include <Windows.h>										*/
/*	#include <TextEdit.h>										*/
#endif /* REZ */

#ifndef __OCE__
#include <OCE.h>
#endif
/*	#include <Aliases.h>										*/
/*	#include <Script.h>											*/
/*		#include <IntlResources.h>								*/
#ifndef REZ

#ifndef __OCESTANDARDMAIL__
#include <OCEStandardMail.h>
#endif
/*	#include <OCEAuthDir.h>										*/
/*	#include <OCEMail.h>										*/
/*		#include <DigitalSignature.h>							*/
/*		#include <OCEMessaging.h>								*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

#endif /* REZ */
#define kDETAspectVersion -976
#define kDETInfoPageVersion -976
#define kDETKillerVersion -976
#define kDETForwarderVersion -976
#define kDETFileTypeVersion -976
#define kDETIDSep 250
#define kDETFirstID (1000)
#define kDETSecondID (1000+kDETIDSep)
#define kDETThirdID (1000+2*kDETIDSep)
#define kDETFourthID (1000+3*kDETIDSep)
#define kDETFifthID (1000+4*kDETIDSep)
#define kDETTemplateName 0
#define kDETRecordType 1
#define kDETAttributeType 2
#define kDETAttributeValueTag 3
#define kDETAspectCode 4
#define kDETAspectMainBitmap 5
#define kDETAspectName 6
#define kDETAspectCategory 7
#define kDETAspectExternalCategory 8
#define kDETAspectKind 9
#define kDETAspectGender 10
#define kDETAspectWhatIs 11
#define kDETAspectAliasKind 12
#define kDETAspectAliasGender 13
#define kDETAspectAliasWhatIs 14
#define kDETAspectBalloons 15
#define kDETAspectNewMenuName 16
#define kDETAspectNewEntryName 17
#define kDETAspectNewValue 18
#define kDETAspectSublistOpenOnNew 19
#define kDETAspectLookup 20
#define kDETAspectDragInString 21
#define kDETAspectDragInVerb 22
#define kDETAspectDragInSummary 23
#define kDETAspectRecordDragIn 24
#define kDETAspectRecordCatDragIn 25
#define kDETAspectAttrDragIn 26
#define kDETAspectAttrDragOut 27
#define kDETAspectViewMenu 28
#define kDETAspectReverseSort 29
#define kDETAspectInfoPageCustomWindow 30
#define kDETNoProperty -1
#define kDETFirstLocalProperty 0
#define kDETLastLocalProperty (kDETFirstLocalProperty+249)
#define kDETFirstDevProperty 40
#define kDETFirstConstantProperty 250
#define kDETLastConstantProperty (kDETFirstConstantProperty+249)
#define kDETConstantProperty kDETFirstConstantProperty
#define kDETZeroProperty (kDETConstantProperty+0)
#define kDETOneProperty (kDETConstantProperty+1)
#define kDETFalseProperty (kDETConstantProperty+0)
#define kDETTrueProperty (kDETConstantProperty+1)
#define kDETPrName 3050
#define kDETPrKind 3051
#define kDETDNodeAccessMask 25825
#define kDETRecordAccessMask 25826
#define kDETAttributeAccessMask 25827
#define kDETPrimaryMaskByBit 25828
#define kDETPrimarySeeMask kDETPrimaryMaskByBit
#define kDETPrimaryAddMask (kDETPrimaryMaskByBit+1)
#define kDETPrimaryDeleteMask (kDETPrimaryMaskByBit+2)
#define kDETPrimaryChangeMask (kDETPrimaryMaskByBit+3)
#define kDETPrimaryRenameMask (kDETPrimaryMaskByBit+4)
#define kDETPrimaryChangePrivsMask (kDETPrimaryMaskByBit+5)
#define kDETPrimaryTopMaskBit (kDETPrimaryMaskByBit+15)
#define kDETPastFirstLookup 26550
#define kDETInfoPageNumber 27050
#define kDETAspectTemplateNumber 26551
#define kDETInfoPageTemplateNumber 26552
#define kDETOpenSelectedItems 26553
#define kDETAddNewItem 26554
#define kDETRemoveSelectedItems 26555
#define kDETPrTypeNumber -1
#define kDETPrTypeString -2
#define kDETPrTypeBinary -3
#ifdef REZ
#define typeRString 'rstr'
#define typePackedDSSpec 'dspc'
#define typeBinary 'bnry'
#endif
#define kDETInfoPageName 4
#define kDETInfoPageMainViewAspect 5
#define kDETInfoPageMenuName 6
#define kDETInfoPageMenuEntries 7
#define kDETNoFlags 0
#define kDETEnabled (1 << 0)
#define kDETHilightIfSelected (1 << 0)
#define kDETNumericOnly (1 << 3)
#define kDETMultiLine (1 << 4)
#define kDETDynamicSize (1 << 9)
#define kDETAllowNoColons (1 << 10)
#define kDETPopupDynamicSize (1 << 8)
#define kDETScaleToView (1 << 8)
#define kDETLargeIcon 0
#define kDETSmallIcon 1
#define kDETMiniIcon 2
#define kDETLeft 0
#define kDETCenter 1
#define kDETRight -1
#define kDETForceLeft -2
#define kDETUnused 0
#define kDETBoxTakesContentClicks (1 << 0)
#define kDETBoxIsRounded (1 << 1)
#define kDETBoxIsGrayed (1 << 2)
#define kDETBoxIsInvisible (1 << 3)
#define kDETApplicationFont 1
#define kDETApplicationFontSize 9
#define kDETAppFontLineHeight 12
#define kDETSystemFont 0
#define kDETSystemFontSize 12
#define kDETSystemFontLineHeight 16
#define kDETDefaultFont 1
#define kDETDefaultFontSize 9
#define kDETDefaultFontLineHeight 12
#define kDETNormal 0
#define kDETBold 1
#define kDETItalic 2
#define kDETUnderline 4
#define kDETOutline 8
#define kDETShadow 0x10
#define kDETCondense 0x20
#define kDETExtend 0x40
#define kDETIconStyle -3
#define kDETChangeViewCommand 'view'
#define kDETRecordInfoWindHeight 228
#define kDETRecordInfoWindWidth 400
#define kDETAttributeInfoWindHeight 250
#define kDETAttributeInfoWindWidth 230
#define kDETSubpageIconTop 8
#define kDETSubpageIconLeft 8
#define kDETSubpageIconBottom (kDETSubpageIconTop+32)
#define kDETSubpageIconRight (kDETSubpageIconLeft+32)
#define kDETSubpageIconRect {kDETSubpageIconTop, kDETSubpageIconLeft, kDETSubpageIconBottom, kDETSubpageIconRight}
#define kDETNoSublistRect {0, 0, 0, 0}
#define kDETKillerName 1
#define kDETForwarderTemplateNames 4
#define kDETCategoryAllItems "aoce All Items"
#define kDETCategoryAddressItems "aoce Address Items"
#define kDETCategoryMisc "aoce Miscellaneous"
#ifndef REZ
/* Target specification: */

enum {
	kDETSelf					= 0,							/* The "current" item */
	kDETSelfOtherAspect,										/* Another aspect of the current item */
	kDETParent,													/* The parent (i.e., the aspect we're in the sublist of, if any) of the current item */
	kDETSublistItem,											/* The itemNumberth item in the sublist */
	kDETSelectedSublistItem,									/* The itemNumberth selected item in the sublist */
	kDETDSSpec,													/* The item specified by the packed DSSpec */
	kDETAspectTemplate,											/* A specific aspect template (number itemNumber) */
	kDETInfoPageTemplate,										/* A specific info-page template (number itemNumber)
	*  Force type to be short */
	kDETHighSelector			= 0xF000
};

typedef long DETTargetSelector;

struct DETTargetSpecification {
	DETTargetSelector				selector;					/* Target selection method (see above) */
	RStringPtr						aspectName;					/* The name of the aspect (kDETSelfOtherAspect, kDETSublistItem,
										   kDETSelectedSublistItem, kDETDSSpec); nil for main aspect or none;
										   always filled in for calls if there is an aspect, even if it's the main aspect */
	long							itemNumber;					/* Sublist index (kDETSublistItem & kDETSelectedSublistItem & kDETAspectTemplate);
										   1-based indexing */
	PackedDSSpecPtr					dsSpec;						/* DSSpec (kDETDSSpec only) */
};

typedef struct DETTargetSpecification DETTargetSpecification;

/* Code resource calls and call-backs both return an OSType:
		kDETDidNotHandle (1)	= used by template to say "I didn't handle it" (for calls only)
		noErr					= function completed successfully
		any error				= function failed, and here's why
*/
#define kDETDidNotHandle 1

enum {
	kDETcmdSimpleCallback		= 0,
	kDETcmdBeep,
	kDETcmdBusy,
	kDETcmdChangeCallFors,
	kDETcmdGetCommandSelectionCount,
	kDETcmdGetCommandItemN,
	kDETcmdOpenDSSpec,
	kDETcmdAboutToTalk,
	kDETcmdUnloadTemplates,
	kDETcmdTemplateCounts,
	kDETcmdTargetedCallback		= 1000,
	kDETcmdGetDSSpec,
	kDETcmdSublistCount,
	kDETcmdSelectedSublistCount,
	kDETcmdRequestSync,
	kDETcmdBreakAttribute,
	kDETcmdGetTemplateFSSpec,
	kDETcmdGetOpenEdit,
	kDETcmdCloseEdit,
	kDETcmdPropertyCallback		= 2000,
	kDETcmdGetPropertyType,
	kDETcmdGetPropertyNumber,
	kDETcmdGetPropertyRString,
	kDETcmdGetPropertyBinarySize,
	kDETcmdGetPropertyBinary,
	kDETcmdGetPropertyChanged,
	kDETcmdGetPropertyEditable,
	kDETcmdSetPropertyType,
	kDETcmdSetPropertyNumber,
	kDETcmdSetPropertyRString,
	kDETcmdSetPropertyBinary,
	kDETcmdSetPropertyChanged,
	kDETcmdSetPropertyEditable,
	kDETcmdDirtyProperty,
	kDETcmdDoPropertyCommand,
	kDETcmdAddMenu,
	kDETcmdRemoveMenu,
	kDETcmdMenuItemRString,
	kDETcmdSaveProperty,
	kDETcmdGetCustomViewUserReference,
	kDETcmdGetCustomViewBounds,
	kDETcmdGetResource,
/* Force type to be long */
	kDETcmdHighCallback			= 0xF0000000
};

typedef unsigned long DETCallBackFunctions;

#define DETCallBackBlockHeader 	\
	DETCallBackFunctions reqFunction;
#define DETCallBackBlockTargetedHeader  \
	DETCallBackFunctions reqFunction;	 \
	DETTargetSpecification target;
#define DETCallBackBlockPropertyHeader  \
	DETCallBackFunctions reqFunction;	 \
	DETTargetSpecification target;	 \
	short property;
struct DETProtoCallBackBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
};

typedef struct DETProtoCallBackBlock DETProtoCallBackBlock;

struct DETBeepBlock {
	DETCallBackFunctions			reqFunction;
};

typedef struct DETBeepBlock DETBeepBlock;

struct DETBusyBlock {
	DETCallBackFunctions			reqFunction;
};

typedef struct DETBusyBlock DETBusyBlock;

struct DETChangeCallForsBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	long							newCallFors;				/*  -> New call-for mask */
};

typedef struct DETChangeCallForsBlock DETChangeCallForsBlock;

struct DETGetCommandSelectionCountBlock {
	DETCallBackFunctions			reqFunction;
	long							count;						/* <-  The number of items in the command selection list */
};

typedef struct DETGetCommandSelectionCountBlock DETGetCommandSelectionCountBlock;


enum {
	kDETHFSType					= 0,							/* HFS item type */
	kDETDSType,													/* Catalog Service item type */
	kDETMailType,												/* Mail (letter) item type */
	kDETMoverType,												/* Sounds, fonts, etc., from inside a suitcase or system file */
	kDETLastItemType			= 0xF0000000					/* Force it to be a long (C & C++ seem to disagree about the definition of 0xF000) */
};

typedef unsigned long DETItemType;

/* FSSpec plus possibly interesting additional info */
struct DETFSInfo {
	OSType							fileType;					/* File type */
	OSType							fileCreator;				/* File creator */
	unsigned short					fdFlags;					/* Finder flags */
	FSSpec							fsSpec;						/* FSSpec */
};

typedef struct DETFSInfo DETFSInfo;

struct DSRec {
	PackedDSSpecPtr					*dsSpec;					/* <-  DSSpec for item (caller must DisposHandle() when done) */
	short							refNum;						/* <-  Refnum for returned address */
	AuthIdentity					identity;					/* <-  Identity for returned address */
};

typedef struct DSRec DSRec;

union ItemRec {
	DETFSInfo						**fsInfo;					/* <-  FSSpec & info for item (caller must DisposHandle() when done) */
	DSRec							ds;
	PackedDSSpecPtr					*dsSpec;					/* <-  DSSpec for item (caller must DisposHandle() when done) */
	LetterSpec						**ltrSpec;					/* <-  Letter spec for item (caller must DisposHandle() when done) */
};
typedef union ItemRec ItemRec;

struct DETGetCommandItemNBlock {
	DETCallBackFunctions			reqFunction;
	long							itemNumber;					/*  -> Item number to retrieve (1-based) */
	DETItemType						itemType;					/*  -> Type of item to be returned (if we can interpret it as such) */
	ItemRec							item;
};

typedef struct DETGetCommandItemNBlock DETGetCommandItemNBlock;

struct DETGetDSSpecBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	PackedDSSpecPtr					*dsSpec;					/* <-  Handle with result (caller must DisposHandle() when done) */
	short							refNum;						/* <-  Refnum for address if PD */
	AuthIdentity					identity;					/* <-  Identity for address */
	Boolean							isAlias;					/* <-  True if this entry is an alias */
	Boolean							isRecordRef;				/* <-  True if this entry is a record reference (reserved) */
};

typedef struct DETGetDSSpecBlock DETGetDSSpecBlock;

struct DETGetTemplateFSSpecBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	FSSpec							fsSpec;						/* <-  FSSpec of template file */
	short							baseID;						/* <-  Base ID of this template */
	long							aspectTemplateNumber;		/* <-  The template number for this aspect template */
};

typedef struct DETGetTemplateFSSpecBlock DETGetTemplateFSSpecBlock;

struct DETGetOpenEditBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							viewProperty;				/* <-  The property of the view being edited (or kNoProperty if none) */
};

typedef struct DETGetOpenEditBlock DETGetOpenEditBlock;

struct DETCloseEditBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
};

typedef struct DETCloseEditBlock DETCloseEditBlock;

struct DETGetPropertyTypeBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
	short							propertyType;				/* <-  The type of the property */
};

typedef struct DETGetPropertyTypeBlock DETGetPropertyTypeBlock;

struct DETGetPropertyNumberBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
	unsigned long					propertyValue;				/* <-  The value of the property */
};

typedef struct DETGetPropertyNumberBlock DETGetPropertyNumberBlock;

struct DETGetPropertyRStringBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
	RStringHandle					propertyValue;				/* <-  A handle containing the property (as an RString) (caller must DisposHandle() when done) */
};

typedef struct DETGetPropertyRStringBlock DETGetPropertyRStringBlock;

struct DETGetPropertyBinarySizeBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
	long							propertyBinarySize;			/* <-  The size of the property as a binary block */
};

typedef struct DETGetPropertyBinarySizeBlock DETGetPropertyBinarySizeBlock;

struct DETGetPropertyBinaryBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
	Handle							propertyValue;				/* <-  Handle with the value of the property (caller must DisposHandle() when done) */
};

typedef struct DETGetPropertyBinaryBlock DETGetPropertyBinaryBlock;

struct DETGetPropertyChangedBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
	Boolean							propertyChanged;			/* <-  True if the property is marked as changed */
	Boolean							filler1;
};

typedef struct DETGetPropertyChangedBlock DETGetPropertyChangedBlock;

struct DETGetPropertyEditableBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
	Boolean							propertyEditable;			/* <-  True if the property can be edited by the user (if false, view will appear disabled) */
	Boolean							filler1;
};

typedef struct DETGetPropertyEditableBlock DETGetPropertyEditableBlock;

struct DETSetPropertyTypeBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
	short							newType;					/*  -> New type for property (just sets type, does not convert contents) */
};

typedef struct DETSetPropertyTypeBlock DETSetPropertyTypeBlock;

struct DETSetPropertyNumberBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
	unsigned long					newValue;					/*  -> New value to set property to (and set type to number) */
};

typedef struct DETSetPropertyNumberBlock DETSetPropertyNumberBlock;

struct DETSetPropertyRStringBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
	RStringPtr						newValue;					/*  -> New value to set property to (and set type to RString) */
};

typedef struct DETSetPropertyRStringBlock DETSetPropertyRStringBlock;

struct DETSetPropertyBinaryBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
	Ptr								newValue;					/*  -> New value to set property to (and set type to binary) */
	long							newValueSize;				/*  -> Size of new value */
};

typedef struct DETSetPropertyBinaryBlock DETSetPropertyBinaryBlock;

struct DETSetPropertyChangedBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
	Boolean							propertyChanged;			/*  -> Value to set changed flag on property to */
	Boolean							filler1;
};

typedef struct DETSetPropertyChangedBlock DETSetPropertyChangedBlock;

struct DETSetPropertyEditableBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
	Boolean							propertyEditable;			/*  -> Value to set editable flag on property to */
	Boolean							filler1;
};

typedef struct DETSetPropertyEditableBlock DETSetPropertyEditableBlock;

struct DETDirtyPropertyBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
};

typedef struct DETDirtyPropertyBlock DETDirtyPropertyBlock;

struct DETDoPropertyCommandBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
	long							parameter;					/* ->  Parameter of command */
};

typedef struct DETDoPropertyCommandBlock DETDoPropertyCommandBlock;

struct DETSublistCountBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	long							count;						/* <-  The number of items in the current item's sublist */
};

typedef struct DETSublistCountBlock DETSublistCountBlock;

struct DETSelectedSublistCountBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	long							count;						/* <-  The number of selected items in the current item's sublist */
};

typedef struct DETSelectedSublistCountBlock DETSelectedSublistCountBlock;

struct DETRequestSyncBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
};

typedef struct DETRequestSyncBlock DETRequestSyncBlock;

struct DETAddMenuBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
	RString							*name;						/*  -> Name of new menu item */
	long							parameter;					/*  -> Parameter to return when this item is selected */
	long							addAfter;					/*  -> Parameter of entry to add after, or -1 for add at end */
};

typedef struct DETAddMenuBlock DETAddMenuBlock;

struct DETRemoveMenuBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
	long							itemToRemove;				/*  -> Parameter of menu item to remove */
};

typedef struct DETRemoveMenuBlock DETRemoveMenuBlock;

struct DETMenuItemRStringBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
	long							itemParameter;				/*  -> Parameter of menu item to return string for */
	RStringHandle					rString;					/* <-  Handle with the RString (caller must DisposHandle() when done) */
};

typedef struct DETMenuItemRStringBlock DETMenuItemRStringBlock;

struct DETOpenDSSpecBlock {
	DETCallBackFunctions			reqFunction;
	PackedDSSpecPtr					dsSpec;						/*  -> DSSpec of object to be opened */
};

typedef struct DETOpenDSSpecBlock DETOpenDSSpecBlock;

struct DETAboutToTalkBlock {
	DETCallBackFunctions			reqFunction;
};

typedef struct DETAboutToTalkBlock DETAboutToTalkBlock;

struct DETBreakAttributeBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	AttributePtr					breakAttribute;				/*  -> Attribute to parse */
	Boolean							isChangeable;				/*  -> True if the value can be changed by the user */
	Boolean							filler1;
};

typedef struct DETBreakAttributeBlock DETBreakAttributeBlock;

struct DETSavePropertyBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
};

typedef struct DETSavePropertyBlock DETSavePropertyBlock;

struct DETGetCustomViewUserReferenceBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
	short							userReference;				/* <-  User reference value, as specified in the .r file */
};

typedef struct DETGetCustomViewUserReferenceBlock DETGetCustomViewUserReferenceBlock;

struct DETGetCustomViewBoundsBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
	Rect							bounds;						/* <-  Bounds of the view */
};

typedef struct DETGetCustomViewBoundsBlock DETGetCustomViewBoundsBlock;

struct DETGetResourceBlock {
	DETCallBackFunctions			reqFunction;
	DETTargetSpecification			target;
	short							property;
	ResType							resourceType;				/*  -> Resource type */
	Handle							theResource;				/* <-  The resource handle (caller must dispose when done) */
};

typedef struct DETGetResourceBlock DETGetResourceBlock;

struct DETTemplateCounts {
	DETCallBackFunctions			reqFunction;
	long							aspectTemplateCount;		/* <-  Number of aspect templates in the system */
	long							infoPageTemplateCount;		/* <-  Number of info-page templates in the system */
};

typedef struct DETTemplateCounts DETTemplateCounts;

struct DETUnloadTemplatesBlock {
	DETCallBackFunctions			reqFunction;
};

typedef struct DETUnloadTemplatesBlock DETUnloadTemplatesBlock;

union DETCallBackBlock {
	DETProtoCallBackBlock			protoCallBack;
	DETBeepBlock					beep;
	DETBusyBlock					busy;
	DETChangeCallForsBlock			changeCallFors;
	DETGetCommandSelectionCountBlock getCommandSelectionCount;
	DETGetCommandItemNBlock			getCommandItemN;
	DETGetDSSpecBlock				getDSSpec;
	DETGetTemplateFSSpecBlock		getTemplateFSSpec;
	DETGetOpenEditBlock				getOpenEdit;
	DETCloseEditBlock				closeEdit;
	DETGetPropertyTypeBlock			getPropertyType;
	DETGetPropertyNumberBlock		getPropertyNumber;
	DETGetPropertyRStringBlock		getPropertyRString;
	DETGetPropertyBinarySizeBlock	getPropertyBinarySize;
	DETGetPropertyBinaryBlock		getPropertyBinary;
	DETGetPropertyChangedBlock		getPropertyChanged;
	DETGetPropertyEditableBlock		getPropertyEditable;
	DETSetPropertyTypeBlock			setPropertyType;
	DETSetPropertyNumberBlock		setPropertyNumber;
	DETSetPropertyRStringBlock		setPropertyRString;
	DETSetPropertyBinaryBlock		setPropertyBinary;
	DETSetPropertyChangedBlock		setPropertyChanged;
	DETSetPropertyEditableBlock		setPropertyEditable;
	DETDirtyPropertyBlock			dirtyProperty;
	DETDoPropertyCommandBlock		doPropertyCommand;
	DETSublistCountBlock			sublistCount;
	DETSelectedSublistCountBlock	selectedSublistCount;
	DETRequestSyncBlock				requestSync;
	DETAddMenuBlock					addMenu;
	DETRemoveMenuBlock				removeMenu;
	DETMenuItemRStringBlock			menuItemRString;
	DETOpenDSSpecBlock				openDSSpec;
	DETAboutToTalkBlock				aboutToTalk;
	DETBreakAttributeBlock			breakAttribute;
	DETSavePropertyBlock			saveProperty;
	DETGetCustomViewUserReferenceBlock getCustomViewUserReference;
	DETGetCustomViewBoundsBlock		getCustomViewBounds;
	DETGetResourceBlock				getResource;
	DETTemplateCounts				templateCounts;
	DETUnloadTemplatesBlock			unloadTemplates;
};
typedef union DETCallBackBlock DETCallBackBlock;

typedef DETCallBackBlock *DETCallBackBlockPtr;

typedef pascal OSErr (*DETCallBackProcPtr)(union DETCallBlock *callBlockPtr, DETCallBackBlockPtr callBackBlockPtr);

#if GENERATINGCFM
typedef UniversalProcPtr DETCallBackUPP;
#else
typedef DETCallBackProcPtr DETCallBackUPP;
#endif

typedef DETCallBackUPP DETCallBack;

/* Call functions:

		reqFunction						Action
		-----------						------
		kDETcmdInit						Called once when template is first loaded (good time to allocate private data); returns call-for list
		kDETcmdExit						Called once when template is freed (good time to free private data)

		kDETcmdAttributeCreation		New sublist attribute creation about to occur; this gives the template a chance to modify
										the value that's about to be created; sent to the template that will be used for
										the main aspect of the new entry

		kDETcmdDynamicForwarders		Return a list of dynamically created forwarders

		kDETcmdInstanceInit				Called once when instance of template is started (good time to allocate private instance data)
		kDETcmdInstanceExit				Called once when instance is ended (good time to free private instance data)

		kDETcmdIdle						Called periodically during idle times

		kDETcmdViewListChanged			Called when the info-page view-list (list of enabled views) has changed

		kDETcmdValidateSave				Validate save: about to save info-page, return noErr (or kDETDidNotHandle) if it's OK to do so

		kDETcmdDropQuery				Drop query: return the appropriate operation for this drag; ask destination
		kDETcmdDropMeQuery				Drop query: return the appropriate operation for this drag; ask dropee

		kDETcmdAttributeNew				Attribute value new (return kDETDidNotHandle to let normal new processing occur)
		kDETcmdAttributeChange			Attribute value change (return kDETDidNotHandle to let normal change processing occur)
		kDETcmdAttributeDelete			Attribute value delete (return kDETDidNotHandle to let normal deletion occur); sent to the
										main aspect of the attribute that's about to be deleted
		kDETcmdItemNew					Target item (record or attribute) has just been created

		kDETcmdOpenSelf					Self open (return noErr to prevent opening; return kDETDidNotHandle to allow it)

		kDETcmdDynamicResource			Return a dynamically created resource

		kDETcmdShouldSync				Check if the code resource wants to force a sync (update data from catalog)
		kDETcmdDoSync					Give code resource a chance to sync (read in and break all attributes)

		kDETcmdPropertyCommand			Command received in the property number range (usually means a button's been pushed)

		kDETcmdMaximumTextLength		Return maximum size for text form of property

		kDETcmdPropertyDirtied			Property dirtied, need to redraw

		kDETcmdPatternIn				Custom pattern element encountered on reading in an attribute
		kDETcmdPatternOut				Custom pattern element encountered on writing out an attribute

		kDETcmdConvertToNumber			Convert from template-defined property type to number
		kDETcmdConvertToRString			Convert from template-defined property type to RString
		kDETcmdConvertFromNumber		Convert from number to template-defined property type
		kDETcmdConvertFromRString		Convert from RString to template-defined property type

		kDETcmdCustomViewDraw			Custom view draw
		kDETcmdCustomViewMouseDown		Custom view mouse down

		kDETcmdKeyPress					Key press (used primarily to filter entry into EditText views)
		kDETcmdPaste					Paste (used primarily to filter entry into EditText views)

		kDETcmdCustomMenuSelected		Custom Catalogs menu selected
		kDETcmdCustomMenuEnabled		Return whether custom Catalogs menu entry should be enabled
*/

enum {
	kDETcmdSimpleCall			= 0,
	kDETcmdInit,
	kDETcmdExit,
	kDETcmdAttributeCreation,
	kDETcmdDynamicForwarders,
	kDETcmdTargetedCall			= 1000,
	kDETcmdInstanceInit,
	kDETcmdInstanceExit,
	kDETcmdIdle,
	kDETcmdViewListChanged,
	kDETcmdValidateSave,
	kDETcmdDropQuery,
	kDETcmdDropMeQuery,
	kDETcmdAttributeNew,
	kDETcmdAttributeChange,
	kDETcmdAttributeDelete,
	kDETcmdItemNew,
	kDETcmdOpenSelf,
	kDETcmdDynamicResource,
	kDETcmdShouldSync,
	kDETcmdDoSync,
	kDETcmdPropertyCall			= 2000,
	kDETcmdPropertyCommand,
	kDETcmdMaximumTextLength,
	kDETcmdPropertyDirtied,
	kDETcmdPatternIn,
	kDETcmdPatternOut,
	kDETcmdConvertToNumber,
	kDETcmdConvertToRString,
	kDETcmdConvertFromNumber,
	kDETcmdConvertFromRString,
	kDETcmdCustomViewDraw,
	kDETcmdCustomViewMouseDown,
	kDETcmdKeyPress,
	kDETcmdPaste,
	kDETcmdCustomMenuSelected,
	kDETcmdCustomMenuEnabled,
	kDETcmdHighCall				= 0xF0000000					/* Force the type to be long */
};

typedef unsigned long DETCallFunctions;

#define DETCallBlockHeader 		\
	DETCallFunctions reqFunction;	 \
	DETCallBack callBack;			\
	long callBackPrivate;			\
	long templatePrivate;
#define DETCallBlockTargetedHeader  \
	DETCallFunctions reqFunction;	 \
	DETCallBack callBack;			\
	long callBackPrivate;			\
	long templatePrivate;			\
	long instancePrivate;			\
	DETTargetSpecification target;	 \
	Boolean targetIsMainAspect;	 \
	Boolean filler1;
#define DETCallBlockPropertyHeader  \
	DETCallFunctions reqFunction;	 \
	DETCallBack callBack;			\
	long callBackPrivate;			\
	long templatePrivate;			\
	long instancePrivate;			\
	DETTargetSpecification target;	 \
	Boolean targetIsMainAspect;	 \
	Boolean filler1; 			\
	short property;
struct DETProtoCallBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	short							property;
};

typedef struct DETProtoCallBlock DETProtoCallBlock;

struct DETInitBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							newCallFors;				/* <-  New call-for mask */
};

typedef struct DETInitBlock DETInitBlock;

struct DETExitBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
};

typedef struct DETExitBlock DETExitBlock;

struct DETInstanceInitBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
};

typedef struct DETInstanceInitBlock DETInstanceInitBlock;

struct DETInstanceExitBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
};

typedef struct DETInstanceExitBlock DETInstanceExitBlock;

struct DETInstanceIdleBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
};

typedef struct DETInstanceIdleBlock DETInstanceIdleBlock;

struct DETPropertyCommandBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	short							property;
	long							parameter;					/*  -> Parameter of command */
};

typedef struct DETPropertyCommandBlock DETPropertyCommandBlock;

struct DETMaximumTextLengthBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	short							property;
	long							maxSize;					/* <-  Return the maximum number of characters the user can entry when property is edited in an EditText */
};

typedef struct DETMaximumTextLengthBlock DETMaximumTextLengthBlock;

struct DETViewListChangedBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
};

typedef struct DETViewListChangedBlock DETViewListChangedBlock;

struct DETPropertyDirtiedBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	short							property;
};

typedef struct DETPropertyDirtiedBlock DETPropertyDirtiedBlock;

struct DETValidateSaveBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	RStringHandle					errorString;				/* <-  Handle with error string if validation fails (callee must allocate handle, DE will DisposHandle() it) */
};

typedef struct DETValidateSaveBlock DETValidateSaveBlock;

/* Valid commandIDs for DETDropQueryBlock and DETDropMeQueryBlock (in addition to property numbers): */

enum {
	kDETDoNothing				= 'xxx0',
	kDETMove					= 'move',
	kDETDrag					= 'drag',
	kDETAlias					= 'alis'
};

struct DETDropQueryBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	short							modifiers;					/*  -> Modifiers at drop time (option/control/command/shift keys) */
	long							commandID;					/* <-> Command ID (kDETDoNothing, kDETMove, kDETDrag (copy), kDETAlias, or a property number) */
	AttributeType					destinationType;			/* <-> Type to convert attribute to */
	Boolean							copyToHFS;					/* <-  If true, object should be copied to HFS before being operated on, and deleted after */
	Boolean							filler2;
};

typedef struct DETDropQueryBlock DETDropQueryBlock;

struct DETDropMeQueryBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	short							modifiers;					/*  -> Modifiers at drop time (option/control/command/shift keys) */
	long							commandID;					/* <-> Command ID (kDETDoNothing, kDETMove, kDETDrag (copy), kDETAlias, or a property number) */
	AttributeType					destinationType;			/* <-> Type to convert attribute to */
	Boolean							copyToHFS;					/* <-  If true, object should be copied to HFS before being operated on, and deleted after */
	Boolean							filler2;
};

typedef struct DETDropMeQueryBlock DETDropMeQueryBlock;

struct DETAttributeCreationBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	PackedDSSpecPtr					parent;						/*  -> The object within which the creation will occur */
	short							refNum;						/*  -> Refnum for returned address (DSSpecs in PDs only) */
	AuthIdentity					identity;					/*  -> The identity we're browsing as in the parent object */
	AttributeType					attrType;					/* <-> The type of the attribute being created */
	AttributeTag					attrTag;					/* <-> The tag of the attribute being created */
	Handle							value;						/* <-> The value to write (pre-allocated, resize as needed) */
};

typedef struct DETAttributeCreationBlock DETAttributeCreationBlock;

struct DETAttributeNewBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	PackedDSSpecPtr					parent;						/*  -> The object within which the creation will occur */
	short							refNum;						/*  -> Refnum for returned address (DSSpecs in PDs only) */
	AuthIdentity					identity;					/*  -> The identity we're browsing as in the parent object */
	AttributeType					attrType;					/* <-> The type of the attribute being created */
	AttributeTag					attrTag;					/* <-> The tag of the attribute being created */
	Handle							value;						/* <-> The value to write (pre-allocated, resize as needed) */
};

typedef struct DETAttributeNewBlock DETAttributeNewBlock;

struct DETAttributeChangeBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	PackedDSSpecPtr					parent;						/*  -> The object within which the creation will occur */
	short							refNum;						/*  -> Refnum for returned address (DSSpecs in PDs only) */
	AuthIdentity					identity;					/*  -> The identity we're browsing as in the parent object */
	AttributeType					attrType;					/* <-> The type of the attribute being changed */
	AttributeTag					attrTag;					/* <-> The tag of the attribute being changed */
	AttributeCreationID				attrCID;					/* <-> The CID of the attribute being changed */
	Handle							value;						/* <-> The value to write (pre-allocated, resize as needed) */
};

typedef struct DETAttributeChangeBlock DETAttributeChangeBlock;

struct DETAttributeDeleteBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	PackedDSSpecPtr					dsSpec;						/*  -> The object which will be deleted */
	short							refNum;						/*  -> Refnum for returned address (DSSpecs in PDs only) */
	AuthIdentity					identity;					/*  -> The identity we're browsing as */
};

typedef struct DETAttributeDeleteBlock DETAttributeDeleteBlock;

struct DETItemNewBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
};

typedef struct DETItemNewBlock DETItemNewBlock;

struct DETShouldSyncBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	Boolean							shouldSync;					/* <-  True if we should now sync with catalog */
	Boolean							filler2;
};

typedef struct DETShouldSyncBlock DETShouldSyncBlock;

struct DETDoSyncBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
};

typedef struct DETDoSyncBlock DETDoSyncBlock;

struct DETPatternInBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	short							property;
	long							elementType;				/*  -> Element type from pattern */
	long							extra;						/*  -> Extra field from pattern */
	AttributePtr					attribute;					/*  -> The complete attribute */
	long							dataOffset;					/* <-> Offset to current (next) byte */
	short							bitOffset;					/* <-> Bit offset (next bit is *fData >> fBitOffset++) */
};

typedef struct DETPatternInBlock DETPatternInBlock;

struct DETPatternOutBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	short							property;
	long							elementType;				/*  -> Element type from pattern */
	long							extra;						/*  -> Extra field from pattern */
	AttributePtr					attribute;					/*  -> The attribute (minus the data portion) */
	Handle							data;						/*  -> Data to be written (pre-allocated, resize and add at end) */
	long							dataOffset;					/* <-> Offset to next byte to write */
	short							bitOffset;					/* <-> Bit offset (if zero, handle will need to be resized to one more byte before write) */
};

typedef struct DETPatternOutBlock DETPatternOutBlock;

struct DETOpenSelfBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	short							modifiers;					/*  -> Modifiers at open time (option/control/command/shift keys) */
};

typedef struct DETOpenSelfBlock DETOpenSelfBlock;

struct DETConvertToNumberBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	short							property;
	long							theValue;					/* <-  The converted value to return */
};

typedef struct DETConvertToNumberBlock DETConvertToNumberBlock;

struct DETConvertToRStringBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	short							property;
	RStringHandle					theValue;					/* <-  A handle with the converted value (callee must allocate handle, DE will DisposHandle() it) */
};

typedef struct DETConvertToRStringBlock DETConvertToRStringBlock;

struct DETConvertFromNumberBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	short							property;
	long							theValue;					/*  -> The value to convert (result should be written direct to the property) */
};

typedef struct DETConvertFromNumberBlock DETConvertFromNumberBlock;

struct DETConvertFromRStringBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	short							property;
	RStringPtr						theValue;					/*  -> The value to convert (result should be written direct to the property) */
};

typedef struct DETConvertFromRStringBlock DETConvertFromRStringBlock;

struct DETCustomViewDrawBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	short							property;
};

typedef struct DETCustomViewDrawBlock DETCustomViewDrawBlock;

struct DETCustomViewMouseDownBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	short							property;
	EventRecord						*theEvent;					/*  -> The original event record of the mouse-down */
};

typedef struct DETCustomViewMouseDownBlock DETCustomViewMouseDownBlock;

struct DETKeyPressBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	short							property;
	EventRecord						*theEvent;					/*  -> The original event record of the key-press */
};

typedef struct DETKeyPressBlock DETKeyPressBlock;

struct DETPasteBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	short							property;
	short							modifiers;					/*  -> Modifiers at paste time (option/control/command/shift keys) */
};

typedef struct DETPasteBlock DETPasteBlock;

struct DETCustomMenuSelectedBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	short							menuTableParameter;			/*  -> The "property" field from the custom menu table */
};

typedef struct DETCustomMenuSelectedBlock DETCustomMenuSelectedBlock;

struct DETCustomMenuEnabledBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	short							menuTableParameter;			/*  -> The "property" field from the custom menu table */
	Boolean							enable;						/* <-  Whether to enable the menu item */
	Boolean							filler2;
};

typedef struct DETCustomMenuEnabledBlock DETCustomMenuEnabledBlock;

struct DETForwarderListItem {
	struct DETForwarderListItem		**next;						/* Pointer to next item, or nil */
	AttributeTag					attributeValueTag;			/* Tag of new templates (0 for none) */
	PackedPathName					rstrs;						/* Record type (empty if none), attrbute type (empty if none),
												list of template names to forward to */
};

typedef struct DETForwarderListItem **DETForwarderListHandle;

struct DETDynamicForwardersBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	DETForwarderListHandle			forwarders;					/* <-  List of forwaders */
};

typedef struct DETDynamicForwardersBlock DETDynamicForwardersBlock;

struct DETDynamicResourceBlock {
	DETCallFunctions				reqFunction;
	DETCallBack						callBack;
	long							callBackPrivate;
	long							templatePrivate;
	long							instancePrivate;
	DETTargetSpecification			target;
	Boolean							targetIsMainAspect;
	Boolean							filler1;
	ResType							resourceType;				/*  -> The resource type being requested */
	short							propertyNumber;				/*  -> The property number of the resource being requested */
	short							resourceID;					/*  -> The resource ID (base ID + property number) of the resource */
	Handle							theResource;				/* <-  The requested resource */
};

typedef struct DETDynamicResourceBlock DETDynamicResourceBlock;

union DETCallBlock {
	DETProtoCallBlock				protoCall;
	DETInitBlock					init;
	DETExitBlock					exit;
	DETInstanceInitBlock			instanceInit;
	DETInstanceExitBlock			instanceExit;
	DETInstanceIdleBlock			instanceIdle;
	DETPropertyCommandBlock			propertyCommand;
	DETMaximumTextLengthBlock		maximumTextLength;
	DETViewListChangedBlock			viewListChanged;
	DETPropertyDirtiedBlock			propertyDirtied;
	DETValidateSaveBlock			validateSave;
	DETDropQueryBlock				dropQuery;
	DETDropMeQueryBlock				dropMeQuery;
	DETAttributeCreationBlock		attributeCreationBlock;
	DETAttributeNewBlock			attributeNew;
	DETAttributeChangeBlock			attributeChange;
	DETAttributeDeleteBlock			attributeDelete;
	DETItemNewBlock					itemNew;
	DETPatternInBlock				patternIn;
	DETPatternOutBlock				patternOut;
	DETShouldSyncBlock				shouldSync;
	DETDoSyncBlock					doSync;
	DETOpenSelfBlock				openSelf;
	DETConvertToNumberBlock			convertToNumber;
	DETConvertToRStringBlock		convertToRString;
	DETConvertFromNumberBlock		convertFromNumber;
	DETConvertFromRStringBlock		convertFromRString;
	DETCustomViewDrawBlock			customViewDraw;
	DETCustomViewMouseDownBlock		customViewMouseDown;
	DETKeyPressBlock				keyPress;
	DETPasteBlock					paste;
	DETCustomMenuSelectedBlock		customMenuSelected;
	DETCustomMenuEnabledBlock		customMenuEnabled;
	DETDynamicForwardersBlock		dynamicForwarders;
	DETDynamicResourceBlock			dynamicResource;
};
typedef union DETCallBlock DETCallBlock;

typedef DETCallBlock *DETCallBlockPtr;

enum {
	uppDETCallBackProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(DETCallBlock*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(DETCallBackBlockPtr)))
};

#if GENERATINGCFM
#define CallDETCallBackProc(userRoutine, callBlockPtr, callBackBlockPtr)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDETCallBackProcInfo, (callBlockPtr), (callBackBlockPtr))
#else
#define CallDETCallBackProc(userRoutine, callBlockPtr, callBackBlockPtr)		\
		(*(userRoutine))((callBlockPtr), (callBackBlockPtr))
#endif

#if GENERATINGCFM
#define NewDETCallBackProc(userRoutine)		\
		(DETCallBackUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDETCallBackProcInfo, GetCurrentArchitecture())
#else
#define NewDETCallBackProc(userRoutine)		\
		((DETCallBackUPP) (userRoutine))
#endif


enum {
	kDETCallForOther			= 1,							/* Call for things not listed below (also auto-enabled by DE if any of the below are enabled) */
	kDETCallForIdle				= 2,							/* kDETcmdIdle */
	kDETCallForCommands			= 4,							/* kDETcmdPropertyCommand, kDETcmdSelfOpen */
	kDETCallForViewChanges		= 8,							/* kDETcmdViewListChanged, kDETcmdPropertyDirtied, kDETcmdMaximumTextLength */
	kDETCallForDrops			= 0x10,							/* kDETcmdDropQuery, kDETcmdDropMeQuery */
	kDETCallForAttributes		= 0x20,							/* kDETcmdAttributeCreation, kDETcmdAttributeNew, kDETcmdAttributeChange, kDETcmdAttributeDelete */
	kDETCallForValidation		= 0x40,							/* kDETcmdValidateSave */
	kDETCallForKeyPresses		= 0x80,							/* kDETcmdKeyPress and kDETcmdPaste */
	kDETCallForResources		= 0x100,						/* kDETcmdDynamicResource */
	kDETCallForSyncing			= 0x200,						/* kDETcmdShouldSync, kDETcmdDoSync */
	kDETCallForEscalation		= 0x8000,						/* All calls escalated from the next lower level */
	kDETCallForNothing			= 0,							/* None of the above
	* All of the above */
	kDETCallForEverything		= 0xFFFFFFFF
};

typedef pascal OSErr (*DETCallProcPtr)(DETCallBlockPtr callBlockPtr);

#if GENERATINGCFM
typedef UniversalProcPtr DETCallUPP;
#else
typedef DETCallProcPtr DETCallUPP;
#endif

enum {
	uppDETCallProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(DETCallBlockPtr)))
};

#if GENERATINGCFM
#define NewDETCallProc(userRoutine)		\
		(DETCallUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDETCallProcInfo, GetCurrentArchitecture())
#else
#define NewDETCallProc(userRoutine)		\
		((DETCallUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallDETCallProc(userRoutine, callBlockPtr)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDETCallProcInfo, (callBlockPtr))
#else
#define CallDETCallProc(userRoutine, callBlockPtr)		\
		(*(userRoutine))((callBlockPtr))
#endif

typedef DETCallUPP DETCall;

/* This following macro saves you from having to dig out the call-back pointer from the call block: */
#define CallBackDET(callBlockPtr, callBackBlockPtr) CallDETCallBackProc(callBlockPtr->protoCall.callBack,callBlockPtr,callBackBlockPtr)
#endif /* REZ */
#define kSAMFirstDevProperty kDETFirstDevProperty + 10
#define kSAMAspectUserName kDETFirstDevProperty + 1
#define kSAMAspectKind kDETFirstDevProperty + 2
#define kSAMAspectCannotDelete kDETFirstDevProperty + 3
#define kSAMAspectSlotCreationInfo kDETFirstDevProperty + 4
#define kDETAdminVersion -978
#ifndef REZ

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* REZ */
#endif /* __OCETEMPLATES__ */
