/******************************************************************************
 **																			 **
 ** 	Module:		QD3DSet.h												 **
 **																			 **
 **																			 **
 ** 	Purpose: 	Set types and routines									 **
 **																			 **
 **																			 **
 **																			 **
 ** 	Copyright (C) 1992-1995 Apple Computer, Inc.  All rights reserved.	 **
 **																			 **
 **																			 **
 *****************************************************************************/
#ifndef QD3DSet_h
#define QD3DSet_h

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
#endif	/* __cplusplus */


/******************************************************************************
 **																			 **
 **								Set Types									 **
 **																			 **
 *****************************************************************************/

typedef long					TQ3ElementType;

#define kQ3ElementTypeNone		0
#define kQ3ElementTypeUnknown	32

/* 
 *	kQ3ElementTypeUnknown is an TQ3Object. 
 *	
 *		Do Q3Set_Add(s, ..., &obj) or Q3Set_Get(s, ..., &obj);
 *		
 *		Note that the object is always referenced when copying around. 
 *		
 *		Generally, it is an Unknown object, a Group of Unknown objects, or a 
 *		group of other "objects" which have been found in the metafile and
 *		have no attachment method to their parent. Be prepared to handle
 *		any or all of these cases if you actually access the set on a shape.
 */

/******************************************************************************
 **																			 **
 **								Set Routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3SetObject Q3Set_New(
	void);

QD3D_EXPORT TQ3ObjectType Q3Set_GetType(
	TQ3SetObject		set);

QD3D_EXPORT TQ3Status Q3Set_Add(
	TQ3SetObject 		set, 
	TQ3ElementType		type,
	const void 			*data);

QD3D_EXPORT TQ3Status Q3Set_Get(
	TQ3SetObject 		set,
	TQ3ElementType		type,
	void				*data);

QD3D_EXPORT TQ3Boolean Q3Set_Contains(
	TQ3SetObject 		set,
	TQ3ElementType		type);

QD3D_EXPORT TQ3Status Q3Set_Clear(
	TQ3SetObject 		set, 
	TQ3ElementType		type);

QD3D_EXPORT TQ3Status Q3Set_Empty(
	TQ3SetObject 		target);

/*
 *  Iterating through all elements in a set
 *
 *  Pass in kQ3ElementTypeNone to get first type
 *  kQ3ElementTypeNone is returned when end of list is reached
 */
QD3D_EXPORT TQ3Status Q3Set_GetNextElementType(
	TQ3SetObject 		set,
	TQ3ElementType		*type);		


/******************************************************************************
 **																			 **
 **								Attribute Types								 **
 **																			 **
 *****************************************************************************/

/* 
 *	For the data types listed below, pass in a pointer to it in the _Add 
 *	and _Get calls.
 *
 *	For surface shader attributes, reference counts are incremented on 
 *	the _Add and _Get 
 */

typedef enum TQ3AttributeTypes {				/* Data Type				*/
	kQ3AttributeTypeNone				=  0,	/* ---------				*/
	kQ3AttributeTypeSurfaceUV			=  1,	/* TQ3Param2D				*/ 
	kQ3AttributeTypeShadingUV			=  2,	/* TQ3Param2D 				*/
	kQ3AttributeTypeNormal				=  3,	/* TQ3Vector3D 				*/
	kQ3AttributeTypeAmbientCoefficient	=  4,	/* float 					*/
	kQ3AttributeTypeDiffuseColor		=  5,	/* TQ3ColorRGB				*/
	kQ3AttributeTypeSpecularColor		=  6,	/* TQ3ColorRGB				*/
	kQ3AttributeTypeSpecularControl		=  7,	/* float					*/
	kQ3AttributeTypeTransparencyColor	=  8,	/* TQ3ColorRGB				*/
	kQ3AttributeTypeSurfaceTangent		=  9,	/* TQ3Tangent2D  			*/
	kQ3AttributeTypeHighlightState		= 10,	/* TQ3Switch 				*/
	kQ3AttributeTypeSurfaceShader		= 11,	/* TQ3SurfaceShaderObject	*/
	kQ3AttributeTypeNumTypes
} TQ3AttributeTypes;

typedef TQ3ElementType TQ3AttributeType;


/******************************************************************************
 **																			 **
 **								Attribute Drawing							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Status Q3Attribute_Submit(
	TQ3AttributeType		attributeType,
	const void				*data,
	TQ3ViewObject			view);


/******************************************************************************
 **																			 **
 **							AttributeSet Routines							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3AttributeSet Q3AttributeSet_New(
	void);

QD3D_EXPORT TQ3Status Q3AttributeSet_Add(
	TQ3AttributeSet 		attributeSet, 
	TQ3AttributeType		type,
	const void 				*data);

QD3D_EXPORT TQ3Boolean Q3AttributeSet_Contains(
	TQ3AttributeSet			attributeSet,
	TQ3AttributeType		attributeType);

QD3D_EXPORT TQ3Status Q3AttributeSet_Get(
	TQ3AttributeSet 		attributeSet,
	TQ3AttributeType		type,
	void					*data);

QD3D_EXPORT TQ3Status Q3AttributeSet_Clear(
	TQ3AttributeSet 		attributeSet,
	TQ3AttributeType		type);

QD3D_EXPORT TQ3Status Q3AttributeSet_Empty(
	TQ3AttributeSet 		target);

/*
 * Q3AttributeSet_GetNextAttributeType
 *
 * Pass in kQ3AttributeTypeNone to get first type
 * kQ3AttributeTypeNone is returned when end of list is reached
 */
