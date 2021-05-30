{
     File:       QD3DStyle.p
 
     Contains:   Q3Style types and routines
 
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
 UNIT QD3DStyle;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DSTYLE__}
{$SETC __QD3DSTYLE__ := 1}

{$I+}
{$SETC QD3DStyleIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{*****************************************************************************
 **                                                                          **
 **                 Style Base Class Routines                                **
 **                                                                          **
 ****************************************************************************}
{$IFC CALL_NOT_IN_CARBON }
{
 *  Q3Style_GetType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Style_GetType(style: TQ3StyleObject): TQ3ObjectType; C;

{
 *  Q3Style_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Style_Submit(style: TQ3StyleObject; view: TQ3ViewObject): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                              Subdivision                                 **
 **                                                                          **
 ****************************************************************************}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	TQ3SubdivisionMethod 		= SInt32;
CONST
	kQ3SubdivisionMethodConstant = 0;
	kQ3SubdivisionMethodWorldSpace = 1;
	kQ3SubdivisionMethodScreenSpace = 2;



TYPE
	TQ3SubdivisionStyleDataPtr = ^TQ3SubdivisionStyleData;
	TQ3SubdivisionStyleData = RECORD
		method:					TQ3SubdivisionMethod;
		c1:						Single;
		c2:						Single;
	END;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3SubdivisionStyle_New()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3SubdivisionStyle_New({CONST}VAR data: TQ3SubdivisionStyleData): TQ3StyleObject; C;

{
 *  Q3SubdivisionStyle_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3SubdivisionStyle_Submit({CONST}VAR data: TQ3SubdivisionStyleData; view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3SubdivisionStyle_SetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3SubdivisionStyle_SetData(subdiv: TQ3StyleObject; {CONST}VAR data: TQ3SubdivisionStyleData): TQ3Status; C;

{
 *  Q3SubdivisionStyle_GetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3SubdivisionStyle_GetData(subdiv: TQ3StyleObject; VAR data: TQ3SubdivisionStyleData): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                             Pick ID                                      **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3PickIDStyle_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3PickIDStyle_New(id: UInt32): TQ3StyleObject; C;

{
 *  Q3PickIDStyle_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3PickIDStyle_Submit(id: UInt32; view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3PickIDStyle_Get()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3PickIDStyle_Get(pickIDObject: TQ3StyleObject; VAR id: UInt32): TQ3Status; C;

{
 *  Q3PickIDStyle_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3PickIDStyle_Set(pickIDObject: TQ3StyleObject; id: UInt32): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                             Pick Parts                                   **
 **                                                                          **
 ****************************************************************************}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	TQ3PickPartsMasks 			= SInt32;
CONST
	kQ3PickPartsObject			= 0;
	kQ3PickPartsMaskFace		= $01;
	kQ3PickPartsMaskEdge		= $02;
	kQ3PickPartsMaskVertex		= $04;


TYPE
	TQ3PickParts						= UInt32;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3PickPartsStyle_New()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3PickPartsStyle_New(parts: TQ3PickParts): TQ3StyleObject; C;

{
 *  Q3PickPartsStyle_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3PickPartsStyle_Submit(parts: TQ3PickParts; view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3PickPartsStyle_Get()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3PickPartsStyle_Get(pickPartsObject: TQ3StyleObject; VAR parts: TQ3PickParts): TQ3Status; C;

{
 *  Q3PickPartsStyle_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3PickPartsStyle_Set(pickPartsObject: TQ3StyleObject; parts: TQ3PickParts): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                     Receive Shadows                                      **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ReceiveShadowsStyle_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ReceiveShadowsStyle_New(receives: TQ3Boolean): TQ3StyleObject; C;

{
 *  Q3ReceiveShadowsStyle_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ReceiveShadowsStyle_Submit(receives: TQ3Boolean; view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3ReceiveShadowsStyle_Get()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ReceiveShadowsStyle_Get(styleObject: TQ3StyleObject; VAR receives: TQ3Boolean): TQ3Status; C;

{
 *  Q3ReceiveShadowsStyle_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ReceiveShadowsStyle_Set(styleObject: TQ3StyleObject; receives: TQ3Boolean): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         Fill Styles                                      **
 **                                                                          **
 ****************************************************************************}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	TQ3FillStyle 				= SInt32;
CONST
	kQ3FillStyleFilled			= 0;
	kQ3FillStyleEdges			= 1;
	kQ3FillStylePoints			= 2;


{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3FillStyle_New()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3FillStyle_New(fillStyle: TQ3FillStyle): TQ3StyleObject; C;

{
 *  Q3FillStyle_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3FillStyle_Submit(fillStyle: TQ3FillStyle; view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3FillStyle_Get()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3FillStyle_Get(styleObject: TQ3StyleObject; VAR fillStyle: TQ3FillStyle): TQ3Status; C;

{
 *  Q3FillStyle_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3FillStyle_Set(styleObject: TQ3StyleObject; fillStyle: TQ3FillStyle): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         Backfacing Styles                                **
 **                                                                          **
 ****************************************************************************}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	TQ3BackfacingStyle 			= SInt32;
CONST
	kQ3BackfacingStyleBoth		= 0;
	kQ3BackfacingStyleRemove	= 1;
	kQ3BackfacingStyleFlip		= 2;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3BackfacingStyle_New()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3BackfacingStyle_New(backfacingStyle: TQ3BackfacingStyle): TQ3StyleObject; C;

{
 *  Q3BackfacingStyle_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3BackfacingStyle_Submit(backfacingStyle: TQ3BackfacingStyle; view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3BackfacingStyle_Get()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3BackfacingStyle_Get(backfacingObject: TQ3StyleObject; VAR backfacingStyle: TQ3BackfacingStyle): TQ3Status; C;

{
 *  Q3BackfacingStyle_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3BackfacingStyle_Set(backfacingObject: TQ3StyleObject; backfacingStyle: TQ3BackfacingStyle): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         Interpolation Types                              **
 **                                                                          **
 ****************************************************************************}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	TQ3InterpolationStyle 		= SInt32;
CONST
	kQ3InterpolationStyleNone	= 0;
	kQ3InterpolationStyleVertex	= 1;
	kQ3InterpolationStylePixel	= 2;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3InterpolationStyle_New()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3InterpolationStyle_New(interpolationStyle: TQ3InterpolationStyle): TQ3StyleObject; C;

{
 *  Q3InterpolationStyle_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3InterpolationStyle_Submit(interpolationStyle: TQ3InterpolationStyle; view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3InterpolationStyle_Get()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3InterpolationStyle_Get(interpolationObject: TQ3StyleObject; VAR interpolationStyle: TQ3InterpolationStyle): TQ3Status; C;

{
 *  Q3InterpolationStyle_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3InterpolationStyle_Set(interpolationObject: TQ3StyleObject; interpolationStyle: TQ3InterpolationStyle): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                             Highlight Style                              **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3HighlightStyle_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3HighlightStyle_New(highlightAttribute: TQ3AttributeSet): TQ3StyleObject; C;

{
 *  Q3HighlightStyle_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3HighlightStyle_Submit(highlightAttribute: TQ3AttributeSet; view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3HighlightStyle_Get()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3HighlightStyle_Get(highlight: TQ3StyleObject; VAR highlightAttribute: TQ3AttributeSet): TQ3Status; C;

{
 *  Q3HighlightStyle_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3HighlightStyle_Set(highlight: TQ3StyleObject; highlightAttribute: TQ3AttributeSet): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         FrontFacing Direction Styles                     **
 **                                                                          **
 ****************************************************************************}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	TQ3OrientationStyle 		= SInt32;
CONST
	kQ3OrientationStyleCounterClockwise = 0;
	kQ3OrientationStyleClockwise = 1;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3OrientationStyle_New()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3OrientationStyle_New(frontFacingDirection: TQ3OrientationStyle): TQ3StyleObject; C;

{
 *  Q3OrientationStyle_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3OrientationStyle_Submit(frontFacingDirection: TQ3OrientationStyle; view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3OrientationStyle_Get()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3OrientationStyle_Get(frontFacingDirectionObject: TQ3StyleObject; VAR frontFacingDirection: TQ3OrientationStyle): TQ3Status; C;

{
 *  Q3OrientationStyle_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3OrientationStyle_Set(frontFacingDirectionObject: TQ3StyleObject; frontFacingDirection: TQ3OrientationStyle): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                             AntiAlias Style                              **
 **                                                                          **
 ****************************************************************************}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	TQ3AntiAliasModeMasks 		= SInt32;
CONST
	kQ3AntiAliasModeMaskEdges	= $01;
	kQ3AntiAliasModeMaskFilled	= $02;


TYPE
	TQ3AntiAliasMode					= UInt32;
	TQ3AntiAliasStyleDataPtr = ^TQ3AntiAliasStyleData;
	TQ3AntiAliasStyleData = RECORD
		state:					TQ3Switch;
		mode:					TQ3AntiAliasMode;
		quality:				Single;
	END;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3AntiAliasStyle_New()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3AntiAliasStyle_New({CONST}VAR data: TQ3AntiAliasStyleData): TQ3StyleObject; C;

{
 *  Q3AntiAliasStyle_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3AntiAliasStyle_Submit({CONST}VAR data: TQ3AntiAliasStyleData; view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3AntiAliasStyle_GetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3AntiAliasStyle_GetData(styleObject: TQ3StyleObject; VAR data: TQ3AntiAliasStyleData): TQ3Status; C;

{
 *  Q3AntiAliasStyle_SetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3AntiAliasStyle_SetData(styleObject: TQ3StyleObject; {CONST}VAR data: TQ3AntiAliasStyleData): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                                 Fog Style                                **
 **                                                                          **
 ****************************************************************************}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	TQ3FogMode 					= SInt32;
CONST
	kQ3FogModeLinear			= 0;
	kQ3FogModeExponential		= 1;
	kQ3FogModeExponentialSquared = 2;
	kQ3FogModeAlpha				= 3;


TYPE
	TQ3FogStyleDataPtr = ^TQ3FogStyleData;
	TQ3FogStyleData = RECORD
		state:					TQ3Switch;
		mode:					TQ3FogMode;
		fogStart:				Single;
		fogEnd:					Single;
		density:				Single;
		color:					TQ3ColorARGB;
	END;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3FogStyle_New()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3FogStyle_New({CONST}VAR data: TQ3FogStyleData): TQ3StyleObject; C;

{
 *  Q3FogStyle_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3FogStyle_Submit({CONST}VAR data: TQ3FogStyleData; view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3FogStyle_GetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3FogStyle_GetData(styleObject: TQ3StyleObject; VAR data: TQ3FogStyleData): TQ3Status; C;

{
 *  Q3FogStyle_SetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3FogStyle_SetData(styleObject: TQ3StyleObject; {CONST}VAR data: TQ3FogStyleData): TQ3Status; C;




{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DStyleIncludes}

{$ENDC} {__QD3DSTYLE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
