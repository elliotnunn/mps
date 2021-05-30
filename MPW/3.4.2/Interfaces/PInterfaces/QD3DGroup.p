{
 	File:		QD3DGroup.p
 
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

{
*****************************************************************************
 **																			 **
 **							Group Typedefs									 **
 **																			 **
 ****************************************************************************
}
{
 * These flags affect how a group is traversed
 * They apply to when a group is "drawn", "picked", "bounded", "written"
}

TYPE
	TQ3DisplayGroupStateMasks 	= LONGINT;
CONST
	kQ3DisplayGroupStateNone	= {TQ3DisplayGroupStateMasks}0;
	kQ3DisplayGroupStateMaskIsDrawn = {TQ3DisplayGroupStateMasks}$01;
	kQ3DisplayGroupStateMaskIsInline = {TQ3DisplayGroupStateMasks}$02;
	kQ3DisplayGroupStateMaskUseBoundingBox = {TQ3DisplayGroupStateMasks}$04;
	kQ3DisplayGroupStateMaskUseBoundingSphere = {TQ3DisplayGroupStateMasks}$08;
	kQ3DisplayGroupStateMaskIsPicked = {TQ3DisplayGroupStateMasks}$10;
	kQ3DisplayGroupStateMaskIsWritten = {TQ3DisplayGroupStateMasks}$20;


TYPE
	TQ3DisplayGroupState				= LONGINT;
{
*****************************************************************************
 **																			 **
 **					Group Routines (apply to all groups)					 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Group_New: TQ3GroupObject; C;
FUNCTION Q3Group_GetType(group: TQ3GroupObject): TQ3ObjectType; C;
FUNCTION Q3Group_AddObject(group: TQ3GroupObject; object: TQ3Object): TQ3GroupPosition; C;
FUNCTION Q3Group_AddObjectBefore(group: TQ3GroupObject; position: TQ3GroupPosition; object: TQ3Object): TQ3GroupPosition; C;
FUNCTION Q3Group_AddObjectAfter(group: TQ3GroupObject; position: TQ3GroupPosition; object: TQ3Object): TQ3GroupPosition; C;
FUNCTION Q3Group_GetPositionObject(group: TQ3GroupObject; position: TQ3GroupPosition; VAR object: TQ3Object): TQ3Status; C;
FUNCTION Q3Group_SetPositionObject(group: TQ3GroupObject; position: TQ3GroupPosition; object: TQ3Object): TQ3Status; C;
FUNCTION Q3Group_RemovePosition(group: TQ3GroupObject; position: TQ3GroupPosition): TQ3Object; C;
FUNCTION Q3Group_GetFirstPosition(group: TQ3GroupObject; VAR position: TQ3GroupPosition): TQ3Status; C;
FUNCTION Q3Group_GetLastPosition(group: TQ3GroupObject; VAR position: TQ3GroupPosition): TQ3Status; C;
FUNCTION Q3Group_GetNextPosition(group: TQ3GroupObject; VAR position: TQ3GroupPosition): TQ3Status; C;
FUNCTION Q3Group_GetPreviousPosition(group: TQ3GroupObject; VAR position: TQ3GroupPosition): TQ3Status; C;
FUNCTION Q3Group_CountObjects(group: TQ3GroupObject; VAR nObjects: LONGINT): TQ3Status; C;
FUNCTION Q3Group_EmptyObjects(group: TQ3GroupObject): TQ3Status; C;
{
 * 	Typed Access
}
FUNCTION Q3Group_GetFirstPositionOfType(group: TQ3GroupObject; isType: TQ3ObjectType; VAR position: TQ3GroupPosition): TQ3Status; C;
FUNCTION Q3Group_GetLastPositionOfType(group: TQ3GroupObject; isType: TQ3ObjectType; VAR position: TQ3GroupPosition): TQ3Status; C;
FUNCTION Q3Group_GetNextPositionOfType(group: TQ3GroupObject; isType: TQ3ObjectType; VAR position: TQ3GroupPosition): TQ3Status; C;
FUNCTION Q3Group_GetPreviousPositionOfType(group: TQ3GroupObject; isType: TQ3ObjectType; VAR position: TQ3GroupPosition): TQ3Status; C;
FUNCTION Q3Group_CountObjectsOfType(group: TQ3GroupObject; isType: TQ3ObjectType; VAR nObjects: LONGINT): TQ3Status; C;
FUNCTION Q3Group_EmptyObjectsOfType(group: TQ3GroupObject; isType: TQ3ObjectType): TQ3Status; C;
{
 *	Determine position of objects in a group
}
FUNCTION Q3Group_GetFirstObjectPosition(group: TQ3GroupObject; object: TQ3Object; VAR position: TQ3GroupPosition): TQ3Status; C;
FUNCTION Q3Group_GetLastObjectPosition(group: TQ3GroupObject; object: TQ3Object; VAR position: TQ3GroupPosition): TQ3Status; C;
FUNCTION Q3Group_GetNextObjectPosition(group: TQ3GroupObject; object: TQ3Object; VAR position: TQ3GroupPosition): TQ3Status; C;
FUNCTION Q3Group_GetPreviousObjectPosition(group: TQ3GroupObject; object: TQ3Object; VAR position: TQ3GroupPosition): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **							Group Subclasses								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3LightGroup_New: TQ3GroupObject; C;
FUNCTION Q3InfoGroup_New: TQ3GroupObject; C;
{
*****************************************************************************
 **																			 **
 **						Display Group Routines								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3DisplayGroup_New: TQ3GroupObject; C;
FUNCTION Q3DisplayGroup_GetType(group: TQ3GroupObject): TQ3ObjectType; C;
FUNCTION Q3DisplayGroup_GetState(group: TQ3GroupObject; VAR state: TQ3DisplayGroupState): TQ3Status; C;
FUNCTION Q3DisplayGroup_SetState(group: TQ3GroupObject; state: TQ3DisplayGroupState): TQ3Status; C;
FUNCTION Q3DisplayGroup_Submit(group: TQ3GroupObject; view: TQ3ViewObject): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **		Ordered Display Group											 	 **
 **																			 **
 **		Ordered display groups keep objects in order by the type of object:	 **
 **																			 **
 **		1	kQ3ShapeTypeTransform											 **
 **		2	kQ3ShapeTypeStyle											 	 **
 **		3	kQ3SetTypeAttribute											 	 **
 **		4	kQ3ShapeTypeShader											 	 **
 **		5	kQ3ShapeTypeCamera											 	 **
 **		6	kQ3ShapeTypeLight											 	 **
 **		7	kQ3ShapeTypeGeometry											 **
 **		8	kQ3ShapeTypeGroup												 **			
 **		9	kQ3ShapeTypeUnknown												 **
 **																			 **
 **		Within a type, you are responsible for keeping things in order.		 **
 **																			 **
 **		You may access and/or manipulate the group using the above types 	 **
 **		(fast), or you may use any parent or leaf class types (slower).		 **
 **																			 **
 **		Additional types will be added as functionality grows.				 **
 **																			 **
 **		The group calls which access by type are much faster for ordered	 ** 
 **		display group for the types above.									 **
 **																			 **
 **		N.B. In QuickDraw 3D 1.0 Lights and Cameras are a no-op when drawn.	 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3OrderedDisplayGroup_New: TQ3GroupObject; C;
{
*****************************************************************************
 **																			 **
 **		IO Proxy Display Group											 	 **
 **																			 **
 **		IO Proxy display groups are used to place more than one 			 **
 **		representation of an object in a metafile. For example, if you know	 **
 **		another program does not understand NURBPatches but does understand  **
 **		Meshes, you may place a mesh and a NURB Patch in an IO Proxy Group,  **
 **		and the reading program will select the desired representation.		 **
 **																			 **
 **		Objects in an IO Proxy Display Group are placed in their preferencial**
 **		order, with the FIRST object being the MOST preferred, the LAST 	 **
 **		object the least preferred.											 **
 **																			 **
 **		The behavior of an IO Proxy Display Group is that when drawn/picked/ **
 **		bounded, the first object in the group that is not "Unknown" is used,**
 **		and the other objects ignored.										 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3IOProxyDisplayGroup_New: TQ3GroupObject; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DGroupIncludes}

{$ENDC} {__QD3DGROUP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
