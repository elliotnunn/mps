{
     File:       Controls.p
 
     Contains:   Control Manager interfaces
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Controls;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CONTROLS__}
{$SETC __CONTROLS__ := 1}

{$I+}
{$SETC ControlsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}
{$IFC UNDEFINED __TEXTEDIT__}
{$I TextEdit.p}
{$ENDC}
{$IFC UNDEFINED __DRAG__}
{$I Drag.p}
{$ENDC}
{$IFC UNDEFINED __ICONS__}
{$I Icons.p}
{$ENDC}
{$IFC UNDEFINED __COLLECTIONS__}
{$I Collections.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{  • Resource Types                                                                                    }
{——————————————————————————————————————————————————————————————————————————————————————————————————————}

CONST
	kControlDefProcType			= 'CDEF';
	kControlTemplateResourceType = 'CNTL';
	kControlColorTableResourceType = 'cctb';
	kControlDefProcResourceType	= 'CDEF';

	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Format of a ‘CNTL’ resource                                                                       	}
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}

TYPE
	ControlTemplatePtr = ^ControlTemplate;
	ControlTemplate = RECORD
		controlRect:			Rect;
		controlValue:			SInt16;
		controlVisible:			BOOLEAN;
		fill:					SInt8;
		controlMaximum:			SInt16;
		controlMinimum:			SInt16;
		controlDefProcID:		SInt16;
		controlReference:		SInt32;
		controlTitle:			Str255;
	END;

	ControlTemplateHandle				= ^ControlTemplatePtr;


{$IFC NOT TARGET_OS_MAC }
	{
	  —————————————————————————————————————————————————————————————————————————————————————————————————————————
	   • NON-MAC COMPATIBILITY CODES (QuickTime 3.0)
	  —————————————————————————————————————————————————————————————————————————————————————————————————————————
	}
	ControlNotification					= UInt32;

CONST
	controlNotifyNothing		= 'nada';						{  No (null) notification }
	controlNotifyClick			= 'clik';						{  Control was clicked }
	controlNotifyFocus			= 'focu';						{  Control got keyboard focus }
	controlNotifyKey			= 'key ';						{  Control got a keypress }


TYPE
	ControlCapabilities					= UInt32;

CONST
	kControlCanAutoInvalidate	= $00000001;					{  Control component automatically invalidates areas left behind after hide/move operation. }

	{  procID's for our added "controls" }
	staticTextProc				= 256;							{  static text }
	editTextProc				= 272;							{  editable text }
	iconProc					= 288;							{  icon }
	userItemProc				= 304;							{  user drawn item }
	pictItemProc				= 320;							{  pict }

{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{  • ControlRef                                                                                        }
{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }

TYPE
	ControlRecordPtr = ^ControlRecord;
	ControlPtr							= ^ControlRecord;
	ControlRef							= ^ControlPtr;
{$ELSEC}

TYPE
	ControlRef    = ^LONGINT; { an opaque 32-bit type }
	ControlRefPtr = ^ControlRef;  { when a VAR xx:ControlRef parameter can be nil, it is changed to xx: ControlRefPtr }
{$ENDC}

	{  ControlHandle is obsolete. Use ControlRef. }
	ControlHandle						= ControlRef;
	ControlPartCode						= SInt16;
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
	{	 • Control ActionProcPtr                                                                              	}
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
{$IFC TYPED_FUNCTION_POINTERS}
	ControlActionProcPtr = PROCEDURE(theControl: ControlRef; partCode: ControlPartCode);
{$ELSEC}
	ControlActionProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ControlActionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ControlActionUPP = UniversalProcPtr;
{$ENDC}	
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
	{	  • ControlRecord                                                                                     	}
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }
	ControlRecord = PACKED RECORD
		nextControl:			ControlRef;								{  in Carbon use embedding heirarchy functions }
		contrlOwner:			WindowRef;								{  in Carbon use GetControlOwner or EmbedControl }
		contrlRect:				Rect;									{  in Carbon use Get/SetControlBounds }
		contrlVis:				UInt8;									{  in Carbon use IsControlVisible, SetControlVisibility }
		contrlHilite:			UInt8;									{  in Carbon use GetControlHilite, HiliteControl }
		contrlValue:			SInt16;									{  in Carbon use Get/SetControlValue, Get/SetControl32BitValue }
		contrlMin:				SInt16;									{  in Carbon use Get/SetControlMinimum, Get/SetControl32BitMinimum }
		contrlMax:				SInt16;									{  in Carbon use Get/SetControlMaximum, Get/SetControl32BitMaximum }
		contrlDefProc:			Handle;									{  not supported in Carbon }
		contrlData:				Handle;									{  in Carbon use Get/SetControlDataHandle }
		contrlAction:			ControlActionUPP;						{  in Carbon use Get/SetControlAction }
		contrlRfCon:			SInt32;									{  in Carbon use Get/SetControlReference }
		contrlTitle:			Str255;									{  in Carbon use Get/SetControlTitle }
	END;

{$ENDC}

	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
	{	 • Control ActionProcPtr : Epilogue                                                                   	}
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}

