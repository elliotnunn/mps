{
 	File:		QD3DStyle.p
 
 	Contains:	Style types and routines		 								
 
 	Version:	Technology:	Quickdraw 3D 1.0.6
 				Release:	Universal Interfaces 2.1.5
 
 	Copyright:	© 1984-1997 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
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

{
*****************************************************************************
 **																			 **
 **					Style Base Class Routines								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Style_GetType(style: TQ3StyleObject): TQ3ObjectType; C;
FUNCTION Q3Style_Submit(style: TQ3StyleObject; view: TQ3ViewObject): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **								 Subdivision								 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3SubdivisionMethod 		= LONGINT;
CONST
	kQ3SubdivisionMethodConstant = {TQ3SubdivisionMethod}0;
	kQ3SubdivisionMethodWorldSpace = {TQ3SubdivisionMethod}1;
	kQ3SubdivisionMethodScreenSpace = {TQ3SubdivisionMethod}2;


TYPE
	TQ3SubdivisionStyleDataPtr = ^TQ3SubdivisionStyleData;
	TQ3SubdivisionStyleData = RECORD
		method:					TQ3SubdivisionMethod;
		c1:						Single;
		c2:						Single;
	END;

FUNCTION Q3SubdivisionStyle_New({CONST}VAR data: TQ3SubdivisionStyleData): TQ3StyleObject; C;
FUNCTION Q3SubdivisionStyle_Submit({CONST}VAR data: TQ3SubdivisionStyleData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3SubdivisionStyle_SetData(subdiv: TQ3StyleObject; {CONST}VAR data: TQ3SubdivisionStyleData): TQ3Status; C;
FUNCTION Q3SubdivisionStyle_GetData(subdiv: TQ3StyleObject; VAR data: TQ3SubdivisionStyleData): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **								Pick ID										 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3PickIDStyle_New(id: LONGINT): TQ3StyleObject; C;
FUNCTION Q3PickIDStyle_Submit(id: LONGINT; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3PickIDStyle_Get(pickIDObject: TQ3StyleObject; VAR id: LONGINT): TQ3Status; C;
FUNCTION Q3PickIDStyle_Set(pickIDObject: TQ3StyleObject; id: LONGINT): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **								Pick Parts									 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3PickPartsMasks 			= LONGINT;
CONST
	kQ3PickPartsObject			= {TQ3PickPartsMasks}0;
	kQ3PickPartsMaskFace		= {TQ3PickPartsMasks}$01;
	kQ3PickPartsMaskEdge		= {TQ3PickPartsMasks}$02;
	kQ3PickPartsMaskVertex		= {TQ3PickPartsMasks}$04;


TYPE
	TQ3PickParts						= LONGINT;
FUNCTION Q3PickPartsStyle_New(parts: TQ3PickParts): TQ3StyleObject; C;
FUNCTION Q3PickPartsStyle_Submit(parts: TQ3PickParts; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3PickPartsStyle_Get(pickPartsObject: TQ3StyleObject; VAR parts: TQ3PickParts): TQ3Status; C;
FUNCTION Q3PickPartsStyle_Set(pickPartsObject: TQ3StyleObject; parts: TQ3PickParts): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **						Receive Shadows										 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3ReceiveShadowsStyle_New(receives: TQ3Boolean): TQ3StyleObject; C;
FUNCTION Q3ReceiveShadowsStyle_Submit(receives: TQ3Boolean; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3ReceiveShadowsStyle_Get(styleObject: TQ3StyleObject; VAR receives: TQ3Boolean): TQ3Status; C;
FUNCTION Q3ReceiveShadowsStyle_Set(styleObject: TQ3StyleObject; receives: TQ3Boolean): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **							Fill Styles										 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3FillStyle 				= LONGINT;
CONST
	kQ3FillStyleFilled			= {TQ3FillStyle}0;
	kQ3FillStyleEdges			= {TQ3FillStyle}1;
	kQ3FillStylePoints			= {TQ3FillStyle}2;

FUNCTION Q3FillStyle_New(fillStyle: TQ3FillStyle): TQ3StyleObject; C;
FUNCTION Q3FillStyle_Submit(fillStyle: TQ3FillStyle; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3FillStyle_Get(styleObject: TQ3StyleObject; VAR fillStyle: TQ3FillStyle): TQ3Status; C;
FUNCTION Q3FillStyle_Set(styleObject: TQ3StyleObject; fillStyle: TQ3FillStyle): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **							Backfacing Styles								 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3BackfacingStyle 			= LONGINT;
CONST
	kQ3BackfacingStyleBoth		= {TQ3BackfacingStyle}0;
	kQ3BackfacingStyleRemove	= {TQ3BackfacingStyle}1;
	kQ3BackfacingStyleFlip		= {TQ3BackfacingStyle}2;

FUNCTION Q3BackfacingStyle_New(backfacingStyle: TQ3BackfacingStyle): TQ3StyleObject; C;
FUNCTION Q3BackfacingStyle_Submit(backfacingStyle: TQ3BackfacingStyle; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3BackfacingStyle_Get(backfacingObject: TQ3StyleObject; VAR backfacingStyle: TQ3BackfacingStyle): TQ3Status; C;
FUNCTION Q3BackfacingStyle_Set(backfacingObject: TQ3StyleObject; backfacingStyle: TQ3BackfacingStyle): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **							Interpolation Types								 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3InterpolationStyle 		= LONGINT;
CONST
	kQ3InterpolationStyleNone	= {TQ3InterpolationStyle}0;
	kQ3InterpolationStyleVertex	= {TQ3InterpolationStyle}1;
	kQ3InterpolationStylePixel	= {TQ3InterpolationStyle}2;

FUNCTION Q3InterpolationStyle_New(interpolationStyle: TQ3InterpolationStyle): TQ3StyleObject; C;
FUNCTION Q3InterpolationStyle_Submit(interpolationStyle: TQ3InterpolationStyle; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3InterpolationStyle_Get(interpolationObject: TQ3StyleObject; VAR interpolationStyle: TQ3InterpolationStyle): TQ3Status; C;
FUNCTION Q3InterpolationStyle_Set(interpolationObject: TQ3StyleObject; interpolationStyle: TQ3InterpolationStyle): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **								Highlight Style								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3HighlightStyle_New(highlightAttribute: TQ3AttributeSet): TQ3StyleObject; C;
FUNCTION Q3HighlightStyle_Submit(highlightAttribute: TQ3AttributeSet; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3HighlightStyle_Get(highlight: TQ3StyleObject; VAR highlightAttribute: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3HighlightStyle_Set(highlight: TQ3StyleObject; highlightAttribute: TQ3AttributeSet): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **							FrontFacing Direction Styles					 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3OrientationStyle 		= LONGINT;
CONST
	kQ3OrientationStyleCounterClockwise = {TQ3OrientationStyle}0;
	kQ3OrientationStyleClockwise = {TQ3OrientationStyle}1;

FUNCTION Q3OrientationStyle_New(frontFacingDirection: TQ3OrientationStyle): TQ3StyleObject; C;
FUNCTION Q3OrientationStyle_Submit(frontFacingDirection: TQ3OrientationStyle; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3OrientationStyle_Get(frontFacingDirectionObject: TQ3StyleObject; VAR frontFacingDirection: TQ3OrientationStyle): TQ3Status; C;
FUNCTION Q3OrientationStyle_Set(frontFacingDirectionObject: TQ3StyleObject; frontFacingDirection: TQ3OrientationStyle): TQ3Status; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DStyleIncludes}

{$ENDC} {__QD3DSTYLE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
