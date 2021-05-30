{
 	File:		QD3DGeometry.p
 
 	Contains:	Generic geometry routines										
 
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
 UNIT QD3DGeometry;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DGEOMETRY__}
{$SETC __QD3DGEOMETRY__ := 1}

{$I+}
{$SETC QD3DGeometryIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}
{$IFC UNDEFINED __QD3DSET__}
{$I QD3DSet.p}
{$ENDC}

{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{
*****************************************************************************
 **																			 **
 **								Geometry Routines							 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Geometry_GetType(geometry: TQ3GeometryObject): TQ3ObjectType; C;
FUNCTION Q3Geometry_GetAttributeSet(geometry: TQ3GeometryObject; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Geometry_SetAttributeSet(geometry: TQ3GeometryObject; attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Geometry_Submit(geometry: TQ3GeometryObject; view: TQ3ViewObject): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **							Box	Data Structure Definitions					 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3AttributeSetArray				= ARRAY [0..5] OF TQ3AttributeSet;
	TQ3AttributeSetArrayPtr				= ^TQ3AttributeSetArray;
	TQ3BoxDataPtr = ^TQ3BoxData;
	TQ3BoxData = RECORD
		origin:					TQ3Point3D;
		orientation:			TQ3Vector3D;
		majorAxis:				TQ3Vector3D;
		minorAxis:				TQ3Vector3D;
		faceAttributeSet:		TQ3AttributeSetArrayPtr;				{  Ordering : Left, right, 	 }
																		{ 			  front, back, 	 }
																		{ 			  top, bottom	 }
		boxAttributeSet:		TQ3AttributeSet;
	END;

{
*****************************************************************************
 **																			 **
 **								Box Routines							     **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Box_New({CONST}VAR boxData: TQ3BoxData): TQ3GeometryObject; C;
FUNCTION Q3Box_Submit({CONST}VAR boxData: TQ3BoxData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Box_SetData(box: TQ3GeometryObject; {CONST}VAR boxData: TQ3BoxData): TQ3Status; C;
FUNCTION Q3Box_GetData(box: TQ3GeometryObject; VAR boxData: TQ3BoxData): TQ3Status; C;
FUNCTION Q3Box_EmptyData(VAR boxData: TQ3BoxData): TQ3Status; C;
FUNCTION Q3Box_SetOrigin(box: TQ3GeometryObject; {CONST}VAR origin: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Box_SetOrientation(box: TQ3GeometryObject; {CONST}VAR orientation: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Box_SetMajorAxis(box: TQ3GeometryObject; {CONST}VAR majorAxis: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Box_SetMinorAxis(box: TQ3GeometryObject; {CONST}VAR minorAxis: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Box_GetOrigin(box: TQ3GeometryObject; VAR origin: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Box_GetOrientation(box: TQ3GeometryObject; VAR orientation: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Box_GetMajorAxis(box: TQ3GeometryObject; VAR majorAxis: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Box_GetMinorAxis(box: TQ3GeometryObject; VAR minorAxis: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Box_GetFaceAttributeSet(box: TQ3GeometryObject; faceIndex: LONGINT; VAR faceAttributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Box_SetFaceAttributeSet(box: TQ3GeometryObject; faceIndex: LONGINT; faceAttributeSet: TQ3AttributeSet): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **					General Polygon Data Structure Definitions				 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3GeneralPolygonShapeHint 	= LONGINT;
CONST
	kQ3GeneralPolygonShapeHintComplex = {TQ3GeneralPolygonShapeHint}0;
	kQ3GeneralPolygonShapeHintConcave = {TQ3GeneralPolygonShapeHint}1;
	kQ3GeneralPolygonShapeHintConvex = {TQ3GeneralPolygonShapeHint}2;


TYPE
	TQ3GeneralPolygonContourDataPtr = ^TQ3GeneralPolygonContourData;
	TQ3GeneralPolygonContourData = RECORD
		numVertices:			LONGINT;
		vertices:				TQ3Vertex3DPtr;
	END;

	TQ3GeneralPolygonDataPtr = ^TQ3GeneralPolygonData;
	TQ3GeneralPolygonData = RECORD
		numContours:			LONGINT;
		contours:				TQ3GeneralPolygonContourDataPtr;
		shapeHint:				TQ3GeneralPolygonShapeHint;
		generalPolygonAttributeSet: TQ3AttributeSet;
	END;

{
*****************************************************************************
 **																			 **
 **							General polygon Routines						 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3GeneralPolygon_New({CONST}VAR generalPolygonData: TQ3GeneralPolygonData): TQ3GeometryObject; C;
FUNCTION Q3GeneralPolygon_Submit({CONST}VAR generalPolygonData: TQ3GeneralPolygonData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3GeneralPolygon_SetData(generalPolygon: TQ3GeometryObject; {CONST}VAR generalPolygonData: TQ3GeneralPolygonData): TQ3Status; C;
FUNCTION Q3GeneralPolygon_GetData(polygon: TQ3GeometryObject; VAR generalPolygonData: TQ3GeneralPolygonData): TQ3Status; C;
FUNCTION Q3GeneralPolygon_EmptyData(VAR generalPolygonData: TQ3GeneralPolygonData): TQ3Status; C;
FUNCTION Q3GeneralPolygon_GetVertexPosition(generalPolygon: TQ3GeometryObject; contourIndex: LONGINT; pointIndex: LONGINT; VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3GeneralPolygon_SetVertexPosition(generalPolygon: TQ3GeometryObject; contourIndex: LONGINT; pointIndex: LONGINT; {CONST}VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3GeneralPolygon_GetVertexAttributeSet(generalPolygon: TQ3GeometryObject; contourIndex: LONGINT; pointIndex: LONGINT; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3GeneralPolygon_SetVertexAttributeSet(generalPolygon: TQ3GeometryObject; contourIndex: LONGINT; pointIndex: LONGINT; attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3GeneralPolygon_SetShapeHint(generalPolygon: TQ3GeometryObject; shapeHint: TQ3GeneralPolygonShapeHint): TQ3Status; C;
FUNCTION Q3GeneralPolygon_GetShapeHint(generalPolygon: TQ3GeometryObject; VAR shapeHint: TQ3GeneralPolygonShapeHint): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **						Line Data Structure Definitions						 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3LineDataPtr = ^TQ3LineData;
	TQ3LineData = RECORD
		vertices:				ARRAY [0..1] OF TQ3Vertex3D;
		lineAttributeSet:		TQ3AttributeSet;
	END;

{
*****************************************************************************
 **																			 **
 **							Line Routines									 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Line_New({CONST}VAR lineData: TQ3LineData): TQ3GeometryObject; C;
FUNCTION Q3Line_Submit({CONST}VAR lineData: TQ3LineData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Line_GetData(line: TQ3GeometryObject; VAR lineData: TQ3LineData): TQ3Status; C;
FUNCTION Q3Line_SetData(line: TQ3GeometryObject; {CONST}VAR lineData: TQ3LineData): TQ3Status; C;
FUNCTION Q3Line_GetVertexPosition(line: TQ3GeometryObject; index: LONGINT; VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Line_SetVertexPosition(line: TQ3GeometryObject; index: LONGINT; {CONST}VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Line_GetVertexAttributeSet(line: TQ3GeometryObject; index: LONGINT; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Line_SetVertexAttributeSet(line: TQ3GeometryObject; index: LONGINT; attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Line_EmptyData(VAR lineData: TQ3LineData): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **						Marker Data Structure Definitions					 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3MarkerDataPtr = ^TQ3MarkerData;
	TQ3MarkerData = RECORD
		location:				TQ3Point3D;
		xOffset:				LONGINT;
		yOffset:				LONGINT;
		bitmap:					TQ3Bitmap;
		markerAttributeSet:		TQ3AttributeSet;
	END;

{
*****************************************************************************
 **																			 **
 **								Marker Routines								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Marker_New({CONST}VAR markerData: TQ3MarkerData): TQ3GeometryObject; C;
FUNCTION Q3Marker_Submit({CONST}VAR markerData: TQ3MarkerData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Marker_SetData(geometry: TQ3GeometryObject; {CONST}VAR markerData: TQ3MarkerData): TQ3Status; C;
FUNCTION Q3Marker_GetData(geometry: TQ3GeometryObject; VAR markerData: TQ3MarkerData): TQ3Status; C;
FUNCTION Q3Marker_EmptyData(VAR markerData: TQ3MarkerData): TQ3Status; C;
FUNCTION Q3Marker_GetPosition(marker: TQ3GeometryObject; VAR location: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Marker_SetPosition(marker: TQ3GeometryObject; {CONST}VAR location: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Marker_GetXOffset(marker: TQ3GeometryObject; VAR xOffset: LONGINT): TQ3Status; C;
FUNCTION Q3Marker_SetXOffset(marker: TQ3GeometryObject; xOffset: LONGINT): TQ3Status; C;
FUNCTION Q3Marker_GetYOffset(marker: TQ3GeometryObject; VAR yOffset: LONGINT): TQ3Status; C;
FUNCTION Q3Marker_SetYOffset(marker: TQ3GeometryObject; yOffset: LONGINT): TQ3Status; C;
FUNCTION Q3Marker_GetBitmap(marker: TQ3GeometryObject; VAR bitmap: TQ3Bitmap): TQ3Status; C;
FUNCTION Q3Marker_SetBitmap(marker: TQ3GeometryObject; {CONST}VAR bitmap: TQ3Bitmap): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **						Mesh Data Structure Definitions						 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3MeshComponent = ^LONGINT;
	TQ3MeshVertex = ^LONGINT;
	TQ3MeshFace = ^LONGINT;
	TQ3MeshEdge = ^LONGINT;
	TQ3MeshContour = ^LONGINT;
{
*****************************************************************************
 **																			 **
 **							Mesh Routines								 	 **
 **																			 **
 ****************************************************************************
}
{
 *  Constructors
}
FUNCTION Q3Mesh_New: TQ3GeometryObject; C;
FUNCTION Q3Mesh_VertexNew(mesh: TQ3GeometryObject; {CONST}VAR vertex: TQ3Vertex3D): TQ3MeshVertex; C;
FUNCTION Q3Mesh_FaceNew(mesh: TQ3GeometryObject; numVertices: LONGINT; {CONST}VAR vertices: TQ3MeshVertex; attributeSet: TQ3AttributeSet): TQ3MeshFace; C;
{
 *  Destructors
}
FUNCTION Q3Mesh_VertexDelete(mesh: TQ3GeometryObject; vertex: TQ3MeshVertex): TQ3Status; C;
FUNCTION Q3Mesh_FaceDelete(mesh: TQ3GeometryObject; face: TQ3MeshFace): TQ3Status; C;
{
 * Methods
}
FUNCTION Q3Mesh_DelayUpdates(mesh: TQ3GeometryObject): TQ3Status; C;
FUNCTION Q3Mesh_ResumeUpdates(mesh: TQ3GeometryObject): TQ3Status; C;
FUNCTION Q3Mesh_FaceToContour(mesh: TQ3GeometryObject; containerFace: TQ3MeshFace; face: TQ3MeshFace): TQ3MeshContour; C;
FUNCTION Q3Mesh_ContourToFace(mesh: TQ3GeometryObject; contour: TQ3MeshContour): TQ3MeshFace; C;
{
 * Mesh
}
FUNCTION Q3Mesh_GetNumComponents(mesh: TQ3GeometryObject; VAR numComponents: LONGINT): TQ3Status; C;
FUNCTION Q3Mesh_GetNumEdges(mesh: TQ3GeometryObject; VAR numEdges: LONGINT): TQ3Status; C;
FUNCTION Q3Mesh_GetNumVertices(mesh: TQ3GeometryObject; VAR numVertices: LONGINT): TQ3Status; C;
FUNCTION Q3Mesh_GetNumFaces(mesh: TQ3GeometryObject; VAR numFaces: LONGINT): TQ3Status; C;
FUNCTION Q3Mesh_GetNumCorners(mesh: TQ3GeometryObject; VAR numCorners: LONGINT): TQ3Status; C;
FUNCTION Q3Mesh_GetOrientable(mesh: TQ3GeometryObject; VAR orientable: TQ3Boolean): TQ3Status; C;
{
 * Component
}
FUNCTION Q3Mesh_GetComponentNumVertices(mesh: TQ3GeometryObject; component: TQ3MeshComponent; VAR numVertices: LONGINT): TQ3Status; C;
FUNCTION Q3Mesh_GetComponentNumEdges(mesh: TQ3GeometryObject; component: TQ3MeshComponent; VAR numEdges: LONGINT): TQ3Status; C;
FUNCTION Q3Mesh_GetComponentBoundingBox(mesh: TQ3GeometryObject; component: TQ3MeshComponent; VAR boundingBox: TQ3BoundingBox): TQ3Status; C;
FUNCTION Q3Mesh_GetComponentOrientable(mesh: TQ3GeometryObject; component: TQ3MeshComponent; VAR orientable: TQ3Boolean): TQ3Status; C;
{
 * Vertex
}
FUNCTION Q3Mesh_GetVertexCoordinates(mesh: TQ3GeometryObject; vertex: TQ3MeshVertex; VAR coordinates: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Mesh_GetVertexIndex(mesh: TQ3GeometryObject; vertex: TQ3MeshVertex; VAR index: LONGINT): TQ3Status; C;
FUNCTION Q3Mesh_GetVertexOnBoundary(mesh: TQ3GeometryObject; vertex: TQ3MeshVertex; VAR onBoundary: TQ3Boolean): TQ3Status; C;
FUNCTION Q3Mesh_GetVertexComponent(mesh: TQ3GeometryObject; vertex: TQ3MeshVertex; VAR component: TQ3MeshComponent): TQ3Status; C;
FUNCTION Q3Mesh_GetVertexAttributeSet(mesh: TQ3GeometryObject; vertex: TQ3MeshVertex; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Mesh_SetVertexCoordinates(mesh: TQ3GeometryObject; vertex: TQ3MeshVertex; {CONST}VAR coordinates: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Mesh_SetVertexAttributeSet(mesh: TQ3GeometryObject; vertex: TQ3MeshVertex; attributeSet: TQ3AttributeSet): TQ3Status; C;
{
 * Face
}
FUNCTION Q3Mesh_GetFaceNumVertices(mesh: TQ3GeometryObject; face: TQ3MeshFace; VAR numVertices: LONGINT): TQ3Status; C;
FUNCTION Q3Mesh_GetFacePlaneEquation(mesh: TQ3GeometryObject; face: TQ3MeshFace; VAR planeEquation: TQ3PlaneEquation): TQ3Status; C;
FUNCTION Q3Mesh_GetFaceNumContours(mesh: TQ3GeometryObject; face: TQ3MeshFace; VAR numContours: LONGINT): TQ3Status; C;
FUNCTION Q3Mesh_GetFaceIndex(mesh: TQ3GeometryObject; face: TQ3MeshFace; VAR index: LONGINT): TQ3Status; C;
FUNCTION Q3Mesh_GetFaceComponent(mesh: TQ3GeometryObject; face: TQ3MeshFace; VAR component: TQ3MeshComponent): TQ3Status; C;
FUNCTION Q3Mesh_GetFaceAttributeSet(mesh: TQ3GeometryObject; face: TQ3MeshFace; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Mesh_SetFaceAttributeSet(mesh: TQ3GeometryObject; face: TQ3MeshFace; attributeSet: TQ3AttributeSet): TQ3Status; C;
{
 * Edge
}
FUNCTION Q3Mesh_GetEdgeVertices(mesh: TQ3GeometryObject; edge: TQ3MeshEdge; VAR vertex1: TQ3MeshVertex; VAR vertex2: TQ3MeshVertex): TQ3Status; C;
FUNCTION Q3Mesh_GetEdgeFaces(mesh: TQ3GeometryObject; edge: TQ3MeshEdge; VAR face1: TQ3MeshFace; VAR face2: TQ3MeshFace): TQ3Status; C;
FUNCTION Q3Mesh_GetEdgeOnBoundary(mesh: TQ3GeometryObject; edge: TQ3MeshEdge; VAR onBoundary: TQ3Boolean): TQ3Status; C;
FUNCTION Q3Mesh_GetEdgeComponent(mesh: TQ3GeometryObject; edge: TQ3MeshEdge; VAR component: TQ3MeshComponent): TQ3Status; C;
FUNCTION Q3Mesh_GetEdgeAttributeSet(mesh: TQ3GeometryObject; edge: TQ3MeshEdge; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Mesh_SetEdgeAttributeSet(mesh: TQ3GeometryObject; edge: TQ3MeshEdge; attributeSet: TQ3AttributeSet): TQ3Status; C;
{
 * Contour
}
FUNCTION Q3Mesh_GetContourFace(mesh: TQ3GeometryObject; contour: TQ3MeshContour; VAR face: TQ3MeshFace): TQ3Status; C;
FUNCTION Q3Mesh_GetContourNumVertices(mesh: TQ3GeometryObject; contour: TQ3MeshContour; VAR numVertices: LONGINT): TQ3Status; C;
{
 * Corner
}
FUNCTION Q3Mesh_GetCornerAttributeSet(mesh: TQ3GeometryObject; vertex: TQ3MeshVertex; face: TQ3MeshFace; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Mesh_SetCornerAttributeSet(mesh: TQ3GeometryObject; vertex: TQ3MeshVertex; face: TQ3MeshFace; attributeSet: TQ3AttributeSet): TQ3Status; C;
{
 * Public Mesh Iterators
}

TYPE
	TQ3MeshIteratorPtr = ^TQ3MeshIterator;
	TQ3MeshIterator = RECORD
		var1:					Ptr;
		var2:					Ptr;
		var3:					Ptr;
		field1:					Ptr;
		field2:					PACKED ARRAY [0..3] OF CHAR;
	END;

FUNCTION Q3Mesh_FirstMeshComponent(mesh: TQ3GeometryObject; VAR iterator: TQ3MeshIterator): TQ3MeshComponent; C;
FUNCTION Q3Mesh_NextMeshComponent(VAR iterator: TQ3MeshIterator): TQ3MeshComponent; C;
FUNCTION Q3Mesh_FirstComponentVertex(component: TQ3MeshComponent; VAR iterator: TQ3MeshIterator): TQ3MeshVertex; C;
FUNCTION Q3Mesh_NextComponentVertex(VAR iterator: TQ3MeshIterator): TQ3MeshVertex; C;
FUNCTION Q3Mesh_FirstComponentEdge(component: TQ3MeshComponent; VAR iterator: TQ3MeshIterator): TQ3MeshEdge; C;
FUNCTION Q3Mesh_NextComponentEdge(VAR iterator: TQ3MeshIterator): TQ3MeshEdge; C;
FUNCTION Q3Mesh_FirstMeshVertex(mesh: TQ3GeometryObject; VAR iterator: TQ3MeshIterator): TQ3MeshVertex; C;
FUNCTION Q3Mesh_NextMeshVertex(VAR iterator: TQ3MeshIterator): TQ3MeshVertex; C;
FUNCTION Q3Mesh_FirstMeshFace(mesh: TQ3GeometryObject; VAR iterator: TQ3MeshIterator): TQ3MeshFace; C;
FUNCTION Q3Mesh_NextMeshFace(VAR iterator: TQ3MeshIterator): TQ3MeshFace; C;
FUNCTION Q3Mesh_FirstMeshEdge(mesh: TQ3GeometryObject; VAR iterator: TQ3MeshIterator): TQ3MeshEdge; C;
FUNCTION Q3Mesh_NextMeshEdge(VAR iterator: TQ3MeshIterator): TQ3MeshEdge; C;
FUNCTION Q3Mesh_FirstVertexEdge(vertex: TQ3MeshVertex; VAR iterator: TQ3MeshIterator): TQ3MeshEdge; C;
FUNCTION Q3Mesh_NextVertexEdge(VAR iterator: TQ3MeshIterator): TQ3MeshEdge; C;
FUNCTION Q3Mesh_FirstVertexVertex(vertex: TQ3MeshVertex; VAR iterator: TQ3MeshIterator): TQ3MeshVertex; C;
FUNCTION Q3Mesh_NextVertexVertex(VAR iterator: TQ3MeshIterator): TQ3MeshVertex; C;
FUNCTION Q3Mesh_FirstVertexFace(vertex: TQ3MeshVertex; VAR iterator: TQ3MeshIterator): TQ3MeshFace; C;
FUNCTION Q3Mesh_NextVertexFace(VAR iterator: TQ3MeshIterator): TQ3MeshFace; C;
FUNCTION Q3Mesh_FirstFaceEdge(face: TQ3MeshFace; VAR iterator: TQ3MeshIterator): TQ3MeshEdge; C;
FUNCTION Q3Mesh_NextFaceEdge(VAR iterator: TQ3MeshIterator): TQ3MeshEdge; C;
FUNCTION Q3Mesh_FirstFaceVertex(face: TQ3MeshFace; VAR iterator: TQ3MeshIterator): TQ3MeshVertex; C;
FUNCTION Q3Mesh_NextFaceVertex(VAR iterator: TQ3MeshIterator): TQ3MeshVertex; C;
FUNCTION Q3Mesh_FirstFaceFace(face: TQ3MeshFace; VAR iterator: TQ3MeshIterator): TQ3MeshFace; C;
FUNCTION Q3Mesh_NextFaceFace(VAR iterator: TQ3MeshIterator): TQ3MeshFace; C;
FUNCTION Q3Mesh_FirstFaceContour(face: TQ3MeshFace; VAR iterator: TQ3MeshIterator): TQ3MeshContour; C;
FUNCTION Q3Mesh_NextFaceContour(VAR iterator: TQ3MeshIterator): TQ3MeshContour; C;
FUNCTION Q3Mesh_FirstContourEdge(contour: TQ3MeshContour; VAR iterator: TQ3MeshIterator): TQ3MeshEdge; C;
FUNCTION Q3Mesh_NextContourEdge(VAR iterator: TQ3MeshIterator): TQ3MeshEdge; C;
FUNCTION Q3Mesh_FirstContourVertex(contour: TQ3MeshContour; VAR iterator: TQ3MeshIterator): TQ3MeshVertex; C;
FUNCTION Q3Mesh_NextContourVertex(VAR iterator: TQ3MeshIterator): TQ3MeshVertex; C;
FUNCTION Q3Mesh_FirstContourFace(contour: TQ3MeshContour; VAR iterator: TQ3MeshIterator): TQ3MeshFace; C;
FUNCTION Q3Mesh_NextContourFace(VAR iterator: TQ3MeshIterator): TQ3MeshFace; C;
{
*****************************************************************************
 **																			 **
 **							Maximum order for NURB Curves					 **
 **																			 **
 ****************************************************************************
}
{
*****************************************************************************
 **																			 **
 **							Data Structure Definitions						 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3NURBCurveDataPtr = ^TQ3NURBCurveData;
	TQ3NURBCurveData = RECORD
		order:					LONGINT;
		numPoints:				LONGINT;
		controlPoints:			TQ3RationalPoint4DPtr;
		knots:					^Single;
		curveAttributeSet:		TQ3AttributeSet;
	END;

{
*****************************************************************************
 **																			 **
 **								NURB Curve Routines							 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3NURBCurve_New({CONST}VAR curveData: TQ3NURBCurveData): TQ3GeometryObject; C;
FUNCTION Q3NURBCurve_Submit({CONST}VAR curveData: TQ3NURBCurveData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3NURBCurve_SetData(curve: TQ3GeometryObject; {CONST}VAR nurbCurveData: TQ3NURBCurveData): TQ3Status; C;
FUNCTION Q3NURBCurve_GetData(curve: TQ3GeometryObject; VAR nurbCurveData: TQ3NURBCurveData): TQ3Status; C;
FUNCTION Q3NURBCurve_EmptyData(VAR nurbCurveData: TQ3NURBCurveData): TQ3Status; C;
FUNCTION Q3NURBCurve_SetControlPoint(curve: TQ3GeometryObject; pointIndex: LONGINT; {CONST}VAR point4D: TQ3RationalPoint4D): TQ3Status; C;
FUNCTION Q3NURBCurve_GetControlPoint(curve: TQ3GeometryObject; pointIndex: LONGINT; VAR point4D: TQ3RationalPoint4D): TQ3Status; C;
FUNCTION Q3NURBCurve_SetKnot(curve: TQ3GeometryObject; knotIndex: LONGINT; knotValue: Single): TQ3Status; C;
FUNCTION Q3NURBCurve_GetKnot(curve: TQ3GeometryObject; knotIndex: LONGINT; VAR knotValue: Single): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **							Maximum NURB Patch Order						 **
 **																			 **
 ****************************************************************************
}
{
*****************************************************************************
 **																			 **
 **						NURB Patch Data Structure Definitions				 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3NURBPatchTrimCurveDataPtr = ^TQ3NURBPatchTrimCurveData;
	TQ3NURBPatchTrimCurveData = RECORD
		order:					LONGINT;
		numPoints:				LONGINT;
		controlPoints:			TQ3RationalPoint3DPtr;
		knots:					^Single;
	END;

	TQ3NURBPatchTrimLoopDataPtr = ^TQ3NURBPatchTrimLoopData;
	TQ3NURBPatchTrimLoopData = RECORD
		numTrimCurves:			LONGINT;
		trimCurves:				TQ3NURBPatchTrimCurveDataPtr;
	END;

	TQ3NURBPatchDataPtr = ^TQ3NURBPatchData;
	TQ3NURBPatchData = RECORD
		uOrder:					LONGINT;
		vOrder:					LONGINT;
		numRows:				LONGINT;
		numColumns:				LONGINT;
		controlPoints:			TQ3RationalPoint4DPtr;
		uKnots:					^Single;
		vKnots:					^Single;
		numTrimLoops:			LONGINT;
		trimLoops:				TQ3NURBPatchTrimLoopDataPtr;
		patchAttributeSet:		TQ3AttributeSet;
	END;

{
*****************************************************************************
 **																			 **
 **								NURB Patch Routines							 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3NURBPatch_New({CONST}VAR nurbPatchData: TQ3NURBPatchData): TQ3GeometryObject; C;
FUNCTION Q3NURBPatch_Submit({CONST}VAR nurbPatchData: TQ3NURBPatchData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3NURBPatch_SetData(nurbPatch: TQ3GeometryObject; {CONST}VAR nurbPatchData: TQ3NURBPatchData): TQ3Status; C;
FUNCTION Q3NURBPatch_GetData(nurbPatch: TQ3GeometryObject; VAR nurbPatchData: TQ3NURBPatchData): TQ3Status; C;
FUNCTION Q3NURBPatch_SetControlPoint(nurbPatch: TQ3GeometryObject; rowIndex: LONGINT; columnIndex: LONGINT; {CONST}VAR point4D: TQ3RationalPoint4D): TQ3Status; C;
FUNCTION Q3NURBPatch_GetControlPoint(nurbPatch: TQ3GeometryObject; rowIndex: LONGINT; columnIndex: LONGINT; VAR point4D: TQ3RationalPoint4D): TQ3Status; C;
FUNCTION Q3NURBPatch_SetUKnot(nurbPatch: TQ3GeometryObject; knotIndex: LONGINT; knotValue: Single): TQ3Status; C;
FUNCTION Q3NURBPatch_SetVKnot(nurbPatch: TQ3GeometryObject; knotIndex: LONGINT; knotValue: Single): TQ3Status; C;
FUNCTION Q3NURBPatch_GetUKnot(nurbPatch: TQ3GeometryObject; knotIndex: LONGINT; VAR knotValue: Single): TQ3Status; C;
FUNCTION Q3NURBPatch_GetVKnot(nurbPatch: TQ3GeometryObject; knotIndex: LONGINT; VAR knotValue: Single): TQ3Status; C;
FUNCTION Q3NURBPatch_EmptyData(VAR nurbPatchData: TQ3NURBPatchData): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **						Point Data Structure Definitions					 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3PointDataPtr = ^TQ3PointData;
	TQ3PointData = RECORD
		point:					TQ3Point3D;
		pointAttributeSet:		TQ3AttributeSet;
	END;

{
*****************************************************************************
 **																			 **
 **								Point Routines								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Point_New({CONST}VAR pointData: TQ3PointData): TQ3GeometryObject; C;
FUNCTION Q3Point_Submit({CONST}VAR pointData: TQ3PointData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Point_GetData(point: TQ3GeometryObject; VAR pointData: TQ3PointData): TQ3Status; C;
FUNCTION Q3Point_SetData(point: TQ3GeometryObject; {CONST}VAR pointData: TQ3PointData): TQ3Status; C;
FUNCTION Q3Point_EmptyData(VAR pointData: TQ3PointData): TQ3Status; C;
FUNCTION Q3Point_SetPosition(point: TQ3GeometryObject; {CONST}VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Point_GetPosition(point: TQ3GeometryObject; VAR position: TQ3Point3D): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **						Polygon Data Structure Definitions					 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3PolygonDataPtr = ^TQ3PolygonData;
	TQ3PolygonData = RECORD
		numVertices:			LONGINT;
		vertices:				TQ3Vertex3DPtr;
		polygonAttributeSet:	TQ3AttributeSet;
	END;

{
*****************************************************************************
 **																			 **
 **							Polygon Routines								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Polygon_New({CONST}VAR polygonData: TQ3PolygonData): TQ3GeometryObject; C;
FUNCTION Q3Polygon_Submit({CONST}VAR polygonData: TQ3PolygonData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Polygon_SetData(polygon: TQ3GeometryObject; {CONST}VAR polygonData: TQ3PolygonData): TQ3Status; C;
FUNCTION Q3Polygon_GetData(polygon: TQ3GeometryObject; VAR polygonData: TQ3PolygonData): TQ3Status; C;
FUNCTION Q3Polygon_EmptyData(VAR polygonData: TQ3PolygonData): TQ3Status; C;
FUNCTION Q3Polygon_GetVertexPosition(polygon: TQ3GeometryObject; index: LONGINT; VAR point: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Polygon_SetVertexPosition(polygon: TQ3GeometryObject; index: LONGINT; {CONST}VAR point: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Polygon_GetVertexAttributeSet(polygon: TQ3GeometryObject; index: LONGINT; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Polygon_SetVertexAttributeSet(polygon: TQ3GeometryObject; index: LONGINT; attributeSet: TQ3AttributeSet): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **						PolyLine Data Structure Definitions					 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3PolyLineDataPtr = ^TQ3PolyLineData;
	TQ3PolyLineData = RECORD
		numVertices:			LONGINT;
		vertices:				TQ3Vertex3DPtr;
		segmentAttributeSet:	TQ3AttributeSetPtr;
		polyLineAttributeSet:	TQ3AttributeSet;
	END;

{
*****************************************************************************
 **																			 **
 **							PolyLine Routines								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3PolyLine_New({CONST}VAR polylineData: TQ3PolyLineData): TQ3GeometryObject; C;
FUNCTION Q3PolyLine_Submit({CONST}VAR polyLineData: TQ3PolyLineData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3PolyLine_SetData(polyLine: TQ3GeometryObject; {CONST}VAR polyLineData: TQ3PolyLineData): TQ3Status; C;
FUNCTION Q3PolyLine_GetData(polyLine: TQ3GeometryObject; VAR polyLineData: TQ3PolyLineData): TQ3Status; C;
FUNCTION Q3PolyLine_EmptyData(VAR polyLineData: TQ3PolyLineData): TQ3Status; C;
FUNCTION Q3PolyLine_GetVertexPosition(polyLine: TQ3GeometryObject; index: LONGINT; VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3PolyLine_SetVertexPosition(polyLine: TQ3GeometryObject; index: LONGINT; {CONST}VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3PolyLine_GetVertexAttributeSet(polyLine: TQ3GeometryObject; index: LONGINT; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3PolyLine_SetVertexAttributeSet(polyLine: TQ3GeometryObject; index: LONGINT; attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3PolyLine_GetSegmentAttributeSet(polyLine: TQ3GeometryObject; index: LONGINT; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3PolyLine_SetSegmentAttributeSet(polyLine: TQ3GeometryObject; index: LONGINT; attributeSet: TQ3AttributeSet): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **						Triangle Data Structure Definitions					 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3TriangleDataPtr = ^TQ3TriangleData;
	TQ3TriangleData = RECORD
		vertices:				ARRAY [0..2] OF TQ3Vertex3D;
		triangleAttributeSet:	TQ3AttributeSet;
	END;

{
*****************************************************************************
 **																			 **
 **							Triangle Routines								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Triangle_New({CONST}VAR triangleData: TQ3TriangleData): TQ3GeometryObject; C;
FUNCTION Q3Triangle_Submit({CONST}VAR triangleData: TQ3TriangleData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Triangle_SetData(triangle: TQ3GeometryObject; {CONST}VAR triangleData: TQ3TriangleData): TQ3Status; C;
FUNCTION Q3Triangle_GetData(triangle: TQ3GeometryObject; VAR triangleData: TQ3TriangleData): TQ3Status; C;
FUNCTION Q3Triangle_EmptyData(VAR triangleData: TQ3TriangleData): TQ3Status; C;
FUNCTION Q3Triangle_GetVertexPosition(triangle: TQ3GeometryObject; index: LONGINT; VAR point: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Triangle_SetVertexPosition(triangle: TQ3GeometryObject; index: LONGINT; {CONST}VAR point: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Triangle_GetVertexAttributeSet(triangle: TQ3GeometryObject; index: LONGINT; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3Triangle_SetVertexAttributeSet(triangle: TQ3GeometryObject; index: LONGINT; attributeSet: TQ3AttributeSet): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **						TriGrid Data Structure Definitions					 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3TriGridDataPtr = ^TQ3TriGridData;
	TQ3TriGridData = RECORD
		numRows:				LONGINT;
		numColumns:				LONGINT;
		vertices:				TQ3Vertex3DPtr;
		facetAttributeSet:		TQ3AttributeSetPtr;
		triGridAttributeSet:	TQ3AttributeSet;
	END;

{
*****************************************************************************
 **																			 **
 **								TriGrid Routines							 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3TriGrid_New({CONST}VAR triGridData: TQ3TriGridData): TQ3GeometryObject; C;
FUNCTION Q3TriGrid_Submit({CONST}VAR triGridData: TQ3TriGridData; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3TriGrid_SetData(triGrid: TQ3GeometryObject; {CONST}VAR triGridData: TQ3TriGridData): TQ3Status; C;
FUNCTION Q3TriGrid_GetData(triGrid: TQ3GeometryObject; VAR triGridData: TQ3TriGridData): TQ3Status; C;
FUNCTION Q3TriGrid_EmptyData(VAR triGridData: TQ3TriGridData): TQ3Status; C;
FUNCTION Q3TriGrid_GetVertexPosition(triGrid: TQ3GeometryObject; rowIndex: LONGINT; columnIndex: LONGINT; VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3TriGrid_SetVertexPosition(triGrid: TQ3GeometryObject; rowIndex: LONGINT; columnIndex: LONGINT; {CONST}VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3TriGrid_GetVertexAttributeSet(triGrid: TQ3GeometryObject; rowIndex: LONGINT; columnIndex: LONGINT; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3TriGrid_SetVertexAttributeSet(triGrid: TQ3GeometryObject; rowIndex: LONGINT; columnIndex: LONGINT; attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3TriGrid_GetFacetAttributeSet(triGrid: TQ3GeometryObject; faceIndex: LONGINT; VAR facetAttributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3TriGrid_SetFacetAttributeSet(triGrid: TQ3GeometryObject; faceIndex: LONGINT; facetAttributeSet: TQ3AttributeSet): TQ3Status; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DGeometryIncludes}

{$ENDC} {__QD3DGEOMETRY__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