CONST
	uppControlActionProcInfo = $000002C0;
	{
	 *  NewControlActionUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewControlActionUPP(userRoutine: ControlActionProcPtr): ControlActionUPP; { old name was NewControlActionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeControlActionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeControlActionUPP(userUPP: ControlActionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeControlActionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeControlActionUPP(theControl: ControlRef; partCode: ControlPartCode; userRoutine: ControlActionUPP); { old name was CallControlActionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{  • Control Color Table                                                                               }
{——————————————————————————————————————————————————————————————————————————————————————————————————————}

CONST
	cFrameColor					= 0;
	cBodyColor					= 1;
	cTextColor					= 2;
	cThumbColor					= 3;
	kNumberCtlCTabEntries		= 4;


TYPE
	CtlCTabPtr = ^CtlCTab;
	CtlCTab = RECORD
		ccSeed:					SInt32;
		ccRider:				SInt16;
		ctSize:					SInt16;
		ctTable:				ARRAY [0..3] OF ColorSpec;
	END;

	CCTabPtr							= ^CtlCTab;
	CCTabHandle							= ^CCTabPtr;
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Auxiliary Control Record                                                                          	}
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }
	AuxCtlRecPtr = ^AuxCtlRec;
	AuxCtlRec = RECORD
		acNext:					Handle;									{  not supported in Carbon }
		acOwner:				ControlRef;								{  not supported in Carbon }
		acCTable:				CCTabHandle;							{  not supported in Carbon }
		acFlags:				SInt16;									{  not supported in Carbon }
		acReserved:				SInt32;									{  not supported in Carbon }
		acRefCon:				SInt32;									{  in Carbon use Get/SetControlProperty if you need more refCons }
	END;

	AuxCtlPtr							= ^AuxCtlRec;
	AuxCtlHandle						= ^AuxCtlPtr;
{$ENDC}

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Control Variants                                                                  	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	ControlVariant						= SInt16;

CONST
	kControlNoVariant			= 0;							{  No variant }
	kControlUsesOwningWindowsFontVariant = $08;					{  Control uses owning windows font to display text }


	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Control Part Codes                                                                	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 Basic part codes 	}
	kControlNoPart				= 0;
	kControlIndicatorPart		= 129;
	kControlDisabledPart		= 254;
	kControlInactivePart		= 255;

	{	 Use this constant in Get/SetControlData when the data referred to is not         	}
	{	 specific to a part, but rather the entire control, e.g. the list handle of a     	}
	{	 list box control.                                                                	}
	kControlEntireControl		= 0;

	{	  Meta-Parts                                                                          	}
	{	                                                                                      	}
	{	  If you haven't guessed from looking at other toolbox headers. We like the word      	}
	{	  'meta'. It's cool. So here's one more for you. A meta-part is a part used in a call 	}
	{	  to the GetControlRegion API. These parts are parts that might be defined by a       	}
	{	  control, but should not be returned from calls like TestControl, et al. They define 	}
	{	  a region of a control, presently the structure and the content region. The content  	}
	{	  region is only defined by controls that can embed other controls. It is the area    	}
	{	  that embedded content can live.                                                     	}
	{	                                                                                      	}
	{	  Along with these parts, you can also pass in normal part codes to get the regions   	}
	{	  of the parts. Not all controls fully support this at the time this was written.     	}
	kControlStructureMetaPart	= -1;
	kControlContentMetaPart		= -2;

	{	 focusing part codes 	}
	kControlFocusNoPart			= 0;							{  tells control to clear its focus }
	kControlFocusNextPart		= -1;							{  tells control to focus on the next part }
	kControlFocusPrevPart		= -2;							{  tells control to focus on the previous part }


TYPE
	ControlFocusPart					= SInt16;
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Control Collection Tags                                                                           	}
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
	{	  These are standard tags that you will find in a flattened Control's Collection.                     	}
	{	                                                                                                      	}
	{	  All tags at ID zero in a flattened Control's Collection is reserved for Control Manager use.        	}
	{	  Custom control definitions should use other IDs.                                                    	}
	{	                                                                                                      	}
	{	  Most of these tags are interpreted when you call CreateCustomControl; the Control Manager will      	}
	{	  put value in the right place before calling the Control Definition with the initialization message. 	}
	{	  Other tags are only interpreted when calling UnflattenControl.                                      	}

CONST
	kControlCollectionTagBounds	= 'boun';						{  Rect - the bounding rectangle }
	kControlCollectionTagValue	= 'valu';						{  SInt32 - the value }
	kControlCollectionTagMinimum = 'min ';						{  SInt32 - the minimum }
	kControlCollectionTagMaximum = 'max ';						{  SInt32 - the maximum }
	kControlCollectionTagViewSize = 'view';						{  SInt32 - the view size }
	kControlCollectionTagVisibility = 'visi';					{  Boolean - the visible state }
	kControlCollectionTagRefCon	= 'refc';						{  SInt32 - the refCon }
	kControlCollectionTagTitle	= 'titl';						{  arbitrarily sized character array - the title }
	kControlCollectionTagUnicodeTitle = 'uttl';					{  bytes as received via CFStringCreateExternalRepresentation }
	kControlCollectionTagIDSignature = 'idsi';					{  OSType - the ControlID signature }
	kControlCollectionTagIDID	= 'idid';						{  SInt32 - the ControlID id }
	kControlCollectionTagCommand = 'cmd ';						{  UInt32 - the command }
	kControlCollectionTagVarCode = 'varc';						{  SInt16 - the variant }

	{	  The following are additional tags which are only interpreted by UnflattenControl. 	}
	kControlCollectionTagSubControls = 'subc';					{  data for all of a control's subcontrols }


	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Control Image Content                                                                             	}
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
	kControlContentTextOnly		= 0;
	kControlNoContent			= 0;
	kControlContentIconSuiteRes	= 1;
	kControlContentCIconRes		= 2;
	kControlContentPictRes		= 3;
	kControlContentICONRes		= 4;
	kControlContentIconSuiteHandle = 129;
	kControlContentCIconHandle	= 130;
	kControlContentPictHandle	= 131;
	kControlContentIconRef		= 132;
	kControlContentICON			= 133;


TYPE
	ControlContentType					= SInt16;
	ControlButtonContentInfoPtr = ^ControlButtonContentInfo;
	ControlButtonContentInfo = RECORD
		contentType:			ControlContentType;
		CASE INTEGER OF
		0: (
			resID:				SInt16;
			);
		1: (
			cIconHandle:		CIconHandle;
			);
		2: (
			iconSuite:			Handle;
			);
		3: (
			iconRef:			IconRef;
			);
		4: (
			picture:			PicHandle;
			);
		5: (
			ICONHandle:			Handle;
			);
	END;

	ControlImageContentInfo				= ControlButtonContentInfo;
	ControlImageContentInfoPtr 			= ^ControlImageContentInfo;
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Control Key Script Behavior                                                                       	}
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}

CONST
	kControlKeyScriptBehaviorAllowAnyScript = 'any ';			{  leaves the current keyboard alone and allows user to change the keyboard. }
	kControlKeyScriptBehaviorPrefersRoman = 'prmn';				{  switches the keyboard to roman, but allows them to change it as desired. }
	kControlKeyScriptBehaviorRequiresRoman = 'rrmn';			{  switches the keyboard to roman and prevents the user from changing it. }


TYPE
	ControlKeyScriptBehavior			= UInt32;
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Control Font Style                                                                                	}
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
	{	    SPECIAL FONT USAGE NOTES: You can specify the font to use for many control types.
	    The constants below are meta-font numbers which you can use to set a particular
	    control's font usage. There are essentially two modes you can use: 1) default,
	    which is essentially the same as it always has been, i.e. it uses the system font, unless
	    directed to use the window font via a control variant. 2) you can specify to use
	    the big or small system font in a generic manner. The Big system font is the font
	    used in menus, etc. Chicago has filled that role for some time now. Small system
	    font is currently Geneva 10. The meta-font number implies the size and style.
	
	    NOTE:       Not all font attributes are used by all controls. Most, in fact, ignore
	                the fore and back color (Static Text is the only one that does, for
	                backwards compatibility). Also size, face, and addFontSize are ignored
	                when using the meta-font numbering.
		}
	{	 Meta-font numbering - see note above 	}

CONST
	kControlFontBigSystemFont	= -1;							{  force to big system font }
	kControlFontSmallSystemFont	= -2;							{  force to small system font }
	kControlFontSmallBoldSystemFont = -3;						{  force to small bold system font }
	kControlFontViewSystemFont	= -4;							{  force to views system font (DataBrowser control only) }

	{	 Add these masks together to set the flags field of a ControlFontStyleRec 	}
	{	 They specify which fields to apply to the text. It is important to make  	}
	{	 sure that you specify only the fields that you wish to set.              	}
	kControlUseFontMask			= $0001;
	kControlUseFaceMask			= $0002;
	kControlUseSizeMask			= $0004;
	kControlUseForeColorMask	= $0008;
	kControlUseBackColorMask	= $0010;
	kControlUseModeMask			= $0020;
	kControlUseJustMask			= $0040;
	kControlUseAllMask			= $00FF;
	kControlAddFontSizeMask		= $0100;

	{	 AddToMetaFont indicates that we want to start with a standard system     	}
	{	 font, but then we'd like to add the other attributes. Normally, the meta 	}
	{	 font ignores all other flags                                             	}
	kControlAddToMetaFontMask	= $0200;						{  Available in Appearance 1.1 or later }

	{	 UseThemeFontID indicates that the font field of the ControlFontStyleRec  	}
	{	 should be interpreted as a ThemeFontID (see Appearance.h). In all other  	}
	{	 ways, specifying a ThemeFontID is just like using one of the control     	}
	{	 meta-fonts IDs.                                                          	}
	kControlUseThemeFontIDMask	= $0080;						{  Available in Mac OS X or later }


TYPE
	ControlFontStyleRecPtr = ^ControlFontStyleRec;
	ControlFontStyleRec = RECORD
		flags:					SInt16;
		font:					SInt16;
		size:					SInt16;
		style:					SInt16;
		mode:					SInt16;
		just:					SInt16;
		foreColor:				RGBColor;
		backColor:				RGBColor;
	END;

	ControlFontStylePtr					= ^ControlFontStyleRec;
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Click Activation Results                                                                          	}
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
	{	  These are for use with GetControlClickActivation. The enumerated values should be pretty            	}
	{	  self-explanatory, but just in case:                                                                 	}
	{	  • Activate/DoNotActivate indicates whether or not to change the owning window's z-ordering before   	}
	{	      processing the click. If activation is requested, you may also want to immediately redraw the   	}
	{	      newly exposed portion of the window.                                                            	}
	{	  • Ignore/Handle Click indicates whether or not to call an appropriate click handling API (like      	}
	{	      HandleControlClick) in respose to the event.                                                    	}

CONST
	kDoNotActivateAndIgnoreClick = 0;							{  probably never used. here for completeness. }
	kDoNotActivateAndHandleClick = 1;							{  let the control handle the click while the window is still in the background. }
	kActivateAndIgnoreClick		= 2;							{  control doesn't want to respond directly to the click, but window should still be brought forward. }
	kActivateAndHandleClick		= 3;							{  control wants to respond to the click, but only after the window has been activated. }


TYPE
	ClickActivationResult				= UInt32;
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Common data tags for Get/SetControlData                                                           	}
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}

	{
	 *  Discussion:
	 *    Get/SetControlData Common Tags
	 	}

