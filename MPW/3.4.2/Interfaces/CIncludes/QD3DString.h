/******************************************************************************
 **																			 **
 ** 	Module:		QD3DString.h 											 **
 ** 																		 **
 ** 																		 **
 ** 	Purpose:														   	 **
 ** 																		 **
 ** 																		 **
 ** 																		 **
 ** 	Copyright (C) 1994-1995 Apple Computer, Inc. All rights reserved.	 **
 ** 																		 **
 ** 																		 **
 *****************************************************************************/
#ifndef QD3DString_h
#define QD3DString_h

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
 **								String Routines								 **
 **																			 **
 *****************************************************************************/
 
TQ3ObjectType Q3String_GetType(
	TQ3StringObject		stringObj);


/******************************************************************************
 **																			 **
 **						C String Routines									 **
 **																			 **
 *****************************************************************************/

TQ3StringObject Q3CString_New(
	const char				*string);

TQ3Status Q3CString_GetLength(
	TQ3StringObject			stringObj,
	unsigned long			*length);

TQ3Status Q3CString_SetString(
	TQ3StringObject			stringObj,
	const char				*string);

TQ3Status Q3CString_GetString(
	TQ3StringObject			stringObj,
	char					**string);

TQ3Status Q3CString_EmptyData(
	char					**string);

#ifdef __cplusplus
}
#endif /*  __cplusplus  */

#if defined(__MWERKS__)
#pragma options align=reset
#pragma enumsalwaysint reset
#endif

#endif  /*  QD3DString_h  */
