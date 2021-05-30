{
     File:       RAVE.p
 
     Contains:   Interface for RAVE (Renderer Acceleration Virtual Engine)
 
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
 UNIT RAVE;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __RAVE__}
{$SETC __RAVE__ := 1}

{$I+}
{$SETC RAVEIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}

{$IFC TARGET_OS_MAC }
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __QDOFFSCREEN__}
{$I QDOffscreen.p}
{$ENDC}

{$ENDC}  {TARGET_OS_MAC}

{$IFC TARGET_OS_WIN32 }
{$IFC UNDEFINED RAVE_NO_DIRECTDRAW }
{$ENDC}
{$ENDC}  {TARGET_OS_WIN32}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{$SETC RAVE_OBSOLETE := 0 }
{*****************************************************************************
 *
 * Platform dependent datatypes: TQAImagePixelType, TQADevice, TQAClip, and TQARect.
 *
 ****************************************************************************}

TYPE
	TQAImagePixelType 			= SInt32;
CONST
	kQAPixel_Alpha1				= 0;							{  1 bit/pixel alpha  }
	kQAPixel_RGB16				= 1;							{  16 bits/pixel, R=14:10, G=9:5, B=4:0  }
	kQAPixel_ARGB16				= 2;							{  16 bits/pixel, A=15, R=14:10, G=9:5, B=4:0  }
	kQAPixel_RGB32				= 3;							{  32 bits/pixel, R=23:16, G=15:8, B=7:0  }
	kQAPixel_ARGB32				= 4;							{  32 bits/pixel, A=31:24, R=23:16, G=15:8, B=7:0  }
	kQAPixel_CL4				= 5;							{  4 bit color look up table, always big endian, ie high 4 bits effect left pixel  }
	kQAPixel_CL8				= 6;							{  8 bit color look up table  }
	kQAPixel_RGB16_565			= 7;							{  Win32 ONLY  16 bits/pixel, no alpha, R:5, G:6, B:5  }
	kQAPixel_RGB24				= 8;							{  Win32 ONLY  24 bits/pixel, no alpha, R:8, G:8, B:8  }
	kQAPixel_RGB8_332			= 9;							{  8 bits/pixel, R=7:5, G = 4:2, B = 1:0  }
	kQAPixel_ARGB16_4444		= 10;							{  16 bits/pixel, A=15:12, R=11:8, G=7:4, B=3:0  }
	kQAPixel_ACL16_88			= 11;							{  16 bits/pixel, A=15:8, CL=7:0, 8 bit alpha + 8 bit color lookup  }
	kQAPixel_I8					= 12;							{  8 bits/pixel, I=7:0, intensity map (grayscale)  }
	kQAPixel_AI16_88			= 13;							{  16 bits/pixel, A=15:8, I=7:0, intensity map (grayscale)  }
	kQAPixel_YUVS				= 14;							{  16 bits/pixel, QD's kYUVSPixelFormat (4:2:2, YUYV ordering, unsigned UV)  }
	kQAPixel_YUVU				= 15;							{  16 bits/pixel, QD's kYUVUPixelFormat (4:2:2, YUYV ordering, signed UV)  }
	kQAPixel_YVYU422			= 16;							{  16 bits/pixel, QD's kYVYU422PixelFormat (4:2:2, YVYU ordering, unsigned UV)  }
	kQAPixel_UYVY422			= 17;							{  16 bits/pixel, QD's kUYVY422PixelFormat (4:2:2, UYVY ordering, unsigned UV)  }


TYPE
	TQAColorTableType 			= SInt32;
CONST
	kQAColorTable_CL8_RGB32		= 0;							{  256 entry, 32 bit/pixel, R=23:16, G=15:8, B=7:0  }
	kQAColorTable_CL4_RGB32		= 1;							{  16 entry, 32 bit/pixel, R=23:16, G=15:8, B=7:0  }

	{	 Selects target device type 	}

TYPE
	TQADeviceType 				= SInt32;
CONST
	kQADeviceMemory				= 0;							{  Memory draw context  }
	kQADeviceGDevice			= 1;							{  Macintosh GDevice draw context  }
	kQADeviceWin32DC			= 2;							{  Win32 DC  }
	kQADeviceDDSurface			= 3;							{  Win32 DirectDraw Surface  }

	{	 Generic memory pixmap device 	}

TYPE
	TQADeviceMemoryPtr = ^TQADeviceMemory;
	TQADeviceMemory = RECORD
		rowBytes:				LONGINT;								{  Rowbytes  }
		pixelType:				TQAImagePixelType;						{  Depth, color space, etc.  }
		width:					LONGINT;								{  Width in pixels  }
		height:					LONGINT;								{  Height in pixels  }
		baseAddr:				Ptr;									{  Base address of pixmap  }
	END;

	{	 Offscreen Device 	}
	TQADeviceOffscreenPtr = ^TQADeviceOffscreen;
	TQADeviceOffscreen = RECORD
		pixelType:				TQAImagePixelType;						{  Depth, color space, etc.  }
	END;

	{	 Selects target clip type 	}
	TQAClipType 				= SInt32;
CONST
	kQAClipRgn					= 0;							{  Macintosh clipRgn with serial number  }
	kQAClipWin32Rgn				= 1;							{  Win32 clip region  }


TYPE
	TQARectPtr = ^TQARect;
	TQARect = RECORD
		left:					LONGINT;
		right:					LONGINT;
		top:					LONGINT;
		bottom:					LONGINT;
	END;

{$IFC TARGET_OS_MAC }
	TQAPlatformDevicePtr = ^TQAPlatformDevice;
	TQAPlatformDevice = RECORD
		CASE INTEGER OF
		0: (
			memoryDevice:		TQADeviceMemory;
			);
		1: (
			gDevice:			GDHandle;
			);
	END;

	TQAPlatformClipPtr = ^TQAPlatformClip;
	TQAPlatformClip = RECORD
		CASE INTEGER OF
		0: (
			clipRgn:			RgnHandle;
			);
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	TQADrawNotificationProcPtr = PROCEDURE(left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER; refCon: LONGINT);
{$ELSEC}
	TQADrawNotificationProcPtr = ProcPtr;
{$ENDC}

	TQADrawNotificationProcRefNum		= LONGINT;
	{	 used to unregister your proc 	}
{$ELSEC}
  {$IFC TARGET_OS_WIN32 }
  {$ELSEC}
	{	
	     * Generic platform supports memory device only. TQARect is generic. TQAClip is ???.
	     	}
	TQAPlatformDevice = RECORD
		CASE INTEGER OF
		0: (
			memoryDevice:		TQADeviceMemory;
			);
	END;

	TQAPlatformClip = RECORD
		CASE INTEGER OF
		0: (
			region:				Ptr;									{  ???  }
			);
	END;

  {$ENDC}
{$ENDC}

	TQADevicePtr = ^TQADevice;
	TQADevice = RECORD
		deviceType:				TQADeviceType;
		device:					TQAPlatformDevice;
	END;

	TQAClipPtr = ^TQAClip;
	TQAClip = RECORD
		clipType:				TQAClipType;
		clip:					TQAPlatformClip;
	END;

	{	*****************************************************************************
	 *
	 * Basic data types.
	 *
	 ****************************************************************************	}

	TQAEngine    = ^LONGINT; { an opaque 32-bit type }
	TQAEnginePtr = ^TQAEngine;  { when a VAR xx:TQAEngine parameter can be nil, it is changed to xx: TQAEnginePtr }
	TQAEnginePtr    = ^LONGINT; { an opaque 32-bit type }
	TQAEnginePtrPtr = ^TQAEnginePtr;  { when a VAR xx:TQAEnginePtr parameter can be nil, it is changed to xx: TQAEnginePtrPtr }
	TQATexture    = ^LONGINT; { an opaque 32-bit type }
	TQATexturePtr = ^TQATexture;  { when a VAR xx:TQATexture parameter can be nil, it is changed to xx: TQATexturePtr }
	TQATexturePtr    = ^LONGINT; { an opaque 32-bit type }
	TQATexturePtrPtr = ^TQATexturePtr;  { when a VAR xx:TQATexturePtr parameter can be nil, it is changed to xx: TQATexturePtrPtr }
	TQABitmap    = ^LONGINT; { an opaque 32-bit type }
	TQABitmapPtr = ^TQABitmap;  { when a VAR xx:TQABitmap parameter can be nil, it is changed to xx: TQABitmapPtr }
	TQABitmapPtr    = ^LONGINT; { an opaque 32-bit type }
	TQABitmapPtrPtr = ^TQABitmapPtr;  { when a VAR xx:TQABitmapPtr parameter can be nil, it is changed to xx: TQABitmapPtrPtr }
	TQADrawPrivate    = ^LONGINT; { an opaque 32-bit type }
	TQADrawPrivatePtr = ^TQADrawPrivate;  { when a VAR xx:TQADrawPrivate parameter can be nil, it is changed to xx: TQADrawPrivatePtr }
	TQADrawPrivatePtr    = ^LONGINT; { an opaque 32-bit type }
	TQADrawPrivatePtrPtr = ^TQADrawPrivatePtr;  { when a VAR xx:TQADrawPrivatePtr parameter can be nil, it is changed to xx: TQADrawPrivatePtrPtr }
	TQAColorTable    = ^LONGINT; { an opaque 32-bit type }
	TQAColorTablePtr = ^TQAColorTable;  { when a VAR xx:TQAColorTable parameter can be nil, it is changed to xx: TQAColorTablePtr }
	TQAColorTablePtr    = ^LONGINT; { an opaque 32-bit type }
	TQAColorTablePtrPtr = ^TQAColorTablePtr;  { when a VAR xx:TQAColorTablePtr parameter can be nil, it is changed to xx: TQAColorTablePtrPtr }
	{	 A single triangle element for QADrawTriMesh 	}
	TQAIndexedTrianglePtr = ^TQAIndexedTriangle;
	TQAIndexedTriangle = RECORD
		triangleFlags:			UInt32;									{  Triangle flags, see kQATriFlags_  }
		vertices:				ARRAY [0..2] OF UInt32;					{  Indices into a vertex array  }
	END;

	{	 An image for use as texture or bitmap 	}
	TQAImagePtr = ^TQAImage;
	TQAImage = RECORD
		width:					LONGINT;								{  Width of pixmap  }
		height:					LONGINT;								{  Height of pixmap  }
		rowBytes:				LONGINT;								{  Rowbytes of pixmap  }
		pixmap:					Ptr;									{  Pixmap  }
	END;

	{	 a pixel buffer 	}
	TQAPixelBuffer						= TQADeviceMemory;
	TQAPixelBufferPtr 					= ^TQAPixelBuffer;
	{	 a zbuffer 	}
	TQAZBufferPtr = ^TQAZBuffer;
	TQAZBuffer = RECORD
		width:					LONGINT;								{  Width of pixmap  }
		height:					LONGINT;								{  Height of pixmap  }
		rowBytes:				LONGINT;								{  Rowbytes of pixmap  }
		zbuffer:				Ptr;									{  pointer to the zbuffer data  }
		zDepth:					LONGINT;								{  bit depth of zbuffer (16,24,32...)  }
		isBigEndian:			LONGINT;								{  true if zbuffer values are in big-endian format, false if little-endian  }
	END;

	{	 Standard error type 	}
	TQAError 					= SInt32;
CONST
	kQANoErr					= 0;							{  No error  }
	kQAError					= 1;							{  Generic error flag  }
	kQAOutOfMemory				= 2;							{  Insufficient memory  }
	kQANotSupported				= 3;							{  Requested feature is not supported  }
	kQAOutOfDate				= 4;							{  A newer drawing engine was registered  }
	kQAParamErr					= 5;							{  Error in passed parameters  }
	kQAGestaltUnknown			= 6;							{  Requested gestalt type isn't available  }
	kQADisplayModeUnsupported	= 7;							{  Engine cannot render to the display in its current ,  }
																{  mode, but could if it were in some other mode  }
	kQAOutOfVideoMemory			= 8;							{  There is not enough VRAM to support the desired context dimensions  }

	{	 TQABoolean 	}

TYPE
	TQABoolean							= UInt8;
	{	***********************************************************************************************
	 *
	 * Vertex data types.
	 *
	 **********************************************************************************************	}
	{	
	 * TQAVGouraud is used for Gouraud shading. Each vertex specifies position, color and Z.
	 *
	 * Alpha is always treated as indicating transparency. Drawing engines which don't
	 * support Z-sorted rendering use the back-to-front transparency blending functions
	 * shown below. (ARGBsrc are the source (new) values, ARGBdest are  the destination
	 * (previous) pixel values.)
	 *
	 *      Premultiplied                           Interpolated
	 *
	 *      A = 1 - (1 - Asrc) * (1 - Adest)        A = 1 - (1 - Asrc) * (1 - Adest) 
	 *      R = (1 - Asrc) * Rdest + Rsrc           R = (1 - Asrc) * Rdest + Asrc * Rsrc
	 *      G = (1 - Asrc) * Gdest + Gsrc           G = (1 - Asrc) * Gdest + Asrc * Gsrc
	 *      B = (1 - Asrc) * Bdest + Bsrc           B = (1 - Asrc) * Bdest + Asrc * Bsrc
	 *
	 * Note that the use of other blending modes to implement antialiasing is performed
	 * automatically by the drawing engine when the kQATag_Antialias variable !=
	 * kQAAntiAlias_Fast. The driving software should continue to use the alpha fields
	 * for transparency even when antialiasing is being used (the drawing engine will
	 * resolve the multiple blending requirements as best as it can).
	 *
	 * Drawing engines which perform front-to-back Z-sorted rendering should replace
	 * the blending function shown above with the equivalent front-to-back formula.
	 	}
	TQAVGouraudPtr = ^TQAVGouraud;
	TQAVGouraud = RECORD
		x:						Single;									{  X pixel coordinate, 0.0 <= x < width  }
		y:						Single;									{  Y pixel coordinate, 0.0 <= y < height  }
		z:						Single;									{  Z coordinate, 0.0 <= z <= 1.0  }
		invW:					Single;									{  1 / w; required only when kQAPerspectiveZ_On is set  }
		r:						Single;									{  Red, 0.0 <= r <= 1.0  }
		g:						Single;									{  Green, 0.0 <= g <= 1.0  }
		b:						Single;									{  Blue, 0.0 <= b <= 1.0  }
		a:						Single;									{  Alpha, 0.0 <= a <= 1.0, 1.0 is opaque  }
	END;

	{	
	 * TQAVTexture is used for texture mapping. The texture mapping operation
	 * is controlled by the kQATag_TextureOp variable, which is a mask of
	 * kQATextureOp_None/Modulate/Highlight/Decal. Below is pseudo-code for the
	 * texture shading operation:
	 *
	 *      texPix = TextureLookup (uq/q, vq/q);
	 *      if (kQATextureOp_Decal)
	 *      (
	 *          texPix.r = texPix.a * texPix.r + (1 - texPix.a) * r;
	 *          texPix.g = texPix.a * texPix.g + (1 - texPix.a) * g;
	 *          texPix.b = texPix.a * texPix.b + (1 - texPix.a) * b;
	 *          texPix.a = a;
	 *      )
	 *      else
	 *      (
	 *          texPix.a = texPix.a * a;
	 *      )
	 *      if (kQATextureOp_Modulate)
	 *      (
	 *          texPix.r *= kd_r;       // Clamped to prevent overflow
	 *          texPix.g *= kd_g;       // Clamped to prevent overflow
	 *          texPix.b *= kd_b;       // Clamped to prevent overflow
	 *      )
	 *      if (kQATextureOp_Highlight)
	 *      (
	 *          texPix.r += ks_r;       // Clamped to prevent overflow
	 *          texPix.g += ks_g;       // Clamped to prevent overflow
	 *          texPix.b += ks_b;       // Clamped to prevent overflow
	 *      )
	 *
	 * After computation of texPix, transparency blending (as shown
	 * above for TQAVGouraud) is performed.
	 	}
	TQAVTexturePtr = ^TQAVTexture;
	TQAVTexture = RECORD
		x:						Single;									{  X pixel coordinate, 0.0 <= x < width  }
		y:						Single;									{  Y pixel coordinate, 0.0 <= y < height  }
		z:						Single;									{  Z coordinate, 0.0 <= z <= 1.0  }
		invW:					Single;									{  1 / w (always required)  }
																		{  rgb are used only when kQATextureOp_Decal is set. a is always required  }
		r:						Single;									{  Red, 0.0 <= r <= 1.0  }
		g:						Single;									{  Green, 0.0 <= g <= 1.0  }
		b:						Single;									{  Blue, 0.0 <= b <= 1.0  }
		a:						Single;									{  Alpha, 0.0 <= a <= 1.0, 1.0 is opaque  }
																		{  uOverW and vOverW are required by all modes  }
		uOverW:					Single;									{  u / w  }
		vOverW:					Single;									{  v / w  }
																		{  kd_r/g/b are used only when kQATextureOp_Modulate is set  }
		kd_r:					Single;									{  Scale factor for texture red, 0.0 <= kd_r  }
		kd_g:					Single;									{  Scale factor for texture green, 0.0 <= kd_g  }
		kd_b:					Single;									{  Scale factor for texture blue, 0.0 <= kd_b  }
																		{  ks_r/g/b are used only when kQATextureOp_Highlight is set  }
		ks_r:					Single;									{  Red specular highlight, 0.0 <= ks_r <= 1.0  }
		ks_g:					Single;									{  Green specular highlight, 0.0 <= ks_g <= 1.0  }
		ks_b:					Single;									{  Blue specular highlight, 0.0 <= ks_b <= 1.0  }
	END;

	{	
	*  TQAVMultiTexture allows you to specify the uv and invW values
	*  for secondary textures.  This data is submitted with the
	*  QASubmitMultiTextureParams() call.
		}
	TQAVMultiTexturePtr = ^TQAVMultiTexture;
	TQAVMultiTexture = RECORD
		invW:					Single;
		uOverW:					Single;
		vOverW:					Single;
	END;


	{	***********************************************************************************************
	 *
	 * Constants used for the state variables.
	 *
	 **********************************************************************************************	}
	{	
	 * kQATag_xxx is used to select a state variable when calling QASetFloat(), QASetInt(),
	 * QAGetFloat() and QAGetInt(). The kQATag values are split into three separate enumerated
	 * types: TQATagInt, TQATagPtr and TQATagFloat. TQATagInt is used for the QASet/GetInt()
	 * functions, TQATagPtr is used for the QASet/GetPtr() functions, and TQATagFloat is used for 
	 * the QASet/GetFloat() functions. (This is so that a compiler that typechecks enums can flag
	 * a float/int tag mismatch during compile.)
	 *
	 * -=- All tag values must be unique even across all three types. -=-
	 *
	 * These variables are required by all drawing engines:
	 *      kQATag_ZFunction            (Int)   One of kQAZFunction_xxx
	 *      kQATag_ColorBG_a            (Float) Background color alpha
	 *      kQATag_ColorBG_r            (Float) Background color red
	 *      kQATag_ColorBG_g            (Float) Background color green
	 *      kQATag_ColorBG_b            (Float) Background color blue
	 *      kQATag_Width                (Float) Line and point width (pixels)
	 *      kQATag_ZMinOffset           (Float) Min offset to Z to guarantee visibility (Read only!)
	 *      kQATag_ZMinScale            (Float) Min scale to Z to guarantee visibility (Read only!)
	 
	 * These variables are used for optional features:
	 *      kQATag_Antialias            (Int)   One of kQAAntiAlias_xxx
	 *      kQATag_Blend                (Int)   One of kQABlend_xxx
	 *      kQATag_PerspectiveZ         (Int)   One of kQAPerspectiveZ_xxx
	 *      kQATag_TextureFilter        (Int)   One of kQATextureFilter_xxx
	 *      kQATag_TextureOp            (Int)   Mask of kQATextureOp_xxx
	 *      kQATag_Texture              (Ptr)   Pointer to current TQATexture
	 *      kQATag_CSGTag               (Int)   One of kQACSGTag_xxx
	 *      kQATag_CSGEquation          (Int)   32 bit CSG truth table
	 *      kQATag_FogMode              (Int)   One of kQAFogMode_xxxx
	 *      kQATag_FogColor_a           (Float) Fog color alpha
	 *      kQATag_FogColor_r           (Float) Fog color red
	 *      kQATag_FogColor_g           (Float) Fog color green
	 *      kQATag_FogColor_b           (Float) Fog color blue
	 *      kQATag_FogStart             (Float) Fog start
	 *      kQATag_FogEnd               (Float) Fog end
	 *      kQATag_FogDensity           (Float) Fog density
	 *      kQATag_FogMaxDepth          (Float) Maximun value for 1.0 / invW
	 *      kQATag_MipmapBias           (Float) The mipmap page bias factor
	 *      kQATag_ChannelMask          (Int) one of kQAChannelMask_xxx
	 *      kQATag_ZBufferMask          (Int) one of kQAZBufferMask_xxx
	 *      kQATag_ZSortedHint          (Int) 1 = depth sort transparent triangles, 0 = do not sort.
	 *      kQATag_Chromakey_r          (Float) chroma key red
	 *      kQATag_Chromakey_g          (Float) chroma key green
	 *      kQATag_Chromakey_b          (Float) chroma key blue
	 *      kQATag_ChromakeyEnable      (Int) 1 = enable chroma keying, 0 = disable chroma keying
	 *      kQATag_AlphaTestFunc        (Int) one of kQAAlphaTest_xxx
	 *      kQATag_AlphaTestRef         (Float) from 0 to 1
	 *      kQATag_DontSwap             (Int) 1 = dont swap buffers during QARenderEnd, 0 = do swap buffers during QARenderEnd.
	
	 *      kQATag_MultiTextureOp       (Int) One of kQAMultiTexture_xxx
	 *      kQATag_MultiTextureFilter   (Int) One of kQATextureFilter_xxx
	 *      kQATag_MultiTextureCurrent  (Int) which multitexture layer to use for all other multitexture funcs
	 *      kQATag_MultiTextureEnable   (Int) how many multitexture layers to use (0 = no multitexturing).
	 *      kQATag_MultiTextureWrapU    (Int)
	 *      kQATag_MultiTextureWrapV    (Int)
	 *      kQATag_MultiTextureMagFilter (Int)
	 *      kQATag_MultiTextureMinFilter (Int)
	 *      kQATag_MultiTextureBorder_a (Float)
	 *      kQATag_MultiTextureBorder_r (Float)
	 *      kQATag_MultiTextureBorder_g (Float)
	 *      kQATag_MultiTextureBorder_b (Float)
	 *      kQATag_MultiTextureMipmapBias (Float)
	 *      kQATag_MultiTextureFactor    (Float) used with kQAMultiTexture_Fixed to determine blending factor
	 *
	 * These variables are used for OpenGL™ support:
	 *      kQATagGL_DrawBuffer         (Int)   Mask of kQAGL_DrawBuffer_xxx
	 *      kQATagGL_TextureWrapU       (Int)   kQAGL_Clamp or kQAGL_Repeat
	 *      kQATagGL_TextureWrapV       (Int)   kQAGL_Clamp or kQAGL_Repeat
	 *      kQATagGL_TextureMagFilter   (Int)   kQAGL_Nearest or kQAGL_Linear
	 *      kQATagGL_TextureMinFilter   (Int)   kQAGL_Nearest, etc.
	 *      kQATagGL_ScissorXMin        (Int)   Minimum X value for scissor rectangle
	 *      kQATagGL_ScissorYMin        (Int)   Minimum Y value for scissor rectangle
	 *      kQATagGL_ScissorXMax        (Int)   Maximum X value for scissor rectangle
	 *      kQATagGL_ScissorYMax        (Int)   Maximum Y value for scissor rectangle
	 *      kQATagGL_BlendSrc           (Int)   Source blending operation
	 *      kQATagGL_BlendDst           (Int)   Destination blending operation
	 *      kQATagGL_LinePattern        (Int)   Line rasterization pattern
	 *      kQATagGL_AreaPattern0       (Int)   First of 32 area pattern registers
	 *      kQATagGL_AreaPattern31      (Int)   Last of 32 area pattern registers
	 *
	 *      kQATagGL_DepthBG            (Float) Background Z
	 *      kQATagGL_TextureBorder_a    (Float) Texture border color alpha
	 *      kQATagGL_TextureBorder_r    (Float) Texture border color red
	 *      kQATagGL_TextureBorder_g    (Float) Texture border color green
	 *      kQATagGL_TextureBorder_b    (Float) Texture border color blue
	 *
	 * Tags >= kQATag_EngineSpecific_Minimum may be assigned by the vendor for use as
	 * engine-specific variables. NOTE: These should be used only in exceptional circumstances,
	 * as functions performed by these variables won't be generally accessible. All other tag
	 * values are reserved.
	 *
	 *      kQATag_EngineSpecific_Minimum   Minimum tag value for drawing-engine specific variables
	 	}
	TQATagInt 					= SInt32;
CONST
	kQATag_ZFunction			= 0;
	kQATag_Antialias			= 8;
	kQATag_Blend				= 9;
	kQATag_PerspectiveZ			= 10;
	kQATag_TextureFilter		= 11;
	kQATag_TextureOp			= 12;
	kQATag_CSGTag				= 14;
	kQATag_CSGEquation			= 15;
	kQATag_BufferComposite		= 16;
	kQATag_FogMode				= 17;
	kQATag_ChannelMask			= 27;
	kQATag_ZBufferMask			= 28;
	kQATag_ZSortedHint			= 29;
	kQATag_ChromakeyEnable		= 30;
	kQATag_AlphaTestFunc		= 31;
	kQATag_DontSwap				= 32;
	kQATag_MultiTextureEnable	= 33;
	kQATag_MultiTextureCurrent	= 34;
	kQATag_MultiTextureOp		= 35;
	kQATag_MultiTextureFilter	= 36;
	kQATag_MultiTextureWrapU	= 37;
	kQATag_MultiTextureWrapV	= 38;
	kQATag_MultiTextureMagFilter = 39;
	kQATag_MultiTextureMinFilter = 40;
	kQATag_BitmapFilter			= 54;							{  filter to use while scaling bitmaps, one of kQAFilter_xxx  }
	kQATag_DrawContextFilter	= 55;							{  filter to use while scaling draw contexts, one of kQAFilter_xxx  }
	kQATagGL_DrawBuffer			= 100;
	kQATagGL_TextureWrapU		= 101;
	kQATagGL_TextureWrapV		= 102;
	kQATagGL_TextureMagFilter	= 103;
	kQATagGL_TextureMinFilter	= 104;
	kQATagGL_ScissorXMin		= 105;
	kQATagGL_ScissorYMin		= 106;
	kQATagGL_ScissorXMax		= 107;
	kQATagGL_ScissorYMax		= 108;
	kQATagGL_BlendSrc			= 109;
	kQATagGL_BlendDst			= 110;
	kQATagGL_LinePattern		= 111;
	kQATagGL_AreaPattern0		= 117;							{  ...kQATagGL_AreaPattern1-30  }
	kQATagGL_AreaPattern31		= 148;
	kQATagGL_LinePatternFactor	= 149;							{  equivalent to GL_LINE_STIPPLE_REPEAT  }
	kQATag_EngineSpecific_Minimum = 1000;


TYPE
	TQATagPtr 					= SInt32;
CONST
	kQATag_Texture				= 13;
	kQATag_MultiTexture			= 26;


TYPE
	TQATagFloat 				= SInt32;
CONST
	kQATag_ColorBG_a			= 1;
	kQATag_ColorBG_r			= 2;
	kQATag_ColorBG_g			= 3;
	kQATag_ColorBG_b			= 4;
	kQATag_Width				= 5;
	kQATag_ZMinOffset			= 6;
	kQATag_ZMinScale			= 7;
	kQATag_FogColor_a			= 18;
	kQATag_FogColor_r			= 19;
	kQATag_FogColor_g			= 20;
	kQATag_FogColor_b			= 21;
	kQATag_FogStart				= 22;
	kQATag_FogEnd				= 23;
	kQATag_FogDensity			= 24;
	kQATag_FogMaxDepth			= 25;
	kQATag_MipmapBias			= 41;
	kQATag_MultiTextureMipmapBias = 42;
	kQATag_Chromakey_r			= 43;
	kQATag_Chromakey_g			= 44;
	kQATag_Chromakey_b			= 45;
	kQATag_AlphaTestRef			= 46;
	kQATag_MultiTextureBorder_a	= 47;
	kQATag_MultiTextureBorder_r	= 48;
	kQATag_MultiTextureBorder_g	= 49;
	kQATag_MultiTextureBorder_b	= 50;
	kQATag_MultiTextureFactor	= 51;
	kQATag_BitmapScale_x		= 52;							{  horizontal bitmap scale factor, default value is 1.0  }
	kQATag_BitmapScale_y		= 53;							{  vertical bitmap scale factor, default value is 1.0  }
	kQATag_MultiTextureEnvColor_a = 56;
	kQATag_MultiTextureEnvColor_r = 57;
	kQATag_MultiTextureEnvColor_g = 58;
	kQATag_MultiTextureEnvColor_b = 59;
	kQATagGL_DepthBG			= 112;
	kQATagGL_TextureBorder_a	= 113;
	kQATagGL_TextureBorder_r	= 114;
	kQATagGL_TextureBorder_g	= 115;
	kQATagGL_TextureBorder_b	= 116;
	kQATagGL_TextureEnvColor_a	= 150;
	kQATagGL_TextureEnvColor_r	= 151;
	kQATagGL_TextureEnvColor_g	= 152;
	kQATagGL_TextureEnvColor_b	= 153;


	{	 kQATag_ZFunction 	}
	kQAZFunction_None			= 0;							{  Z is neither tested nor written (same as no Z buffer)  }
	kQAZFunction_LT				= 1;							{  Znew < Zbuffer is visible  }
	kQAZFunction_EQ				= 2;							{  Znew == Zbuffer is visible  }
	kQAZFunction_LE				= 3;							{  Znew <= Zbuffer is visible  }
	kQAZFunction_GT				= 4;							{  Znew > Zbuffer is visible  }
	kQAZFunction_NE				= 5;							{  Znew != Zbuffer is visible  }
	kQAZFunction_GE				= 6;							{  Znew >= Zbuffer is visible  }
	kQAZFunction_True			= 7;							{  Znew is always visible  }
	kQAZFunction_False			= 8;							{  Znew is never visible  }

	{	 kQATag_Width 	}
    kQAMaxWidth = 128.0;
	{	 kQATag_Antialias 	}
	kQAAntiAlias_Off			= 0;
	kQAAntiAlias_Fast			= 1;
	kQAAntiAlias_Mid			= 2;
	kQAAntiAlias_Best			= 3;

	{	 kQATag_Blend 	}
	kQABlend_PreMultiply		= 0;
	kQABlend_Interpolate		= 1;
	kQABlend_OpenGL				= 2;

	{	 kQATag_BufferComposite 	}
	kQABufferComposite_None		= 0;							{  Default: New pixels overwrite initial buffer contents  }
	kQABufferComposite_PreMultiply = 1;							{  New pixels are blended with initial buffer contents via PreMultiply  }
	kQABufferComposite_Interpolate = 2;							{  New pixels are blended with initial buffer contents via Interpolate  }

	{	 kQATag_PerspectiveZ 	}
	kQAPerspectiveZ_Off			= 0;							{  Use Z for hidden surface removal  }
	kQAPerspectiveZ_On			= 1;							{  Use InvW for hidden surface removal  }

	{	 kQATag_TextureFilter 	}
																{  suggested meanings of these values  }
	kQATextureFilter_Fast		= 0;							{  No filtering, pick nearest  }
	kQATextureFilter_Mid		= 1;							{  Fastest method that does some filtering  }
	kQATextureFilter_Best		= 2;							{  Highest quality renderer can do  }

	{	 filter tag values 	}
																{  suggested meanings of these values  }
	kQAFilter_Fast				= 0;							{  No filtering, pick nearest  }
	kQAFilter_Mid				= 1;							{  Fastest method that does some filtering  }
	kQAFilter_Best				= 2;							{  Highest quality renderer can do  }

	{	 kQATag_TextureOp (mask of one or more) 	}
	kQATextureOp_None			= 0;							{  Default texture mapping mode  }
	kQATextureOp_Modulate		= $01;							{  Modulate texture color with kd_r/g/b  }
	kQATextureOp_Highlight		= $02;							{  Add highlight value ks_r/g/b  }
	kQATextureOp_Decal			= $04;							{  When texture alpha == 0, use rgb instead  }
	kQATextureOp_Shrink			= $08;							{  This is a non-wrapping texture, so the ???  }
	kQATextureOp_Blend			= $10;							{  Same as GL_TEXTURE_ENV_MODE GL_BLEND  }

	{	 kQATag_MultiTextureOp 	}
	kQAMultiTexture_Add			= 0;							{  texels are added to form final pixel  }
	kQAMultiTexture_Modulate	= 1;							{  texels are multiplied to form final pixel  }
	kQAMultiTexture_BlendAlpha	= 2;							{  texels are blended according to 2nd texel's alpha  }
	kQAMultiTexture_Fixed		= 3;							{  texels are blended by a fixed factor via kQATag_MultiTextureFactor   }

	{	 kQATag_CSGTag 	}
	kQACSGTag_0					= 0;							{  Submitted tris have CSG ID 0  }
	kQACSGTag_1					= 1;							{  Submitted tris have CSG ID 1  }
	kQACSGTag_2					= 2;							{  Submitted tris have CSG ID 2  }
	kQACSGTag_3					= 3;							{  Submitted tris have CSG ID 3  }
	kQACSGTag_4					= 4;							{  Submitted tris have CSG ID 4  }

	{	 kQATagGL_TextureWrapU/V 	}
	kQAGL_Repeat				= 0;
	kQAGL_Clamp					= 1;

	{	 kQATagGL_BlendSrc 	}
	kQAGL_SourceBlend_XXX		= 0;

	{	 kQATagGL_BlendDst 	}
	kQAGL_DestBlend_XXX			= 0;

	{	 kQATagGL_DrawBuffer (mask of one or more) 	}
	kQAGL_DrawBuffer_None		= 0;
	kQAGL_DrawBuffer_FrontLeft	= $01;
	kQAGL_DrawBuffer_FrontRight	= $02;
	kQAGL_DrawBuffer_BackLeft	= $04;
	kQAGL_DrawBuffer_BackRight	= $08;
	kQAGL_DrawBuffer_Front		= $03;
	kQAGL_DrawBuffer_Back		= $0C;

	{	 kQATag_FogMode 	}
	kQAFogMode_None				= 0;							{  no fog                      }
	kQAFogMode_Alpha			= 1;							{  fog value is alpha                }
	kQAFogMode_Linear			= 2;							{  fog = (end - z) / (end - start)          }
	kQAFogMode_Exponential		= 3;							{  fog = exp(-density * z)               }
	kQAFogMode_ExponentialSquared = 4;							{  fog = exp(-density * z * density * z)   }


	{	 kQATag_ChannelMask 	}
	kQAChannelMask_r			= $01;
	kQAChannelMask_g			= $02;
	kQAChannelMask_b			= $04;
	kQAChannelMask_a			= $08;


	{	 kQATag_ZBufferMask 	}
	kQAZBufferMask_Disable		= 0;
	kQAZBufferMask_Enable		= 1;

	{	 kQATag_AlphaTestFunc 	}
	kQAAlphaTest_None			= 0;
	kQAAlphaTest_LT				= 1;
	kQAAlphaTest_EQ				= 2;
	kQAAlphaTest_LE				= 3;
	kQAAlphaTest_GT				= 4;
	kQAAlphaTest_NE				= 5;
	kQAAlphaTest_GE				= 6;
	kQAAlphaTest_True			= 7;


	{	 flags for QAAccess__xxx 	}
	kQANoCopyNeeded				= $01;


	{	***********************************************************************************************
	 *
	 * Constants used as function parameters.
	 *
	 **********************************************************************************************	}
	{	
	 * TQAVertexMode is a parameter to QADrawVGouraud() and QADrawVTexture() that specifies how
	 * to interpret and draw the vertex array.
	 	}

TYPE
	TQAVertexMode 				= SInt32;
CONST
	kQAVertexMode_Point			= 0;							{  Draw nVertices points  }
	kQAVertexMode_Line			= 1;							{  Draw nVertices/2 line segments  }
	kQAVertexMode_Polyline		= 2;							{  Draw nVertices-1 connected line segments  }
	kQAVertexMode_Tri			= 3;							{  Draw nVertices/3 triangles  }
	kQAVertexMode_Strip			= 4;							{  Draw nVertices-2 triangles as a strip  }
	kQAVertexMode_Fan			= 5;							{  Draw nVertices-2 triangles as a fan from v0  }
	kQAVertexMode_NumModes		= 6;

	{	
	 * TQAGestaltSelector is a parameter to QAEngineGestalt(). It selects which gestalt
	 * parameter will be copied into 'response'.
	 	}

TYPE
	TQAGestaltSelector 			= SInt32;
CONST
	kQAGestalt_OptionalFeatures	= 0;							{  Mask of one or more kQAOptional_xxx  }
	kQAGestalt_FastFeatures		= 1;							{  Mask of one or more kQAFast_xxx  }
	kQAGestalt_VendorID			= 2;							{  Vendor ID  }
	kQAGestalt_EngineID			= 3;							{  Engine ID  }
	kQAGestalt_Revision			= 4;							{  Revision number of this engine  }
	kQAGestalt_ASCIINameLength	= 5;							{  strlen (asciiName)  }
	kQAGestalt_ASCIIName		= 6;							{  Causes strcpy (response, asciiName)  }
	kQAGestalt_TextureMemory	= 7;							{  amount of texture RAM currently available  }
	kQAGestalt_FastTextureMemory = 8;							{  amount of texture RAM currently available  }
	kQAGestalt_DrawContextPixelTypesAllowed = 9;				{  returns all the draw context pixel types supported by the RAVE engine  }
	kQAGestalt_DrawContextPixelTypesPreferred = 10;				{  returns all the draw context pixel types that are preferred by the RAVE engine.  }
	kQAGestalt_TexturePixelTypesAllowed = 11;					{  returns all the texture pixel types that are supported by the RAVE engine  }
	kQAGestalt_TexturePixelTypesPreferred = 12;					{  returns all the texture pixel types that are preferred by the RAVE engine. }
	kQAGestalt_BitmapPixelTypesAllowed = 13;					{  returns all the bitmap pixel types that are supported by the RAVE engine.  }
	kQAGestalt_BitmapPixelTypesPreferred = 14;					{  returns all the bitmap pixel types that are preferred by the RAVE engine.  }
	kQAGestalt_OptionalFeatures2 = 15;							{  Mask of one or more kQAOptional2_xxx  }
	kQAGestalt_MultiTextureMax	= 16;							{  max number of multi textures supported by this engine  }
	kQAGestalt_NumSelectors		= 17;
	kQAGestalt_EngineSpecific_Minimum = 1000;					{  all gestalts here and above are for engine specific purposes  }

	{	
	 * TQAMethodSelector is a parameter to QASetNoticeMethod to select the notice method
	 	}
{$IFC RAVE_OBSOLETE }

TYPE
	TQAMethodSelector 			= SInt32;
CONST
	kQAMethod_RenderCompletion	= 0;							{  Called when rendering has completed and buffers swapped  }
	kQAMethod_DisplayModeChanged = 1;							{  Called when a display mode has changed  }
	kQAMethod_ReloadTextures	= 2;							{  Called when texture memory has been invalidated  }
	kQAMethod_BufferInitialize	= 3;							{  Called when a buffer needs to be initialized  }
	kQAMethod_BufferComposite	= 4;							{  Called when rendering is finished and its safe to composite  }
	kQAMethod_NumSelectors		= 5;

{$ELSEC}

TYPE
	TQAMethodSelector 			= SInt32;
CONST
	kQAMethod_RenderCompletion	= 0;							{  Called when rendering has completed and buffers swapped  }
	kQAMethod_DisplayModeChanged = 1;							{  Called when a display mode has changed  }
	kQAMethod_ReloadTextures	= 2;							{  Called when texture memory has been invalidated  }
	kQAMethod_ImageBufferInitialize = 3;						{  Called when a buffer needs to be initialized  }
	kQAMethod_ImageBuffer2DComposite = 4;						{  Called when rendering is finished and its safe to composite  }
	kQAMethod_NumSelectors		= 5;

{$ENDC}  {RAVE_OBSOLETE}

	{	
	 * kQATriFlags_xxx are ORed together to generate the 'flags' parameter
	 * to QADrawTriGouraud() and QADrawTriTexture().
	 	}
	kQATriFlags_None			= 0;							{  No flags (triangle is front-facing or don't care)  }
	kQATriFlags_Backfacing		= $01;							{  Triangle is back-facing  }

	{	
	 * kQATexture_xxx are ORed together to generate the 'flags' parameter to QATextureNew().
	 	}
	kQATexture_None				= 0;							{  No flags  }
	kQATexture_Lock				= $01;							{  Don't swap this texture out  }
	kQATexture_Mipmap			= $02;							{  This texture is mipmapped  }
	kQATexture_NoCompression	= $04;							{  Do not compress this texture  }
	kQATexture_HighCompression	= $08;							{  Compress texture, even if it takes a while  }
	kQATexture_NonRelocatable	= $10;							{  Image buffer in VRAM should be non-relocatable  }
	kQATexture_NoCopy			= $20;							{  Don't copy image to VRAM when creating it  }
	kQATexture_FlipOrigin		= $40;							{  The image(s) is(are) in a bottom-up format. (The image(s) is(are) flipped vertically.)  }
	kQATexture_PriorityBits		= $F0000000;					{  Texture priority: 4 upper bits for 16 levels of priority  }

	{	
	 * kQABitmap_xxx are ORed together to generate the 'flags' parameter to QABitmapNew().
	 	}
	kQABitmap_None				= 0;							{  No flags  }
	kQABitmap_Lock				= $02;							{  Don't swap this bitmap out  }
	kQABitmap_NoCompression		= $04;							{  Do not compress this bitmap  }
	kQABitmap_HighCompression	= $08;							{  Compress bitmap, even if it takes a while  }
	kQABitmap_NonRelocatable	= $10;							{  Image buffer in VRAM should be non-relocatable  }
	kQABitmap_NoCopy			= $20;							{  Don't copy image to VRAM when creating it  }
	kQABitmap_FlipOrigin		= $40;							{  The image is in a bottom-up format. (The image is flipped vertically.)  }
	kQABitmap_PriorityBits		= $F0000000;					{  Bitmap priority: 4 upper bits for 16 levels of priority  }

	{	
	 * kQAContext_xxx are ORed together to generate the 'flags' parameter for QADrawContextNew().
	 	}
	kQAContext_None				= 0;							{  No flags  }
	kQAContext_NoZBuffer		= $01;							{  No hidden surface removal  }
	kQAContext_DeepZ			= $02;							{  Hidden surface precision >= 24 bits  }
	kQAContext_DoubleBuffer		= $04;							{  Double buffered window  }
	kQAContext_Cache			= $08;							{  This is a cache context  }
	kQAContext_NoDither			= $10;							{  No dithering, straight color banding  }
	kQAContext_Scale			= $20;							{  The draw context is to be scaled.  The front buffer is a different size than the back buffer.  }
	kQAContext_NonRelocatable	= $40;							{  The back buffer and the z buffer must not move in memory  }
	kQAContext_EngineSpecific1	= $10000000;					{  engine specific flag # 1  }
	kQAContext_EngineSpecific2	= $20000000;					{  engine specific flag # 2  }
	kQAContext_EngineSpecific3	= $40000000;					{  engine specific flag # 3  }
	kQAContext_EngineSpecific4	= $80000000;					{  engine specific flag # 4  }

	{	
	 * kQAOptional_xxx are ORed together to generate the kQAGestalt_OptionalFeatures response
	 * from QAEngineGestalt().
	 	}
	kQAOptional_None			= 0;							{  No optional features  }
	kQAOptional_DeepZ			= $01;							{  Hidden surface precision >= 24 bits  }
	kQAOptional_Texture			= $02;							{  Texture mapping  }
	kQAOptional_TextureHQ		= $04;							{  High quality texture (tri-linear mip or better)  }
	kQAOptional_TextureColor	= $08;							{  Full color modulation and highlight of textures  }
	kQAOptional_Blend			= $10;							{  Transparency blending of RGB  }
	kQAOptional_BlendAlpha		= $20;							{  Transparency blending includes alpha channel  }
	kQAOptional_Antialias		= $40;							{  Antialiased rendering  }
	kQAOptional_ZSorted			= $80;							{  Z sorted rendering (for transparency, etc.)  }
	kQAOptional_PerspectiveZ	= $0100;						{  Hidden surface removal using InvW instead of Z  }
	kQAOptional_OpenGL			= $0200;						{  Extended rasterization features for OpenGL™  }
	kQAOptional_NoClear			= $0400;						{  This drawing engine doesn't clear before drawing  }
	kQAOptional_CSG				= $0800;						{  kQATag_CSGxxx are implemented  }
	kQAOptional_BoundToDevice	= $1000;						{  This engine is tightly bound to GDevice  }
	kQAOptional_CL4				= $2000;						{  This engine suports kQAPixel_CL4  }
	kQAOptional_CL8				= $4000;						{  This engine suports kQAPixel_CL8  }
	kQAOptional_BufferComposite	= $8000;						{  This engine can composite with initial buffer contents  }
	kQAOptional_NoDither		= $00010000;					{  This engine can draw with no dithering  }
	kQAOptional_FogAlpha		= $00020000;					{  This engine suports alpha based fog  }
	kQAOptional_FogDepth		= $00040000;					{  This engine suports depth based fog  }
	kQAOptional_MultiTextures	= $00080000;					{  This bit set if engine supports texture compositing  }
	kQAOptional_MipmapBias		= $00100000;					{  This bit is set if the engine supports mipmap selection bias  }
	kQAOptional_ChannelMask		= $00200000;
	kQAOptional_ZBufferMask		= $00400000;
	kQAOptional_AlphaTest		= $00800000;					{  this engine supports alpha testing  }
	kQAOptional_AccessTexture	= $01000000;					{  if engine supports access to texture  }
	kQAOptional_AccessBitmap	= $02000000;					{  if engine supports access to bitmaps  }
	kQAOptional_AccessDrawBuffer = $04000000;					{  if engine supports access to draw buffer  }
	kQAOptional_AccessZBuffer	= $08000000;					{  if engine supports access to zbuffer  }
	kQAOptional_ClearDrawBuffer	= $10000000;					{  if engine supports QAClearDrawBuffer()  }
	kQAOptional_ClearZBuffer	= $20000000;					{  if engine supports QAClearZBuffer()  }
	kQAOptional_OffscreenDrawContexts = $40000000;				{  if engine supports TQADeviceOffscreen  }

	{	
	 * kQAOptional2_xxx are ORed together to generate the kQAGestalt_OptionalFeatures2 response
	 * from QAEngineGestalt().
	 	}
	kQAOptional2_None			= 0;
	kQAOptional2_TextureDrawContexts = $02;						{  if engine supports QATextureNewFromDrawContext()  }
	kQAOptional2_BitmapDrawContexts = $04;						{  if engine supports QABitmapNewFromDrawContext()  }
	kQAOptional2_Busy			= $08;							{  if engine supports QABusy()  }
	kQAOptional2_SwapBuffers	= $10;							{  if engine supports QASwapBuffers()  }
	kQAOptional2_Chromakey		= $20;							{  if engine supports chromakeying via kQATag_Chromakey_xxx  }
	kQAOptional2_NonRelocatable	= $40;							{  if engine supports nonrelocatable texture & bitmap image buffers in VRAM  }
	kQAOptional2_NoCopy			= $80;							{  if engine supports ability to not copy texture & bitmap image to VRAM  }
	kQAOptional2_PriorityBits	= $0100;						{  if engine supports texture & bitmap priority levels  }
	kQAOptional2_FlipOrigin		= $0200;						{  if engine supports textures & bitmaps that are vertically flipped  }
	kQAOptional2_BitmapScale	= $0400;						{  if engine supports scaled bitmap drawing  }
	kQAOptional2_DrawContextScale = $0800;						{  if engine supports scaled draw contexts  }
	kQAOptional2_DrawContextNonRelocatable = $1000;				{  if engine supports draw contexts with non relocatable buffers  }


	{	
	 * kQAFast_xxx are ORed together to generate the kQAGestalt_FastFeatures response
	 * from QAEngineGestalt().
	 	}
	kQAFast_None				= 0;							{  No accelerated features  }
	kQAFast_Line				= $01;							{  Line drawing  }
	kQAFast_Gouraud				= $02;							{  Gouraud shaded triangles  }
	kQAFast_Texture				= $04;							{  Texture mapped triangles  }
	kQAFast_TextureHQ			= $08;							{  High quality texture (tri-linear mip or better)  }
	kQAFast_Blend				= $10;							{  Transparency blending  }
	kQAFast_Antialiasing		= $20;							{  Antialiased rendering  }
	kQAFast_ZSorted				= $40;							{  Z sorted rendering of non-opaque objects  }
	kQAFast_CL4					= $80;							{  This engine accelerates kQAPixel_CL4  }
	kQAFast_CL8					= $0100;						{  This engine accelerates kQAPixel_CL8  }
	kQAFast_FogAlpha			= $0200;						{  This engine accelerates alpha based fog  }
	kQAFast_FogDepth			= $0400;						{  This engine accelerates depth based fog  }
	kQAFast_MultiTextures		= $0800;						{  This engine accelerates texture compositing  }
	kQAFast_BitmapScale			= $1000;						{  This engine accelerates scaled bitmap drawing  }
	kQAFast_DrawContextScale	= $2000;						{  This engine accelerates scaled draw contexts  }






	{	*******************************************************************
	 * TQAVersion sets the TQADrawContext 'version' field. It is set by
	 * the manager to indicate the version of the TQADrawContext structure.
	 ******************************************************************	}

TYPE
	TQAVersion 					= SInt32;
CONST
	kQAVersion_Prerelease		= 0;
	kQAVersion_1_0				= 1;
	kQAVersion_1_0_5			= 2;							{  Added tri mesh functions, color tables  }
	kQAVersion_1_5				= 3;							{  Added call backs, texture compression, and new error return code  }
	kQAVersion_1_6				= 4;							{  Added QAAccess_xxx, fog, _Options2, Clear_xxx, etc.  }



	{	**********************************************************************
	 * TQADrawContext structure holds method pointers.
	 * This is a forward refrence. The structure is defined later.
	 *********************************************************************	}

TYPE
	TQADrawContextPtr = ^TQADrawContext;
	{	***********************************************************************************************
	 *
	 * Typedefs of draw method functions provided by the drawing engine. One function pointer
	 * for each of these function types in stored in the TQADrawContext public data structure.
	 *
	 * These functions should be accessed through the QA<function>(context,...) macros,
	 * defined above.
	 *
	 **********************************************************************************************	}
{$IFC TYPED_FUNCTION_POINTERS}
	TQAStandardNoticeMethod = PROCEDURE({CONST}VAR drawContext: TQADrawContext; refCon: UNIV Ptr); C;
{$ELSEC}
	TQAStandardNoticeMethod = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQABufferNoticeMethod = PROCEDURE({CONST}VAR drawContext: TQADrawContext; {CONST}VAR buffer: TQADevice; {CONST}VAR dirtyRect: TQARect; refCon: UNIV Ptr); C;
{$ELSEC}
	TQABufferNoticeMethod = ProcPtr;
{$ENDC}

	TQANoticeMethodPtr = ^TQANoticeMethod;
	TQANoticeMethod = RECORD
		CASE INTEGER OF
		0: (
			standardNoticeMethod: TQAStandardNoticeMethod;				{  Used for non-buffer related methods  }
			);
		1: (
			bufferNoticeMethod:	TQABufferNoticeMethod;					{  Used for buffer handling methods  }
			);
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	TQASetFloat = PROCEDURE(drawContext: TQADrawContextPtr; tag: TQATagFloat; newValue: Single); C;
{$ELSEC}
	TQASetFloat = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQASetInt = PROCEDURE(drawContext: TQADrawContextPtr; tag: TQATagInt; newValue: UInt32); C;
{$ELSEC}
	TQASetInt = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQASetPtr = PROCEDURE(drawContext: TQADrawContextPtr; tag: TQATagPtr; newValue: UNIV Ptr); C;
{$ELSEC}
	TQASetPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQAGetFloat = FUNCTION({CONST}VAR drawContext: TQADrawContext; tag: TQATagFloat): Single; C;
{$ELSEC}
	TQAGetFloat = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQAGetInt = FUNCTION({CONST}VAR drawContext: TQADrawContext; tag: TQATagInt): UInt32; C;
{$ELSEC}
	TQAGetInt = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQAGetPtr = FUNCTION({CONST}VAR drawContext: TQADrawContext; tag: TQATagPtr): Ptr; C;
{$ELSEC}
	TQAGetPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQADrawPoint = PROCEDURE({CONST}VAR drawContext: TQADrawContext; {CONST}VAR v: TQAVGouraud); C;
{$ELSEC}
	TQADrawPoint = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQADrawLine = PROCEDURE({CONST}VAR drawContext: TQADrawContext; {CONST}VAR v0: TQAVGouraud; {CONST}VAR v1: TQAVGouraud); C;
{$ELSEC}
	TQADrawLine = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQADrawTriGouraud = PROCEDURE({CONST}VAR drawContext: TQADrawContext; {CONST}VAR v0: TQAVGouraud; {CONST}VAR v1: TQAVGouraud; {CONST}VAR v2: TQAVGouraud; flags: UInt32); C;
{$ELSEC}
	TQADrawTriGouraud = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQADrawTriTexture = PROCEDURE({CONST}VAR drawContext: TQADrawContext; {CONST}VAR v0: TQAVTexture; {CONST}VAR v1: TQAVTexture; {CONST}VAR v2: TQAVTexture; flags: UInt32); C;
{$ELSEC}
	TQADrawTriTexture = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQASubmitVerticesGouraud = PROCEDURE({CONST}VAR drawContext: TQADrawContext; nVertices: UInt32; {CONST}VAR vertices: TQAVGouraud); C;
{$ELSEC}
	TQASubmitVerticesGouraud = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQASubmitVerticesTexture = PROCEDURE({CONST}VAR drawContext: TQADrawContext; nVertices: UInt32; {CONST}VAR vertices: TQAVTexture); C;
{$ELSEC}
	TQASubmitVerticesTexture = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQADrawTriMeshGouraud = PROCEDURE({CONST}VAR drawContext: TQADrawContext; nTriangles: UInt32; {CONST}VAR triangles: TQAIndexedTriangle); C;
{$ELSEC}
	TQADrawTriMeshGouraud = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQADrawTriMeshTexture = PROCEDURE({CONST}VAR drawContext: TQADrawContext; nTriangles: UInt32; {CONST}VAR triangles: TQAIndexedTriangle); C;
{$ELSEC}
	TQADrawTriMeshTexture = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQADrawVGouraud = PROCEDURE({CONST}VAR drawContext: TQADrawContext; nVertices: UInt32; vertexMode: TQAVertexMode; {CONST}VAR vertices: TQAVGouraud; {CONST}VAR flags: UInt32); C;
{$ELSEC}
	TQADrawVGouraud = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQADrawVTexture = PROCEDURE({CONST}VAR drawContext: TQADrawContext; nVertices: UInt32; vertexMode: TQAVertexMode; {CONST}VAR vertices: TQAVTexture; {CONST}VAR flags: UInt32); C;
{$ELSEC}
	TQADrawVTexture = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQADrawBitmap = PROCEDURE({CONST}VAR drawContext: TQADrawContext; {CONST}VAR v: TQAVGouraud; VAR bitmap: TQABitmap); C;
{$ELSEC}
	TQADrawBitmap = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQARenderStart = PROCEDURE({CONST}VAR drawContext: TQADrawContext; {CONST}VAR dirtyRect: TQARect; {CONST}VAR initialContext: TQADrawContext); C;
{$ELSEC}
	TQARenderStart = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQARenderEnd = FUNCTION({CONST}VAR drawContext: TQADrawContext; {CONST}VAR modifiedRect: TQARect): TQAError; C;
{$ELSEC}
	TQARenderEnd = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQARenderAbort = FUNCTION({CONST}VAR drawContext: TQADrawContext): TQAError; C;
{$ELSEC}
	TQARenderAbort = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQAFlush = FUNCTION({CONST}VAR drawContext: TQADrawContext): TQAError; C;
{$ELSEC}
	TQAFlush = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQASync = FUNCTION({CONST}VAR drawContext: TQADrawContext): TQAError; C;
{$ELSEC}
	TQASync = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQASetNoticeMethod = FUNCTION({CONST}VAR drawContext: TQADrawContext; method: TQAMethodSelector; completionCallBack: TQANoticeMethod; refCon: UNIV Ptr): TQAError; C;
{$ELSEC}
	TQASetNoticeMethod = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQAGetNoticeMethod = FUNCTION({CONST}VAR drawContext: TQADrawContext; method: TQAMethodSelector; VAR completionCallBack: TQANoticeMethod; VAR refCon: UNIV Ptr): TQAError; C;
{$ELSEC}
	TQAGetNoticeMethod = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQASubmitMultiTextureParams = PROCEDURE({CONST}VAR drawContext: TQADrawContext; nParams: UInt32; {CONST}VAR params: TQAVMultiTexture); C;
{$ELSEC}
	TQASubmitMultiTextureParams = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQAAccessDrawBuffer = FUNCTION({CONST}VAR drawContext: TQADrawContext; VAR buffer: TQAPixelBuffer): TQAError; C;
{$ELSEC}
	TQAAccessDrawBuffer = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQAAccessDrawBufferEnd = FUNCTION({CONST}VAR drawContext: TQADrawContext; {CONST}VAR dirtyRect: TQARect): TQAError; C;
{$ELSEC}
	TQAAccessDrawBufferEnd = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQAAccessZBuffer = FUNCTION({CONST}VAR drawContext: TQADrawContext; VAR buffer: TQAZBuffer): TQAError; C;
{$ELSEC}
	TQAAccessZBuffer = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQAAccessZBufferEnd = FUNCTION({CONST}VAR drawContext: TQADrawContext; {CONST}VAR dirtyRect: TQARect): TQAError; C;
{$ELSEC}
	TQAAccessZBufferEnd = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQAClearDrawBuffer = FUNCTION({CONST}VAR drawContext: TQADrawContext; {CONST}VAR rect: TQARect; {CONST}VAR initialContext: TQADrawContext): TQAError; C;
{$ELSEC}
	TQAClearDrawBuffer = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQAClearZBuffer = FUNCTION({CONST}VAR drawContext: TQADrawContext; {CONST}VAR rect: TQARect; {CONST}VAR initialContext: TQADrawContext): TQAError; C;
{$ELSEC}
	TQAClearZBuffer = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQATextureNewFromDrawContext = FUNCTION({CONST}VAR drawContext: TQADrawContext; flags: UInt32; VAR newTexture: UNIV Ptr): TQAError; C;
{$ELSEC}
	TQATextureNewFromDrawContext = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQABitmapNewFromDrawContext = FUNCTION({CONST}VAR drawContext: TQADrawContext; flags: UInt32; VAR newBitmap: UNIV Ptr): TQAError; C;
{$ELSEC}
	TQABitmapNewFromDrawContext = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQABusy = FUNCTION({CONST}VAR drawContext: TQADrawContext): ByteParameter; C;
{$ELSEC}
	TQABusy = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQASwapBuffers = FUNCTION({CONST}VAR drawContext: TQADrawContext; {CONST}VAR dirtyRect: TQARect): TQAError; C;
{$ELSEC}
	TQASwapBuffers = ProcPtr;
{$ENDC}

	{	***********************************************************************************************
	 *
	 * Public TQADrawContext structure. This contains function pointers for the chosen
	 * drawing engine.
	 *
	 **********************************************************************************************	}
	TQADrawContext = RECORD
		drawPrivate:			TQADrawPrivatePtr;						{  Engine's private data for this context  }
		version:				TQAVersion;								{  Version number  }
		setFloat:				TQASetFloat;							{  Method: Set a float state variable  }
		setInt:					TQASetInt;								{  Method: Set an unsigned long state variable  }
		setPtr:					TQASetPtr;								{  Method: Set an unsigned long state variable  }
		getFloat:				TQAGetFloat;							{  Method: Get a float state variable  }
		getInt:					TQAGetInt;								{  Method: Get an unsigned long state variable  }
		getPtr:					TQAGetPtr;								{  Method: Get an pointer state variable  }
		drawPoint:				TQADrawPoint;							{  Method: Draw a point  }
		drawLine:				TQADrawLine;							{  Method: Draw a line  }
		drawTriGouraud:			TQADrawTriGouraud;						{  Method: Draw a Gouraud shaded triangle  }
		drawTriTexture:			TQADrawTriTexture;						{  Method: Draw a texture mapped triangle  }
		drawVGouraud:			TQADrawVGouraud;						{  Method: Draw Gouraud vertices  }
		drawVTexture:			TQADrawVTexture;						{  Method: Draw texture vertices  }
		drawBitmap:				TQADrawBitmap;							{  Method: Draw a bitmap  }
		renderStart:			TQARenderStart;							{  Method: Initialize for rendering  }
		renderEnd:				TQARenderEnd;							{  Method: Complete rendering and display  }
		renderAbort:			TQARenderAbort;							{  Method: Abort any outstanding rendering (blocking)  }
		flush:					TQAFlush;								{  Method: Start render of any queued commands (non-blocking)  }
		sync:					TQASync;								{  Method: Wait for completion of all rendering (blocking)  }
		submitVerticesGouraud:	TQASubmitVerticesGouraud;				{  Method: Submit Gouraud vertices for trimesh  }
		submitVerticesTexture:	TQASubmitVerticesTexture;				{  Method: Submit Texture vertices for trimesh  }
		drawTriMeshGouraud:		TQADrawTriMeshGouraud;					{  Method: Draw a Gouraud triangle mesh  }
		drawTriMeshTexture:		TQADrawTriMeshTexture;					{  Method: Draw a Texture triangle mesh  }
		setNoticeMethod:		TQASetNoticeMethod;						{  Method: Set a notice method  }
		getNoticeMethod:		TQAGetNoticeMethod;						{  Method: Get a notice method  }
		submitMultiTextureParams: TQASubmitMultiTextureParams;			{  Method: Submit Secondary texture params  }
		accessDrawBuffer:		TQAAccessDrawBuffer;
		accessDrawBufferEnd:	TQAAccessDrawBufferEnd;
		accessZBuffer:			TQAAccessZBuffer;
		accessZBufferEnd:		TQAAccessZBufferEnd;
		clearDrawBuffer:		TQAClearDrawBuffer;
		clearZBuffer:			TQAClearZBuffer;
		textureFromContext:		TQATextureNewFromDrawContext;
		bitmapFromContext:		TQABitmapNewFromDrawContext;
		busy:					TQABusy;
		swapBuffers:			TQASwapBuffers;
	END;

	{	***********************************************************************************************
	 *
	 * Acceleration manager function prototypes.
	 *
	 **********************************************************************************************	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  QADrawContextNew()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION QADrawContextNew({CONST}VAR device: TQADevice; {CONST}VAR rect: TQARect; {CONST}VAR clip: TQAClip; {CONST}VAR engine: TQAEngine; flags: UInt32; VAR newDrawContext: UNIV Ptr): TQAError; C;

{
 *  QADrawContextDelete()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE QADrawContextDelete(VAR drawContext: TQADrawContext); C;

{
 *  QAColorTableNew()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION QAColorTableNew({CONST}VAR engine: TQAEngine; tableType: TQAColorTableType; pixelData: UNIV Ptr; transparentIndexFlag: LONGINT; VAR newTable: UNIV Ptr): TQAError; C;

{
 *  QAColorTableDelete()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE QAColorTableDelete({CONST}VAR engine: TQAEngine; VAR colorTable: TQAColorTable); C;

{
 *  QATextureNew()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION QATextureNew({CONST}VAR engine: TQAEngine; flags: UInt32; pixelType: TQAImagePixelType; {CONST}VAR images: TQAImage; VAR newTexture: UNIV Ptr): TQAError; C;

{
 *  QATextureDetach()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION QATextureDetach({CONST}VAR engine: TQAEngine; VAR texture: TQATexture): TQAError; C;

{
 *  QATextureDelete()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE QATextureDelete({CONST}VAR engine: TQAEngine; VAR texture: TQATexture); C;

{
 *  QATextureBindColorTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION QATextureBindColorTable({CONST}VAR engine: TQAEngine; VAR texture: TQATexture; VAR colorTable: TQAColorTable): TQAError; C;

{
 *  QABitmapNew()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION QABitmapNew({CONST}VAR engine: TQAEngine; flags: UInt32; pixelType: TQAImagePixelType; {CONST}VAR image: TQAImage; VAR newBitmap: UNIV Ptr): TQAError; C;

{
 *  QABitmapDetach()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION QABitmapDetach({CONST}VAR engine: TQAEngine; VAR bitmap: TQABitmap): TQAError; C;

{
 *  QABitmapDelete()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE QABitmapDelete({CONST}VAR engine: TQAEngine; VAR bitmap: TQABitmap); C;

{
 *  QABitmapBindColorTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION QABitmapBindColorTable({CONST}VAR engine: TQAEngine; VAR bitmap: TQABitmap; VAR colorTable: TQAColorTable): TQAError; C;

{
 *  QADeviceGetFirstEngine()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION QADeviceGetFirstEngine({CONST}VAR device: TQADevice): TQAEnginePtr; C;

{
 *  QADeviceGetNextEngine()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION QADeviceGetNextEngine({CONST}VAR device: TQADevice; {CONST}VAR currentEngine: TQAEngine): TQAEnginePtr; C;

{
 *  QAEngineCheckDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION QAEngineCheckDevice({CONST}VAR engine: TQAEngine; {CONST}VAR device: TQADevice): TQAError; C;

{
 *  QAEngineGestalt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION QAEngineGestalt({CONST}VAR engine: TQAEngine; selector: TQAGestaltSelector; response: UNIV Ptr): TQAError; C;

{
 *  QAEngineEnable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION QAEngineEnable(vendorID: LONGINT; engineID: LONGINT): TQAError; C;

{
 *  QAEngineDisable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION QAEngineDisable(vendorID: LONGINT; engineID: LONGINT): TQAError; C;


{
 *  QAAccessTexture()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION QAAccessTexture({CONST}VAR engine: TQAEngine; VAR texture: TQATexture; mipmapLevel: LONGINT; flags: LONGINT; VAR buffer: TQAPixelBuffer): TQAError; C;

{
 *  QAAccessTextureEnd()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION QAAccessTextureEnd({CONST}VAR engine: TQAEngine; VAR texture: TQATexture; {CONST}VAR dirtyRect: TQARect): TQAError; C;

{
 *  QAAccessBitmap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION QAAccessBitmap({CONST}VAR engine: TQAEngine; VAR bitmap: TQABitmap; flags: LONGINT; VAR buffer: TQAPixelBuffer): TQAError; C;

{
 *  QAAccessBitmapEnd()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION QAAccessBitmapEnd({CONST}VAR engine: TQAEngine; VAR bitmap: TQABitmap; {CONST}VAR dirtyRect: TQARect): TQAError; C;




{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC TARGET_OS_MAC }
{$IFC CALL_NOT_IN_CARBON }
{
 *  QARegisterDrawNotificationProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION QARegisterDrawNotificationProc(VAR globalRect: Rect; proc: TQADrawNotificationProcPtr; refCon: LONGINT; VAR refNum: TQADrawNotificationProcRefNum): TQAError; C;

{
 *  QAUnregisterDrawNotificationProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION QAUnregisterDrawNotificationProc(refNum: TQADrawNotificationProcRefNum): TQAError; C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_OS_MAC}







{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := RAVEIncludes}

{$ENDC} {__RAVE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
