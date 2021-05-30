/******************************************************************************
 **																			 **
 ** 	Module:		QD3DShader.h											 **
 **																			 **
 **																			 **
 ** 	Purpose: 	QuickDraw 3D Shader / Color Routines					 **
 **																			 **
 **																			 **
 **																			 **
 ** 	Copyright (C) 1991-1995 Apple Computer, Inc. All rights reserved.	 **
 **																			 **
 **																			 **
 *****************************************************************************/
#ifndef QD3DShader_h
#define QD3DShader_h

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
 **								RGB Color routines							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ColorRGB *Q3ColorRGB_Set(
	TQ3ColorRGB			*color,
	float				r,
	float				g,
	float				b);

QD3D_EXPORT TQ3ColorARGB *Q3ColorARGB_Set(
	TQ3ColorARGB		*color,
	float				a,
	float				r,
	float				g,
	float				b);

QD3D_EXPORT TQ3ColorRGB *Q3ColorRGB_Add(
	const TQ3ColorRGB 	*c1, 
	const TQ3ColorRGB 	*c2,
	TQ3ColorRGB			*result);

QD3D_EXPORT TQ3ColorRGB *Q3ColorRGB_Subtract(
	const TQ3ColorRGB 	*c1, 
	const TQ3ColorRGB 	*c2,
	TQ3ColorRGB			*result);

QD3D_EXPORT TQ3ColorRGB *Q3ColorRGB_Scale(
	const TQ3ColorRGB 	*color, 
	float				scale,
	TQ3ColorRGB			*result);

QD3D_EXPORT TQ3ColorRGB *Q3ColorRGB_Clamp(
	const TQ3ColorRGB 	*color,
	TQ3ColorRGB			*result);

QD3D_EXPORT TQ3ColorRGB *Q3ColorRGB_Lerp(
	const TQ3ColorRGB 	*first, 
	const TQ3ColorRGB 	*last, 
	float 				alpha,
	TQ3ColorRGB 		*result);

QD3D_EXPORT TQ3ColorRGB *Q3ColorRGB_Accumulate(
	const TQ3ColorRGB 	*src, 
	TQ3ColorRGB 		*result);

QD3D_EXPORT float *Q3ColorRGB_Luminance(
	const TQ3ColorRGB	*color, 
	float 				*luminance);


/******************************************************************************
 **																			 **
 **								Shader Types								 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3ShaderUVBoundary {
	kQ3ShaderUVBoundaryWrap,
	kQ3ShaderUVBoundaryClamp
} TQ3ShaderUVBoundary;


/******************************************************************************
 **																			 **
 **								Shader Routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ObjectType Q3Shader_GetType(
	TQ3ShaderObject			shader);

QD3D_EXPORT TQ3Status Q3Shader_Submit(
	TQ3ShaderObject			shader, 
	TQ3ViewObject			view);

QD3D_EXPORT TQ3Status Q3Shader_SetUVTransform(
	TQ3ShaderObject			shader,
	const TQ3Matrix3x3		*uvTransform);

QD3D_EXPORT TQ3Status Q3Shader_GetUVTransform(
	TQ3ShaderObject			shader,
	TQ3Matrix3x3			*uvTransform);

QD3D_EXPORT TQ3Status Q3Shader_SetUBoundary(
	TQ3ShaderObject			shader,
	TQ3ShaderUVBoundary		uBoundary);

QD3D_EXPORT TQ3Status Q3Shader_SetVBoundary(
	TQ3ShaderObject			shader,
	TQ3ShaderUVBoundary		vBoundary);

QD3D_EXPORT TQ3Status Q3Shader_GetUBoundary(
	TQ3ShaderObject			shader,
	TQ3ShaderUVBoundary		*uBoundary);

QD3D_EXPORT TQ3Status Q3Shader_GetVBoundary(
	TQ3ShaderObject			shader,
	TQ3ShaderUVBoundary		*vBoundary);


/******************************************************************************
 **																			 **
 **							Illumination Shader	Classes						 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ObjectType Q3IlluminationShader_GetType(
	TQ3ShaderObject				shader);

QD3D_EXPORT TQ3ShaderObject Q3PhongIllumination_New(
	void);

QD3D_EXPORT TQ3ShaderObject Q3LambertIllumination_New(
	void);

QD3D_EXPORT TQ3ShaderObject Q3NULLIllumination_New(
	void);


/******************************************************************************
 **																			 **
 **		Texture Shader  - may use any type of Texture. (only 1 type in 1.0)	 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ShaderObject Q3TextureShader_New(
	TQ3TextureObject			texture);

QD3D_EXPORT TQ3Status Q3TextureShader_GetTexture(
	TQ3ShaderObject				shader,
	TQ3TextureObject			*texture);

QD3D_EXPORT TQ3Status Q3TextureShader_SetTexture(
	TQ3ShaderObject				shader,
	TQ3TextureObject			texture);


/******************************************************************************
 **																			 **
 **		Texture Objects - For 1.0, there  is 1 subclass: PixmapTexture.		 **
 **		More subclasses will be added in later releases.					 **
 **			(e.g. PICTTexture, GIFTexture, MipMapTexture)					 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ObjectType Q3Texture_GetType(
	TQ3TextureObject		texture);

QD3D_EXPORT TQ3Status Q3Texture_GetWidth(
	TQ3TextureObject		texture,
	unsigned long			*width);

QD3D_EXPORT TQ3Status Q3Texture_GetHeight(
	TQ3TextureObject		texture,
	unsigned long			*height);


/******************************************************************************
 **																			 **
 **		Pixmap Texture													     **
 **			The TQ3StoragePixmap must contain a TQ3StorageObject that is a	 **
 **			Memory Storage ONLY for 1.0. We will support other storage 		 **
 **			classes in later releases.										 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3TextureObject Q3PixmapTexture_New(
	const TQ3StoragePixmap	*pixmap);

QD3D_EXPORT TQ3Status Q3PixmapTexture_GetPixmap(
	TQ3TextureObject		texture,
	TQ3StoragePixmap		*pixmap);

QD3D_EXPORT TQ3Status Q3PixmapTexture_SetPixmap(
	TQ3TextureObject		texture,
	const TQ3StoragePixmap	*pixmap);



#ifdef __cplusplus
}
#endif	/* __cplusplus */

#if defined(__MWERKS__)
#pragma options align=reset
#pragma enumsalwaysint reset
#endif

#endif  /*  QD3DShader_h  */
