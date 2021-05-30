{
     File:       GXTypes.p
 
     Contains:   QuickDraw GX object and constant definitions
 
     Version:    Technology: Quickdraw GX 1.1
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT GXTypes;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __GXTYPES__}
{$SETC __GXTYPES__ := 1}

{$I+}
{$SETC GXTypesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __FIXMATH__}
{$I FixMath.p}
{$ENDC}
{$IFC UNDEFINED __GXMATH__}
{$I GXMath.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}




TYPE
	gxShape    = ^LONGINT; { an opaque 32-bit type }
	gxShapePtr = ^gxShape;  { when a VAR xx:gxShape parameter can be nil, it is changed to xx: gxShapePtr }
	gxStyle    = ^LONGINT; { an opaque 32-bit type }
	gxStylePtr = ^gxStyle;  { when a VAR xx:gxStyle parameter can be nil, it is changed to xx: gxStylePtr }
	gxInk    = ^LONGINT; { an opaque 32-bit type }
	gxInkPtr = ^gxInk;  { when a VAR xx:gxInk parameter can be nil, it is changed to xx: gxInkPtr }
	gxTransform    = ^LONGINT; { an opaque 32-bit type }
	gxTransformPtr = ^gxTransform;  { when a VAR xx:gxTransform parameter can be nil, it is changed to xx: gxTransformPtr }
	gxTag    = ^LONGINT; { an opaque 32-bit type }
	gxTagPtr = ^gxTag;  { when a VAR xx:gxTag parameter can be nil, it is changed to xx: gxTagPtr }
	gxColorSet    = ^LONGINT; { an opaque 32-bit type }
	gxColorSetPtr = ^gxColorSet;  { when a VAR xx:gxColorSet parameter can be nil, it is changed to xx: gxColorSetPtr }
	gxColorProfile    = ^LONGINT; { an opaque 32-bit type }
	gxColorProfilePtr = ^gxColorProfile;  { when a VAR xx:gxColorProfile parameter can be nil, it is changed to xx: gxColorProfilePtr }
	gxGraphicsClient    = ^LONGINT; { an opaque 32-bit type }
	gxGraphicsClientPtr = ^gxGraphicsClient;  { when a VAR xx:gxGraphicsClient parameter can be nil, it is changed to xx: gxGraphicsClientPtr }
	gxViewGroup    = ^LONGINT; { an opaque 32-bit type }
	gxViewGroupPtr = ^gxViewGroup;  { when a VAR xx:gxViewGroup parameter can be nil, it is changed to xx: gxViewGroupPtr }
	gxViewPort    = ^LONGINT; { an opaque 32-bit type }
	gxViewPortPtr = ^gxViewPort;  { when a VAR xx:gxViewPort parameter can be nil, it is changed to xx: gxViewPortPtr }
	gxViewDevice    = ^LONGINT; { an opaque 32-bit type }
	gxViewDevicePtr = ^gxViewDevice;  { when a VAR xx:gxViewDevice parameter can be nil, it is changed to xx: gxViewDevicePtr }

	gxColorSpace						= LONGINT;
	{	 gxShape enumerations 	}

CONST
	gxEmptyType					= 1;
	gxPointType					= 2;
	gxLineType					= 3;
	gxCurveType					= 4;
	gxRectangleType				= 5;
	gxPolygonType				= 6;
	gxPathType					= 7;
	gxBitmapType				= 8;
	gxTextType					= 9;
	gxGlyphType					= 10;
	gxLayoutType				= 11;
	gxFullType					= 12;
	gxPictureType				= 13;


TYPE
	gxShapeType							= LONGINT;

CONST
	gxNoFill					= 0;
	gxOpenFrameFill				= 1;
	gxFrameFill					= 1;
	gxClosedFrameFill			= 2;
	gxHollowFill				= 2;
	gxEvenOddFill				= 3;
	gxSolidFill					= 3;
	gxWindingFill				= 4;
	gxInverseEvenOddFill		= 5;
	gxInverseSolidFill			= 5;
	gxInverseFill				= 5;
	gxInverseWindingFill		= 6;


TYPE
	gxShapeFill							= LONGINT;

CONST
	gxNoAttributes				= 0;
	gxDirectShape				= $0001;
	gxRemoteShape				= $0002;
	gxCachedShape				= $0004;
	gxLockedShape				= $0008;
	gxGroupShape				= $0010;
	gxMapTransformShape			= $0020;
	gxUniqueItemsShape			= $0040;
	gxIgnorePlatformShape		= $0080;
	gxNoMetricsGridShape		= $0100;
	gxDiskShape					= $0200;
	gxMemoryShape				= $0400;


TYPE
	gxShapeAttribute					= LONGINT;
	{	 gxShape editing enumerations 	}

CONST
	gxBreakNeitherEdit			= 0;
	gxBreakLeftEdit				= $0001;
	gxBreakRightEdit			= $0002;
	gxRemoveDuplicatePointsEdit	= $0004;

	{	 if the new first (or last) point exactly matches the point before it in 	}
	{	 the same contour, then remove it) 	}

TYPE
	gxEditShapeFlag						= LONGINT;

CONST
	gxSelectToEnd				= -1;

	gxAnyNumber					= 1;
	gxSetToNil					= -1;

	gxCounterclockwiseDirection	= 0;
	gxClockwiseDirection		= 1;


TYPE
	gxContourDirection					= LONGINT;
	{	 gxShape structures 	}
	{	 The type 'gxPoint' is defined in "GXMath.h" 	}
	gxLinePtr = ^gxLine;
	gxLine = RECORD
		first:					gxPoint;
		last:					gxPoint;
	END;

	gxCurvePtr = ^gxCurve;
	gxCurve = RECORD
		first:					gxPoint;
		control:				gxPoint;
		last:					gxPoint;
	END;

	gxRectanglePtr = ^gxRectangle;
	gxRectangle = RECORD
		left:					Fixed;
		top:					Fixed;
		right:					Fixed;
		bottom:					Fixed;
	END;

	gxPolygonPtr = ^gxPolygon;
	gxPolygon = RECORD
		vectors:				LONGINT;
		vector:					ARRAY [0..0] OF gxPoint;
	END;

	gxPolygonsPtr = ^gxPolygons;
	gxPolygons = RECORD
		contours:				LONGINT;
		contour:				ARRAY [0..0] OF gxPolygon;
	END;

	gxPathPtr = ^gxPath;
	gxPath = RECORD
		vectors:				LONGINT;
		controlBits:			ARRAY [0..0] OF LONGINT;
		vector:					ARRAY [0..0] OF gxPoint;
	END;

	gxPathsPtr = ^gxPaths;
	gxPaths = RECORD
		contours:				LONGINT;
		contour:				ARRAY [0..0] OF gxPath;
	END;

	gxBitmapPtr = ^gxBitmap;
	gxBitmap = RECORD
		image:					CStringPtr;								{  pointer to pixels  }
		width:					LONGINT;								{  width in pixels  }
		height:					LONGINT;								{  height in pixels  }
		rowBytes:				LONGINT;								{  width in bytes  }
		pixelSize:				LONGINT;								{  physical bits per pixel  }
		space:					gxColorSpace;
		colorSet:				gxColorSet;
		profile:				gxColorProfile;
	END;

	gxLongRectanglePtr = ^gxLongRectangle;
	gxLongRectangle = RECORD
		left:					LONGINT;
		top:					LONGINT;
		right:					LONGINT;
		bottom:					LONGINT;
	END;

	{	 gxStyle enumerations 	}

CONST
	gxCenterFrameStyle			= 0;
	gxSourceGridStyle			= $0001;
	gxDeviceGridStyle			= $0002;
	gxInsideFrameStyle			= $0004;
	gxOutsideFrameStyle			= $0008;
	gxAutoInsetStyle			= $0010;


TYPE
	gxStyleAttribute					= LONGINT;

CONST
	gxBendDash					= $0001;
	gxBreakDash					= $0002;
	gxClipDash					= $0004;
	gxLevelDash					= $0008;
	gxAutoAdvanceDash			= $0010;


TYPE
	gxDashAttribute						= LONGINT;

CONST
	gxPortAlignPattern			= $0001;
	gxPortMapPattern			= $0002;


TYPE
	gxPatternAttribute					= LONGINT;

CONST
	gxSharpJoin					= $0000;
	gxCurveJoin					= $0001;
	gxLevelJoin					= $0002;
	gxSnapJoin					= $0004;


TYPE
	gxJoinAttribute						= LONGINT;

CONST
	gxLevelStartCap				= $0001;
	gxLevelEndCap				= $0002;


TYPE
	gxCapAttribute						= LONGINT;