CONST
	kControlFontStyleTag		= 'font';
	kControlKeyFilterTag		= 'fltr';
	kControlKindTag				= 'kind';
	kControlSizeTag				= 'size';

	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Control Feature Bits                                                                              	}
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
																{  Control feature bits - returned by GetControlFeatures  }
	kControlSupportsGhosting	= $01;
	kControlSupportsEmbedding	= $02;
	kControlSupportsFocus		= $04;
	kControlWantsIdle			= $08;
	kControlWantsActivate		= $10;
	kControlHandlesTracking		= $20;
	kControlSupportsDataAccess	= $40;
	kControlHasSpecialBackground = $80;
	kControlGetsFocusOnClick	= $0100;
	kControlSupportsCalcBestRect = $0200;
	kControlSupportsLiveFeedback = $0400;
	kControlHasRadioBehavior	= $0800;						{  Available in Appearance 1.0.1 or later }
	kControlSupportsDragAndDrop	= $1000;						{  Available in Carbon }
	kControlAutoToggles			= $4000;						{  Available in Appearance 1.1 or later }
	kControlSupportsGetRegion	= $00020000;					{  Available in Appearance 1.1 or later }
	kControlSupportsFlattening	= $00080000;					{  Available in Carbon }
	kControlSupportsSetCursor	= $00100000;					{  Available in Carbon }
	kControlSupportsContextualMenus = $00200000;				{  Available in Carbon }
	kControlSupportsClickActivation = $00400000;				{  Available in Carbon }
	kControlIdlesWithTimer		= $00800000;					{  Available in Carbon - this bit indicates that the control animates automatically }

	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Control Messages                                                                                  	}
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
	drawCntl					= 0;
	testCntl					= 1;
	calcCRgns					= 2;
	initCntl					= 3;
	dispCntl					= 4;
	posCntl						= 5;
	thumbCntl					= 6;
	dragCntl					= 7;
	autoTrack					= 8;
	calcCntlRgn					= 10;
	calcThumbRgn				= 11;
	drawThumbOutline			= 12;
	kControlMsgDrawGhost		= 13;
	kControlMsgCalcBestRect		= 14;							{  Calculate best fitting rectangle for control }
	kControlMsgHandleTracking	= 15;
	kControlMsgFocus			= 16;							{  param indicates action. }
	kControlMsgKeyDown			= 17;
	kControlMsgIdle				= 18;
	kControlMsgGetFeatures		= 19;
	kControlMsgSetData			= 20;
	kControlMsgGetData			= 21;
	kControlMsgActivate			= 22;
	kControlMsgSetUpBackground	= 23;
	kControlMsgCalcValueFromPos	= 26;
	kControlMsgTestNewMsgSupport = 27;							{  See if this control supports new messaging }
	kControlMsgSubValueChanged	= 25;							{  Available in Appearance 1.0.1 or later }
	kControlMsgSubControlAdded	= 28;							{  Available in Appearance 1.0.1 or later }
	kControlMsgSubControlRemoved = 29;							{  Available in Appearance 1.0.1 or later }
	kControlMsgApplyTextColor	= 30;							{  Available in Appearance 1.1 or later }
	kControlMsgGetRegion		= 31;							{  Available in Appearance 1.1 or later }
	kControlMsgFlatten			= 32;							{  Available in Carbon. Param is Collection. }
	kControlMsgSetCursor		= 33;							{  Available in Carbon. Param is ControlSetCursorRec }
	kControlMsgDragEnter		= 38;							{  Available in Carbon. Param is DragRef, result is boolean indicating acceptibility of drag. }
	kControlMsgDragLeave		= 39;							{  Available in Carbon. As above. }
	kControlMsgDragWithin		= 40;							{  Available in Carbon. As above. }
	kControlMsgDragReceive		= 41;							{  Available in Carbon. Param is DragRef, result is OSStatus indicating success/failure. }
	kControlMsgDisplayDebugInfo	= 46;							{  Available in Carbon on X. }
	kControlMsgContextualMenuClick = 47;						{  Available in Carbon. Param is ControlContextualMenuClickRec }
	kControlMsgGetClickActivation = 48;							{  Available in Carbon. Param is ControlClickActivationRec }


TYPE
	ControlDefProcMessage				= SInt16;
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Control Sizes                                                                     	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

CONST
	kControlSizeNormal			= 0;
	kControlSizeSmall			= 1;
	kControlSizeLarge			= 2;
	kControlSizeAuto			= $FFFF;


TYPE
	ControlSize							= UInt16;
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Constants for drawCntl message (passed in param)                                  	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

CONST
	kDrawControlEntireControl	= 0;
	kDrawControlIndicatorOnly	= 129;

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Constants for dragCntl message (passed in param)                                  	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	kDragControlEntireControl	= 0;
	kDragControlIndicator		= 1;

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Drag Constraint Structure for thumbCntl message (passed in param)                 	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

TYPE
	IndicatorDragConstraintPtr = ^IndicatorDragConstraint;
	IndicatorDragConstraint = RECORD
		limitRect:				Rect;
		slopRect:				Rect;
		axis:					DragConstraint;
	END;

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  CDEF should return as result of kControlMsgTestNewMsgSupport                        	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

