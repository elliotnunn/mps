/*
 *	File:			InputSprocket.h
 *
 *	Version:		Input Sprocket 1.1
 *
 *	Dependencies:	Universal Interfaces 2.1.2 on ETO #20
 *
 *	Contents:		Public interfaces for InputSprocket.
 *
 *	Bugs:			If you find a problem with this file or InputSprocketLib,
 *					please send e-mail describing the problem in enough detail
 *					to be reproduced, and include the version number above, the
 *					version of MacOS and hardware configuration information to
 *					sprockets@adr.apple.com.
 *
 *	Copyright (c) 1996 Apple Computer, Inc.  All rights reserved.
 */

#ifndef __INPUTSPROCKET__
#define __INPUTSPROCKET__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __EVENTS__
#include <Events.h>
#endif

#ifndef USE_OLD_INPUT_SPROCKET_LABELS
#define USE_OLD_INPUT_SPROCKET_LABELS 1 // this will be changed to false soon
#endif

#if GENERATINGPOWERPC

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=power
#endif

/* ********************* data types ********************* */
typedef struct ISpDevicePrivate *ISpDeviceReference;
typedef struct ISpElementPrivate *ISpElementReference;
typedef struct ISpElementListPrivate *ISpElementListReference;
typedef OSType ISpDeviceClass;  /* general classs of device, example: keyboard, mouse, joystick */
typedef OSType ISpDeviceIdentifier;   /* a specific device,  example: standard 1-button mouse, 105key ext. kbd. */
typedef OSType ISpElementLabel;
typedef OSType ISpElementKind;

/* *************** errors -30420 to -30439***************** */

enum
{
	kISpInternalErr = -30420,
	kISpSystemListErr = -30421,
	kISpBufferToSmallErr = -30422,
	kISpElementInListErr = -30423,
	kISpElementNotInListErr = - 30424,
	kISpSystemInactiveErr = -30425,
	kISpDeviceInactiveErr = -30426,
	kISpSystemActiveErr = -30427,
	kISpDeviceActiveErr = -30428,
	kISpListBusyErr = -30429
};

/* *************** resources **************** */

enum 
{
	kISpSetListResourceType = 'setl',
	kISpSetDataResourceType = 'setd'
};

/*
 * ISpDeviceDefinition
 *
 * This structure provides all the available
 * information for an input device within the system
 *
 */
 
typedef struct ISpDeviceDefinition
{
	Str63 deviceName;								/* a human readable name of the device */
	ISpDeviceClass theDeviceClass;					/* general classs of device example : keyboard, mouse, joystick */
	ISpDeviceIdentifier theDeviceIdentifier;		/* every distinguishable device should have an OSType */
	UInt32 permanentID;								/* a cross reboot id unique within that deviceType, 0 if not possible */
	UInt32 flags;									/* status flags */
	UInt32 reserved1;
	UInt32 reserved2;
	UInt32 reserved3;
} ISpDeviceDefinition;

enum
{
	kISpDeviceFlag_HandleOwnEmulation = 1
};

/*
 * ISpElementEvent, ISpElementEventPtr
 *
 * This is the structure that event data is passed in.
 *
 */
 
typedef struct ISpElementEvent
{
	AbsoluteTime when;              	/* this is absolute time on PCI or later, otherwise it is */
										/* 0 for the hi 32 bits and TickCount for the low 32 bits */
	ISpElementReference element;		/* a reference to the element that generated this event */
	UInt32 refCon;						/* for application usage, 0 on the global list */
	UInt32 data;						/* the data for this event */
} ISpElementEvent, *ISpElementEventPtr;

/*
 * ISpElementInfo, ISpElementInfoPtr
 *
 * This is the generic definition of an element.
 * Every element must contain this information.
 *
 */
typedef struct ISpElementInfo
{
	ISpElementLabel theLabel;
	ISpElementKind theKind;
	Str63 theString;
	UInt32 reserved1;
	UInt32 reserved2;
} ISpElementInfo, *ISpElementInfoPtr;

typedef struct ISpNeed
{
	Str63 name;
	short iconSuiteResourceId;	/* resource id of the icon suite */
	short reserved;
	ISpElementKind theKind;
	ISpElementLabel theLabel;
	UInt32 flags;
	UInt32 reserved1;
	UInt32 reserved2;
	UInt32 reserved3;
} ISpNeed;

typedef UInt32 ISpNeedFlagBits;
enum
{
	kISpNeedFlag_NoMultiConfig = 1
};

/*
 *
 * These are the current built values for ISpDeviceClass
 *
 */
 
