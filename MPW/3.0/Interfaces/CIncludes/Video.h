/************************************************************

Created: Tuesday, October 4, 1988 at 10:09 PM
    Video.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1986-1988
    All rights reserved

************************************************************/


#ifndef __VIDEO__
#define __VIDEO__

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#define mBaseOffset 1       /*Id of mBaseOffset.*/
#define mRowBytes 2         /*Video sResource parameter Id's */
#define mBounds 3           /*Video sResource parameter Id's */
#define mVersion 4          /*Video sResource parameter Id's */
#define mHRes 5             /*Video sResource parameter Id's */
#define mVRes 6             /*Video sResource parameter Id's */
#define mPixelType 7        /*Video sResource parameter Id's */
#define mPixelSize 8        /*Video sResource parameter Id's */
#define mCmpCount 9         /*Video sResource parameter Id's */
#define mCmpSize 10         /*Video sResource parameter Id's */
#define mPlaneBytes 11      /*Video sResource parameter Id's */
#define mVertRefRate 14     /*Video sResource parameter Id's */
#define mVidParams 1        /*Video parameter block id.*/
#define mTable 2            /*Offset to the table.*/
#define mPageCnt 3          /*Number of pages*/
#define mDevType 4          /*Device Type*/
#define oneBitMode 128      /*Id of OneBitMode Parameter list.*/
#define twoBitMode 129      /*Id of TwoBitMode Parameter list.*/
#define fourBitMode 130     /*Id of FourBitMode Parameter list.*/
#define eightBitMode 131    /*Id of EightBitMode Parameter list.*/
#define cscReset 0          /*Control Codes*/
#define cscSetMode 2        /*Control Codes*/
#define cscSetEntries 3     /*Control Codes*/
#define cscGrayPage 5
#define cscSetGray 6
#define cscGetMode 2        /*Status Codes*/
#define cscGetEntries 3     /*Status Codes*/
#define cscGetPageCnt 4     /*Status Codes*/
#define cscGetPageBase 5    /*Status Codes*/

struct VPBlock {
    long vpBaseOffset;      /*Offset to page zero of video RAM (From minorBaseOS).*/
    short vpRowBytes;       /*Width of each row of video memory.*/
    Rect vpBounds;          /*BoundsRect for the video display (gives dimensions).*/
    short vpVersion;        /*PixelMap version number.*/
    short vpPackType;
    long vpPackSize;
    long vpHRes;            /*Horizontal resolution of the device (pixels per inch).*/
    long vpVRes;            /*Vertical resolution of the device (pixels per inch).*/
    short vpPixelType;      /*Defines the pixel type.*/
    short vpPixelSize;      /*Number of bits in pixel.*/
    short vpCmpCount;       /*Number of components in pixel.*/
    short vpCmpSize;        /*Number of bits per component*/
    long vpPlaneBytes;      /*Offset from one plane to the next.*/
};

#ifndef __cplusplus
typedef struct VPBlock VPBlock;
#endif

typedef VPBlock *VPBlockPtr;

struct VDEntryRecord {
    Ptr csTable;            /*(long) pointer to color table entry=value, r,g,b:INTEGER*/
};

#ifndef __cplusplus
typedef struct VDEntryRecord VDEntryRecord;
#endif

typedef VDEntryRecord *VDEntRecPtr;

struct VDGrayRecord {
    Boolean csMode;         /*Same as GDDevType value (0=mono, 1=color)*/
};

#ifndef __cplusplus
typedef struct VDGrayRecord VDGrayRecord;
#endif

typedef VDGrayRecord *VDGrayPtr;

/* Parm block for SetGray control call */
struct VDSetEntryRecord {
    ColorSpec *csTable;     /*Pointer to an array of color specs*/
    short csStart;          /*Which spec in array to start with, or -1*/
    short csCount;          /*Number of color spec entries to set*/
};

#ifndef __cplusplus
typedef struct VDSetEntryRecord VDSetEntryRecord;
#endif

typedef VDSetEntryRecord *VDSetEntryPtr;

/* Parm block for SetEntries control call */

struct VDPageInfo {
    short csMode;           /*(word) mode within device*/
    long csData;            /*(long) data supplied by driver*/
    short csPage;           /*(word) page to switch in*/
    Ptr csBaseAddr;         /*(long) base address of page*/
};

#ifndef __cplusplus
typedef struct VDPageInfo VDPageInfo;
#endif

typedef VDPageInfo *VDPgInfoPtr;

struct VDSizeInfo {
    short csHSize;          /*(word) desired/returned h size*/
    short csHPos;           /*(word) desired/returned h position*/
    short csVSize;          /*(word) desired/returned v size*/
    short csVPos;           /*(word) desired/returned v position*/
};

#ifndef __cplusplus
typedef struct VDSizeInfo VDSizeInfo;
#endif

typedef VDSizeInfo *VDSzInfoPtr;

struct VDSettings {
    short csParamCnt;       /*(word) number of params*/
    short csBrightMax;      /*(word) max brightness*/
    short csBrightDef;      /*(word) default brightness*/
    short csBrightVal;      /*(word) current brightness*/
    short csCntrstMax;      /*(word) max contrast*/
    short csCntrstDef;      /*(word) default contrast*/
    short csCntrstVal;      /*(word) current contrast*/
    short csTintMax;        /*(word) max tint*/
    short csTintDef;        /*(word) default tint*/
    short csTintVal;        /*(word) current tint*/
    short csHueMax;         /*(word) max hue*/
    short csHueDef;         /*(word) default hue*/
    short csHueVal;         /*(word) current hue*/
    short csHorizDef;       /*(word) default horizontal*/
    short csHorizVal;       /*(word) current horizontal*/
    short csHorizMax;       /*(word) max horizontal*/
    short csVertDef;        /*(word) default vertical*/
    short csVertVal;        /*(word) current vertical*/
    short csVertMax;        /*(word) max vertical*/
};

#ifndef __cplusplus
typedef struct VDSettings VDSettings;
#endif

typedef VDSettings *VDSettingsPtr;


#endif
