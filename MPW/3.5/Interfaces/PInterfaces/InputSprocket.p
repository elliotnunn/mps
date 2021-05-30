{
     File:       InputSprocket.p
 
     Contains:   Games Sprockets: InputSprocket interfaaces
 
     Version:    Technology: InputSprocket 1.7
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1996-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT InputSprocket;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __INPUTSPROCKET__}
{$SETC __INPUTSPROCKET__ := 1}

{$I+}
{$SETC InputSprocketIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __DESKBUS__}
{$I DeskBus.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __ICONS__}
{$I Icons.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{$IFC UNDEFINED USE_OLD_INPUT_SPROCKET_LABELS }
{$SETC USE_OLD_INPUT_SPROCKET_LABELS := 0 }
{$ENDC}

{$IFC UNDEFINED USE_OLD_ISPNEED_STRUCT }
{$SETC USE_OLD_ISPNEED_STRUCT := 0 }
{$ENDC}

{ ********************* data types ********************* }

TYPE
	ISpDeviceReference    = ^LONGINT; { an opaque 32-bit type }
	ISpDeviceReferencePtr = ^ISpDeviceReference;  { when a VAR xx:ISpDeviceReference parameter can be nil, it is changed to xx: ISpDeviceReferencePtr }
	ISpElementReference    = ^LONGINT; { an opaque 32-bit type }
	ISpElementReferencePtr = ^ISpElementReference;  { when a VAR xx:ISpElementReference parameter can be nil, it is changed to xx: ISpElementReferencePtr }
	ISpElementListReference    = ^LONGINT; { an opaque 32-bit type }
	ISpElementListReferencePtr = ^ISpElementListReference;  { when a VAR xx:ISpElementListReference parameter can be nil, it is changed to xx: ISpElementListReferencePtr }
	{	 ISpDeviceClass is a general classs of device, example: keyboard, mouse, joystick 	}
	ISpDeviceClass						= OSType;
	{	 ISpDeviceIdentifier is a specific device,  example: standard 1-button mouse, 105key ext. kbd. 	}
	ISpDeviceIdentifier					= OSType;
	ISpElementLabel						= OSType;
	ISpElementKind						= OSType;


	{	 *************** resources **************** 	}

CONST
	kISpApplicationResourceType	= 'isap';
	kISpSetListResourceType		= 'setl';
	kISpSetDataResourceType		= 'setd';


TYPE
	ISpApplicationResourceStructPtr = ^ISpApplicationResourceStruct;
	ISpApplicationResourceStruct = RECORD
		flags:					UInt32;
		reserved1:				UInt32;
		reserved2:				UInt32;
		reserved3:				UInt32;
	END;


CONST
	kISpAppResFlag_UsesInputSprocket = $00000001;				{  true if the application uses InputSprocket }
	kISpAppResFlag_UsesISpInit	= $00000002;					{  true if the calls ISpInit (ie, uses the high level interface, calls ISpConfigure, has a needs list, etc...) }

	{	
	 * ISpDeviceDefinition
	 *
	 * This structure provides all the available
	 * information for an input device within the system
	 *
	 	}

TYPE
	ISpDeviceDefinitionPtr = ^ISpDeviceDefinition;
	ISpDeviceDefinition = RECORD
		deviceName:				Str63;									{  a human readable name of the device  }
		theDeviceClass:			ISpDeviceClass;							{  general classs of device example : keyboard, mouse, joystick  }
		theDeviceIdentifier:	ISpDeviceIdentifier;					{  every distinguishable device should have an OSType  }
		permanentID:			UInt32;									{  a cross reboot id unique within that deviceType, 0 if not possible  }
		flags:					UInt32;									{  status flags  }
		permanentIDExtend:		UInt32;									{  extension of permanentID, so 64 bits total are now significant  }
		reserved2:				UInt32;
		reserved3:				UInt32;
	END;


CONST
	kISpDeviceFlag_HandleOwnEmulation = 1;

	{	
	 * ISpElementEvent, ISpElementEventPtr
	 *
	 * This is the structure that event data is passed in.
	 *
	 	}

TYPE
	ISpElementEventPtr = ^ISpElementEvent;
	ISpElementEvent = RECORD
		when:					AbsoluteTime;							{  this is absolute time on PCI or later, otherwise it is  }
																		{  0 for the hi 32 bits and TickCount for the low 32 bits  }
		element:				ISpElementReference;					{  a reference to the element that generated this event  }
		refCon:					UInt32;									{  for application usage, 0 on the global list  }
		data:					UInt32;									{  the data for this event  }
	END;

	{	
	 * ISpElementInfo, ISpElementInfoPtr
	 *
	 * This is the generic definition of an element.
	 * Every element must contain this information.
	 *
	 	}
	ISpElementInfoPtr = ^ISpElementInfo;
	ISpElementInfo = RECORD
		theLabel:				ISpElementLabel;
		theKind:				ISpElementKind;
		theString:				Str63;
		reserved1:				UInt32;
		reserved2:				UInt32;
	END;

	ISpNeedFlagBits						= UInt32;
{$IFC USE_OLD_ISPNEED_STRUCT }
	ISpNeedPtr = ^ISpNeed;
	ISpNeed = RECORD
		name:					Str63;
		iconSuiteResourceId:	INTEGER;								{  resource id of the icon suite  }
		reserved:				INTEGER;
		theKind:				ISpElementKind;
		theLabel:				ISpElementLabel;
		flags:					ISpNeedFlagBits;
		reserved1:				UInt32;
		reserved2:				UInt32;
		reserved3:				UInt32;
	END;

{$ELSEC}
	ISpNeed = RECORD
		name:					Str63;									{  human-readable string  }
		iconSuiteResourceId:	INTEGER;								{  resource id of the icon suite  }
		playerNum:				SInt8;									{  used for multi-player support  }
		group:					SInt8;									{  used to group related needs (eg, look left and look right button needs)  }
		theKind:				ISpElementKind;
		theLabel:				ISpElementLabel;
		flags:					ISpNeedFlagBits;
		reserved1:				UInt32;
		reserved2:				UInt32;
		reserved3:				UInt32;
	END;

{$ENDC}  {USE_OLD_ISPNEED_STRUCT}


CONST
	kISpNeedFlag_NoMultiConfig	= $00000001;					{  once this need is autoconfigured to one device dont autoconfigure to anything else }
	kISpNeedFlag_Utility		= $00000002;					{  this need is a utility function (like show framerate) which would not typically be assigned to anything but the keyboard }
	kISpNeedFlag_PolledOnly		= $00000004;
	kISpNeedFlag_EventsOnly		= $00000008;
	kISpNeedFlag_NoAutoConfig	= $00000010;					{  this need can be set normally, but will not ever be auto configured }
	kISpNeedFlag_NoConfig		= $00000020;					{  this need can not be changed by the user }
	kISpNeedFlag_Invisible		= $00000040;					{  this need can not be seen by the user }
																{  *** kISpElementKind specific flags *** }
																{  these are flags specific to kISpElementKind_Button }
	kISpNeedFlag_Button_AlreadyAxis = $10000000;				{  there is a axis version of this button need }
	kISpNeedFlag_Button_ClickToggles = $20000000;
	kISpNeedFlag_Button_ActiveWhenDown = $40000000;
	kISpNeedFlag_Button_AlreadyDelta = $80000000;				{  there is a delta version of this button need }
																{  these are flags specific to kISpElementKind_DPad }
																{  these are flags specific to kISpElementKind_Axis }
	kISpNeedFlag_Axis_AlreadyButton = $10000000;				{  there is a button version of this axis need }
	kISpNeedFlag_Axis_Asymetric	= $20000000;					{  this axis need is asymetric     }
	kISpNeedFlag_Axis_AlreadyDelta = $40000000;					{  there is a delta version of this axis need }
																{  these are flags specific to kISpElementKind_Delta }
	kISpNeedFlag_Delta_AlreadyAxis = $10000000;					{  there is a axis version of this delta need }
	kISpNeedFlag_Delta_AlreadyButton = $20000000;				{  there is a button version of this delta need }

	{	
	 *
	 * These are the current built values for ISpDeviceClass
	 *
	 	}
	kISpDeviceClass_SpeechRecognition = 'talk';
	kISpDeviceClass_Mouse		= 'mous';
	kISpDeviceClass_Keyboard	= 'keyd';
	kISpDeviceClass_Joystick	= 'joys';
	kISpDeviceClass_Gamepad		= 'gmpd';
	kISpDeviceClass_Wheel		= 'whel';
	kISpDeviceClass_Pedals		= 'pedl';
	kISpDeviceClass_Levers		= 'levr';
	kISpDeviceClass_Tickle		= 'tckl';						{  a device of this class requires ISpTickle }
	kISpDeviceClass_Unknown		= '????';

	{	
	 * These are the current built in ISpElementKind's
	 * 
	 * These are all OSTypes.
	 *
	 	}
	kISpElementKind_Button		= 'butn';
	kISpElementKind_DPad		= 'dpad';
	kISpElementKind_Axis		= 'axis';
	kISpElementKind_Delta		= 'dlta';
	kISpElementKind_Movement	= 'move';
	kISpElementKind_Virtual		= 'virt';


	{	
	 *
	 * These are the current built in ISpElementLabel's
	 *
	 * These are all OSTypes.
	 *
	 	}
{$IFC USE_OLD_INPUT_SPROCKET_LABELS }
																{  axis  }
	kISpElementLabel_XAxis		= 'xaxi';
	kISpElementLabel_YAxis		= 'yaxi';
	kISpElementLabel_ZAxis		= 'zaxi';
	kISpElementLabel_Rx			= 'rxax';
	kISpElementLabel_Ry			= 'ryax';
	kISpElementLabel_Rz			= 'rzax';
	kISpElementLabel_Gas		= 'gasp';
	kISpElementLabel_Brake		= 'brak';
	kISpElementLabel_Clutch		= 'cltc';
	kISpElementLabel_Throttle	= 'thrt';
	kISpElementLabel_Trim		= 'trim';						{  direction pad  }
	kISpElementLabel_POVHat		= 'povh';
	kISpElementLabel_PadMove	= 'move';						{  buttons  }
	kISpElementLabel_Fire		= 'fire';
	kISpElementLabel_Start		= 'strt';
	kISpElementLabel_Select		= 'optn';						{  Pause/Resume was changed into 2 needs: Quit and start/pause  }
	kISpElementLabel_Btn_PauseResume = 'strt';

{$ENDC}  {USE_OLD_INPUT_SPROCKET_LABELS}

																{  generic  }
	kISpElementLabel_None		= 'none';						{  axis  }
	kISpElementLabel_Axis_XAxis	= 'xaxi';
	kISpElementLabel_Axis_YAxis	= 'yaxi';
	kISpElementLabel_Axis_ZAxis	= 'zaxi';
	kISpElementLabel_Axis_Rx	= 'rxax';
	kISpElementLabel_Axis_Ry	= 'ryax';
	kISpElementLabel_Axis_Rz	= 'rzax';
	kISpElementLabel_Axis_Roll	= 'rzax';
	kISpElementLabel_Axis_Pitch	= 'rxax';
	kISpElementLabel_Axis_Yaw	= 'ryax';
	kISpElementLabel_Axis_RollTrim = 'rxtm';
	kISpElementLabel_Axis_PitchTrim = 'trim';
	kISpElementLabel_Axis_YawTrim = 'rytm';
	kISpElementLabel_Axis_Gas	= 'gasp';
	kISpElementLabel_Axis_Brake	= 'brak';
	kISpElementLabel_Axis_Clutch = 'cltc';
	kISpElementLabel_Axis_Throttle = 'thrt';
	kISpElementLabel_Axis_Trim	= 'trim';
	kISpElementLabel_Axis_Rudder = 'rudd';
	kISpElementLabel_Axis_ToeBrake = 'toeb';					{  delta  }
	kISpElementLabel_Delta_X	= 'xdlt';
	kISpElementLabel_Delta_Y	= 'ydlt';
	kISpElementLabel_Delta_Z	= 'zdlt';
	kISpElementLabel_Delta_Rx	= 'rxdl';
	kISpElementLabel_Delta_Ry	= 'rydl';
	kISpElementLabel_Delta_Rz	= 'rzdl';
	kISpElementLabel_Delta_Roll	= 'rzdl';
	kISpElementLabel_Delta_Pitch = 'rxdl';
	kISpElementLabel_Delta_Yaw	= 'rydl';
	kISpElementLabel_Delta_Cursor_X = 'curx';
	kISpElementLabel_Delta_Cursor_Y = 'cury';					{  direction pad  }
	kISpElementLabel_Pad_POV	= 'povh';						{  up/down/left/right }
	kISpElementLabel_Pad_Move	= 'move';						{  up/down/left/right }
	kISpElementLabel_Pad_POV_Horiz = 'hpov';					{  forward/back/left/right }
	kISpElementLabel_Pad_Move_Horiz = 'hmov';					{  forward/back/left/right }
																{  buttons  }
	kISpElementLabel_Btn_Fire	= 'fire';
	kISpElementLabel_Btn_SecondaryFire = 'sfir';
	kISpElementLabel_Btn_Jump	= 'jump';
	kISpElementLabel_Btn_Quit	= 'strt';						{  kISpElementLabel_Btn_Quit automatically binds to escape  }
	kISpElementLabel_Btn_StartPause = 'paus';
	kISpElementLabel_Btn_Select	= 'optn';
	kISpElementLabel_Btn_SlideLeft = 'blft';
	kISpElementLabel_Btn_SlideRight = 'brgt';
	kISpElementLabel_Btn_MoveForward = 'btmf';
	kISpElementLabel_Btn_MoveBackward = 'btmb';
	kISpElementLabel_Btn_TurnLeft = 'bttl';
	kISpElementLabel_Btn_TurnRight = 'bttr';
	kISpElementLabel_Btn_LookLeft = 'btll';
	kISpElementLabel_Btn_LookRight = 'btlr';
	kISpElementLabel_Btn_LookUp	= 'btlu';
	kISpElementLabel_Btn_LookDown = 'btld';
	kISpElementLabel_Btn_Next	= 'btnx';
	kISpElementLabel_Btn_Previous = 'btpv';
	kISpElementLabel_Btn_SideStep = 'side';
	kISpElementLabel_Btn_Run	= 'quik';
	kISpElementLabel_Btn_Look	= 'blok';
	kISpElementLabel_Btn_Minimum = 'min ';
	kISpElementLabel_Btn_Decrement = 'decr';
	kISpElementLabel_Btn_Center	= 'cent';
	kISpElementLabel_Btn_Increment = 'incr';
	kISpElementLabel_Btn_Maximum = 'max ';
	kISpElementLabel_Btn_10Percent = ' 10 ';
	kISpElementLabel_Btn_20Percent = ' 20 ';
	kISpElementLabel_Btn_30Percent = ' 30 ';
	kISpElementLabel_Btn_40Percent = ' 40 ';
	kISpElementLabel_Btn_50Percent = ' 50 ';
	kISpElementLabel_Btn_60Percent = ' 60 ';
	kISpElementLabel_Btn_70Percent = ' 70 ';
	kISpElementLabel_Btn_80Percent = ' 80 ';
	kISpElementLabel_Btn_90Percent = ' 90 ';
	kISpElementLabel_Btn_MouseOne = 'mou1';
	kISpElementLabel_Btn_MouseTwo = 'mou2';
	kISpElementLabel_Btn_MouseThree = 'mou3';

	{	
	 *
	 * direction pad data & configuration information
	 *
	 	}

TYPE
	ISpDPadData 				= UInt32;
CONST
	kISpPadIdle					= 0;
	kISpPadLeft					= 1;
	kISpPadUpLeft				= 2;
	kISpPadUp					= 3;
	kISpPadUpRight				= 4;
	kISpPadRight				= 5;
	kISpPadDownRight			= 6;
	kISpPadDown					= 7;
	kISpPadDownLeft				= 8;


TYPE
	ISpDPadConfigurationInfoPtr = ^ISpDPadConfigurationInfo;
	ISpDPadConfigurationInfo = RECORD
		id:						UInt32;									{  ordering 1..n, 0 = no relavent ordering of direction pads  }
		fourWayPad:				BOOLEAN;								{  true if this pad can only produce idle + four directions  }
	END;

	{	
	 *
	 * button data & configuration information
	 *
	 	}
	ISpButtonData 				= UInt32;
CONST
	kISpButtonUp				= 0;
	kISpButtonDown				= 1;


TYPE
	ISpButtonConfigurationInfoPtr = ^ISpButtonConfigurationInfo;
	ISpButtonConfigurationInfo = RECORD
		id:						UInt32;									{  ordering 1..n, 0 = no relavent ordering of buttons  }
	END;

	{	
	 *
	 * axis data & configuration information 
	 *
	 	}
	ISpAxisData							= UInt32;
	ISpAxisConfigurationInfoPtr = ^ISpAxisConfigurationInfo;
	ISpAxisConfigurationInfo = RECORD
		symetricAxis:			BOOLEAN;								{  axis is symetric, i.e. a joystick is symetric and a gas pedal is not  }
	END;

	ISpDeltaData						= Fixed;
	ISpDeltaConfigurationInfoPtr = ^ISpDeltaConfigurationInfo;
	ISpDeltaConfigurationInfo = RECORD
		reserved1:				UInt32;
		reserved2:				UInt32;
	END;

	ISpMovementDataPtr = ^ISpMovementData;
	ISpMovementData = RECORD
		xAxis:					ISpAxisData;
		yAxis:					ISpAxisData;
		direction:				ISpDPadData;							{  ISpDPadData version of the movement  }
	END;

	ISpMovementConfigurationInfoPtr = ^ISpMovementConfigurationInfo;
	ISpMovementConfigurationInfo = RECORD
		reserved1:				UInt32;
		reserved2:				UInt32;
	END;


CONST
	kISpVirtualElementFlag_UseTempMem = 1;

	kISpElementListFlag_UseTempMem = 1;

	kISpFirstIconSuite			= 30000;
	kISpLastIconSuite			= 30100;
	kISpNoneIconSuite			= 30000;



	{	 ********************* user level functions ********************* 	}

	{	
	 *
	 * startup / shutdown
	 *
	 	}
	{
	 *  ISpStartup()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InputSprocketLib 1.1 and later
	 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
	 *    Mac OS X:         not available
	 	}
FUNCTION ISpStartup: OSStatus; C;

{  1.1 or later }
{
 *  ISpShutdown()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.1 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpShutdown: OSStatus; C;

{  1.1 or later }
{
 *
 * polling
 *
 }
{
 *  ISpTickle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.1 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpTickle: OSStatus; C;

{  1.1 or later }
{********* user interface functions *********}

{
 *  ISpGetVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpGetVersion: NumVersion; C;

{
 *
 * ISpElement_NewVirtual(ISpElementReference *outElement);
 *
 }
{
 *  ISpElement_NewVirtual()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElement_NewVirtual(dataSize: UInt32; VAR outElement: ISpElementReference; flags: UInt32): OSStatus; C;

{
 *
 * ISpElement_NewVirtualFromNeeds(UInt32 count, ISpNeeds *needs, ISpElementReference *outElements);
 *
 }
{
 *  ISpElement_NewVirtualFromNeeds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElement_NewVirtualFromNeeds(count: UInt32; VAR needs: ISpNeed; VAR outElements: ISpElementReference; flags: UInt32): OSStatus; C;

{
 *
 * ISpElement_DisposeVirtual(inElement);
 *
 }
{
 *  ISpElement_DisposeVirtual()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElement_DisposeVirtual(count: UInt32; VAR inElements: ISpElementReference): OSStatus; C;

{
 * ISpInit
 *
 }
{
 *  ISpInit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpInit(count: UInt32; VAR needs: ISpNeed; VAR inReferences: ISpElementReference; appCreatorCode: OSType; subCreatorCode: OSType; flags: UInt32; setListResourceId: INTEGER; reserved: UInt32): OSStatus; C;


{
 * ISpConfigure
 *
 }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ISpEventProcPtr = FUNCTION(VAR inEvent: EventRecord): BOOLEAN; C;
{$ELSEC}
	ISpEventProcPtr = ProcPtr;
{$ENDC}

	{
	 *  ISpConfigure()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
	 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
	 *    Mac OS X:         not available
	 	}
FUNCTION ISpConfigure(inEventProcPtr: ISpEventProcPtr): OSStatus; C;

{
 *
 * ISpStop
 *
 }
{
 *  ISpStop()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpStop: OSStatus; C;

{
 *
 * ISpSuspend, ISpResume
 *
 * ISpSuspend turns all devices off and allocates memory so that the state may be later resumed.
 * ISpResume resumes to the previous state of the system after a suspend call.
 * 
 * Return Codes
 * memFullErr
 *
 }
{
 *  ISpSuspend()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpSuspend: OSStatus; C;

{
 *  ISpResume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpResume: OSStatus; C;

{
 * ISpDevices_Extract, ISpDevices_ExtractByClass, ISpDevices_ExtractByIdentifier
 *
 * These will extract as many device references from the system wide list as will fit in your buffer.  
 *
 * inBufferCount - the size of your buffer (in units of sizeof(ISpDeviceReference)) this may be zero
 * buffer - a pointer to your buffer
 * outCount - contains the number of devices in the system
 *
 * ISpDevices_ExtractByClass extracts and counts devices of the specified ISpDeviceClass
 * ISpDevices_ExtractByIdentifier extracts and counts devices of the specified ISpDeviceIdentifier
 *
 * Return Codes
 * paramErr
 *
 }
{
 *  ISpDevices_Extract()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpDevices_Extract(inBufferCount: UInt32; VAR outCount: UInt32; VAR buffer: ISpDeviceReference): OSStatus; C;

{
 *  ISpDevices_ExtractByClass()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpDevices_ExtractByClass(inClass: ISpDeviceClass; inBufferCount: UInt32; VAR outCount: UInt32; VAR buffer: ISpDeviceReference): OSStatus; C;

{
 *  ISpDevices_ExtractByIdentifier()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpDevices_ExtractByIdentifier(inIdentifier: ISpDeviceIdentifier; inBufferCount: UInt32; VAR outCount: UInt32; VAR buffer: ISpDeviceReference): OSStatus; C;


{
 * ISpDevices_ActivateClass, ISpDevices_DeactivateClass, ISpDevices_Activate, ISpDevices_Deactivate, ISpDevice_IsActive
 *
 * ISpDevices_Activate, ISpDevices_Deactivate
 *
 * This will activate/deactivate a block of devices.
 * inDeviceCount - the number of devices to activate / deactivate
 * inDevicesToActivate/inDevicesToDeactivate - a pointer to a block of memory contains the devices references
 *
 * ISpDevices_ActivateClass, ISpDevices_DeactivateClass
 * inClass - the class of devices to activate or deactivate
 *
 * ISpDevice_IsActive
 * inDevice - the device reference that you wish to 
 * outIsActive - a boolean value that is true when the device is active
 *
 * Return Codes
 * paramErr
 *
 }
{
 *  ISpDevices_ActivateClass()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.1 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpDevices_ActivateClass(inClass: ISpDeviceClass): OSStatus; C;

{  1.1 or later }
{
 *  ISpDevices_DeactivateClass()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.1 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpDevices_DeactivateClass(inClass: ISpDeviceClass): OSStatus; C;

{  1.1 or later }
{
 *  ISpDevices_Activate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpDevices_Activate(inDeviceCount: UInt32; VAR inDevicesToActivate: ISpDeviceReference): OSStatus; C;

{
 *  ISpDevices_Deactivate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpDevices_Deactivate(inDeviceCount: UInt32; VAR inDevicesToDeactivate: ISpDeviceReference): OSStatus; C;

{
 *  ISpDevice_IsActive()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpDevice_IsActive(inDevice: ISpDeviceReference; VAR outIsActive: BOOLEAN): OSStatus; C;

{
 * ISpDevice_GetDefinition
 *
 *
 * inDevice - the device you want to get the definition for
 * inBuflen - the size of the structure (sizeof(ISpDeviceDefinition))
 * outStruct - a pointer to where you want the structure copied
 *
 * Return Codes
 * paramErr
 *
 }
{
 *  ISpDevice_GetDefinition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpDevice_GetDefinition(inDevice: ISpDeviceReference; inBuflen: UInt32; VAR outStruct: ISpDeviceDefinition): OSStatus; C;


{
 *
 * ISpDevice_GetElementList
 *
 * inDevice - the device whose element list you wish to get
 * outElementList - a pointer to where you want a reference to that list stored
 *
 * Return Codes
 * paramErr
 *
 }
{
 *  ISpDevice_GetElementList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpDevice_GetElementList(inDevice: ISpDeviceReference; VAR outElementList: ISpElementListReference): OSStatus; C;

{
 *
 * takes an ISpElementReference and returns the group that it is in or 0 if there is
 * no group
 *
 * Return Codes
 * paramErr
 *
 }
{
 *  ISpElement_GetGroup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElement_GetGroup(inElement: ISpElementReference; VAR outGroup: UInt32): OSStatus; C;

{
 *
 * takes an ISpElementReference and returns the device that the element belongs 
 * to.
 *
 * Return Codes
 * paramErr if inElement is 0 or outDevice is nil
 *
 }
{
 *  ISpElement_GetDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElement_GetDevice(inElement: ISpElementReference; VAR outDevice: ISpDeviceReference): OSStatus; C;

{
 *
 * takes an ISpElementReference and gives the ISpElementInfo for that Element.  This is the
 * the set of standard information.  You get ISpElementKind specific information
 * through ISpElement_GetConfigurationInfo.
 *
 * Return Codes
 * paramErr if inElement is 0 or outInfo is nil
 *
 }
{
 *  ISpElement_GetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElement_GetInfo(inElement: ISpElementReference; outInfo: ISpElementInfoPtr): OSStatus; C;

{
 *
 *      
 *
 * takes an ISpElementReference and gives the ISpElementKind specific configuration information
 * 
 * if buflen is not long enough to hold the information ISpElement_GetConfigurationInfo will
 * copy buflen bytes of the data into the block of memory pointed to by configInfo and
 * will return something error.
 *
 * Return Codes
 * paramErr if inElement or configInfo is nil
 *
 }
{
 *  ISpElement_GetConfigurationInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElement_GetConfigurationInfo(inElement: ISpElementReference; buflen: UInt32; configInfo: UNIV Ptr): OSStatus; C;

{
 *
 * ISpElement_GetSimpleState
 *
 * Takes an ISpElementReference and returns the current state of that element.  This is a 
 * specialized version of ISpElement_GetComplexState that is only appropriate for elements
 * whose data fits in a signed 32 bit integer.
 *
 *
 *
 * Return Codes
 * paramErr if inElement is 0 or state is nil
 *
 }
{
 *  ISpElement_GetSimpleState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElement_GetSimpleState(inElement: ISpElementReference; VAR state: UInt32): OSStatus; C;

{
 *
 * ISpElement_GetComplexState
 *
 * Takes an ISpElementReference and returns the current state of that element.  
 * Will copy up to buflen bytes of the current state of the device into
 * state.
 *
 *
 * Return Codes
 * paramErr if inElement is 0 or state is nil
 *
 }
{
 *  ISpElement_GetComplexState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElement_GetComplexState(inElement: ISpElementReference; buflen: UInt32; state: UNIV Ptr): OSStatus; C;


{
 * ISpElement_GetNextEvent
 *
 * It takes in an element  reference and the buffer size of the ISpElementEventPtr
 * it will set wasEvent to true if there was an event and false otherwise.  If there
 * was not enough space to fill in the whole event structure that event will be
 * dequed, as much of the event as will fit in the buffer will by copied and
 * ISpElement_GetNextEvent will return an error.
 *
 * Return Codes
 * paramErr
 *
 }
{
 *  ISpElement_GetNextEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElement_GetNextEvent(inElement: ISpElementReference; bufSize: UInt32; event: ISpElementEventPtr; VAR wasEvent: BOOLEAN): OSStatus; C;

{
 *
 * ISpElement_Flush
 *
 * It takes an ISpElementReference and flushes all the events on that element.  All it guaruntees is
 * that any events that made it to this layer before the time of the flush call will be flushed and
 * it will not flush any events that make it to this layer after the time when the call has returned.
 * What happens to events that occur during the flush is undefined.
 *
 *
 * Return Codes
 * paramErr
 *
 }
{
 *  ISpElement_Flush()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElement_Flush(inElement: ISpElementReference): OSStatus; C;


{
 * ISpElementList_New
 *
 * Creates a new element list and returns it in outElementList.  In count specifies 
 * the number of element references in the list pointed to by inElements.  If inCount
 * is non zero the list is created with inCount elements in at as specified by the 
 * inElements parameter.  Otherwise the list is created empty.
 *
 *
 * Return Codes
 * out of memory - If it failed to allocate the list because it was out of memory
                   it will also set outElementList to 0
 * paramErr if outElementList was nil
 *
 *
 * Special Concerns
 *
 * interrupt unsafe
 *
 }
{
 *  ISpElementList_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElementList_New(inCount: UInt32; VAR inElements: ISpElementReference; VAR outElementList: ISpElementListReference; flags: UInt32): OSStatus; C;

{
 * ISpElementList_Dispose
 *
 * Deletes an already existing memory list.  
 *
 *
 * Return Codes
 * paramErr if inElementList was 0
 *
 *
 * Special Concerns
 *
 * interrupt unsafe
 *
 }
{
 *  ISpElementList_Dispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElementList_Dispose(inElementList: ISpElementListReference): OSStatus; C;

{
 * ISpGetGlobalElementList
 *
 * returns the global element list
 *
 * Return Codes
 * paramErr if outElementList is nil
 *
 }
{
 *  ISpGetGlobalElementList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpGetGlobalElementList(VAR outElementList: ISpElementListReference): OSStatus; C;

{
 * ISpElementList_AddElement
 *
 * adds an element to the element list
 *
 * Return Codes
 * paramErr if inElementList is 0 or newElement is 0
 * memory error if the system is unable to allocate enough memory
 *
 * Special Concerns
 * interrupt Unsafe
 * 
 }
{
 *  ISpElementList_AddElements()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElementList_AddElements(inElementList: ISpElementListReference; refCon: UInt32; count: UInt32; VAR newElements: ISpElementReference): OSStatus; C;

{
 * ISpElementList_RemoveElement
 *
 * removes the specified element from the element list
 *
 * Return Codes
 * paramErr if inElementList is 0 or oldElement is 0
 * memory error if the system is unable to allocate enough memory
 *
 * Special Concerns
 * interrupt Unsafe
 * 
 }
{
 *  ISpElementList_RemoveElements()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElementList_RemoveElements(inElementList: ISpElementListReference; count: UInt32; VAR oldElement: ISpElementReference): OSStatus; C;

{
 * ISpElementList_Extract
 *
 * ISpElementList_Extract will extract as many of the elements from an element list as possible.  You pass
 * in an element list, a pointer to an array of element references and the number of elements in that array.
 * It will return how many items are in the element list in the outCount parameter and copy the minimum of 
 * that number and the size of the array into the buffer.
 *
 * ByKind and ByLabel are the same except that they will only count and copy element references to elements
 * that have the specified kind and label.
 *
 * Return Codes
 * paramErr
 *
 }
{
 *  ISpElementList_Extract()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElementList_Extract(inElementList: ISpElementListReference; inBufferCount: UInt32; VAR outCount: UInt32; VAR buffer: ISpElementReference): OSStatus; C;

{
 *  ISpElementList_ExtractByKind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElementList_ExtractByKind(inElementList: ISpElementListReference; inKind: ISpElementKind; inBufferCount: UInt32; VAR outCount: UInt32; VAR buffer: ISpElementReference): OSStatus; C;

{
 *  ISpElementList_ExtractByLabel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElementList_ExtractByLabel(inElementList: ISpElementListReference; inLabel: ISpElementLabel; inBufferCount: UInt32; VAR outCount: UInt32; VAR buffer: ISpElementReference): OSStatus; C;

{
 * ISpElementList_GetNextEvent
 *
 * It takes in an element list reference and the buffer size of the ISpElementEventPtr
 * it will set wasEvent to true if there was an event and false otherwise.  If there
 * was not enough space to fill in the whole event structure that event will be
 * dequed, as much of the event as will fit in the buffer will by copied and
 * ISpElementList_GetNextEvent will return an error.
 *
 * Return Codes
 * paramErr
 *
 }
{
 *  ISpElementList_GetNextEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElementList_GetNextEvent(inElementList: ISpElementListReference; bufSize: UInt32; event: ISpElementEventPtr; VAR wasEvent: BOOLEAN): OSStatus; C;

{
 *
 * ISpElementList_Flush
 *
 * It takes an ISpElementListReference and flushes all the events on that list.  All it guaruntees is
 * that any events that made it to this layer before the time of the flush call will be flushed and
 * it will not flush any events that make it to this layer after the time when the call has returned.
 * What happens to events that occur during the flush is undefined.
 *
 *
 * Return Codes
 * paramErr
 *
 }
{
 *  ISpElementList_Flush()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElementList_Flush(inElementList: ISpElementListReference): OSStatus; C;

{
 *
 * ISpTimeToMicroseconds
 *
 *
 * This function takes time from an input sprocket event and converts it
 * into microseconds. (Version 1.2 or later of InputSprocket.)
 *
 *
 * Return Codes
 * paramErr
 *
 }
{
 *  ISpTimeToMicroseconds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.2 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpTimeToMicroseconds({CONST}VAR inTime: AbsoluteTime; VAR outMicroseconds: UnsignedWide): OSStatus; C;

{
 *
 * ISpUptime
 *
 *
 * This funtion returns the current machine dependant time, identical in form
 * to that in an InputSprocket event. (Version 1.1 or later of InputSprocket).
 *
 *
 }
{
 *  ISpUptime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.1 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpUptime: AbsoluteTime; C;


{**************************************************************************}
{  Interfaces for InputSprocket Drivers                                    }
{                                                                          }
{  These APIs should be called only from InputSprocket drivers             }
{                                                                          }
{  (Moved from InputSprocketDriver.h, which is now obsolete.               }
{**************************************************************************}

{

Resource File Concerns

1. All resource ids of a driver should be in the range of 256 to 2048
and the res file should only be open while the drivers panel is visable.

}

CONST
	kOSType_ISpDriverFileType	= 'shlb';
	kOSType_ISpDriverCreator	= 'insp';

	{	
	 *
	 * this function will plot an icon suite of the application (usually for a need)
	 *
	 	}
	{
	 *  ISpPlotAppIconSuite()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
	 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
	 *    Mac OS X:         not available
	 	}
FUNCTION ISpPlotAppIconSuite({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; iconSuiteResourceId: INTEGER): OSErr; C;

{  label2,5,6,7, disabled and offline are reserved }


CONST
	kISpIconTransform_Selected	= $4000;						{  choose one of these (optionally) (these all erase what is behind them to the dialog color) }
	kISpIconTransform_PlotIcon	= $0100;
	kISpIconTransform_PlotPopupButton = $0300;
	kISpIconTransform_PlotButton = $0400;						{  use this is you want to plot the icon while the devices button is pressed }
																{  or the devices axis is activated and so on }
	kISpIconTransform_DeviceActive = $03;


TYPE
	ISpMetaHandlerSelector 		= UInt32;
CONST
	kISpSelector_Init			= 1;
	kISpSelector_Stop			= 2;
	kISpSelector_GetSize		= 3;
	kISpSelector_HandleEvent	= 4;
	kISpSelector_Show			= 5;
	kISpSelector_Hide			= 6;
	kISpSelector_BeginConfiguration = 7;
	kISpSelector_EndConfiguration = 8;
	kISpSelector_GetIcon		= 9;
	kISpSelector_GetState		= 10;
	kISpSelector_SetState		= 11;
	kISpSelector_Dirty			= 12;
	kISpSelector_SetActive		= 13;
	kISpSelector_DialogItemHit	= 14;
	kISpSelector_Tickle			= 15;							{  1.03 and later }
	kISpSelector_InterruptTickle = 16;
	kISpSelector_Draw			= 17;
	kISpSelector_Click			= 18;
	kISpSelector_ADBReInit		= 19;							{  1.2 and later }
	kISpSelector_GetCalibration	= 20;							{  1.7 and later }
	kISpSelector_SetCalibration	= 21;
	kISpSelector_CalibrateDialog = 22;


	{	
	 *
	 * typedefs for the function pointers the metahandler may return 
	 *
	 	}
	{	 a generic driver function pointer 	}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_Generic = FUNCTION(refCon: UInt32; ...): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_Generic = ProcPtr;
{$ENDC}

	{	 the meta handler pointer 	}
{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_MetaHandler = FUNCTION(refCon: UInt32; metaHandlerSelector: ISpMetaHandlerSelector): ISpDriverFunctionPtr_Generic; C;
{$ELSEC}
	ISpDriverFunctionPtr_MetaHandler = ProcPtr;
{$ENDC}

	{	 the pointers you get through the meta handler 	}
{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_Init = FUNCTION(refCon: UInt32; count: UInt32; VAR needs: ISpNeed; VAR virtualElements: ISpElementReference; VAR used: BOOLEAN; appCreatorCode: OSType; subCreatorCode: OSType; reserved: UInt32; reserved2: UNIV Ptr): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_Init = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_Stop = FUNCTION(refCon: UInt32): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_Stop = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_GetSize = FUNCTION(refCon: UInt32; VAR minimum: Point; VAR best: Point): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_GetSize = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_HandleEvent = FUNCTION(refCon: UInt32; VAR theEvent: EventRecord; VAR handled: BOOLEAN): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_HandleEvent = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_Show = FUNCTION(refCon: UInt32; theDialog: DialogRef; dialogItemNumber: INTEGER; VAR r: Rect): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_Show = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_Hide = FUNCTION(refCon: UInt32): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_Hide = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_BeginConfiguration = FUNCTION(refCon: UInt32; count: UInt32; VAR needs: ISpNeed): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_BeginConfiguration = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_EndConfiguration = FUNCTION(refCon: UInt32; accept: BOOLEAN): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_EndConfiguration = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_GetIcon = FUNCTION(refCon: UInt32; VAR iconSuiteResourceId: INTEGER): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_GetIcon = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_GetState = FUNCTION(refCon: UInt32; buflen: UInt32; buffer: UNIV Ptr; VAR length: UInt32): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_GetState = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_SetState = FUNCTION(refCon: UInt32; length: UInt32; buffer: UNIV Ptr): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_SetState = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_Dirty = FUNCTION(refCon: UInt32; VAR dirty: BOOLEAN): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_Dirty = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_SetActive = FUNCTION(refCon: UInt32; active: BOOLEAN): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_SetActive = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_DialogItemHit = FUNCTION(refCon: UInt32; itemHit: INTEGER): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_DialogItemHit = ProcPtr;
{$ENDC}

	{  1.03 and later }
{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_Tickle = FUNCTION(refCon: UInt32): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_Tickle = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_InterruptTickle = FUNCTION(refCon: UInt32): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_InterruptTickle = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_Draw = FUNCTION(refCon: UInt32): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_Draw = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_Click = FUNCTION(refCon: UInt32; {CONST}VAR event: EventRecord): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_Click = ProcPtr;
{$ENDC}

	{  1.2 and later }
{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_ADBReInit = FUNCTION(refCon: UInt32; inPostProcess: BOOLEAN): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_ADBReInit = ProcPtr;
{$ENDC}

	{  1.7 and later }
{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_GetCalibration = FUNCTION(refCon: UInt32; calibration: UNIV Ptr; VAR calibrationSize: Size): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_GetCalibration = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_SetCalibration = FUNCTION(refCon: UInt32; calibration: UNIV Ptr; calibrationSize: Size): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_SetCalibration = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriverFunctionPtr_CalibrateDialog = FUNCTION(refCon: UInt32; VAR changed: BOOLEAN): OSStatus; C;
{$ELSEC}
	ISpDriverFunctionPtr_CalibrateDialog = ProcPtr;
{$ENDC}

	{  these functions are exported in the driver's pef container (1.7 or later) }
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  ISpDriver_CheckConfiguration()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION ISpDriver_CheckConfiguration(VAR validConfiguration: BOOLEAN): OSStatus; C;

{
 *  ISpDriver_FindAndLoadDevices()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ISpDriver_FindAndLoadDevices(VAR keepDriverLoaded: BOOLEAN): OSStatus; C;

{
 *  ISpDriver_DisposeDevices()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ISpDriver_DisposeDevices: OSStatus; C;

{
 *  ISpDriver_Tickle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE ISpDriver_Tickle; C;

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriver_CheckConfigurationPtr = FUNCTION(VAR validConfiguration: BOOLEAN): OSStatus; C;
{$ELSEC}
	ISpDriver_CheckConfigurationPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriver_FindAndLoadDevicesPtr = FUNCTION(VAR keepDriverLoaded: BOOLEAN): OSStatus; C;
{$ELSEC}
	ISpDriver_FindAndLoadDevicesPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriver_DisposeDevicesPtr = FUNCTION: OSStatus; C;
{$ELSEC}
	ISpDriver_DisposeDevicesPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ISpDriver_TicklePtr = PROCEDURE; C;
{$ELSEC}
	ISpDriver_TicklePtr = ProcPtr;
{$ENDC}

	{	 ********************* driver level functions ********************* 	}

	{	
	 *
	 * ISpDevice_New
	 *
	 * This creates a new device from the device definition structure and returns
	 * the result into the device reference.
	 *
	 * Returns Codes
	 * paramErr
	 * out of memory
	 * 
	 * Specical Considerations
	 * may not be done at interrupt time
	 	}
	{
	 *  ISpDevice_New()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
	 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
	 *    Mac OS X:         not available
	 	}
FUNCTION ISpDevice_New({CONST}VAR inStruct: ISpDeviceDefinition; metaHandler: ISpDriverFunctionPtr_MetaHandler; refCon: UInt32; VAR outReference: ISpDeviceReference): OSStatus; C;

{
 * ISpDevice_Dispose
 *
 * This disposes an existing device.
 *
 * Returns Codes
 * paramErr
 *
 * Special Considerations
 * May not be done at interrupt time
 *
 }
{
 *  ISpDevice_Dispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpDevice_Dispose(inReference: ISpDeviceReference): OSStatus; C;


{
 *
 * ISpElementDefinitionStruct
 *
 * This is the structure that defines everything static about this
 * element.  For each element on your device you will need to 
 * fill in one of these structures when your driver loads.
 *
 }

TYPE
	ISpElementDefinitionStructPtr = ^ISpElementDefinitionStruct;
	ISpElementDefinitionStruct = RECORD
		device:					ISpDeviceReference;						{  device this element belongs to  }
		group:					UInt32;									{  group this element belongs to or 0  }
		theString:				Str63;									{  a string that is a human readable identifier for this element, internationalization ?  }
		kind:					ISpElementKind;
		theLabel:				ISpElementLabel;
		configInfo:				Ptr;									{  a pointer to the buffer containing the configuration information for this element  }
		configInfoLength:		UInt32;									{  length of that configuration info  }
		dataSize:				UInt32;									{  the size of the data, so we can generate an appropriate buffer  }
		reserved1:				UInt32;
		reserved2:				UInt32;
		reserved3:				UInt32;
	END;

	{	
	 *
	 * ISpElement_New
	 *
	 * ISpElement_New takes an element definition struct and gives you back a element reference.
	 * When you produce data you use that element reference to give the data to the system.
	 * 
	 * Return Codes
	 * paramErr
	 * memory error
	 *
	 * Special Considerations
	 * The ISpElement_New function may move or purge memory.  Your application should not call this function 
	 * at interrupt time.
	 * 
	 	}
	{
	 *  ISpElement_New()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
	 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
	 *    Mac OS X:         not available
	 	}
FUNCTION ISpElement_New({CONST}VAR inStruct: ISpElementDefinitionStruct; VAR outElement: ISpElementReference): OSStatus; C;

{
 *
 * ISpElement_Dispose
 *
 * ISpElement_Dispose takes an element reference and deletes it.
 * You should call this function when your driver unloads.
 *
 * Return Codes
 * paramErr
 * memory error
 *
 * Special Considerations
 * The ISpElement_Dispose function may move or purge memory.  Your application should not call this function 
 * at interrupt time.
 * 
 }
{
 *  ISpElement_Dispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElement_Dispose(inElement: ISpElementReference): OSStatus; C;

{
 *
 * ISpElement_PushSimpleData
 *
 * ISpElement_PushSimpleData is the appropriate way to give the system data if your data fits exactly into
 * a 32 bit signed number.  You pass the element reference that goes with the data, the data and the 
 * AbsoluteTime that data was produced.  If UpTime is not available you should fill time.lo with the
 * TickCount time and time.hi with 0.
 *
 * Return Codes
 * paramErr
 *
 }
{
 *  ISpElement_PushSimpleData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElement_PushSimpleData(inElement: ISpElementReference; data: UInt32; {CONST}VAR time: AbsoluteTime): OSStatus; C;

{
 *
 * ISpElement_PushComplexData
 *
 * ISpElement_PushComplexData is exactly like ISpElement_PushSimpleData except that it is appropriate for times
 * when your data does not fit into a signed 32 bit integer.
 *
 * Instead it takes the length of your data (which must match the datasize field of your ISpElementDefinitionStruct)
 * and a ptr to the devices state.
 *
 * Return Codes
 * paramErr
 *
 }
{
 *  ISpElement_PushComplexData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but InputSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION ISpElement_PushComplexData(inElement: ISpElementReference; buflen: UInt32; state: UNIV Ptr; {CONST}VAR time: AbsoluteTime): OSStatus; C;

{  ***********************************************************************************  }

TYPE
	ISpADBDeferRef						= UInt32;
{$IFC TYPED_FUNCTION_POINTERS}
	ISpADBDeferCallbackProcPtr = PROCEDURE(adbCommand: ByteParameter; adbBuffer: UNIV Ptr; refcon: UInt32); C;
{$ELSEC}
	ISpADBDeferCallbackProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  ISpAllocateADBDeferBlock()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InputSprocketDeferLib 1.3 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION ISpAllocateADBDeferBlock(VAR createBlock: ISpADBDeferRef): OSErr; C;

{
 *  ISpDisposeADBDeferBlock()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketDeferLib 1.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ISpDisposeADBDeferBlock(disposeBlock: ISpADBDeferRef): OSErr; C;

{
 *  ISpInstallADBDefer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketDeferLib 1.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ISpInstallADBDefer(refBlock: ISpADBDeferRef; reqAddress: ADBAddress; installProc: ISpADBDeferCallbackProcPtr; clientRefCon: UInt32; VAR prevRoutine: ADBServiceRoutineUPP; VAR prevDataArea: Ptr): OSErr; C;

{
 *  ISpRemoveADBDefer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InputSprocketDeferLib 1.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ISpRemoveADBDefer(refBlock: ISpADBDeferRef): OSErr; C;

{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := InputSprocketIncludes}

{$ENDC} {__INPUTSPROCKET__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