enum
{
	kISpDeviceClass_SpeechRecognition = 'talk',
	kISpDeviceClass_Mouse = 'mous',
	kISpDeviceClass_Keyboard = 'keyd',
	kISpDeviceClass_Joystick = 'joys',
	kISpDeviceClass_Wheel = 'whel',
	kISpDeviceClass_Pedals = 'pedl',
	kISpDeviceClass_Levers = 'levr',
	kISpDeviceClass_Tickle = 'tckl'		// a device of this class requires ISpTickle
};

/*
 * These are the current built in ISpElementKind's
 * 
 * These are all OSTypes.
 *
 */
 
enum
{
	kISpElementKind_Button = 'butn',
	kISpElementKind_DPad = 'dpad',
	kISpElementKind_Axis = 'axis',
	kISpElementKind_Movement = 'move',
	kISpElementKind_Virtual = 'virt'
};


/*
 *
 * These are the current built in ISpElementLabel's
 *
 * These are all OSTypes.
 *
 */

#if USE_OLD_INPUT_SPROCKET_LABELS 
enum
{
	/* axis */
	kISpElementLabel_XAxis = 'xaxi',
	kISpElementLabel_YAxis = 'yaxi',
	kISpElementLabel_ZAxis = 'zaxi',
	
	kISpElementLabel_Rx = 'rxax',
	kISpElementLabel_Ry = 'ryax',
	kISpElementLabel_Rz = 'rzax',
	
	kISpElementLabel_Gas = 'gasp',
	kISpElementLabel_Brake = 'brak',
	kISpElementLabel_Clutch = 'cltc',
	
	kISpElementLabel_Throttle = 'thrt',
	kISpElementLabel_Trim = 'trim',
	
	/* direction pad */
	kISpElementLabel_POVHat = 'povh',
	kISpElementLabel_PadMove = 'move',
	
	/* buttons */
	kISpElementLabel_Fire = 'fire',
	kISpElementLabel_Start = 'strt',
	kISpElementLabel_Select = 'optn'
};
#endif

enum
{
	/* generic */
	kISpElementLabel_None = 'none',
	
	/* axis */
	kISpElementLabel_Axis_XAxis = 'xaxi',
	kISpElementLabel_Axis_YAxis = 'yaxi',
	kISpElementLabel_Axis_ZAxis = 'zaxi',
	
	kISpElementLabel_Axis_Rx = 'rxax',
	kISpElementLabel_Axis_Ry = 'ryax',
	kISpElementLabel_Axis_Rz = 'rzax',
	
	kISpElementLabel_Axis_Gas = 'gasp',
	kISpElementLabel_Axis_Brake = 'brak',
	kISpElementLabel_Axis_Clutch = 'cltc',
	
	kISpElementLabel_Axis_Throttle = 'thrt',
	kISpElementLabel_Axis_Trim = 'trim',
	kISpElementLabel_Axis_Rudder = 'rudd',
	
	/* direction pad */
	kISpElementLabel_Pad_POV = 'povh',
	kISpElementLabel_Pad_Move = 'move',
	
	/* buttons */
	kISpElementLabel_Btn_Fire = 'fire',
	kISpElementLabel_Btn_SecondaryFire = 'sfir',
	kISpElementLabel_Btn_Jump = 'jump',
	kISpElementLabel_Btn_PauseResume = 'strt',	
	/* kISpElementLabel_Btn_PauseResume automatically binds to escape */
	kISpElementLabel_Btn_Select = 'optn',
	
	kISpElementLabel_Btn_SlideLeft = 'blft',
	kISpElementLabel_Btn_SlideRight = 'brgt',
	
	kISpElementLabel_Btn_MoveForward = 'btmf',
	kISpElementLabel_Btn_MoveBackward = 'btmb',
	
	kISpElementLabel_Btn_TurnLeft = 'bttl',
	kISpElementLabel_Btn_TurnRight = 'bttr',
	
	kISpElementLabel_Btn_LookLeft = 'btll',
	kISpElementLabel_Btn_LookRight = 'btlr',
	kISpElementLabel_Btn_LookUp = 'btlu',
	kISpElementLabel_Btn_LookDown = 'btld',
	
	kISpElementLabel_Btn_Next = 'btnx',
	kISpElementLabel_Btn_Previous = 'btpv',
	
	kISpElementLabel_Btn_SideStep = 'side',
	kISpElementLabel_Btn_Run = 'quik',
	kISpElementLabel_Btn_Look = 'blok'
};

/*
 *
 * direction pad data & configuration information
 *
 */
 
