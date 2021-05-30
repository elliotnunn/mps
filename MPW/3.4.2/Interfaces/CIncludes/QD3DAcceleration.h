/******************************************************************************
 **																			 **
 ** 	Module:		QD3DAcceleration.h										 **
 ** 																		 **
 ** 																		 **
 ** 	Purpose: 	Header file for low-level 3D driver API					 **
 ** 				Vendor IDs, and Apple's engine IDs						 **
 ** 																		 **
 ** 																		 **
 ** 	Copyright (C) 1994-95 Apple Computer, Inc.  All rights reserved.	 **
 ** 																		 **
 ** 																		 **
 *****************************************************************************/
#ifndef QD3DAcceleration_h
#define QD3DAcceleration_h

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
#endif

/******************************************************************************
 **																			 **
 ** 						Vendor ID definitions							 **
 **																			 **
 *****************************************************************************/

/*
 * If kQAVendor_BestChoice is used, the system chooses the "best" drawing engine
 * available for the target device. This should be used for the default.
 */
 
#define kQAVendor_BestChoice		(-1)

/*
 * The other definitions (kQAVendor_Apple, etc.) identify specific vendors
 * of drawing engines. When a vendor ID is used in conjunction with a
 * vendor-defined engine ID, a specific drawing engine can be selected.
 */

#define kQAVendor_Apple			0
#define kQAVendor_ATI			1
#define kQAVendor_Radius		2
#define kQAVendor_Mentor		3		/* Mentor Software, Inc. */
#define kQAVendor_Matrox		4
#define kQAVendor_Yarc			5

/******************************************************************************
 **																			 **
 **						 Apple's engine ID definitions						 **
 **																			 **
 *****************************************************************************/

#define kQAEngine_AppleSW		0		/* Default software rasterizer */
#define kQAEngine_AppleHW		(-1)	/* Apple accelerator */
#define kQAEngine_AppleHW2		1		/* Another Apple accelerator */

#ifdef __cplusplus
}
#endif

#if defined(__MWERKS__)
	#pragma options align=reset
	#pragma enumsalwaysint reset
#endif

#endif /* QD3DAcceleration_h */