CONST
	kControlSupportsNewMessages	= ' ok ';

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  This structure is passed into a CDEF when called with the kControlMsgHandleTracking 	}
	{	  message                                                                             	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

TYPE
	ControlTrackingRecPtr = ^ControlTrackingRec;
	ControlTrackingRec = RECORD
		startPt:				Point;
		modifiers:				EventModifiers;
		action:					ControlActionUPP;
	END;

	ControlTrackingPtr					= ^ControlTrackingRec;
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 This structure is passed into a CDEF when called with the kControlMsgKeyDown message 	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	ControlKeyDownRecPtr = ^ControlKeyDownRec;
	ControlKeyDownRec = RECORD
		modifiers:				EventModifiers;
		keyCode:				SInt16;
		charCode:				SInt16;
	END;

	ControlKeyDownPtr					= ^ControlKeyDownRec;
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 This structure is passed into a CDEF when called with the kControlMsgGetData or      	}
	{	 kControlMsgSetData message                                                           	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	ControlDataAccessRecPtr = ^ControlDataAccessRec;
	ControlDataAccessRec = RECORD
		tag:					ResType;
		part:					ResType;
		size:					Size;
		dataPtr:				Ptr;
	END;

	ControlDataAccessPtr				= ^ControlDataAccessRec;
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 This structure is passed into a CDEF when called with the kControlCalcBestRect msg   	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	ControlCalcSizeRecPtr = ^ControlCalcSizeRec;
	ControlCalcSizeRec = RECORD
		height:					SInt16;
		width:					SInt16;
		baseLine:				SInt16;
	END;

	ControlCalcSizePtr					= ^ControlCalcSizeRec;
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 This structure is passed into a CDEF when called with the kControlMsgSetUpBackground 	}
	{	 message is sent                                                                      	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	ControlBackgroundRecPtr = ^ControlBackgroundRec;
	ControlBackgroundRec = RECORD
		depth:					SInt16;
		colorDevice:			BOOLEAN;
	END;

	ControlBackgroundPtr				= ^ControlBackgroundRec;
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 This structure is passed into a CDEF when called with the kControlMsgApplyTextColor  	}
	{	 message is sent                                                                      	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	ControlApplyTextColorRecPtr = ^ControlApplyTextColorRec;
	ControlApplyTextColorRec = RECORD
		depth:					SInt16;
		colorDevice:			BOOLEAN;
		active:					BOOLEAN;
	END;

	ControlApplyTextColorPtr			= ^ControlApplyTextColorRec;
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 This structure is passed into a CDEF when called with the kControlMsgGetRegion       	}
	{	 message is sent                                                                      	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	ControlGetRegionRecPtr = ^ControlGetRegionRec;
	ControlGetRegionRec = RECORD
		region:					RgnHandle;
		part:					ControlPartCode;
	END;

	ControlGetRegionPtr					= ^ControlGetRegionRec;
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 This structure is passed into a CDEF when the kControlMsgSetCursor message is sent   	}
	{	 Only sent on Carbon                                                                  	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	ControlSetCursorRecPtr = ^ControlSetCursorRec;
	ControlSetCursorRec = RECORD
		localPoint:				Point;
		modifiers:				EventModifiers;
		cursorWasSet:			BOOLEAN;								{  your CDEF must set this to true if you set the cursor, or false otherwise }
	END;

	ControlSetCursorPtr					= ^ControlSetCursorRec;
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 This structure is passed into a CDEF when the kControlMsgContextualMenuClick message 	}
	{	 is sent                                                                              	}
	{	 Only sent on Carbon                                                                  	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	ControlContextualMenuClickRecPtr = ^ControlContextualMenuClickRec;
	ControlContextualMenuClickRec = RECORD
		localPoint:				Point;
		menuDisplayed:			BOOLEAN;								{  your CDEF must set this to true if you displayed a menu, or false otherwise }
	END;

	ControlContextualMenuClickPtr		= ^ControlContextualMenuClickRec;
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 This structure is passed into a CDEF when the kControlMsgGetClickActivation message  	}
	{	 is sent                                                                              	}
	{	 Only sent on Carbon                                                                  	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	ControlClickActivationRecPtr = ^ControlClickActivationRec;
	ControlClickActivationRec = RECORD
		localPoint:				Point;
		modifiers:				EventModifiers;
		result:					ClickActivationResult;					{  your CDEF must pass the desired result back }
	END;

	ControlClickActivationPtr			= ^ControlClickActivationRec;
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • ‘CDEF’ entrypoint                                                                 	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
{$IFC TYPED_FUNCTION_POINTERS}
	ControlDefProcPtr = FUNCTION(varCode: SInt16; theControl: ControlRef; message: ControlDefProcMessage; param: SInt32): SInt32;
{$ELSEC}
	ControlDefProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ControlDefUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ControlDefUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppControlDefProcInfo = $00003BB0;
	{
	 *  NewControlDefUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewControlDefUPP(userRoutine: ControlDefProcPtr): ControlDefUPP; { old name was NewControlDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeControlDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeControlDefUPP(userUPP: ControlDefUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeControlDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeControlDefUPP(varCode: SInt16; theControl: ControlRef; message: ControlDefProcMessage; param: SInt32; userRoutine: ControlDefUPP): SInt32; { old name was CallControlDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{  Control Key Filter                                                                  }
{——————————————————————————————————————————————————————————————————————————————————————}
{ Certain controls can have a keyfilter attached to them.                              }
{ Definition of a key filter for intercepting and possibly changing keystrokes         }
{ which are destined for a control.                                                    }
{ Key Filter Result Codes                                                          }
{ The filter proc should return one of the two constants below. If                 }
{ kKeyFilterBlockKey is returned, the key is blocked and never makes it to the     }
{ control. If kKeyFilterPassKey is returned, the control receives the keystroke.   }

CONST
	kControlKeyFilterBlockKey	= 0;
	kControlKeyFilterPassKey	= 1;


TYPE
	ControlKeyFilterResult				= SInt16;
{$IFC TYPED_FUNCTION_POINTERS}
	ControlKeyFilterProcPtr = FUNCTION(theControl: ControlRef; VAR keyCode: SInt16; VAR charCode: SInt16; VAR modifiers: EventModifiers): ControlKeyFilterResult;
{$ELSEC}
	ControlKeyFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ControlKeyFilterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ControlKeyFilterUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppControlKeyFilterProcInfo = $00003FE0;
	{
	 *  NewControlKeyFilterUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewControlKeyFilterUPP(userRoutine: ControlKeyFilterProcPtr): ControlKeyFilterUPP; { old name was NewControlKeyFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeControlKeyFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeControlKeyFilterUPP(userUPP: ControlKeyFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeControlKeyFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeControlKeyFilterUPP(theControl: ControlRef; VAR keyCode: SInt16; VAR charCode: SInt16; VAR modifiers: EventModifiers; userRoutine: ControlKeyFilterUPP): ControlKeyFilterResult; { old name was CallControlKeyFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}


{——————————————————————————————————————————————————————————————————————————————————————}
{  • DragGrayRgn Constatns                                                             }
{                                                                                      }
{   For DragGrayRgnUPP used in TrackControl()                                          }
{——————————————————————————————————————————————————————————————————————————————————————}

CONST
	noConstraint				= 0;
	hAxisOnly					= 1;
	vAxisOnly					= 2;

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Control Creation/Deletion/Persistence                                             	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  CreateCustomControl is only available as part of Carbon                             	}
	kControlDefProcPtr			= 0;							{  raw proc-ptr based access }
	kControlDefObjectClass		= 1;							{  event-based definition (Carbon 1.1 or later) }


TYPE
	ControlDefType						= UInt32;
	ControlDefSpecPtr = ^ControlDefSpec;
	ControlDefSpec = RECORD
		defType:				ControlDefType;
		CASE INTEGER OF
		0: (
			defProc:			ControlDefUPP;
			);
		1: (
			classRef:			Ptr;
			);
	END;

	{
	 *  CreateCustomControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateCustomControl(owningWindow: WindowRef; {CONST}VAR contBounds: Rect; {CONST}VAR def: ControlDefSpec; initData: Collection; VAR outControl: ControlRef): OSStatus;

{
 *  NewControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewControl(owningWindow: WindowRef; {CONST}VAR boundsRect: Rect; controlTitle: Str255; initiallyVisible: BOOLEAN; initialValue: SInt16; minimumValue: SInt16; maximumValue: SInt16; procID: SInt16; controlReference: SInt32): ControlRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A954;
	{$ENDC}

{
 *  GetNewControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetNewControl(resourceID: SInt16; owningWindow: WindowRef): ControlRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9BE;
	{$ENDC}

{
 *  DisposeControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeControl(theControl: ControlRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A955;
	{$ENDC}

{
 *  KillControls()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE KillControls(theWindow: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A956;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  FlattenControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FlattenControl(control: ControlRef; flattenSubControls: BOOLEAN; collection: Collection): OSStatus;

{
 *  UnflattenControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UnflattenControl(window: WindowRef; collection: Collection; VAR outControl: ControlRef): OSStatus;

{$ENDC}  {CALL_NOT_IN_CARBON}

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Control Definition Registration                                                   }
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ControlCNTLToCollectionProcPtr = FUNCTION({CONST}VAR bounds: Rect; value: SInt16; visible: BOOLEAN; max: SInt16; min: SInt16; procID: SInt16; refCon: SInt32; title: Str255; collection: Collection): OSStatus;
{$ELSEC}
	ControlCNTLToCollectionProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ControlCNTLToCollectionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ControlCNTLToCollectionUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppControlCNTLToCollectionProcInfo = $00FEA6F0;
	{
	 *  NewControlCNTLToCollectionUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewControlCNTLToCollectionUPP(userRoutine: ControlCNTLToCollectionProcPtr): ControlCNTLToCollectionUPP; { old name was NewControlCNTLToCollectionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeControlCNTLToCollectionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeControlCNTLToCollectionUPP(userUPP: ControlCNTLToCollectionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeControlCNTLToCollectionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeControlCNTLToCollectionUPP({CONST}VAR bounds: Rect; value: SInt16; visible: BOOLEAN; max: SInt16; min: SInt16; procID: SInt16; refCon: SInt32; title: Str255; collection: Collection; userRoutine: ControlCNTLToCollectionUPP): OSStatus; { old name was CallControlCNTLToCollectionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  RegisterControlDefinition()
 *  
 *  Summary:
 *    Associates or dissociates a control definition with a virtual
 *    CDEF resource ID.
 *  
 *  Discussion:
 *    In GetNewControl or NewControl on Carbon, the Control Manager
 *    needs to know how to map the procID to a ControlDefSpec. With
 *    RegisterControlDefinition, your application can inform the
 *    Control Manager which ControlDefSpec to call when it sees a
 *    request to use a 'CDEF' of a particular resource ID. Since custom
 *    control definitions receive their initialization data in a
 *    Collection, you must also provide a procedure to convert the
 *    bounds, min, max, and other parameters to NewControl into a
 *    Collection. If you don't provide a conversion proc, your control
 *    will receive an empty collection when it is sent the
 *    initialization message. If you want the value, min, visibility,
 *    etc. to be given to the control, you must add the appropriate
 *    tagged data to the collection. See the Control Collection Tags
 *    above. If you want to unregister a ControlDefSpec that you have
 *    already registered, call RegisterControlDefinition with the same
 *    CDEF resource ID, but pass NULL for the inControlDef parameter.
 *    In this situation, inConversionProc is effectively ignored.
 *  
 *  Parameters:
 *    
 *    inCDEFResID:
 *      The virtual CDEF resource ID to which you'd like to associate
 *      or dissociate the control definition.
 *    
 *    inControlDef:
 *      A pointer to a ControlDefSpec which represents the control
 *      definition you want to register, or NULL if you are attempting
 *      to unregister a control definition.
 *    
 *    inConversionProc:
 *      The conversion proc which will translate the NewControl
 *      parameters into a Collection.
 *  
 *  Result:
 *    An OSStatus code indicating success or failure.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RegisterControlDefinition(inCDEFResID: SInt16; {CONST}VAR inControlDef: ControlDefSpec; inConversionProc: ControlCNTLToCollectionUPP): OSStatus;



{——————————————————————————————————————————————————————————————————————————————————————}
{  • Control Visible State                                                             }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  HiliteControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE HiliteControl(theControl: ControlRef; hiliteState: ControlPartCode);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95D;
	{$ENDC}

{
 *  ShowControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ShowControl(theControl: ControlRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A957;
	{$ENDC}

{
 *  HideControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE HideControl(theControl: ControlRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A958;
	{$ENDC}


{  following state routines available only with Appearance 1.0 and later }
{
 *  IsControlActive()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsControlActive(inControl: ControlRef): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0005, $AA73;
	{$ENDC}

{
 *  IsControlVisible()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsControlVisible(inControl: ControlRef): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0006, $AA73;
	{$ENDC}

{
 *  ActivateControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ActivateControl(inControl: ControlRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0007, $AA73;
	{$ENDC}

{
 *  DeactivateControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DeactivateControl(inControl: ControlRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0008, $AA73;
	{$ENDC}

{
 *  SetControlVisibility()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetControlVisibility(inControl: ControlRef; inIsVisible: BOOLEAN; inDoDraw: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001E, $AA73;
	{$ENDC}


{  following state routines available only on Mac OS X and later }
{
 *  IsControlEnabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsControlEnabled(inControl: ControlRef): BOOLEAN;

{
 *  EnableControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION EnableControl(inControl: ControlRef): OSStatus;

{
 *  DisableControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DisableControl(inControl: ControlRef): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Control Imaging                                                                   }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  DrawControls()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DrawControls(theWindow: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A969;
	{$ENDC}

{
 *  Draw1Control()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE Draw1Control(theControl: ControlRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A96D;
	{$ENDC}


{
 *  UpdateControls()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE UpdateControls(theWindow: WindowRef; updateRegion: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A953;
	{$ENDC}


{  following imaging routines available only with Appearance 1.0 and later }
{
 *  GetBestControlRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetBestControlRect(inControl: ControlRef; VAR outRect: Rect; VAR outBaseLineOffset: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001B, $AA73;
	{$ENDC}

{
 *  SetControlFontStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetControlFontStyle(inControl: ControlRef; {CONST}VAR inStyle: ControlFontStyleRec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001C, $AA73;
	{$ENDC}

{
 *  DrawControlInCurrentPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DrawControlInCurrentPort(inControl: ControlRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0018, $AA73;
	{$ENDC}

{
 *  SetUpControlBackground()
 *  
 *  Summary:
 *    Applies the proper background color for the given control to the
 *    current port.
 *  
 *  Discussion:
 *    An embedding-savvy control which erases before drawing must
 *    ensure that its background color properly matches the body color
 *    of any parent controls on top of which it draws. This routine
 *    asks the Control Manager to determine and apply the proper
 *    background color to the current port. If a ControlColorProc has
 *    been provided for the given control, the proc will be called to
 *    set up the background color. If no proc exists, or if the proc
 *    returns a value other than noErr, the Control Manager ascends the
 *    parent chain for the given control looking for a control which
 *    has a special background (see the kControlHasSpecialBackground
 *    feature bit). The first such parent is asked to set up the
 *    background color (see the kControlMsgSetUpBackground message). If
 *    no such parent exists, the Control Manager applies any ThemeBrush
 *    which has been associated with the owning window (see
 *    SetThemeWindowBackground). Available in Appearance 1.0 (Mac OS
 *    8), CarbonLib 1.0, Mac OS X, and later.
 *  
 *  Parameters:
 *    
 *    inControl:
 *      The ControlRef that wants to erase.
 *    
 *    inDepth:
 *      A short integer indicating the color depth of the device onto
 *      which drawing will take place.
 *    
 *    inIsColorDevice:
 *      A Boolean indicating whether the draw device is a color device.
 *  
 *  Result:
 *    An OSStatus code indicating success or failure. The most likely
 *    error is a controlHandleInvalidErr, resulting from a bad
 *    ControlRef. Any non-noErr result indicates that the color set up
 *    failed, and that the caller should probably give up its attempt
 *    to draw.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetUpControlBackground(inControl: ControlRef; inDepth: SInt16; inIsColorDevice: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001D, $AA73;
	{$ENDC}

{
 *  SetUpControlTextColor()
 *  
 *  Summary:
 *    Applies the proper text color for the given control to the
 *    current port.
 *  
 *  Discussion:
 *    An embedding-savvy control which draws text must ensure that its
 *    text color properly contrasts the background on which it draws.
 *    This routine asks the Control Manager to determine and apply the
 *    proper text color to the current port. If a ControlColorProc has
 *    been provided for the given control, the proc will be called to
 *    set up the text color. If no proc exists, or if the proc returns
 *    a value other than noErr, the Control Manager ascends the parent
 *    chain for the given control looking for a control which has a
 *    special background (see the kControlHasSpecialBackground feature
 *    bit). The first such parent is asked to set up the text color
 *    (see the kControlMsgApplyTextColor message). If no such parent
 *    exists, the Control Manager chooses a text color which contrasts
 *    any ThemeBrush which has been associated with the owning window
 *    (see SetThemeWindowBackground). Available in Appearance 1.1 (Mac
 *    OS 8.5), CarbonLib 1.0, Mac OS X, and later.
 *  
 *  Parameters:
 *    
 *    inControl:
 *      The ControlRef that wants to draw text.
 *    
 *    inDepth:
 *      A short integer indicating the color depth of the device onto
 *      which drawing will take place.
 *    
 *    inIsColorDevice:
 *      A Boolean indicating whether the draw device is a color device.
 *  
 *  Result:
 *    An OSStatus code indicating success or failure. The most likely
 *    error is a controlHandleInvalidErr, resulting from a bad
 *    ControlRef. Any non-noErr result indicates that the color set up
 *    failed, and that the caller should probably give up its attempt
 *    to draw.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetUpControlTextColor(inControl: ControlRef; inDepth: SInt16; inIsColorDevice: BOOLEAN): OSErr;



{
 *  ControlColorProcPtr
 *  
 *  Discussion:
 *    Callback allowing clients to specify/override the background
 *    color and text color that a Control will use during drawing. Your
 *    procedure should make the color changes to the current port. See
 *    SetControlColorProc, SetUpControlBackground, and
 *    SetUpControlTextColor for more information. Available on Mac OS
 *    8.5, CarbonLib 1.1, Mac OS X, and later.
 *  
 *  Parameters:
 *    
 *    inControl:
 *      A reference to the Control for whom your proc is setting up
 *      colors.
 *    
 *    inMessage:
 *      A ControlDefProcMessage indicating what sort of color your
 *      procedure should set up. It will be either
 *      kControlMsgApplyTextColor or kControlMsgSetUpBackground.
 *      kControlMsgApplyTextColor is a request to set up the
 *      appropriate text color (by setting the current port's
 *      foreground color, pen information, etc.).
 *      kControlMsgSetUpBackground is a request to set up the
 *      appropriate background color (the current port's background
 *      color, pattern, etc.).
 *    
 *    inDrawDepth:
 *      A short integer indicating the bit depth of the device into
 *      which the Control is drawing. The bit depth is typically passed
 *      in as a result of someone someone trying to draw properly
 *      across multiple monitors with different bit depths. If your
 *      procedure wants to handle proper color set up based on bit
 *      depth, it should use this parameter to help decide what color
 *      to apply.
 *    
 *    inDrawInColor:
 *      A Boolean indicating whether or not the device that the Control
 *      is drawing into is a color device. The value is typically
 *      passed in as a result of someone trying to draw properly across
 *      multiple monitors which may or may not be color devices. If
 *      your procedure wants to handle proper color set up for both
 *      color and grayscale devices, it should use this parameter to
 *      help decide what color to apply.
 *  
 *  Result:
 *    An OSStatus code indicating success or failure. Returning noErr
 *    is an indication that your proc completely handled the color set
 *    up. If you return any other value, the Control Manager will fall
 *    back to the normal color set up mechanism.
 }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ControlColorProcPtr = FUNCTION(inControl: ControlRef; inMessage: SInt16; inDrawDepth: SInt16; inDrawInColor: BOOLEAN): OSStatus;
{$ELSEC}
	ControlColorProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ControlColorUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ControlColorUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppControlColorProcInfo = $00001AF0;
	{
	 *  NewControlColorUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewControlColorUPP(userRoutine: ControlColorProcPtr): ControlColorUPP; { old name was NewControlColorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeControlColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeControlColorUPP(userUPP: ControlColorUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeControlColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeControlColorUPP(inControl: ControlRef; inMessage: SInt16; inDrawDepth: SInt16; inDrawInColor: BOOLEAN; userRoutine: ControlColorUPP): OSStatus; { old name was CallControlColorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  SetControlColorProc()
 *  
 *  Summary:
 *    Associates a ControlColorUPP with a given Control, thereby
 *    allowing you to bypass the embedding hierarchy-based color setup
 *    of SetUpControlBackground/SetUpControlTextColor and replace it
 *    with your own.
 *  
 *  Discussion:
 *    Before an embedded Control can erase, it calls
 *    SetUpControlBackground to have its background color set up by any
 *    parent controls. Similarly, any Control which draws text calls
 *    SetUpControlTextColor to have the appropriate text color set up.
 *    This allows certain controls (such as Tabs and Placards) to offer
 *    special backgrounds and text colors for any child controls. By
 *    default, the SetUp routines only move up the Control Manager
 *    embedding hierarchy looking for a parent which has a special
 *    background. This is fine in a plain vanilla embedding case, but
 *    many application frameworks find it troublesome; if there are
 *    interesting views between two Controls in the embedding
 *    hierarchy, the framework needs to be in charge of the background
 *    and text colors, otherwise drawing defects will occur. You can
 *    only associate a single color proc with a given ControlRef.
 *    Available on Mac OS 8.5, CarbonLib 1.1, Mac OS X, and later.
 *  
 *  Parameters:
 *    
 *    inControl:
 *      The ControlRef with whom the color proc should be associated.
 *    
 *    inProc:
 *      The color proc to associate with the ControlRef. If you pass
 *      NULL, the ControlRef will be dissociated from any previously
 *      installed color proc.
 *  
 *  Result:
 *    An OSStatus code indicating success or failure. The most likely
 *    error is a controlHandleInvalidErr resulting from a bad
 *    ControlRef.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetControlColorProc(inControl: ControlRef; inProc: ControlColorUPP): OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————}
{  • Control Mousing                                                                   }
{——————————————————————————————————————————————————————————————————————————————————————}
{
    NOTE ON CONTROL ACTION PROCS

    When using the TrackControl() call when tracking an indicator, the actionProc parameter
    (type ControlActionUPP) should be replaced by a parameter of type DragGrayRgnUPP
    (see Quickdraw.h).

    If, however, you are using the live feedback variants of scroll bars or sliders, you
    must pass a ControlActionUPP in when tracking the indicator as well. This functionality
    is available in Appearance 1.0 or later.
}
{
 *  TrackControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TrackControl(theControl: ControlRef; startPoint: Point; actionProc: ControlActionUPP): ControlPartCode;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A968;
	{$ENDC}

{
 *  DragControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DragControl(theControl: ControlRef; startPoint: Point; {CONST}VAR limitRect: Rect; {CONST}VAR slopRect: Rect; axis: DragConstraint);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A967;
	{$ENDC}

{
 *  TestControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TestControl(theControl: ControlRef; testPoint: Point): ControlPartCode;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A966;
	{$ENDC}

{
 *  FindControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FindControl(testPoint: Point; theWindow: WindowRef; VAR theControl: ControlRef): ControlPartCode;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A96C;
	{$ENDC}

{ The following mousing routines available only with Appearance 1.0 and later  }
{                                                                              }
{ HandleControlClick is preferable to TrackControl when running under          }
{ Appearance 1.0 as you can pass in modifiers, which some of the new controls  }
{ use, such as edit text and list boxes.                                       }
{
 *  FindControlUnderMouse()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FindControlUnderMouse(inWhere: Point; inWindow: WindowRef; VAR outPart: SInt16): ControlRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0009, $AA73;
	{$ENDC}

{
 *  HandleControlClick()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HandleControlClick(inControl: ControlRef; inWhere: Point; inModifiers: EventModifiers; inAction: ControlActionUPP): ControlPartCode;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000A, $AA73;
	{$ENDC}

{ Contextual Menu support in the Control Manager is only available on Carbon.  }
{ If the control didn't display a contextual menu (possibly because the point  }
{ was in a non-interesting part), the menuDisplayed output parameter will be   }
{ false. If the control did display a menu, menuDisplayed will be true.        }
{ This in on Carbon only                                                       }
{
 *  HandleControlContextualMenuClick()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HandleControlContextualMenuClick(inControl: ControlRef; inWhere: Point; VAR menuDisplayed: BOOLEAN): OSStatus;

{ Some complex controls (like Data Browser) require proper sequencing of       }
{ window activation and click processing. In some cases, the control might     }
{ want the window to be left inactive yet still handle the click, or vice-     }
{ versa. The GetControlClickActivation routine lets a control client ask the   }
{ control how it wishes to behave for a particular click.                      }
{ This in on Carbon only.                                                      }
{
 *  GetControlClickActivation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlClickActivation(inControl: ControlRef; inWhere: Point; inModifiers: EventModifiers; VAR outResult: ClickActivationResult): OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————}
{  • Control Events (available only with Appearance 1.0 and later)                     }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  HandleControlKey()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HandleControlKey(inControl: ControlRef; inKeyCode: SInt16; inCharCode: SInt16; inModifiers: EventModifiers): ControlPartCode;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000B, $AA73;
	{$ENDC}

{
 *  IdleControls()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE IdleControls(inWindow: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000C, $AA73;
	{$ENDC}



{——————————————————————————————————————————————————————————————————————————————————————}
{ • Control Mouse Tracking (available with Carbon)                                     }
{——————————————————————————————————————————————————————————————————————————————————————}
{ The HandleControlSetCursor routine requests that a given control set the cursor to   }
{ something appropriate based on the mouse location.                                   }
{ If the control didn't want to set the cursor (because the point was in a             }
{ non-interesting part), the cursorWasSet output parameter will be false. If the       }
{ control did set the cursor, cursorWasSet will be true.                               }
{ Carbon only.                                                                         }
{
 *  HandleControlSetCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HandleControlSetCursor(control: ControlRef; localPoint: Point; modifiers: EventModifiers; VAR cursorWasSet: BOOLEAN): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Control Positioning                                                               }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  MoveControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE MoveControl(theControl: ControlRef; h: SInt16; v: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A959;
	{$ENDC}

{
 *  SizeControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SizeControl(theControl: ControlRef; w: SInt16; h: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95C;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Control Title                                                                     }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  SetControlTitle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetControlTitle(theControl: ControlRef; title: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95F;
	{$ENDC}

{
 *  GetControlTitle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetControlTitle(theControl: ControlRef; VAR title: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95E;
	{$ENDC}

{
 *  SetControlTitleWithCFString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetControlTitleWithCFString(inControl: ControlRef; inString: CFStringRef): OSStatus;

{
 *  CopyControlTitleAsCFString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CopyControlTitleAsCFString(inControl: ControlRef; VAR outString: CFStringRef): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Control Value                                                                     }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  GetControlValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlValue(theControl: ControlRef): SInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A960;
	{$ENDC}

{
 *  SetControlValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetControlValue(theControl: ControlRef; newValue: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A963;
	{$ENDC}

{
 *  GetControlMinimum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlMinimum(theControl: ControlRef): SInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A961;
	{$ENDC}

{
 *  SetControlMinimum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetControlMinimum(theControl: ControlRef; newMinimum: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A964;
	{$ENDC}

{
 *  GetControlMaximum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlMaximum(theControl: ControlRef): SInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A962;
	{$ENDC}

{
 *  SetControlMaximum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetControlMaximum(theControl: ControlRef; newMaximum: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A965;
	{$ENDC}


{  proportional scrolling/32-bit value support is new with Appearance 1.1 }

{
 *  GetControlViewSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlViewSize(theControl: ControlRef): SInt32;

{
 *  SetControlViewSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetControlViewSize(theControl: ControlRef; newViewSize: SInt32);

{
 *  GetControl32BitValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControl32BitValue(theControl: ControlRef): SInt32;

{
 *  SetControl32BitValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetControl32BitValue(theControl: ControlRef; newValue: SInt32);

{
 *  GetControl32BitMaximum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControl32BitMaximum(theControl: ControlRef): SInt32;

{
 *  SetControl32BitMaximum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetControl32BitMaximum(theControl: ControlRef; newMaximum: SInt32);

{
 *  GetControl32BitMinimum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControl32BitMinimum(theControl: ControlRef): SInt32;

{
 *  SetControl32BitMinimum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetControl32BitMinimum(theControl: ControlRef; newMinimum: SInt32);

{
    IsValidControlHandle will tell you if the handle you pass in belongs to a control
    the Control Manager knows about. It does not sanity check the data in the control.
}

{
 *  IsValidControlHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsValidControlHandle(theControl: ControlRef): BOOLEAN;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Control IDs                                                                        }
{ Carbon only.                                                                         }
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	ControlIDPtr = ^ControlID;
	ControlID = RECORD
		signature:				OSType;
		id:						SInt32;
	END;

	{
	 *  SetControlID()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION SetControlID(inControl: ControlRef; {CONST}VAR inID: ControlID): OSStatus;

{
 *  GetControlID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlID(inControl: ControlRef; VAR outID: ControlID): OSStatus;

{
 *  GetControlByID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlByID(inWindow: WindowRef; {CONST}VAR inID: ControlID; VAR outControl: ControlRef): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Control Command IDs                                                                    }
{ Carbon only.                                                                         }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  SetControlCommandID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetControlCommandID(inControl: ControlRef; inCommandID: UInt32): OSStatus;

{
 *  GetControlCommandID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlCommandID(inControl: ControlRef; VAR outCommandID: UInt32): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Control Identification                                                             }
{ Carbon only.                                                                         }
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	ControlKindPtr = ^ControlKind;
	ControlKind = RECORD
		signature:				OSType;
		kind:					OSType;
	END;


	{
	 *  Discussion:
	 *    Control signature kind
	 	}

CONST
	kControlKindSignatureApple	= 'appl';

	{
	 *  GetControlKind()
	 *  
	 *  Summary:
	 *    Returns the kind of the given control.
	 *  
	 *  Discussion:
	 *    GetControlKind allows you to query the kind of any control. This
	 *    function is only available in Mac OS X.
	 *  
	 *  Parameters:
	 *    
	 *    inControl:
	 *      The ControlRef to find the kind of.
	 *    
	 *    outControlKind:
	 *      On successful exit, this will contain the control signature and
	 *      kind. See ControlDefinitions.h for the kinds of each system
	 *      control.
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION GetControlKind(inControl: ControlRef; VAR outControlKind: ControlKind): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Properties                                                                         }
{——————————————————————————————————————————————————————————————————————————————————————}

CONST
	kControlPropertyPersistent	= $00000001;					{  whether this property gets saved when flattening the control }

	{
	 *  GetControlProperty()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in ControlsLib 8.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION GetControlProperty(control: ControlRef; propertyCreator: OSType; propertyTag: OSType; bufferSize: UInt32; VAR actualSize: UInt32; propertyBuffer: UNIV Ptr): OSStatus;

{
 *  GetControlPropertySize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlPropertySize(control: ControlRef; propertyCreator: OSType; propertyTag: OSType; VAR size: UInt32): OSStatus;

{
 *  SetControlProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetControlProperty(control: ControlRef; propertyCreator: OSType; propertyTag: OSType; propertySize: UInt32; propertyData: UNIV Ptr): OSStatus;

{
 *  RemoveControlProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RemoveControlProperty(control: ControlRef; propertyCreator: OSType; propertyTag: OSType): OSStatus;

{
 *  GetControlPropertyAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlPropertyAttributes(control: ControlRef; propertyCreator: OSType; propertyTag: OSType; VAR attributes: UInt32): OSStatus;

{
 *  ChangeControlPropertyAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ChangeControlPropertyAttributes(control: ControlRef; propertyCreator: OSType; propertyTag: OSType; attributesToSet: UInt32; attributesToClear: UInt32): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Control Regions (Appearance 1.1 or later)                                         }
{                                                                                      }
{  See the discussion on meta-parts in this header for more information                }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  GetControlRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlRegion(inControl: ControlRef; inPart: ControlPartCode; outRegion: RgnHandle): OSStatus;



{——————————————————————————————————————————————————————————————————————————————————————}
{  • Control Variant                                                                   }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  GetControlVariant()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlVariant(theControl: ControlRef): ControlVariant;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A809;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Control Action                                                                    }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  SetControlAction()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetControlAction(theControl: ControlRef; actionProc: ControlActionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A96B;
	{$ENDC}

{
 *  GetControlAction()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlAction(theControl: ControlRef): ControlActionUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A96A;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Control Accessors                                                                  }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  SetControlReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetControlReference(theControl: ControlRef; data: SInt32);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95B;
	{$ENDC}

{
 *  GetControlReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlReference(theControl: ControlRef): SInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95A;
	{$ENDC}

{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }
{
 *  GetAuxiliaryControlRecord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetAuxiliaryControlRecord(theControl: ControlRef; VAR acHndl: AuxCtlHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA44;
	{$ENDC}

{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  SetControlColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetControlColor(theControl: ControlRef; newColorTable: CCTabHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA43;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Control Hierarchy (Appearance 1.0 and later only)                                 }
{——————————————————————————————————————————————————————————————————————————————————————}
{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  SendControlMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SendControlMessage(inControl: ControlRef; inMessage: SInt16; inParam: UNIV Ptr): SInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $FFFE, $AA73;
	{$ENDC}

{
 *  DumpControlHierarchy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DumpControlHierarchy(inWindow: WindowRef; {CONST}VAR inDumpFile: FSSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $FFFF, $AA73;
	{$ENDC}

{
 *  CreateRootControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateRootControl(inWindow: WindowRef; VAR outControl: ControlRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0001, $AA73;
	{$ENDC}

{
 *  GetRootControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetRootControl(inWindow: WindowRef; VAR outControl: ControlRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0002, $AA73;
	{$ENDC}

{
 *  EmbedControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION EmbedControl(inControl: ControlRef; inContainer: ControlRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0003, $AA73;
	{$ENDC}

{
 *  AutoEmbedControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AutoEmbedControl(inControl: ControlRef; inWindow: WindowRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0004, $AA73;
	{$ENDC}

{
 *  GetSuperControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetSuperControl(inControl: ControlRef; VAR outParent: ControlRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0015, $AA73;
	{$ENDC}

{
 *  CountSubControls()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CountSubControls(inControl: ControlRef; VAR outNumChildren: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0016, $AA73;
	{$ENDC}

{
 *  GetIndexedSubControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetIndexedSubControl(inControl: ControlRef; inIndex: UInt16; VAR outSubControl: ControlRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0017, $AA73;
	{$ENDC}

{
 *  SetControlSupervisor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetControlSupervisor(inControl: ControlRef; inBoss: ControlRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001A, $AA73;
	{$ENDC}



{——————————————————————————————————————————————————————————————————————————————————————}
{  • Keyboard Focus (available only with Appearance 1.0 and later)                     }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  GetKeyboardFocus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetKeyboardFocus(inWindow: WindowRef; VAR outControl: ControlRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000D, $AA73;
	{$ENDC}

{
 *  SetKeyboardFocus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetKeyboardFocus(inWindow: WindowRef; inControl: ControlRef; inPart: ControlFocusPart): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000E, $AA73;
	{$ENDC}

{
 *  AdvanceKeyboardFocus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AdvanceKeyboardFocus(inWindow: WindowRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000F, $AA73;
	{$ENDC}

{
 *  ReverseKeyboardFocus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ReverseKeyboardFocus(inWindow: WindowRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0010, $AA73;
	{$ENDC}

{
 *  ClearKeyboardFocus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ClearKeyboardFocus(inWindow: WindowRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0019, $AA73;
	{$ENDC}



{——————————————————————————————————————————————————————————————————————————————————————}
{  • Control Data (available only with Appearance 1.0 and later)                       }
{——————————————————————————————————————————————————————————————————————————————————————}

{
 *  GetControlFeatures()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlFeatures(inControl: ControlRef; VAR outFeatures: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0011, $AA73;
	{$ENDC}

{
 *  SetControlData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetControlData(inControl: ControlRef; inPart: ControlPartCode; inTagName: ResType; inSize: Size; inData: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0012, $AA73;
	{$ENDC}

{
 *  GetControlData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlData(inControl: ControlRef; inPart: ControlPartCode; inTagName: ResType; inBufferSize: Size; inBuffer: UNIV Ptr; VAR outActualSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0013, $AA73;
	{$ENDC}

{
 *  GetControlDataSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlDataSize(inControl: ControlRef; inPart: ControlPartCode; inTagName: ResType; VAR outMaxSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0014, $AA73;
	{$ENDC}


{——————————————————————————————————————————————————————————————————————————————————————}
{  • Control Drag & Drop                                                               }
{      Carbon only.                                                                    }
{——————————————————————————————————————————————————————————————————————————————————————}
{  some simple redefinitions of the similar values found in the Drag header }

CONST
	kDragTrackingEnterControl	= 2;
	kDragTrackingInControl		= 3;
	kDragTrackingLeaveControl	= 4;

	{
	 *  HandleControlDragTracking()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in ControlsLib 9.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION HandleControlDragTracking(inControl: ControlRef; inMessage: DragTrackingMessage; inDrag: DragReference; VAR outLikesDrag: BOOLEAN): OSStatus;

{
 *  HandleControlDragReceive()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HandleControlDragReceive(inControl: ControlRef; inDrag: DragReference): OSStatus;

{
 *  SetControlDragTrackingEnabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetControlDragTrackingEnabled(theControl: ControlRef; tracks: BOOLEAN): OSStatus;

{
 *  IsControlDragTrackingEnabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsControlDragTrackingEnabled(theControl: ControlRef; VAR tracks: BOOLEAN): OSStatus;

{
 *  SetAutomaticControlDragTrackingEnabledForWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetAutomaticControlDragTrackingEnabledForWindow(theWindow: WindowRef; tracks: BOOLEAN): OSStatus;

{
 *  IsAutomaticControlDragTrackingEnabledForWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ControlsLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsAutomaticControlDragTrackingEnabledForWindow(theWindow: WindowRef; VAR tracks: BOOLEAN): OSStatus;



{$IFC NOT TARGET_OS_MAC }
{——————————————————————————————————————————————————————————————————————————————————————}
{  • QuickTime 3.0 Win32/unix notification mechanism                                   }
{——————————————————————————————————————————————————————————————————————————————————————}
{  Proc used to notify window that something happened to the control }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ControlNotificationProcPtr = PROCEDURE(theWindow: WindowRef; theControl: ControlRef; notification: ControlNotification; param1: LONGINT; param2: LONGINT); C;
{$ELSEC}
	ControlNotificationProcPtr = ProcPtr;
{$ENDC}

	{
	   Proc used to prefilter events before handled by control.  A client of a control calls
	   CTRLSetPreFilterProc() to have the control call this proc before handling the event.
	   If the proc returns TRUE, the control can go ahead and handle the event.
	}
{$IFC TYPED_FUNCTION_POINTERS}
	PreFilterEventProc = FUNCTION(theControl: ControlRef; VAR theEvent: EventRecord): BOOLEAN; C;
{$ELSEC}
	PreFilterEventProc = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  GetControlComponentInstance()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION GetControlComponentInstance(theControl: ControlRef): LONGINT; C;

{
 *  GetControlHandleFromCookie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetControlHandleFromCookie(cookie: LONGINT): ControlRef; C;

{
 *  SetControlDefProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetControlDefProc(resID: INTEGER; proc: ControlDefProcPtr); C;

{$ENDC}  {CALL_NOT_IN_CARBON}

TYPE
	ControlNotificationUPP				= ControlNotificationProcPtr;
{$ENDC}

{$IFC OLDROUTINENAMES }
{——————————————————————————————————————————————————————————————————————————————————————}
{  • OLDROUTINENAMES                                                                   }
{——————————————————————————————————————————————————————————————————————————————————————}

CONST
	useWFont					= $08;

	inThumb						= 129;
	kNoHiliteControlPart		= 0;
	kInIndicatorControlPart		= 129;
	kReservedControlPart		= 254;
	kControlInactiveControlPart	= 255;


{$IFC CALL_NOT_IN_CARBON }
	{
	 *  SetCTitle()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE SetCTitle(theControl: ControlRef; title: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95F;
	{$ENDC}

{
 *  GetCTitle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GetCTitle(theControl: ControlRef; VAR title: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95E;
	{$ENDC}

{
 *  UpdtControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE UpdtControl(theWindow: WindowRef; updateRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A953;
	{$ENDC}

{
 *  SetCtlValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetCtlValue(theControl: ControlRef; theValue: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A963;
	{$ENDC}

{
 *  GetCtlValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetCtlValue(theControl: ControlRef): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A960;
	{$ENDC}

{
 *  SetCtlMin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetCtlMin(theControl: ControlRef; minValue: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A964;
	{$ENDC}

{
 *  GetCtlMin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetCtlMin(theControl: ControlRef): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A961;
	{$ENDC}

{
 *  SetCtlMax()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetCtlMax(theControl: ControlRef; maxValue: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A965;
	{$ENDC}

{
 *  GetCtlMax()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetCtlMax(theControl: ControlRef): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A962;
	{$ENDC}

{
 *  SetCRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetCRefCon(theControl: ControlRef; data: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95B;
	{$ENDC}

{
 *  GetCRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetCRefCon(theControl: ControlRef): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95A;
	{$ENDC}

{
 *  SetCtlAction()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetCtlAction(theControl: ControlRef; actionProc: ControlActionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A96B;
	{$ENDC}

{
 *  GetCtlAction()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetCtlAction(theControl: ControlRef): ControlActionUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A96A;
	{$ENDC}

{
 *  SetCtlColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetCtlColor(theControl: ControlRef; newColorTable: CCTabHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA43;
	{$ENDC}

{
 *  GetCVariant()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetCVariant(theControl: ControlRef): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A809;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OLDROUTINENAMES}

{$IFC ACCESSOR_CALLS_ARE_FUNCTIONS }
{ Getters }
{
 *  GetControlBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlBounds(control: ControlRef; VAR bounds: Rect): RectPtr;

{
 *  IsControlHilited()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsControlHilited(control: ControlRef): BOOLEAN;

{
 *  GetControlHilite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlHilite(control: ControlRef): UInt16;

{
 *  GetControlOwner()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlOwner(control: ControlRef): WindowRef;

{
 *  GetControlDataHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlDataHandle(control: ControlRef): Handle;

{
 *  GetControlPopupMenuHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlPopupMenuHandle(control: ControlRef): MenuRef;

{
 *  GetControlPopupMenuID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlPopupMenuID(control: ControlRef): INTEGER;

{ Setters }
{
 *  SetControlDataHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetControlDataHandle(control: ControlRef; dataHandle: Handle);

{
 *  SetControlBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetControlBounds(control: ControlRef; {CONST}VAR bounds: Rect);

{
 *  SetControlPopupMenuHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetControlPopupMenuHandle(control: ControlRef; popupMenu: MenuRef);

{
 *  SetControlPopupMenuID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetControlPopupMenuID(control: ControlRef; menuID: INTEGER);

{$ENDC}  {ACCESSOR_CALLS_ARE_FUNCTIONS}

{$IFC NOT OPAQUE_TOOLBOX_STRUCTS AND NOT ACCESSOR_CALLS_ARE_FUNCTIONS }
{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ControlsIncludes}

{$ENDC} {__CONTROLS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
