/******************************************************************************
 **																			 **
 ** 	Module:		QD3DStyle.h												 **
 ** 																		 **
 ** 																		 **
 ** 	Purpose: 	Style types and routines		 						 **
 ** 																		 **
 ** 																		 **
 ** 																		 **
 ** 	Copyright (C) 1992-1995 Apple Computer, Inc.  All rights reserved.	 **
 ** 																		 **
 ** 																		 **
 *****************************************************************************/
#ifndef QD3DStyle_h
#define QD3DStyle_h

#ifndef QD3D_h
#include <QD3D.h>
#endif  /*  QD3D_h  */

#if PRAGMA_ONCE
	#pragma once
#endif

#if defined(__MWERKS__)
	#pragma enumsalwaysint on
	#pragma align_array_members off
	#pragma options align=native
#endif

#ifdef __cplusplus
extern "C" {
#endif	/* __cplusplus */


/******************************************************************************
 **																			 **
 **					Style Base Class Routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ObjectType Q3Style_GetType(
	TQ3StyleObject			style);

QD3D_EXPORT TQ3Status Q3Style_Submit(
	TQ3StyleObject			style, 
	TQ3ViewObject			view);


/******************************************************************************
 **																			 **
 **								 Subdivision								 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3SubdivisionMethod {
	kQ3SubdivisionMethodConstant,
	kQ3SubdivisionMethodWorldSpace,
	kQ3SubdivisionMethodScreenSpace
} TQ3SubdivisionMethod;

 
typedef struct TQ3SubdivisionStyleData {
	TQ3SubdivisionMethod			method;
	float							c1;
	float							c2;
} TQ3SubdivisionStyleData;


QD3D_EXPORT TQ3StyleObject Q3SubdivisionStyle_New(
	const TQ3SubdivisionStyleData	*data);

QD3D_EXPORT TQ3Status Q3SubdivisionStyle_Submit(
	const TQ3SubdivisionStyleData	*data,
	TQ3ViewObject					view);

QD3D_EXPORT TQ3Status Q3SubdivisionStyle_SetData(
	TQ3StyleObject					subdiv,
	const TQ3SubdivisionStyleData	*data);

QD3D_EXPORT TQ3Status Q3SubdivisionStyle_GetData(
	TQ3StyleObject					subdiv,
	TQ3SubdivisionStyleData			*data);


/******************************************************************************
 **																			 **
 **								Pick ID										 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3StyleObject Q3PickIDStyle_New(
	unsigned long			id);
	
QD3D_EXPORT TQ3Status Q3PickIDStyle_Submit(
	unsigned long			id,
	TQ3ViewObject			view);

QD3D_EXPORT TQ3Status Q3PickIDStyle_Get(
	TQ3StyleObject			pickIDObject,
	unsigned long			*id);

QD3D_EXPORT TQ3Status Q3PickIDStyle_Set(
	TQ3StyleObject			pickIDObject,
	unsigned long			id);
	
	
/******************************************************************************
 **																			 **
 **								Pick Parts									 **
 **																			 **
 *****************************************************************************/
 
typedef enum TQ3PickPartsMasks {
	kQ3PickPartsObject		= 0,
	kQ3PickPartsMaskFace	= 1 << 0,
	kQ3PickPartsMaskEdge	= 1 << 1,
	kQ3PickPartsMaskVertex	= 1 << 2
} TQ3PickPartsMasks;

typedef unsigned long TQ3PickParts;

QD3D_EXPORT TQ3StyleObject Q3PickPartsStyle_New(
	TQ3PickParts			parts);
	
QD3D_EXPORT TQ3Status Q3PickPartsStyle_Submit(
	TQ3PickParts			parts,
	TQ3ViewObject			view);

QD3D_EXPORT TQ3Status Q3PickPartsStyle_Get(
	TQ3StyleObject			pickPartsObject,
	TQ3PickParts			*parts);

QD3D_EXPORT TQ3Status Q3PickPartsStyle_Set(
	TQ3StyleObject			pickPartsObject,
	TQ3PickParts			parts);


/******************************************************************************
 **																			 **
 **						Receive Shadows										 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3StyleObject Q3ReceiveShadowsStyle_New(
	TQ3Boolean				receives);
	
QD3D_EXPORT TQ3Status Q3ReceiveShadowsStyle_Submit(
	TQ3Boolean				receives,
	TQ3ViewObject			view);

QD3D_EXPORT TQ3Status Q3ReceiveShadowsStyle_Get(
	TQ3StyleObject			styleObject,
	TQ3Boolean				*receives);

QD3D_EXPORT TQ3Status Q3ReceiveShadowsStyle_Set(
	TQ3StyleObject			styleObject,
	TQ3Boolean				receives);


/******************************************************************************
 **																			 **
 **							Fill Styles										 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3FillStyle {
	kQ3FillStyleFilled,
	kQ3FillStyleEdges,
	kQ3FillStylePoints
} TQ3FillStyle;


QD3D_EXPORT TQ3StyleObject Q3FillStyle_New(
	TQ3FillStyle 			fillStyle);

QD3D_EXPORT TQ3Status Q3FillStyle_Submit(
	TQ3FillStyle 			fillStyle,
	TQ3ViewObject 			view);

QD3D_EXPORT TQ3Status Q3FillStyle_Get(
	TQ3StyleObject			styleObject,
	TQ3FillStyle			*fillStyle);

QD3D_EXPORT TQ3Status Q3FillStyle_Set(
	TQ3StyleObject			styleObject,
	TQ3FillStyle			fillStyle);
	
	
/******************************************************************************
 **																			 **
 **							Backfacing Styles								 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3BackfacingStyle {
	kQ3BackfacingStyleBoth,
	kQ3BackfacingStyleRemove,
	kQ3BackfacingStyleFlip
} TQ3BackfacingStyle;

QD3D_EXPORT TQ3StyleObject Q3BackfacingStyle_New(
	TQ3BackfacingStyle		backfacingStyle);

QD3D_EXPORT TQ3Status Q3BackfacingStyle_Submit(
	TQ3BackfacingStyle		backfacingStyle,
	TQ3ViewObject			view);

QD3D_EXPORT TQ3Status Q3BackfacingStyle_Get(
	TQ3StyleObject			backfacingObject,
	TQ3BackfacingStyle		*backfacingStyle);

QD3D_EXPORT TQ3Status Q3BackfacingStyle_Set(
	TQ3StyleObject			backfacingObject,
	TQ3BackfacingStyle		backfacingStyle);


/******************************************************************************
 **																			 **
 **							Interpolation Types								 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3InterpolationStyle {
	kQ3InterpolationStyleNone,
	kQ3InterpolationStyleVertex,
	kQ3InterpolationStylePixel
} TQ3InterpolationStyle;

QD3D_EXPORT TQ3StyleObject Q3InterpolationStyle_New(
	TQ3InterpolationStyle	interpolationStyle);

QD3D_EXPORT TQ3Status Q3InterpolationStyle_Submit(
	TQ3InterpolationStyle 	interpolationStyle,
	TQ3ViewObject			view);

QD3D_EXPORT TQ3Status Q3InterpolationStyle_Get(
	TQ3StyleObject			interpolationObject,
	TQ3InterpolationStyle	*interpolationStyle);

QD3D_EXPORT TQ3Status Q3InterpolationStyle_Set(
	TQ3StyleObject			interpolationObject,
	TQ3InterpolationStyle	interpolationStyle);


/******************************************************************************
 **																			 **
 **								Highlight Style								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3StyleObject Q3HighlightStyle_New(
	TQ3AttributeSet			highlightAttribute);
	
QD3D_EXPORT TQ3Status Q3HighlightStyle_Submit(
	TQ3AttributeSet			highlightAttribute,
	TQ3ViewObject			view);

QD3D_EXPORT TQ3Status Q3HighlightStyle_Get(
	TQ3StyleObject			highlight,
	TQ3AttributeSet			*highlightAttribute);

QD3D_EXPORT TQ3Status Q3HighlightStyle_Set(
	TQ3StyleObject			highlight,
	TQ3AttributeSet			highlightAttribute);


/******************************************************************************
 **																			 **
 **							FrontFacing Direction Styles					 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3OrientationStyle{
	kQ3OrientationStyleCounterClockwise,
	kQ3OrientationStyleClockwise
} TQ3OrientationStyle;

QD3D_EXPORT TQ3StyleObject Q3OrientationStyle_New(
	TQ3OrientationStyle		frontFacingDirection);

QD3D_EXPORT TQ3Status Q3OrientationStyle_Submit(
	TQ3OrientationStyle		frontFacingDirection,
	TQ3ViewObject			view);

QD3D_EXPORT TQ3Status Q3OrientationStyle_Get(
	TQ3StyleObject			frontFacingDirectionObject,
	TQ3OrientationStyle		*frontFacingDirection);

QD3D_EXPORT TQ3Status Q3OrientationStyle_Set(
	TQ3StyleObject			frontFacingDirectionObject,
	TQ3OrientationStyle		frontFacingDirection);


#ifdef __cplusplus
}
#endif	/* __cplusplus */

#if defined(__MWERKS__)
#pragma options align=reset
#pragma enumsalwaysint reset
#endif

#endif  /*  QD3DStyle_h  */
