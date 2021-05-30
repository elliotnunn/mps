{
     File:       QD3DCustomElements.p
 
     Contains:   Custom QuickTime Elements in QuickDraw 3D
 
     Version:    Technology: Quickdraw 3D 1.6
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
 UNIT QD3DCustomElements;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DCUSTOMELEMENTS__}
{$SETC __QD3DCUSTOMELEMENTS__ := 1}

{$I+}
{$SETC QD3DCustomElementsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}


{*****************************************************************************
 **                                                                          **
 **                     Custom Name Element Functions                        **
 **                                                                          **
 ****************************************************************************}
{$IFC CALL_NOT_IN_CARBON }
{
 *  CENameElement_SetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CENameElement_SetData(object: TQ3Object; name: ConstCStringPtr): TQ3Status; C;

{
 *  CENameElement_GetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CENameElement_GetData(object: TQ3Object; VAR name: CStringPtr): TQ3Status; C;

{
 *  CENameElement_EmptyData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CENameElement_EmptyData(VAR name: CStringPtr): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         URL Data Structure Definitions                   **
 **                                                                          **
 ****************************************************************************}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	TCEUrlOptions 				= SInt32;
CONST
	kCEUrlOptionNone			= 0;
	kCEUrlOptionUseMap			= 1;


TYPE
	TCEUrlDataPtr = ^TCEUrlData;
	TCEUrlData = RECORD
		url:					CStringPtr;
		description:			CStringPtr;
		options:				TCEUrlOptions;
	END;

	{	*****************************************************************************
	 **                                                                          **
	 **                     Custom URL Element Functions                         **
	 **                                                                          **
	 ****************************************************************************	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  CEUrlElement_SetData()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION CEUrlElement_SetData(object: TQ3Object; VAR urlData: TCEUrlData): TQ3Status; C;

{
 *  CEUrlElement_GetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CEUrlElement_GetData(object: TQ3Object; VAR urlData: UNIV Ptr): TQ3Status; C;

{
 *  CEUrlElement_EmptyData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CEUrlElement_EmptyData(VAR urlData: UNIV Ptr): TQ3Status; C;

{*****************************************************************************
 **                                                                          **
 **                         Wire Data Definitions                            **
 **                                                                          **
 ****************************************************************************}

{*****************************************************************************
 **                                                                          **
 **                     Wire Custom Element Functions                        **
 **                                                                          **
 ****************************************************************************}
{
 *  CEWireElement_SetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CEWireElement_SetData(object: TQ3Object; wireData: QTAtomContainer): TQ3Status; C;

{
 *  CEWireElement_GetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CEWireElement_GetData(object: TQ3Object; VAR wireData: QTAtomContainer): TQ3Status; C;

{
 *  CEWireElement_EmptyData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CEWireElement_EmptyData(VAR wireData: QTAtomContainer): TQ3Status; C;



{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DCustomElementsIncludes}

{$ENDC} {__QD3DCUSTOMELEMENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