QD3D_EXPORT TQ3Status Q3AttributeSet_GetNextAttributeType(
	TQ3AttributeSet 		source,
	TQ3AttributeType		*type);		

QD3D_EXPORT TQ3Status Q3AttributeSet_Submit(
	TQ3AttributeSet			attributeSet, 
	TQ3ViewObject			view);

/*
 * Inherit from parent->child into result
 *	Result attributes are:
 *		all child attributes + all parent attributes NOT in the child
 */
QD3D_EXPORT TQ3Status Q3AttributeSet_Inherit(
	TQ3AttributeSet			parent, 
	TQ3AttributeSet			child, 
	TQ3AttributeSet			result);


/******************************************************************************
 **																			 **
 **							Custom Element Registration						 **
 **																			 **
 *****************************************************************************/

/*
 * Element Methods - 
 *
 * 		When you create a custom element, you control what structures are 
 *		passed around the API. For example, you may allow the Q3Set_Add call 
 *		take one type of argument, store your element internally in some 
 *		abstract data type, and have the Q3Set_Get call take a different 
 *		argument.
 *
 *		For example:
 *			
 *		There are four calls which at some point will copy an element:
 *
 *		Q3Set_Add (copied from Application memory to QuickDraw3D memory)
 *		Q3Set_Get (copied from QuickDraw3D memory to Application memory)
 *		Q3Object_Duplicate (all elements are copied internally)
 *		Q3AttributeSet_Inherit (all elements are copied internally)
 *
 * 		Either CopyAdd or CopyReplace is called during the "_Add" call.
 *			- CopyAdd is destructive and should assume "toElement" is garbage
 *			- CopyReplace is replacing an existing element.
 *
 * 		CopyGet is called during the "_Get" call.
 *
 * 		CopyDuplicate is called to duplicate an element's internal structure.
 *
 * Attributes Methods - 
 *
 *		For copying data while Inheriting. Element methods are used
 *		at all other times.
 *	
 * 		CopyInherit is called to duplicate an element's internal structure 
 *			during inheritance. You should make this as fast as possible.
 *			(for example, if your custom element contains objects, you
 *			 should do a Q3Shared_GetReference instead of a Q3Object_Duplicate)
 *			
 *		The ElementDelete method will be called for all of your elements copied 
 *		around via CopyAdd, CopyReplace, CopyDuplicate, and CopyInherit.
 *		If CopyGet allocates any memory in it's destination, it is up to the app 
 *		to delete it on its side.
 */
 
#define kQ3MethodTypeElementCopyAdd			Q3_METHOD_TYPE('e','c','p','a')
#define kQ3MethodTypeElementCopyReplace		Q3_METHOD_TYPE('e','c','p','r')
#define kQ3MethodTypeElementCopyGet			Q3_METHOD_TYPE('e','c','p','g')
#define kQ3MethodTypeElementCopyDuplicate	Q3_METHOD_TYPE('e','c','p','d')
#define kQ3MethodTypeElementDelete			Q3_METHOD_TYPE('e','d','e','l')

typedef TQ3Status (*TQ3ElementCopyAddMethod)(	
	const void			*fromAPIElement,			/* element from _Add API call */
	void				*toInternalElement);		/* to new QD3D internal element */

typedef TQ3Status (*TQ3ElementCopyReplaceMethod)(
	const void			*fromAPIElement,			/* element from _Add API call */
	void				*ontoInternalElement);		/* replacing QD3D internal element */

typedef TQ3Status (*TQ3ElementCopyGetMethod)(
	const void			*fromInternalElement,		/* from QD3D internal element */
	void				*toAPIElement);				/* to _Get API call */

typedef TQ3Status (*TQ3ElementCopyDuplicateMethod)(
	const void			*fromInternalElement,		/* from QD3D internal element */
	void				*toInternalElement);		/* to new QD3D internal element */

typedef TQ3Status (*TQ3ElementDeleteMethod)(	
	void				*internalElement);

QD3D_EXPORT TQ3ObjectClass Q3ElementClass_Register(
 	TQ3ElementType		elementType,
	const char			*name,
	unsigned long		sizeOfElement,
	TQ3MetaHandler		metaHandler);

QD3D_EXPORT TQ3Status Q3ElementType_GetElementSize(
 	TQ3ElementType		elementType,
	unsigned long		*sizeOfElement);


/******************************************************************************
 **																			 **
 **						Custom Attribute Registration						 **
 **																			 **
 *****************************************************************************/

#define kQ3MethodTypeAttributeInherit		Q3_METHOD_TYPE('i','n','h','t')
#define kQ3MethodTypeAttributeCopyInherit	Q3_METHOD_TYPE('a','c','p','i')

typedef TQ3Boolean TQ3AttributeInheritMethod;	
/* return kQ3True or kQ3False in your metahandler */

typedef TQ3Status (*TQ3AttributeCopyInheritMethod)(
	const void			*fromInternalAttribute,		/* from QD3D internal element */
	void				*toInternalAttribute);		/* to new QD3D internal element */

QD3D_EXPORT TQ3ObjectClass Q3AttributeClass_Register(
	TQ3AttributeType	attributeType,
	const char			*creatorName,
	unsigned long		sizeOfElement,
	TQ3MetaHandler		metaHandler);

#ifdef __cplusplus
}
#endif	/* __cplusplus */

#if defined(__MWERKS__)
#pragma options align=reset
#pragma enumsalwaysint reset
#endif

#endif /*  QD3DSet_h */
