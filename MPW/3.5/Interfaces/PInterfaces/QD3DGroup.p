{
     File:       QD3DGroup.p
 
     Contains:   Q3Group methods
 
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
 UNIT QD3DGroup;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DGROUP__}
{$SETC __QD3DGROUP__ := 1}

{$I+}
{$SETC QD3DGroupIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{*****************************************************************************
 **                                                                          **
 **                         Group Typedefs                                   **
 **                                                                          **
 ****************************************************************************}
{
 * These flags affect how a group is traversed
 * They apply to when a group is "drawn", "picked", "bounded", "written"
 }

TYPE
	TQ3DisplayGroupStateMasks 	= SInt32;
CONST
	kQ3DisplayGroupStateNone	= 0;
	kQ3DisplayGroupStateMaskIsDrawn = $01;
	kQ3DisplayGroupStateMaskIsInline = $02;
	kQ3DisplayGroupStateMaskUseBoundingBox = $04;
	kQ3DisplayGroupStateMaskUseBoundingSphere = $08;
	kQ3DisplayGroupStateMaskIsPicked = $10;
	kQ3DisplayGroupStateMaskIsWritten = $20;


TYPE
	TQ3DisplayGroupState				= UInt32;
	{	*****************************************************************************
	 **                                                                          **
	 **                 Group Routines (apply to all groups)                     **
	 **                                                                          **
	 ****************************************************************************	}
	{	 May contain any shared object 	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3Group_New()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3Group_New: TQ3GroupObject; C;

{
 *  Q3Group_GetType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_GetType(group: TQ3GroupObject): TQ3ObjectType; C;

{
 *  Q3Group_AddObject()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_AddObject(group: TQ3GroupObject; object: TQ3Object): TQ3GroupPosition; C;

{
 *  Q3Group_AddObjectBefore()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_AddObjectBefore(group: TQ3GroupObject; position: TQ3GroupPosition; object: TQ3Object): TQ3GroupPosition; C;

{
 *  Q3Group_AddObjectAfter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_AddObjectAfter(group: TQ3GroupObject; position: TQ3GroupPosition; object: TQ3Object): TQ3GroupPosition; C;

{
 *  Q3Group_GetPositionObject()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_GetPositionObject(group: TQ3GroupObject; position: TQ3GroupPosition; VAR object: TQ3Object): TQ3Status; C;

{
 *  Q3Group_SetPositionObject()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_SetPositionObject(group: TQ3GroupObject; position: TQ3GroupPosition; object: TQ3Object): TQ3Status; C;

{
 *  Q3Group_RemovePosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_RemovePosition(group: TQ3GroupObject; position: TQ3GroupPosition): TQ3Object; C;

{
 *  Q3Group_GetFirstPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_GetFirstPosition(group: TQ3GroupObject; VAR position: TQ3GroupPosition): TQ3Status; C;

{
 *  Q3Group_GetLastPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_GetLastPosition(group: TQ3GroupObject; VAR position: TQ3GroupPosition): TQ3Status; C;

{
 *  Q3Group_GetNextPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_GetNextPosition(group: TQ3GroupObject; VAR position: TQ3GroupPosition): TQ3Status; C;

{
 *  Q3Group_GetPreviousPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_GetPreviousPosition(group: TQ3GroupObject; VAR position: TQ3GroupPosition): TQ3Status; C;

{
 *  Q3Group_CountObjects()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_CountObjects(group: TQ3GroupObject; VAR nObjects: UInt32): TQ3Status; C;

{
 *  Q3Group_EmptyObjects()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_EmptyObjects(group: TQ3GroupObject): TQ3Status; C;

{
 *  Typed Access
 }
{
 *  Q3Group_GetFirstPositionOfType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_GetFirstPositionOfType(group: TQ3GroupObject; isType: TQ3ObjectType; VAR position: TQ3GroupPosition): TQ3Status; C;

{
 *  Q3Group_GetLastPositionOfType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_GetLastPositionOfType(group: TQ3GroupObject; isType: TQ3ObjectType; VAR position: TQ3GroupPosition): TQ3Status; C;

{
 *  Q3Group_GetNextPositionOfType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_GetNextPositionOfType(group: TQ3GroupObject; isType: TQ3ObjectType; VAR position: TQ3GroupPosition): TQ3Status; C;

{
 *  Q3Group_GetPreviousPositionOfType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_GetPreviousPositionOfType(group: TQ3GroupObject; isType: TQ3ObjectType; VAR position: TQ3GroupPosition): TQ3Status; C;

{
 *  Q3Group_CountObjectsOfType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_CountObjectsOfType(group: TQ3GroupObject; isType: TQ3ObjectType; VAR nObjects: UInt32): TQ3Status; C;

{
 *  Q3Group_EmptyObjectsOfType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_EmptyObjectsOfType(group: TQ3GroupObject; isType: TQ3ObjectType): TQ3Status; C;

{
 *  Determine position of objects in a group
 }
{
 *  Q3Group_GetFirstObjectPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_GetFirstObjectPosition(group: TQ3GroupObject; object: TQ3Object; VAR position: TQ3GroupPosition): TQ3Status; C;

{
 *  Q3Group_GetLastObjectPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_GetLastObjectPosition(group: TQ3GroupObject; object: TQ3Object; VAR position: TQ3GroupPosition): TQ3Status; C;

{
 *  Q3Group_GetNextObjectPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_GetNextObjectPosition(group: TQ3GroupObject; object: TQ3Object; VAR position: TQ3GroupPosition): TQ3Status; C;

{
 *  Q3Group_GetPreviousObjectPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Group_GetPreviousObjectPosition(group: TQ3GroupObject; object: TQ3Object; VAR position: TQ3GroupPosition): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         Group Subclasses                                 **
 **                                                                          **
 ****************************************************************************}
{ Must contain only lights }
{
 *  Q3LightGroup_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3LightGroup_New: TQ3GroupObject; C;

{ Must contain only strings }
{
 *  Q3InfoGroup_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3InfoGroup_New: TQ3GroupObject; C;

{*****************************************************************************
 **                                                                          **
 **                     Display Group Routines                               **
 **                                                                          **
 ****************************************************************************}
{ May contain only drawables }
{
 *  Q3DisplayGroup_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3DisplayGroup_New: TQ3GroupObject; C;

{
 *  Q3DisplayGroup_GetType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3DisplayGroup_GetType(group: TQ3GroupObject): TQ3ObjectType; C;

{
 *  Q3DisplayGroup_GetState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3DisplayGroup_GetState(group: TQ3GroupObject; VAR state: TQ3DisplayGroupState): TQ3Status; C;

{
 *  Q3DisplayGroup_SetState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3DisplayGroup_SetState(group: TQ3GroupObject; state: TQ3DisplayGroupState): TQ3Status; C;

{
 *  Q3DisplayGroup_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3DisplayGroup_Submit(group: TQ3GroupObject; view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3DisplayGroup_SetAndUseBoundingBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3DisplayGroup_SetAndUseBoundingBox(group: TQ3GroupObject; VAR bBox: TQ3BoundingBox): TQ3Status; C;

{
 *  Q3DisplayGroup_GetBoundingBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3DisplayGroup_GetBoundingBox(group: TQ3GroupObject; VAR bBox: TQ3BoundingBox): TQ3Status; C;

{
 *  Q3DisplayGroup_RemoveBoundingBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3DisplayGroup_RemoveBoundingBox(group: TQ3GroupObject): TQ3Status; C;

{
 *  Q3DisplayGroup_CalcAndUseBoundingBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3DisplayGroup_CalcAndUseBoundingBox(group: TQ3GroupObject; computeBounds: TQ3ComputeBounds; view: TQ3ViewObject): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **     Ordered Display Group                                                **
 **                                                                          **
 **     Ordered display groups keep objects in order by the type of object:  **
 **                                                                          **
 **     1   kQ3ShapeTypeTransform                                            **
 **     2   kQ3ShapeTypeStyle                                                **
 **     3   kQ3SetTypeAttribute                                              **
 **     4   kQ3ShapeTypeShader                                               **
 **     5   kQ3ShapeTypeCamera                                               **
 **     6   kQ3ShapeTypeLight                                                **
 **     7   kQ3ShapeTypeGeometry                                             **
 **     8   kQ3ShapeTypeGroup                                                **         
 **     9   kQ3ShapeTypeUnknown                                              **
 **                                                                          **
 **     Within a type, you are responsible for keeping things in order.      **
 **                                                                          **
 **     You may access and/or manipulate the group using the above types     **
 **     (fast), or you may use any parent or leaf class types (slower).      **
 **                                                                          **
 **     Additional types will be added as functionality grows.               **
 **                                                                          **
 **     The group calls which access by type are much faster for ordered     ** 
 **     display group for the types above.                                   **
 **                                                                          **
 **     N.B. Lights and Cameras in groups are a no-op when drawn and will    **
 **          post an error with the debug libraries.                         **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3OrderedDisplayGroup_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3OrderedDisplayGroup_New: TQ3GroupObject; C;

{*****************************************************************************
 **                                                                          **
 **     IO Proxy Display Group                                               **
 **                                                                          **
 **     IO Proxy display groups are used to place more than one              **
 **     representation of an object in a metafile. For example, if you know  **
 **     another program does not understand NURBPatches but does understand  **
 **     Meshes, you may place a mesh and a NURB Patch in an IO Proxy Group,  **
 **     and the reading program will select the desired representation.      **
 **                                                                          **
 **     Objects in an IO Proxy Display Group are placed in their preferencial**
 **     order, with the FIRST object being the MOST preferred, the LAST      **
 **     object the least preferred.                                          **
 **                                                                          **
 **     The behavior of an IO Proxy Display Group is that when drawn/picked/ **
 **     bounded, the first object in the group that is not "Unknown" is used,**
 **     and the other objects ignored.                                       **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3IOProxyDisplayGroup_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3IOProxyDisplayGroup_New: TQ3GroupObject; C;

{*****************************************************************************
 **                                                                          **
 **                     Group Extension Definitions                          **
 **                                                                          **
 ****************************************************************************}
{
 *  Searching methods - OPTIONAL
 }
{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	kQ3XMethodType_GroupAcceptObject = 'gaco';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XGroupAcceptObjectMethod = FUNCTION(group: TQ3GroupObject; object: TQ3Object): TQ3Boolean; C;
{$ELSEC}
	TQ3XGroupAcceptObjectMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodType_GroupAddObject = 'gado';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XGroupAddObjectMethod = FUNCTION(group: TQ3GroupObject; object: TQ3Object): TQ3GroupPosition; C;
{$ELSEC}
	TQ3XGroupAddObjectMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodType_GroupAddObjectBefore = 'gaob';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XGroupAddObjectBeforeMethod = FUNCTION(group: TQ3GroupObject; position: TQ3GroupPosition; object: TQ3Object): TQ3GroupPosition; C;
{$ELSEC}
	TQ3XGroupAddObjectBeforeMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodType_GroupAddObjectAfter = 'gaoa';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XGroupAddObjectAfterMethod = FUNCTION(group: TQ3GroupObject; position: TQ3GroupPosition; object: TQ3Object): TQ3GroupPosition; C;
{$ELSEC}
	TQ3XGroupAddObjectAfterMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodType_GroupSetPositionObject = 'gspo';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XGroupSetPositionObjectMethod = FUNCTION(group: TQ3GroupObject; gPos: TQ3GroupPosition; obj: TQ3Object): TQ3Status; C;
{$ELSEC}
	TQ3XGroupSetPositionObjectMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodType_GroupRemovePosition = 'grmp';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XGroupRemovePositionMethod = FUNCTION(group: TQ3GroupObject; position: TQ3GroupPosition): TQ3Object; C;
{$ELSEC}
	TQ3XGroupRemovePositionMethod = ProcPtr;
{$ENDC}

	{	
	 *  Searching methods - OPTIONAL - default uses above methods
	 	}

CONST
	kQ3XMethodType_GroupGetFirstPositionOfType = 'gfrt';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XGroupGetFirstPositionOfTypeMethod = FUNCTION(group: TQ3GroupObject; isType: TQ3ObjectType; VAR gPos: TQ3GroupPosition): TQ3Status; C;
{$ELSEC}
	TQ3XGroupGetFirstPositionOfTypeMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodType_GroupGetLastPositionOfType = 'glst';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XGroupGetLastPositionOfTypeMethod = FUNCTION(group: TQ3GroupObject; isType: TQ3ObjectType; VAR gPos: TQ3GroupPosition): TQ3Status; C;
{$ELSEC}
	TQ3XGroupGetLastPositionOfTypeMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodType_GroupGetNextPositionOfType = 'gnxt';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XGroupGetNextPositionOfTypeMethod = FUNCTION(group: TQ3GroupObject; isType: TQ3ObjectType; VAR gPos: TQ3GroupPosition): TQ3Status; C;
{$ELSEC}
	TQ3XGroupGetNextPositionOfTypeMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodType_GroupGetPrevPositionOfType = 'gpvt';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XGroupGetPrevPositionOfTypeMethod = FUNCTION(group: TQ3GroupObject; isType: TQ3ObjectType; VAR gPos: TQ3GroupPosition): TQ3Status; C;
{$ELSEC}
	TQ3XGroupGetPrevPositionOfTypeMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodType_GroupCountObjectsOfType = 'gcnt';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XGroupCountObjectsOfTypeMethod = FUNCTION(group: TQ3GroupObject; isType: TQ3ObjectType; VAR nObjects: UInt32): TQ3Status; C;
{$ELSEC}
	TQ3XGroupCountObjectsOfTypeMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodType_GroupEmptyObjectsOfType = 'geot';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XGroupEmptyObjectsOfTypeMethod = FUNCTION(group: TQ3GroupObject; isType: TQ3ObjectType): TQ3Status; C;
{$ELSEC}
	TQ3XGroupEmptyObjectsOfTypeMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodType_GroupGetFirstObjectPosition = 'gfop';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XGroupGetFirstObjectPositionMethod = FUNCTION(group: TQ3GroupObject; object: TQ3Object; VAR gPos: TQ3GroupPosition): TQ3Status; C;
{$ELSEC}
	TQ3XGroupGetFirstObjectPositionMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodType_GroupGetLastObjectPosition = 'glop';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XGroupGetLastObjectPositionMethod = FUNCTION(group: TQ3GroupObject; object: TQ3Object; VAR gPos: TQ3GroupPosition): TQ3Status; C;
{$ELSEC}
	TQ3XGroupGetLastObjectPositionMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodType_GroupGetNextObjectPosition = 'gnop';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XGroupGetNextObjectPositionMethod = FUNCTION(group: TQ3GroupObject; object: TQ3Object; VAR gPos: TQ3GroupPosition): TQ3Status; C;
{$ELSEC}
	TQ3XGroupGetNextObjectPositionMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodType_GroupGetPrevObjectPosition = 'gpop';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XGroupGetPrevObjectPositionMethod = FUNCTION(group: TQ3GroupObject; object: TQ3Object; VAR gPos: TQ3GroupPosition): TQ3Status; C;
{$ELSEC}
	TQ3XGroupGetPrevObjectPositionMethod = ProcPtr;
{$ENDC}

	{	
	 *  Group Position Methods
	 	}

CONST
	kQ3XMethodType_GroupPositionSize = 'ggpz';


TYPE
	TQ3XMethodTypeGroupPositionSize		= UInt32;

CONST
	kQ3XMethodType_GroupPositionNew = 'ggpn';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XGroupPositionNewMethod = FUNCTION(gPos: UNIV Ptr; object: TQ3Object; initData: UNIV Ptr): TQ3Status; C;
{$ELSEC}
	TQ3XGroupPositionNewMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodType_GroupPositionCopy = 'ggpc';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XGroupPositionCopyMethod = FUNCTION(srcGPos: UNIV Ptr; dstGPos: UNIV Ptr): TQ3Status; C;
{$ELSEC}
	TQ3XGroupPositionCopyMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodType_GroupPositionDelete = 'ggpd';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XGroupPositionDeleteMethod = PROCEDURE(gPos: UNIV Ptr); C;
{$ELSEC}
	TQ3XGroupPositionDeleteMethod = ProcPtr;
{$ENDC}

	{	
	 *  View Drawing Helpers
	 *  
	 *  TQ3XGroupStartIterateMethod
	 *
	 *      Pass back *object = NULL to NOT call EndIterate iterate
	 *      Pass back *object != NULL to draw object
	 *       (other side will pass it to EndIterate for deletion!)
	 *
	 *      *iterator is uninitialized, use for iteration state. Caller should 
	 *       ignore it.
	 *  
	 *  TQ3XGroupEndIterateMethod
	 *  
	 *      *object is previous object, dispose it or play with it.
	 *      Pass back NULL when last iteration has occurred
	 *      *iterator is previous value, use for iteration state Caller should 
	 *      ignore it.
	 	}

CONST
	kQ3XMethodType_GroupStartIterate = 'gstd';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XGroupStartIterateMethod = FUNCTION(group: TQ3GroupObject; VAR iterator: TQ3GroupPosition; VAR object: TQ3Object; view: TQ3ViewObject): TQ3Status; C;
{$ELSEC}
	TQ3XGroupStartIterateMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodType_GroupEndIterate = 'gitd';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XGroupEndIterateMethod = FUNCTION(group: TQ3GroupObject; VAR iterator: TQ3GroupPosition; VAR object: TQ3Object; view: TQ3ViewObject): TQ3Status; C;
{$ELSEC}
	TQ3XGroupEndIterateMethod = ProcPtr;
{$ENDC}

	{	
	 *  IO  Helpers
	 *  
	 *  TQ3XGroupEndReadMethod
	 *      Called when a group has been completely read. Group should perform
	 *      validation and clean up any reading caches.
	 	}

CONST
	kQ3XMethodType_GroupEndRead	= 'gerd';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XGroupEndReadMethod = FUNCTION(group: TQ3GroupObject): TQ3Status; C;
{$ELSEC}
	TQ3XGroupEndReadMethod = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3XGroup_GetPositionPrivate()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3XGroup_GetPositionPrivate(group: TQ3GroupObject; position: TQ3GroupPosition): Ptr; C;



{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DGroupIncludes}

{$ENDC} {__QD3DGROUP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
