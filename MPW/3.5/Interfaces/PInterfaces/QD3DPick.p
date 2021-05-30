{
     File:       QD3DPick.p
 
     Contains:   Q3Pick methods
 
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

{****************************************************************************
 **                                                                         **
 **                         Mask bits for hit information                   **
 **                                                                         **
 ****************************************************************************}

TYPE
	TQ3PickDetailMasks 			= SInt32;
CONST
	kQ3PickDetailNone			= 0;
	kQ3PickDetailMaskPickID		= $01;
	kQ3PickDetailMaskPath		= $02;
	kQ3PickDetailMaskObject		= $04;
	kQ3PickDetailMaskLocalToWorldMatrix = $08;
	kQ3PickDetailMaskXYZ		= $10;
	kQ3PickDetailMaskDistance	= $20;
	kQ3PickDetailMaskNormal		= $40;
	kQ3PickDetailMaskShapePart	= $80;
	kQ3PickDetailMaskPickPart	= $0100;
	kQ3PickDetailMaskUV			= $0200;


TYPE
	TQ3PickDetail						= UInt32;
	{	*****************************************************************************
	 **                                                                          **
	 **                             Hitlist sorting                              **
	 **                                                                          **
	 ****************************************************************************	}
	TQ3PickSort 				= SInt32;
CONST
	kQ3PickSortNone				= 0;
	kQ3PickSortNearToFar		= 1;
	kQ3PickSortFarToNear		= 2;


	{	*****************************************************************************
	 **                                                                          **
	 **                 Data structures to set up the pick object                **
	 **                                                                          **
	 ****************************************************************************	}

TYPE
	TQ3PickDataPtr = ^TQ3PickData;
	TQ3PickData = RECORD
		sort:					TQ3PickSort;
		mask:					TQ3PickDetail;
		numHitsToReturn:		UInt32;
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

	TQ3WorldRayPickDataPtr = ^TQ3WorldRayPickData;
	TQ3WorldRayPickData = RECORD
		data:					TQ3PickData;
		ray:					TQ3Ray3D;
		vertexTolerance:		Single;
		edgeTolerance:			Single;
	END;


	{	*****************************************************************************
	 **                                                                          **
	 **                                 Hit data                                 **
	 **                                                                          **
	 ****************************************************************************	}
	TQ3HitPathPtr = ^TQ3HitPath;
	TQ3HitPath = RECORD
		rootGroup:				TQ3GroupObject;
		depth:					UInt32;
		positions:				TQ3GroupPositionPtr;
	END;

	{	*****************************************************************************
	 **                                                                          **
	 **                             Pick class methods                           **
	 **                                                                          **
	 ****************************************************************************	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3Pick_GetType()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3Pick_GetType(pick: TQ3PickObject): TQ3ObjectType; C;

{
 *  Q3Pick_GetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Pick_GetData(pick: TQ3PickObject; VAR data: TQ3PickData): TQ3Status; C;

{
 *  Q3Pick_SetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Pick_SetData(pick: TQ3PickObject; {CONST}VAR data: TQ3PickData): TQ3Status; C;

{
 *  Q3Pick_GetVertexTolerance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Pick_GetVertexTolerance(pick: TQ3PickObject; VAR vertexTolerance: Single): TQ3Status; C;

{
 *  Q3Pick_GetEdgeTolerance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Pick_GetEdgeTolerance(pick: TQ3PickObject; VAR edgeTolerance: Single): TQ3Status; C;

{
 *  Q3Pick_SetVertexTolerance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Pick_SetVertexTolerance(pick: TQ3PickObject; vertexTolerance: Single): TQ3Status; C;

{
 *  Q3Pick_SetEdgeTolerance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Pick_SetEdgeTolerance(pick: TQ3PickObject; edgeTolerance: Single): TQ3Status; C;

{
 *  Q3Pick_GetNumHits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Pick_GetNumHits(pick: TQ3PickObject; VAR numHits: UInt32): TQ3Status; C;

{
 *  Q3Pick_EmptyHitList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Pick_EmptyHitList(pick: TQ3PickObject): TQ3Status; C;

{
 *  Q3Pick_GetPickDetailValidMask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Pick_GetPickDetailValidMask(pick: TQ3PickObject; index: UInt32; VAR pickDetailValidMask: TQ3PickDetail): TQ3Status; C;

{
 *  Q3Pick_GetPickDetailData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Pick_GetPickDetailData(pick: TQ3PickObject; index: UInt32; pickDetailValue: TQ3PickDetail; detailData: UNIV Ptr): TQ3Status; C;

{
 *  Q3HitPath_EmptyData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3HitPath_EmptyData(VAR hitPath: TQ3HitPath): TQ3Status; C;

{$ENDC}  {CALL_NOT_IN_CARBON}

{*****************************************************************************
 **                                                                          **
 **                         Window point pick methods                        **
 **                                                                          **
 ****************************************************************************}
{$IFC CALL_NOT_IN_CARBON }
{
 *  Q3WindowPointPick_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3WindowPointPick_New({CONST}VAR data: TQ3WindowPointPickData): TQ3PickObject; C;

{
 *  Q3WindowPointPick_GetPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3WindowPointPick_GetPoint(pick: TQ3PickObject; VAR point: TQ3Point2D): TQ3Status; C;

{
 *  Q3WindowPointPick_SetPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3WindowPointPick_SetPoint(pick: TQ3PickObject; {CONST}VAR point: TQ3Point2D): TQ3Status; C;

{
 *  Q3WindowPointPick_GetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3WindowPointPick_GetData(pick: TQ3PickObject; VAR data: TQ3WindowPointPickData): TQ3Status; C;

{
 *  Q3WindowPointPick_SetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3WindowPointPick_SetData(pick: TQ3PickObject; {CONST}VAR data: TQ3WindowPointPickData): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         Window rect pick methods                         **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3WindowRectPick_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3WindowRectPick_New({CONST}VAR data: TQ3WindowRectPickData): TQ3PickObject; C;

{
 *  Q3WindowRectPick_GetRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3WindowRectPick_GetRect(pick: TQ3PickObject; VAR rect: TQ3Area): TQ3Status; C;

{
 *  Q3WindowRectPick_SetRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3WindowRectPick_SetRect(pick: TQ3PickObject; {CONST}VAR rect: TQ3Area): TQ3Status; C;

{
 *  Q3WindowRectPick_GetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3WindowRectPick_GetData(pick: TQ3PickObject; VAR data: TQ3WindowRectPickData): TQ3Status; C;

{
 *  Q3WindowRectPick_SetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3WindowRectPick_SetData(pick: TQ3PickObject; {CONST}VAR data: TQ3WindowRectPickData): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         World ray pick methods                           **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3WorldRayPick_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3WorldRayPick_New({CONST}VAR data: TQ3WorldRayPickData): TQ3PickObject; C;

{
 *  Q3WorldRayPick_GetRay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3WorldRayPick_GetRay(pick: TQ3PickObject; VAR ray: TQ3Ray3D): TQ3Status; C;

{
 *  Q3WorldRayPick_SetRay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3WorldRayPick_SetRay(pick: TQ3PickObject; {CONST}VAR ray: TQ3Ray3D): TQ3Status; C;

{
 *  Q3WorldRayPick_GetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3WorldRayPick_GetData(pick: TQ3PickObject; VAR data: TQ3WorldRayPickData): TQ3Status; C;

{
 *  Q3WorldRayPick_SetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3WorldRayPick_SetData(pick: TQ3PickObject; {CONST}VAR data: TQ3WorldRayPickData): TQ3Status; C;



{*****************************************************************************
 **                                                                          **
 **                             Shape Part methods                           **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ShapePart_GetType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ShapePart_GetType(shapePartObject: TQ3ShapePartObject): TQ3ObjectType; C;

{
 *  Q3MeshPart_GetType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3MeshPart_GetType(meshPartObject: TQ3MeshPartObject): TQ3ObjectType; C;

{
 *  Q3ShapePart_GetShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ShapePart_GetShape(shapePartObject: TQ3ShapePartObject; VAR shapeObject: TQ3ShapeObject): TQ3Status; C;

{
 *  Q3MeshPart_GetComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3MeshPart_GetComponent(meshPartObject: TQ3MeshPartObject; VAR component: TQ3MeshComponent): TQ3Status; C;

{
 *  Q3MeshFacePart_GetFace()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3MeshFacePart_GetFace(meshFacePartObject: TQ3MeshFacePartObject; VAR face: TQ3MeshFace): TQ3Status; C;

{
 *  Q3MeshEdgePart_GetEdge()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3MeshEdgePart_GetEdge(meshEdgePartObject: TQ3MeshEdgePartObject; VAR edge: TQ3MeshEdge): TQ3Status; C;

{
 *  Q3MeshVertexPart_GetVertex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3MeshVertexPart_GetVertex(meshVertexPartObject: TQ3MeshVertexPartObject; VAR vertex: TQ3MeshVertex): TQ3Status; C;



{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DPickIncludes}

{$ENDC} {__QD3DPICK__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
