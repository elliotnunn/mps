{
     File:       ICADevice.p
 
     Contains:   Image Capture device definitions.  This file is included
 
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
 UNIT ICADevice;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ICADEVICE__}
{$SETC __ICADEVICE__ := 1}

{$I+}
{$SETC ICADeviceIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __ICAAPPLICATION__}
{$I ICAApplication.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ 
--------------- Completion Procs --------------- 
}
{
   
   NOTE: the parameter for the completion proc (ICDHeader*) has to be casted to the appropriate type
   e.g. (ICD_BuildObjectChildrenPB*), ...
   
}

TYPE
	ICDHeaderPtr = ^ICDHeader;
{$IFC TYPED_FUNCTION_POINTERS}
	ICDCompletion = PROCEDURE(pb: ICDHeaderPtr); C;
{$ELSEC}
	ICDCompletion = ProcPtr;
{$ENDC}

	{	 
	--------------- ICDHeader --------------- 
		}
	ICDHeader = RECORD
		err:					OSErr;									{  -->  }
		refcon:					UInt32;									{  <--  }
	END;

	{	
	--------------- Object parameter blocks ---------------
		}
	ICD_NewObjectPBPtr = ^ICD_NewObjectPB;
	ICD_NewObjectPB = RECORD
		header:					ICDHeader;
		parentObject:			ICAObject;								{  <--  }
		objectInfo:				ICAObjectInfo;							{  <--  }
		object:					ICAObject;								{  -->  }
	END;

	ICD_DisposeObjectPBPtr = ^ICD_DisposeObjectPB;
	ICD_DisposeObjectPB = RECORD
		header:					ICDHeader;
		object:					ICAObject;								{  <--  }
	END;

	{	
	--------------- Property parameter blocks ---------------
		}
	ICD_NewPropertyPBPtr = ^ICD_NewPropertyPB;
	ICD_NewPropertyPB = RECORD
		header:					ICDHeader;
		object:					ICAObject;								{  <--  }
		propertyInfo:			ICAPropertyInfo;						{  <--  }
		property:				ICAProperty;							{  -->  }
	END;

	ICD_DisposePropertyPBPtr = ^ICD_DisposePropertyPB;
	ICD_DisposePropertyPB = RECORD
		header:					ICDHeader;
		property:				ICAProperty;							{  <--  }
	END;

	{
	   
	   NOTE: for all APIs - pass NULL as completion parameter to make a synchronous call 
	   
	}

	{	 
	--------------- Object utilities for device libraries --------------- 
		}
	{
	 *  ICDNewObject()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION ICDNewObject(VAR pb: ICD_NewObjectPB; completion: ICDCompletion): OSErr;

{
 *  ICDDisposeObject()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ICDDisposeObject(VAR pb: ICD_DisposeObjectPB; completion: ICDCompletion): OSErr;

{
 *  ICDNewProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ICDNewProperty(VAR pb: ICD_NewPropertyPB; completion: ICDCompletion): OSErr;

{
 *  ICDDisposeProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ICDDisposeProperty(VAR pb: ICD_DisposePropertyPB; completion: ICDCompletion): OSErr;





{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ICADeviceIncludes}

{$ENDC} {__ICADEVICE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