CONST
	gxAutoAdvanceText			= $0001;
	gxNoContourGridText			= $0002;
	gxNoMetricsGridText			= $0004;
	gxAnchorPointsText			= $0008;
	gxVerticalText				= $0010;
	gxNoOpticalScaleText		= $0020;


TYPE
	gxTextAttribute						= LONGINT;

CONST
	gxLeftJustify				= 0;
	gxCenterJustify				= $20000000;
	gxRightJustify				= $40000000;
	gxFillJustify				= -1;

	gxUnderlineAdvanceLayer		= $0001;						{  a gxLine is drawn through the advances  }
	gxSkipWhiteSpaceLayer		= $0002;						{  except characters describing white space  }
	gxUnderlineIntervalLayer	= $0004;						{  (+ gxStringLayer) a gxLine is drawn through the gaps between advances  }
	gxUnderlineContinuationLayer = $0008;						{  (+ gxStringLayer) join this underline with another face  }
	gxWhiteLayer				= $0010;						{  the layer draws to white instead of black  }
	gxClipLayer					= $0020;						{  the characters define a clip  }
	gxStringLayer				= $0040;						{  all characters in run are combined  }


TYPE
	gxLayerFlag							= LONGINT;
	{	 gxStyle structures 	}
	gxFaceLayerPtr = ^gxFaceLayer;
	gxFaceLayer = RECORD
		outlineFill:			gxShapeFill;							{  outline framed or filled  }
		flags:					gxLayerFlag;							{  various additional effects  }
		outlineStyle:			gxStyle;								{  outline  }
		outlineTransform:		gxTransform;							{  italic, condense, extend  }
		boldOutset:				gxPoint;								{  bold  }
	END;

	gxTextFacePtr = ^gxTextFace;
	gxTextFace = RECORD
		faceLayers:				LONGINT;								{  layer to implement shadow  }
		advanceMapping:			gxMapping;								{  algorithmic change to advance width  }
		faceLayer:				ARRAY [0..0] OF gxFaceLayer;			{  zero or more face layers describing the face  }
	END;

	gxJoinRecordPtr = ^gxJoinRecord;
	gxJoinRecord = RECORD
		attributes:				gxJoinAttribute;
		join:					gxShape;
		miter:					Fixed;
	END;

	gxDashRecordPtr = ^gxDashRecord;
	gxDashRecord = RECORD
		attributes:				gxDashAttribute;
		dash:					gxShape;								{  similar to pattern, except rotated to gxLine slope  }
		advance:				Fixed;									{  specifies repeating frequency of dash  }
		phase:					Fract;									{  specifies offset into the gxPath to start dashing  }
		scale:					Fixed;									{  specifies height of dash to be mapped to penWidth  }
	END;

	gxPatternRecordPtr = ^gxPatternRecord;
	gxPatternRecord = RECORD
		attributes:				gxPatternAttribute;
		pattern:				gxShape;
		u:						gxPoint;
		v:						gxPoint;
	END;

	gxCapRecordPtr = ^gxCapRecord;
	gxCapRecord = RECORD
		attributes:				gxCapAttribute;
		startCap:				gxShape;
		endCap:					gxShape;
	END;


	{	 gxInk enumerations 	}

CONST
	gxPortAlignDitherInk		= $0001;
	gxForceDitherInk			= $0002;
	gxSuppressDitherInk			= $0004;
	gxSuppressHalftoneInk		= $0008;


TYPE
	gxInkAttribute						= LONGINT;

CONST
	gxNoMode					= 0;
	gxCopyMode					= 1;
	gxAddMode					= 2;
	gxBlendMode					= 3;
	gxMigrateMode				= 4;
	gxMinimumMode				= 5;
	gxMaximumMode				= 6;
	gxHighlightMode				= 7;
	gxAndMode					= 8;
	gxOrMode					= 9;
	gxXorMode					= 10;
	gxRampAndMode				= 11;
	gxRampOrMode				= 12;
	gxRampXorMode				= 13;
	gxOverMode					= 14;							{  Alpha channel modes           }
	gxAtopMode					= 15;							{  Note: In England = Beta channel modes    }
	gxExcludeMode				= 16;
	gxFadeMode					= 17;


TYPE
	gxComponentMode						= SInt8;

CONST
	gxRejectSourceTransfer		= $0001;						{  at least one component must be out of range        }
	gxRejectDeviceTransfer		= $0002;						{  at least one component must be out of range        }
	gxSingleComponentTransfer	= $0004;						{  duplicate gxTransferComponent[0] for all components in transfer  }


TYPE
	gxTransferFlag						= LONGINT;

CONST
	gxOverResultComponent		= $01;							{  & result gxColor with 0xFFFF before clamping    }
	gxReverseComponent			= $02;							{  reverse source and device before moding        }


TYPE
	gxComponentFlag						= SInt8;
	{	 gxInk structures 	}
	gxTransferComponentPtr = ^gxTransferComponent;
	gxTransferComponent = RECORD
		mode:					gxComponentMode;						{  how the component is operated upon  }
		flags:					gxComponentFlag;						{  flags for each component    }
		sourceMinimum:			gxColorValue;
		sourceMaximum:			gxColorValue;							{  input filter range  }
		deviceMinimum:			gxColorValue;
		deviceMaximum:			gxColorValue;							{  output filter range  }
		clampMinimum:			gxColorValue;
		clampMaximum:			gxColorValue;							{  output clamping range  }
		operand:				gxColorValue;							{  ratio for blend, step for migrate, gxColor for highlight    }
	END;

	gxTransferModePtr = ^gxTransferMode;
	gxTransferMode = RECORD
		space:					gxColorSpace;							{  the gxColor-space the transfer mode is to operate in    }
		colorSet:				gxColorSet;
		profile:				gxColorProfile;
		sourceMatrix:			ARRAY [0..4,0..3] OF Fixed;
		deviceMatrix:			ARRAY [0..4,0..3] OF Fixed;
		resultMatrix:			ARRAY [0..4,0..3] OF Fixed;
		flags:					gxTransferFlag;
		component:				ARRAY [0..3] OF gxTransferComponent;	{  how each component is operated upon          }
	END;


	{	 gxColor space enumerations 	}

CONST
	gxNoColorPacking			= $0000;						{  16 bits per channel  }
	gxAlphaSpace				= $0080;						{  space includes alpha channel  }
	gxWord5ColorPacking			= $0500;						{  5 bits per channel, right-justified  }
	gxLong8ColorPacking			= $0800;						{  8 bits per channel, right-justified  }
	gxLong10ColorPacking		= $0A00;						{  10 bits per channel, right-justified  }
	gxAlphaFirstPacking			= $1000;						{  alpha channel is the first field in the packed space  }

	gxNoSpace					= 0;
	gxRGBSpace					= 1;
	gxCMYKSpace					= 2;
	gxHSVSpace					= 3;
	gxHLSSpace					= 4;
	gxYXYSpace					= 5;
	gxXYZSpace					= 6;
	gxLUVSpace					= 7;
	gxLABSpace					= 8;
	gxYIQSpace					= 9;
	gxNTSCSpace					= 9;
	gxPALSpace					= 9;
	gxGraySpace					= 10;
	gxIndexedSpace				= 11;
	gxRGBASpace					= 129;
	gxGrayASpace				= 138;
	gxRGB16Space				= $0501;
	gxRGB32Space				= $0801;
	gxARGB32Space				= $1881;
	gxCMYK32Space				= $0802;
	gxHSV32Space				= $0A03;
	gxHLS32Space				= $0A04;
	gxYXY32Space				= $0A05;
	gxXYZ32Space				= $0A06;
	gxLUV32Space				= $0A07;
	gxLAB32Space				= $0A08;
	gxYIQ32Space				= $0A09;
	gxNTSC32Space				= $0A09;
	gxPAL32Space				= $0A09;

	{	 gxColor space structures 	}

