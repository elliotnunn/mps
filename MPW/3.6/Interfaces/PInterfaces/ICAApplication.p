{
     File:       ICAApplication.p
 
     Contains:   General purpose Image Capture definitions
 
     Version:    Technology: 1.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ICAApplication;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ICAAPPLICATION__}
{$SETC __ICAAPPLICATION__ := 1}

{$I+}
{$SETC ICAApplicationIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	ICAObject    = ^LONGINT; { an opaque 32-bit type }
	ICAObjectPtr = ^ICAObject;  { when a VAR xx:ICAObject parameter can be nil, it is changed to xx: ICAObjectPtr }
	ICAProperty    = ^LONGINT; { an opaque 32-bit type }
	ICAPropertyPtr = ^ICAProperty;  { when a VAR xx:ICAProperty parameter can be nil, it is changed to xx: ICAPropertyPtr }
	ICAConnectionID    = ^LONGINT; { an opaque 32-bit type }
	ICAConnectionIDPtr = ^ICAConnectionID;  { when a VAR xx:ICAConnectionID parameter can be nil, it is changed to xx: ICAConnectionIDPtr }
	{	
	--------------- Defines --------------- 
		}
	{  Error codes (Image Capture range = -9900...-9949) }

CONST
	kICACommunicationErr		= -9900;
	kICADeviceNotFoundErr		= -9901;
	kICADeviceNotOpenErr		= -9902;
	kICAFileCorruptedErr		= -9903;
	kICAIOPendingErr			= -9904;
	kICAInvalidObjectErr		= -9905;
	kICAInvalidPropertyErr		= -9906;
	kICAIndexOutOfRangeErr		= -9907;
	kICAPropertyTypeNotFoundErr	= -9908;

	{	
	NOTE: vendor specific constants are UPPERCASE  (exception: 'TEXT')
		}
	{  ICAObject types and subtypes  }
	kICADevice					= 'icdv';						{  Also creator of device library files  }
	kICADeviceCamera			= 'cmra';						{  Also file type of device library files  }
	kICADeviceScanner			= 'scan';						{  Also file type of device library files  }
	kICADeviceMFP				= 'mfp ';						{  Also file type of device library files  }
	kICAList					= 'objl';
	kICADirectory				= 'dire';
	kICAFile					= 'file';
	kICAFileImage				= 'imag';
	kICAFileMovie				= 'moov';
	kICAFileAudio				= 'audo';
	kICAFileFirmware			= 'firm';
	kICAFileOther				= 'othe';

	{  ICAProperties  }
	kICAProperty				= 'prop';
	kICAPropertyImageWidth		= 'iwid';						{  UInt32  }
	kICAPropertyImageHeight		= 'ihei';						{  UInt32  }
	kICAPropertyImageSize		= 'isiz';						{  UInt32  }
	kICAPropertyImageDPI		= 'idpi';						{  UInt32  }
	kICAPropertyImageBitDepth	= 'ibit';						{  UInt32  }
	kICAPropertyImageData		= 'idat';						{  void *  }
	kICAPropertyImageFilename	= 'ifil';						{  null terminated string  }
	kICAPropertyImageCaptureDate = 'icdt';						{  null terminated string (YYYYMMDDThhmmss.s)  }
	kICAPropertyImageModificationDate = 'imdt';					{  null terminated string (YYYYMMDDThhmmss.s)  }
	kICAPropertyImageThumbnail	= 'thum';						{  void *  }
	kICAPropertyGamma			= 'igam';						{  UInt32  }
	kICAPropertyColorSyncProfile = 'prof';
	kICAPropertyListOfSupportedMessages = 'msgs';


	{  Messages  }
	kICAMessageConnect			= 'open';
	kICAMessageDisconnect		= 'clos';
	kICAMessageReset			= 'rese';
	kICAMessageCheckDevice		= 'chkd';


	{  Data type definitions, mapped to AppleEvent types  }
	kICATypeUInt16				= 'ui16';						{  UInt16  }
	kICATypeUInt32				= 'ui32';						{  UInt32  }
	kICATypeUInt64				= 'ui64';						{  UInt64  }
	kICATypeSInt16				= 'si16';						{  SInt16  }
	kICATypeSInt32				= 'si32';						{  SInt32  }
	kICATypeSInt64				= 'si64';						{  SInt64  }
	kICATypeFixed				= 'sing';						{  typeIEEE32BitFloatingPoint  }
	kICATypeBoolean				= 'bool';						{  typeBoolean  }
	kICATypeString				= 'TEXT';						{  typeChar  }
	kICATypeData				= 'data';						{  void *  }
	kICATypeThumbnail			= 'thum';						{  ICAThumbnail }


	{  Flags for PropertyInfo flag element  }
	kICAFlagReadWriteAccess		= $00000001;
	kICAFlagReadAccess			= $00000002;



	{  Notification types (Refer to section 12.4 of PTP spec)  }
	kICAEventCancelTransaction	= 'ecnt';
	kICAEventObjectAdded		= 'eoba';
	kICAEventObjectRemoved		= 'eobr';
	kICAEventStoreAdded			= 'esta';
	kICAEventStoreRemoved		= 'estr';
	kICAEventDeviceAdded		= 'edea';
	kICAEventDeviceRemoved		= 'eder';
	kICAEventDevicePropChanged	= 'edpc';
	kICAEventObjectInfoChanged	= 'eoic';
	kICAEventDeviceInfoChanged	= 'edic';
	kICAEventRequestObjectTransfer = 'erot';
	kICAEventStoreFull			= 'estf';
	kICAEventDeviceReset		= 'edvr';
	kICAEventStorageInfoChanged	= 'esic';
	kICAEventCaptureComplete	= 'ecpc';
	kICAEventUnreportedStatus	= 'eurs';


	{  Used for partial reads via ICAGetPropertyData  }
	kICAStartAtBeginning		= 0;
	kICAEntireLength			= -1;


	{	
	--------------- Structures --------------- 
		}

TYPE
	ICAObjectInfoPtr = ^ICAObjectInfo;
	ICAObjectInfo = RECORD
		objectType:				OSType;									{  i.e. kICAFile }
		objectSubtype:			OSType;									{  i.e. kICAFileImage   }
	END;

	ICAPropertyInfoPtr = ^ICAPropertyInfo;
	ICAPropertyInfo = RECORD
		propertyType:			OSType;
		dataType:				OSType;
		dataSize:				UInt32;
		dataFlags:				UInt32;
	END;

	ICAMessagePtr = ^ICAMessage;
	ICAMessage = RECORD
		messageType:			OSType;									{  <--  i.e. kICAMessageCameraCaptureNewImage  }
		startByte:				UInt32;									{  <--  }
		dataPtr:				Ptr;									{  <--  }
		dataSize:				UInt32;									{  <--  }
		dataType:				OSType;									{  <--  }
	END;

	ICAThumbnailPtr = ^ICAThumbnail;
	ICAThumbnail = RECORD
		width:					UInt32;
		height:					UInt32;
		dataSize:				UInt32;
		data:					SInt8;									{  8-bit RGB data (RGBRGBRGB...) }
	END;


CONST
	kICAPBVersion				= $00010000;


	{	 
	--------------- Completion Procs --------------- 
		}
	{
	   
	   NOTE: the parameter for the completion proc (ICAHeader*) has to be casted to the appropriate type
	   e.g. (ICAGetChildCountPB*), ...
	   
	}


TYPE
	ICAHeaderPtr = ^ICAHeader;
{$IFC TYPED_FUNCTION_POINTERS}
	ICACompletion = PROCEDURE(pb: ICAHeaderPtr); C;
{$ELSEC}
	ICACompletion = ProcPtr;
{$ENDC}

	{	 
	--------------- ICAHeader --------------- 
		}
	ICAHeader = RECORD
		err:					OSErr;									{  -->  }
		refcon:					UInt32;									{  <--  }
	END;

	{	
	--------------- Object parameter blocks --------------- 
		}
	ICAGetChildCountPBPtr = ^ICAGetChildCountPB;
	ICAGetChildCountPB = RECORD
		header:					ICAHeader;
		object:					ICAObject;								{  <--  }
		count:					UInt32;									{  -->  }
	END;

	ICAGetNthChildPBPtr = ^ICAGetNthChildPB;
	ICAGetNthChildPB = RECORD
		header:					ICAHeader;
		parentObject:			ICAObject;								{  <--  }
		index:					UInt32;									{  <-- zero based  }
		childObject:			ICAObject;								{  -->  }
		childInfo:				ICAObjectInfo;							{  -->  }
	END;

	ICAGetObjectInfoPBPtr = ^ICAGetObjectInfoPB;
	ICAGetObjectInfoPB = RECORD
		header:					ICAHeader;
		object:					ICAObject;								{  <--  }
		objectInfo:				ICAObjectInfo;							{  -->  }
	END;

	ICAGetParentOfObjectPBPtr = ^ICAGetParentOfObjectPB;
	ICAGetParentOfObjectPB = RECORD
		header:					ICAHeader;
		object:					ICAObject;								{  <--  }
		parentObject:			ICAObject;								{  -->  }
		parentInfo:				ICAObjectInfo;							{  -->  }
	END;

	ICAGetRootOfObjectPBPtr = ^ICAGetRootOfObjectPB;
	ICAGetRootOfObjectPB = RECORD
		header:					ICAHeader;
		object:					ICAObject;								{  <--  }
		rootObject:				ICAObject;								{  -->  }
		rootInfo:				ICAObjectInfo;							{  -->  }
	END;

	ICAGetObjectRefConPBPtr = ^ICAGetObjectRefConPB;
	ICAGetObjectRefConPB = RECORD
		header:					ICAHeader;
		object:					ICAObject;								{  <--  }
		objectRefCon:			UInt32;									{  -->  }
	END;

	ICASetObjectRefConPBPtr = ^ICASetObjectRefConPB;
	ICASetObjectRefConPB = RECORD
		header:					ICAHeader;
		object:					ICAObject;								{  <--  }
		objectRefCon:			UInt32;									{  <--  }
	END;

	{	
	--------------- Property parameter blocks --------------- 
		}
	ICAGetPropertyCountPBPtr = ^ICAGetPropertyCountPB;
	ICAGetPropertyCountPB = RECORD
		header:					ICAHeader;
		object:					ICAObject;								{  <--  }
		count:					UInt32;									{  -->  }
	END;

	ICAGetNthPropertyPBPtr = ^ICAGetNthPropertyPB;
	ICAGetNthPropertyPB = RECORD
		header:					ICAHeader;
		object:					ICAObject;								{  <--  }
		index:					UInt32;									{  <-- zero based  }
		property:				ICAProperty;							{  -->  }
		propertyInfo:			ICAPropertyInfo;						{  -->  }
	END;

	ICAGetPropertyByTypePBPtr = ^ICAGetPropertyByTypePB;
	ICAGetPropertyByTypePB = RECORD
		header:					ICAHeader;
		object:					ICAObject;								{  <--  }
		propertyType:			OSType;									{  <--  }
		property:				ICAProperty;							{  -->  }
		propertyInfo:			ICAPropertyInfo;						{  -->  }
	END;

	ICAGetPropertyInfoPBPtr = ^ICAGetPropertyInfoPB;
	ICAGetPropertyInfoPB = RECORD
		header:					ICAHeader;
		property:				ICAProperty;							{  <--  }
		propertyInfo:			ICAPropertyInfo;						{  -->  }
	END;

	ICAGetPropertyDataPBPtr = ^ICAGetPropertyDataPB;
	ICAGetPropertyDataPB = RECORD
		header:					ICAHeader;
		property:				ICAProperty;							{  <--  }
		startByte:				UInt32;									{  <--  }
		requestedSize:			UInt32;									{  <--  }
		dataPtr:				Ptr;									{  <->  }
		actualSize:				UInt32;									{  -->  }
		dataType:				OSType;									{  -->  }
	END;

	ICASetPropertyDataPBPtr = ^ICASetPropertyDataPB;
	ICASetPropertyDataPB = RECORD
		header:					ICAHeader;
		property:				ICAProperty;							{  <--  }
		startByte:				UInt32;									{  <--  }
		dataPtr:				Ptr;									{  <--  }
		dataSize:				UInt32;									{  <--  }
		dataType:				OSType;									{  <--  }
	END;

	ICAGetParentOfPropertyPBPtr = ^ICAGetParentOfPropertyPB;
	ICAGetParentOfPropertyPB = RECORD
		header:					ICAHeader;
		property:				ICAProperty;							{  <--  }
		parentObject:			ICAObject;								{  -->  }
		parentInfo:				ICAObjectInfo;							{  -->  }
	END;

	ICAGetRootOfPropertyPBPtr = ^ICAGetRootOfPropertyPB;
	ICAGetRootOfPropertyPB = RECORD
		header:					ICAHeader;
		property:				ICAProperty;							{  <--  }
		rootObject:				ICAObject;								{  -->  }
		rootInfo:				ICAObjectInfo;							{  -->  }
	END;

	ICAGetPropertyRefConPBPtr = ^ICAGetPropertyRefConPB;
	ICAGetPropertyRefConPB = RECORD
		header:					ICAHeader;
		property:				ICAProperty;							{  <--  }
		propertyRefCon:			UInt32;									{  -->  }
	END;

	ICASetPropertyRefConPBPtr = ^ICASetPropertyRefConPB;
	ICASetPropertyRefConPB = RECORD
		header:					ICAHeader;
		property:				ICAProperty;							{  <--  }
		propertyRefCon:			UInt32;									{  <--  }
	END;

	{	
	--------------- Device parameter blocks --------------- 
		}
	ICAGetDeviceListPBPtr = ^ICAGetDeviceListPB;
	ICAGetDeviceListPB = RECORD
		header:					ICAHeader;
		object:					ICAObject;								{  -->  }
	END;

	ICAObjectSendMessagePBPtr = ^ICAObjectSendMessagePB;
	ICAObjectSendMessagePB = RECORD
		header:					ICAHeader;
		object:					ICAObject;								{  <--  }
		message:				ICAMessage;								{  <--  }
		result:					UInt32;									{  --> message specific result }
	END;

	ICARegisterEventNotificationPBPtr = ^ICARegisterEventNotificationPB;
	ICARegisterEventNotificationPB = RECORD
		header:					ICAHeader;
		object:					ICAObject;								{  <--  }
		notifyType:				OSType;									{  <--  }
		notifyProc:				ICACompletion;							{  <--  }
	END;

	{
	   
	   NOTE: for all APIs - pass NULL as completion parameter to make a synchronous call 
	   
	}

	{	
	--------------- Object functions --------------- 
		}

	{
	 *  ICAGetChildCount()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION ICAGetChildCount(VAR pb: ICAGetChildCountPB; completion: ICACompletion): OSErr;

{
 *  ICAGetNthChild()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ICAGetNthChild(VAR pb: ICAGetNthChildPB; completion: ICACompletion): OSErr;

{
 *  ICAGetObjectInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ICAGetObjectInfo(VAR pb: ICAGetObjectInfoPB; completion: ICACompletion): OSErr;

{
 *  ICAGetParentOfObject()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ICAGetParentOfObject(VAR pb: ICAGetParentOfObjectPB; completion: ICACompletion): OSErr;

{
 *  ICAGetRootOfObject()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ICAGetRootOfObject(VAR pb: ICAGetRootOfObjectPB; completion: ICACompletion): OSErr;

{
 *  ICAGetObjectRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ICAGetObjectRefCon(VAR pb: ICAGetObjectRefConPB; completion: ICACompletion): OSErr;

{
 *  ICASetObjectRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ICASetObjectRefCon(VAR pb: ICASetObjectRefConPB; completion: ICACompletion): OSErr;


{
--------------- Property functions --------------- 
}
{
 *  ICAGetPropertyCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ICAGetPropertyCount(VAR pb: ICAGetPropertyCountPB; completion: ICACompletion): OSErr;

{
 *  ICAGetNthProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ICAGetNthProperty(VAR pb: ICAGetNthPropertyPB; completion: ICACompletion): OSErr;

{
 *  ICAGetPropertyByType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ICAGetPropertyByType(VAR pb: ICAGetPropertyByTypePB; completion: ICACompletion): OSErr;

{
 *  ICAGetPropertyInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ICAGetPropertyInfo(VAR pb: ICAGetPropertyInfoPB; completion: ICACompletion): OSErr;

{
 *  ICAGetPropertyData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ICAGetPropertyData(VAR pb: ICAGetPropertyDataPB; completion: ICACompletion): OSErr;

{
 *  ICASetPropertyData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ICASetPropertyData(VAR pb: ICASetPropertyDataPB; completion: ICACompletion): OSErr;

{
 *  ICAGetParentOfProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ICAGetParentOfProperty(VAR pb: ICAGetParentOfPropertyPB; completion: ICACompletion): OSErr;

{
 *  ICAGetRootOfProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ICAGetRootOfProperty(VAR pb: ICAGetRootOfPropertyPB; completion: ICACompletion): OSErr;

{
 *  ICAGetPropertyRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ICAGetPropertyRefCon(VAR pb: ICAGetPropertyRefConPB; completion: ICACompletion): OSErr;

{
 *  ICASetPropertyRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ICASetPropertyRefCon(VAR pb: ICASetPropertyRefConPB; completion: ICACompletion): OSErr;


{ 
--------------- Device functions --------------- 
}
{
 *  ICAGetDeviceList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ICAGetDeviceList(VAR pb: ICAGetDeviceListPB; completion: ICACompletion): OSErr;

{
 *  ICAObjectSendMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ICAObjectSendMessage(VAR pb: ICAObjectSendMessagePB; completion: ICACompletion): OSErr;

{
 *  ICARegisterEventNotification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ICARegisterEventNotification(VAR pb: ICARegisterEventNotificationPB; completion: ICACompletion): OSErr;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ICAApplicationIncludes}

{$ENDC} {__ICAAPPLICATION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