typedef UInt32 ISpDPadData;
enum
{
	kISpPadIdle = 0,
	kISpPadLeft,
	kISpPadUpLeft,
	kISpPadUp,
	kISpPadUpRight,
	kISpPadRight,
	kISpPadDownRight,
	kISpPadDown,
	kISpPadDownLeft
};

typedef struct ISpDPadConfigurationInfo
{
	UInt32 id;				/* ordering 1..n, 0 = no relavent ordering of direction pads */
	Boolean fourWayPad;		/* true if this pad can only produce idle + four directions */
} ISpDPadConfigurationInfo;

/*
 *
 * button data & configuration information
 *
 */
 
typedef UInt32 ISpButtonData;
enum
{
	kISpButtonUp = 0,
	kISpButtonDown = 1
};

typedef struct ISpButtonConfigurationInfo
{
	UInt32 id;				/* ordering 1..n, 0 = no relavent ordering of buttons */
} ISpButtonConfigurationInfo;

/*
 *
 * axis data & configuration information 
 *
 */
 
#define	kISpAxisMinimum  0x00000000U
#define	kISpAxisMiddle   0x7FFFFFFFU
#define	kISpAxisMaximum  0xFFFFFFFFU

typedef struct ISpAxisConfigurationInfo
{
	Boolean	symetricAxis;	/* axis is symetric, i.e. a joystick is symetric and a gas pedal is not */
} ISpAxisConfigurationInfo;


typedef struct ISpMovementData
{
	UInt32 xAxis;
	UInt32 yAxis;
	UInt32 direction;	/* ISpDPadData version of the movement */
} ISpMovementData;

enum
{
	kISpVirtualElementFlag_UseTempMem = 1
};

enum
{
	kISpElementListFlag_UseTempMem = 1
};

enum
{
	kISpFirstIconSuite = 30000,
	kISpLastIconSuite = 30100,
	kISpNoneIconSuite = 30000
};

/* ********************* user level functions ********************* */



/*
 *
 * startup / shutdown
 *
 */

OSStatus ISpStartup(void);	// 1.1 or later
OSStatus ISpShutdown(void); // 1.1 or later

/*
 *
 * polling
 *
 */
 
 OSStatus ISpTickle(void);	// 1.1 or later

/********** user interface functions **********/


NumVersion ISpGetVersion(void);

/*
 *
 * ISpElement_NewVirtual(ISpElementReference *outElement);
 *
 */
 
OSStatus ISpElement_NewVirtual(UInt32 dataSize, ISpElementReference *outElement, UInt32 flags);

/*
 *
 * ISpElement_NewVirtualFromNeeds(UInt32 count, ISpNeeds *needs, ISpElementReference *outElements);
 *
 */
 
OSStatus ISpElement_NewVirtualFromNeeds(UInt32 count, ISpNeed *needs, ISpElementReference *outElements, UInt32 flags);

/*
 *
 * ISpElement_DisposeVirtual(inElement);
 *
 */

OSStatus ISpElement_DisposeVirtual(UInt32 count, ISpElementReference *inElements);

/*
 * ISpInit
 *
 */
 
OSStatus ISpInit(
	UInt32 count,
	ISpNeed *needs,
	ISpElementReference *inReferences,
	OSType appCreatorCode,
	OSType subCreatorCode,
	UInt32 flags,
	short setListResourceId, 
	UInt32 version);
	
	
/*
 * ISpConfigure
 *
 */
 
typedef Boolean (*ISpEventProcPtr) (EventRecord* inEvent);

OSStatus ISpConfigure(ISpEventProcPtr inEventProcPtr);

/*
 *
 * ISpStop
 *
 */
 
OSStatus ISpStop(void);

/*
 *
 * ISpSuspend, ISpResume
 *
 * ISpSuspend turns all devices off and allocates memory so that the state may be later resumed.
 * ISpResume resumes to the previous state of the system after a suspend call.
 * 
 * Return Codes
 * memFullErr
 *
 */
 
OSStatus ISpSuspend(void);
OSStatus ISpResume(void);

/*
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
 */

OSStatus ISpDevices_Extract(UInt32 inBufferCount, UInt32 *outCount, ISpDeviceReference *buffer);
OSStatus ISpDevices_ExtractByClass(ISpDeviceClass inClass, UInt32 inBufferCount, UInt32 *outCount, ISpDeviceReference *buffer);
OSStatus ISpDevices_ExtractByIdentifier(ISpDeviceIdentifier inIdentifier, UInt32 inBufferCount, UInt32 *outCount, ISpDeviceReference *buffer);


/*
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
 */
 