TYPE
	gxRGBColorPtr = ^gxRGBColor;
	gxRGBColor = RECORD
		red:					gxColorValue;
		green:					gxColorValue;
		blue:					gxColorValue;
	END;

	gxRGBAColorPtr = ^gxRGBAColor;
	gxRGBAColor = RECORD
		red:					gxColorValue;
		green:					gxColorValue;
		blue:					gxColorValue;
		alpha:					gxColorValue;
	END;

	gxHSVColorPtr = ^gxHSVColor;
	gxHSVColor = RECORD
		hue:					gxColorValue;
		saturation:				gxColorValue;
		value:					gxColorValue;
	END;

	gxHLSColorPtr = ^gxHLSColor;
	gxHLSColor = RECORD
		hue:					gxColorValue;
		lightness:				gxColorValue;
		saturation:				gxColorValue;
	END;

	gxCMYKColorPtr = ^gxCMYKColor;
	gxCMYKColor = RECORD
		cyan:					gxColorValue;
		magenta:				gxColorValue;
		yellow:					gxColorValue;
		black:					gxColorValue;
	END;

	gxXYZColorPtr = ^gxXYZColor;
	gxXYZColor = RECORD
		x:						gxColorValue;
		y:						gxColorValue;
		z:						gxColorValue;
	END;

	gxYXYColorPtr = ^gxYXYColor;
	gxYXYColor = RECORD
		capY:					gxColorValue;
		x:						gxColorValue;
		y:						gxColorValue;
	END;

	gxLUVColorPtr = ^gxLUVColor;
	gxLUVColor = RECORD
		l:						gxColorValue;
		u:						gxColorValue;
		v:						gxColorValue;
	END;

	gxLABColorPtr = ^gxLABColor;
	gxLABColor = RECORD
		l:						gxColorValue;
		a:						gxColorValue;
		b:						gxColorValue;
	END;

	gxYIQColorPtr = ^gxYIQColor;
	gxYIQColor = RECORD
		y:						gxColorValue;
		i:						gxColorValue;
		q:						gxColorValue;
	END;

	gxGrayAColorPtr = ^gxGrayAColor;
	gxGrayAColor = RECORD
		gray:					gxColorValue;
		alpha:					gxColorValue;
	END;

	gxColorIndex						= LONGINT;
	gxIndexedColorPtr = ^gxIndexedColor;
	gxIndexedColor = RECORD
		index:					gxColorIndex;
		colorSet:				gxColorSet;
	END;

	gxColorPtr = ^gxColor;
	gxColor = RECORD
		space:					gxColorSpace;
		profile:				gxColorProfile;
		CASE INTEGER OF
		0: (
			cmyk:				gxCMYKColor;
			);
		1: (
			rgb:				gxRGBColor;
			);
		2: (
			rgba:				gxRGBAColor;
			);
		3: (
			hsv:				gxHSVColor;
			);
		4: (
			hls:				gxHLSColor;
			);
		5: (
			xyz:				gxXYZColor;
			);
		6: (
			yxy:				gxYXYColor;
			);
		7: (
			luv:				gxLUVColor;
			);
		8: (
			lab:				gxLABColor;
			);
		9: (
			yiq:				gxYIQColor;
			);
		10: (
			gray:				gxColorValue;
			);
		11: (
			graya:				gxGrayAColor;
			);
		12: (
			pixel16:			UInt16;
			);
		13: (
			pixel32:			UInt32;
			);
		14: (
			indexed:			gxIndexedColor;
			);
		15: (
			component:			ARRAY [0..3] OF gxColorValue;
			);
	END;


	{	 gxColorSet structures 	}
	gxSetColorPtr = ^gxSetColor;
	gxSetColor = RECORD
		CASE INTEGER OF
		0: (
			cmyk:				gxCMYKColor;
			);
		1: (
			rgb:				gxRGBColor;
			);
		2: (
			rgba:				gxRGBAColor;
			);
		3: (
			hsv:				gxHSVColor;
			);
		4: (
			hls:				gxHLSColor;
			);
		5: (
			xyz:				gxXYZColor;
			);
		6: (
			yxy:				gxYXYColor;
			);
		7: (
			luv:				gxLUVColor;
			);
		8: (
			lab:				gxLABColor;
			);
		9: (
			yiq:				gxYIQColor;
			);
		10: (
			gray:				gxColorValue;
			);
		11: (
			graya:				gxGrayAColor;
			);
		12: (
			pixel16:			UInt16;
			);
		13: (
			pixel32:			UInt32;
			);
		14: (
			component:			ARRAY [0..3] OF gxColorValue;
			);
	END;

	{	 gxTransform enumerations 	}
	{	 parts of a gxShape considered in hit testing: 	}

CONST
	gxNoPart					= 0;							{  (in order of evaluation)  }
	gxBoundsPart				= $0001;
	gxGeometryPart				= $0002;
	gxPenPart					= $0004;
	gxCornerPointPart			= $0008;
	gxControlPointPart			= $0010;
	gxEdgePart					= $0020;
	gxJoinPart					= $0040;
	gxStartCapPart				= $0080;
	gxEndCapPart				= $0100;
	gxDashPart					= $0200;
	gxPatternPart				= $0400;
	gxGlyphBoundsPart			= $0040;
	gxGlyphFirstPart			= $0080;
	gxGlyphLastPart				= $0100;
	gxSideBearingPart			= $0200;
	gxAnyPart					= $07FF;


TYPE
	gxShapePart							= LONGINT;
	{	 gxTransform structures 	}
	gxHitTestInfoPtr = ^gxHitTestInfo;
	gxHitTestInfo = RECORD
		what:					gxShapePart;							{  which part of gxShape  }
		index:					LONGINT;								{  control gxPoint index  }
		distance:				Fixed;									{  how far from gxPoint or outside of area click was  }
																		{  these fields are only set by GXHitTestPicture  }
		which:					gxShape;
		containerPicture:		gxShape;								{  picture which contains gxShape hit  }
		containerIndex:			LONGINT;								{  the index within that picture   }
		totalIndex:				LONGINT;								{  the total index within the root picture  }
	END;

	{	 gxViewPort enumerations 	}

CONST
	gxGrayPort					= $0001;
	gxAlwaysGridPort			= $0002;
	gxEnableMatchPort			= $0004;


TYPE
	gxPortAttribute						= LONGINT;
	{	 gxViewDevice enumerations 	}

CONST
	gxDirectDevice				= $01;							{  for the device gxBitmap baseAddr pointer  }
	gxRemoteDevice				= $02;
	gxInactiveDevice			= $04;


TYPE
	gxDeviceAttribute					= LONGINT;

CONST
	gxRoundDot					= 1;
	gxSpiralDot					= 2;
	gxSquareDot					= 3;
	gxLineDot					= 4;
	gxEllipticDot				= 5;
	gxTriangleDot				= 6;
	gxDispersedDot				= 7;
	gxCustomDot					= 8;


TYPE
	gxDotType							= LONGINT;
	{	 gxViewPort structures 	}

CONST
	gxNoTint					= 0;
	gxLuminanceTint				= 1;							{  use the luminance of the gxColor  }
	gxAverageTint				= 2;							{  add all the components and divide by the number of components  }
	gxMixtureTint				= 3;							{  find the closest gxColor on the axis between the foreground and background  }
	gxComponent1Tint			= 4;							{  use the value of the first component of the gxColor  }
	gxComponent2Tint			= 5;							{  ... etc.  }
	gxComponent3Tint			= 6;
	gxComponent4Tint			= 7;


TYPE
	gxTintType							= LONGINT;
	gxHalftonePtr = ^gxHalftone;
	gxHalftone = RECORD
		angle:					Fixed;
		frequency:				Fixed;
		method:					gxDotType;
		tinting:				gxTintType;
		dotColor:				gxColor;
		backgroundColor:		gxColor;
		tintSpace:				gxColorSpace;
	END;

	gxHalftoneMatrixPtr = ^gxHalftoneMatrix;
	gxHalftoneMatrix = RECORD
		dpiX:					Fixed;									{  intended resolution  }
		dpiY:					Fixed;
		width:					LONGINT;								{  width of matrix (in device pixels)  }
		height:					LONGINT;								{  height of matrix (in device pixels)  }
		tileShift:				LONGINT;								{  shift amount (in samples) for rectangular tiling  }
		samples:				ARRAY [0..0] OF UInt16;					{  samples from 0..MAX(halftone tintSpace)  }
	END;

	{	 gxViewGroup enumerations 	}

CONST
	gxAllViewDevices			= 0;
	gxScreenViewDevices			= 1;

	{	 graphics stream constants and structures 	}
	gxOpenReadSpool				= 1;
	gxOpenWriteSpool			= 2;
	gxReadSpool					= 3;
	gxWriteSpool				= 4;
	gxCloseSpool				= 5;


