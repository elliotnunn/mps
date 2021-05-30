{
     File:       ControlDefinitions.p
 
     Contains:   Definitions of controls provided by the Control Manager
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ControlDefinitions;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CONTROLDEFINITIONS__}
{$SETC __CONTROLDEFINITIONS__ := 1}

{$I+}
{$SETC ControlDefinitionsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __APPEARANCE__}
{$I Appearance.p}
{$ENDC}
{$IFC UNDEFINED __CARBONEVENTS__}
{$I CarbonEvents.p}
{$ENDC}
{$IFC UNDEFINED __CONTROLS__}
{$I Controls.p}
{$ENDC}
{$IFC UNDEFINED __LISTS__}
{$I Lists.p}
{$ENDC}
{$IFC UNDEFINED __MACHELP__}
{$I MacHelp.p}
{$ENDC}
{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}

{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{  • Resource Types                                                                                    }
{——————————————————————————————————————————————————————————————————————————————————————————————————————}


CONST
	kControlTabListResType		= 'tab#';						{  used for tab control (Appearance 1.0 and later) }
	kControlListDescResType		= 'ldes';						{  used for list box control (Appearance 1.0 and later) }

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Check Box Values                                                                  	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	kControlCheckBoxUncheckedValue = 0;
	kControlCheckBoxCheckedValue = 1;
	kControlCheckBoxMixedValue	= 2;

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Radio Button Values                                                               	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	kControlRadioButtonUncheckedValue = 0;
	kControlRadioButtonCheckedValue = 1;
	kControlRadioButtonMixedValue = 2;

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Pop-Up Menu Control Constants                                                     	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{  Variant codes for the System 7 pop-up menu }
	popupFixedWidth				= $01;
	popupVariableWidth			= $02;
	popupUseAddResMenu			= $04;
	popupUseWFont				= $08;

	{  Menu label styles for the System 7 pop-up menu }
	popupTitleBold				= $0100;
	popupTitleItalic			= $0200;
	popupTitleUnderline			= $0400;
	popupTitleOutline			= $0800;
	popupTitleShadow			= $1000;
	popupTitleCondense			= $2000;
	popupTitleExtend			= $4000;
	popupTitleNoStyle			= $8000;

	{  Menu label justifications for the System 7 pop-up menu }
	popupTitleLeftJust			= $00000000;
	popupTitleCenterJust		= $00000001;
	popupTitleRightJust			= $000000FF;

	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
	{	  • PopUp Menu Private Data Structure                                                                 	}
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }

TYPE
	PopupPrivateDataPtr = ^PopupPrivateData;
	PopupPrivateData = RECORD
		mHandle:				MenuRef;
		mID:					SInt16;
	END;

	PopupPrivateDataHandle				= ^PopupPrivateDataPtr;
{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{  • Control Definition ID’s                                                                           }
{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{  Standard System 7 procIDs }


CONST
	pushButProc					= 0;
	checkBoxProc				= 1;
	radioButProc				= 2;
	scrollBarProc				= 16;
	popupMenuProc				= 1008;

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Control Part Codes                                                                	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	kControlLabelPart			= 1;
	kControlMenuPart			= 2;
	kControlTrianglePart		= 4;
	kControlEditTextPart		= 5;							{  Appearance 1.0 and later }
	kControlPicturePart			= 6;							{  Appearance 1.0 and later }
	kControlIconPart			= 7;							{  Appearance 1.0 and later }
	kControlClockPart			= 8;							{  Appearance 1.0 and later }
	kControlListBoxPart			= 24;							{  Appearance 1.0 and later }
	kControlListBoxDoubleClickPart = 25;						{  Appearance 1.0 and later }
	kControlImageWellPart		= 26;							{  Appearance 1.0 and later }
	kControlRadioGroupPart		= 27;							{  Appearance 1.0.2 and later }
	kControlButtonPart			= 10;
	kControlCheckBoxPart		= 11;
	kControlRadioButtonPart		= 11;
	kControlUpButtonPart		= 20;
	kControlDownButtonPart		= 21;
	kControlPageUpPart			= 22;
	kControlPageDownPart		= 23;
	kControlClockHourDayPart	= 9;							{  Appearance 1.1 and later }
	kControlClockMinuteMonthPart = 10;							{  Appearance 1.1 and later }
	kControlClockSecondYearPart	= 11;							{  Appearance 1.1 and later }
	kControlClockAMPMPart		= 12;							{  Appearance 1.1 and later }
	kControlDataBrowserPart		= 24;							{  CarbonLib 1.0 and later }
	kControlDataBrowserDraggedPart = 25;						{  CarbonLib 1.0 and later }



	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Control Types and ID’s available only with Appearance 1.0 and later                               	}
	{	——————————————————————————————————————————————————————————————————————————————————————————————————————	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • BEVEL BUTTON INTERFACE (CDEF 2)                                                   	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  Bevel buttons allow you to control the content type (pict/icon/etc.), the behavior  	}
	{	 (pushbutton/toggle/sticky), and the bevel size. You also have the option of          	}
	{	  attaching a menu to it. When a menu is present, you can specify which way the       	}
	{	  popup arrow is facing (down or right).                                              	}
	{	                                                                                      	}
	{	  This is all made possible by overloading the Min, Max, and Value parameters for the 	}
	{	  control, as well as adjusting the variant. Here's the breakdown of what goes where: 	}
	{	                                                                                      	}
	{	  Parameter                   What Goes Here                                          	}
	{	  ———————————————————         ————————————————————————————————————————————————————    	}
	{	  Min                         Hi Byte = Behavior, Lo Byte = content type.             	}
	{	  Max                         ResID for resource-based content types.                 	}
	{	  Value                       MenuID to attach, 0 = no menu, please.                  	}
	{	                                                                                      	}
	{	  The variant is broken down into two halfs. The low 2 bits control the bevel type.   	}
	{	  Bit 2 controls the popup arrow direction (if a menu is present) and bit 3 controls  	}
	{	  whether or not to use the control's owning window's font.                           	}
	{	                                                                                      	}
	{	  Constants for all you need to put this together are below. The values for behaviors 	}
	{	  are set up so that you can simply add them to the content type and pass them into   	}
	{	  the Min parameter of NewControl.                                                    	}
	{	                                                                                      	}
	{	  An example call:                                                                    	}
	{	                                                                                      	}
	{	  control = NewControl( window, &bounds, "\p", true, 0, kContentIconSuiteRes +        	}
	{	                          kBehaviorToggles, myIconSuiteID, bevelButtonSmallBevelProc, 	}
	{	                          0L );                                                       	}
	{	                                                                                      	}
	{	  Attaching a menu:                                                                   	}
	{	                                                                                      	}
	{	  control = NewControl( window, &bounds, "\p", true, kMyMenuID, kContentIconSuiteRes, 	}
	{	          myIconSuiteID, bevelButtonSmallBevelProc + kBevelButtonMenuOnRight, 0L );   	}
	{	                                                                                      	}
	{	  This will attach menu ID kMyMenuID to the button, with the popup arrow facing right.	}
	{	  This also puts the menu up to the right of the button. You can also specify that a  	}
	{	  menu can have multiple items checked at once by adding kBehaviorMultiValueMenus     	}
	{	  into the Min parameter. If you do use multivalue menus, the GetBevelButtonMenuValue 	}
	{	  helper function will return the last item chosen from the menu, whether or not it   	}
	{	  was checked.                                                                        	}
	{	                                                                                      	}
	{	  NOTE:   Bevel buttons with menus actually have *two* values. The value of the       	}
	{	          button (on/off), and the value of the menu. The menu value can be gotten    	}
	{	          with the GetBevelButtonMenuValue helper function.                           	}
	{	                                                                                      	}
	{	  Handle-based Content                                                                	}
	{	  ————————————————————                                                                	}
	{	  You can create your control and then set the content to an existing handle to an    	}
	{	  icon suite, etc. using the macros below. Please keep in mind that resource-based    	}
	{	  content is owned by the control, handle-based content is owned by you. The CDEF will	}
	{	  not try to dispose of handle-based content. If you are changing the content type of 	}
	{	  the button on the fly, you must make sure that if you are replacing a handle-       	}
	{	  based content with a resource-based content to properly dispose of the handle,      	}
	{	  else a memory leak will ensue.                                                      	}
	{	                                                                                      	}
	{	 Bevel Button Proc IDs 	}
	kControlBevelButtonSmallBevelProc = 32;
	kControlBevelButtonNormalBevelProc = 33;
	kControlBevelButtonLargeBevelProc = 34;

	{	 Add these variant codes to kBevelButtonSmallBevelProc to change the type of button 	}
	kControlBevelButtonSmallBevelVariant = 0;
	kControlBevelButtonNormalBevelVariant = $01;
	kControlBevelButtonLargeBevelVariant = $02;
	kControlBevelButtonMenuOnRightVariant = $04;

	{	 Bevel Thicknesses 	}

TYPE
	ControlBevelThickness 		= UInt16;
CONST
	kControlBevelButtonSmallBevel = 0;
	kControlBevelButtonNormalBevel = 1;
	kControlBevelButtonLargeBevel = 2;

	{	 Behaviors of bevel buttons. These are set up so you can add  	}
	{	 them together with the content types.                        	}
	kControlBehaviorPushbutton	= 0;
	kControlBehaviorToggles		= $0100;
	kControlBehaviorSticky		= $0200;
	kControlBehaviorSingleValueMenu = 0;
	kControlBehaviorMultiValueMenu = $4000;						{  only makes sense when a menu is attached. }
	kControlBehaviorOffsetContents = $8000;

	{	 Behaviors for 1.0.1 or later 	}
	kControlBehaviorCommandMenu	= $2000;						{  menu holds commands, not choices. Overrides multi-value bit. }


TYPE
	ControlBevelButtonBehavior			= UInt16;
	ControlBevelButtonMenuBehavior		= UInt16;
	{	 Bevel Button Menu Placements 	}
	ControlBevelButtonMenuPlacement  = UInt16;
CONST
	kControlBevelButtonMenuOnBottom = 0;
	kControlBevelButtonMenuOnRight = $04;

	{	 Control Kind Tag 	}
	kControlKindBevelButton		= 'bevl';

	{	 Creation API: Carbon Only 	}
	{
	 *  CreateBevelButtonControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateBevelButtonControl(window: WindowRef; {CONST}VAR boundsRect: Rect; title: CFStringRef; thickness: ControlBevelThickness; behavior: ControlBevelButtonBehavior; info: ControlButtonContentInfoPtr; menuID: SInt16; menuBehavior: ControlBevelButtonMenuBehavior; menuPlacement: ControlBevelButtonMenuPlacement; VAR outControl: ControlRef): OSStatus;

{ Graphic Alignments }

TYPE
	ControlButtonGraphicAlignment  = SInt16;
CONST
	kControlBevelButtonAlignSysDirection = -1;					{  only left or right }
	kControlBevelButtonAlignCenter = 0;
	kControlBevelButtonAlignLeft = 1;
	kControlBevelButtonAlignRight = 2;
	kControlBevelButtonAlignTop	= 3;
	kControlBevelButtonAlignBottom = 4;
	kControlBevelButtonAlignTopLeft = 5;
	kControlBevelButtonAlignBottomLeft = 6;
	kControlBevelButtonAlignTopRight = 7;
	kControlBevelButtonAlignBottomRight = 8;

	{	 Text Alignments 	}

TYPE
	ControlButtonTextAlignment 	= SInt16;
CONST
	kControlBevelButtonAlignTextSysDirection = 0;
	kControlBevelButtonAlignTextCenter = 1;
	kControlBevelButtonAlignTextFlushRight = -1;
	kControlBevelButtonAlignTextFlushLeft = -2;

	{	 Text Placements 	}

TYPE
	ControlButtonTextPlacement 	= SInt16;
CONST
	kControlBevelButtonPlaceSysDirection = -1;					{  if graphic on right, then on left }
	kControlBevelButtonPlaceNormally = 0;
	kControlBevelButtonPlaceToRightOfGraphic = 1;
	kControlBevelButtonPlaceToLeftOfGraphic = 2;
	kControlBevelButtonPlaceBelowGraphic = 3;
	kControlBevelButtonPlaceAboveGraphic = 4;


	{	 Data tags supported by the bevel button controls 	}
	kControlBevelButtonContentTag = 'cont';						{  ButtonContentInfo }
	kControlBevelButtonTransformTag = 'tran';					{  IconTransformType }
	kControlBevelButtonTextAlignTag = 'tali';					{  ButtonTextAlignment }
	kControlBevelButtonTextOffsetTag = 'toff';					{  SInt16 }
	kControlBevelButtonGraphicAlignTag = 'gali';				{  ButtonGraphicAlignment }
	kControlBevelButtonGraphicOffsetTag = 'goff';				{  Point }
	kControlBevelButtonTextPlaceTag = 'tplc';					{  ButtonTextPlacement }
	kControlBevelButtonMenuValueTag = 'mval';					{  SInt16 }
	kControlBevelButtonMenuHandleTag = 'mhnd';					{  MenuRef }
	kControlBevelButtonMenuRefTag = 'mhnd';						{  MenuRef }
	kControlBevelButtonOwnedMenuRefTag = 'omrf';				{  MenuRef (control will dispose) }
	kControlBevelButtonCenterPopupGlyphTag = 'pglc';			{  Boolean: true = center, false = bottom right }
	kControlBevelButtonKindTag	= 'bebk';						{  ThemeButtonKind ( kTheme[Small,Medium,Large,Rounded]BevelButton ) }

	{	 These are tags in 1.0.1 or later 	}
	kControlBevelButtonLastMenuTag = 'lmnu';					{  SInt16: menuID of last menu item selected from }
	kControlBevelButtonMenuDelayTag = 'mdly';					{  SInt32: ticks to delay before menu appears }

	{	 tags available with Appearance 1.1 or later 	}
																{  Boolean: True = if an icon of the ideal size for }
																{  the button isn't available, scale a larger or }
																{  smaller icon to the ideal size. False = don't }
																{  scale; draw a smaller icon or clip a larger icon. }
																{  Default is false. Only applies to IconSuites and }
	kControlBevelButtonScaleIconTag = 'scal';					{  IconRefs. }

	{	 Helper routines are available only thru the shared library/glue. 	}
	{
	 *  GetBevelButtonMenuValue()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION GetBevelButtonMenuValue(inButton: ControlRef; VAR outValue: SInt16): OSErr;

{
 *  SetBevelButtonMenuValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetBevelButtonMenuValue(inButton: ControlRef; inValue: SInt16): OSErr;

{
 *  GetBevelButtonMenuHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetBevelButtonMenuHandle(inButton: ControlRef; VAR outHandle: MenuHandle): OSErr;

{
 *  GetBevelButtonContentInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetBevelButtonContentInfo(inButton: ControlRef; outContent: ControlButtonContentInfoPtr): OSErr;

{
 *  SetBevelButtonContentInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetBevelButtonContentInfo(inButton: ControlRef; inContent: ControlButtonContentInfoPtr): OSErr;

{
 *  SetBevelButtonTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetBevelButtonTransform(inButton: ControlRef; transform: IconTransformType): OSErr;

{
 *  SetBevelButtonGraphicAlignment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetBevelButtonGraphicAlignment(inButton: ControlRef; inAlign: ControlButtonGraphicAlignment; inHOffset: SInt16; inVOffset: SInt16): OSErr;

{
 *  SetBevelButtonTextAlignment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetBevelButtonTextAlignment(inButton: ControlRef; inAlign: ControlButtonTextAlignment; inHOffset: SInt16): OSErr;

{
 *  SetBevelButtonTextPlacement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetBevelButtonTextPlacement(inButton: ControlRef; inWhere: ControlButtonTextPlacement): OSErr;


{——————————————————————————————————————————————————————————————————————————————————————}
{  • SLIDER (CDEF 3)                                                                   }
{——————————————————————————————————————————————————————————————————————————————————————}
{  There are several variants that control the behavior of the slider control. Any     }
{  combination of the following three constants can be added to the basic CDEF ID      }
{  (kSliderProc).                                                                      }
{                                                                                      }
{  Variants:                                                                           }
{                                                                                      }
{      kSliderLiveFeedback     Slider does not use "ghosted" indicator when tracking.  }
{                              ActionProc is called (set via SetControlAction) as the  }
{                              indicator is dragged. The value is updated so that the  }
{                              actionproc can adjust some other property based on the  }
{                              value each time the action proc is called. If no action }
{                              proc is installed, it reverts to the ghost indicator.   }
{                                                                                      }
{      kSliderHasTickMarks     Slider is drawn with 'tick marks'. The control          }
{                              rectangle must be large enough to accomidate the tick   }
{                              marks.                                                  }
{                                                                                      }
{      kSliderReverseDirection Slider thumb points in opposite direction than normal.  }
{                              If the slider is vertical, the thumb will point to the  }
{                              left, if the slider is horizontal, the thumb will point }
{                              upwards.                                                }
{                                                                                      }
{      kSliderNonDirectional   This option overrides the kSliderReverseDirection and   }
{                              kSliderHasTickMarks variants. It creates an indicator   }
{                              which is rectangular and doesn't point in any direction }
{                              like the normal indicator does.                         }
{ Slider proc ID and variants }

CONST
	kControlSliderProc			= 48;
	kControlSliderLiveFeedback	= $01;
	kControlSliderHasTickMarks	= $02;
	kControlSliderReverseDirection = $04;
	kControlSliderNonDirectional = $08;

	{	 Slider Orientation 	}

TYPE
	ControlSliderOrientation 	= UInt16;
CONST
	kControlSliderPointsDownOrRight = 0;
	kControlSliderPointsUpOrLeft = 1;
	kControlSliderDoesNotPoint	= 2;

	{	 Control Kind Tag 	}
	kControlKindSlider			= 'sldr';

	{	 Creation API: Carbon Only 	}
	{
	 *  CreateSliderControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateSliderControl(window: WindowRef; {CONST}VAR boundsRect: Rect; value: SInt32; minimum: SInt32; maximum: SInt32; orientation: ControlSliderOrientation; numTickMarks: UInt16; liveTracking: BOOLEAN; liveTrackingProc: ControlActionUPP; VAR outControl: ControlRef): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • DISCLOSURE TRIANGLE (CDEF 4)                                                      }
{——————————————————————————————————————————————————————————————————————————————————————}
{  This control can be used as either left or right facing. It can also handle its own }
{  tracking if you wish. This means that when the 'autotoggle' variant is used, if the }
{  user clicks the control, it's state will change automatically from open to closed   }
{  and vice-versa depending on its initial state. After a successful call to Track-    }
{  Control, you can just check the current value to see what state it was switched to. }
{ Triangle proc IDs }

CONST
	kControlTriangleProc		= 64;
	kControlTriangleLeftFacingProc = 65;
	kControlTriangleAutoToggleProc = 66;
	kControlTriangleLeftFacingAutoToggleProc = 67;


TYPE
	ControlDisclosureTriangleOrientation  = UInt16;
CONST
	kControlDisclosureTrianglePointDefault = 0;					{  points right on a left-to-right script system (X only) }
	kControlDisclosureTrianglePointRight = 1;
	kControlDisclosureTrianglePointLeft = 2;

	{	 Control Kind Tag 	}
	kControlKindDisclosureTriangle = 'dist';

	{	 Creation API: Carbon only 	}
	{
	 *  CreateDisclosureTriangleControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateDisclosureTriangleControl(window: WindowRef; {CONST}VAR boundsRect: Rect; orientation: ControlDisclosureTriangleOrientation; title: CFStringRef; initialValue: SInt32; drawTitle: BOOLEAN; autoToggles: BOOLEAN; VAR outControl: ControlRef): OSStatus;

{ Tagged data supported by disclosure triangles }

CONST
	kControlTriangleLastValueTag = 'last';						{  SInt16 }

	{	 Helper routines are available only thru the shared library/glue. 	}
	{
	 *  SetDisclosureTriangleLastValue()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION SetDisclosureTriangleLastValue(inTabControl: ControlRef; inValue: SInt16): OSErr;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • PROGRESS INDICATOR (CDEF 5)                                                       }
{——————————————————————————————————————————————————————————————————————————————————————}
{  This CDEF implements both determinate and indeterminate progress bars. To switch,   }
{  just use SetControlData to set the indeterminate flag to make it indeterminate call }
{  IdleControls to step thru the animation. IdleControls should be called at least     }
{  once during your event loop.                                                        }
{                                                                                      }
{  We also use this same CDEF for Relevance bars. At this time this control does not   }
{  idle.                                                                               }
{ Progress Bar proc IDs }

CONST
	kControlProgressBarProc		= 80;
	kControlRelevanceBarProc	= 81;

	{	 Control Kind Tag 	}
	kControlKindProgressBar		= 'prgb';
	kControlKindRelevanceBar	= 'relb';

	{	 Creation API: Carbon only 	}
	{
	 *  CreateProgressBarControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateProgressBarControl(window: WindowRef; {CONST}VAR boundsRect: Rect; value: SInt32; minimum: SInt32; maximum: SInt32; indeterminate: BOOLEAN; VAR outControl: ControlRef): OSStatus;

{
 *  CreateRelevanceBarControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateRelevanceBarControl(window: WindowRef; {CONST}VAR boundsRect: Rect; value: SInt32; minimum: SInt32; maximum: SInt32; VAR outControl: ControlRef): OSStatus;

{ Tagged data supported by progress bars }

CONST
	kControlProgressBarIndeterminateTag = 'inde';				{  Boolean }
	kControlProgressBarAnimatingTag = 'anim';					{  Boolean }

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • LITTLE ARROWS (CDEF 6)                                                            	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  This control implements the little up and down arrows you'd see in the Memory       	}
	{	  control panel for adjusting the cache size.                                         	}
	{	 Little Arrows proc IDs 	}
	kControlLittleArrowsProc	= 96;

	{	 Control Kind Tag 	}
	kControlKindLittleArrows	= 'larr';

	{	 Creation API: Carbon only 	}
	{
	 *  CreateLittleArrowsControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateLittleArrowsControl(window: WindowRef; {CONST}VAR boundsRect: Rect; value: SInt32; minimum: SInt32; maximum: SInt32; increment: SInt32; VAR outControl: ControlRef): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • CHASING ARROWS (CDEF 7)                                                           }
{——————————————————————————————————————————————————————————————————————————————————————}
{  To animate this control, make sure to call IdleControls repeatedly.                 }
{                                                                                      }
{ Chasing Arrows proc IDs }

CONST
	kControlChasingArrowsProc	= 112;

	{	 Control Kind Tag 	}
	kControlKindChasingArrows	= 'carr';

	{	 Creation API: Carbon only 	}
	{
	 *  CreateChasingArrowsControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateChasingArrowsControl(window: WindowRef; {CONST}VAR boundsRect: Rect; VAR outControl: ControlRef): OSStatus;

{ Tagged data supported by the Chasing Arrows control }

CONST
	kControlChasingArrowsAnimatingTag = 'anim';					{  Boolean }


	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • TABS (CDEF 8)                                                                     	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  Tabs use an auxiliary resource (tab#) to hold tab information such as the tab name  	}
	{	  and an icon suite ID for each tab.                                                  	}
	{	                                                                                      	}
	{	  The ID of the tab# resource that you wish to associate with a tab control should    	}
	{	  be passed in as the Value parameter of the control. If you are using GetNewControl, 	}
	{	  then the Value slot in the CNTL resource should have the ID of the 'tab#' resource  	}
	{	  on creation.                                                                        	}
	{	                                                                                      	}
	{	  Passing zero in for the tab# resource tells the control not to read in a tab# res.  	}
	{	  You can then use SetControlMaximum to add tabs, followed by a call to SetControlData	}
	{	  with the kControlTabInfoTag, passing in a pointer to a ControlTabInfoRec. This sets 	}
	{	  the name and optionally an icon for a tab.                                          	}
	{	 Tabs proc IDs 	}
	kControlTabLargeProc		= 128;							{  Large tab size, north facing    }
	kControlTabSmallProc		= 129;							{  Small tab size, north facing    }
	kControlTabLargeNorthProc	= 128;							{  Large tab size, north facing    }
	kControlTabSmallNorthProc	= 129;							{  Small tab size, north facing    }
	kControlTabLargeSouthProc	= 130;							{  Large tab size, south facing    }
	kControlTabSmallSouthProc	= 131;							{  Small tab size, south facing    }
	kControlTabLargeEastProc	= 132;							{  Large tab size, east facing     }
	kControlTabSmallEastProc	= 133;							{  Small tab size, east facing     }
	kControlTabLargeWestProc	= 134;							{  Large tab size, west facing     }
	kControlTabSmallWestProc	= 135;							{  Small tab size, west facing     }

	{	 Tab Directions 	}

TYPE
	ControlTabDirection 		= UInt16;
CONST
	kControlTabDirectionNorth	= 0;
	kControlTabDirectionSouth	= 1;
	kControlTabDirectionEast	= 2;
	kControlTabDirectionWest	= 3;

	{	 Tab Sizes 	}

TYPE
	ControlTabSize 				= UInt16;
CONST
	kControlTabSizeLarge		= 0;
	kControlTabSizeSmall		= 1;

	{	 Control Tab Entry - used during creation                             	}
	{	 Note that the client is responsible for allocating/providing         	}
	{	 the ControlButtonContentInfo and string storage for this             	}
	{	 structure.                                                           	}

TYPE
	ControlTabEntryPtr = ^ControlTabEntry;
	ControlTabEntry = RECORD
		icon:					ControlButtonContentInfoPtr;
		name:					CFStringRef;
		enabled:				BOOLEAN;
	END;

	{	 Control Kind Tag 	}

CONST
	kControlKindTabs			= 'tabs';

	{	 Creation API: Carbon only 	}
	{
	 *  CreateTabsControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateTabsControl(window: WindowRef; {CONST}VAR boundsRect: Rect; size: ControlTabSize; direction: ControlTabDirection; numTabs: UInt16; {CONST}VAR tabArray: ControlTabEntry; VAR outControl: ControlRef): OSStatus;

{ Tagged data supported by tabs }

CONST
	kControlTabContentRectTag	= 'rect';						{  Rect }
	kControlTabEnabledFlagTag	= 'enab';						{  Boolean }
	kControlTabFontStyleTag		= 'font';						{  ControlFontStyleRec }

	{	 New tags in 1.0.1 or later 	}
	kControlTabInfoTag			= 'tabi';						{  ControlTabInfoRec }

	{	 New tags in X 10.1 or later 	}
	kControlTabImageContentTag	= 'cont';						{  ControlButtonContentInfo }

	kControlTabInfoVersionZero	= 0;							{  ControlTabInfoRec }
	kControlTabInfoVersionOne	= 1;							{  ControlTabInfoRecV1 }


TYPE
	ControlTabInfoRecPtr = ^ControlTabInfoRec;
	ControlTabInfoRec = RECORD
		version:				SInt16;									{  version of this structure. }
		iconSuiteID:			SInt16;									{  icon suite to use. Zero indicates no icon }
		name:					Str255;									{  name to be displayed on the tab }
	END;

	ControlTabInfoRecV1Ptr = ^ControlTabInfoRecV1;
	ControlTabInfoRecV1 = RECORD
		version:				SInt16;									{  version of this structure. == kControlTabInfoVersionOne }
		iconSuiteID:			SInt16;									{  icon suite to use. Zero indicates no icon }
		name:					CFStringRef;							{  name to be displayed on the tab. Will be retained so caller }
																		{  should always release it. }
	END;

	{	 Helper routines are available only thru the shared library/glue. 	}
	{
	 *  GetTabContentRect()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION GetTabContentRect(inTabControl: ControlRef; VAR outContentRect: Rect): OSErr;

{
 *  SetTabEnabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetTabEnabled(inTabControl: ControlRef; inTabToHilite: SInt16; inEnabled: BOOLEAN): OSErr;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • VISUAL SEPARATOR (CDEF 9)                                                         }
{——————————————————————————————————————————————————————————————————————————————————————}
{  Separator lines determine their orientation (horizontal or vertical) automatically  }
{  based on the relative height and width of their contrlRect.                         }
{ Visual separator proc IDs }

CONST
	kControlSeparatorLineProc	= 144;

	{	 Control Kind Tag 	}
	kControlKindSeparator		= 'sepa';

	{	 Creation API: Carbon only 	}
	{
	 *  CreateSeparatorControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateSeparatorControl(window: WindowRef; {CONST}VAR boundsRect: Rect; VAR outControl: ControlRef): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • GROUP BOX (CDEF 10)                                                               }
{——————————————————————————————————————————————————————————————————————————————————————}
{  The group box CDEF can be use in several ways. It can have no title, a text title,  }
{  a check box as the title, or a popup button as a title. There are two versions of   }
{  group boxes, primary and secondary, which look slightly different.                  }
{ Group Box proc IDs }

CONST
	kControlGroupBoxTextTitleProc = 160;
	kControlGroupBoxCheckBoxProc = 161;
	kControlGroupBoxPopupButtonProc = 162;
	kControlGroupBoxSecondaryTextTitleProc = 164;
	kControlGroupBoxSecondaryCheckBoxProc = 165;
	kControlGroupBoxSecondaryPopupButtonProc = 166;

	{	 Control Kind Tag 	}
	kControlKindGroupBox		= 'grpb';
	kControlKindCheckGroupBox	= 'cgrp';
	kControlKindPopupGroupBox	= 'pgrp';

	{	 Creation APIs: Carbon only 	}
	{
	 *  CreateGroupBoxControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateGroupBoxControl(window: WindowRef; {CONST}VAR boundsRect: Rect; title: CFStringRef; primary: BOOLEAN; VAR outControl: ControlRef): OSStatus;

{
 *  CreateCheckGroupBoxControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateCheckGroupBoxControl(window: WindowRef; {CONST}VAR boundsRect: Rect; title: CFStringRef; initialValue: SInt32; primary: BOOLEAN; autoToggle: BOOLEAN; VAR outControl: ControlRef): OSStatus;

{
 *  CreatePopupGroupBoxControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreatePopupGroupBoxControl(window: WindowRef; {CONST}VAR boundsRect: Rect; title: CFStringRef; primary: BOOLEAN; menuID: SInt16; variableWidth: BOOLEAN; titleWidth: SInt16; titleJustification: SInt16; titleStyle: ByteParameter; VAR outControl: ControlRef): OSStatus;

{ Tagged data supported by group box }

CONST
	kControlGroupBoxMenuHandleTag = 'mhan';						{  MenuRef (popup title only) }
	kControlGroupBoxMenuRefTag	= 'mhan';						{  MenuRef (popup title only) }
	kControlGroupBoxFontStyleTag = 'font';						{  ControlFontStyleRec }

	{	 tags available with Appearance 1.1 or later 	}
	kControlGroupBoxTitleRectTag = 'trec';						{  Rect. Rectangle that the title text/control is drawn in. (get only) }

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • IMAGE WELL (CDEF 11)                                                              	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  Image Wells allow you to control the content type (pict/icon/etc.) shown in the     	}
	{	  well.                                                                               	}
	{	                                                                                      	}
	{	  This is made possible by overloading the Min and Value parameters for the control.  	}
	{	                                                                                      	}
	{	  Parameter                   What Goes Here                                          	}
	{	  ———————————————————         ——————————————————————————————————————————————————      	}
	{	  Min                         content type (see constants for bevel buttons)          	}
	{	  Value                       Resource ID of content type, if resource-based.         	}
	{	                                                                                      	}
	{	                                                                                      	}
	{	  Handle-based Content                                                                	}
	{	  ————————————————————                                                                	}
	{	  You can create your control and then set the content to an existing handle to an    	}
	{	  icon suite, etc. using the macros below. Please keep in mind that resource-based    	}
	{	  content is owned by the control, handle-based content is owned by you. The CDEF will	}
	{	  not try to dispose of handle-based content. If you are changing the content type of 	}
	{	  the button on the fly, you must make sure that if you are replacing a handle-       	}
	{	  based content with a resource-based content to properly dispose of the handle,      	}
	{	  else a memory leak will ensue.                                                      	}
	{	                                                                                      	}
	{	 Image Well proc IDs 	}
	kControlImageWellProc		= 176;

	{	 Control Kind Tag 	}
	kControlKindImageWell		= 'well';

	{	 Creation API: Carbon only 	}
	{
	 *  CreateImageWellControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateImageWellControl(window: WindowRef; {CONST}VAR boundsRect: Rect; {CONST}VAR info: ControlButtonContentInfo; VAR outControl: ControlRef): OSStatus;

{ Tagged data supported by image wells }

CONST
	kControlImageWellContentTag	= 'cont';						{  ButtonContentInfo }
	kControlImageWellTransformTag = 'tran';						{  IconTransformType }
	kControlImageWellIsDragDestinationTag = 'drag';				{  Boolean }

	{	 Helper routines are available only thru the shared library/glue. 	}
	{
	 *  GetImageWellContentInfo()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION GetImageWellContentInfo(inButton: ControlRef; outContent: ControlButtonContentInfoPtr): OSErr;

{
 *  SetImageWellContentInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetImageWellContentInfo(inButton: ControlRef; inContent: ControlButtonContentInfoPtr): OSErr;

{
 *  SetImageWellTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetImageWellTransform(inButton: ControlRef; inTransform: IconTransformType): OSErr;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • POPUP ARROW (CDEF 12)                                                             }
{——————————————————————————————————————————————————————————————————————————————————————}
{  The popup arrow CDEF is used to draw the small arrow normally associated with a     }
{  popup control. The arrow can point in four directions, and a small or large version }
{  can be used. This control is provided to allow clients to draw the arrow in a       }
{  normalized fashion which will take advantage of themes automatically.               }
{                                                                                      }
{ Popup Arrow proc IDs }

CONST
	kControlPopupArrowEastProc	= 192;
	kControlPopupArrowWestProc	= 193;
	kControlPopupArrowNorthProc	= 194;
	kControlPopupArrowSouthProc	= 195;
	kControlPopupArrowSmallEastProc = 196;
	kControlPopupArrowSmallWestProc = 197;
	kControlPopupArrowSmallNorthProc = 198;
	kControlPopupArrowSmallSouthProc = 199;

	{	 Popup Arrow Orientations 	}
	kControlPopupArrowOrientationEast = 0;
	kControlPopupArrowOrientationWest = 1;
	kControlPopupArrowOrientationNorth = 2;
	kControlPopupArrowOrientationSouth = 3;


TYPE
	ControlPopupArrowOrientation		= UInt16;
	{	 Popup Arrow Size 	}

CONST
	kControlPopupArrowSizeNormal = 0;
	kControlPopupArrowSizeSmall	= 1;


TYPE
	ControlPopupArrowSize				= UInt16;
	{	 Control Kind Tag 	}

CONST
	kControlKindPopupArrow		= 'parr';

	{	 Creation API: Carbon only 	}
	{
	 *  CreatePopupArrowControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreatePopupArrowControl(window: WindowRef; {CONST}VAR boundsRect: Rect; orientation: ControlPopupArrowOrientation; size: ControlPopupArrowSize; VAR outControl: ControlRef): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • PLACARD (CDEF 14)                                                                 }
{——————————————————————————————————————————————————————————————————————————————————————}
{ Placard proc IDs }

CONST
	kControlPlacardProc			= 224;

	{	 Control Kind Tag 	}
	kControlKindPlacard			= 'plac';

	{	 Creation API: Carbon only 	}
	{
	 *  CreatePlacardControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreatePlacardControl(window: WindowRef; {CONST}VAR boundsRect: Rect; VAR outControl: ControlRef): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • CLOCK (CDEF 15)                                                                   }
{——————————————————————————————————————————————————————————————————————————————————————}
{  NOTE:   You can specify more options in the Value paramter when creating the clock. }
{          See below.                                                                  }
{                                                                                      }
{  NOTE:   Under Appearance 1.1, the clock control knows and returns more part codes.  }
{          The new clock-specific part codes are defined with the other control parts. }
{          Besides these clock-specific parts, we also return kControlUpButtonPart     }
{          and kControlDownButtonPart when they hit the up and down arrows.            }
{          The new part codes give you more flexibility for focusing and hit testing.  }
{                                                                                      }
{          The original kControlClockPart is still valid. When hit testing, it means   }
{          that some non-editable area of the clock's whitespace has been clicked.     }
{          When focusing a currently unfocused clock, it changes the focus to the      }
{          first part; it is the same as passing kControlFocusNextPart. When           }
{          re-focusing a focused clock, it will not change the focus at all.           }
{ Clock proc IDs }

CONST
	kControlClockTimeProc		= 240;
	kControlClockTimeSecondsProc = 241;
	kControlClockDateProc		= 242;
	kControlClockMonthYearProc	= 243;

	{	 Clock Types 	}

TYPE
	ControlClockType 			= UInt16;
CONST
	kControlClockTypeHourMinute	= 0;
	kControlClockTypeHourMinuteSecond = 1;
	kControlClockTypeMonthDayYear = 2;
	kControlClockTypeMonthYear	= 3;

	{	 Clock Flags 	}
	{	  These flags can be passed into 'value' field on creation of the control.            	}
	{	  Value is set to 0 after control is created.                                         	}

TYPE
	ControlClockFlags 			= UInt32;
CONST
	kControlClockFlagStandard	= 0;							{  editable, non-live }
	kControlClockNoFlags		= 0;
	kControlClockFlagDisplayOnly = 1;							{  add this to become non-editable }
	kControlClockIsDisplayOnly	= 1;
	kControlClockFlagLive		= 2;							{  automatically shows current time on idle. only valid with display only. }
	kControlClockIsLive			= 2;

	{	 Control Kind Tag 	}
	kControlKindClock			= 'clck';

	{	 Creation API: Carbon only 	}
	{
	 *  CreateClockControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateClockControl(window: WindowRef; {CONST}VAR boundsRect: Rect; clockType: ControlClockType; clockFlags: ControlClockFlags; VAR outControl: ControlRef): OSStatus;

{ Tagged data supported by clocks }

CONST
	kControlClockLongDateTag	= 'date';						{  LongDateRec }
	kControlClockFontStyleTag	= 'font';						{  ControlFontStyleRec }
	kControlClockAnimatingTag	= 'anim';						{  Boolean }

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • USER PANE (CDEF 16)                                                               	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  User panes have two primary purposes: to allow easy implementation of a custom      	}
	{	  control by the developer, and to provide a generic container for embedding other    	}
	{	  controls.                                                                           	}
	{	                                                                                      	}
	{	  In Carbon, with the advent of Carbon-event-based controls, you may find it easier   	}
	{	  to simply write a new control from scratch than to customize a user pane control.   	}
	{	  The set of callbacks provided by the user pane will not be extended to support      	}
	{	  new Control Manager features; instead, you should just write a real control.        	}
	{	                                                                                      	}
	{	  User panes do not, by default, support embedding. If you try to embed a control     	}
	{	  into a user pane, you will get back errControlIsNotEmbedder. You can make a user    	}
	{	  pane support embedding by passing the kControlSupportsEmbedding flag in the 'value' 	}
	{	  parameter when you create the control.                                              	}
	{	                                                                                      	}
	{	  User panes support the following overloaded control initialization options:         	}
	{	                                                                                      	}
	{	  Parameter                   What Goes Here                                          	}
	{	  ———————————————————         ——————————————————————————————————————————————————      	}
	{	  Value                       Control feature flags                                   	}

	{	 User Pane proc IDs 	}
	kControlUserPaneProc		= 256;

	{	 Control Kind Tag 	}
	kControlKindUserPane		= 'upan';

	{	 Creation API: Carbon only 	}
	{
	 *  CreateUserPaneControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateUserPaneControl(window: WindowRef; {CONST}VAR boundsRect: Rect; features: UInt32; VAR outControl: ControlRef): OSStatus;

{ Tagged data supported by user panes }
{ Currently, they are all proc ptrs for doing things like drawing and hit testing, etc. }

CONST
	kControlUserItemDrawProcTag	= 'uidp';						{  UserItemUPP }
	kControlUserPaneDrawProcTag	= 'draw';						{  ControlUserPaneDrawingUPP }
	kControlUserPaneHitTestProcTag = 'hitt';					{  ControlUserPaneHitTestUPP }
	kControlUserPaneTrackingProcTag = 'trak';					{  ControlUserPaneTrackingUPP }
	kControlUserPaneIdleProcTag	= 'idle';						{  ControlUserPaneIdleUPP }
	kControlUserPaneKeyDownProcTag = 'keyd';					{  ControlUserPaneKeyDownUPP }
	kControlUserPaneActivateProcTag = 'acti';					{  ControlUserPaneActivateUPP }
	kControlUserPaneFocusProcTag = 'foci';						{  ControlUserPaneFocusUPP }
	kControlUserPaneBackgroundProcTag = 'back';					{  ControlUserPaneBackgroundUPP }


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ControlUserPaneDrawProcPtr = PROCEDURE(control: ControlRef; part: SInt16);
{$ELSEC}
	ControlUserPaneDrawProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ControlUserPaneHitTestProcPtr = FUNCTION(control: ControlRef; where: Point): ControlPartCode;
{$ELSEC}
	ControlUserPaneHitTestProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ControlUserPaneTrackingProcPtr = FUNCTION(control: ControlRef; startPt: Point; actionProc: ControlActionUPP): ControlPartCode;
{$ELSEC}
	ControlUserPaneTrackingProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ControlUserPaneIdleProcPtr = PROCEDURE(control: ControlRef);
{$ELSEC}
	ControlUserPaneIdleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ControlUserPaneKeyDownProcPtr = FUNCTION(control: ControlRef; keyCode: SInt16; charCode: SInt16; modifiers: SInt16): ControlPartCode;
{$ELSEC}
	ControlUserPaneKeyDownProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ControlUserPaneActivateProcPtr = PROCEDURE(control: ControlRef; activating: BOOLEAN);
{$ELSEC}
	ControlUserPaneActivateProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ControlUserPaneFocusProcPtr = FUNCTION(control: ControlRef; action: ControlFocusPart): ControlPartCode;
{$ELSEC}
	ControlUserPaneFocusProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ControlUserPaneBackgroundProcPtr = PROCEDURE(control: ControlRef; info: ControlBackgroundPtr);
{$ELSEC}
	ControlUserPaneBackgroundProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ControlUserPaneDrawUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ControlUserPaneDrawUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ControlUserPaneHitTestUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ControlUserPaneHitTestUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ControlUserPaneTrackingUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ControlUserPaneTrackingUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ControlUserPaneIdleUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ControlUserPaneIdleUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ControlUserPaneKeyDownUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ControlUserPaneKeyDownUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ControlUserPaneActivateUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ControlUserPaneActivateUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ControlUserPaneFocusUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ControlUserPaneFocusUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ControlUserPaneBackgroundUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ControlUserPaneBackgroundUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppControlUserPaneDrawProcInfo = $000002C0;
	uppControlUserPaneHitTestProcInfo = $000003E0;
	uppControlUserPaneTrackingProcInfo = $00000FE0;
	uppControlUserPaneIdleProcInfo = $000000C0;
	uppControlUserPaneKeyDownProcInfo = $00002AE0;
	uppControlUserPaneActivateProcInfo = $000001C0;
	uppControlUserPaneFocusProcInfo = $000002E0;
	uppControlUserPaneBackgroundProcInfo = $000003C0;
	{
	 *  NewControlUserPaneDrawUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewControlUserPaneDrawUPP(userRoutine: ControlUserPaneDrawProcPtr): ControlUserPaneDrawUPP; { old name was NewControlUserPaneDrawProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewControlUserPaneHitTestUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewControlUserPaneHitTestUPP(userRoutine: ControlUserPaneHitTestProcPtr): ControlUserPaneHitTestUPP; { old name was NewControlUserPaneHitTestProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewControlUserPaneTrackingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewControlUserPaneTrackingUPP(userRoutine: ControlUserPaneTrackingProcPtr): ControlUserPaneTrackingUPP; { old name was NewControlUserPaneTrackingProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewControlUserPaneIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewControlUserPaneIdleUPP(userRoutine: ControlUserPaneIdleProcPtr): ControlUserPaneIdleUPP; { old name was NewControlUserPaneIdleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewControlUserPaneKeyDownUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewControlUserPaneKeyDownUPP(userRoutine: ControlUserPaneKeyDownProcPtr): ControlUserPaneKeyDownUPP; { old name was NewControlUserPaneKeyDownProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewControlUserPaneActivateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewControlUserPaneActivateUPP(userRoutine: ControlUserPaneActivateProcPtr): ControlUserPaneActivateUPP; { old name was NewControlUserPaneActivateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewControlUserPaneFocusUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewControlUserPaneFocusUPP(userRoutine: ControlUserPaneFocusProcPtr): ControlUserPaneFocusUPP; { old name was NewControlUserPaneFocusProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewControlUserPaneBackgroundUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewControlUserPaneBackgroundUPP(userRoutine: ControlUserPaneBackgroundProcPtr): ControlUserPaneBackgroundUPP; { old name was NewControlUserPaneBackgroundProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeControlUserPaneDrawUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeControlUserPaneDrawUPP(userUPP: ControlUserPaneDrawUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeControlUserPaneHitTestUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeControlUserPaneHitTestUPP(userUPP: ControlUserPaneHitTestUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeControlUserPaneTrackingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeControlUserPaneTrackingUPP(userUPP: ControlUserPaneTrackingUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeControlUserPaneIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeControlUserPaneIdleUPP(userUPP: ControlUserPaneIdleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeControlUserPaneKeyDownUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeControlUserPaneKeyDownUPP(userUPP: ControlUserPaneKeyDownUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeControlUserPaneActivateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeControlUserPaneActivateUPP(userUPP: ControlUserPaneActivateUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeControlUserPaneFocusUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeControlUserPaneFocusUPP(userUPP: ControlUserPaneFocusUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeControlUserPaneBackgroundUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeControlUserPaneBackgroundUPP(userUPP: ControlUserPaneBackgroundUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeControlUserPaneDrawUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeControlUserPaneDrawUPP(control: ControlRef; part: SInt16; userRoutine: ControlUserPaneDrawUPP); { old name was CallControlUserPaneDrawProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeControlUserPaneHitTestUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeControlUserPaneHitTestUPP(control: ControlRef; where: Point; userRoutine: ControlUserPaneHitTestUPP): ControlPartCode; { old name was CallControlUserPaneHitTestProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeControlUserPaneTrackingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeControlUserPaneTrackingUPP(control: ControlRef; startPt: Point; actionProc: ControlActionUPP; userRoutine: ControlUserPaneTrackingUPP): ControlPartCode; { old name was CallControlUserPaneTrackingProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeControlUserPaneIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeControlUserPaneIdleUPP(control: ControlRef; userRoutine: ControlUserPaneIdleUPP); { old name was CallControlUserPaneIdleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeControlUserPaneKeyDownUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeControlUserPaneKeyDownUPP(control: ControlRef; keyCode: SInt16; charCode: SInt16; modifiers: SInt16; userRoutine: ControlUserPaneKeyDownUPP): ControlPartCode; { old name was CallControlUserPaneKeyDownProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeControlUserPaneActivateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeControlUserPaneActivateUPP(control: ControlRef; activating: BOOLEAN; userRoutine: ControlUserPaneActivateUPP); { old name was CallControlUserPaneActivateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeControlUserPaneFocusUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeControlUserPaneFocusUPP(control: ControlRef; action: ControlFocusPart; userRoutine: ControlUserPaneFocusUPP): ControlPartCode; { old name was CallControlUserPaneFocusProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeControlUserPaneBackgroundUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeControlUserPaneBackgroundUPP(control: ControlRef; info: ControlBackgroundPtr; userRoutine: ControlUserPaneBackgroundUPP); { old name was CallControlUserPaneBackgroundProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
  ——————————————————————————————————————————————————————————————————————————————————————————
    • EDIT TEXT (CDEF 17)
  ——————————————————————————————————————————————————————————————————————————————————————————
}
{ Edit Text proc IDs }

CONST
	kControlEditTextProc		= 272;
	kControlEditTextPasswordProc = 274;

	{	 proc IDs available with Appearance 1.1 or later 	}
	kControlEditTextInlineInputProc = 276;						{  Can't combine with the other variants }

	{	 Control Kind Tag 	}
	kControlKindEditText		= 'etxt';

	{	 Creation API: Carbon only 	}
	{
	 *  CreateEditTextControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateEditTextControl(window: WindowRef; {CONST}VAR boundsRect: Rect; text: CFStringRef; isPassword: BOOLEAN; useInlineInput: BOOLEAN; {CONST}VAR style: ControlFontStyleRec; VAR outControl: ControlRef): OSStatus;

{ Tagged data supported by edit text }

CONST
	kControlEditTextStyleTag	= 'font';						{  ControlFontStyleRec }
	kControlEditTextTextTag		= 'text';						{  Buffer of chars - you supply the buffer }
	kControlEditTextTEHandleTag	= 'than';						{  The TEHandle of the text edit record }
	kControlEditTextKeyFilterTag = 'fltr';
	kControlEditTextSelectionTag = 'sele';						{  EditTextSelectionRec }
	kControlEditTextPasswordTag	= 'pass';						{  The clear text password text }

	{	 tags available with Appearance 1.1 or later 	}
	kControlEditTextKeyScriptBehaviorTag = 'kscr';				{  ControlKeyScriptBehavior. Defaults to "PrefersRoman" for password fields, }
																{        or "AllowAnyScript" for non-password fields. }
	kControlEditTextLockedTag	= 'lock';						{  Boolean. Locking disables editability. }
	kControlEditTextFixedTextTag = 'ftxt';						{  Like the normal text tag, but fixes inline input first }
	kControlEditTextValidationProcTag = 'vali';					{  ControlEditTextValidationUPP. Called when a key filter can't be: after cut, paste, etc. }
	kControlEditTextInlinePreUpdateProcTag = 'prup';			{  TSMTEPreUpdateUPP and TSMTEPostUpdateUpp. For use with inline input variant... }
	kControlEditTextInlinePostUpdateProcTag = 'poup';			{  ...The refCon parameter will contain the ControlRef. }

	{	 Tags available with Mac OS X and later 	}
	kControlEditTextCFStringTag	= 'cfst';						{  CFStringRef }




	{	 Structure for getting the edit text selection 	}

TYPE
	ControlEditTextSelectionRecPtr = ^ControlEditTextSelectionRec;
	ControlEditTextSelectionRec = RECORD
		selStart:				SInt16;
		selEnd:					SInt16;
	END;

	ControlEditTextSelectionPtr			= ^ControlEditTextSelectionRec;
{$IFC TYPED_FUNCTION_POINTERS}
	ControlEditTextValidationProcPtr = PROCEDURE(control: ControlRef);
{$ELSEC}
	ControlEditTextValidationProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ControlEditTextValidationUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ControlEditTextValidationUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppControlEditTextValidationProcInfo = $000000C0;
	{
	 *  NewControlEditTextValidationUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewControlEditTextValidationUPP(userRoutine: ControlEditTextValidationProcPtr): ControlEditTextValidationUPP; { old name was NewControlEditTextValidationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeControlEditTextValidationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeControlEditTextValidationUPP(userUPP: ControlEditTextValidationUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeControlEditTextValidationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeControlEditTextValidationUPP(control: ControlRef; userRoutine: ControlEditTextValidationUPP); { old name was CallControlEditTextValidationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{  • STATIC TEXT (CDEF 18)                                                             }
{——————————————————————————————————————————————————————————————————————————————————————}
{ Static Text proc IDs }

CONST
	kControlStaticTextProc		= 288;

	{	 Control Kind Tag 	}
	kControlKindStaticText		= 'stxt';

	{	 Creation API: Carbon only 	}
	{
	 *  CreateStaticTextControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateStaticTextControl(window: WindowRef; {CONST}VAR boundsRect: Rect; text: CFStringRef; {CONST}VAR style: ControlFontStyleRec; VAR outControl: ControlRef): OSStatus;

{ Tagged data supported by static text }

CONST
	kControlStaticTextStyleTag	= 'font';						{  ControlFontStyleRec }
	kControlStaticTextTextTag	= 'text';						{  Copy of text }
	kControlStaticTextTextHeightTag = 'thei';					{  SInt16 }

	{	 Tags available with appearance 1.1 or later 	}
	kControlStaticTextTruncTag	= 'trun';						{  TruncCode (-1 means no truncation) }

	{	 Tags available with Mac OS X or later 	}
	kControlStaticTextCFStringTag = 'cfst';						{  CFStringRef }


	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • PICTURE CONTROL (CDEF 19)                                                         	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  Value parameter should contain the ID of the picture you wish to display when       	}
	{	  creating controls of this type. If you don't want the control tracked at all, use   	}
	{	  the 'no track' variant.                                                             	}
	{	 Picture control proc IDs 	}
	kControlPictureProc			= 304;
	kControlPictureNoTrackProc	= 305;							{  immediately returns kControlPicturePart }

	{	 Control Kind Tag 	}
	kControlKindPicture			= 'pict';

	{	 Creation API: Carbon only 	}
	{
	 *  CreatePictureControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreatePictureControl(window: WindowRef; {CONST}VAR boundsRect: Rect; {CONST}VAR content: ControlButtonContentInfo; dontTrack: BOOLEAN; VAR outControl: ControlRef): OSStatus;

{ Tagged data supported by picture controls }

CONST
	kControlPictureHandleTag	= 'pich';						{  PicHandle }

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • ICON CONTROL (CDEF 20)                                                            	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  Value parameter should contain the ID of the ICON or cicn you wish to display when  	}
	{	  creating controls of this type. If you don't want the control tracked at all, use   	}
	{	  the 'no track' variant.                                                             	}
	{	 Icon control proc IDs 	}
	kControlIconProc			= 320;
	kControlIconNoTrackProc		= 321;							{  immediately returns kControlIconPart }
	kControlIconSuiteProc		= 322;
	kControlIconSuiteNoTrackProc = 323;							{  immediately returns kControlIconPart }

																{  icon ref controls may have either an icon, color icon, icon suite, or icon ref. }
																{  for data other than icon, you must set the data by passing a }
																{  ControlButtonContentInfo to SetControlData }
	kControlIconRefProc			= 324;
	kControlIconRefNoTrackProc	= 325;							{  immediately returns kControlIconPart }

	{	 Control Kind Tag 	}
	kControlKindIcon			= 'icon';

	{	 Creation API: Carbon Only 	}
	{
	 *  CreateIconControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateIconControl(window: WindowRef; {CONST}VAR boundsRect: Rect; {CONST}VAR icon: ControlButtonContentInfo; dontTrack: BOOLEAN; VAR outControl: ControlRef): OSStatus;

{ Tagged data supported by icon controls }

CONST
	kControlIconTransformTag	= 'trfm';						{  IconTransformType }
	kControlIconAlignmentTag	= 'algn';						{  IconAlignmentType }

	{	 Tags available with appearance 1.1 or later 	}
	kControlIconResourceIDTag	= 'ires';						{  SInt16 resource ID of icon to use }
	kControlIconContentTag		= 'cont';						{  accepts a ControlButtonContentInfo }

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • WINDOW HEADER (CDEF 21)                                                           	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 Window Header proc IDs 	}
	kControlWindowHeaderProc	= 336;							{  normal header }
	kControlWindowListViewHeaderProc = 337;						{  variant for list views - no bottom line }

	{	 Control Kind Tag 	}
	kControlKindWindowHeader	= 'whed';

	{	 Creation API: Carbon Only 	}
	{
	 *  CreateWindowHeaderControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateWindowHeaderControl(window: WindowRef; {CONST}VAR boundsRect: Rect; isListHeader: BOOLEAN; VAR outControl: ControlRef): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • LIST BOX (CDEF 22)                                                                }
{——————————————————————————————————————————————————————————————————————————————————————}
{  Lists use an auxiliary resource to define their format. The resource type used is   }
{  'ldes' and a definition for it can be found in Appearance.r. The resource ID for    }
{  the ldes is passed in the 'value' parameter when creating the control. You may pass }
{  zero in value. This tells the List Box control to not use a resource. The list will }
{  be created with default values, and will use the standard LDEF (0). You can change  }
{  the list by getting the list handle. You can set the LDEF to use by using the tag   }
{  below (kControlListBoxLDEFTag)                                                      }
{ List Box proc IDs }

CONST
	kControlListBoxProc			= 352;
	kControlListBoxAutoSizeProc	= 353;

	{	 Control Kind Tag 	}
	kControlKindListBox			= 'lbox';

	{	 Creation API: Carbon Only 	}
	{
	 *  CreateListBoxControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateListBoxControl(window: WindowRef; {CONST}VAR boundsRect: Rect; autoSize: BOOLEAN; numRows: SInt16; numColumns: SInt16; horizScroll: BOOLEAN; vertScroll: BOOLEAN; cellHeight: SInt16; cellWidth: SInt16; hasGrowSpace: BOOLEAN; {CONST}VAR listDef: ListDefSpec; VAR outControl: ControlRef): OSStatus;

{ Tagged data supported by list box }

CONST
	kControlListBoxListHandleTag = 'lhan';						{  ListHandle }
	kControlListBoxKeyFilterTag	= 'fltr';						{  ControlKeyFilterUPP }
	kControlListBoxFontStyleTag	= 'font';						{  ControlFontStyleRec }

	{	 New tags in 1.0.1 or later 	}
	kControlListBoxDoubleClickTag = 'dblc';						{  Boolean. Was last click a double-click? }
	kControlListBoxLDEFTag		= 'ldef';						{  SInt16. ID of LDEF to use. }

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • PUSH BUTTON (CDEF 23)                                                             	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  The new standard checkbox and radio button controls support a "mixed" value that    	}
	{	  indicates that the current setting contains a mixed set of on and off values. The   	}
	{	  control value used to display this indication is defined in Controls.h:             	}
	{	                                                                                      	}
	{	      kControlCheckBoxMixedValue = 2                                                  	}
	{	                                                                                      	}
	{	  Two new variants of the standard pushbutton have been added to the standard control 	}
	{	  suite that draw a color icon next to the control title. One variant draws the icon  	}
	{	  on the left side, the other draws it on the right side (when the system justifica-  	}
	{	  tion is right to left, these are reversed).                                         	}
	{	                                                                                      	}
	{	  When either of the icon pushbuttons are created, the contrlMax field of the control 	}
	{	  record is used to determine the ID of the 'cicn' resource drawn in the pushbutton.  	}
	{	                                                                                      	}
	{	  In addition, a push button can now be told to draw with a default outline using the 	}
	{	  SetControlData routine with the kPushButtonDefaultTag below.                        	}
	{	                                                                                      	}
	{	  A push button may also be marked using the kControlPushButtonCancelTag. This has    	}
	{	  no visible representation, but does cause the button to play the CancelButton theme 	}
	{	  sound instead of the regular pushbutton theme sound when pressed.                   	}
	{	                                                                                      	}
	{	 Theme Push Button/Check Box/Radio Button proc IDs 	}
	kControlPushButtonProc		= 368;
	kControlCheckBoxProc		= 369;
	kControlRadioButtonProc		= 370;
	kControlPushButLeftIconProc	= 374;							{  Standard pushbutton with left-side icon }
	kControlPushButRightIconProc = 375;							{  Standard pushbutton with right-side icon }

	{	 Variants with Appearance 1.1 or later 	}
	kControlCheckBoxAutoToggleProc = 371;
	kControlRadioButtonAutoToggleProc = 372;

	{	 Push Button Icon Alignments 	}

TYPE
	ControlPushButtonIconAlignment  = UInt16;
CONST
	kControlPushButtonIconOnLeft = 6;
	kControlPushButtonIconOnRight = 7;

	{	 Control Kind Tag 	}
	kControlKindPushButton		= 'push';
	kControlKindPushIconButton	= 'picn';
	kControlKindRadioButton		= 'rdio';
	kControlKindCheckBox		= 'cbox';

	{	 Creation APIs: Carbon Only 	}
	{
	 *  CreatePushButtonControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreatePushButtonControl(window: WindowRef; {CONST}VAR boundsRect: Rect; title: CFStringRef; VAR outControl: ControlRef): OSStatus;

{
 *  CreatePushButtonWithIconControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreatePushButtonWithIconControl(window: WindowRef; {CONST}VAR boundsRect: Rect; title: CFStringRef; VAR icon: ControlButtonContentInfo; iconAlignment: ControlPushButtonIconAlignment; VAR outControl: ControlRef): OSStatus;

{
 *  CreateRadioButtonControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateRadioButtonControl(window: WindowRef; {CONST}VAR boundsRect: Rect; title: CFStringRef; initialValue: SInt32; autoToggle: BOOLEAN; VAR outControl: ControlRef): OSStatus;

{
 *  CreateCheckBoxControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateCheckBoxControl(window: WindowRef; {CONST}VAR boundsRect: Rect; title: CFStringRef; initialValue: SInt32; autoToggle: BOOLEAN; VAR outControl: ControlRef): OSStatus;


{ Tagged data supported by standard buttons }

CONST
	kControlPushButtonDefaultTag = 'dflt';						{  default ring flag }
	kControlPushButtonCancelTag	= 'cncl';						{  cancel button flag (1.1 and later) }

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • SCROLL BAR (CDEF 24)                                                              	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  This is the new Appearance scroll bar.                                              	}
	{	                                                                                      	}
	{	 Theme Scroll Bar proc IDs 	}
	kControlScrollBarProc		= 384;							{  normal scroll bar }
	kControlScrollBarLiveProc	= 386;							{  live scrolling variant }

	{	 Control Kind Tag 	}
	kControlKindScrollBar		= 'sbar';

	{	 Creation API: Carbon Only 	}
	{
	 *  CreateScrollBarControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateScrollBarControl(window: WindowRef; {CONST}VAR boundsRect: Rect; value: SInt32; minimum: SInt32; maximum: SInt32; viewSize: SInt32; liveTracking: BOOLEAN; liveTrackingProc: ControlActionUPP; VAR outControl: ControlRef): OSStatus;

{ These tags are available in Mac OS X or later }

CONST
	kControlScrollBarShowsArrowsTag = 'arro';					{  Boolean whether or not to draw the scroll arrows }

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • POPUP BUTTON (CDEF 25)                                                            	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  This is the new Appearance Popup Button. It takes the same variants and does the    	}
	{	  same overloading as the previous popup menu control. There are some differences:    	}
	{	                                                                                      	}
	{	  Passing in a menu ID of -12345 causes the popup not to try and get the menu from a  	}
	{	  resource. Instead, you can build the menu and later stuff the MenuRef field in      	}
	{	  the popup data information.                                                         	}
	{	                                                                                      	}
	{	  You can pass -1 in the Max parameter to have the control calculate the width of the 	}
	{	  title on its own instead of guessing and then tweaking to get it right. It adds the 	}
	{	  appropriate amount of space between the title and the popup.                        	}
	{	                                                                                      	}
	{	 Theme Popup Button proc IDs 	}
	kControlPopupButtonProc		= 400;
	kControlPopupFixedWidthVariant = $01;
	kControlPopupVariableWidthVariant = $02;
	kControlPopupUseAddResMenuVariant = $04;
	kControlPopupUseWFontVariant = $08;

	{	 Control Kind Tag 	}
	kControlKindPopupButton		= 'popb';

	{	 Creation API: Carbon Only 	}
	{
	 *  CreatePopupButtonControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreatePopupButtonControl(window: WindowRef; {CONST}VAR boundsRect: Rect; title: CFStringRef; menuID: SInt16; variableWidth: BOOLEAN; titleWidth: SInt16; titleJustification: SInt16; titleStyle: ByteParameter; VAR outControl: ControlRef): OSStatus;


{ These tags are available in 1.0.1 or later of Appearance }

CONST
	kControlPopupButtonMenuHandleTag = 'mhan';					{  MenuRef }
	kControlPopupButtonMenuRefTag = 'mhan';						{  MenuRef }
	kControlPopupButtonMenuIDTag = 'mnid';						{  SInt16 }

	{	 These tags are available in 1.1 or later of Appearance 	}
	kControlPopupButtonExtraHeightTag = 'exht';					{  SInt16 - extra vertical whitespace within the button }
	kControlPopupButtonOwnedMenuRefTag = 'omrf';				{  MenuRef }
	kControlPopupButtonCheckCurrentTag = 'chck';				{  Boolean    - whether the popup puts a checkmark next to the current item (defaults to true) }


	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • RADIO GROUP (CDEF 26)                                                             	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  This control implements a radio group. It is an embedding control and can therefore 	}
	{	  only be used when a control hierarchy is established for its owning window. You     	}
	{	  should only embed radio buttons within it. As radio buttons are embedded into it,   	}
	{	  the group sets up its value, min, and max to represent the number of embedded items.	}
	{	  The current value of the control is the index of the sub-control that is the current	}
	{	  'on' radio button. To get the current radio button control handle, you can use the  	}
	{	  control manager call GetIndSubControl, passing in the value of the radio group.     	}
	{	                                                                                      	}
	{	  NOTE: This control is only available with Appearance 1.0.1.                         	}
	{	 Radio Group Proc ID 	}
	kControlRadioGroupProc		= 416;

	{	 Control Kind Tag 	}
	kControlKindRadioGroup		= 'rgrp';

	{	 Creation API: Carbon Only 	}
	{
	 *  CreateRadioGroupControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateRadioGroupControl(window: WindowRef; {CONST}VAR boundsRect: Rect; VAR outControl: ControlRef): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • SCROLL TEXT BOX (CDEF 27)                                                         }
{——————————————————————————————————————————————————————————————————————————————————————}
{  This control implements a scrolling box of (non-editable) text. This is useful for  }
{  credits in about boxes, etc.                                                        }
{  The standard version of this control has a scroll bar, but the autoscrolling        }
{  variant does not. The autoscrolling variant needs two pieces of information to      }
{  work: delay (in ticks) before the scrolling starts, and time (in ticks) between     }
{  scrolls. It will scroll one pixel at a time, unless changed via SetControlData.     }
{                                                                                      }
{  Parameter                   What Goes Here                                          }
{  ———————————————————         ————————————————————————————————————————————————————    }
{  Value                       Resource ID of 'TEXT'/'styl' content.                   }
{  Min                         Scroll start delay (in ticks)                       .   }
{  Max                         Delay (in ticks) between scrolls.                       }
{                                                                                      }
{  NOTE: This control is only available with Appearance 1.1.                           }
{ Scroll Text Box Proc IDs }

CONST
	kControlScrollTextBoxProc	= 432;
	kControlScrollTextBoxAutoScrollProc = 433;

	{	 Control Kind Tag 	}
	kControlKindScrollingTextBox = 'stbx';

	{	 Creation API: Carbon Only 	}
	{
	 *  CreateScrollingTextBoxControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateScrollingTextBoxControl(window: WindowRef; {CONST}VAR boundsRect: Rect; contentResID: SInt16; autoScroll: BOOLEAN; delayBeforeAutoScroll: UInt32; delayBetweenAutoScroll: UInt32; autoScrollAmount: UInt16; VAR outControl: ControlRef): OSStatus;

{ Tagged data supported by Scroll Text Box }

CONST
	kControlScrollTextBoxDelayBeforeAutoScrollTag = 'stdl';		{  UInt32 (ticks until autoscrolling starts) }
	kControlScrollTextBoxDelayBetweenAutoScrollTag = 'scdl';	{  UInt32 (ticks between scrolls) }
	kControlScrollTextBoxAutoScrollAmountTag = 'samt';			{  UInt16 (pixels per scroll) -- defaults to 1 }
	kControlScrollTextBoxContentsTag = 'tres';					{  SInt16 (resource ID of 'TEXT'/'styl') -- write only! }
	kControlScrollTextBoxAnimatingTag = 'anim';					{  Boolean (whether the text box should auto-scroll) }


	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • DISCLOSURE BUTTON                                                                 	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{
	 *  CreateDisclosureButtonControl()
	 *  
	 *  Summary:
	 *    Creates a new instance of the Disclosure Button Control.
	 *  
	 *  Discussion:
	 *    CreateDisclosureButtonControl is preferred over NewControl
	 *    because it allows you to specify the exact set of parameters
	 *    required to create the control without overloading parameter
	 *    semantics. The initial minimum of the Disclosure Button will be
	 *    kControlDisclosureButtonClosed, and the maximum will be
	 *    kControlDisclosureButtonDisclosed.
	 *  
	 *  Parameters:
	 *    
	 *    inWindow:
	 *      The WindowRef in which to create the control.
	 *    
	 *    inBoundsRect:
	 *      The bounding rectangle for the control. The height of the
	 *      control is fixed and the control will be centered vertically
	 *      within the rectangle you specify.
	 *    
	 *    inValue:
	 *      The initial value; either kControlDisclosureButtonClosed or
	 *      kControlDisclosureButtonDisclosed.
	 *    
	 *    inAutoToggles:
	 *      A boolean value indicating whether its value should change
	 *      automatically after tracking the mouse.
	 *    
	 *    outControl:
	 *      On successful exit, this will contain the new control.
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateDisclosureButtonControl(inWindow: WindowRef; {CONST}VAR inBoundsRect: Rect; inValue: SInt32; inAutoToggles: BOOLEAN; VAR outControl: ControlRef): OSStatus;


{ Control Kind Tag }

CONST
	kControlKindDisclosureButton = 'disb';


	{
	 *  Discussion:
	 *    Disclosure Button Values
	 	}
	kControlDisclosureButtonClosed = 0;
	kControlDisclosureButtonDisclosed = 1;


	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • ROUND BUTTON                                                                      	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

	{
	 *  ControlRoundButtonSize
	 *  
	 *  Discussion:
	 *    Button Sizes
	 	}

TYPE
	ControlRoundButtonSize 		= SInt16;
CONST
	kControlRoundButtonNormalSize = 0;
	kControlRoundButtonLargeSize = 2;

	{	 Data tags supported by the round button controls 	}
	kControlRoundButtonContentTag = 'cont';						{  ControlButtonContentInfo }
	kControlRoundButtonSizeTag	= 'size';						{  ControlRoundButtonSize }

	{	 Control Kind Tag 	}
	kControlKindRoundButton		= 'rndb';

	{
	 *  CreateRoundButtonControl()
	 *  
	 *  Summary:
	 *    Creates a new instance of the Round Button Control.
	 *  
	 *  Discussion:
	 *    CreateRoundButtonControl is preferred over NewControl because it
	 *    allows you to specify the exact set of parameters required to
	 *    create the control without overloading parameter semantics.
	 *  
	 *  Parameters:
	 *    
	 *    inWindow:
	 *      The WindowRef in which to create the control.
	 *    
	 *    inBoundsRect:
	 *      The bounding rectangle for the control. The height and width of
	 *      the control is fixed (specified by the ControlRoundButtonSize
	 *      parameter) and the control will be centered within the
	 *      rectangle you specify.
	 *    
	 *    inSize:
	 *      The button size; either kControlRoundButtonNormalSize or
	 *      kControlRoundButtonLargeSize.
	 *    
	 *    inContent:
	 *      Any optional content displayed in the button. Currently only
	 *      kControlContentIconRef is supported.
	 *    
	 *    outControl:
	 *      On successful exit, this will contain the new control.
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateRoundButtonControl(inWindow: WindowRef; {CONST}VAR inBoundsRect: Rect; inSize: ControlRoundButtonSize; VAR inContent: ControlButtonContentInfo; VAR outControl: ControlRef): OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————}
{    • DATA BROWSER                                                                    }
{——————————————————————————————————————————————————————————————————————————————————————}
{  This control implements a user interface component for browsing (optionally)        }
{  hiearchical data structures. The browser supports multiple presentation styles      }
{  including, but not limited to:                                                      }
{                                                                                      }
{      kDataBrowserListView   - items and item properties in                           }
{                               multi-column (optionally outline) format               }
{      kDataBrowserColumnView - in-place browsing using fixed navigation columns       }
{                                                                                      }
{  The browser manages all view styles through a single high-level interface.          }
{  The high-level interface makes the following assumptions:                           }
{                                                                                      }
{      - Items have unique 32-bit identifiers (0 is reserved)                          }
{                                                                                      }
{      - Items have two kinds of named and typed properties:                           }
{           - Predefined attribute properties ( < 1024 )                               }
{             (including some display properties)                                      }
{           - Client-defined display properties ( >= 1024 )                            }
{                                                                                      }
{      - Some items are containers of other items                                      }
{      - Items may be sorted by any property                                           }
{                                                                                      }
{  Because a browser doesn't know all details about the type of objects it manages,    }
{  some implementation responsibility is best handled by its client. The client must   }
{  provide a set of callback routines which define the item hierarchy and help to      }
{  populate the browser with items. The client may also provide callbacks for handling }
{  custom data types and doing low-level event management.                             }
{                                                                                      }
{  The API is subdivided into a "universal" set of routines that applies to all view   }
{  styles, and a set of routines unique to each view style. kDataBrowserListView and   }
{  kDataBrowserColumnView share an (internal) TableView abstract base class. The       }
{  TableView formatting options and API applies to both of these view styles.          }
{                                                                                      }
{  NOTE: This control is only available with CarbonLib 1.1.                            }
{ Control Kind Tag }

CONST
	kControlKindDataBrowser		= 'datb';

	{	 Error Codes 	}
	errDataBrowserNotConfigured	= -4970;
	errDataBrowserItemNotFound	= -4971;
	errDataBrowserItemNotAdded	= -4975;
	errDataBrowserPropertyNotFound = -4972;
	errDataBrowserInvalidPropertyPart = -4973;
	errDataBrowserInvalidPropertyData = -4974;
	errDataBrowserPropertyNotSupported = -4979;					{  Return from DataBrowserGetSetItemDataProc  }

																{  Generic Control Tags  }
	kControlDataBrowserIncludesFrameAndFocusTag = 'brdr';		{  Boolean  }
	kControlDataBrowserKeyFilterTag = 'fltr';
	kControlDataBrowserEditTextKeyFilterTag = 'fltr';
	kControlDataBrowserEditTextValidationProcTag = 'vali';

	{	 Data Browser View Styles 	}

TYPE
	DataBrowserViewStyle				= OSType;

CONST
	kDataBrowserNoView			= '????';						{  Error State  }
	kDataBrowserListView		= 'lstv';
	kDataBrowserColumnView		= 'clmv';

	{	 Selection Flags 	}

TYPE
	DataBrowserSelectionFlags 	= UInt32;
CONST
	kDataBrowserDragSelect		= $01;							{  ≈ ListMgr lNoRect  }
	kDataBrowserSelectOnlyOne	= $02;							{  ≈ ListMgr lOnlyOne  }
	kDataBrowserResetSelection	= $04;							{  ≈ ListMgr lNoExtend  }
	kDataBrowserCmdTogglesSelection = $08;						{  ≈ ListMgr lUseSense  }
	kDataBrowserNoDisjointSelection = $10;						{  ≈ ListMgr lNoDisjoint  }
	kDataBrowserAlwaysExtendSelection = $20;					{  ≈ ListMgr lExtendDrag  }
	kDataBrowserNeverEmptySelectionSet = $40;					{  ≈ ListMgr lNoNilHilite  }

	{	 Data Browser Sorting 	}

TYPE
	DataBrowserSortOrder 		= UInt16;
CONST
	kDataBrowserOrderUndefined	= 0;							{  Not currently supported  }
	kDataBrowserOrderIncreasing	= 1;
	kDataBrowserOrderDecreasing	= 2;

	{	 Data Browser Item Management 	}

TYPE
	DataBrowserItemID 			= UInt32;
CONST
	kDataBrowserNoItem			= 0;							{  Reserved DataBrowserItemID  }


TYPE
	DataBrowserItemState 		= UInt32;
CONST
	kDataBrowserItemNoState		= 0;
	kDataBrowserItemAnyState	= -1;
	kDataBrowserItemIsSelected	= $01;
	kDataBrowserContainerIsOpen	= $02;
	kDataBrowserItemIsDragTarget = $04;							{  During a drag operation  }

	{	 Options for use with RevealDataBrowserItem 	}

TYPE
	DataBrowserRevealOptions 	= UInt8;
CONST
	kDataBrowserRevealOnly		= 0;
	kDataBrowserRevealAndCenterInView = $01;
	kDataBrowserRevealWithoutSelecting = $02;

	{	 Set operations for use with SetDataBrowserSelectedItems 	}

TYPE
	DataBrowserSetOption 		= UInt32;
CONST
	kDataBrowserItemsAdd		= 0;							{  add specified items to existing set  }
	kDataBrowserItemsAssign		= 1;							{  assign destination set to specified items  }
	kDataBrowserItemsToggle		= 2;							{  toggle membership state of specified items  }
	kDataBrowserItemsRemove		= 3;							{  remove specified items from existing set  }

	{	 Commands for use with MoveDataBrowserSelectionAnchor 	}

TYPE
	DataBrowserSelectionAnchorDirection  = UInt32;
CONST
	kDataBrowserSelectionAnchorUp = 0;
	kDataBrowserSelectionAnchorDown = 1;
	kDataBrowserSelectionAnchorLeft = 2;
	kDataBrowserSelectionAnchorRight = 3;

	{	 Edit menu command IDs for use with Enable/ExecuteDataBrowserEditCommand 	}

TYPE
	DataBrowserEditCommand 		= UInt32;
CONST
	kDataBrowserEditMsgUndo		= 'undo';
	kDataBrowserEditMsgRedo		= 'redo';
	kDataBrowserEditMsgCut		= 'cut ';
	kDataBrowserEditMsgCopy		= 'copy';
	kDataBrowserEditMsgPaste	= 'past';
	kDataBrowserEditMsgClear	= 'clea';
	kDataBrowserEditMsgSelectAll = 'sall';

	{	 Notifications used in DataBrowserItemNotificationProcPtr 	}

TYPE
	DataBrowserItemNotification  = UInt32;
CONST
	kDataBrowserItemAdded		= 1;							{  The specified item has been added to the browser  }
	kDataBrowserItemRemoved		= 2;							{  The specified item has been removed from the browser  }
	kDataBrowserEditStarted		= 3;							{  Starting an EditText session for specified item  }
	kDataBrowserEditStopped		= 4;							{  Stopping an EditText session for specified item  }
	kDataBrowserItemSelected	= 5;							{  Item has just been added to the selection set  }
	kDataBrowserItemDeselected	= 6;							{  Item has just been removed from the selection set  }
	kDataBrowserItemDoubleClicked = 7;
	kDataBrowserContainerOpened	= 8;							{  Container is open  }
	kDataBrowserContainerClosing = 9;							{  Container is about to close (and will real soon now, y'all)  }
	kDataBrowserContainerClosed	= 10;							{  Container is closed (y'all come back now!)  }
	kDataBrowserContainerSorting = 11;							{  Container is about to be sorted (lock any volatile properties)  }
	kDataBrowserContainerSorted	= 12;							{  Container has been sorted (you may release any property locks)  }
	kDataBrowserUserToggledContainer = 16;						{  _User_ requested container open/close state to be toggled  }
	kDataBrowserTargetChanged	= 15;							{  The target has changed to the specified item  }
	kDataBrowserUserStateChanged = 13;							{  The user has reformatted the view for the target  }
	kDataBrowserSelectionSetChanged = 14;						{  The selection set has been modified (net result may be the same)  }

	{	 DataBrowser Property Management 	}
	{	 0-1023 reserved; >= 1024 for client use 	}

TYPE
	DataBrowserPropertyID 		= UInt32;
CONST
																{  Predefined attribute properties, optional & non-display unless otherwise stated  }
	kDataBrowserItemNoProperty	= 0;							{  The anti-property (no associated data)  }
	kDataBrowserItemIsActiveProperty = 1;						{  Boolean typed data (defaults to true)  }
	kDataBrowserItemIsSelectableProperty = 2;					{  Boolean typed data (defaults to true)  }
	kDataBrowserItemIsEditableProperty = 3;						{  Boolean typed data (defaults to false, used for editable properties)  }
	kDataBrowserItemIsContainerProperty = 4;					{  Boolean typed data (defaults to false)  }
	kDataBrowserContainerIsOpenableProperty = 5;				{  Boolean typed data (defaults to true)  }
	kDataBrowserContainerIsClosableProperty = 6;				{  Boolean typed data (defaults to true)  }
	kDataBrowserContainerIsSortableProperty = 7;				{  Boolean typed data (defaults to true)  }
	kDataBrowserItemSelfIdentityProperty = 8;					{  kDataBrowserIconAndTextType (display property; ColumnView only)  }
	kDataBrowserContainerAliasIDProperty = 9;					{  DataBrowserItemID (alias/symlink an item to a container item)  }
	kDataBrowserColumnViewPreviewProperty = 10;					{  kDataBrowserCustomType (display property; ColumnView only)  }
	kDataBrowserItemParentContainerProperty = 11;				{  DataBrowserItemID (the parent of the specified item, used by ColumnView)  }

	{	 DataBrowser Property Types (for display properties; i.e. ListView columns) 	}
	{	      These are primarily presentation types (or styles) although         	}
	{	      they also imply a particular set of primitive types or structures.  	}

TYPE
	DataBrowserPropertyType				= OSType;

CONST
																{  == Corresponding data type or structure ==  }
	kDataBrowserCustomType		= '????';						{  No associated data, custom callbacks used  }
	kDataBrowserIconType		= 'icnr';						{  IconRef, IconTransformType, RGBColor  }
	kDataBrowserTextType		= 'text';						{  CFStringRef  }
	kDataBrowserDateTimeType	= 'date';						{  DateTime or LongDateTime  }
	kDataBrowserSliderType		= 'sldr';						{  Min, Max, Value  }
	kDataBrowserCheckboxType	= 'chbx';						{  ThemeButtonValue  }
	kDataBrowserProgressBarType	= 'prog';						{  Min, Max, Value  }
	kDataBrowserRelevanceRankType = 'rank';						{  Min, Max, Value  }
	kDataBrowserPopupMenuType	= 'menu';						{  MenuRef, Value  }
	kDataBrowserIconAndTextType	= 'ticn';						{  IconRef, CFStringRef, etc  }

	{	 DataBrowser Property Parts 	}
	{	      Visual components of a property type.      	}
	{	      For use with GetDataBrowserItemPartBounds. 	}

TYPE
	DataBrowserPropertyPart				= OSType;

CONST
	kDataBrowserPropertyEnclosingPart = 0;
	kDataBrowserPropertyContentPart = '----';
	kDataBrowserPropertyDisclosurePart = 'disc';
	kDataBrowserPropertyTextPart = 'text';
	kDataBrowserPropertyIconPart = 'icnr';
	kDataBrowserPropertySliderPart = 'sldr';
	kDataBrowserPropertyCheckboxPart = 'chbx';
	kDataBrowserPropertyProgressBarPart = 'prog';
	kDataBrowserPropertyRelevanceRankPart = 'rank';

	{	 Modify appearance/behavior of display properties 	}

TYPE
	DataBrowserPropertyFlags			= UInt32;
	{  Low 8 bits apply to all property types  }

CONST
	kDataBrowserUniversalPropertyFlagsMask = $FF;
	kDataBrowserPropertyIsMutable = $01;
	kDataBrowserDefaultPropertyFlags = $00;
	kDataBrowserUniversalPropertyFlags = $FF;					{  support for an old name }
	kDataBrowserPropertyIsEditable = $01;						{  support for an old name }

	{  Next 8 bits contain property-specific modifiers  }
	kDataBrowserPropertyFlagsOffset = 8;
	kDataBrowserPropertyFlagsMask = $FF00;
	kDataBrowserCheckboxTriState = $0100;						{  kDataBrowserCheckboxType }
	kDataBrowserDateTimeRelative = $0100;						{  kDataBrowserDateTimeType  }
	kDataBrowserDateTimeDateOnly = $0200;						{  kDataBrowserDateTimeType  }
	kDataBrowserDateTimeTimeOnly = $0400;						{  kDataBrowserDateTimeType  }
	kDataBrowserDateTimeSecondsToo = $0800;						{  kDataBrowserDateTimeType  }
	kDataBrowserSliderPlainThumb = $00;							{  kDataBrowserSliderType  }
	kDataBrowserSliderUpwardThumb = $0100;						{  kDataBrowserSliderType  }
	kDataBrowserSliderDownwardThumb = $0200;					{  kDataBrowserSliderType  }
	kDataBrowserDoNotTruncateText = $0300;						{  kDataBrowserTextType && kDataBrowserIconAndTextType  }
	kDataBrowserTruncateTextAtEnd = $0200;						{  kDataBrowserTextType && kDataBrowserIconAndTextType  }
	kDataBrowserTruncateTextMiddle = $00;						{  kDataBrowserTextType && kDataBrowserIconAndTextType  }
	kDataBrowserTruncateTextAtStart = $0100;					{  kDataBrowserTextType && kDataBrowserIconAndTextType  }
	kDataBrowserPropertyModificationFlags = $FF00;				{  support for an old name }
	kDataBrowserRelativeDateTime = $0100;						{  support for an old name }

	{
	   Next 8 bits contain viewStyle-specific modifiers 
	   See individual ViewStyle sections below for flag definitions 
	}
	kDataBrowserViewSpecificFlagsOffset = 16;
	kDataBrowserViewSpecificFlagsMask = $00FF0000;
	kDataBrowserViewSpecificPropertyFlags = $00FF0000;			{  support for an old name }

	{  High 8 bits are reserved for client application use  }
	kDataBrowserClientPropertyFlagsOffset = 24;
	kDataBrowserClientPropertyFlagsMask = $FF000000;

	{	 Client defined property description 	}

TYPE
	DataBrowserPropertyDescPtr = ^DataBrowserPropertyDesc;
	DataBrowserPropertyDesc = RECORD
		propertyID:				DataBrowserPropertyID;
		propertyType:			DataBrowserPropertyType;
		propertyFlags:			DataBrowserPropertyFlags;
	END;

	{	 Callback definition for use with ForEachDataBrowserItem 	}
{$IFC TYPED_FUNCTION_POINTERS}
	DataBrowserItemProcPtr = PROCEDURE(item: DataBrowserItemID; state: DataBrowserItemState; clientData: UNIV Ptr);
{$ELSEC}
	DataBrowserItemProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	DataBrowserItemUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DataBrowserItemUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppDataBrowserItemProcInfo = $00000FC0;
	{
	 *  NewDataBrowserItemUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewDataBrowserItemUPP(userRoutine: DataBrowserItemProcPtr): DataBrowserItemUPP;
{
 *  DisposeDataBrowserItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDataBrowserItemUPP(userUPP: DataBrowserItemUPP);
{
 *  InvokeDataBrowserItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeDataBrowserItemUPP(item: DataBrowserItemID; state: DataBrowserItemState; clientData: UNIV Ptr; userRoutine: DataBrowserItemUPP);
{ Creation/Configuration }
{
 *  CreateDataBrowserControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateDataBrowserControl(window: WindowRef; {CONST}VAR boundsRect: Rect; style: DataBrowserViewStyle; VAR outControl: ControlRef): OSStatus;

{
 *  GetDataBrowserViewStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserViewStyle(browser: ControlRef; VAR style: DataBrowserViewStyle): OSStatus;

{
 *  SetDataBrowserViewStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserViewStyle(browser: ControlRef; style: DataBrowserViewStyle): OSStatus;

{ Item Manipulation }
{ Passing NULL for "items" argument to RemoveDataBrowserItems and }
{ UpdateDataBrowserItems refers to all items in the specified container }
{
 *  AddDataBrowserItems()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AddDataBrowserItems(browser: ControlRef; container: DataBrowserItemID; numItems: UInt32; {CONST}VAR items: DataBrowserItemID; preSortProperty: DataBrowserPropertyID): OSStatus;

{
 *  RemoveDataBrowserItems()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RemoveDataBrowserItems(browser: ControlRef; container: DataBrowserItemID; numItems: UInt32; {CONST}VAR items: DataBrowserItemID; preSortProperty: DataBrowserPropertyID): OSStatus;

{
 *  UpdateDataBrowserItems()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UpdateDataBrowserItems(browser: ControlRef; container: DataBrowserItemID; numItems: UInt32; {CONST}VAR items: DataBrowserItemID; preSortProperty: DataBrowserPropertyID; propertyID: DataBrowserPropertyID): OSStatus;

{ Edit Menu Enabling and Handling }
{
 *  EnableDataBrowserEditCommand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION EnableDataBrowserEditCommand(browser: ControlRef; command: DataBrowserEditCommand): BOOLEAN;

{
 *  ExecuteDataBrowserEditCommand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ExecuteDataBrowserEditCommand(browser: ControlRef; command: DataBrowserEditCommand): OSStatus;

{
 *  GetDataBrowserSelectionAnchor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserSelectionAnchor(browser: ControlRef; VAR first: DataBrowserItemID; VAR last: DataBrowserItemID): OSStatus;

{
 *  MoveDataBrowserSelectionAnchor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MoveDataBrowserSelectionAnchor(browser: ControlRef; direction: DataBrowserSelectionAnchorDirection; extendSelection: BOOLEAN): OSStatus;

{ Container Manipulation }
{
 *  OpenDataBrowserContainer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OpenDataBrowserContainer(browser: ControlRef; container: DataBrowserItemID): OSStatus;

{
 *  CloseDataBrowserContainer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CloseDataBrowserContainer(browser: ControlRef; container: DataBrowserItemID): OSStatus;

{
 *  SortDataBrowserContainer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SortDataBrowserContainer(browser: ControlRef; container: DataBrowserItemID; sortChildren: BOOLEAN): OSStatus;

{ Aggregate Item Access and Iteration }
{
 *  GetDataBrowserItems()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserItems(browser: ControlRef; container: DataBrowserItemID; recurse: BOOLEAN; state: DataBrowserItemState; items: Handle): OSStatus;

{
 *  GetDataBrowserItemCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserItemCount(browser: ControlRef; container: DataBrowserItemID; recurse: BOOLEAN; state: DataBrowserItemState; VAR numItems: UInt32): OSStatus;

{
 *  ForEachDataBrowserItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ForEachDataBrowserItem(browser: ControlRef; container: DataBrowserItemID; recurse: BOOLEAN; state: DataBrowserItemState; callback: DataBrowserItemUPP; clientData: UNIV Ptr): OSStatus;

{ Individual Item Access and Display }
{
 *  IsDataBrowserItemSelected()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsDataBrowserItemSelected(browser: ControlRef; item: DataBrowserItemID): BOOLEAN;

{
 *  GetDataBrowserItemState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserItemState(browser: ControlRef; item: DataBrowserItemID; VAR state: DataBrowserItemState): OSStatus;

{
 *  RevealDataBrowserItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RevealDataBrowserItem(browser: ControlRef; item: DataBrowserItemID; propertyID: DataBrowserPropertyID; options: ByteParameter): OSStatus;

{ Selection Set Manipulation }
{
 *  SetDataBrowserSelectedItems()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserSelectedItems(browser: ControlRef; numItems: UInt32; {CONST}VAR items: DataBrowserItemID; operation: DataBrowserSetOption): OSStatus;


{ DataBrowser Attribute Manipulation }
{ The user customizable portion of the current view style settings }
{
 *  SetDataBrowserUserState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserUserState(browser: ControlRef; stateInfo: CFDataRef): OSStatus;

{
 *  GetDataBrowserUserState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserUserState(browser: ControlRef; VAR stateInfo: CFDataRef): OSStatus;

{ All items are active/enabled or not }
{
 *  SetDataBrowserActiveItems()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserActiveItems(browser: ControlRef; active: BOOLEAN): OSStatus;

{
 *  GetDataBrowserActiveItems()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserActiveItems(browser: ControlRef; VAR active: BOOLEAN): OSStatus;

{ Inset the scrollbars within the DataBrowser bounds }
{
 *  SetDataBrowserScrollBarInset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserScrollBarInset(browser: ControlRef; VAR insetRect: Rect): OSStatus;

{
 *  GetDataBrowserScrollBarInset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserScrollBarInset(browser: ControlRef; VAR insetRect: Rect): OSStatus;

{ The "user focused" item }
{ For the ListView, this means the root container }
{ For the ColumnView, this means the rightmost container column }
{
 *  SetDataBrowserTarget()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserTarget(browser: ControlRef; target: DataBrowserItemID): OSStatus;

{
 *  GetDataBrowserTarget()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserTarget(browser: ControlRef; VAR target: DataBrowserItemID): OSStatus;

{ Current sort ordering }
{ ListView tracks this per-column }
{
 *  SetDataBrowserSortOrder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserSortOrder(browser: ControlRef; order: DataBrowserSortOrder): OSStatus;

{
 *  GetDataBrowserSortOrder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserSortOrder(browser: ControlRef; VAR order: DataBrowserSortOrder): OSStatus;

{ Scrollbar values }
{
 *  SetDataBrowserScrollPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserScrollPosition(browser: ControlRef; top: UInt32; left: UInt32): OSStatus;

{
 *  GetDataBrowserScrollPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserScrollPosition(browser: ControlRef; VAR top: UInt32; VAR left: UInt32): OSStatus;

{ Show/Hide each scrollbar }
{
 *  SetDataBrowserHasScrollBars()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserHasScrollBars(browser: ControlRef; horiz: BOOLEAN; vert: BOOLEAN): OSStatus;

{
 *  GetDataBrowserHasScrollBars()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserHasScrollBars(browser: ControlRef; VAR horiz: BOOLEAN; VAR vert: BOOLEAN): OSStatus;

{ Property passed to sort callback (ListView sort column) }
{
 *  SetDataBrowserSortProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserSortProperty(browser: ControlRef; property: DataBrowserPropertyID): OSStatus;

{
 *  GetDataBrowserSortProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserSortProperty(browser: ControlRef; VAR property: DataBrowserPropertyID): OSStatus;

{ Modify selection behavior }
{
 *  SetDataBrowserSelectionFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserSelectionFlags(browser: ControlRef; selectionFlags: DataBrowserSelectionFlags): OSStatus;

{
 *  GetDataBrowserSelectionFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserSelectionFlags(browser: ControlRef; VAR selectionFlags: DataBrowserSelectionFlags): OSStatus;

{ Dynamically modify property appearance/behavior }
{
 *  SetDataBrowserPropertyFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserPropertyFlags(browser: ControlRef; property: DataBrowserPropertyID; flags: DataBrowserPropertyFlags): OSStatus;

{
 *  GetDataBrowserPropertyFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserPropertyFlags(browser: ControlRef; property: DataBrowserPropertyID; VAR flags: DataBrowserPropertyFlags): OSStatus;

{ Text of current in-place edit session }
{
 *  SetDataBrowserEditText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserEditText(browser: ControlRef; text: CFStringRef): OSStatus;

{
 *  CopyDataBrowserEditText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CopyDataBrowserEditText(browser: ControlRef; VAR text: CFStringRef): OSStatus;

{
 *  GetDataBrowserEditText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserEditText(browser: ControlRef; text: CFMutableStringRef): OSStatus;

{ Item/property currently being edited }
{
 *  SetDataBrowserEditItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserEditItem(browser: ControlRef; item: DataBrowserItemID; property: DataBrowserPropertyID): OSStatus;

{
 *  GetDataBrowserEditItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserEditItem(browser: ControlRef; VAR item: DataBrowserItemID; VAR property: DataBrowserPropertyID): OSStatus;

{ Get the current bounds of a visual part of an item's property }
{
 *  GetDataBrowserItemPartBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserItemPartBounds(browser: ControlRef; item: DataBrowserItemID; property: DataBrowserPropertyID; part: DataBrowserPropertyPart; VAR bounds: Rect): OSStatus;


{ DataBrowser ItemData Accessors (used within DataBrowserItemData callback) }

TYPE
	DataBrowserItemDataRef				= Ptr;
	{
	 *  SetDataBrowserItemDataIcon()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION SetDataBrowserItemDataIcon(itemData: DataBrowserItemDataRef; theData: IconRef): OSStatus;

{
 *  GetDataBrowserItemDataIcon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserItemDataIcon(itemData: DataBrowserItemDataRef; VAR theData: IconRef): OSStatus;

{
 *  SetDataBrowserItemDataText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserItemDataText(itemData: DataBrowserItemDataRef; theData: CFStringRef): OSStatus;

{
 *  GetDataBrowserItemDataText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserItemDataText(itemData: DataBrowserItemDataRef; VAR theData: CFStringRef): OSStatus;


{
 *  SetDataBrowserItemDataValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserItemDataValue(itemData: DataBrowserItemDataRef; theData: SInt32): OSStatus;

{
 *  GetDataBrowserItemDataValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserItemDataValue(itemData: DataBrowserItemDataRef; VAR theData: SInt32): OSStatus;

{
 *  SetDataBrowserItemDataMinimum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserItemDataMinimum(itemData: DataBrowserItemDataRef; theData: SInt32): OSStatus;

{
 *  GetDataBrowserItemDataMinimum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserItemDataMinimum(itemData: DataBrowserItemDataRef; VAR theData: SInt32): OSStatus;

{
 *  SetDataBrowserItemDataMaximum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserItemDataMaximum(itemData: DataBrowserItemDataRef; theData: SInt32): OSStatus;

{
 *  GetDataBrowserItemDataMaximum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserItemDataMaximum(itemData: DataBrowserItemDataRef; VAR theData: SInt32): OSStatus;

{
 *  SetDataBrowserItemDataBooleanValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserItemDataBooleanValue(itemData: DataBrowserItemDataRef; theData: BOOLEAN): OSStatus;

{
 *  GetDataBrowserItemDataBooleanValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserItemDataBooleanValue(itemData: DataBrowserItemDataRef; VAR theData: BOOLEAN): OSStatus;

{
 *  SetDataBrowserItemDataMenuRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserItemDataMenuRef(itemData: DataBrowserItemDataRef; theData: MenuRef): OSStatus;

{
 *  GetDataBrowserItemDataMenuRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserItemDataMenuRef(itemData: DataBrowserItemDataRef; VAR theData: MenuRef): OSStatus;

{
 *  SetDataBrowserItemDataRGBColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserItemDataRGBColor(itemData: DataBrowserItemDataRef; {CONST}VAR theData: RGBColor): OSStatus;

{
 *  GetDataBrowserItemDataRGBColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserItemDataRGBColor(itemData: DataBrowserItemDataRef; VAR theData: RGBColor): OSStatus;


{
 *  SetDataBrowserItemDataDrawState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserItemDataDrawState(itemData: DataBrowserItemDataRef; theData: ThemeDrawState): OSStatus;

{
 *  GetDataBrowserItemDataDrawState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserItemDataDrawState(itemData: DataBrowserItemDataRef; VAR theData: ThemeDrawState): OSStatus;

{
 *  SetDataBrowserItemDataButtonValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserItemDataButtonValue(itemData: DataBrowserItemDataRef; theData: ThemeButtonValue): OSStatus;

{
 *  GetDataBrowserItemDataButtonValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserItemDataButtonValue(itemData: DataBrowserItemDataRef; VAR theData: ThemeButtonValue): OSStatus;

{
 *  SetDataBrowserItemDataIconTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserItemDataIconTransform(itemData: DataBrowserItemDataRef; theData: IconTransformType): OSStatus;

{
 *  GetDataBrowserItemDataIconTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserItemDataIconTransform(itemData: DataBrowserItemDataRef; VAR theData: IconTransformType): OSStatus;


{
 *  SetDataBrowserItemDataDateTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserItemDataDateTime(itemData: DataBrowserItemDataRef; theData: LONGINT): OSStatus;

{
 *  GetDataBrowserItemDataDateTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserItemDataDateTime(itemData: DataBrowserItemDataRef; VAR theData: LONGINT): OSStatus;

{
 *  SetDataBrowserItemDataLongDateTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserItemDataLongDateTime(itemData: DataBrowserItemDataRef; {CONST}VAR theData: LongDateTime): OSStatus;

{
 *  GetDataBrowserItemDataLongDateTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserItemDataLongDateTime(itemData: DataBrowserItemDataRef; VAR theData: LongDateTime): OSStatus;


{
 *  SetDataBrowserItemDataItemID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserItemDataItemID(itemData: DataBrowserItemDataRef; theData: DataBrowserItemID): OSStatus;

{
 *  GetDataBrowserItemDataItemID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserItemDataItemID(itemData: DataBrowserItemDataRef; VAR theData: DataBrowserItemID): OSStatus;

{
 *  GetDataBrowserItemDataProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserItemDataProperty(itemData: DataBrowserItemDataRef; VAR theData: DataBrowserPropertyID): OSStatus;


{ Standard DataBrowser Callbacks }
{ Basic Item Management & Manipulation }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	DataBrowserItemDataProcPtr = FUNCTION(browser: ControlRef; item: DataBrowserItemID; property: DataBrowserPropertyID; itemData: DataBrowserItemDataRef; setValue: BOOLEAN): OSStatus;
{$ELSEC}
	DataBrowserItemDataProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	DataBrowserItemDataUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DataBrowserItemDataUPP = UniversalProcPtr;
{$ENDC}	
	{	 Item Comparison 	}
{$IFC TYPED_FUNCTION_POINTERS}
	DataBrowserItemCompareProcPtr = FUNCTION(browser: ControlRef; itemOne: DataBrowserItemID; itemTwo: DataBrowserItemID; sortProperty: DataBrowserPropertyID): BOOLEAN;
{$ELSEC}
	DataBrowserItemCompareProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	DataBrowserItemCompareUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DataBrowserItemCompareUPP = UniversalProcPtr;
{$ENDC}	
	{	 ItemEvent Notification 	}
{$IFC TYPED_FUNCTION_POINTERS}
	DataBrowserItemNotificationProcPtr = PROCEDURE(browser: ControlRef; item: DataBrowserItemID; message: DataBrowserItemNotification);
{$ELSEC}
	DataBrowserItemNotificationProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	DataBrowserItemNotificationUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DataBrowserItemNotificationUPP = UniversalProcPtr;
{$ENDC}	

	{	 Drag & Drop Processing 	}
{$IFC TYPED_FUNCTION_POINTERS}
	DataBrowserAddDragItemProcPtr = FUNCTION(browser: ControlRef; theDrag: DragReference; item: DataBrowserItemID; VAR itemRef: ItemReference): BOOLEAN;
{$ELSEC}
	DataBrowserAddDragItemProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DataBrowserAcceptDragProcPtr = FUNCTION(browser: ControlRef; theDrag: DragReference; item: DataBrowserItemID): BOOLEAN;
{$ELSEC}
	DataBrowserAcceptDragProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DataBrowserReceiveDragProcPtr = FUNCTION(browser: ControlRef; theDrag: DragReference; item: DataBrowserItemID): BOOLEAN;
{$ELSEC}
	DataBrowserReceiveDragProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DataBrowserPostProcessDragProcPtr = PROCEDURE(browser: ControlRef; theDrag: DragReference; trackDragResult: OSStatus);
{$ELSEC}
	DataBrowserPostProcessDragProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	DataBrowserAddDragItemUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DataBrowserAddDragItemUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DataBrowserAcceptDragUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DataBrowserAcceptDragUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DataBrowserReceiveDragUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DataBrowserReceiveDragUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DataBrowserPostProcessDragUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DataBrowserPostProcessDragUPP = UniversalProcPtr;
{$ENDC}	
	{	 Contextual Menu Support 	}
{$IFC TYPED_FUNCTION_POINTERS}
	DataBrowserGetContextualMenuProcPtr = PROCEDURE(browser: ControlRef; VAR menu: MenuRef; VAR helpType: UInt32; VAR helpItemString: CFStringRef; VAR selection: AEDesc);
{$ELSEC}
	DataBrowserGetContextualMenuProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DataBrowserSelectContextualMenuProcPtr = PROCEDURE(browser: ControlRef; menu: MenuRef; selectionType: UInt32; menuID: SInt16; menuItem: MenuItemIndex);
{$ELSEC}
	DataBrowserSelectContextualMenuProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	DataBrowserGetContextualMenuUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DataBrowserGetContextualMenuUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DataBrowserSelectContextualMenuUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DataBrowserSelectContextualMenuUPP = UniversalProcPtr;
{$ENDC}	
	{	 Help Manager Support 	}
{$IFC TYPED_FUNCTION_POINTERS}
	DataBrowserItemHelpContentProcPtr = PROCEDURE(browser: ControlRef; item: DataBrowserItemID; property: DataBrowserPropertyID; inRequest: HMContentRequest; VAR outContentProvided: HMContentProvidedType; ioHelpContent: HMHelpContentPtr);
{$ELSEC}
	DataBrowserItemHelpContentProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	DataBrowserItemHelpContentUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DataBrowserItemHelpContentUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppDataBrowserItemDataProcInfo = $00007FF0;
	uppDataBrowserItemCompareProcInfo = $00003FD0;
	uppDataBrowserItemNotificationProcInfo = $00000FC0;
	uppDataBrowserAddDragItemProcInfo = $00003FD0;
	uppDataBrowserAcceptDragProcInfo = $00000FD0;
	uppDataBrowserReceiveDragProcInfo = $00000FD0;
	uppDataBrowserPostProcessDragProcInfo = $00000FC0;
	uppDataBrowserGetContextualMenuProcInfo = $0000FFC0;
	uppDataBrowserSelectContextualMenuProcInfo = $0000AFC0;
	uppDataBrowserItemHelpContentProcInfo = $0003EFC0;
	{
	 *  NewDataBrowserItemDataUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewDataBrowserItemDataUPP(userRoutine: DataBrowserItemDataProcPtr): DataBrowserItemDataUPP;
{
 *  NewDataBrowserItemCompareUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDataBrowserItemCompareUPP(userRoutine: DataBrowserItemCompareProcPtr): DataBrowserItemCompareUPP;
{
 *  NewDataBrowserItemNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDataBrowserItemNotificationUPP(userRoutine: DataBrowserItemNotificationProcPtr): DataBrowserItemNotificationUPP;
{
 *  NewDataBrowserAddDragItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDataBrowserAddDragItemUPP(userRoutine: DataBrowserAddDragItemProcPtr): DataBrowserAddDragItemUPP;
{
 *  NewDataBrowserAcceptDragUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDataBrowserAcceptDragUPP(userRoutine: DataBrowserAcceptDragProcPtr): DataBrowserAcceptDragUPP;
{
 *  NewDataBrowserReceiveDragUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDataBrowserReceiveDragUPP(userRoutine: DataBrowserReceiveDragProcPtr): DataBrowserReceiveDragUPP;
{
 *  NewDataBrowserPostProcessDragUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDataBrowserPostProcessDragUPP(userRoutine: DataBrowserPostProcessDragProcPtr): DataBrowserPostProcessDragUPP;
{
 *  NewDataBrowserGetContextualMenuUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDataBrowserGetContextualMenuUPP(userRoutine: DataBrowserGetContextualMenuProcPtr): DataBrowserGetContextualMenuUPP;
{
 *  NewDataBrowserSelectContextualMenuUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDataBrowserSelectContextualMenuUPP(userRoutine: DataBrowserSelectContextualMenuProcPtr): DataBrowserSelectContextualMenuUPP;
{
 *  NewDataBrowserItemHelpContentUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDataBrowserItemHelpContentUPP(userRoutine: DataBrowserItemHelpContentProcPtr): DataBrowserItemHelpContentUPP;
{
 *  DisposeDataBrowserItemDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDataBrowserItemDataUPP(userUPP: DataBrowserItemDataUPP);
{
 *  DisposeDataBrowserItemCompareUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDataBrowserItemCompareUPP(userUPP: DataBrowserItemCompareUPP);
{
 *  DisposeDataBrowserItemNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDataBrowserItemNotificationUPP(userUPP: DataBrowserItemNotificationUPP);
{
 *  DisposeDataBrowserAddDragItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDataBrowserAddDragItemUPP(userUPP: DataBrowserAddDragItemUPP);
{
 *  DisposeDataBrowserAcceptDragUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDataBrowserAcceptDragUPP(userUPP: DataBrowserAcceptDragUPP);
{
 *  DisposeDataBrowserReceiveDragUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDataBrowserReceiveDragUPP(userUPP: DataBrowserReceiveDragUPP);
{
 *  DisposeDataBrowserPostProcessDragUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDataBrowserPostProcessDragUPP(userUPP: DataBrowserPostProcessDragUPP);
{
 *  DisposeDataBrowserGetContextualMenuUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDataBrowserGetContextualMenuUPP(userUPP: DataBrowserGetContextualMenuUPP);
{
 *  DisposeDataBrowserSelectContextualMenuUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDataBrowserSelectContextualMenuUPP(userUPP: DataBrowserSelectContextualMenuUPP);
{
 *  DisposeDataBrowserItemHelpContentUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDataBrowserItemHelpContentUPP(userUPP: DataBrowserItemHelpContentUPP);
{
 *  InvokeDataBrowserItemDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeDataBrowserItemDataUPP(browser: ControlRef; item: DataBrowserItemID; property: DataBrowserPropertyID; itemData: DataBrowserItemDataRef; setValue: BOOLEAN; userRoutine: DataBrowserItemDataUPP): OSStatus;
{
 *  InvokeDataBrowserItemCompareUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeDataBrowserItemCompareUPP(browser: ControlRef; itemOne: DataBrowserItemID; itemTwo: DataBrowserItemID; sortProperty: DataBrowserPropertyID; userRoutine: DataBrowserItemCompareUPP): BOOLEAN;
{
 *  InvokeDataBrowserItemNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeDataBrowserItemNotificationUPP(browser: ControlRef; item: DataBrowserItemID; message: DataBrowserItemNotification; userRoutine: DataBrowserItemNotificationUPP);
{
 *  InvokeDataBrowserAddDragItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeDataBrowserAddDragItemUPP(browser: ControlRef; theDrag: DragReference; item: DataBrowserItemID; VAR itemRef: ItemReference; userRoutine: DataBrowserAddDragItemUPP): BOOLEAN;
{
 *  InvokeDataBrowserAcceptDragUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeDataBrowserAcceptDragUPP(browser: ControlRef; theDrag: DragReference; item: DataBrowserItemID; userRoutine: DataBrowserAcceptDragUPP): BOOLEAN;
{
 *  InvokeDataBrowserReceiveDragUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeDataBrowserReceiveDragUPP(browser: ControlRef; theDrag: DragReference; item: DataBrowserItemID; userRoutine: DataBrowserReceiveDragUPP): BOOLEAN;
{
 *  InvokeDataBrowserPostProcessDragUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeDataBrowserPostProcessDragUPP(browser: ControlRef; theDrag: DragReference; trackDragResult: OSStatus; userRoutine: DataBrowserPostProcessDragUPP);
{
 *  InvokeDataBrowserGetContextualMenuUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeDataBrowserGetContextualMenuUPP(browser: ControlRef; VAR menu: MenuRef; VAR helpType: UInt32; VAR helpItemString: CFStringRef; VAR selection: AEDesc; userRoutine: DataBrowserGetContextualMenuUPP);
{
 *  InvokeDataBrowserSelectContextualMenuUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeDataBrowserSelectContextualMenuUPP(browser: ControlRef; menu: MenuRef; selectionType: UInt32; menuID: SInt16; menuItem: MenuItemIndex; userRoutine: DataBrowserSelectContextualMenuUPP);
{
 *  InvokeDataBrowserItemHelpContentUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeDataBrowserItemHelpContentUPP(browser: ControlRef; item: DataBrowserItemID; property: DataBrowserPropertyID; inRequest: HMContentRequest; VAR outContentProvided: HMContentProvidedType; ioHelpContent: HMHelpContentPtr; userRoutine: DataBrowserItemHelpContentUPP);
{ Standard Callback (vtable) Structure }

CONST
	kDataBrowserLatestCallbacks	= 0;


TYPE
	DataBrowserCallbacksPtr = ^DataBrowserCallbacks;
	DataBrowserCallbacks = RECORD
		version:				UInt32;									{  Use kDataBrowserLatestCallbacks  }
		CASE INTEGER OF
		0: (
			itemDataCallback:	DataBrowserItemDataUPP;
			itemCompareCallback: DataBrowserItemCompareUPP;
			itemNotificationCallback: DataBrowserItemNotificationUPP;
			addDragItemCallback: DataBrowserAddDragItemUPP;
			acceptDragCallback:	DataBrowserAcceptDragUPP;
			receiveDragCallback: DataBrowserReceiveDragUPP;
			postProcessDragCallback: DataBrowserPostProcessDragUPP;
			itemHelpContentCallback: DataBrowserItemHelpContentUPP;
			getContextualMenuCallback: DataBrowserGetContextualMenuUPP;
			selectContextualMenuCallback: DataBrowserSelectContextualMenuUPP;
		   );
	END;

	{
	 *  InitDataBrowserCallbacks()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION InitDataBrowserCallbacks(VAR callbacks: DataBrowserCallbacks): OSStatus;

{
 *  GetDataBrowserCallbacks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserCallbacks(browser: ControlRef; VAR callbacks: DataBrowserCallbacks): OSStatus;

{
 *  SetDataBrowserCallbacks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserCallbacks(browser: ControlRef; {CONST}VAR callbacks: DataBrowserCallbacks): OSStatus;


{ Custom Format Callbacks (kDataBrowserCustomType display properties) }

TYPE
	DataBrowserDragFlags				= UInt32;
	DataBrowserTrackingResult 	= SInt16;
CONST
	kDataBrowserContentHit		= 1;
	kDataBrowserNothingHit		= 0;
	kDataBrowserStopTracking	= -1;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	DataBrowserDrawItemProcPtr = PROCEDURE(browser: ControlRef; item: DataBrowserItemID; property: DataBrowserPropertyID; itemState: DataBrowserItemState; {CONST}VAR theRect: Rect; gdDepth: SInt16; colorDevice: BOOLEAN);
{$ELSEC}
	DataBrowserDrawItemProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DataBrowserEditItemProcPtr = FUNCTION(browser: ControlRef; item: DataBrowserItemID; property: DataBrowserPropertyID; theString: CFStringRef; VAR maxEditTextRect: Rect; VAR shrinkToFit: BOOLEAN): BOOLEAN;
{$ELSEC}
	DataBrowserEditItemProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DataBrowserHitTestProcPtr = FUNCTION(browser: ControlRef; itemID: DataBrowserItemID; property: DataBrowserPropertyID; {CONST}VAR theRect: Rect; {CONST}VAR mouseRect: Rect): BOOLEAN;
{$ELSEC}
	DataBrowserHitTestProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DataBrowserTrackingProcPtr = FUNCTION(browser: ControlRef; itemID: DataBrowserItemID; property: DataBrowserPropertyID; {CONST}VAR theRect: Rect; startPt: Point; modifiers: EventModifiers): DataBrowserTrackingResult;
{$ELSEC}
	DataBrowserTrackingProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DataBrowserItemDragRgnProcPtr = PROCEDURE(browser: ControlRef; itemID: DataBrowserItemID; property: DataBrowserPropertyID; {CONST}VAR theRect: Rect; dragRgn: RgnHandle);
{$ELSEC}
	DataBrowserItemDragRgnProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DataBrowserItemAcceptDragProcPtr = FUNCTION(browser: ControlRef; itemID: DataBrowserItemID; property: DataBrowserPropertyID; {CONST}VAR theRect: Rect; theDrag: DragReference): DataBrowserDragFlags;
{$ELSEC}
	DataBrowserItemAcceptDragProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DataBrowserItemReceiveDragProcPtr = FUNCTION(browser: ControlRef; itemID: DataBrowserItemID; property: DataBrowserPropertyID; dragFlags: DataBrowserDragFlags; theDrag: DragReference): BOOLEAN;
{$ELSEC}
	DataBrowserItemReceiveDragProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	DataBrowserDrawItemUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DataBrowserDrawItemUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DataBrowserEditItemUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DataBrowserEditItemUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DataBrowserHitTestUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DataBrowserHitTestUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DataBrowserTrackingUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DataBrowserTrackingUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DataBrowserItemDragRgnUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DataBrowserItemDragRgnUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DataBrowserItemAcceptDragUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DataBrowserItemAcceptDragUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DataBrowserItemReceiveDragUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DataBrowserItemReceiveDragUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppDataBrowserDrawItemProcInfo = $0006FFC0;
	uppDataBrowserEditItemProcInfo = $0003FFD0;
	uppDataBrowserHitTestProcInfo = $0000FFD0;
	uppDataBrowserTrackingProcInfo = $0002FFE0;
	uppDataBrowserItemDragRgnProcInfo = $0000FFC0;
	uppDataBrowserItemAcceptDragProcInfo = $0000FFF0;
	uppDataBrowserItemReceiveDragProcInfo = $0000FFD0;
	{
	 *  NewDataBrowserDrawItemUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewDataBrowserDrawItemUPP(userRoutine: DataBrowserDrawItemProcPtr): DataBrowserDrawItemUPP;
{
 *  NewDataBrowserEditItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDataBrowserEditItemUPP(userRoutine: DataBrowserEditItemProcPtr): DataBrowserEditItemUPP;
{
 *  NewDataBrowserHitTestUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDataBrowserHitTestUPP(userRoutine: DataBrowserHitTestProcPtr): DataBrowserHitTestUPP;
{
 *  NewDataBrowserTrackingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDataBrowserTrackingUPP(userRoutine: DataBrowserTrackingProcPtr): DataBrowserTrackingUPP;
{
 *  NewDataBrowserItemDragRgnUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDataBrowserItemDragRgnUPP(userRoutine: DataBrowserItemDragRgnProcPtr): DataBrowserItemDragRgnUPP;
{
 *  NewDataBrowserItemAcceptDragUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDataBrowserItemAcceptDragUPP(userRoutine: DataBrowserItemAcceptDragProcPtr): DataBrowserItemAcceptDragUPP;
{
 *  NewDataBrowserItemReceiveDragUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDataBrowserItemReceiveDragUPP(userRoutine: DataBrowserItemReceiveDragProcPtr): DataBrowserItemReceiveDragUPP;
{
 *  DisposeDataBrowserDrawItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDataBrowserDrawItemUPP(userUPP: DataBrowserDrawItemUPP);
{
 *  DisposeDataBrowserEditItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDataBrowserEditItemUPP(userUPP: DataBrowserEditItemUPP);
{
 *  DisposeDataBrowserHitTestUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDataBrowserHitTestUPP(userUPP: DataBrowserHitTestUPP);
{
 *  DisposeDataBrowserTrackingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDataBrowserTrackingUPP(userUPP: DataBrowserTrackingUPP);
{
 *  DisposeDataBrowserItemDragRgnUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDataBrowserItemDragRgnUPP(userUPP: DataBrowserItemDragRgnUPP);
{
 *  DisposeDataBrowserItemAcceptDragUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDataBrowserItemAcceptDragUPP(userUPP: DataBrowserItemAcceptDragUPP);
{
 *  DisposeDataBrowserItemReceiveDragUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDataBrowserItemReceiveDragUPP(userUPP: DataBrowserItemReceiveDragUPP);
{
 *  InvokeDataBrowserDrawItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeDataBrowserDrawItemUPP(browser: ControlRef; item: DataBrowserItemID; property: DataBrowserPropertyID; itemState: DataBrowserItemState; {CONST}VAR theRect: Rect; gdDepth: SInt16; colorDevice: BOOLEAN; userRoutine: DataBrowserDrawItemUPP);
{
 *  InvokeDataBrowserEditItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeDataBrowserEditItemUPP(browser: ControlRef; item: DataBrowserItemID; property: DataBrowserPropertyID; theString: CFStringRef; VAR maxEditTextRect: Rect; VAR shrinkToFit: BOOLEAN; userRoutine: DataBrowserEditItemUPP): BOOLEAN;
{
 *  InvokeDataBrowserHitTestUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeDataBrowserHitTestUPP(browser: ControlRef; itemID: DataBrowserItemID; property: DataBrowserPropertyID; {CONST}VAR theRect: Rect; {CONST}VAR mouseRect: Rect; userRoutine: DataBrowserHitTestUPP): BOOLEAN;
{
 *  InvokeDataBrowserTrackingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeDataBrowserTrackingUPP(browser: ControlRef; itemID: DataBrowserItemID; property: DataBrowserPropertyID; {CONST}VAR theRect: Rect; startPt: Point; modifiers: EventModifiers; userRoutine: DataBrowserTrackingUPP): DataBrowserTrackingResult;
{
 *  InvokeDataBrowserItemDragRgnUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeDataBrowserItemDragRgnUPP(browser: ControlRef; itemID: DataBrowserItemID; property: DataBrowserPropertyID; {CONST}VAR theRect: Rect; dragRgn: RgnHandle; userRoutine: DataBrowserItemDragRgnUPP);
{
 *  InvokeDataBrowserItemAcceptDragUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeDataBrowserItemAcceptDragUPP(browser: ControlRef; itemID: DataBrowserItemID; property: DataBrowserPropertyID; {CONST}VAR theRect: Rect; theDrag: DragReference; userRoutine: DataBrowserItemAcceptDragUPP): DataBrowserDragFlags;
{
 *  InvokeDataBrowserItemReceiveDragUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeDataBrowserItemReceiveDragUPP(browser: ControlRef; itemID: DataBrowserItemID; property: DataBrowserPropertyID; dragFlags: DataBrowserDragFlags; theDrag: DragReference; userRoutine: DataBrowserItemReceiveDragUPP): BOOLEAN;
{ Custom Callback (vtable) Structure }

CONST
	kDataBrowserLatestCustomCallbacks = 0;


TYPE
	DataBrowserCustomCallbacksPtr = ^DataBrowserCustomCallbacks;
	DataBrowserCustomCallbacks = RECORD
		version:				UInt32;									{  Use kDataBrowserLatestCustomCallbacks  }
		CASE INTEGER OF
		0: (
			drawItemCallback:	DataBrowserDrawItemUPP;
			editTextCallback:	DataBrowserEditItemUPP;
			hitTestCallback:	DataBrowserHitTestUPP;
			trackingCallback:	DataBrowserTrackingUPP;
			dragRegionCallback:	DataBrowserItemDragRgnUPP;
			acceptDragCallback:	DataBrowserItemAcceptDragUPP;
			receiveDragCallback: DataBrowserItemReceiveDragUPP;
		   );
	END;

	{
	 *  InitDataBrowserCustomCallbacks()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION InitDataBrowserCustomCallbacks(VAR callbacks: DataBrowserCustomCallbacks): OSStatus;

{
 *  GetDataBrowserCustomCallbacks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserCustomCallbacks(browser: ControlRef; VAR callbacks: DataBrowserCustomCallbacks): OSStatus;

{
 *  SetDataBrowserCustomCallbacks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserCustomCallbacks(browser: ControlRef; {CONST}VAR callbacks: DataBrowserCustomCallbacks): OSStatus;




{ TableView Formatting }

TYPE
	DataBrowserTableViewHiliteStyle  = UInt32;
CONST
	kDataBrowserTableViewMinimalHilite = 0;
	kDataBrowserTableViewFillHilite = 1;


TYPE
	DataBrowserTableViewPropertyFlags  = UInt32;
CONST
																{  kDataBrowserTableView DataBrowserPropertyFlags  }
	kDataBrowserTableViewSelectionColumn = $00010000;


TYPE
	DataBrowserTableViewRowIndex		= UInt32;
	DataBrowserTableViewColumnIndex		= UInt32;
	DataBrowserTableViewColumnID		= DataBrowserPropertyID;
	DataBrowserTableViewColumnDesc		= DataBrowserPropertyDesc;
	DataBrowserTableViewColumnDescPtr 	= ^DataBrowserTableViewColumnDesc;

	{	 TableView API 	}
	{	 Use when setting column position 	}

CONST
	kDataBrowserTableViewLastColumn = -1;

	{
	 *  RemoveDataBrowserTableViewColumn()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION RemoveDataBrowserTableViewColumn(browser: ControlRef; column: DataBrowserTableViewColumnID): OSStatus;

{
 *  GetDataBrowserTableViewColumnCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserTableViewColumnCount(browser: ControlRef; VAR numColumns: UInt32): OSStatus;


{
 *  SetDataBrowserTableViewHiliteStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserTableViewHiliteStyle(browser: ControlRef; hiliteStyle: DataBrowserTableViewHiliteStyle): OSStatus;

{
 *  GetDataBrowserTableViewHiliteStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserTableViewHiliteStyle(browser: ControlRef; VAR hiliteStyle: DataBrowserTableViewHiliteStyle): OSStatus;


{
 *  SetDataBrowserTableViewRowHeight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserTableViewRowHeight(browser: ControlRef; height: UInt16): OSStatus;

{
 *  GetDataBrowserTableViewRowHeight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserTableViewRowHeight(browser: ControlRef; VAR height: UInt16): OSStatus;

{
 *  SetDataBrowserTableViewColumnWidth()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserTableViewColumnWidth(browser: ControlRef; width: UInt16): OSStatus;

{
 *  GetDataBrowserTableViewColumnWidth()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserTableViewColumnWidth(browser: ControlRef; VAR width: UInt16): OSStatus;

{
 *  SetDataBrowserTableViewItemRowHeight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserTableViewItemRowHeight(browser: ControlRef; item: DataBrowserItemID; height: UInt16): OSStatus;

{
 *  GetDataBrowserTableViewItemRowHeight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserTableViewItemRowHeight(browser: ControlRef; item: DataBrowserItemID; VAR height: UInt16): OSStatus;

{
 *  SetDataBrowserTableViewNamedColumnWidth()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserTableViewNamedColumnWidth(browser: ControlRef; column: DataBrowserTableViewColumnID; width: UInt16): OSStatus;

{
 *  GetDataBrowserTableViewNamedColumnWidth()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserTableViewNamedColumnWidth(browser: ControlRef; column: DataBrowserTableViewColumnID; VAR width: UInt16): OSStatus;

{
 *  SetDataBrowserTableViewGeometry()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserTableViewGeometry(browser: ControlRef; variableWidthColumns: BOOLEAN; variableHeightRows: BOOLEAN): OSStatus;

{
 *  GetDataBrowserTableViewGeometry()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserTableViewGeometry(browser: ControlRef; VAR variableWidthColumns: BOOLEAN; VAR variableHeightRows: BOOLEAN): OSStatus;


{
 *  GetDataBrowserTableViewItemID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserTableViewItemID(browser: ControlRef; row: DataBrowserTableViewRowIndex; VAR item: DataBrowserItemID): OSStatus;

{
 *  SetDataBrowserTableViewItemRow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserTableViewItemRow(browser: ControlRef; item: DataBrowserItemID; row: DataBrowserTableViewRowIndex): OSStatus;

{
 *  GetDataBrowserTableViewItemRow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserTableViewItemRow(browser: ControlRef; item: DataBrowserItemID; VAR row: DataBrowserTableViewRowIndex): OSStatus;

{
 *  SetDataBrowserTableViewColumnPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserTableViewColumnPosition(browser: ControlRef; column: DataBrowserTableViewColumnID; position: DataBrowserTableViewColumnIndex): OSStatus;

{
 *  GetDataBrowserTableViewColumnPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserTableViewColumnPosition(browser: ControlRef; column: DataBrowserTableViewColumnID; VAR position: DataBrowserTableViewColumnIndex): OSStatus;

{
 *  GetDataBrowserTableViewColumnProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserTableViewColumnProperty(browser: ControlRef; column: DataBrowserTableViewColumnIndex; VAR property: DataBrowserTableViewColumnID): OSStatus;




{ kDataBrowserListView Formatting }

TYPE
	DataBrowserListViewPropertyFlags  = UInt32;
CONST
																{  kDataBrowserListView DataBrowserPropertyFlags  }
	kDataBrowserListViewMovableColumn = $00020000;
	kDataBrowserListViewSortableColumn = $00040000;
	kDataBrowserListViewSelectionColumn = $00010000;
	kDataBrowserListViewDefaultColumnFlags = $00060000;


	kDataBrowserListViewLatestHeaderDesc = 0;


TYPE
	DataBrowserListViewHeaderDescPtr = ^DataBrowserListViewHeaderDesc;
	DataBrowserListViewHeaderDesc = RECORD
		version:				UInt32;									{  Use kDataBrowserListViewLatestHeaderDesc  }
		minimumWidth:			UInt16;
		maximumWidth:			UInt16;
		titleOffset:			SInt16;
		titleString:			CFStringRef;
		initialOrder:			DataBrowserSortOrder;
		btnFontStyle:			ControlFontStyleRec;
		btnContentInfo:			ControlButtonContentInfo;
	END;

	DataBrowserListViewColumnDescPtr = ^DataBrowserListViewColumnDesc;
	DataBrowserListViewColumnDesc = RECORD
		propertyDesc:			DataBrowserTableViewColumnDesc;
		headerBtnDesc:			DataBrowserListViewHeaderDesc;
	END;

	{	 kDataBrowserListView API 	}

CONST
	kDataBrowserListViewAppendColumn = -1;

	{
	 *  AutoSizeDataBrowserListViewColumns()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION AutoSizeDataBrowserListViewColumns(browser: ControlRef): OSStatus;

{
 *  AddDataBrowserListViewColumn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AddDataBrowserListViewColumn(browser: ControlRef; VAR columnDesc: DataBrowserListViewColumnDesc; position: DataBrowserTableViewColumnIndex): OSStatus;

{
 *  SetDataBrowserListViewHeaderBtnHeight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserListViewHeaderBtnHeight(browser: ControlRef; height: UInt16): OSStatus;

{
 *  GetDataBrowserListViewHeaderBtnHeight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserListViewHeaderBtnHeight(browser: ControlRef; VAR height: UInt16): OSStatus;

{
 *  SetDataBrowserListViewUsePlainBackground()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserListViewUsePlainBackground(browser: ControlRef; usePlainBackground: BOOLEAN): OSStatus;

{
 *  GetDataBrowserListViewUsePlainBackground()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserListViewUsePlainBackground(browser: ControlRef; VAR usePlainBackground: BOOLEAN): OSStatus;

{
 *  SetDataBrowserListViewDisclosureColumn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserListViewDisclosureColumn(browser: ControlRef; column: DataBrowserTableViewColumnID; expandableRows: BOOLEAN): OSStatus;

{
 *  GetDataBrowserListViewDisclosureColumn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserListViewDisclosureColumn(browser: ControlRef; VAR column: DataBrowserTableViewColumnID; VAR expandableRows: BOOLEAN): OSStatus;


{ kDataBrowserColumnView API }
{
 *  GetDataBrowserColumnViewPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserColumnViewPath(browser: ControlRef; path: Handle): OSStatus;

{
 *  GetDataBrowserColumnViewPathLength()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserColumnViewPathLength(browser: ControlRef; VAR pathLength: UInt32): OSStatus;

{
 *  SetDataBrowserColumnViewPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserColumnViewPath(browser: ControlRef; length: UInt32; {CONST}VAR path: DataBrowserItemID): OSStatus;

{
 *  SetDataBrowserColumnViewDisplayType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDataBrowserColumnViewDisplayType(browser: ControlRef; propertyType: DataBrowserPropertyType): OSStatus;

{
 *  GetDataBrowserColumnViewDisplayType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDataBrowserColumnViewDisplayType(browser: ControlRef; VAR propertyType: DataBrowserPropertyType): OSStatus;


{ DataBrowser UPP macros }
{---------------------------------------------------------------------------------------}
{ EditUnicodeText Contol                                                                }
{---------------------------------------------------------------------------------------}
{ This control is only available in X, XXXXX.  It is super similar to Edit Text control }
{ Use all the same Get/Set tags.  But don't ask for the TEHandle.           }
{---------------------------------------------------------------------------------------}
{ This callback supplies the functionality of the TSMTEPostUpdateProcPtr that is used }
{ in the EditText control.  A client should supply this call if they want to look at  }
{ inline text that has been fixed before it is included in the actual body text       }
{ if the new text (i.e. the text in the handle) should be included in the body text    }
{ the client should return true.  If the client wants to block the inclusion of the    }
{ text they should return false.                                                       }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	EditUnicodePostUpdateProcPtr = FUNCTION(uniText: UniCharArrayHandle; uniTextLength: UniCharCount; iStartOffset: UniCharArrayOffset; iEndOffset: UniCharArrayOffset; refcon: UNIV Ptr): BOOLEAN;
{$ELSEC}
	EditUnicodePostUpdateProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	EditUnicodePostUpdateUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	EditUnicodePostUpdateUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppEditUnicodePostUpdateProcInfo = $0000FFD0;
	{
	 *  NewEditUnicodePostUpdateUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib on Mac OS X
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewEditUnicodePostUpdateUPP(userRoutine: EditUnicodePostUpdateProcPtr): EditUnicodePostUpdateUPP;
{
 *  DisposeEditUnicodePostUpdateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib on Mac OS X
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeEditUnicodePostUpdateUPP(userUPP: EditUnicodePostUpdateUPP);
{
 *  InvokeEditUnicodePostUpdateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib on Mac OS X
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeEditUnicodePostUpdateUPP(uniText: UniCharArrayHandle; uniTextLength: UniCharCount; iStartOffset: UniCharArrayOffset; iEndOffset: UniCharArrayOffset; refcon: UNIV Ptr; userRoutine: EditUnicodePostUpdateUPP): BOOLEAN;
{ Use this tag when calling ControlSet/GetData to specify the UnicodePostUpdateProcPtr }
{ tags available with Appearance 1.1 or later }

CONST
	kControlEditUnicodeTextPostUpdateProcTag = 'upup';


	kControlEditUnicodeTextProc	= 912;
	kControlEditUnicodeTextPasswordProc = 914;

	{	 Creation API for X 	}
	{
	 *  CreateEditUnicodeTextControl()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateEditUnicodeTextControl(window: WindowRef; {CONST}VAR boundsRect: Rect; text: CFStringRef; isPassword: BOOLEAN; {CONST}VAR style: ControlFontStyleRec; VAR outControl: ControlRef): OSStatus;



{$IFC OLDROUTINENAMES }
{——————————————————————————————————————————————————————————————————————————————————————}
{  • OLDROUTINENAMES                                                                   }
{——————————————————————————————————————————————————————————————————————————————————————}

CONST
	inLabel						= 1;
	inMenu						= 2;
	inTriangle					= 4;
	inButton					= 10;
	inCheckBox					= 11;
	inUpButton					= 20;
	inDownButton				= 21;
	inPageUp					= 22;
	inPageDown					= 23;

	kInLabelControlPart			= 1;
	kInMenuControlPart			= 2;
	kInTriangleControlPart		= 4;
	kInButtonControlPart		= 10;
	kInCheckBoxControlPart		= 11;
	kInUpButtonControlPart		= 20;
	kInDownButtonControlPart	= 21;
	kInPageUpControlPart		= 22;
	kInPageDownControlPart		= 23;


{$ENDC}  {OLDROUTINENAMES}




{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ControlDefinitionsIncludes}

{$ENDC} {__CONTROLDEFINITIONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
