{
     File:       AVComponents.p
 
     Contains:   Standard includes for standard AV panels
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1989-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT AVComponents;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __AVCOMPONENTS__}
{$SETC __AVCOMPONENTS__ := 1}

{$I+}
{$SETC AVComponentsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __VIDEO__}
{$I Video.p}
{$ENDC}
{$IFC UNDEFINED __DISPLAYS__}
{$I Displays.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __CMAPPLICATION__}
{$I CMApplication.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
    The subtypes listed here are for example only.  The display manager will find _all_ panels
    with the appropriate types.  These panels return class information that is used to devide them
    up into groups to be displayed in the AV Windows (class means "geometry" or "color" or other groupings
    like that.
}

CONST
	kAVPanelType				= 'avpc';						{  Panel subtypes         }
	kBrightnessPanelSubType		= 'brit';
	kContrastPanelSubType		= 'cont';
	kBitDepthPanelSubType		= 'bitd';
	kAVEngineType				= 'avec';						{  Engine subtypes           }
	kBrightnessEngineSubType	= 'brit';
	kContrastEngineSubType		= 'cont';						{     kBitDepthEngineSubType     = 'bitd',       // Not used               }
	kAVPortType					= 'avdp';						{  subtypes are defined in each port's public .h file  }
	kAVUtilityType				= 'avuc';
	kAVBackChannelSubType		= 'avbc';
	kAVCommunicationType		= 'avcm';
	kAVDialogType				= 'avdg';

	{	 PortComponent subtypes are up to the port and display manager does not use the subtype
	    to find port components.  Instead, display manager uses an internal cache to search for portcompoennts.
	    It turns out to be useful to have a unique subtype so that engines can see if they should apply themselves to
	    a particular port component.
	  
	   PortKinds are the "class" of port.  When a port is registered with display manager (creating a display ID), the
	    caller of DMNewDisplayIDByPortComponent passes a portKind.  Ports of this type are returned by
	    DMNewDevicePortList.
	  
	   PortKinds are NOT subtypes of components
	   PortKinds ARE used to register and find port components with Display Manager.  Here are the basic port kinds:
	  
	   Video displays are distinct from video out because there are some video out ports that are not actaully displays.
	    if EZAV is looking to configure displays, it needs to look for kAVVideoDisplayPortKind not kAVVideoOutPortKind.
		}
	kAVVideoDisplayPortKind		= 'pkdo';						{  Video Display (CRT or panel display)           }
	kAVVideoOutPortKind			= 'pkvo';						{  Video out port (camera output).                 }
	kAVVideoInPortKind			= 'pkvi';						{  Video in port (camera input)                }
	kAVSoundOutPortKind			= 'pkso';						{  Sound out port (speaker or speaker jack)       }
	kAVSoundInPortKind			= 'pksi';						{  Sound in port (microphone or microphone jack)   }
	kAVDeviceType				= 'avdc';						{  Device Component subtypes are up to the manufacturor since each device may contain multiple function types (eg telecaster)  }
	kAVDisplayDeviceKind		= 'dkvo';						{  Display device }
																{  Device Component subtypes are up to the manufacturor since each device may contain multiple function types (eg telecaster) }
	kAVCategoryType				= 'avcc';
	kAVSoundInSubType			= 'avao';
	kAVSoundOutSubType			= 'avai';
	kAVVideoInSubType			= 'vdin';
	kAVVideoOutSubType			= 'vdou';
	kAVInvalidType				= 'badt';						{  Some calls return a component type, in case of errors, these types are set to kAVInvalidComponentType  }

	{
	   Interface Signatures are used to identify what kind of component
	   calls can be made for a given component. Today this applies only
	   to ports, but could be applied to other components as well.
	}
	kAVGenericInterfaceSignature = 'dmgr';
	kAVAppleVisionInterfaceSignature = 'avav';

	{	 =============================                    	}
	{	 Panel Class Constants                            	}
	{	 =============================                    	}
	kAVPanelClassDisplayDefault	= 'cdsp';
	kAVPanelClassColor			= 'cclr';
	kAVPanelClassGeometry		= 'cgeo';
	kAVPanelClassSound			= 'csnd';
	kAVPanelClassPreferences	= 'cprf';
	kAVPanelClassLCD			= 'clcd';
	kAVPanelClassMonitorSound	= 'cres';
	kAVPanelClassAlert			= 'calr';
	kAVPanelClassExtras			= 'cext';
	kAVPanelClassRearrange		= 'crea';


	{	 =============================                    	}
	{	 AV Notification Types                            	}
	{	 =============================                    	}
	{
	   This notification will be sent whenever a
	   device has been reset, for whatever reason.
	}
	kAVNotifyDeviceReset		= 'rset';


	{	 =============================                    	}
	{	 Component interface revision levels and history  	}
	{	 =============================                    	}
	kAVPanelComponentInterfaceRevOne = 1;
	kAVPanelComponentInterfaceRevTwo = 2;
	kAVEngineComponentInterfaceRevOne = 1;
	kAVPortComponentInterfaceRevOne = 1;
	kAVDeviceComponentInterfaceRevOne = 1;
	kAVUtilityComponentInterfaceRevOne = 1;


	{	 =============================                    	}
	{	 Adornment Constants                              	}
	{	 =============================                    	}
	kAVPanelAdornmentNoBorder	= 0;
	kAVPanelAdornmentStandardBorder = 1;

	kAVPanelAdornmentNoName		= 0;
	kAVPanelAdornmentStandardName = 1;


	{	 =============================                    	}
	{	 Selector Ranges                                  	}
	{	 =============================                    	}
	kBaseAVComponentSelector	= 256;							{  First apple-defined selector for AV components  }
	kAppleAVComponentSelector	= 512;							{  First apple-defined type-specific selector for AV components  }


	{	 =============================                	}
	{	 Panel Standard component selectors           	}
	{	 =============================                	}
	kAVPanelFakeRegisterSelect	= -5;							{  -5  }
	kAVPanelSetCustomDataSelect	= 0;
	kAVPanelGetDitlSelect		= 1;
	kAVPanelGetTitleSelect		= 2;
	kAVPanelInstallSelect		= 3;
	kAVPanelEventSelect			= 4;
	kAVPanelItemSelect			= 5;
	kAVPanelRemoveSelect		= 6;
	kAVPanelValidateInputSelect	= 7;
	kAVPanelGetSettingsIdentifiersSelect = 8;
	kAVPanelGetSettingsSelect	= 9;
	kAVPanelSetSettingsSelect	= 10;
	kAVPanelSelectorGetFidelitySelect = 256;
	kAVPanelSelectorTargetDeviceSelect = 257;
	kAVPanelSelectorGetPanelClassSelect = 258;
	kAVPanelSelectorGetPanelAdornmentSelect = 259;
	kAVPanelSelectorGetBalloonHelpStringSelect = 260;
	kAVPanelSelectorAppleGuideRequestSelect = 261;
	kAVPanelSelectorGetFocusStatusSelect = 262;
	kAVPanelSelectorSetFocusStatusSelect = 263;


	{	 =============================                	}
	{	 Engine Standard component selectors          	}
	{	 =============================                	}
	kAVEngineGetEngineFidelitySelect = 256;
	kAVEngineTargetDeviceSelect	= 257;


	{	 =============================                    	}
	{	 Video Port Specific calls                        	}
	{	 =============================                    	}
	kAVPortCheckTimingModeSelect = 0;
	kAVPortReserved1Select		= 1;							{  Reserved }
	kAVPortReserved2Select		= 2;							{  Reserved }
	kAVPortGetDisplayTimingInfoSelect = 512;
	kAVPortGetDisplayProfileCountSelect = 513;
	kAVPortGetIndexedDisplayProfileSelect = 514;
	kAVPortGetDisplayGestaltSelect = 515;
	kAVPortGetDisplayTimingCountSelect = 516;
	kAVPortGetIndexedDisplayTimingSelect = 517;
	kAVPortGetDisplayTimingRangeCountSelect = 518;
	kAVPortGetIndexedDisplayTimingRangeSelect = 519;


	{	 =============================                    	}
	{	 AV Port Specific calls                           	}
	{	 =============================                    	}
	kAVPortGetAVDeviceFidelitySelect = 256;						{  Port Standard Component selectors  }
	kAVPortGetWiggleSelect		= 257;
	kAVPortSetWiggleSelect		= 258;
	kAVPortGetNameSelect		= 259;
	kAVPortGetGraphicInfoSelect	= 260;
	kAVPortSetActiveSelect		= 261;
	kAVPortGetActiveSelect		= 262;
	kAVPortUnsed1Select			= 263;							{  Selector removed as part of API change.  We don't want to mess up the following selectors, so we put in this spacer (ie kPadSelector).  }
	kAVPortGetAVIDSelect		= 264;
	kAVPortSetAVIDSelect		= 265;
	kAVPortSetDeviceAVIDSelect	= 266;							{  For registrar to set device (instead of hitting global directly) -- should only be called once  }
	kAVPortGetDeviceAVIDSelect	= 267;							{  Called by display mgr for generic ports  }
	kAVPortGetPowerStateSelect	= 268;
	kAVPortSetPowerStateSelect	= 269;
	kAVPortGetMakeAndModelSelect = 270;							{  Get Make and model information }
	kAVPortGetInterfaceSignatureSelect = 271;					{  To determine what VideoPort-specific calls can be made }
	kAVPortReserved3Select		= 272;							{  Reserved }
	kAVPortGetManufactureInfoSelect = 273;						{  Get more Make and model information   }




	{	 =============================                    	}
	{	 Device Component Standard Component selectors    	}
	{	 =============================                    	}
	kAVDeviceGetNameSelect		= 256;
	kAVDeviceGetGraphicInfoSelect = 257;
	kAVDeviceGetPowerStateSelect = 258;
	kAVDeviceSetPowerStateSelect = 259;
	kAVDeviceGetAVIDSelect		= 260;
	kAVDeviceSetAVIDSelect		= 261;

	{	 =============================                    	}
	{	 AV Back-Channel Selectors                        	}
	{	 =============================                    	}
	kAVBackChannelReservedSelector = 1;
	kAVBackChannelPreModalFilterSelect = 2;
	kAVBackChannelModalFilterSelect = 3;
	kAVBackChannelAppleGuideLaunchSelect = 4;







	{	 =============================                	}
	{	 Engine Standard component selectors          	}
	{	 =============================                	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  AVEngineComponentGetFidelity()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION AVEngineComponentGetFidelity(engineComponent: ComponentInstance; displayID: DisplayIDType; VAR engineFidelity: DMFidelityType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0100, $7000, $A82A;
	{$ENDC}

{
 *  AVEngineComponentTargetDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVEngineComponentTargetDevice(engineComponent: ComponentInstance; displayID: DisplayIDType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{ =============================                }
{ Panel Standard Component calls               }
{ =============================                }
{$IFC CALL_NOT_IN_CARBON }
{
 *  AVPanelFakeRegister()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPanelFakeRegister(ci: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $FFFB, $7000, $A82A;
	{$ENDC}

{
 *  AVPanelSetCustomData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPanelSetCustomData(ci: ComponentInstance; theCustomData: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0000, $7000, $A82A;
	{$ENDC}

{
 *  AVPanelGetDitl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPanelGetDitl(ci: ComponentInstance; VAR ditl: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}

{
 *  AVPanelGetTitle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPanelGetTitle(ci: ComponentInstance; title: StringPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0002, $7000, $A82A;
	{$ENDC}

{
 *  AVPanelInstall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPanelInstall(ci: ComponentInstance; dialog: DialogRef; itemOffset: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0003, $7000, $A82A;
	{$ENDC}

{
 *  AVPanelEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPanelEvent(ci: ComponentInstance; dialog: DialogRef; itemOffset: LONGINT; VAR event: EventRecord; VAR itemHit: INTEGER; VAR handled: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0004, $7000, $A82A;
	{$ENDC}

{
 *  AVPanelItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPanelItem(ci: ComponentInstance; dialog: DialogRef; itemOffset: LONGINT; itemNum: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0005, $7000, $A82A;
	{$ENDC}

{
 *  AVPanelRemove()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPanelRemove(ci: ComponentInstance; dialog: DialogRef; itemOffset: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0006, $7000, $A82A;
	{$ENDC}

{
 *  AVPanelValidateInput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPanelValidateInput(ci: ComponentInstance; VAR ok: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}

{
 *  AVPanelGetSettingsIdentifiers()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPanelGetSettingsIdentifiers(ci: ComponentInstance; VAR theID: INTEGER; VAR theType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0008, $7000, $A82A;
	{$ENDC}

{
 *  AVPanelGetSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPanelGetSettings(ci: ComponentInstance; VAR userDataHand: Handle; flags: LONGINT; theDialog: DialogRef; itemsOffset: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0009, $7000, $A82A;
	{$ENDC}

{
 *  AVPanelSetSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPanelSetSettings(ci: ComponentInstance; userDataHand: Handle; flags: LONGINT; theDialog: DialogRef; itemsOffset: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $000A, $7000, $A82A;
	{$ENDC}

{
 *  AVPanelGetFidelity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPanelGetFidelity(panelComponent: ComponentInstance; displayID: DisplayIDType; VAR panelFidelity: DMFidelityType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0100, $7000, $A82A;
	{$ENDC}

{
 *  AVPanelComponentTargetDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPanelComponentTargetDevice(panelComponent: ComponentInstance; displayID: DisplayIDType; theDialog: DialogRef; itemsOffset: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0101, $7000, $A82A;
	{$ENDC}

{
 *  AVPanelComponentGetPanelClass()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPanelComponentGetPanelClass(panelComponent: ComponentInstance; VAR panelClass: ResType; VAR subClass: ResType; reserved1: Ptr; reserved2: Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0102, $7000, $A82A;
	{$ENDC}

{
 *  AVPanelComponentGetPanelAdornment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPanelComponentGetPanelAdornment(panelComponent: ComponentInstance; VAR panelBorderType: LONGINT; VAR panelNameType: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0103, $7000, $A82A;
	{$ENDC}

{
 *  AVPanelComponentGetBalloonHelpString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPanelComponentGetBalloonHelpString(panelComponent: ComponentInstance; item: INTEGER; balloonString: StringPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0104, $7000, $A82A;
	{$ENDC}

{
 *  AVPanelComponentAppleGuideRequest()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPanelComponentAppleGuideRequest(panelComponent: ComponentInstance; agSelector: OSType; agDataReply: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0105, $7000, $A82A;
	{$ENDC}

{
 *  AVPanelComponentGetFocusStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPanelComponentGetFocusStatus(panelComponent: ComponentInstance; VAR hasFocus: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0106, $7000, $A82A;
	{$ENDC}

{
 *  AVPanelComponentSetFocusStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPanelComponentSetFocusStatus(panelComponent: ComponentInstance; theDialog: DialogPtr; itemOffset: LONGINT; gettingFocus: BOOLEAN; VAR tookFocus: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000E, $0107, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{ =============================                }
{ Port Component Standard Component selectors  }
{ =============================                }
{$IFC CALL_NOT_IN_CARBON }
{
 *  AVPortGetAVDeviceFidelity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortGetAVDeviceFidelity(portComponent: ComponentInstance; deviceAVID: AVIDType; VAR portFidelity: DMFidelityType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0100, $7000, $A82A;
	{$ENDC}

{
 *  AVPortGetWiggle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortGetWiggle(portComponent: ComponentInstance; VAR wiggleDevice: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}

{
 *  AVPortSetWiggle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortSetWiggle(portComponent: ComponentInstance; wiggleDevice: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0102, $7000, $A82A;
	{$ENDC}

{
 *  AVPortGetName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortGetName(portComponent: ComponentInstance; VAR portName: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0103, $7000, $A82A;
	{$ENDC}

{
 *  AVPortGetGraphicInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortGetGraphicInfo(portComponent: ComponentInstance; VAR thePict: PicHandle; VAR theIconSuite: Handle; theLocation: AVLocationPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0104, $7000, $A82A;
	{$ENDC}

{
 *  AVPortSetActive()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortSetActive(portComponent: ComponentInstance; setActive: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0105, $7000, $A82A;
	{$ENDC}

{
 *  AVPortGetActive()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortGetActive(portComponent: ComponentInstance; VAR isPortActive: BOOLEAN; VAR portCanBeActivated: BOOLEAN; reserved: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0106, $7000, $A82A;
	{$ENDC}

{
 *  AVPortGetAVID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortGetAVID(portComponent: ComponentInstance; VAR avPortID: AVIDType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0108, $7000, $A82A;
	{$ENDC}

{
 *  AVPortSetAVID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortSetAVID(portComponent: ComponentInstance; avPortID: AVIDType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0109, $7000, $A82A;
	{$ENDC}

{
 *  AVPortSetDeviceAVID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortSetDeviceAVID(portComponent: ComponentInstance; avDeviceID: AVIDType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010A, $7000, $A82A;
	{$ENDC}

{
 *  AVPortGetDeviceAVID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortGetDeviceAVID(portComponent: ComponentInstance; VAR avDeviceID: AVIDType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010B, $7000, $A82A;
	{$ENDC}

{
 *  AVPortGetPowerState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortGetPowerState(portComponent: ComponentInstance; getPowerState: AVPowerStatePtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010C, $7000, $A82A;
	{$ENDC}

{
 *  AVPortSetPowerState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortSetPowerState(portComponent: ComponentInstance; setPowerState: AVPowerStatePtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010D, $7000, $A82A;
	{$ENDC}

{
 *  AVPortGetMakeAndModel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortGetMakeAndModel(portComponent: ComponentInstance; theDisplayID: DisplayIDType; VAR manufacturer: ResType; VAR model: UInt32; VAR serialNumber: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $010E, $7000, $A82A;
	{$ENDC}

{
 *  AVPortGetInterfaceSignature()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortGetInterfaceSignature(portComponent: ComponentInstance; VAR interfaceSignature: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010F, $7000, $A82A;
	{$ENDC}

{
 *  AVPortGetManufactureInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortGetManufactureInfo(portComponent: ComponentInstance; theDisplayID: DisplayIDType; theMakeAndModel: DMMakeAndModelPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0111, $7000, $A82A;
	{$ENDC}


{ =============================                }
{ Video Out Port Component Selectors           }
{ =============================                }
{
 *  AVPortCheckTimingMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortCheckTimingMode(displayComponent: ComponentInstance; theDisplayID: DisplayIDType; connectInfo: VDDisplayConnectInfoPtr; modeTiming: VDTimingInfoPtr; theDetailedTiming: VDDetailedTimingPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0000, $7000, $A82A;
	{$ENDC}

{
 *  AVPortGetDisplayTimingInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortGetDisplayTimingInfo(displayComponent: ComponentInstance; modeTiming: VDTimingInfoPtr; requestedVersion: UInt32; modeInfo: DMDisplayTimingInfoPtr; theDetailedTiming: VDDetailedTimingPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0200, $7000, $A82A;
	{$ENDC}

{
 *  AVPortGetDisplayProfileCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortGetDisplayProfileCount(displayComponent: ComponentInstance; reserved: UInt32; VAR profileCount: UInt32; VAR profileSeed: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0201, $7000, $A82A;
	{$ENDC}

{
 *  AVPortGetIndexedDisplayProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortGetIndexedDisplayProfile(displayComponent: ComponentInstance; reserved: UInt32; profileIndex: UInt32; profileSeed: UInt32; VAR indexedProfile: CMProfileRef): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0202, $7000, $A82A;
	{$ENDC}

{
 *  AVPortGetDisplayGestalt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortGetDisplayGestalt(displayComponent: ComponentInstance; displayGestaltSelector: ResType; VAR displayGestaltResponse: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0203, $7000, $A82A;
	{$ENDC}

{
 *  AVPortGetDisplayTimingCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortGetDisplayTimingCount(displayComponent: ComponentInstance; reserved: UNIV Ptr; VAR timingCount: UInt32; VAR timingsSeed: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0204, $7000, $A82A;
	{$ENDC}

{
 *  AVPortGetIndexedDisplayTiming()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortGetIndexedDisplayTiming(displayComponent: ComponentInstance; reserved: UNIV Ptr; timingIndex: UInt32; timingsSeed: UInt32; indexedTiming: VDDetailedTimingPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0205, $7000, $A82A;
	{$ENDC}

{
 *  AVPortGetDisplayTimingRangeCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortGetDisplayTimingRangeCount(displayComponent: ComponentInstance; reserved: UNIV Ptr; VAR rangeCount: UInt32; VAR rangeSeed: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0206, $7000, $A82A;
	{$ENDC}

{
 *  AVPortGetIndexedDisplayTimingRange()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVPortGetIndexedDisplayTimingRange(displayComponent: ComponentInstance; reserved: UNIV Ptr; rangeIndex: UInt32; rangeSeed: UInt32; indexedRange: VDDisplayTimingRangePtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0207, $7000, $A82A;
	{$ENDC}


{$ENDC}  {CALL_NOT_IN_CARBON}

{ =============================                }
{ AV Device Component Selectors                }
{ =============================                }
{$IFC CALL_NOT_IN_CARBON }
{
 *  AVDeviceGetName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVDeviceGetName(deviceComponent: ComponentInstance; VAR portName: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0100, $7000, $A82A;
	{$ENDC}

{
 *  AVDeviceGetGraphicInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVDeviceGetGraphicInfo(deviceComponent: ComponentInstance; VAR thePict: PicHandle; VAR theIconSuite: Handle; theLocation: AVLocationPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0101, $7000, $A82A;
	{$ENDC}

{
 *  AVDeviceGetPowerState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVDeviceGetPowerState(deviceComponent: ComponentInstance; getPowerState: AVPowerStatePtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0102, $7000, $A82A;
	{$ENDC}

{
 *  AVDeviceSetPowerState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVDeviceSetPowerState(deviceComponent: ComponentInstance; setPowerState: AVPowerStatePtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0103, $7000, $A82A;
	{$ENDC}

{
 *  AVDeviceGetAVID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVDeviceGetAVID(deviceComponent: ComponentInstance; VAR avDeviceID: AVIDType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0104, $7000, $A82A;
	{$ENDC}

{
 *  AVDeviceSetAVID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVDeviceSetAVID(deviceComponent: ComponentInstance; avDeviceID: AVIDType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0105, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{ =============================                }
{ AV BackChannel Component Selectors           }
{ =============================                }
{$IFC CALL_NOT_IN_CARBON }
{
 *  AVBackChannelPreModalFilter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVBackChannelPreModalFilter(compInstance: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0002, $7000, $A82A;
	{$ENDC}

{
 *  AVBackChannelModalFilter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVBackChannelModalFilter(compInstance: ComponentInstance; VAR theEvent: EventRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0003, $7000, $A82A;
	{$ENDC}

{
 *  AVBackChannelAppleGuideLaunch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AVBackChannelAppleGuideLaunch(compInstance: ComponentInstance; theSubject: StringPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0004, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AVComponentsIncludes}

{$ENDC} {__AVCOMPONENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
