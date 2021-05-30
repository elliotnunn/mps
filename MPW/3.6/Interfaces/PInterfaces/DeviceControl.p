{
     File:       DeviceControl.p
 
     Contains:   Component API for doing AVC transactions.
 
     Version:    Technology: xxx put version here xxx
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
 UNIT DeviceControl;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DEVICECONTROL__}
{$SETC __DEVICECONTROL__ := 1}

{$I+}
{$SETC DeviceControlIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	DCResponseHandler = FUNCTION(fwCommandObjectID: UInt32; responseBuffer: Ptr; responseLength: UInt32): UInt32; C;
{$ELSEC}
	DCResponseHandler = ProcPtr;
{$ENDC}

	DVCTransactionParamsPtr = ^DVCTransactionParams;
	DVCTransactionParams = RECORD
		commandBufferPtr:		Ptr;
		commandLength:			UInt32;
		responseBufferPtr:		Ptr;
		responseBufferSize:		UInt32;
		responseHandler:		^DCResponseHandler;
	END;

	{
	 *  DeviceControlDoAVCTransaction()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in IDHLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.3 and later
	 *    Mac OS X:         not available
	 	}
FUNCTION DeviceControlDoAVCTransaction(instance: ComponentInstance; VAR params: DVCTransactionParams): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DeviceControlIncludes}

{$ENDC} {__DEVICECONTROL__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