TYPE
	gxSpoolCommand						= LONGINT;
	gxGraphicsOpcode					= SInt8;
	gxSpoolBlockPtr = ^gxSpoolBlock;
{$IFC TYPED_FUNCTION_POINTERS}
	gxSpoolProcPtr = FUNCTION(command: gxSpoolCommand; block: gxSpoolBlockPtr): LONGINT; C;
{$ELSEC}
	gxSpoolProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	gxSpoolUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	gxSpoolUPP = UniversalProcPtr;
{$ENDC}	
	gxSpoolBlock = RECORD
		spoolProcedure:			gxSpoolUPP;								{  these fields are read only  }
		buffer:					Ptr;									{  source/destination pointer to data  }
		bufferSize:				LONGINT;								{  how many bytes for the system to read (flatten) / write (unflatten)  }
																		{  these fields are written to (but are not read from)  }
		count:					LONGINT;								{  how many bytes for the caller to read (unflatten) /write (flatten)  }
		operationSize:			LONGINT;								{  operation size (including operand byte)  }
		operationOffset:		LONGINT;								{  the data offset, if any, within the current operation  }
		lastTypeOpcode:			gxGraphicsOpcode;						{  type of last created object  }
		currentOperation:		gxGraphicsOpcode;						{  operation emitted by flatten, or intrepreted by last unflatten  }
		currentOperand:			gxGraphicsOpcode;						{  e.g., gxTransformTypeOpcode, gxInkTagOpcode  }
		compressed:				SInt8;									{  one of: gxTwoBitCompressionValues  }
	END;


