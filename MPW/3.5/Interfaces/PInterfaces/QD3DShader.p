{
     File:       QD3DShader.p
 
     Contains:   QuickDraw 3D Shader / Color Routines
 
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
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{*****************************************************************************
 **                                                                          **
 **                             RGB Color routines                           **
 **                                                                          **
 ****************************************************************************}
{$IFC CALL_NOT_IN_CARBON }
{
 *  Q3ColorRGB_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ColorRGB_Set(VAR color: TQ3ColorRGB; r: Single; g: Single; b: Single): TQ3ColorRGBPtr; C;

{
 *  Q3ColorARGB_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ColorARGB_Set(VAR color: TQ3ColorARGB; a: Single; r: Single; g: Single; b: Single): TQ3ColorARGBPtr; C;

{
 *  Q3ColorRGB_Add()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ColorRGB_Add({CONST}VAR c1: TQ3ColorRGB; {CONST}VAR c2: TQ3ColorRGB; VAR result: TQ3ColorRGB): TQ3ColorRGBPtr; C;

{
 *  Q3ColorRGB_Subtract()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ColorRGB_Subtract({CONST}VAR c1: TQ3ColorRGB; {CONST}VAR c2: TQ3ColorRGB; VAR result: TQ3ColorRGB): TQ3ColorRGBPtr; C;

{
 *  Q3ColorRGB_Scale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ColorRGB_Scale({CONST}VAR color: TQ3ColorRGB; scale: Single; VAR result: TQ3ColorRGB): TQ3ColorRGBPtr; C;

{
 *  Q3ColorRGB_Clamp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ColorRGB_Clamp({CONST}VAR color: TQ3ColorRGB; VAR result: TQ3ColorRGB): TQ3ColorRGBPtr; C;

{
 *  Q3ColorRGB_Lerp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ColorRGB_Lerp({CONST}VAR first: TQ3ColorRGB; {CONST}VAR last: TQ3ColorRGB; alpha: Single; VAR result: TQ3ColorRGB): TQ3ColorRGBPtr; C;

{
 *  Q3ColorRGB_Accumulate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ColorRGB_Accumulate({CONST}VAR src: TQ3ColorRGB; VAR result: TQ3ColorRGB): TQ3ColorRGBPtr; C;

{$ENDC}  {CALL_NOT_IN_CARBON}

{  Q3ColorRGB_Luminance really returns a pointer to a Single }
{$IFC CALL_NOT_IN_CARBON }
{
 *  Q3ColorRGB_Luminance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ColorRGB_Luminance({CONST}VAR color: TQ3ColorRGB; VAR luminance: Single): Ptr; C;

{$ENDC}  {CALL_NOT_IN_CARBON}

{*****************************************************************************
 **                                                                          **
 **                             Shader Types                                 **
 **                                                                          **
 ****************************************************************************}

TYPE
	TQ3ShaderUVBoundary 		= SInt32;
CONST
	kQ3ShaderUVBoundaryWrap		= 0;
	kQ3ShaderUVBoundaryClamp	= 1;


	{	*****************************************************************************
	 **                                                                          **
	 **                             Shader Routines                              **
	 **                                                                          **
	 ****************************************************************************	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3Shader_GetType()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3Shader_GetType(shader: TQ3ShaderObject): TQ3ObjectType; C;

{
 *  Q3Shader_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Shader_Submit(shader: TQ3ShaderObject; view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3Shader_SetUVTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Shader_SetUVTransform(shader: TQ3ShaderObject; {CONST}VAR uvTransform: TQ3Matrix3x3): TQ3Status; C;

{
 *  Q3Shader_GetUVTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Shader_GetUVTransform(shader: TQ3ShaderObject; VAR uvTransform: TQ3Matrix3x3): TQ3Status; C;

{
 *  Q3Shader_SetUBoundary()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Shader_SetUBoundary(shader: TQ3ShaderObject; uBoundary: TQ3ShaderUVBoundary): TQ3Status; C;

{
 *  Q3Shader_SetVBoundary()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Shader_SetVBoundary(shader: TQ3ShaderObject; vBoundary: TQ3ShaderUVBoundary): TQ3Status; C;

{
 *  Q3Shader_GetUBoundary()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Shader_GetUBoundary(shader: TQ3ShaderObject; VAR uBoundary: TQ3ShaderUVBoundary): TQ3Status; C;

{
 *  Q3Shader_GetVBoundary()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Shader_GetVBoundary(shader: TQ3ShaderObject; VAR vBoundary: TQ3ShaderUVBoundary): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         Illumination Shader Classes                      **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3IlluminationShader_GetType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3IlluminationShader_GetType(shader: TQ3ShaderObject): TQ3ObjectType; C;

{
 *  Q3PhongIllumination_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3PhongIllumination_New: TQ3ShaderObject; C;

{
 *  Q3LambertIllumination_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3LambertIllumination_New: TQ3ShaderObject; C;

{
 *  Q3NULLIllumination_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3NULLIllumination_New: TQ3ShaderObject; C;


{*****************************************************************************
 **                                                                          **
 **                              Surface Shader                              **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3SurfaceShader_GetType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3SurfaceShader_GetType(shader: TQ3SurfaceShaderObject): TQ3ObjectType; C;


{*****************************************************************************
 **                                                                          **
 **                             Texture Shader                               **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3TextureShader_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3TextureShader_New(texture: TQ3TextureObject): TQ3ShaderObject; C;

{
 *  Q3TextureShader_GetTexture()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3TextureShader_GetTexture(shader: TQ3ShaderObject; VAR texture: TQ3TextureObject): TQ3Status; C;

{
 *  Q3TextureShader_SetTexture()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3TextureShader_SetTexture(shader: TQ3ShaderObject; texture: TQ3TextureObject): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                             Texture Objects                              **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Texture_GetType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Texture_GetType(texture: TQ3TextureObject): TQ3ObjectType; C;

{
 *  Q3Texture_GetWidth()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Texture_GetWidth(texture: TQ3TextureObject; VAR width: UInt32): TQ3Status; C;

{
 *  Q3Texture_GetHeight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Texture_GetHeight(texture: TQ3TextureObject; VAR height: UInt32): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                             Pixmap Texture                               **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3PixmapTexture_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3PixmapTexture_New({CONST}VAR pixmap: TQ3StoragePixmap): TQ3TextureObject; C;

{
 *  Q3PixmapTexture_GetPixmap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3PixmapTexture_GetPixmap(texture: TQ3TextureObject; VAR pixmap: TQ3StoragePixmap): TQ3Status; C;

{
 *  Q3PixmapTexture_SetPixmap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3PixmapTexture_SetPixmap(texture: TQ3TextureObject; {CONST}VAR pixmap: TQ3StoragePixmap): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                             Mipmap Texture                               **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3MipmapTexture_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3MipmapTexture_New({CONST}VAR mipmap: TQ3Mipmap): TQ3TextureObject; C;

{
 *  Q3MipmapTexture_GetMipmap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3MipmapTexture_GetMipmap(texture: TQ3TextureObject; VAR mipmap: TQ3Mipmap): TQ3Status; C;

{
 *  Q3MipmapTexture_SetMipmap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3MipmapTexture_SetMipmap(texture: TQ3TextureObject; {CONST}VAR mipmap: TQ3Mipmap): TQ3Status; C;

{*****************************************************************************
 **                                                                          **
 **                 Compressed Pixmap Texture                                **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3CompressedPixmapTexture_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3CompressedPixmapTexture_New({CONST}VAR compressedPixmap: TQ3CompressedPixmap): TQ3TextureObject; C;

{
 *  Q3CompressedPixmapTexture_GetCompressedPixmap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3CompressedPixmapTexture_GetCompressedPixmap(texture: TQ3TextureObject; VAR compressedPixmap: TQ3CompressedPixmap): TQ3Status; C;

{
 *  Q3CompressedPixmapTexture_SetCompressedPixmap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3CompressedPixmapTexture_SetCompressedPixmap(texture: TQ3TextureObject; {CONST}VAR compressedPixmap: TQ3CompressedPixmap): TQ3Status; C;

{
 *  Q3CompressedPixmapTexture_CompressImage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3CompressedPixmapTexture_CompressImage(VAR compressedPixmap: TQ3CompressedPixmap; sourcePixMap: PixMapHandle; codecType: CodecType; codecComponent: CodecComponent; codedDepth: INTEGER; codecQuality: CodecQ): TQ3Status; C;






{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DShaderIncludes}

{$ENDC} {__QD3DSHADER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
