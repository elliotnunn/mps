{
 	File:		CMAcceleration.p
 
 	Contains:	ColorSync 2.0 Acceleration Component Interfaces
 
 	Version:	Technology:	ColorSync 2.0
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
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


{$IFC UNDEFINED __MEMORY__}
{$I Memory.p}
{$ENDC}
{	Types.p														}
{		ConditionalMacros.p										}
{	MixedMode.p													}

{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}

{$IFC UNDEFINED __CMAPPLICATION__}
{$I CMApplication.p}
{$ENDC}
{	Quickdraw.p													}
{		QuickdrawText.p											}
{	Files.p														}
{		OSUtils.p												}
{		Finder.p												}
{	Printing.p													}
{		Errors.p												}
{		Dialogs.p												}
{			Menus.p												}
{			Controls.p											}
{			Windows.p											}
{				Events.p										}
{			TextEdit.p											}
{	CMICCProfile.p												}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	cmAccelerationInterfaceVersion = 1;

{–––––––––––––––––––––––––––––––––––––– Component Type}
	cmAccelerationComponentType	= 'csac';

{–––––––––––––––––––––––––––––––––––––– Required Component function selectors}
	cmLoadTables				= 0;
	cmCalculateData				= 1;

{–––––––––––––––––––––––––––––––––––––– table data for acceleration component}

TYPE
	CMAccelerationTableData = RECORD
		inputLutEntryCount:		LONGINT;								{ count of entries for input lut for one dimension}
		inputLutWordSize:		LONGINT;								{ count of bits of each entry ( e.g. 16 for WORD )}
		inputLut:				Handle;									{ handle to input lut}
		outputLutEntryCount:	LONGINT;								{ count of entries for output lut for one dimension	}
		outputLutWordSize:		LONGINT;								{ count of bits of each entry ( e.g. 8 for BYTE )}
		outputLut:				Handle;									{ handle to output lut}
		colorLutInDim:			LONGINT;								{ input dimension  ( e.g. 3 for LAB ; 4 for CMYK )}
		colorLutOutDim:			LONGINT;								{ output dimension ( e.g. 3 for LAB ; 4 for CMYK )}
		colorLutGridPoints:		LONGINT;								{ count of gridpoints for color lut ( for one Dimension )	}
		colorLutWordSize:		LONGINT;								{ count of bits of each entry ( e.g. 8 for BYTE )}
		colorLut:				Handle;									{ handle to color lut}
		inputColorSpace:		CMBitmapColorSpace;						{ packing info for input}
		outputColorSpace:		CMBitmapColorSpace;						{ packing info for output}
		userData:				Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		reserved3:				LONGINT;
		reserved4:				LONGINT;
		reserved5:				LONGINT;
	END;

	CMAccelerationTableDataPtr = ^CMAccelerationTableData;
	CMAccelerationTableDataHdl = ^CMAccelerationTableDataPtr;

{–––––––––––––––––––––––––––––––––––––– calc data for acceleration component}
	CMAccelerationCalcData = RECORD
		pixelCount:				LONGINT;								{ count of input pixels}
		inputData:				Ptr;									{ input array}
		outputData:				Ptr;									{ output array}
		reserved1:				LONGINT;
		reserved2:				LONGINT;
	END;

	CMAccelerationCalcDataPtr = ^CMAccelerationCalcData;
	CMAccelerationCalcDataHdl = ^CMAccelerationCalcDataPtr;

{————————————————————————————————————————————————————————————————————————————————————————————————}
{				A c c e l e r a t i o n   C o m p o n e n t   I n t e r f a c e s}
{————————————————————————————————————————————————————————————————————————————————————————————————}

FUNCTION CMAccelerationLoadTables(CMSession: ComponentInstance; tableData: CMAccelerationTableDataPtr): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0000, $7000, $A82A;
	{$ENDC}
FUNCTION CMAccelerationCalculateData(CMSession: ComponentInstance; calcData: CMAccelerationCalcDataPtr): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMAccelerationIncludes}

{$ENDC} {__CMACCELERATION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