CONST
	uppgxSpoolProcInfo = $000003F1;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewgxSpoolUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewgxSpoolUPP(userRoutine: gxSpoolProcPtr): gxSpoolUPP; { old name was NewgxSpoolProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposegxSpoolUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposegxSpoolUPP(userUPP: gxSpoolUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokegxSpoolUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokegxSpoolUPP(command: gxSpoolCommand; block: gxSpoolBlockPtr; userRoutine: gxSpoolUPP): LONGINT; { old name was CallgxSpoolProc }
{$ENDC}  {CALL_NOT_IN_CARBON}



CONST
	gxFontListFlatten			= $01;							{  if set, generate a gxTag containing list of each gxFont referenced  }
	gxFontGlyphsFlatten			= $02;							{  if set, generate a gxTag containing the list of glyphs referenced inside the gxFont  }
	gxFontVariationsFlatten		= $04;							{  if set, append the gxTag with separate [variation] coordinates  }
	gxBitmapAliasFlatten		= $08;							{  if set, open bitmap alias files and flatten out their image data  }



TYPE
	gxFlattenFlag						= LONGINT;
	{	 gxGraphicsClient constants 	}

CONST
	gxGraphicsSystemClient		= -1;

	gxStaticHeapClient			= $0001;


TYPE
	gxClientAttribute					= LONGINT;
	{	 graphics patching constants 	}

CONST
	gxOriginalGraphicsFunction	= -1;
	gxOriginalGraphicsIdentifier = 'grfx';


TYPE
	gxBitmapDataSourceAliasPtr = ^gxBitmapDataSourceAlias;
	gxBitmapDataSourceAlias = RECORD
		fileOffset:				UInt32;									{  file offset (in bytes) of top-left pixel  }
		aliasRecordSize:		UInt32;									{  size of alias record below  }
		aliasRecord:			SInt8;									{  the actual alias record data  }
	END;


CONST
	gxBitmapFileAliasTagType	= 'bfil';
	gxPICTFileAliasTagType		= 'pict';
	gxBitmapFileAliasImageValue	= 1;


TYPE
	gxFont    = ^LONGINT; { an opaque 32-bit type }
	gxFontPtr = ^gxFont;  { when a VAR xx:gxFont parameter can be nil, it is changed to xx: gxFontPtr }

CONST
	gxNoPlatform				= 0;
	gxNoScript					= 0;
	gxNoLanguage				= 0;
	gxNoFontName				= 0;
	gxGlyphPlatform				= -1;

	gxUnicodePlatform			= 1;
	gxMacintoshPlatform			= 2;
	gxReservedPlatform			= 3;
	gxMicrosoftPlatform			= 4;
	gxCustomPlatform			= 5;


TYPE
	gxFontPlatform						= LONGINT;

CONST
	gxUnicodeDefaultSemantics	= 1;
	gxUnicodeV1_1Semantics		= 2;
	gxISO10646_1993Semantics	= 3;

	gxRomanScript				= 1;
	gxJapaneseScript			= 2;
	gxTraditionalChineseScript	= 3;
	gxChineseScript				= 3;
	gxKoreanScript				= 4;
	gxArabicScript				= 5;
	gxHebrewScript				= 6;
	gxGreekScript				= 7;
	gxCyrillicScript			= 8;
	gxRussian					= 8;
	gxRSymbolScript				= 9;
	gxDevanagariScript			= 10;
	gxGurmukhiScript			= 11;
	gxGujaratiScript			= 12;
	gxOriyaScript				= 13;
	gxBengaliScript				= 14;
	gxTamilScript				= 15;
	gxTeluguScript				= 16;
	gxKannadaScript				= 17;
	gxMalayalamScript			= 18;
	gxSinhaleseScript			= 19;
	gxBurmeseScript				= 20;
	gxKhmerScript				= 21;
	gxThaiScript				= 22;
	gxLaotianScript				= 23;
	gxGeorgianScript			= 24;
	gxArmenianScript			= 25;
	gxSimpleChineseScript		= 26;
	gxTibetanScript				= 27;
	gxMongolianScript			= 28;
	gxGeezScript				= 29;
	gxEthiopicScript			= 29;
	gxAmharicScript				= 29;
	gxSlavicScript				= 30;
	gxEastEuropeanRomanScript	= 30;
	gxVietnameseScript			= 31;
	gxExtendedArabicScript		= 32;
	gxSindhiScript				= 32;
	gxUninterpretedScript		= 33;

	gxMicrosoftSymbolScript		= 1;
	gxMicrosoftStandardScript	= 2;

	gxCustom8BitScript			= 1;
	gxCustom816BitScript		= 2;
	gxCustom16BitScript			= 3;


TYPE
	gxFontScript						= LONGINT;

CONST
	gxEnglishLanguage			= 1;
	gxFrenchLanguage			= 2;
	gxGermanLanguage			= 3;
	gxItalianLanguage			= 4;
	gxDutchLanguage				= 5;
	gxSwedishLanguage			= 6;
	gxSpanishLanguage			= 7;
	gxDanishLanguage			= 8;
	gxPortugueseLanguage		= 9;
	gxNorwegianLanguage			= 10;
	gxHebrewLanguage			= 11;
	gxJapaneseLanguage			= 12;
	gxArabicLanguage			= 13;
	gxFinnishLanguage			= 14;
	gxGreekLanguage				= 15;
	gxIcelandicLanguage			= 16;
	gxMalteseLanguage			= 17;
	gxTurkishLanguage			= 18;
	gxCroatianLanguage			= 19;
	gxTradChineseLanguage		= 20;
	gxUrduLanguage				= 21;
	gxHindiLanguage				= 22;
	gxThaiLanguage				= 23;
	gxKoreanLanguage			= 24;
	gxLithuanianLanguage		= 25;
	gxPolishLanguage			= 26;
	gxHungarianLanguage			= 27;
	gxEstonianLanguage			= 28;
	gxLettishLanguage			= 29;
	gxLatvianLanguage			= 29;
	gxSaamiskLanguage			= 30;
	gxLappishLanguage			= 30;
	gxFaeroeseLanguage			= 31;
	gxFarsiLanguage				= 32;
	gxPersianLanguage			= 32;
	gxRussianLanguage			= 33;
	gxSimpChineseLanguage		= 34;
	gxFlemishLanguage			= 35;
	gxIrishLanguage				= 36;
	gxAlbanianLanguage			= 37;
	gxRomanianLanguage			= 38;
	gxCzechLanguage				= 39;
	gxSlovakLanguage			= 40;
	gxSlovenianLanguage			= 41;
	gxYiddishLanguage			= 42;
	gxSerbianLanguage			= 43;
	gxMacedonianLanguage		= 44;
	gxBulgarianLanguage			= 45;
	gxUkrainianLanguage			= 46;
	gxByelorussianLanguage		= 47;
	gxUzbekLanguage				= 48;
	gxKazakhLanguage			= 49;
	gxAzerbaijaniLanguage		= 50;
	gxAzerbaijanArLanguage		= 51;
	gxArmenianLanguage			= 52;
	gxGeorgianLanguage			= 53;
	gxMoldavianLanguage			= 54;
	gxKirghizLanguage			= 55;
	gxTajikiLanguage			= 56;
	gxTurkmenLanguage			= 57;
	gxMongolianLanguage			= 58;
	gxMongolianCyrLanguage		= 59;
	gxPashtoLanguage			= 60;
	gxKurdishLanguage			= 61;
	gxKashmiriLanguage			= 62;
	gxSindhiLanguage			= 63;
	gxTibetanLanguage			= 64;
	gxNepaliLanguage			= 65;
	gxSanskritLanguage			= 66;
	gxMarathiLanguage			= 67;
	gxBengaliLanguage			= 68;
	gxAssameseLanguage			= 69;
	gxGujaratiLanguage			= 70;
	gxPunjabiLanguage			= 71;
	gxOriyaLanguage				= 72;
	gxMalayalamLanguage			= 73;
	gxKannadaLanguage			= 74;
	gxTamilLanguage				= 75;
	gxTeluguLanguage			= 76;
	gxSinhaleseLanguage			= 77;
	gxBurmeseLanguage			= 78;
	gxKhmerLanguage				= 79;
	gxLaoLanguage				= 80;
	gxVietnameseLanguage		= 81;
	gxIndonesianLanguage		= 82;
	gxTagalogLanguage			= 83;
	gxMalayRomanLanguage		= 84;
	gxMalayArabicLanguage		= 85;
	gxAmharicLanguage			= 86;
	gxTigrinyaLanguage			= 87;
	gxGallaLanguage				= 88;
	gxOromoLanguage				= 88;
	gxSomaliLanguage			= 89;
	gxSwahiliLanguage			= 90;
	gxRuandaLanguage			= 91;
	gxRundiLanguage				= 92;
	gxChewaLanguage				= 93;
	gxMalagasyLanguage			= 94;
	gxEsperantoLanguage			= 95;
	gxWelshLanguage				= 129;
	gxBasqueLanguage			= 130;
	gxCatalanLanguage			= 131;
	gxLatinLanguage				= 132;
	gxQuechuaLanguage			= 133;
	gxGuaraniLanguage			= 134;
	gxAymaraLanguage			= 135;
	gxTatarLanguage				= 136;
	gxUighurLanguage			= 137;
	gxDzongkhaLanguage			= 138;
	gxJavaneseRomLanguage		= 139;
	gxSundaneseRomLanguage		= 140;


TYPE
	gxFontLanguage						= LONGINT;

CONST
	gxCopyrightFontName			= 1;
	gxFamilyFontName			= 2;
	gxStyleFontName				= 3;
	gxUniqueFontName			= 4;
	gxFullFontName				= 5;
	gxVersionFontName			= 6;
	gxPostscriptFontName		= 7;
	gxTrademarkFontName			= 8;
	gxManufacturerFontName		= 9;
	gxLastReservedFontName		= 256;


TYPE
	gxFontName							= LONGINT;
	gxFontTableTag						= LONGINT;
	gxFontVariationTag					= LONGINT;
	gxFontFormatTag						= LONGINT;
	gxFontStorageTag					= LONGINT;
	gxFontDescriptorTag					= gxFontVariationTag;
	gxFontVariationPtr = ^gxFontVariation;
	gxFontVariation = RECORD
		name:					gxFontVariationTag;
		value:					Fixed;
	END;

	gxFontDescriptor					= gxFontVariation;
	gxFontDescriptorPtr 				= ^gxFontDescriptor;
	gxFontFeatureSettingPtr = ^gxFontFeatureSetting;
	gxFontFeatureSetting = RECORD
		setting:				UInt16;
		nameID:					UInt16;
	END;


CONST
	gxSystemFontAttribute		= $0001;
	gxReadOnlyFontAttribute		= $0002;


TYPE
	gxFontAttribute						= LONGINT;

CONST
	gxMutuallyExclusiveFeature	= $00008000;


TYPE
	gxFontFeatureFlag					= LONGINT;
	gxFontFeature						= LONGINT;

CONST
	gxResourceFontStorage		= 'rsrc';
	gxHandleFontStorage			= 'hndl';
	gxFileFontStorage			= 'bass';
	gxNfntFontStorage			= 'nfnt';


TYPE
	gxFontStorageReference				= Ptr;
	gxGlyphcode							= UInt16;
	{	 single glyph in a font 	}
	{	 byte offset within backing store 	}
	gxByteOffset						= LONGINT;
	{	 The actual constants for feature types and selectors have been moved to a library. 	}
	gxRunFeatureType					= UInt16;
	gxRunFeatureSelector				= UInt16;
	{	 If tracking is not desired, specify the following value in the track field in the
	        gxRunControls record (note that a track of 0 does *not* mean to turn tracking off;
	        rather, it means to use normal tracking). 	}

CONST
	gxNoTracking				= $80000000;

	{	 The special "gxNoStake" value is returned by the GXGetLayoutBreakOffset call to
	        indicate the absence of a character offset that is stable with respect to
	        metamorphosis and contextual kerning. 	}
	gxNoStake					= -1;

	{	 A glyph's behavior with respect to other glyphs on its line is defined in part by its
	        gxBaselineType. These types allow correct alignment of the baselines of all glyphs on
	        the line. 	}
	gxRomanBaseline				= 0;
	gxIdeographicCenterBaseline	= 1;
	gxIdeographicLowBaseline	= 2;
	gxHangingBaseline			= 3;
	gxMathBaseline				= 4;
	gxLastBaseline				= 31;
	gxNumberOfBaselineTypes		= 32;
	gxNoOverrideBaseline		= 255;


TYPE
	gxBaselineType						= UInt32;
	gxBaselineDeltas					= ARRAY [0..31] OF Fixed;
	{	 gxJustificationPriority defines the point during the justification process at which a
	    glyph will begin to receive deltas before and after itself. 	}

CONST
	gxKashidaPriority			= 0;
	gxWhiteSpacePriority		= 1;
	gxInterCharPriority			= 2;
	gxNullJustificationPriority	= 3;
	gxNumberOfJustificationPriorities = 4;


TYPE
	gxJustificationPriority				= UInt8;
	{	 gxJustificationFlags are used to control which fields of a gxWidthDeltaRecord are to
	        be overridden and which are not if a gxPriorityJustificationOverride or
	        gxGlyphJustificationOverride (qq.v.) is specified. 	}

CONST
	gxOverridePriority			= $8000;						{  use priority value from override  }
	gxOverrideLimits			= $4000;						{  use limits values from override  }
	gxOverrideUnlimited			= $2000;						{  use unlimited flag from override  }
	gxUnlimitedGapAbsorption	= $1000;						{  glyph can take unlimited gap  }
	gxJustificationPriorityMask	= $000F;						{  justification priority  }
	gxAllJustificationFlags		= $F00F;


TYPE
	gxJustificationFlags				= UInt16;
	{	 The directional behavior of a glyph can be overridden using a gxDirectionOverride. 	}

CONST
	gxNoDirectionOverride		= 0;
	gxImposeLeftToRight			= 1;
	gxImposeRightToLeft			= 2;
	gxImposeArabic				= 3;


TYPE
	gxDirectionOverride					= UInt16;
	{	 gxRunControlFlags describe the nonparametric layout options contained in a gxStyle. 	}

CONST
	gxNoCaretAngle				= $40000000;
	gxImposeWidth				= $20000000;
	gxNoCrossKerning			= $10000000;
	gxNoOpticalAlignment		= $08000000;
	gxForceHanging				= $04000000;
	gxNoSpecialJustification	= $02000000;
	gxDirectionOverrideMask		= $00000003;
	gxNoLigatureSplits			= $80000000;

	gxAllRunControlFlags		= $FE000003;


TYPE
	gxRunControlFlags					= UInt32;
	{	 gxHighlightType is used to distinguish various highlighting methods, both in terms of
	        character offset based vs. visual based, and in terms of angled sides vs. non-angled
	        sides. 	}

CONST
	gxHighlightStraight			= 0;							{  straight-edged simple highlighting  }
	gxHighlightAverageAngle		= 1;							{  takes average of two edge angles  }


TYPE
	gxHighlightType						= UInt32;
	{	 gxCaretType is used to control whether the caret that is returned from GXGetLayoutCaret
	        is a split caret or a (keyboard-syncronized) single caret. 	}

CONST
	gxSplitCaretType			= 0;							{  returns Mac-style split caret (default)  }
	gxLeftRightKeyboardCaret	= 1;							{  single caret in left-right position  }
	gxRightLeftKeyboardCaret	= 2;							{  single caret in right-left position  }


TYPE
	gxCaretType							= UInt32;
	{	 gxLayoutOffsetState describes the characteristics of a given gxByteOffset in some
	        layout. It is returned by the GXGetOffsetGlyphs call. Note that the
	        gxOffsetInsideLigature value is returned in addition to the 8/16 (or invalid)
	        indication. 	}

CONST
	gxOffset8_8					= 0;
	gxOffset8_16				= 1;
	gxOffset16_8				= 2;
	gxOffset16_16				= 3;
	gxOffsetInvalid				= 4;

	gxOffsetInsideLigature		= $8000;


TYPE
	gxLayoutOffsetState					= UInt16;
	{	 gxLayoutOptionsFlags are single-bit flags contained in a gxLayoutOptions record. We
	    also define here some utility constants that are useful in setting various fields in
	    the gxLayoutOptions record. 	}

CONST
	gxNoLayoutOptions			= 0;
	gxLineIsDisplayOnly			= $00000001;
	gxKeepSpacesInMargin		= $00000002;
	gxLimitReorderingToTwoLevels = $00000004;
	gxLineLeftEdgeNotAtMargin	= $00000008;
	gxLineRightEdgeNotAtMargin	= $00000010;
	gxAllLayoutOptionsFlags		= $0000001F;
	gxMaxRunLevel				= 15;
	gxFlushLeft					= 0;
	gxFlushCenter				= $20000000;
	gxFlushRight				= $40000000;
	gxNoJustification			= 0;
	gxFullJustification			= $40000000;


TYPE
	gxLayoutOptionsFlags				= UInt32;
	{	 A gxRunFeature describes a feature and a level for that feature. 	}
	gxRunFeaturePtr = ^gxRunFeature;
	gxRunFeature = RECORD
		featureType:			gxRunFeatureType;
		featureSelector:		gxRunFeatureSelector;
	END;

	{	 A gxWidthDeltaRecord contains all of the information needed to describe the behavior of one
	        class of glyphs during the justification process. 	}
	gxWidthDeltaRecordPtr = ^gxWidthDeltaRecord;
	gxWidthDeltaRecord = RECORD
		beforeGrowLimit:		Fixed;									{  ems AW can grow by at most on LT  }
		beforeShrinkLimit:		Fixed;									{  ems AW can shrink by at most on LT  }
		afterGrowLimit:			Fixed;									{  ems AW can grow by at most on RB  }
		afterShrinkLimit:		Fixed;									{  ems AW can shrink by at most on RB  }
		growFlags:				gxJustificationFlags;					{  flags controlling grow case  }
		shrinkFlags:			gxJustificationFlags;					{  flags controlling shrink case  }
	END;

	{	 A gxPriorityJustificationOverride contains an array of WidthDeltaRecords, one for each
	        gxJustificationPriority. 	}
	gxPriorityJustificationOverridePtr = ^gxPriorityJustificationOverride;
	gxPriorityJustificationOverride = RECORD
		deltas:					ARRAY [0..3] OF gxWidthDeltaRecord;		{  overrides for each of the priorities  }
	END;

	{	 A gxGlyphJustificationOverride contains a gxWidthDeltaRecord that is to be used for a
	        specific glyph in a specific run (this limitation is because glyphcodes vary by font). 	}
	gxGlyphJustificationOverridePtr = ^gxGlyphJustificationOverride;
	gxGlyphJustificationOverride = RECORD
		glyph:					gxGlyphcode;
		override:				gxWidthDeltaRecord;
	END;


	{	 gxRunControls contains flags, shifts, imposed widths and overrides for a run. 	}
	{	 NOTE: a value of "gxNoTracking" (see above) in track disables tracking 	}
	gxRunControlsPtr = ^gxRunControls;
	gxRunControls = RECORD
		flags:					gxRunControlFlags;
		beforeWithStreamShift:	Fixed;
		afterWithStreamShift:	Fixed;
		crossStreamShift:		Fixed;
		imposedWidth:			Fixed;
		track:					Fixed;
		hangingInhibitFactor:	Fract;
		kerningInhibitFactor:	Fract;
		decompositionAdjustmentFactor: Fixed;
		baselineType:			gxBaselineType;
	END;

	{	 A gxGlyphSubstitution describes one client-provided substitution that occurs after all
	        other automatic glyph changes have happened. 	}
	gxGlyphSubstitutionPtr = ^gxGlyphSubstitution;
	gxGlyphSubstitution = RECORD
		originalGlyph:			gxGlyphcode;							{  Whenever you see this glyph...  }
		substituteGlyph:		gxGlyphcode;							{  ...change it to this one.  }
	END;

	{	 gxKerningAdjustmentFactors specify an adjustment to automatic kerning. The adjustment
	        is ax + b where x is the automatic kerning value, a is scaleFactor, and b is
	        adjustmentPointSizeFactor times the run's point size. 	}
	gxKerningAdjustmentFactorsPtr = ^gxKerningAdjustmentFactors;
	gxKerningAdjustmentFactors = RECORD
		scaleFactor:			Fract;
		adjustmentPointSizeFactor: Fixed;
	END;

	{	 A gxKerningAdjustment identifies with- and cross-stream kerning adjustments
	        for specific glyph pairs. 	}
	gxKerningAdjustmentPtr = ^gxKerningAdjustment;
	gxKerningAdjustment = RECORD
		firstGlyph:				gxGlyphcode;
		secondGlyph:			gxGlyphcode;
		withStreamFactors:		gxKerningAdjustmentFactors;
		crossStreamFactors:		gxKerningAdjustmentFactors;
	END;

	{	 A value of gxResetCrossStreamFactor in crossStreamFactors.adjustmentPointSizeFactor
	        will reset the cross-stream kerning to the baseline. 	}

CONST
	gxResetCrossStreamFactor	= $80000000;

	{	 gxLayoutHitInfo contains the output from the GXHitTestLayout call. 	}

TYPE
	gxLayoutHitInfoPtr = ^gxLayoutHitInfo;
	gxLayoutHitInfo = RECORD
		firstPartialDist:		Fixed;
		lastPartialDist:		Fixed;
		hitSideOffset:			gxByteOffset;
		nonHitSideOffset:		gxByteOffset;
		leadingEdge:			BOOLEAN;
		inLoose:				BOOLEAN;
	END;

	{	 A gxLineBaselineRecord contains the deltas from 0 to all the different baselines for
	        the layout. It can be filled via a call to GetBaselineDeltas (q.v.). 	}
	gxLineBaselineRecordPtr = ^gxLineBaselineRecord;
	gxLineBaselineRecord = RECORD
		deltas:					gxBaselineDeltas;
	END;

	{	 The gxLayoutOptions type contains information about the layout characteristics of the
	        whole line. 	}
	gxLayoutOptionsPtr = ^gxLayoutOptions;
	gxLayoutOptions = RECORD
		width:					Fixed;
		flush:					Fract;
		just:					Fract;
		flags:					gxLayoutOptionsFlags;
		baselineRec:			gxLineBaselineRecordPtr;
	END;


CONST
	gxNewObjectOpcode			= $00;							{  create new object  }
	gxSetDataOpcode				= $40;							{  add reference to current object  }
	gxSetDefaultOpcode			= $80;							{  replace current default with this object  }
	gxReservedOpcode			= $C0;							{  (may be used in future expansion)  }
	gxNextOpcode				= $FF;							{  used by currentOperand field to say opcode is coming  }

	{	 new object types (new object opcode) 	}
	gxHeaderTypeOpcode			= $00;							{  byte following new object uses bottom 6 bits for type  }
																{  gxShape types use values 1 (gxEmptyType) through 13 (gxPictureType)  }
	gxStyleTypeOpcode			= $28;
	gxInkTypeOpcode				= $29;
	gxTransformTypeOpcode		= $2A;
	gxColorProfileTypeOpcode	= $2B;
	gxColorSetTypeOpcode		= $2C;
	gxTagTypeOpcode				= $2D;
	gxBitImageOpcode			= $2E;
	gxFontNameTypeOpcode		= $2F;
	gxTrailerTypeOpcode			= $3F;

	{	 fields of objects (set data opcodes) 	}
	gxShapeAttributesOpcode		= 0;
	gxShapeTagOpcode			= 1;
	gxShapeFillOpcode			= 2;

	gxOmitPathPositionXMask		= $C0;
	gxOmitPathPositionYMask		= $30;
	gxOmitPathDeltaXMask		= $0C;
	gxOmitPathDeltaYMask		= $03;

	gxOmitPathPositionXShift	= 6;
	gxOmitPathPositionYShift	= 4;
	gxOmitPathDeltaXShift		= 2;
	gxOmitPathDeltaYShift		= 0;

	gxOmitBitmapImageMask		= $C0;
	gxOmitBitmapWidthMask		= $30;
	gxOmitBitmapHeightMask		= $0C;
	gxOmitBitmapRowBytesMask	= $03;

	gxOmitBitmapImageShift		= 6;
	gxOmitBitmapWidthShift		= 4;
	gxOmitBitmapHeightShift		= 2;
	gxOmitBitmapRowBytesShift	= 0;

	gxOmitBitmapPixelSizeMask	= $C0;
	gxOmitBitmapSpaceMask		= $30;
	gxOmitBitmapSetMask			= $0C;
	gxOmitBitmapProfileMask		= $03;

	gxOmitBitmapPixelSizeShift	= 6;
	gxOmitBitmapSpaceShift		= 4;
	gxOmitBitmapSetShift		= 2;
	gxOmitBitmapProfileShift	= 0;

	gxOmitBitmapPositionXMask	= $C0;
	gxOmitBitmapPositionYMask	= $30;

	gxOmitBitmapPositionXShift	= 6;
	gxOmitBitmapPositionYShift	= 4;

	gxOmitBitImageRowBytesMask	= $C0;
	gxOmitBitImageHeightMask	= $30;
	gxOmitBitImageDataMask		= $08;

	gxOmitBitImageRowBytesShift	= 6;
	gxOmitBitImageHeightShift	= 4;
	gxOmitBitImageDataShift		= 3;

	gxCopyBitImageBytesOpcode	= $00;
	gxRepeatBitImageBytesOpcode	= $40;
	gxLookupBitImageBytesOpcode	= $80;
	gxRepeatBitImageScanOpcode	= $C0;

	gxOmitTextCharactersMask	= $C0;
	gxOmitTextPositionXMask		= $30;
	gxOmitTextPositionYMask		= $0C;
	gxOmitTextDataMask			= $02;

	gxOmitTextCharactersShift	= 6;
	gxOmitTextPositionXShift	= 4;
	gxOmitTextPositionYShift	= 2;
	gxOmitTextDataShift			= 1;

	gxOmitGlyphCharactersMask	= $C0;
	gxOmitGlyphLengthMask		= $30;
	gxOmitGlyphRunNumberMask	= $0C;
	gxOmitGlyphOnePositionMask	= $02;
	gxOmitGlyphDataMask			= $01;

	gxOmitGlyphCharactersShift	= 6;
	gxOmitGlyphLengthShift		= 4;
	gxOmitGlyphRunNumberShift	= 2;
	gxOmitGlyphOnePositionShift	= 1;
	gxOmitGlyphDataShift		= 0;

	gxOmitGlyphPositionsMask	= $C0;
	gxOmitGlyphAdvancesMask		= $20;
	gxOmitGlyphTangentsMask		= $18;
	gxOmitGlyphRunsMask			= $04;
	gxOmitGlyphStylesMask		= $03;

	gxOmitGlyphPositionsShift	= 6;
	gxOmitGlyphAdvancesShift	= 5;
	gxOmitGlyphTangentsShift	= 3;
	gxOmitGlyphRunsShift		= 2;
	gxOmitGlyphStylesShift		= 0;

	gxOmitLayoutLengthMask		= $C0;
	gxOmitLayoutPositionXMask	= $30;
	gxOmitLayoutPositionYMask	= $0C;
	gxOmitLayoutDataMask		= $02;

	gxOmitLayoutLengthShift		= 6;
	gxOmitLayoutPositionXShift	= 4;
	gxOmitLayoutPositionYShift	= 2;
	gxOmitLayoutDataShift		= 1;

	gxOmitLayoutWidthMask		= $C0;
	gxOmitLayoutFlushMask		= $30;
	gxOmitLayoutJustMask		= $0C;
	gxOmitLayoutOptionsMask		= $03;

	gxOmitLayoutWidthShift		= 6;
	gxOmitLayoutFlushShift		= 4;
	gxOmitLayoutJustShift		= 2;
	gxOmitLayoutOptionsShift	= 0;

	gxOmitLayoutStyleRunNumberMask = $C0;
	gxOmitLayoutLevelRunNumberMask = $30;
	gxOmitLayoutHasBaselineMask	= $08;
	gxOmitLayoutStyleRunsMask	= $04;
	gxOmitLayoutStylesMask		= $03;

	gxOmitLayoutStyleRunNumberShift = 6;
	gxOmitLayoutLevelRunNumberShift = 4;
	gxOmitLayoutHasBaselineShift = 3;
	gxOmitLayoutStyleRunsShift	= 2;
	gxOmitLayoutStylesShift		= 0;

	gxOmitLayoutLevelRunsMask	= $80;
	gxOmitLayoutLevelsMask		= $40;

	gxOmitLayoutLevelRunsShift	= 7;
	gxOmitLayoutLevelsShift		= 6;

	gxInkAttributesOpcode		= 0;
	gxInkTagOpcode				= 1;
	gxInkColorOpcode			= 2;
	gxInkTransferModeOpcode		= 3;

	gxOmitColorsSpaceMask		= $C0;
	gxOmitColorsProfileMask		= $30;
	gxOmitColorsComponentsMask	= $0F;
	gxOmitColorsIndexMask		= $0C;
	gxOmitColorsIndexSetMask	= $03;

	gxOmitColorsSpaceShift		= 6;
	gxOmitColorsProfileShift	= 4;
	gxOmitColorsComponentsShift	= 0;
	gxOmitColorsIndexShift		= 2;
	gxOmitColorsIndexSetShift	= 0;

	gxOmitTransferSpaceMask		= $C0;
	gxOmitTransferSetMask		= $30;
	gxOmitTransferProfileMask	= $0C;

	gxOmitTransferSpaceShift	= 6;
	gxOmitTransferSetShift		= 4;
	gxOmitTransferProfileShift	= 2;

	gxOmitTransferSourceMatrixMask = $C0;
	gxOmitTransferDeviceMatrixMask = $30;
	gxOmitTransferResultMatrixMask = $0C;
	gxOmitTransferFlagsMask		= $03;

	gxOmitTransferSourceMatrixShift = 6;
	gxOmitTransferDeviceMatrixShift = 4;
	gxOmitTransferResultMatrixShift = 2;
	gxOmitTransferFlagsShift	= 0;

	gxOmitTransferComponentModeMask = $80;
	gxOmitTransferComponentFlagsMask = $40;
	gxOmitTransferComponentSourceMinimumMask = $30;
	gxOmitTransferComponentSourceMaximumMask = $0C;
	gxOmitTransferComponentDeviceMinimumMask = $03;

	gxOmitTransferComponentModeShift = 7;
	gxOmitTransferComponentFlagsShift = 6;
	gxOmitTransferComponentSourceMinimumShift = 4;
	gxOmitTransferComponentSourceMaximumShift = 2;
	gxOmitTransferComponentDeviceMinimumShift = 0;

	gxOmitTransferComponentDeviceMaximumMask = $C0;
	gxOmitTransferComponentClampMinimumMask = $30;
	gxOmitTransferComponentClampMaximumMask = $0C;
	gxOmitTransferComponentOperandMask = $03;

	gxOmitTransferComponentDeviceMaximumShift = 6;
	gxOmitTransferComponentClampMinimumShift = 4;
	gxOmitTransferComponentClampMaximumShift = 2;
	gxOmitTransferComponentOperandShift = 0;

	gxStyleAttributesOpcode		= 0;
	gxStyleTagOpcode			= 1;
	gxStyleCurveErrorOpcode		= 2;
	gxStylePenOpcode			= 3;
	gxStyleJoinOpcode			= 4;
	gxStyleDashOpcode			= 5;
	gxStyleCapsOpcode			= 6;
	gxStylePatternOpcode		= 7;
	gxStyleTextAttributesOpcode	= 8;
	gxStyleTextSizeOpcode		= 9;
	gxStyleFontOpcode			= 10;
	gxStyleTextFaceOpcode		= 11;
	gxStylePlatformOpcode		= 12;
	gxStyleFontVariationsOpcode	= 13;
	gxStyleRunControlsOpcode	= 14;
	gxStyleRunPriorityJustOverrideOpcode = 15;
	gxStyleRunGlyphJustOverridesOpcode = 16;
	gxStyleRunGlyphSubstitutionsOpcode = 17;
	gxStyleRunFeaturesOpcode	= 18;
	gxStyleRunKerningAdjustmentsOpcode = 19;
	gxStyleJustificationOpcode	= 20;

	gxOmitDashAttributesMask	= $C0;
	gxOmitDashShapeMask			= $30;
	gxOmitDashAdvanceMask		= $0C;
	gxOmitDashPhaseMask			= $03;

	gxOmitDashAttributesShift	= 6;
	gxOmitDashShapeShift		= 4;
	gxOmitDashAdvanceShift		= 2;
	gxOmitDashPhaseShift		= 0;

	gxOmitDashScaleMask			= $C0;

	gxOmitDashScaleShift		= 6;

	gxOmitPatternAttributesMask	= $C0;
	gxOmitPatternShapeMask		= $30;
	gxOmitPatternUXMask			= $0C;
	gxOmitPatternUYMask			= $03;

	gxOmitPatternAttributesShift = 6;
	gxOmitPatternShapeShift		= 4;
	gxOmitPatternUXShift		= 2;
	gxOmitPatternUYShift		= 0;

	gxOmitPatternVXMask			= $C0;
	gxOmitPatternVYMask			= $30;

	gxOmitPatternVXShift		= 6;
	gxOmitPatternVYShift		= 4;

	gxOmitJoinAttributesMask	= $C0;
	gxOmitJoinShapeMask			= $30;
	gxOmitJoinMiterMask			= $0C;

	gxOmitJoinAttributesShift	= 6;
	gxOmitJoinShapeShift		= 4;
	gxOmitJoinMiterShift		= 2;

	gxOmitCapAttributesMask		= $C0;
	gxOmitCapStartShapeMask		= $30;
	gxOmitCapEndShapeMask		= $0C;

	gxOmitCapAttributesShift	= 6;
	gxOmitCapStartShapeShift	= 4;
	gxOmitCapEndShapeShift		= 2;

	gxOmitFaceLayersMask		= $C0;
	gxOmitFaceMappingMask		= $30;

	gxOmitFaceLayersShift		= 6;
	gxOmitFaceMappingShift		= 4;

	gxOmitFaceLayerFillMask		= $C0;
	gxOmitFaceLayerFlagsMask	= $30;
	gxOmitFaceLayerStyleMask	= $0C;
	gxOmitFaceLayerTransformMask = $03;

	gxOmitFaceLayerFillShift	= 6;
	gxOmitFaceLayerFlagsShift	= 4;
	gxOmitFaceLayerStyleShift	= 2;
	gxOmitFaceLayerTransformShift = 0;

	gxOmitFaceLayerBoldXMask	= $C0;
	gxOmitFaceLayerBoldYMask	= $30;

	gxOmitFaceLayerBoldXShift	= 6;
	gxOmitFaceLayerBoldYShift	= 4;

	gxColorSetReservedOpcode	= 0;
	gxColorSetTagOpcode			= 1;

	gxColorProfileReservedOpcode = 0;
	gxColorProfileTagOpcode		= 1;

	gxTransformReservedOpcode	= 0;
	gxTransformTagOpcode		= 1;
	gxTransformClipOpcode		= 2;
	gxTransformMappingOpcode	= 3;
	gxTransformPartMaskOpcode	= 4;
	gxTransformToleranceOpcode	= 5;

	gxTypeOpcode				= 0;
	gxSizeOpcode				= 1;

	{	 used by currentOperand when currentOperation is gxNextOpcode 	}
	{	    format of top byte:
	xx yyyyyy   xx == 0x00, 0x40, 0x80, 0xC0: defines graphics operation (see gxGraphicsOperationOpcode)
	            yyyyyy == size of operation in bytes
	            if (yyyyyy == 0), byte size follows. If byte following == 0, word size follows; if == 0, long follows
	            word and long, if present, are specified in high-endian order (first byte is largest magnitude)
	            
	format of byte following size specifiers, if any:
	xx yyyyyy   xx == 0x00, 0x40, 0x80, 0xC0: defines compression level (0 == none, 0xC0 == most)
	            exact method of compression is defined by type of data
	            yyyyyy == data type selector (0 to 63): see gxGraphicsNewOpcode, __DataOpcode
		}
	gxOpcodeShift				= 6;
	gxObjectSizeMask			= $3F;
	gxCompressionShift			= 6;
	gxObjectTypeMask			= $3F;
	gxBitImageOpcodeMask		= $C0;
	gxBitImageCountMask			= $3F;
	gxBitImageOpcodeShift		= 6;

	gxNoCompression				= 0;
	gxWordCompression			= 1;
	gxByteCompression			= 2;
	gxOmitCompression			= 3;
	gxCompressionMask			= $03;

	{	    the following structures define how primitives without a public geometry
	    are stored (their format mirrors that of the New call to create them)   	}

TYPE
	gxFlatFontNamePtr = ^gxFlatFontName;
	gxFlatFontName = RECORD
		name:					SInt8;									{  gxFontName  }
		platform:				SInt8;									{  gxFontPlatform  }
		script:					SInt8;									{  gxFontScript  }
		language:				SInt8;									{  gxFontLanguage  }
		length:					INTEGER;								{  byte length  }
	END;


CONST
	gxFlatFontListItemTag		= 'flst';


TYPE
	gxFlatFontListItemPtr = ^gxFlatFontListItem;
	gxFlatFontListItem = RECORD
		fontID:					gxFont;									{ ** if we get rid of this, remove #include "font types.h", above  }
		name:					SInt8;									{  gxFontName  }
		platform:				SInt8;									{  gxFontPlatform  }
		script:					SInt8;									{  gxFontScript  }
		language:				SInt8;									{  gxFontLanguage  }
		length:					INTEGER;								{  byte length of the name that follows  }
		glyphCount:				UInt16;									{  CountFontGlyphs or 0 if gxFontGlyphsFlatten is false  }
		axisCount:				UInt16;									{  CountFontVariations or 0 if gxFontVariationsFlatten is false  }
		variationCount:			UInt16;									{  number of bitsVariationPairs that follow the (optional) glyphBits  }
	END;

	gxFlatFontListPtr = ^gxFlatFontList;
	gxFlatFontList = RECORD
		count:					LONGINT;
		items:					ARRAY [0..0] OF gxFlatFontListItem;
	END;

	gxFlattenHeaderPtr = ^gxFlattenHeader;
	gxFlattenHeader = RECORD
		version:				Fixed;
		flatFlags:				SInt8;
		padding:				SInt8;
	END;


CONST
	gxOmitPictureShapeMask		= $C0;
	gxOmitOverrideStyleMask		= $30;
	gxOmitOverrideInkMask		= $0C;
	gxOmitOverrideTransformMask	= $03;

	gxOmitPictureShapeShift		= $06;
	gxOmitOverrideStyleShift	= $04;
	gxOmitOverrideInkShift		= $02;
	gxOmitOverrideTransformShift = $00;

	gxPostScriptTag				= 'post';
	gxPostControlTag			= 'psct';

	gxNoSave					= 1;							{  don't do save-restore around PS data  }
	gxPSContinueNext			= 2;							{  next shape is continuation of this shape's PS -- only obeyed if gxNoSave is true  }


TYPE
	gxPostControlPtr = ^gxPostControl;
	gxPostControl = RECORD
		flags:					LONGINT;								{  PostScript state flags  }
	END;


CONST
	gxDashSynonymTag			= 'sdsh';


TYPE
	gxDashSynonymPtr = ^gxDashSynonym;
	gxDashSynonym = RECORD
		size:					LONGINT;								{  number of elements in array  }
		dashLength:				ARRAY [0..0] OF Fixed;					{  Array of dash lengths  }
	END;


CONST
	gxLineCapSynonymTag			= 'lcap';

	gxButtCap					= 0;
	gxRoundCap					= 1;
	gxSquareCap					= 2;
	gxTriangleCap				= 3;

	{	 gxLine cap type 	}

TYPE
	gxLineCapSynonym					= LONGINT;

CONST
	gxCubicSynonymTag			= 'cubx';

	gxIgnoreFlag				= $0000;						{  Ignore this word, get next one  }
	gxLineToFlag				= $0001;						{  Draw a gxLine to gxPoint following this flag  }
	gxCurveToFlag				= $0002;						{  Draw a gxCurve through the 3 points following this flag  }
	gxMoveToFlag				= $0003;						{  Start a new contour at the gxPoint following this flag  }
	gxClosePathFlag				= $0004;						{  Close the contour  }


TYPE
	gxCubicSynonym						= LONGINT;

CONST
	gxCubicInstructionMask		= $000F;						{  low four bits are gxPoint instructions  }

	{	 Low four bits are instruction (moveto, lineto, curveto, closepath) 	}

TYPE
	gxCubicSynonymFlags					= INTEGER;

CONST
	gxPatternSynonymTag			= 'ptrn';

	gxHatch						= 0;
	gxCrossHatch				= 1;


TYPE
	gxPatternSynonymPtr = ^gxPatternSynonym;
	gxPatternSynonym = RECORD
		patternType:			LONGINT;								{  one of the gxPatterns: gxHatch or gxCrossHatch  }
		angle:					Fixed;									{  angle at which pattern is drawn  }
		spacing:				Fixed;									{  distance between two parallel pattern lines  }
		thickness:				Fixed;									{  thickness of the pattern  }
		anchorPoint:			gxPoint;								{  gxPoint with with respect to which pattern position is calculated  }
	END;


CONST
	gxURLTag					= 'urlt';

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := GXTypesIncludes}

{$ENDC} {__GXTYPES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
