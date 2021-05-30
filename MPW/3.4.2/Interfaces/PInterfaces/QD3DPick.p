{
 	File:		QD3DPick.p
 
 	Contains:	Public picking routines 										
 
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
 UNIT QD3DPick;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DPICK__}
{$SETC __QD3DPICK__ := 1}

{$I+}
{$SETC QD3DPickIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}
{$IFC UNDEFINED __QD3DSTYLE__}
{$I QD3DStyle.p}
{$ENDC}
{$IFC UNDEFINED __QD3DGEOMETRY__}
{$I QD3DGeometry.p}
{$ENDC}

{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{
****************************************************************************
 **																			**
 **							Mask bits for hit information 					**
 **																			**
 ****************************************************************************
}

TYPE
	TQ3PickDetailMasks 			= LONGINT;
CONST
	kQ3PickDetailNone			= {TQ3PickDetailMasks}0;
	kQ3PickDetailMaskPickID		= {TQ3PickDetailMasks}$01;
	kQ3PickDetailMaskPath		= {TQ3PickDetailMasks}$02;
	kQ3PickDetailMaskObject		= {TQ3PickDetailMasks}$04;
	kQ3PickDetailMaskLocalToWorldMatrix = {TQ3PickDetailMasks}$08;
	kQ3PickDetailMaskXYZ		= {TQ3PickDetailMasks}$10;
	kQ3PickDetailMaskDistance	= {TQ3PickDetailMasks}$20;
	kQ3PickDetailMaskNormal		= {TQ3PickDetailMasks}$40;
	kQ3PickDetailMaskShapePart	= {TQ3PickDetailMasks}$80;


TYPE
	TQ3PickDetail						= LONGINT;
{
*****************************************************************************
 **																			 **
 **								Hitlist sorting								 **
 **																			 **
 ****************************************************************************
}
	TQ3PickSort 				= LONGINT;
CONST
	kQ3PickSortNone				= {TQ3PickSort}0;
	kQ3PickSortNearToFar		= {TQ3PickSort}1;
	kQ3PickSortFarToNear		= {TQ3PickSort}2;

{
*****************************************************************************
 **																			 **
 **					Data structures to set up the pick object				 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3PickDataPtr = ^TQ3PickData;
	TQ3PickData = RECORD
		sort:					TQ3PickSort;
		mask:					TQ3PickDetail;
		numHitsToReturn:		LONGINT;
	END;

	TQ3WindowPointPickDataPtr = ^TQ3WindowPointPickData;
	TQ3WindowPointPickData = RECORD
		data:					TQ3PickData;
		point:					TQ3Point2D;
		vertexTolerance:		Single;
		edgeTolerance:			Single;
	END;

	TQ3WindowRectPickDataPtr = ^TQ3WindowRectPickData;
	TQ3WindowRectPickData = RECORD
		data:					TQ3PickData;
		rect:					TQ3Area;
	END;

{
*****************************************************************************
 **																			 **
 **									Hit data								 **
 **																			 **
 ****************************************************************************
}
	TQ3HitPathPtr = ^TQ3HitPath;
	TQ3HitPath = RECORD
		rootGroup:				TQ3GroupObject;
		depth:					LONGINT;
		positions:				TQ3GroupPositionPtr;
	END;

	TQ3HitDataPtr = ^TQ3HitData;
	TQ3HitData = RECORD
		part:					TQ3PickParts;
		validMask:				TQ3PickDetail;
		pickID:					LONGINT;
		path:					TQ3HitPath;
		object:					TQ3Object;
		localToWorldMatrix:		TQ3Matrix4x4;
		xyzPoint:				TQ3Point3D;
		distance:				Single;
		normal:					TQ3Vector3D;
		shapePart:				TQ3ShapePartObject;
	END;

{
*****************************************************************************
 **																			 **
 **								Pick class methods							 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Pick_GetType(pick: TQ3PickObject): TQ3ObjectType; C;
FUNCTION Q3Pick_GetData(pick: TQ3PickObject; VAR data: TQ3PickData): TQ3Status; C;
FUNCTION Q3Pick_SetData(pick: TQ3PickObject; {CONST}VAR data: TQ3PickData): TQ3Status; C;
FUNCTION Q3Pick_GetVertexTolerance(pick: TQ3PickObject; VAR vertexTolerance: Single): TQ3Status; C;
FUNCTION Q3Pick_GetEdgeTolerance(pick: TQ3PickObject; VAR edgeTolerance: Single): TQ3Status; C;
FUNCTION Q3Pick_SetVertexTolerance(pick: TQ3PickObject; vertexTolerance: Single): TQ3Status; C;
FUNCTION Q3Pick_SetEdgeTolerance(pick: TQ3PickObject; edgeTolerance: Single): TQ3Status; C;
FUNCTION Q3Pick_GetNumHits(pick: TQ3PickObject; VAR numHits: LONGINT): TQ3Status; C;
FUNCTION Q3Pick_GetHitData(pick: TQ3PickObject; index: LONGINT; VAR hitData: TQ3HitData): TQ3Status; C;
FUNCTION Q3Hit_EmptyData(VAR hitData: TQ3HitData): TQ3Status; C;
FUNCTION Q3Pick_EmptyHitList(pick: TQ3PickObject): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **							Window point pick methods						 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3WindowPointPick_New({CONST}VAR data: TQ3WindowPointPickData): TQ3PickObject; C;
FUNCTION Q3WindowPointPick_GetPoint(pick: TQ3PickObject; VAR point: TQ3Point2D): TQ3Status; C;
FUNCTION Q3WindowPointPick_SetPoint(pick: TQ3PickObject; {CONST}VAR point: TQ3Point2D): TQ3Status; C;
FUNCTION Q3WindowPointPick_GetData(pick: TQ3PickObject; VAR data: TQ3WindowPointPickData): TQ3Status; C;
FUNCTION Q3WindowPointPick_SetData(pick: TQ3PickObject; {CONST}VAR data: TQ3WindowPointPickData): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **							Window rect pick methods						 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3WindowRectPick_New({CONST}VAR data: TQ3WindowRectPickData): TQ3PickObject; C;
FUNCTION Q3WindowRectPick_GetRect(pick: TQ3PickObject; VAR rect: TQ3Area): TQ3Status; C;
FUNCTION Q3WindowRectPick_SetRect(pick: TQ3PickObject; {CONST}VAR rect: TQ3Area): TQ3Status; C;
FUNCTION Q3WindowRectPick_GetData(pick: TQ3PickObject; VAR data: TQ3WindowRectPickData): TQ3Status; C;
FUNCTION Q3WindowRectPick_SetData(pick: TQ3PickObject; {CONST}VAR data: TQ3WindowRectPickData): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **								Shape Part methods							 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3ShapePart_GetType(shapePartObject: TQ3ShapePartObject): TQ3ObjectType; C;
FUNCTION Q3MeshPart_GetType(meshPartObject: TQ3MeshPartObject): TQ3ObjectType; C;
FUNCTION Q3ShapePart_GetShape(shapePartObject: TQ3ShapePartObject; VAR shapeObject: TQ3ShapeObject): TQ3Status; C;
FUNCTION Q3MeshPart_GetComponent(meshPartObject: TQ3MeshPartObject; VAR component: TQ3MeshComponent): TQ3Status; C;
FUNCTION Q3MeshFacePart_GetFace(meshFacePartObject: TQ3MeshFacePartObject; VAR face: TQ3MeshFace): TQ3Status; C;
FUNCTION Q3MeshEdgePart_GetEdge(meshEdgePartObject: TQ3MeshEdgePartObject; VAR edge: TQ3MeshEdge): TQ3Status; C;
FUNCTION Q3MeshVertexPart_GetVertex(meshVertexPartObject: TQ3MeshVertexPartObject; VAR vertex: TQ3MeshVertex): TQ3Status; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DPickIncludes}

{$ENDC} {__QD3DPICK__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
