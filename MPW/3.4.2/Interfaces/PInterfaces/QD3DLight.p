{
 	File:		QD3DLight.p
 
 	Contains:	Generic light routines								 			
 
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
 UNIT QD3DLight;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DLIGHT__}
{$SETC __QD3DLIGHT__ := 1}

{$I+}
{$SETC QD3DLightIncludes := UsingIncludes}
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
 **							Enum Definitions								 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3AttenuationType 			= LONGINT;
CONST
	kQ3AttenuationTypeNone		= {TQ3AttenuationType}0;
	kQ3AttenuationTypeInverseDistance = {TQ3AttenuationType}1;
	kQ3AttenuationTypeInverseDistanceSquared = {TQ3AttenuationType}2;


TYPE
	TQ3FallOffType 				= LONGINT;
CONST
	kQ3FallOffTypeNone			= {TQ3FallOffType}0;
	kQ3FallOffTypeLinear		= {TQ3FallOffType}1;
	kQ3FallOffTypeExponential	= {TQ3FallOffType}2;
	kQ3FallOffTypeCosine		= {TQ3FallOffType}3;

{
*****************************************************************************
 **																			 **
 **							Data Structure Definitions						 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3LightDataPtr = ^TQ3LightData;
	TQ3LightData = RECORD
		isOn:					TQ3Boolean;
		brightness:				Single;
		color:					TQ3ColorRGB;
	END;

	TQ3DirectionalLightDataPtr = ^TQ3DirectionalLightData;
	TQ3DirectionalLightData = RECORD
		lightData:				TQ3LightData;
		castsShadows:			TQ3Boolean;
		direction:				TQ3Vector3D;
	END;

	TQ3PointLightDataPtr = ^TQ3PointLightData;
	TQ3PointLightData = RECORD
		lightData:				TQ3LightData;
		castsShadows:			TQ3Boolean;
		attenuation:			TQ3AttenuationType;
		location:				TQ3Point3D;
	END;

	TQ3SpotLightDataPtr = ^TQ3SpotLightData;
	TQ3SpotLightData = RECORD
		lightData:				TQ3LightData;
		castsShadows:			TQ3Boolean;
		attenuation:			TQ3AttenuationType;
		location:				TQ3Point3D;
		direction:				TQ3Vector3D;
		hotAngle:				Single;
		outerAngle:				Single;
		fallOff:				TQ3FallOffType;
	END;

{
*****************************************************************************
 **																			 **
 **					Light routines (apply to all TQ3LightObjects)		     **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Light_GetType(light: TQ3LightObject): TQ3ObjectType; C;
FUNCTION Q3Light_GetState(light: TQ3LightObject; VAR isOn: TQ3Boolean): TQ3Status; C;
FUNCTION Q3Light_GetBrightness(light: TQ3LightObject; VAR brightness: Single): TQ3Status; C;
FUNCTION Q3Light_GetColor(light: TQ3LightObject; VAR color: TQ3ColorRGB): TQ3Status; C;
FUNCTION Q3Light_SetState(light: TQ3LightObject; isOn: TQ3Boolean): TQ3Status; C;
FUNCTION Q3Light_SetBrightness(light: TQ3LightObject; brightness: Single): TQ3Status; C;
FUNCTION Q3Light_SetColor(light: TQ3LightObject; {CONST}VAR color: TQ3ColorRGB): TQ3Status; C;
FUNCTION Q3Light_GetData(light: TQ3LightObject; VAR lightData: TQ3LightData): TQ3Status; C;
FUNCTION Q3Light_SetData(light: TQ3LightObject; {CONST}VAR lightData: TQ3LightData): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **							Specific Light Routines					 	 	 **
 **																			 **
 ****************************************************************************
}
{
*****************************************************************************
 **																			 **
 **							Ambient Light							 	 	 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3AmbientLight_New({CONST}VAR lightData: TQ3LightData): TQ3LightObject; C;
FUNCTION Q3AmbientLight_GetData(light: TQ3LightObject; VAR lightData: TQ3LightData): TQ3Status; C;
FUNCTION Q3AmbientLight_SetData(light: TQ3LightObject; {CONST}VAR lightData: TQ3LightData): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **						Directional Light									 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3DirectionalLight_New({CONST}VAR directionalLightData: TQ3DirectionalLightData): TQ3LightObject; C;
FUNCTION Q3DirectionalLight_GetCastShadowsState(light: TQ3LightObject; VAR castsShadows: TQ3Boolean): TQ3Status; C;
FUNCTION Q3DirectionalLight_GetDirection(light: TQ3LightObject; VAR direction: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3DirectionalLight_SetCastShadowsState(light: TQ3LightObject; castsShadows: TQ3Boolean): TQ3Status; C;
FUNCTION Q3DirectionalLight_SetDirection(light: TQ3LightObject; {CONST}VAR direction: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3DirectionalLight_GetData(light: TQ3LightObject; VAR directionalLightData: TQ3DirectionalLightData): TQ3Status; C;
FUNCTION Q3DirectionalLight_SetData(light: TQ3LightObject; {CONST}VAR directionalLightData: TQ3DirectionalLightData): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **						Point Light									 		 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3PointLight_New({CONST}VAR pointLightData: TQ3PointLightData): TQ3LightObject; C;
FUNCTION Q3PointLight_GetCastShadowsState(light: TQ3LightObject; VAR castsShadows: TQ3Boolean): TQ3Status; C;
FUNCTION Q3PointLight_GetAttenuation(light: TQ3LightObject; VAR attenuation: TQ3AttenuationType): TQ3Status; C;
FUNCTION Q3PointLight_GetLocation(light: TQ3LightObject; VAR location: TQ3Point3D): TQ3Status; C;
FUNCTION Q3PointLight_GetData(light: TQ3LightObject; VAR pointLightData: TQ3PointLightData): TQ3Status; C;
FUNCTION Q3PointLight_SetCastShadowsState(light: TQ3LightObject; castsShadows: TQ3Boolean): TQ3Status; C;
FUNCTION Q3PointLight_SetAttenuation(light: TQ3LightObject; attenuation: TQ3AttenuationType): TQ3Status; C;
FUNCTION Q3PointLight_SetLocation(light: TQ3LightObject; {CONST}VAR location: TQ3Point3D): TQ3Status; C;
FUNCTION Q3PointLight_SetData(light: TQ3LightObject; {CONST}VAR pointLightData: TQ3PointLightData): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **						Spot Light									 		 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3SpotLight_New({CONST}VAR spotLightData: TQ3SpotLightData): TQ3LightObject; C;
FUNCTION Q3SpotLight_GetCastShadowsState(light: TQ3LightObject; VAR castsShadows: TQ3Boolean): TQ3Status; C;
FUNCTION Q3SpotLight_GetAttenuation(light: TQ3LightObject; VAR attenuation: TQ3AttenuationType): TQ3Status; C;
FUNCTION Q3SpotLight_GetLocation(light: TQ3LightObject; VAR location: TQ3Point3D): TQ3Status; C;
FUNCTION Q3SpotLight_GetDirection(light: TQ3LightObject; VAR direction: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3SpotLight_GetHotAngle(light: TQ3LightObject; VAR hotAngle: Single): TQ3Status; C;
FUNCTION Q3SpotLight_GetOuterAngle(light: TQ3LightObject; VAR outerAngle: Single): TQ3Status; C;
FUNCTION Q3SpotLight_GetFallOff(light: TQ3LightObject; VAR fallOff: TQ3FallOffType): TQ3Status; C;
FUNCTION Q3SpotLight_GetData(light: TQ3LightObject; VAR spotLightData: TQ3SpotLightData): TQ3Status; C;
FUNCTION Q3SpotLight_SetCastShadowsState(light: TQ3LightObject; castsShadows: TQ3Boolean): TQ3Status; C;
FUNCTION Q3SpotLight_SetAttenuation(light: TQ3LightObject; attenuation: TQ3AttenuationType): TQ3Status; C;
FUNCTION Q3SpotLight_SetLocation(light: TQ3LightObject; {CONST}VAR location: TQ3Point3D): TQ3Status; C;
FUNCTION Q3SpotLight_SetDirection(light: TQ3LightObject; {CONST}VAR direction: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3SpotLight_SetHotAngle(light: TQ3LightObject; hotAngle: Single): TQ3Status; C;
FUNCTION Q3SpotLight_SetOuterAngle(light: TQ3LightObject; outerAngle: Single): TQ3Status; C;
FUNCTION Q3SpotLight_SetFallOff(light: TQ3LightObject; fallOff: TQ3FallOffType): TQ3Status; C;
FUNCTION Q3SpotLight_SetData(light: TQ3LightObject; {CONST}VAR spotLightData: TQ3SpotLightData): TQ3Status; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DLightIncludes}

{$ENDC} {__QD3DLIGHT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
