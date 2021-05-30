{
 	File:		QD3DShader.p
 
 	Contains:	QuickDraw 3D Shader / Color Routines							
 
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
 UNIT QD3DShader;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DSHADER__}
{$SETC __QD3DSHADER__ := 1}

{$I+}
{$SETC QD3DShaderIncludes := UsingIncludes}
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
 **								RGB Color routines							 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3ColorRGB_Set(VAR color: TQ3ColorRGB; r: Single; g: Single; b: Single): TQ3ColorRGBPtr; C;
FUNCTION Q3ColorARGB_Set(VAR color: TQ3ColorARGB; a: Single; r: Single; g: Single; b: Single): TQ3ColorARGBPtr; C;
FUNCTION Q3ColorRGB_Add({CONST}VAR c1: TQ3ColorRGB; {CONST}VAR c2: TQ3ColorRGB; VAR result: TQ3ColorRGB): TQ3ColorRGBPtr; C;
FUNCTION Q3ColorRGB_Subtract({CONST}VAR c1: TQ3ColorRGB; {CONST}VAR c2: TQ3ColorRGB; VAR result: TQ3ColorRGB): TQ3ColorRGBPtr; C;
FUNCTION Q3ColorRGB_Scale({CONST}VAR color: TQ3ColorRGB; scale: Single; VAR result: TQ3ColorRGB): TQ3ColorRGBPtr; C;
FUNCTION Q3ColorRGB_Clamp({CONST}VAR color: TQ3ColorRGB; VAR result: TQ3ColorRGB): TQ3ColorRGBPtr; C;
FUNCTION Q3ColorRGB_Lerp({CONST}VAR first: TQ3ColorRGB; {CONST}VAR last: TQ3ColorRGB; alpha: Single; VAR result: TQ3ColorRGB): TQ3ColorRGBPtr; C;
FUNCTION Q3ColorRGB_Accumulate({CONST}VAR src: TQ3ColorRGB; VAR result: TQ3ColorRGB): TQ3ColorRGBPtr; C;
{  Q3ColorRGB_Luminance really returns a pointer to a Single }
FUNCTION Q3ColorRGB_Luminance({CONST}VAR color: TQ3ColorRGB; VAR luminance: Single): Ptr; C;
{
*****************************************************************************
 **																			 **
 **								Shader Types								 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3ShaderUVBoundary 		= LONGINT;
CONST
	kQ3ShaderUVBoundaryWrap		= {TQ3ShaderUVBoundary}0;
	kQ3ShaderUVBoundaryClamp	= {TQ3ShaderUVBoundary}1;

{
*****************************************************************************
 **																			 **
 **								Shader Routines								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Shader_GetType(shader: TQ3ShaderObject): TQ3ObjectType; C;
FUNCTION Q3Shader_Submit(shader: TQ3ShaderObject; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Shader_SetUVTransform(shader: TQ3ShaderObject; {CONST}VAR uvTransform: TQ3Matrix3x3): TQ3Status; C;
FUNCTION Q3Shader_GetUVTransform(shader: TQ3ShaderObject; VAR uvTransform: TQ3Matrix3x3): TQ3Status; C;
FUNCTION Q3Shader_SetUBoundary(shader: TQ3ShaderObject; uBoundary: TQ3ShaderUVBoundary): TQ3Status; C;
FUNCTION Q3Shader_SetVBoundary(shader: TQ3ShaderObject; vBoundary: TQ3ShaderUVBoundary): TQ3Status; C;
FUNCTION Q3Shader_GetUBoundary(shader: TQ3ShaderObject; VAR uBoundary: TQ3ShaderUVBoundary): TQ3Status; C;
FUNCTION Q3Shader_GetVBoundary(shader: TQ3ShaderObject; VAR vBoundary: TQ3ShaderUVBoundary): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **							Illumination Shader	Classes						 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3IlluminationShader_GetType(shader: TQ3ShaderObject): TQ3ObjectType; C;
FUNCTION Q3PhongIllumination_New: TQ3ShaderObject; C;
FUNCTION Q3LambertIllumination_New: TQ3ShaderObject; C;
FUNCTION Q3NULLIllumination_New: TQ3ShaderObject; C;
{
*****************************************************************************
 **																			 **
 **		Texture Shader  - may use any type of Texture. (only 1 type in 1.0)	 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3TextureShader_New(texture: TQ3TextureObject): TQ3ShaderObject; C;
FUNCTION Q3TextureShader_GetTexture(shader: TQ3ShaderObject; VAR texture: TQ3TextureObject): TQ3Status; C;
FUNCTION Q3TextureShader_SetTexture(shader: TQ3ShaderObject; texture: TQ3TextureObject): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **		Texture Objects - For 1.0, there  is 1 subclass: PixmapTexture.		 **
 **		More subclasses will be added in later releases.					 **
 **			(e.g. PICTTexture, GIFTexture, MipMapTexture)					 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Texture_GetType(texture: TQ3TextureObject): TQ3ObjectType; C;
FUNCTION Q3Texture_GetWidth(texture: TQ3TextureObject; VAR width: LONGINT): TQ3Status; C;
FUNCTION Q3Texture_GetHeight(texture: TQ3TextureObject; VAR height: LONGINT): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **		Pixmap Texture													     **
 **			The TQ3StoragePixmap must contain a TQ3StorageObject that is a	 **
 **			Memory Storage ONLY for 1.0. We will support other storage 		 **
 **			classes in later releases.										 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3PixmapTexture_New({CONST}VAR pixmap: TQ3StoragePixmap): TQ3TextureObject; C;
FUNCTION Q3PixmapTexture_GetPixmap(texture: TQ3TextureObject; VAR pixmap: TQ3StoragePixmap): TQ3Status; C;
FUNCTION Q3PixmapTexture_SetPixmap(texture: TQ3TextureObject; {CONST}VAR pixmap: TQ3StoragePixmap): TQ3Status; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DShaderIncludes}

{$ENDC} {__QD3DSHADER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
