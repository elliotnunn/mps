/******************************************************************************
 **																			 **
 ** 	Module:		QD3DLight.h											 	 **
 ** 																		 **
 ** 																		 **
 ** 																		 **
 ** 	Purpose: 	Generic light routines								 	 **
 ** 																		 **
 ** 																		 **
 ** 	Copyright (C) 1991-1994 Apple Computer, Inc. All rights reserved.	 **	
 ** 																		 **
 **																			 **
 *****************************************************************************/
#ifndef QD3DLight_h
#define QD3DLight_h

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
 **							Enum Definitions								 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3AttenuationType {
	kQ3AttenuationTypeNone,
	kQ3AttenuationTypeInverseDistance,
	kQ3AttenuationTypeInverseDistanceSquared
} TQ3AttenuationType;


typedef enum TQ3FallOffType {
	kQ3FallOffTypeNone,
	kQ3FallOffTypeLinear,
	kQ3FallOffTypeExponential,
	kQ3FallOffTypeCosine
} TQ3FallOffType;


/******************************************************************************
 **																			 **
 **							Data Structure Definitions						 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3LightData {
	TQ3Boolean			isOn;
	float				brightness;
	TQ3ColorRGB			color;
} TQ3LightData;

typedef struct TQ3DirectionalLightData {
	TQ3LightData		lightData;
	TQ3Boolean			castsShadows;
	TQ3Vector3D			direction;
} TQ3DirectionalLightData;

typedef struct TQ3PointLightData {
	TQ3LightData		lightData;
	TQ3Boolean			castsShadows;
	TQ3AttenuationType	attenuation;
	TQ3Point3D			location;
} TQ3PointLightData;

typedef struct TQ3SpotLightData {
	TQ3LightData		lightData;
	TQ3Boolean			castsShadows;
	TQ3AttenuationType	attenuation;
	TQ3Point3D			location;
	TQ3Vector3D			direction;
	float				hotAngle;
	float				outerAngle;
	TQ3FallOffType		fallOff;
} TQ3SpotLightData;


/******************************************************************************
 **																			 **
 **					Light routines (apply to all TQ3LightObjects)		     **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ObjectType Q3Light_GetType(
	TQ3LightObject		light);

QD3D_EXPORT TQ3Status Q3Light_GetState(
	TQ3LightObject		light,
	TQ3Boolean			*isOn);
				
QD3D_EXPORT TQ3Status Q3Light_GetBrightness(
	TQ3LightObject		light,
	float				*brightness);
	
QD3D_EXPORT TQ3Status Q3Light_GetColor(
	TQ3LightObject		light,
	TQ3ColorRGB			*color);
	
QD3D_EXPORT TQ3Status Q3Light_SetState(
	TQ3LightObject		light,
	TQ3Boolean			isOn);
				
QD3D_EXPORT TQ3Status Q3Light_SetBrightness(
	TQ3LightObject		light,
	float				brightness);
	
QD3D_EXPORT TQ3Status Q3Light_SetColor(
	TQ3LightObject		light,
	const TQ3ColorRGB	*color);

QD3D_EXPORT TQ3Status Q3Light_GetData(
	TQ3LightObject		light,
	TQ3LightData		*lightData);

QD3D_EXPORT TQ3Status Q3Light_SetData(
	TQ3LightObject		light,
	const TQ3LightData	*lightData);
	

/******************************************************************************
 **																			 **
 **							Specific Light Routines					 	 	 **
 **																			 **
 *****************************************************************************/

