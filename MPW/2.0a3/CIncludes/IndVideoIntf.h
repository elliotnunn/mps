/*
	IndVideoIntf.h -- Video Interface 

 	Version: 2.0a3

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1986-1987
	All rights reserved.
*/
/**********************************************************************************************
  Modification History:
 
 <C742/02Feb87 GWN>  Changed video parameters to an sBlock.
**********************************************************************************************/

#ifndef __VIDEOINT__
#define __VIDEOINT__
#ifndef __TYPESS__
#include <Types.h>
#endif


				/* Video sResource parameter Id's */
#define mBaseOffset		1		/* Id of mBaseOffset. */
#define mRowBytes		2
#define mBounds			3
#define mVersion		4
#define mHRes			5
#define mVRes			6
#define mPixelType		7
#define mPixelSize		8
#define mCmpCount		9
#define mCmpSize		10
#define mPlaneBytes		11
/* #define mTable		12 */
/* #define mPageCnt		13 */
#define mVertRefRate	14

#define mVidParams		1          /* Video parameter block id.  <C742> */
#define mTable			2          /* Offset to the table.       <C742> */
#define mPageCnt		3          /* Number of pages            <C742> */
#define mDevType		4          /* Device Type                <C742> */

				/* Video sResource List Id's */
#define oneBitMode		128		/* Id of OneBitMode Parameter list. */
#define twoBitMode		129		/* Id of TwoBitMode Parameter list. */
#define fourBitMode		130		/* Id of FourBitMode Parameter list. */	
#define eightBitMode	131		/* Id of EightBitMode Parameter list. */

				/* Control Codes */
#define cscReset		0
#define cscSetMode		2
#define cscSetEntries	3

				/* Status Codes */
#define cscGetMode		2
#define cscGetEntries	3
#define cscGetPageCnt	4
#define cscGetPageBase	5



/* mVidParams block */



typedef struct VPBlock  {  	/* Video Parameters block. */
	long	vpBaseOffset;	/* Offset to page zero of video RAM (From minorBaseOS). */
	short	vpRowBytes ;	/* Width of each row of video memory. */
	short	vpBounds[4] ;	/* BoundsRect for the video display (gives dimensions). */
	short	vpVersion ; 	/* PixelMap version number. */
	short	vpPackType ;                   
	long	vpPackSize ;                   
	long	vpHRes  ;   	/* Horizontal resolution of the device (pixels per inch). */
	long	vpVRes  ;   	/* Vertical resolution of the device (pixels per inch). */
	short	vpPixelType;	/* Defines the pixel type. */
	short	vpPixelSize; 	/* Number of bits in pixel. */
	short	vpCmpCount ; 	/* Number of components in pixel. */
	short	vpCmpSize  ;	/* Number of bits per component */
	long	vpPlaneBytes;	/* Offset from one plane to the next. */
} VPBlock, *VPBlockPtr;

typedef struct VDEntryRecord{
	Ptr				csTable;		/* (long) pointer to color table */
									/* entry = value, r, g, b : INTEGER */
} VDEntryRecord, *VDEntRecPtr;
		
typedef struct VDPageInfo{
	short			csMode;			/* (word) mode within device */
	long			csData;			/* (long) data supplied by driver */
	short			csPage;			/* (word) page to switch in */
	Ptr				csBaseAddr;		/* (long) base address of page */
} VDPageInfo, *VDPgInfoPtr;
		
typedef struct VDSizeInfo{
	short			csHSize;		/* (word) desired/returned h size */
	short			csHPos;			/* (word) desired/returned h position */
	short			csVSize;		/* (word) desired/returned v size */
	short			csVPos;			/* (word) desired/returned v position */
} VDSizeInfo, *VDSzInfoPtr;

typedef struct VDSettings{
	short			csParamCnt;		/* (word) number of params */
	short			csBrightMax;	/* (word) max brightness */
	short			csBrightDef;	/* (word) default brightness */
	short			csBrightVal;	/* (word) current brightness */
	short			csCntrstMax;	/* (word) max contrast */
	short			csCntrstDef;	/* (word) default contrast */
	short			csCntrstVal;	/* (word) current contrast */
	short			csTintMax;		/* (word) max tint */
	short			csTintDef;		/* (word) default tint */
	short			csTintVal;		/* (word) current tint */
	short			csHueMax;		/* (word) max hue */
	short			csHueDef;		/* (word) default hue */
	short			csHueVal;		/* (word) current hue */
	short			csHorizDef;		/* (word) default horizontal */
	short			csHorizVal;		/* (word) current horizontal */
	short			csHorizMax;		/* (word) max horizontal */
	short			csVertDef;		/* (word) default vertical */
	short			csVertVal;		/* (word) current vertical */
	short			csVertMax;		/* (word) max vertical */
} VDSettings, *VDSettingsPtr;


#endif