OSStatus ISpDevices_ActivateClass(ISpDeviceClass inClass);		// 1.1 or later
OSStatus ISpDevices_DeactivateClass(ISpDeviceClass inClass);	// 1.1 or later
OSStatus ISpDevices_Activate(UInt32 inDeviceCount, ISpDeviceReference *inDevicesToActivate);
OSStatus ISpDevices_Deactivate(UInt32 inDeviceCount, ISpDeviceReference *inDevicesToDeactivate);
OSStatus ISpDevice_IsActive(ISpDeviceReference inDevice, Boolean *outIsActive);

/*
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
 */
 
OSStatus ISpDevice_GetDefinition(const ISpDeviceReference inDevice, UInt32 inBuflen, ISpDeviceDefinition *outStruct);


/*
 *
 * ISpDevice_GetElementList
 *
 * inDevice - the device whose element list you wish to get
 * outElementList - a pointer to where you want a reference to that list stored
 *
 * Return Codes
 * paramErr
 *
 */
 
OSStatus ISpDevice_GetElementList(const ISpDeviceReference inDevice, ISpElementListReference *outElementList);

/*
 *
 * takes an ISpElementReference and returns the group that it is in or 0 if there is
 * no group
 *
 * Return Codes
 * paramErr
 *
 */
 
OSStatus ISpElement_GetGroup(const ISpElementReference inElement, UInt32 *outGroup);

/*
 *
 * takes an ISpElementReference and returns the device that the element belongs 
 * to.
 *
 * Return Codes
 * paramErr if inElement is 0 or outDevice is nil
 *
 */
 
OSStatus ISpElement_GetDevice(const ISpElementReference inElement, ISpDeviceReference *outDevice);
		
/*
 *
 * takes an ISpElementReference and gives the ISpElementInfo for that Element.  This is the
 * the set of standard information.  You get ISpElementKind specific information
 * through ISpElement_GetConfigurationInfo.
 *
 * Return Codes
 * paramErr if inElement is 0 or outInfo is nil
 *
 */

OSStatus ISpElement_GetInfo(const ISpElementReference inElement, ISpElementInfoPtr outInfo);
		
/*
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
 */
 
OSStatus ISpElement_GetConfigurationInfo(const ISpElementReference inElement, UInt32 buflen, void *configInfo);
	
/*
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
 */
 
OSStatus ISpElement_GetSimpleState(const ISpElementReference inElement, UInt32 *state);

/*
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
 */

OSStatus ISpElement_GetComplexState(const ISpElementReference inElement, UInt32 buflen, void *state);

 
/*
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
 */
 
OSStatus ISpElement_GetNextEvent(ISpElementReference inElement, UInt32 bufSize, ISpElementEventPtr event, Boolean *wasEvent);

/*
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
 */
 
OSStatus ISpElement_Flush(ISpElementReference inElement);



/*
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
 */

OSStatus ISpElementList_New(UInt32 inCount, ISpElementReference *inElements, ISpElementListReference *outElementList, UInt32 flags);

/*
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
 */

OSStatus ISpElementList_Dispose(ISpElementListReference inElementList);

/*
 * ISpGetGlobalElementList
 *
 * returns the global element list
 *
 * Return Codes
 * paramErr if outElementList is nil
 *
 */ 

OSStatus ISpGetGlobalElementList(ISpElementListReference *outElementList);

/*
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
 */
OSStatus ISpElementList_AddElements(ISpElementListReference inElementList, UInt32 refCon, UInt32 count, ISpElementReference *newElements);

/*
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
 */
 
OSStatus ISpElementList_RemoveElements(ISpElementListReference inElementList, UInt32 count, ISpElementReference *oldElement);

/*
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
 */
 
OSStatus ISpElementList_Extract(ISpElementListReference inElementList, UInt32 inBufferCount, UInt32 *outCount, ISpElementReference *buffer);
OSStatus ISpElementList_ExtractByKind(ISpElementListReference inElementList, ISpElementKind inKind, UInt32 inBufferCount, UInt32 *outCount, ISpElementReference *buffer);
OSStatus ISpElementList_ExtractByLabel(ISpElementListReference inElementList, ISpElementLabel inLabel, UInt32 inBufferCount, UInt32 *outCount, ISpElementReference *buffer);
 
/*
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
 */
 
OSStatus ISpElementList_GetNextEvent(ISpElementListReference inElementList, UInt32 bufSize, ISpElementEventPtr event, Boolean *wasEvent);

/*
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
 */
 
OSStatus ISpElementList_Flush(ISpElementListReference inElementList);


#ifdef __cplusplus
}
#endif



#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#endif /* GENERATINGPOWERPC */
#endif /* __INPUTSPROCKET__ */