/******************************************************************************
 **																			 **
 **							Ambient Light							 	 	 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3LightObject Q3AmbientLight_New(
	const TQ3LightData				*lightData);

QD3D_EXPORT TQ3Status Q3AmbientLight_GetData(
	TQ3LightObject					light,
	TQ3LightData					*lightData);

QD3D_EXPORT TQ3Status Q3AmbientLight_SetData(
	TQ3LightObject					light,
	const TQ3LightData				*lightData);


/******************************************************************************
 **																			 **
 **						Directional Light									 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3LightObject Q3DirectionalLight_New(
	const TQ3DirectionalLightData	*directionalLightData);
	
QD3D_EXPORT TQ3Status Q3DirectionalLight_GetCastShadowsState(
	TQ3LightObject					light,
	TQ3Boolean						*castsShadows);
	
QD3D_EXPORT TQ3Status Q3DirectionalLight_GetDirection(
	TQ3LightObject					light,
	TQ3Vector3D						*direction);
	
QD3D_EXPORT TQ3Status Q3DirectionalLight_SetCastShadowsState(
	TQ3LightObject					light,
	TQ3Boolean						castsShadows);
	
QD3D_EXPORT TQ3Status Q3DirectionalLight_SetDirection(
	TQ3LightObject					light,
	const TQ3Vector3D				*direction);

QD3D_EXPORT TQ3Status Q3DirectionalLight_GetData(
	TQ3LightObject					light,
	TQ3DirectionalLightData			*directionalLightData);

QD3D_EXPORT TQ3Status Q3DirectionalLight_SetData(
	TQ3LightObject					light,
	const TQ3DirectionalLightData	*directionalLightData);


/******************************************************************************
 **																			 **
 **						Point Light									 		 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3LightObject Q3PointLight_New(
	const TQ3PointLightData			*pointLightData);

QD3D_EXPORT TQ3Status Q3PointLight_GetCastShadowsState(
	TQ3LightObject					light,
	TQ3Boolean						*castsShadows);
	
QD3D_EXPORT TQ3Status Q3PointLight_GetAttenuation(
	TQ3LightObject					light,
	TQ3AttenuationType				*attenuation);
	
QD3D_EXPORT TQ3Status Q3PointLight_GetLocation(
	TQ3LightObject					light,
	TQ3Point3D						*location);

QD3D_EXPORT TQ3Status Q3PointLight_GetData(
	TQ3LightObject					light,
	TQ3PointLightData				*pointLightData);
	
QD3D_EXPORT TQ3Status Q3PointLight_SetCastShadowsState(
	TQ3LightObject					light,
	TQ3Boolean						castsShadows);
	
QD3D_EXPORT TQ3Status Q3PointLight_SetAttenuation(
	TQ3LightObject					light,
	TQ3AttenuationType				attenuation);
	
QD3D_EXPORT TQ3Status Q3PointLight_SetLocation(
	TQ3LightObject					light,
	const TQ3Point3D				*location);

QD3D_EXPORT TQ3Status Q3PointLight_SetData(
	TQ3LightObject					light,
	const TQ3PointLightData			*pointLightData);
	

/******************************************************************************
 **																			 **
 **						Spot Light									 		 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3LightObject Q3SpotLight_New(
	const TQ3SpotLightData			*spotLightData);

QD3D_EXPORT TQ3Status Q3SpotLight_GetCastShadowsState(
	TQ3LightObject					light,
	TQ3Boolean						*castsShadows);
	
QD3D_EXPORT TQ3Status Q3SpotLight_GetAttenuation(
	TQ3LightObject					light,
	TQ3AttenuationType				*attenuation);
	
QD3D_EXPORT TQ3Status Q3SpotLight_GetLocation(
	TQ3LightObject					light,
	TQ3Point3D						*location);
		
QD3D_EXPORT TQ3Status Q3SpotLight_GetDirection(
	TQ3LightObject					light,
	TQ3Vector3D						*direction);
		
QD3D_EXPORT TQ3Status Q3SpotLight_GetHotAngle(
	TQ3LightObject					light,
	float							*hotAngle);
		
QD3D_EXPORT TQ3Status Q3SpotLight_GetOuterAngle(
	TQ3LightObject					light,
	float							*outerAngle);
		
QD3D_EXPORT TQ3Status Q3SpotLight_GetFallOff(
	TQ3LightObject					light,
	TQ3FallOffType					*fallOff);

QD3D_EXPORT TQ3Status Q3SpotLight_GetData(
	TQ3LightObject					light,
	TQ3SpotLightData				*spotLightData);

QD3D_EXPORT TQ3Status Q3SpotLight_SetCastShadowsState(
	TQ3LightObject					light,
	TQ3Boolean						castsShadows);
	
QD3D_EXPORT TQ3Status Q3SpotLight_SetAttenuation(
	TQ3LightObject					light,
	TQ3AttenuationType				attenuation);
	
QD3D_EXPORT TQ3Status Q3SpotLight_SetLocation(
	TQ3LightObject					light,
	const TQ3Point3D				*location);

QD3D_EXPORT TQ3Status Q3SpotLight_SetDirection(
	TQ3LightObject					light,
	const TQ3Vector3D				*direction);

QD3D_EXPORT TQ3Status Q3SpotLight_SetHotAngle(
	TQ3LightObject					light,
	float							hotAngle);
		
QD3D_EXPORT TQ3Status Q3SpotLight_SetOuterAngle(
	TQ3LightObject					light,
	float							outerAngle);
		
QD3D_EXPORT TQ3Status Q3SpotLight_SetFallOff(
	TQ3LightObject					light,
	TQ3FallOffType					fallOff);

QD3D_EXPORT TQ3Status Q3SpotLight_SetData(
	TQ3LightObject					light,
	const TQ3SpotLightData			*spotLightData);


#ifdef __cplusplus
}
#endif	/* __cplusplus */

#if defined(__MWERKS__)
#pragma options align=reset
#pragma enumsalwaysint reset
#endif

#endif  /*  QD3DLight_h  */
