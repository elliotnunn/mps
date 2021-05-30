/******************************************************************************
 **																			 **
 **																			 **
 ** 	Module:		QD3DGroup.h												 **
 **																			 **
 **																			 **
 ** 	Purpose:															 **
 **																			 **
 **																			 **
 ** 	Copyright (C) 1992-1995 Apple Computer, Inc.  All rights reserved.	 **
 **																			 **
 **																			 **
 *****************************************************************************/
#ifndef QD3DGroup_h
#define QD3DGroup_h

#ifndef QD3D_h
#include <QD3D.h>
#endif  /*  QD3D_h  */

#if PRAGMA_ONCE
	#pragma once
#endif

#if defined(__MWERKS__)
	#pragma enumsalwaysint on
	#pragma align_array_members off
	#pragma options align=native
#endif

#ifdef __cplusplus
extern "C" {
#endif /*  __cplusplus  */


/******************************************************************************
 **																			 **
 **							Group Typedefs									 **
 **																			 **
 *****************************************************************************/

/*
 * These flags affect how a group is traversed
 * They apply to when a group is "drawn", "picked", "bounded", "written"
 */
typedef enum TQ3DisplayGroupStateMasks {
	kQ3DisplayGroupStateNone					= 0,
	kQ3DisplayGroupStateMaskIsDrawn				= 1 << 0,
	kQ3DisplayGroupStateMaskIsInline			= 1 << 1,
	kQ3DisplayGroupStateMaskUseBoundingBox		= 1 << 2,
	kQ3DisplayGroupStateMaskUseBoundingSphere	= 1 << 3,
	kQ3DisplayGroupStateMaskIsPicked			= 1 << 4,
	kQ3DisplayGroupStateMaskIsWritten			= 1 << 5
} TQ3DisplayGroupStateMasks;

typedef unsigned long TQ3DisplayGroupState;

/******************************************************************************
 **																			 **
 **					Group Routines (apply to all groups)					 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3GroupObject Q3Group_New(		/* May contain any shared object */
	void);
	
QD3D_EXPORT TQ3ObjectType Q3Group_GetType(
	TQ3GroupObject			group);

QD3D_EXPORT TQ3GroupPosition Q3Group_AddObject(
	TQ3GroupObject			group,
	TQ3Object				object);
	
QD3D_EXPORT TQ3GroupPosition Q3Group_AddObjectBefore(
	TQ3GroupObject			group,
	TQ3GroupPosition		position,
	TQ3Object				object);

QD3D_EXPORT TQ3GroupPosition Q3Group_AddObjectAfter(
	TQ3GroupObject			group,
	TQ3GroupPosition		position,
	TQ3Object				object);

QD3D_EXPORT TQ3Status Q3Group_GetPositionObject(
	TQ3GroupObject			group,
	TQ3GroupPosition		position,	
	TQ3Object				*object);		

QD3D_EXPORT TQ3Status Q3Group_SetPositionObject(
	TQ3GroupObject			group,
	TQ3GroupPosition		position,
	TQ3Object				object);

QD3D_EXPORT TQ3Object Q3Group_RemovePosition(
	TQ3GroupObject			group,
	TQ3GroupPosition		position);

QD3D_EXPORT TQ3Status Q3Group_GetFirstPosition(		
	TQ3GroupObject			group,
	TQ3GroupPosition		*position);

QD3D_EXPORT TQ3Status Q3Group_GetLastPosition(		
	TQ3GroupObject			group,
	TQ3GroupPosition		*position);

QD3D_EXPORT TQ3Status Q3Group_GetNextPosition(		
	TQ3GroupObject			group,
	TQ3GroupPosition		*position);

QD3D_EXPORT TQ3Status Q3Group_GetPreviousPosition(		
	TQ3GroupObject			group,
	TQ3GroupPosition		*position);

QD3D_EXPORT TQ3Status Q3Group_CountObjects(
	TQ3GroupObject			group,
	unsigned long			*nObjects);

QD3D_EXPORT TQ3Status Q3Group_EmptyObjects(
	TQ3GroupObject			group);
	
/*
 * 	Typed Access
 */
QD3D_EXPORT TQ3Status Q3Group_GetFirstPositionOfType(		
	TQ3GroupObject			group,
	TQ3ObjectType			isType,
	TQ3GroupPosition		*position);

QD3D_EXPORT TQ3Status Q3Group_GetLastPositionOfType(		
	TQ3GroupObject			group,
	TQ3ObjectType			isType,
	TQ3GroupPosition		*position);

QD3D_EXPORT TQ3Status Q3Group_GetNextPositionOfType(		
	TQ3GroupObject			group,
	TQ3ObjectType			isType,
	TQ3GroupPosition		*position);

QD3D_EXPORT TQ3Status Q3Group_GetPreviousPositionOfType(		
	TQ3GroupObject			group,
	TQ3ObjectType			isType,
	TQ3GroupPosition		*position);

QD3D_EXPORT TQ3Status Q3Group_CountObjectsOfType(
	TQ3GroupObject			group,
	TQ3ObjectType			isType,
	unsigned long			*nObjects);

QD3D_EXPORT TQ3Status Q3Group_EmptyObjectsOfType(
	TQ3GroupObject			group,
	TQ3ObjectType			isType);

/*
 *	Determine position of objects in a group
 */
QD3D_EXPORT TQ3Status Q3Group_GetFirstObjectPosition(
	TQ3GroupObject			group,
	TQ3Object				object,
	TQ3GroupPosition		*position);
	
QD3D_EXPORT TQ3Status Q3Group_GetLastObjectPosition(
	TQ3GroupObject			group,
	TQ3Object				object,
	TQ3GroupPosition		*position);

QD3D_EXPORT TQ3Status Q3Group_GetNextObjectPosition(
	TQ3GroupObject			group,
	TQ3Object				object,
	TQ3GroupPosition		*position);
	
QD3D_EXPORT TQ3Status Q3Group_GetPreviousObjectPosition(
	TQ3GroupObject			group,
	TQ3Object				object,
	TQ3GroupPosition		*position);
	

/******************************************************************************
 **																			 **
 **							Group Subclasses								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3GroupObject Q3LightGroup_New(		/* Must contain only lights */
	void);

QD3D_EXPORT TQ3GroupObject Q3InfoGroup_New(			/* Must contain only strings */
	void);

/******************************************************************************
 **																			 **
 **						Display Group Routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3GroupObject Q3DisplayGroup_New(	/* May contain only drawables */
	void);
	
QD3D_EXPORT TQ3ObjectType Q3DisplayGroup_GetType(
	TQ3GroupObject			group);

QD3D_EXPORT TQ3Status Q3DisplayGroup_GetState(
	TQ3GroupObject			group,
	TQ3DisplayGroupState	*state);
	
QD3D_EXPORT TQ3Status Q3DisplayGroup_SetState(
	TQ3GroupObject			group,
	TQ3DisplayGroupState	state);

QD3D_EXPORT TQ3Status Q3DisplayGroup_Submit(
	TQ3GroupObject			group, 
	TQ3ViewObject			view);

/******************************************************************************
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
 *****************************************************************************/

QD3D_EXPORT TQ3GroupObject Q3OrderedDisplayGroup_New(
	void);

/******************************************************************************
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
 *****************************************************************************/

QD3D_EXPORT TQ3GroupObject Q3IOProxyDisplayGroup_New(
	void);
		
#ifdef __cplusplus
}
#endif /*  __cplusplus  */

#if defined(__MWERKS__)
#pragma options align=reset
#pragma enumsalwaysint reset
#endif

#endif /*  QD3DGroup_h  */
