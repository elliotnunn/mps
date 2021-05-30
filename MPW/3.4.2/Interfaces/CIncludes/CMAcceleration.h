/*
 	File:		CMAcceleration.h
 
 	Contains:	ColorSync 2.0 Acceleration Component Interfaces
 
 	Version:	Technology:	ColorSync 2.0
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __CMACCELERATION__
#define __CMACCELERATION__


#ifndef __MEMORY__
#include <Memory.h>
#endif
/*	#include <Types.h>											*/
/*		#include <ConditionalMacros.h>							*/
/*	#include <MixedMode.h>										*/

#ifndef __COMPONENTS__
#include <Components.h>
#endif

#ifndef __CMAPPLICATION__
#include <CMApplication.h>
#endif
/*	#include <Quickdraw.h>										*/
/*		#include <QuickdrawText.h>								*/
/*	#include <Files.h>											*/
/*		#include <OSUtils.h>									*/
/*		#include <Finder.h>										*/
/*	#include <Printing.h>										*/
/*		#include <Errors.h>										*/
/*		#include <Dialogs.h>									*/
/*			#include <Menus.h>									*/
/*			#include <Controls.h>								*/
/*			#include <Windows.h>								*/
/*				#include <Events.h>								*/
/*			#include <TextEdit.h>								*/
/*	#include <CMICCProfile.h>									*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif


enum {
	cmAccelerationInterfaceVersion = 1
};

/*–––––––––––––––––––––––––––––––––––––– Component Type*/
enum {
	cmAccelerationComponentType	= 'csac'
};

/*–––––––––––––––––––––––––––––––––––––– Required Component function selectors*/
enum {
	cmLoadTables				= 0,
	cmCalculateData				= 1
};

/*–––––––––––––––––––––––––––––––––––––– table data for acceleration component*/
struct CMAccelerationTableData {
	long							inputLutEntryCount;			/* count of entries for input lut for one dimension*/
	long							inputLutWordSize;			/* count of bits of each entry ( e.g. 16 for WORD )*/
	Handle							inputLut;					/* handle to input lut*/
	long							outputLutEntryCount;		/* count of entries for output lut for one dimension	*/
	long							outputLutWordSize;			/* count of bits of each entry ( e.g. 8 for BYTE )*/
	Handle							outputLut;					/* handle to output lut*/
	long							colorLutInDim;				/* input dimension  ( e.g. 3 for LAB ; 4 for CMYK )*/
	long							colorLutOutDim;				/* output dimension ( e.g. 3 for LAB ; 4 for CMYK )*/
	long							colorLutGridPoints;			/* count of gridpoints for color lut ( for one Dimension )	*/
	long							colorLutWordSize;			/* count of bits of each entry ( e.g. 8 for BYTE )*/
	Handle							colorLut;					/* handle to color lut*/
	CMBitmapColorSpace				inputColorSpace;			/* packing info for input*/
	CMBitmapColorSpace				outputColorSpace;			/* packing info for output*/
	void							*userData;
	unsigned long					reserved1;
	unsigned long					reserved2;
	unsigned long					reserved3;
	unsigned long					reserved4;
	unsigned long					reserved5;
};
typedef struct CMAccelerationTableData CMAccelerationTableData, *CMAccelerationTableDataPtr, **CMAccelerationTableDataHdl;

/*–––––––––––––––––––––––––––––––––––––– calc data for acceleration component*/
struct CMAccelerationCalcData {
	long							pixelCount;					/* count of input pixels*/
	Ptr								inputData;					/* input array*/
	Ptr								outputData;					/* output array*/
	unsigned long					reserved1;
	unsigned long					reserved2;
};
typedef struct CMAccelerationCalcData CMAccelerationCalcData, *CMAccelerationCalcDataPtr, **CMAccelerationCalcDataHdl;

/*————————————————————————————————————————————————————————————————————————————————————————————————*/
/*				A c c e l e r a t i o n   C o m p o n e n t   I n t e r f a c e s*/
/*————————————————————————————————————————————————————————————————————————————————————————————————*/
extern pascal CMError CMAccelerationLoadTables(ComponentInstance CMSession, CMAccelerationTableDataPtr tableData)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0000, 0x7000, 0xA82A);
extern pascal CMError CMAccelerationCalculateData(ComponentInstance CMSession, CMAccelerationCalcDataPtr calcData)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0001, 0x7000, 0xA82A);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __CMACCELERATION__ */
