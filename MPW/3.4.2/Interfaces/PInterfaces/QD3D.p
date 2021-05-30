{
 	File:		QD3D.p
 
 	Contains:	Base types for QD3D							
 
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
 UNIT QD3D;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3D__}
{$SETC __QD3D__ := 1}

{$I+}
{$SETC QD3DIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}

{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{
*****************************************************************************
 **																			 **
 **								Porting Control								 **
 **																			 **
 ****************************************************************************
}

CONST
	gestaltQD3D					= 'qd3d';
	gestaltQD3DVersion			= 'q3v ';
	gestaltQD3DNotPresent		= 0;
	gestaltQD3DAvailable		= 1;

{
*****************************************************************************
 **																			 **
 **								Export Control								 **
 **																			 **
 ****************************************************************************
}
{
*****************************************************************************
 **																			 **
 **								NULL definition								 **
 **																			 **
 ****************************************************************************
}
{
*****************************************************************************
 **																			 **
 **									Objects									 **
 **																			 **
 ****************************************************************************
}
{
 * Everything in QuickDraw 3D is an OBJECT: a bunch of data with a type,
 * deletion, duplication, and i/o methods.
}

TYPE
	TQ3ObjectType						= FourCharCode;
	TQ3Object = ^LONGINT;
{
 * There are four subclasses of OBJECT:
 *	an ELEMENT, which is data that is placed in a SET
 *	a SHAREDOBJECT, which is reference-counted data that is shared
 *	VIEWs, which maintain state information for an image
 *	a PICK, which used to query a VIEW
}
	TQ3ElementObject					= TQ3Object;
	TQ3SharedObject						= TQ3Object;
	TQ3ViewObject						= TQ3Object;
	TQ3PickObject						= TQ3Object;
{
 * There are several types of SharedObjects:
 *	RENDERERs, which paint to a drawContext
 *	DRAWCONTEXTs, which are an interface to a device 
 *	SETs, which maintains "mathematical sets" of ELEMENTs
 *	FILEs, which maintain state information for a metafile
 *	SHAPEs, which affect the state of the View
 *	SHAPEPARTs, which contain geometry-specific data about a picking hit
 *	CONTROLLERSTATEs, which hold state of the output channels for a CONTROLLER
 *	TRACKERs, which represent a position and orientation in the user interface
 *  STRINGs, which are abstractions of text string data.
 *	STORAGE, which is an abstraction for stream-based data storage (files, memory)
 *	TEXTUREs, for sharing bitmap information for TEXTURESHADERS
 *	VIEWHINTs, which specifies viewing preferences in FILEs
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
 *	ATTRIBUTESETs, which contain ATTRIBUTEs which are inherited 
}
	TQ3AttributeSet						= TQ3SetObject;
	TQ3AttributeSetPtr					= ^TQ3AttributeSet;
{
 * There are many types of SHAPEs:
 *	LIGHTs, which affect how the RENDERER draws 3-D cues
 *	CAMERAs, which affects the location and orientation of the RENDERER in space
 *	GROUPs, which may contain any number of SHARED OBJECTS
 *	GEOMETRYs, which are representations of three-dimensional data
 *	SHADERs, which affect how colors are drawn on a geometry
 *	STYLEs, which affect how the RENDERER paints to the DRAWCONTEXT
 *	TRANSFORMs, which affect the coordinate system in the VIEW
 *	REFERENCEs, which are references to objects in FILEs
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
{
 * For now, there is only one type of SHAPEPARTs:
 *	MESHPARTs, which describe some part of a mesh
}
	TQ3MeshPartObject					= TQ3ShapePartObject;
{
 * There are three types of MESHPARTs:
 *	MESHFACEPARTs, which describe a face of a mesh
 *	MESHEDGEPARTs, which describe a edge of a mesh
 *	MESHVERTEXPARTs, which describe a vertex of a mesh
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
 *	SURFACESHADERs, which affect how the surface of a geometry is painted
 *	ILLUMINATIONSHADERs, which affect how lights affect the color of a surface
}
	TQ3SurfaceShaderObject				= TQ3ShaderObject;
	TQ3IlluminationShaderObject			= TQ3ShaderObject;
{
 * A handle to an object in a group
}
	TQ3GroupPosition = ^LONGINT;
	TQ3GroupPositionPtr					= ^TQ3GroupPosition;
{
*****************************************************************************
 **																			 **
 **							Client/Server Things							 **
 **																			 **
 ****************************************************************************
}
	TQ3ControllerRef					= Ptr;
{
*****************************************************************************
 **																			 **
 **							Flags and Switches								 **
 **																			 **
 ****************************************************************************
}
	TQ3Boolean 					= LONGINT;
CONST
	kQ3False					= {TQ3Boolean}0;
	kQ3True						= {TQ3Boolean}1;


TYPE
	TQ3Switch 					= LONGINT;
CONST
	kQ3Off						= {TQ3Switch}0;
	kQ3On						= {TQ3Switch}1;


TYPE
	TQ3Status 					= LONGINT;
CONST
	kQ3Failure					= {TQ3Status}0;
	kQ3Success					= {TQ3Status}1;


TYPE
	TQ3Axis 					= LONGINT;
CONST
	kQ3AxisX					= {TQ3Axis}0;
	kQ3AxisY					= {TQ3Axis}1;
	kQ3AxisZ					= {TQ3Axis}2;


TYPE
	TQ3PixelType 				= LONGINT;
CONST
	kQ3PixelTypeRGB32			= {TQ3PixelType}0;
	kQ3PixelTypeRGB24			= {TQ3PixelType}1;
	kQ3PixelTypeRGB16			= {TQ3PixelType}2;
	kQ3PixelTypeRGB8			= {TQ3PixelType}3;


TYPE
	TQ3Endian 					= LONGINT;
CONST
	kQ3EndianBig				= {TQ3Endian}0;
	kQ3EndianLittle				= {TQ3Endian}1;


TYPE
	TQ3EndCapMasks 				= LONGINT;
CONST
	kQ3EndCapNone				= {TQ3EndCapMasks}0;
	kQ3EndCapMaskTop			= {TQ3EndCapMasks}$01;
	kQ3EndCapMaskBottom			= {TQ3EndCapMasks}$02;


TYPE
	TQ3EndCap							= LONGINT;
{
*****************************************************************************
 **																			 **
 **						Point and Vector Definitions						 **
 **																			 **
 ****************************************************************************
}
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

{
*****************************************************************************
 **																			 **
 **								Quaternion									 **
 **																			 **
 ****************************************************************************
}
	TQ3QuaternionPtr = ^TQ3Quaternion;
	TQ3Quaternion = RECORD
		w:						Single;
		x:						Single;
		y:						Single;
		z:						Single;
	END;

{
*****************************************************************************
 **																			 **
 **								Ray Definition								 **
 **																			 **
 ****************************************************************************
}
	TQ3Ray3DPtr = ^TQ3Ray3D;
	TQ3Ray3D = RECORD
		origin:					TQ3Point3D;
		direction:				TQ3Vector3D;
	END;

{
*****************************************************************************
 **																			 **
 **						Parameterization Data Structures					 **
 **																			 **
 ****************************************************************************
}
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

{
*****************************************************************************
 **																			 **
 **						Polar and Spherical Coordinates						 **
 **																			 **
 ****************************************************************************
}
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

{
*****************************************************************************
 **																			 **
 **							Color Definition								 **
 **																			 **
 ****************************************************************************
}
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

{
*****************************************************************************
 **																			 **
 **									Vertices								 **
 **																			 **
 ****************************************************************************
}
	TQ3Vertex3DPtr = ^TQ3Vertex3D;
	TQ3Vertex3D = RECORD
		point:					TQ3Point3D;
		attributeSet:			TQ3AttributeSet;
	END;

{
*****************************************************************************
 **																			 **
 **									Matrices								 **
 **																			 **
 ****************************************************************************
}
	TQ3Matrix3x3Ptr = ^TQ3Matrix3x3;
	TQ3Matrix3x3 = RECORD
		value:					ARRAY [0..2,0..2] OF Single;
	END;

	TQ3Matrix4x4Ptr = ^TQ3Matrix4x4;
	TQ3Matrix4x4 = RECORD
		value:					ARRAY [0..3,0..3] OF Single;
	END;

{
*****************************************************************************
 **																			 **
 **								Bitmap/Pixmap								 **
 **																			 **
 ****************************************************************************
}
	TQ3PixmapPtr = ^TQ3Pixmap;
	TQ3Pixmap = RECORD
		image:					Ptr;
		width:					LONGINT;
		height:					LONGINT;
		rowBytes:				LONGINT;
		pixelSize:				LONGINT;
		pixelType:				TQ3PixelType;
		bitOrder:				TQ3Endian;
		byteOrder:				TQ3Endian;
	END;

	TQ3StoragePixmapPtr = ^TQ3StoragePixmap;
	TQ3StoragePixmap = RECORD
		image:					TQ3StorageObject;
		width:					LONGINT;
		height:					LONGINT;
		rowBytes:				LONGINT;
		pixelSize:				LONGINT;
		pixelType:				TQ3PixelType;
		bitOrder:				TQ3Endian;
		byteOrder:				TQ3Endian;
	END;

	TQ3BitmapPtr = ^TQ3Bitmap;
	TQ3Bitmap = RECORD
		image:					Ptr;
		width:					LONGINT;
		height:					LONGINT;
		rowBytes:				LONGINT;
		bitOrder:				TQ3Endian;
	END;

FUNCTION Q3Bitmap_Empty(VAR bitmap: TQ3Bitmap): TQ3Status; C; EXTERNAL;
FUNCTION Q3Bitmap_GetImageSize(width: LONGINT; height: LONGINT): LONGINT; C; EXTERNAL;
{
*****************************************************************************
 **																			 **
 **						Higher dimension quantities							 **
 **																			 **
 ****************************************************************************
}

TYPE
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
 *	The TQ3ComputeBounds flag passed to StartBoundingBox or StartBoundingSphere
 *	calls in the View. It's a hint to the system as to how it should 
 *	compute the bbox of a shape:
 *
 *	kQ3ComputeBoundsExact:	
 *		Vertices of shapes are transformed into world space and
 *		the world space bounding box is computed from them.  Slow!
 *	
 *	kQ3ComputeBoundsApproximate: 
 *		A local space bounding box is computed from a shape's
 *		vertices.  This bbox is then transformed into world space,
 *		and its bounding box is taken as the shape's approximate
 *		bbox.  Fast but the bbox is larger than optimal.
}
	TQ3ComputeBounds 			= LONGINT;
CONST
	kQ3ComputeBoundsExact		= {TQ3ComputeBounds}0;
	kQ3ComputeBoundsApproximate	= {TQ3ComputeBounds}1;

{
*****************************************************************************
 **																			 **
 **							Object System Types								 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3ObjectClass = ^LONGINT;
	TQ3MethodType						= LONGINT;
{
 * Object methods
}
{
 * IO Methods
}
	TQ3FunctionPointer = ProcPtr;  { PROCEDURE TQ3FunctionPointer; C; EXTERNAL; }

	TQ3MetaHandler = ProcPtr;  { FUNCTION TQ3MetaHandler(methodType: TQ3MethodType): TQ3FunctionPointer; C; EXTERNAL; }

{
 * MetaHandler:
 *		When you give a metahandler to QuickDraw 3D, it is called multiple times to
 *		build method tables, and then is thrown away. You are guaranteed that
 *		your metahandler will never be called again after a call that was passed
 *		a metahandler returns.
 *
 *		Your metahandler should contain a switch on the methodType passed to it
 *		and should return the corresponding method as an TQ3FunctionPointer.
 *
 *		IMPORTANT: A metaHandler MUST always "return" a value. If you are
 *		passed a methodType that you do not understand, ALWAYS return NULL.
 *
 *		These types here are prototypes of how your functions should look.
}
	TQ3ObjectUnregisterMethod = ProcPtr;  { FUNCTION TQ3ObjectUnregisterMethod(objectClass: TQ3ObjectClass): TQ3Status; C; EXTERNAL; }

{
 * See QD3DIO.h for the IO method types: 
 *		ObjectReadData, ObjectTraverse, ObjectWrite
}
{
*****************************************************************************
 **																			 **
 **							Object System Macros							 **
 **																			 **
 ****************************************************************************
}
{
*****************************************************************************
 **																			 **
 **								Object Types								 **
 **																			 **
 ****************************************************************************
}
{
 * Note:	a call to Q3Foo_GetType will return a value kQ3FooTypeBar
 *			e.g. Q3Shared_GetType(object) returns kQ3SharedTypeShape, etc.
}

CONST
	kQ3ObjectTypeInvalid		= 0;
	kQ3ObjectTypeView			= 'view';
	kQ3ObjectTypeElement		= 'elmn';
	kQ3ElementTypeAttribute		= 'eatt';
	kQ3ObjectTypePick			= 'pick';
	kQ3PickTypeWindowPoint		= 'pkwp';
	kQ3PickTypeWindowRect		= 'pkwr';
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
	kQ3GeometryTypeMesh			= 'mesh';
	kQ3GeometryTypeNURBCurve	= 'nrbc';
	kQ3GeometryTypeNURBPatch	= 'nrbp';
	kQ3GeometryTypePoint		= 'pnt ';
	kQ3GeometryTypePolygon		= 'plyg';
	kQ3GeometryTypePolyLine		= 'plyl';
	kQ3GeometryTypeTriangle		= 'trng';
	kQ3GeometryTypeTriGrid		= 'trig';
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
	kQ3ShapeTypeTransform		= 'xfrm';
	kQ3TransformTypeMatrix		= 'mtrx';
	kQ3TransformTypeScale		= 'scal';
	kQ3TransformTypeTranslate	= 'trns';
	kQ3TransformTypeRotate		= 'rott';
	kQ3TransformTypeRotateAboutPoint = 'rtap';
	kQ3TransformTypeRotateAboutAxis = 'rtaa';
	kQ3TransformTypeQuaternion	= 'qtrn';
	kQ3ShapeTypeLight			= 'lght';
	kQ3LightTypeAmbient			= 'ambn';
	kQ3LightTypeDirectional		= 'drct';
	kQ3LightTypePoint			= 'pntl';
	kQ3LightTypeSpot			= 'spot';
	kQ3ShapeTypeCamera			= 'cmra';
	kQ3CameraTypeOrthographic	= 'orth';
	kQ3CameraTypeViewPlane		= 'vwpl';
	kQ3CameraTypeViewAngleAspect = 'vana';
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
	kQ3SharedTypeSet			= 'set ';
	kQ3SetTypeAttribute			= 'attr';
	kQ3SharedTypeDrawContext	= 'dctx';
	kQ3DrawContextTypePixmap	= 'dpxp';
	kQ3DrawContextTypeMacintosh	= 'dmac';
	kQ3SharedTypeTexture		= 'txtr';
	kQ3TextureTypePixmap		= 'txpm';
	kQ3SharedTypeFile			= 'file';
	kQ3SharedTypeStorage		= 'strg';
	kQ3StorageTypeMemory		= 'mems';
	kQ3MemoryStorageTypeHandle	= 'hndl';
	kQ3StorageTypeUnix			= 'uxst';
	kQ3UnixStorageTypePath		= 'unix';
	kQ3StorageTypeMacintosh		= 'macn';
	kQ3MacintoshStorageTypeFSSpec = 'macp';
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
	kQ3ObjectTypeEndGroup		= 'endg';

{
*****************************************************************************
 **																			 **
 **							QuickDraw 3D System Routines					 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Initialize: TQ3Status; C; EXTERNAL;
FUNCTION Q3Exit: TQ3Status; C; EXTERNAL;
FUNCTION Q3IsInitialized: TQ3Boolean; C; EXTERNAL;
FUNCTION Q3GetVersion(VAR majorRevision: LONGINT; VAR minorRevision: LONGINT): TQ3Status; C; EXTERNAL;
{
*****************************************************************************
 **																			 **
 **							ObjectClass Routines							 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3ObjectClass_Unregister(objectClass: TQ3ObjectClass): TQ3Status; C; EXTERNAL;
{
*****************************************************************************
 **																			 **
 **								Object Routines								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Object_Dispose(object: TQ3Object): TQ3Status; C; EXTERNAL;
FUNCTION Q3Object_Duplicate(object: TQ3Object): TQ3Object; C; EXTERNAL;
FUNCTION Q3Object_Submit(object: TQ3Object; view: TQ3ViewObject): TQ3Status; C; EXTERNAL;
FUNCTION Q3Object_IsDrawable(object: TQ3Object): TQ3Boolean; C; EXTERNAL;
FUNCTION Q3Object_IsWritable(object: TQ3Object; theFile: TQ3FileObject): TQ3Boolean; C; EXTERNAL;
{
*****************************************************************************
 **																			 **
 **							Object Type Routines							 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Object_GetType(object: TQ3Object): TQ3ObjectType; C; EXTERNAL;
FUNCTION Q3Object_GetLeafType(object: TQ3Object): TQ3ObjectType; C; EXTERNAL;
FUNCTION Q3Object_IsType(object: TQ3Object; theType: TQ3ObjectType): TQ3Boolean; C; EXTERNAL;
{
*****************************************************************************
 **																			 **
 **							Shared Object Routines							 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Shared_GetType(sharedObject: TQ3SharedObject): TQ3ObjectType; C; EXTERNAL;
FUNCTION Q3Shared_GetReference(sharedObject: TQ3SharedObject): TQ3SharedObject; C; EXTERNAL;
{
*****************************************************************************
 **																			 **
 **								Shape Routines								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Shape_GetType(shape: TQ3ShapeObject): TQ3ObjectType; C; EXTERNAL;
FUNCTION Q3Shape_GetSet(shape: TQ3ShapeObject; VAR theSet: TQ3SetObject): TQ3Status; C; EXTERNAL;
FUNCTION Q3Shape_SetSet(shape: TQ3ShapeObject; theSet: TQ3SetObject): TQ3Status; C; EXTERNAL;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DIncludes}

{$ENDC} {__QD3D__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
