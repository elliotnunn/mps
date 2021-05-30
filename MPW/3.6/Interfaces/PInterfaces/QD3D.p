{
     File:       QD3D.p
 
     Contains:   Base types for Quickdraw 3D
 
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
 UNIT QD3D;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3D__}
{$SETC __QD3D__ := 1}

{$I+}
{$SETC QD3DIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}

{$IFC TARGET_OS_MAC }
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$ENDC}  {TARGET_OS_MAC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{$IFC TARGET_OS_MAC }
{$SETC OS_MACINTOSH := 1 }
{$SETC OS_WIN32 := 0 }
{$SETC OS_UNIX := 0 }
{$SETC OS_NEXT := 0 }
{$SETC WINDOW_SYSTEM_MACINTOSH := 1 }
{$SETC WINDOW_SYSTEM_WIN32 := 0 }
{$SETC WINDOW_SYSTEM_X11 := 0 }
{$SETC WINDOW_SYSTEM_NEXT := 0 }
{$ENDC}  {TARGET_OS_MAC}


{*****************************************************************************
 **                                                                          **
 **                             NULL definition                              **
 **                                                                          **
 ****************************************************************************}
{*****************************************************************************
 **                                                                          **
 **                                 Objects                                  **
 **                                                                          **
 ****************************************************************************}
{
 * Everything in QuickDraw 3D is an OBJECT: a bunch of data with a type,
 * deletion, duplication, and i/o methods.
 }

TYPE
	TQ3ObjectType						= LONGINT;
	TQ3ObjectTypePtr					= ^TQ3ObjectType;
	TQ3Object    = ^LONGINT; { an opaque 32-bit type }
	TQ3ObjectPtr = ^TQ3Object;  { when a VAR xx:TQ3Object parameter can be nil, it is changed to xx: TQ3ObjectPtr }
	{   }
	{	
	 * There are four subclasses of OBJECT:
	 *  an ELEMENT, which is data that is placed in a SET
	 *  a SHAREDOBJECT, which is reference-counted data that is shared
	 *  VIEWs, which maintain state information for an image
	 *  a PICK, which used to query a VIEW
	 	}
	TQ3ElementObject					= TQ3Object;
	TQ3SharedObject						= TQ3Object;
	TQ3ViewObject						= TQ3Object;
	TQ3PickObject						= TQ3Object;
	{	
	 * There are several types of SharedObjects:
	 *  RENDERERs, which paint to a drawContext
	 *  DRAWCONTEXTs, which are an interface to a device 
	 *  SETs, which maintains "mathematical sets" of ELEMENTs
	 *  FILEs, which maintain state information for a metafile
	 *  SHAPEs, which affect the state of the View
	 *  SHAPEPARTs, which contain geometry-specific data about a picking hit
	 *  CONTROLLERSTATEs, which hold state of the output channels for a CONTROLLER
	 *  TRACKERs, which represent a position and orientation in the user interface
	 *  STRINGs, which are abstractions of text string data.
	 *  STORAGE, which is an abstraction for stream-based data storage (files, memory)
	 *  TEXTUREs, for sharing bitmap information for TEXTURESHADERS
	 *  VIEWHINTs, which specifies viewing preferences in FILEs
	 	}
	TQ3RendererObject					= TQ3SharedObject;
	TQ3DrawContextObject				= TQ3SharedObject;
	TQ3SetObject						= TQ3SharedObject;
	TQ3FileObject						= TQ3SharedObject;
	TQ3ShapeObject						= TQ3SharedObject;
	TQ3ShapePartObject					= TQ3SharedObject;
	TQ3ControllerStateObject			= TQ3SharedObject;
	TQ3TrackerObject					= TQ3SharedObject;
	TQ3StringObject						= TQ3SharedObject;
	TQ3StorageObject					= TQ3SharedObject;
	TQ3TextureObject					= TQ3SharedObject;
	TQ3ViewHintsObject					= TQ3SharedObject;
	{	
	 * There is one types of SET:
	 *  ATTRIBUTESETs, which contain ATTRIBUTEs which are inherited 
	 	}
	TQ3AttributeSet						= TQ3SetObject;
	TQ3AttributeSetPtr					= ^TQ3AttributeSet;
	{	
	 * There are many types of SHAPEs:
	 *  LIGHTs, which affect how the RENDERER draws 3-D cues
	 *  CAMERAs, which affects the location and orientation of the RENDERER in space
	 *  GROUPs, which may contain any number of SHARED OBJECTS
	 *  GEOMETRYs, which are representations of three-dimensional data
	 *  SHADERs, which affect how colors are drawn on a geometry
	 *  STYLEs, which affect how the RENDERER paints to the DRAWCONTEXT
	 *  TRANSFORMs, which affect the coordinate system in the VIEW
	 *  REFERENCEs, which are references to objects in FILEs
	 *  UNKNOWN, which hold unknown objects read from a metafile.
	 	}
	TQ3GroupObject						= TQ3ShapeObject;
	TQ3GeometryObject					= TQ3ShapeObject;
	TQ3ShaderObject						= TQ3ShapeObject;
	TQ3StyleObject						= TQ3ShapeObject;
	TQ3TransformObject					= TQ3ShapeObject;
	TQ3LightObject						= TQ3ShapeObject;
	TQ3CameraObject						= TQ3ShapeObject;
	TQ3UnknownObject					= TQ3ShapeObject;
	TQ3ReferenceObject					= TQ3ShapeObject;
	TQ3StateOperatorObject				= TQ3ShapeObject;
	{	
	 * For now, there is only one type of SHAPEPARTs:
	 *  MESHPARTs, which describe some part of a mesh
	 	}
	TQ3MeshPartObject					= TQ3ShapePartObject;
	{	
	 * There are three types of MESHPARTs:
	 *  MESHFACEPARTs, which describe a face of a mesh
	 *  MESHEDGEPARTs, which describe a edge of a mesh
	 *  MESHVERTEXPARTs, which describe a vertex of a mesh
	 	}
	TQ3MeshFacePartObject				= TQ3MeshPartObject;
	TQ3MeshEdgePartObject				= TQ3MeshPartObject;
	TQ3MeshVertexPartObject				= TQ3MeshPartObject;
	{	
	 * A DISPLAY Group can be drawn to a view
	 	}
	TQ3DisplayGroupObject				= TQ3GroupObject;
	{	
	 * There are many types of SHADERs:
	 *  SURFACESHADERs, which affect how the surface of a geometry is painted
	 *  ILLUMINATIONSHADERs, which affect how lights affect the color of a surface
	 	}
	TQ3SurfaceShaderObject				= TQ3ShaderObject;
	TQ3IlluminationShaderObject			= TQ3ShaderObject;
	{	
	 * A handle to an object in a group
	 	}
	TQ3GroupPosition    = ^LONGINT; { an opaque 32-bit type }
	TQ3GroupPositionPtr = ^TQ3GroupPosition;  { when a VAR xx:TQ3GroupPosition parameter can be nil, it is changed to xx: TQ3GroupPositionPtr }
	{	 
	 * TQ3ObjectClassNameString is used for the class name of an object
	 	}

CONST
	kQ3StringMaximumLength		= 1024;


TYPE
	TQ3ObjectClassNameString			= PACKED ARRAY [0..1023] OF CHAR;
	{	*****************************************************************************
	 **                                                                          **
	 **                         Client/Server Things                             **
	 **                                                                          **
	 ****************************************************************************	}
	TQ3ControllerRef					= Ptr;
	{	*****************************************************************************
	 **                                                                          **
	 **                         Flags and Switches                               **
	 **                                                                          **
	 ****************************************************************************	}
	TQ3Boolean 					= SInt32;
CONST
	kQ3False					= 0;
	kQ3True						= 1;


TYPE
	TQ3Switch 					= SInt32;
CONST
	kQ3Off						= 0;
	kQ3On						= 1;


TYPE
	TQ3Status 					= SInt32;
CONST
	kQ3Failure					= 0;
	kQ3Success					= 1;


TYPE
	TQ3Axis 					= SInt32;
CONST
	kQ3AxisX					= 0;
	kQ3AxisY					= 1;
	kQ3AxisZ					= 2;


TYPE
	TQ3PixelType 				= SInt32;
CONST
	kQ3PixelTypeRGB32			= 0;							{  Alpha:8 (ignored), R:8, G:8, B:8    }
	kQ3PixelTypeARGB32			= 1;							{  Alpha:8, R:8, G:8, B:8           }
	kQ3PixelTypeRGB16			= 2;							{  Alpha:1 (ignored), R:5, G:5, B:5    }
	kQ3PixelTypeARGB16			= 3;							{  Alpha:1, R:5, G:5, B:5           }
	kQ3PixelTypeRGB16_565		= 4;							{  Win32 only: 16 bits/pixel, R:5, G:6, B:5      }
	kQ3PixelTypeRGB24			= 5;							{  Win32 only: 24 bits/pixel, R:8, G:8, B:8      }


TYPE
	TQ3Endian 					= SInt32;
CONST
	kQ3EndianBig				= 0;
	kQ3EndianLittle				= 1;


TYPE
	TQ3EndCapMasks 				= SInt32;
CONST
	kQ3EndCapNone				= 0;
	kQ3EndCapMaskTop			= $01;
	kQ3EndCapMaskBottom			= $02;
	kQ3EndCapMaskInterior		= $04;


TYPE
	TQ3EndCap							= UInt32;

CONST
	kQ3ArrayIndexNULL			= -1;

	{	*****************************************************************************
	 **                                                                          **
	 **                     Point and Vector Definitions                         **
	 **                                                                          **
	 ****************************************************************************	}

TYPE
	TQ3Vector2DPtr = ^TQ3Vector2D;
	TQ3Vector2D = RECORD
		x:						Single;
		y:						Single;
	END;

	TQ3Vector3DPtr = ^TQ3Vector3D;
	TQ3Vector3D = RECORD
		x:						Single;
		y:						Single;
		z:						Single;
	END;

	TQ3Point2DPtr = ^TQ3Point2D;
	TQ3Point2D = RECORD
		x:						Single;
		y:						Single;
	END;

	TQ3Point3DPtr = ^TQ3Point3D;
	TQ3Point3D = RECORD
		x:						Single;
		y:						Single;
		z:						Single;
	END;

	TQ3RationalPoint4DPtr = ^TQ3RationalPoint4D;
	TQ3RationalPoint4D = RECORD
		x:						Single;
		y:						Single;
		z:						Single;
		w:						Single;
	END;

	TQ3RationalPoint3DPtr = ^TQ3RationalPoint3D;
	TQ3RationalPoint3D = RECORD
		x:						Single;
		y:						Single;
		w:						Single;
	END;

	{	*****************************************************************************
	 **                                                                          **
	 **                             Quaternion                                   **
	 **                                                                          **
	 ****************************************************************************	}
	TQ3QuaternionPtr = ^TQ3Quaternion;
	TQ3Quaternion = RECORD
		w:						Single;
		x:						Single;
		y:						Single;
		z:						Single;
	END;

	{	*****************************************************************************
	 **                                                                          **
	 **                             Ray Definition                               **
	 **                                                                          **
	 ****************************************************************************	}
	TQ3Ray3DPtr = ^TQ3Ray3D;
	TQ3Ray3D = RECORD
		origin:					TQ3Point3D;
		direction:				TQ3Vector3D;
	END;

	{	*****************************************************************************
	 **                                                                          **
	 **                     Parameterization Data Structures                     **
	 **                                                                          **
	 ****************************************************************************	}
	TQ3Param2DPtr = ^TQ3Param2D;
	TQ3Param2D = RECORD
		u:						Single;
		v:						Single;
	END;

	TQ3Param3DPtr = ^TQ3Param3D;
	TQ3Param3D = RECORD
		u:						Single;
		v:						Single;
		w:						Single;
	END;

	TQ3Tangent2DPtr = ^TQ3Tangent2D;
	TQ3Tangent2D = RECORD
		uTangent:				TQ3Vector3D;
		vTangent:				TQ3Vector3D;
	END;

	TQ3Tangent3DPtr = ^TQ3Tangent3D;
	TQ3Tangent3D = RECORD
		uTangent:				TQ3Vector3D;
		vTangent:				TQ3Vector3D;
		wTangent:				TQ3Vector3D;
	END;

	{	*****************************************************************************
	 **                                                                          **
	 **                     Polar and Spherical Coordinates                      **
	 **                                                                          **
	 ****************************************************************************	}
	TQ3PolarPointPtr = ^TQ3PolarPoint;
	TQ3PolarPoint = RECORD
		r:						Single;
		theta:					Single;
	END;

	TQ3SphericalPointPtr = ^TQ3SphericalPoint;
	TQ3SphericalPoint = RECORD
		rho:					Single;
		theta:					Single;
		phi:					Single;
	END;

	{	*****************************************************************************
	 **                                                                          **
	 **                         Color Definition                                 **
	 **                                                                          **
	 ****************************************************************************	}
	TQ3ColorRGBPtr = ^TQ3ColorRGB;
	TQ3ColorRGB = RECORD
		r:						Single;
		g:						Single;
		b:						Single;
	END;

	TQ3ColorARGBPtr = ^TQ3ColorARGB;
	TQ3ColorARGB = RECORD
		a:						Single;
		r:						Single;
		g:						Single;
		b:						Single;
	END;

	{	*****************************************************************************
	 **                                                                          **
	 **                                 Vertices                                 **
	 **                                                                          **
	 ****************************************************************************	}
	TQ3Vertex3DPtr = ^TQ3Vertex3D;
	TQ3Vertex3D = RECORD
		point:					TQ3Point3D;
		attributeSet:			TQ3AttributeSet;
	END;

	{	*****************************************************************************
	 **                                                                          **
	 **                                 Matrices                                 **
	 **                                                                          **
	 ****************************************************************************	}
	TQ3Matrix3x3Ptr = ^TQ3Matrix3x3;
	TQ3Matrix3x3 = RECORD
		value:					ARRAY [0..2,0..2] OF Single;
	END;

	TQ3Matrix4x4Ptr = ^TQ3Matrix4x4;
	TQ3Matrix4x4 = RECORD
		value:					ARRAY [0..3,0..3] OF Single;
	END;

	{	*****************************************************************************
	 **                                                                          **
	 **                             Bitmap/Pixmap                                **
	 **                                                                          **
	 ****************************************************************************	}
	TQ3PixmapPtr = ^TQ3Pixmap;
	TQ3Pixmap = RECORD
		image:					Ptr;
		width:					UInt32;
		height:					UInt32;
		rowBytes:				UInt32;
		pixelSize:				UInt32;									{  MUST be 16 or 32 to use with the   Interactive Renderer on Mac OS }
		pixelType:				TQ3PixelType;
		bitOrder:				TQ3Endian;
		byteOrder:				TQ3Endian;
	END;

	TQ3StoragePixmapPtr = ^TQ3StoragePixmap;
	TQ3StoragePixmap = RECORD
		image:					TQ3StorageObject;
		width:					UInt32;
		height:					UInt32;
		rowBytes:				UInt32;
		pixelSize:				UInt32;									{  MUST be 16 or 32 to use with the   Interactive Renderer on Mac OS }
		pixelType:				TQ3PixelType;
		bitOrder:				TQ3Endian;
		byteOrder:				TQ3Endian;
	END;

	TQ3BitmapPtr = ^TQ3Bitmap;
	TQ3Bitmap = RECORD
		image:					Ptr;
		width:					UInt32;
		height:					UInt32;
		rowBytes:				UInt32;
		bitOrder:				TQ3Endian;
	END;

	TQ3MipmapImagePtr = ^TQ3MipmapImage;
	TQ3MipmapImage = RECORD
																		{  An image for use as a texture mipmap   }
		width:					UInt32;									{  Width of mipmap, must be power of 2    }
		height:					UInt32;									{  Height of mipmap, must be power of 2   }
		rowBytes:				UInt32;									{  Rowbytes of mipmap                     }
		offset:					UInt32;									{  Offset from image base to this mipmap  }
	END;

	TQ3MipmapPtr = ^TQ3Mipmap;
	TQ3Mipmap = RECORD
		image:					TQ3StorageObject;						{  Data containing the texture map and      }
																		{  if (useMipmapping==kQ3True) the        }
																		{  mipmap data                   }
		useMipmapping:			TQ3Boolean;								{  True if mipmapping should be used    }
																		{  and all mipmaps have been provided     }
		pixelType:				TQ3PixelType;
		bitOrder:				TQ3Endian;
		byteOrder:				TQ3Endian;
		reserved:				UInt32;									{  leave NULL for next version           }
		mipmaps:				ARRAY [0..31] OF TQ3MipmapImage;		{  The actual number of mipmaps is determined from the size of the first mipmap  }
	END;



	TQ3CompressedPixmapPtr = ^TQ3CompressedPixmap;
	TQ3CompressedPixmap = RECORD
		compressedImage:		TQ3StorageObject;						{  storage obj containing compressed image data  }
		imageDescByteOrder:		TQ3Endian;								{  endianness of the data in the imageDesc  }
		imageDesc:				TQ3StorageObject;						{  storage obj containing image description created by Quicktime to store info about compressed image  }
		makeMipmaps:			TQ3Boolean;
		width:					UInt32;
		height:					UInt32;
		pixelSize:				UInt32;
		pixelType:				TQ3PixelType;
	END;


	{	*****************************************************************************
	 **                                                                          **
	 **                     Higher dimension quantities                          **
	 **                                                                          **
	 ****************************************************************************	}
	TQ3AreaPtr = ^TQ3Area;
	TQ3Area = RECORD
		min:					TQ3Point2D;
		max:					TQ3Point2D;
	END;

	TQ3PlaneEquationPtr = ^TQ3PlaneEquation;
	TQ3PlaneEquation = RECORD
		normal:					TQ3Vector3D;
		constant:				Single;
	END;

	TQ3BoundingBoxPtr = ^TQ3BoundingBox;
	TQ3BoundingBox = RECORD
		min:					TQ3Point3D;
		max:					TQ3Point3D;
		isEmpty:				TQ3Boolean;
	END;

	TQ3BoundingSpherePtr = ^TQ3BoundingSphere;
	TQ3BoundingSphere = RECORD
		origin:					TQ3Point3D;
		radius:					Single;
		isEmpty:				TQ3Boolean;
	END;

	{	
	 *  The TQ3ComputeBounds flag passed to StartBoundingBox or StartBoundingSphere
	 *  calls in the View. It's a hint to the system as to how it should 
	 *  compute the bbox of a shape:
	 *
	 *  kQ3ComputeBoundsExact:  
	 *      Vertices of shapes are transformed into world space and
	 *      the world space bounding box is computed from them.  Slow!
	 *  
	 *  kQ3ComputeBoundsApproximate: 
	 *      A local space bounding box is computed from a shape's
	 *      vertices.  This bbox is then transformed into world space,
	 *      and its bounding box is taken as the shape's approximate
	 *      bbox.  Fast but the bbox is larger than optimal.
	 	}
	TQ3ComputeBounds 			= SInt32;
CONST
	kQ3ComputeBoundsExact		= 0;
	kQ3ComputeBoundsApproximate	= 1;


	{	*****************************************************************************
	 **                                                                          **
	 **                         Object System Types                              **
	 **                                                                          **
	 ****************************************************************************	}


TYPE
	TQ3XObjectClass    = ^LONGINT; { an opaque 32-bit type }
	TQ3XObjectClassPtr = ^TQ3XObjectClass;  { when a VAR xx:TQ3XObjectClass parameter can be nil, it is changed to xx: TQ3XObjectClassPtr }
	TQ3XMethodType						= UInt32;
	{	
	 * Object methods
	 	}
	{	 
	 *  Return true from the metahandler if this 
	 *  object can be submitted in a rendering loop 
	 	}
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XFunctionPointer = PROCEDURE; C;
{$ELSEC}
	TQ3XFunctionPointer = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XMetaHandler = FUNCTION(methodType: TQ3XMethodType): TQ3XFunctionPointer; C;
{$ELSEC}
	TQ3XMetaHandler = ProcPtr;
{$ENDC}

	{	
	 * MetaHandler:
	 *      When you give a metahandler to QuickDraw 3D, it is called multiple 
	 *      times to build method tables, and then is thrown away. You are 
	 *      guaranteed that your metahandler will never be called again after a 
	 *      call that was passed a metahandler returns.
	 *
	 *      Your metahandler should contain a switch on the methodType passed to it
	 *      and should return the corresponding method as an TQ3XFunctionPointer.
	 *
	 *      IMPORTANT: A metaHandler MUST always "return" a value. If you are
	 *      passed a methodType that you do not understand, ALWAYS return NULL.
	 *
	 *      These types here are prototypes of how your functions should look.
	 	}
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XObjectUnregisterMethod = FUNCTION(objectClass: TQ3XObjectClass): TQ3Status; C;
{$ELSEC}
	TQ3XObjectUnregisterMethod = ProcPtr;
{$ENDC}

	{	
	 * See QD3DIO.h for the IO method types: 
	 *      ObjectReadData, ObjectTraverse, ObjectWrite
	 	}

	{	*****************************************************************************
	 **                                                                          **
	 **                             Set Types                                    **
	 **                                                                          **
	 ****************************************************************************	}
	TQ3ElementType						= LONGINT;

CONST
	kQ3ElementTypeNone			= 0;
	kQ3ElementTypeUnknown		= 32;
	kQ3ElementTypeSet			= 33;


	{	 
	 *  kQ3ElementTypeUnknown is a TQ3Object. 
	 *  
	 *      Do Q3Set_Add(s, ..., &obj) or Q3Set_Get(s, ..., &obj);
	 *      
	 *      Note that the object is always referenced when copying around. 
	 *      
	 *      Generally, it is an Unknown object, a Group of Unknown objects, or a 
	 *      group of other "objects" which have been found in the metafile and
	 *      have no attachment method to their parent. Be prepared to handle
	 *      any or all of these cases if you actually access the set on a shape.
	 *
	 *  kQ3ElementTypeSet is a TQ3SetObject. 
	 *  
	 *      Q3Shape_GetSet(s,&o) is eqivalent to 
	 *          Q3Shape_GetElement(s, kQ3ElementTypeSet, &o)
	 *          
	 *      Q3Shape_SetSet(s,o)  is eqivalent to 
	 *          Q3Shape_SetElement(s, kQ3ElementTypeSet, &o)
	 *  
	 *      Note that the object is always referenced when copying around. 
	 *      
	 *  See the note below about the Set and Shape changes.
	 	}

	{	*****************************************************************************
	 **                                                                          **
	 **                         Object System Macros                             **
	 **                                                                          **
	 ****************************************************************************	}
	{	*****************************************************************************
	 **                                                                          **
	 **                             Object Types                                 **
	 **                                                                          **
	 ****************************************************************************	}
	{	
	 * Note:    a call to Q3Foo_GetType will return a value kQ3FooTypeBar
	 *          e.g. Q3Shared_GetType(object) returns kQ3SharedTypeShape, etc.
	 	}
	kQ3ObjectTypeInvalid		= 0;
	kQ3ObjectTypeView			= 'view';
	kQ3ObjectTypeElement		= 'elmn';
	kQ3ElementTypeAttribute		= 'eatt';
	kQ3ObjectTypePick			= 'pick';
	kQ3PickTypeWindowPoint		= 'pkwp';
	kQ3PickTypeWindowRect		= 'pkwr';
	kQ3PickTypeWorldRay			= 'pkry';
	kQ3ObjectTypeShared			= 'shrd';
	kQ3SharedTypeRenderer		= 'rddr';
	kQ3RendererTypeWireFrame	= 'wrfr';
	kQ3RendererTypeGeneric		= 'gnrr';
	kQ3RendererTypeInteractive	= 'ctwn';
	kQ3SharedTypeShape			= 'shap';
	kQ3ShapeTypeGeometry		= 'gmtr';
	kQ3GeometryTypeBox			= 'box ';
	kQ3GeometryTypeGeneralPolygon = 'gpgn';
	kQ3GeometryTypeLine			= 'line';
	kQ3GeometryTypeMarker		= 'mrkr';
	kQ3GeometryTypePixmapMarker	= 'mrkp';
	kQ3GeometryTypeMesh			= 'mesh';
	kQ3GeometryTypeNURBCurve	= 'nrbc';
	kQ3GeometryTypeNURBPatch	= 'nrbp';
	kQ3GeometryTypePoint		= 'pnt ';
	kQ3GeometryTypePolygon		= 'plyg';
	kQ3GeometryTypePolyLine		= 'plyl';
	kQ3GeometryTypeTriangle		= 'trng';
	kQ3GeometryTypeTriGrid		= 'trig';
	kQ3GeometryTypeCone			= 'cone';
	kQ3GeometryTypeCylinder		= 'cyln';
	kQ3GeometryTypeDisk			= 'disk';
	kQ3GeometryTypeEllipse		= 'elps';
	kQ3GeometryTypeEllipsoid	= 'elpd';
	kQ3GeometryTypePolyhedron	= 'plhd';
	kQ3GeometryTypeTorus		= 'tors';
	kQ3GeometryTypeTriMesh		= 'tmsh';
	kQ3ShapeTypeShader			= 'shdr';
	kQ3ShaderTypeSurface		= 'sush';
	kQ3SurfaceShaderTypeTexture	= 'txsu';
	kQ3ShaderTypeIllumination	= 'ilsh';
	kQ3IlluminationTypePhong	= 'phil';
	kQ3IlluminationTypeLambert	= 'lmil';
	kQ3IlluminationTypeNULL		= 'nuil';
	kQ3ShapeTypeStyle			= 'styl';
	kQ3StyleTypeBackfacing		= 'bckf';
	kQ3StyleTypeInterpolation	= 'intp';
	kQ3StyleTypeFill			= 'fist';
	kQ3StyleTypePickID			= 'pkid';
	kQ3StyleTypeReceiveShadows	= 'rcsh';
	kQ3StyleTypeHighlight		= 'high';
	kQ3StyleTypeSubdivision		= 'sbdv';
	kQ3StyleTypeOrientation		= 'ofdr';
	kQ3StyleTypePickParts		= 'pkpt';
	kQ3StyleTypeAntiAlias		= 'anti';
	kQ3StyleTypeFog				= 'fogg';
	kQ3ShapeTypeTransform		= 'xfrm';
	kQ3TransformTypeMatrix		= 'mtrx';
	kQ3TransformTypeScale		= 'scal';
	kQ3TransformTypeTranslate	= 'trns';
	kQ3TransformTypeRotate		= 'rott';
	kQ3TransformTypeRotateAboutPoint = 'rtap';
	kQ3TransformTypeRotateAboutAxis = 'rtaa';
	kQ3TransformTypeQuaternion	= 'qtrn';
	kQ3TransformTypeReset		= 'rset';
	kQ3ShapeTypeLight			= 'lght';
	kQ3LightTypeAmbient			= 'ambn';
	kQ3LightTypeDirectional		= 'drct';
	kQ3LightTypePoint			= 'pntl';
	kQ3LightTypeSpot			= 'spot';
	kQ3ShapeTypeCamera			= 'cmra';
	kQ3CameraTypeOrthographic	= 'orth';
	kQ3CameraTypeViewPlane		= 'vwpl';
	kQ3CameraTypeViewAngleAspect = 'vana';
	kQ3ShapeTypeStateOperator	= 'stop';
	kQ3StateOperatorTypePush	= 'push';
	kQ3StateOperatorTypePop		= 'pop ';
	kQ3ShapeTypeGroup			= 'grup';
	kQ3GroupTypeDisplay			= 'dspg';
	kQ3DisplayGroupTypeOrdered	= 'ordg';
	kQ3DisplayGroupTypeIOProxy	= 'iopx';
	kQ3GroupTypeLight			= 'lghg';
	kQ3GroupTypeInfo			= 'info';
	kQ3ShapeTypeUnknown			= 'unkn';
	kQ3UnknownTypeText			= 'uktx';
	kQ3UnknownTypeBinary		= 'ukbn';
	kQ3ShapeTypeReference		= 'rfrn';
	kQ3ReferenceTypeExternal	= 'rfex';
	kQ3SharedTypeSet			= 'set ';
	kQ3SetTypeAttribute			= 'attr';
	kQ3SharedTypeDrawContext	= 'dctx';
	kQ3DrawContextTypePixmap	= 'dpxp';
	kQ3DrawContextTypeMacintosh	= 'dmac';
	kQ3DrawContextTypeWin32DC	= 'dw32';
	kQ3DrawContextTypeDDSurface	= 'ddds';
	kQ3DrawContextTypeX11		= 'dx11';
	kQ3SharedTypeTexture		= 'txtr';
	kQ3TextureTypePixmap		= 'txpm';
	kQ3TextureTypeMipmap		= 'txmm';
	kQ3TextureTypeCompressedPixmap = 'txcp';
	kQ3SharedTypeFile			= 'file';
	kQ3SharedTypeStorage		= 'strg';
	kQ3StorageTypeMemory		= 'mems';
	kQ3MemoryStorageTypeHandle	= 'hndl';
	kQ3StorageTypeUnix			= 'uxst';
	kQ3UnixStorageTypePath		= 'unix';
	kQ3StorageTypeMacintosh		= 'macn';
	kQ3MacintoshStorageTypeFSSpec = 'macp';
	kQ3StorageTypeWin32			= 'wist';
	kQ3SharedTypeString			= 'strn';
	kQ3StringTypeCString		= 'strc';
	kQ3SharedTypeShapePart		= 'sprt';
	kQ3ShapePartTypeMeshPart	= 'spmh';
	kQ3MeshPartTypeMeshFacePart	= 'mfac';
	kQ3MeshPartTypeMeshEdgePart	= 'medg';
	kQ3MeshPartTypeMeshVertexPart = 'mvtx';
	kQ3SharedTypeControllerState = 'ctst';
	kQ3SharedTypeTracker		= 'trkr';
	kQ3SharedTypeViewHints		= 'vwhn';
	kQ3SharedTypeEndGroup		= 'endg';

	{	*****************************************************************************
	 **                                                                          **
	 **                         QuickDraw 3D System Routines                     **
	 **                                                                          **
	 ****************************************************************************	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3Initialize()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3Initialize: TQ3Status; C;

{
 *  Q3Exit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Exit: TQ3Status; C;

{
 *  Q3IsInitialized()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3IsInitialized: TQ3Boolean; C;

{
 *  Q3GetVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3GetVersion(VAR majorRevision: UInt32; VAR minorRevision: UInt32): TQ3Status; C;

{
 *  Q3GetReleaseVersion returns the release version number,
 *  in the format of the first four bytes of a 'vers' resource
 *  (e.g. 0x01518000 ==> 1.5.1 release).
 }
{
 *  Q3GetReleaseVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3GetReleaseVersion(VAR releaseRevision: UInt32): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         ObjectClass Routines                             **
 **                                                                          **
 ****************************************************************************}
{ 
 *  New object system calls to query the object system.
 *
 *  These comments to move to the stubs file before final release, they 
 *  are here for documentation for developers using early seeds.
 }
{
 *  Given a class name as a string return the associated class type for the 
 *  class, may return kQ3Failure if the string representing the class is 
 *  invalid.
 }
{
 *  Q3ObjectHierarchy_GetTypeFromString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ObjectHierarchy_GetTypeFromString(VAR objectClassString: TQ3ObjectClassNameString; VAR objectClassType: TQ3ObjectType): TQ3Status; C;

{
 *  Given a class type as return the associated string for the class name, 
 *  may return kQ3Failure if the type representing the class is invalid.
 }
{
 *  Q3ObjectHierarchy_GetStringFromType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ObjectHierarchy_GetStringFromType(objectClassType: TQ3ObjectType; VAR objectClassString: TQ3ObjectClassNameString): TQ3Status; C;

{ 
 *  Return true if the class with this type is registered, false if not 
 }
{
 *  Q3ObjectHierarchy_IsTypeRegistered()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ObjectHierarchy_IsTypeRegistered(objectClassType: TQ3ObjectType): TQ3Boolean; C;

{ 
 *  Return true if the class with this name is registered, false if not 
 }
{
 *  Q3ObjectHierarchy_IsNameRegistered()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ObjectHierarchy_IsNameRegistered(objectClassName: ConstCStringPtr): TQ3Boolean; C;

{
 * TQ3SubClassData is used when querying the object system for
 * the subclasses of a particular parent type:
 }
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	TQ3SubClassDataPtr = ^TQ3SubClassData;
	TQ3SubClassData = RECORD
		numClasses:				UInt32;									{  the # of subclass types found for a parent class  }
		classTypes:				TQ3ObjectTypePtr;						{  an array containing the class types  }
	END;

	{	
	 *  Given a parent type and an instance of the TQ3SubClassData struct fill
	 *  it in with the number and class types of all of the subclasses immediately
	 *  below the parent in the class hierarchy.  Return kQ3Success to indicate no
	 *  errors occurred, else kQ3Failure.
	 *
	 *  NOTE:  This function will allocate memory for the classTypes array.  Be 
	 *  sure to call Q3ObjectClass_EmptySubClassData to free this memory up.
	 	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3ObjectHierarchy_GetSubClassData()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3ObjectHierarchy_GetSubClassData(objectClassType: TQ3ObjectType; VAR subClassData: TQ3SubClassData): TQ3Status; C;

{
 *  Given an instance of the TQ3SubClassData struct free all memory allocated 
 *  by the Q3ObjectClass_GetSubClassData call.
 *
 *  NOTE: This call MUST be made after a call to Q3ObjectClass_GetSubClassData
 *  to avoid memory leaks.
 }
{
 *  Q3ObjectHierarchy_EmptySubClassData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ObjectHierarchy_EmptySubClassData(VAR subClassData: TQ3SubClassData): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                             Object Routines                              **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Object_Dispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Object_Dispose(object: TQ3Object): TQ3Status; C;

{
 *  Q3Object_Duplicate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Object_Duplicate(object: TQ3Object): TQ3Object; C;

{
 *  Q3Object_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Object_Submit(object: TQ3Object; view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3Object_IsDrawable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Object_IsDrawable(object: TQ3Object): TQ3Boolean; C;

{
 *  Q3Object_IsWritable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Object_IsWritable(object: TQ3Object; theFile: TQ3FileObject): TQ3Boolean; C;


{*****************************************************************************
 **                                                                          **
 **                         Object Type Routines                             **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Object_GetType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Object_GetType(object: TQ3Object): TQ3ObjectType; C;

{
 *  Q3Object_GetLeafType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Object_GetLeafType(object: TQ3Object): TQ3ObjectType; C;

{
 *  Q3Object_IsType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Object_IsType(object: TQ3Object; theType: TQ3ObjectType): TQ3Boolean; C;


{*****************************************************************************
 **                                                                          **
 **                         Shared Object Routines                           **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Shared_GetType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Shared_GetType(sharedObject: TQ3SharedObject): TQ3ObjectType; C;

{
 *  Q3Shared_GetReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Shared_GetReference(sharedObject: TQ3SharedObject): TQ3SharedObject; C;

{ 
 *  Q3Shared_IsReferenced
 *      Returns kQ3True if there is more than one reference to sharedObject.
 *      Returns kQ3False if there is ONE reference to sharedObject.
 *  
 *  This call is intended to allow applications and plug-in objects to delete
 *  objects of which they hold THE ONLY REFERENCE. This is useful when
 *  caching objects, etc.
 *  
 *  Although many may be tempted, DO NOT DO THIS:
 *      while (Q3Shared_IsReferenced(foo)) ( Q3Object_Dispose(foo); )
 *  
 *  Your application will crash and no one will buy it. Chapter 11 is 
 *  never fun (unless you short the stock). Thanks.
 }
{
 *  Q3Shared_IsReferenced()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Shared_IsReferenced(sharedObject: TQ3SharedObject): TQ3Boolean; C;

{
 *  Q3Shared_GetEditIndex
 *      Returns the "serial number" of sharedObject. Usefuly for caching 
 *      object information. Returns 0 on error.
 *      
 *      Hold onto this number to determine if an object has changed since you
 *      last built your caches... To validate, do:
 *      
 *      if (Q3Shared_GetEditIndex(foo) == oldFooEditIndex) (
 *          // Cache is valid
 *      ) else (
 *          // Cache is invalid
 *          RebuildSomeSortOfCache(foo);
 *          oldFooEditIndex = Q3Shared_GetEditIndex(foo);
 *      )
 }
{
 *  Q3Shared_GetEditIndex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Shared_GetEditIndex(sharedObject: TQ3SharedObject): UInt32; C;

{
 *  Q3Shared_Edited
 *      Bumps the "serial number" of sharedObject to a different value. This
 *      call is intended to be used solely from a plug-in object which is 
 *      shared. Call this whenever your private instance data changes.
 *      
 *      Returns kQ3Failure iff sharedObject is not a shared object, OR
 *          QuickDraw 3D isn't initialized.
 }
{
 *  Q3Shared_Edited()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Shared_Edited(sharedObject: TQ3SharedObject): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                             Shape Routines                               **
 **                                                                          **
 ****************************************************************************}
{
 *  QuickDraw 3D 1.5 Note:
 *
 *  Shapes and Sets are now (sort of) polymorphic.
 *
 *      You may call Q3Shape_Foo or Q3Set_Foo on a shape or a set.
 *      The following calls are identical, in implementation:
 *
 *          Q3Shape_GetElement          =   Q3Set_Get
 *          Q3Shape_AddElement          =   Q3Set_Add
 *          Q3Shape_ContainsElement     =   Q3Set_Contains
 *          Q3Shape_GetNextElementType  =   Q3Set_GetNextElementType
 *          Q3Shape_EmptyElements       =   Q3Set_Empty
 *          Q3Shape_ClearElement        =   Q3Set_Clear
 *
 *  All of these calls accept a shape or a set as their first parameter.
 *
 *  The Q3Shape_GetSet and Q3ShapeSetSet calls are implemented via a new
 *  element type kQ3ElementTypeSet. See the note above about 
 *  kQ3ElementTypeSet;
 *
 *  It is important to note that the new Q3Shape_...Element... calls do not
 *  create a set on a shape and then add the element to it. This data is
 *  attached directly to the shape. Therefore, it is possible for an element
 *  to exist on a shape without a set existing on it as well. 
 *
 *  In your application, if you attach an element to a shape like this:
 *      (this isn't checking for errors for simplicity)
 *
 *      set = Q3Set_New();
 *      Q3Set_AddElement(set, kMyElemType, &data);
 *      Q3Shape_SetSet(shape, set);
 *
 *  You should retrieve it in the same manner:
 *
 *      Q3Shape_GetSet(shape, &set);
 *      if (Q3Set_Contains(set, kMyElemType) == kTrue) (
 *          Q3Set_Get(set, kMyElemType, &data);
 *      )
 *
 *  Similarly, if you attach data to a shape with the new calls:
 *
 *      Q3Shape_AddElement(shape, kMyElemType, &data);
 *
 *  You should retrieve it in the same manner:
 *
 *      if (Q3Shape_ContainsElement(set, kMyElemType) == kTrue) (
 *          Q3Shape_GetElement(set, kMyElemType, &data);
 *      )
 *
 *  This really becomes an issue when dealing with version 1.0 and version 1.1 
 *  metafiles.
 *
 *  When attempting to find a particular element on a shape, you should
 *  first check with Q3Shape_GetNextElementType or Q3Shape_GetElement, then,
 *  Q3Shape_GetSet(s, &set) (or Q3Shape_GetElement(s, kQ3ElementTypeSet, &set))
 *  and then Q3Shape_GetElement(set, ...).
 *
 *  In terms of implementation, Q3Shape_SetSet and Q3Shape_GetSet should only be
 *  used for sets of information that are shared among multiple shapes.
 *  
 *  Q3Shape_AddElement, Q3Shape_GetElement, etc. calls should only be used
 *  for elements that are unique for a particular shape.
 *  
 }
{
 *  Q3Shape_GetType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Shape_GetType(shape: TQ3ShapeObject): TQ3ObjectType; C;

{
 *  Q3Shape_GetSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Shape_GetSet(shape: TQ3ShapeObject; VAR theSet: TQ3SetObject): TQ3Status; C;

{
 *  Q3Shape_SetSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Shape_SetSet(shape: TQ3ShapeObject; theSet: TQ3SetObject): TQ3Status; C;

{
 *  Q3Shape_AddElement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Shape_AddElement(shape: TQ3ShapeObject; theType: TQ3ElementType; data: UNIV Ptr): TQ3Status; C;

{
 *  Q3Shape_GetElement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Shape_GetElement(shape: TQ3ShapeObject; theType: TQ3ElementType; data: UNIV Ptr): TQ3Status; C;

{
 *  Q3Shape_ContainsElement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Shape_ContainsElement(shape: TQ3ShapeObject; theType: TQ3ElementType): TQ3Boolean; C;

{
 *  Q3Shape_GetNextElementType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Shape_GetNextElementType(shape: TQ3ShapeObject; VAR theType: TQ3ElementType): TQ3Status; C;

{
 *  Q3Shape_EmptyElements()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Shape_EmptyElements(shape: TQ3ShapeObject): TQ3Status; C;

{
 *  Q3Shape_ClearElement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Shape_ClearElement(shape: TQ3ShapeObject; theType: TQ3ElementType): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         Color Table Routines                             **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Bitmap_Empty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Bitmap_Empty(VAR bitmap: TQ3Bitmap): TQ3Status; C;

{
 *  Q3Bitmap_GetImageSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Bitmap_GetImageSize(width: UInt32; height: UInt32): UInt32; C;



{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DIncludes}

{$ENDC} {__QD3D__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
