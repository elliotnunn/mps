{
     File:       CMAcceleration.p
 
     Contains:   ColorSync Acceleration Component API
 
     Version:    Technology: ColorSync 2.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1995-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CMAcceleration;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CMACCELERATION__}
{$SETC __CMACCELERATION__ := 1}

{$I+}
{$SETC CMAccelerationIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __CMAPPLICATION__}
{$I CMApplication.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{  –––––––––––––––––––––––––––––––––––––– version info  }

CONST
	cmAccelerationInterfaceVersion = 1;

	{  –––––––––––––––––––––––––––––––––––––– Component Type  }
	cmAccelerationComponentType	= 'csac';

	{  –––––––––––––––––––––––––––––––––––––– Required Component function selectors  }
	cmLoadTables				= 0;
	cmCalculateData				= 1;

	{  –––––––––––––––––––––––––––––––––––––– table data for acceleration component  }

TYPE
	CMAccelerationTableDataPtr = ^CMAccelerationTableData;
	CMAccelerationTableData = RECORD
		inputLutEntryCount:		LONGINT;								{  count of entries for input lut for one dimension }
		inputLutWordSize:		LONGINT;								{  count of bits of each entry ( e.g. 16 for WORD ) }
		inputLut:				Handle;									{  handle to input lut }
		outputLutEntryCount:	LONGINT;								{  count of entries for output lut for one dimension   }
		outputLutWordSize:		LONGINT;								{  count of bits of each entry ( e.g. 8 for BYTE ) }
		outputLut:				Handle;									{  handle to output lut }
		colorLutInDim:			LONGINT;								{  input dimension  ( e.g. 3 for LAB ; 4 for CMYK ) }
		colorLutOutDim:			LONGINT;								{  output dimension ( e.g. 3 for LAB ; 4 for CMYK ) }
		colorLutGridPoints:		LONGINT;								{  count of gridpoints for color lut ( for one Dimension )     }
		colorLutWordSize:		LONGINT;								{  count of bits of each entry ( e.g. 8 for BYTE ) }
		colorLut:				Handle;									{  handle to color lut }
		inputColorSpace:		CMBitmapColorSpace;						{  packing info for input }
		outputColorSpace:		CMBitmapColorSpace;						{  packing info for output }
		userData:				Ptr;
		reserved1:				UInt32;
		reserved2:				UInt32;
		reserved3:				UInt32;
		reserved4:				UInt32;
		reserved5:				UInt32;
	END;

	CMAccelerationTableDataHdl			= ^CMAccelerationTableDataPtr;
	{  –––––––––––––––––––––––––––––––––––––– calc data for acceleration component  }
	CMAccelerationCalcDataPtr = ^CMAccelerationCalcData;
	CMAccelerationCalcData = RECORD
		pixelCount:				LONGINT;								{  count of input pixels }
		inputData:				Ptr;									{  input array }
		outputData:				Ptr;									{  output array }
		reserved1:				UInt32;
		reserved2:				UInt32;
	END;

	CMAccelerationCalcDataHdl			= ^CMAccelerationCalcDataPtr;
	{
	   ———————————————————————————————————————————————————————————————————————————————————————————————— 
	                A c c e l e r a t i o n   C o m p o n e n t   I n t e r f a c e s
	   ———————————————————————————————————————————————————————————————————————————————————————————————— 
	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  CMAccelerationLoadTables()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION CMAccelerationLoadTables(CMSession: ComponentInstance; tableData: CMAccelerationTableDataPtr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0000, $7000, $A82A;
	{$ENDC}


{
 *  CMAccelerationCalculateData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMAccelerationCalculateData(CMSession: ComponentInstance; calcData: CMAccelerationCalcDataPtr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}


{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMAccelerationIncludes}

{$ENDC} {__CMACCELERATION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
