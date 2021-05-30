/************************************************************

Created: Thursday, September 7, 1989 at 8:11 PM
	ToolUtils.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1985-1989
	All rights reserved

************************************************************/


#ifndef __TOOLUTILS__
#define __TOOLUTILS__

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#define sysPatListID 0
#define iBeamCursor 1
#define crossCursor 2
#define plusCursor 3
#define watchCursor 4

struct Int64Bit {
	long hiLong;
	long loLong;
};

typedef struct Int64Bit Int64Bit;
#ifdef __cplusplus
extern "C" {
#endif
pascal Fixed FixRatio(short numer,short denom)
	= 0xA869;
pascal Fixed FixMul(Fixed a,Fixed b)
	= 0xA868;
pascal short FixRound(Fixed x)
	= 0xA86C;
pascal StringHandle GetString(short stringID)
	= 0xA9BA;
pascal long Munger(Handle h,long offset,Ptr ptr1,long len1,Ptr ptr2,long len2)
	= 0xA9E0;
pascal void PackBits(Ptr *srcPtr,Ptr *dstPtr,short srcBytes)
	= 0xA8CF;
pascal void UnpackBits(Ptr *srcPtr,Ptr *dstPtr,short dstBytes)
	= 0xA8D0;
pascal Boolean BitTst(Ptr bytePtr,long bitNum)
	= 0xA85D;
pascal void BitSet(Ptr bytePtr,long bitNum)
	= 0xA85E;
pascal void BitClr(Ptr bytePtr,long bitNum)
	= 0xA85F;
pascal long BitAnd(long value1,long value2)
	= 0xA858;
pascal long BitOr(long value1,long value2)
	= 0xA85B;
pascal long BitXor(long value1,long value2)
	= 0xA859;
pascal long BitNot(long value)
	= 0xA85A;
pascal long BitShift(long value,short count)
	= 0xA85C;
pascal short HiWord(long x)
	= 0xA86A;
pascal short LoWord(long x)
	= 0xA86B;
pascal void LongMul(long a,long b,Int64Bit *dest)
	= 0xA867;
pascal Handle GetIcon(short iconID)
	= 0xA9BB;
pascal void PlotIcon(const Rect *theRect,Handle theIcon)
	= 0xA94B;
pascal PatHandle GetPattern(short patID)
	= 0xA9B8;
pascal CursHandle GetCursor(short cursorID)
	= 0xA9B9;
pascal PicHandle GetPicture(short picID)
	= 0xA9BC;
pascal Fixed SlopeFromAngle(short angle)
	= 0xA8BC;
pascal short AngleFromSlope(Fixed slope)
	= 0xA8C4;
StringHandle newstring(char *theString);
pascal void SetString(StringHandle theString,const Str255 strNew)
	= 0xA907;
pascal long DeltaPoint(Point ptA,Point ptB)
	= 0xA94F;
pascal StringHandle NewString(const Str255 theString)
	= 0xA906;
pascal void ShieldCursor(const Rect *shieldRect,Point offsetPt)
	= 0xA855;
pascal void GetIndString(Str255 theString,short strListID,short index); 
void getindstring(char *theString,short strListID,short index); 
pascal void ScreenRes(short *scrnHRes,short *scrnVRes); 
pascal void GetIndPattern(Pattern thePat,short patListID,short index);
void setstring(StringHandle theString,char *strNew);
void shieldcursor(const Rect *shieldRect,Point *offsetPt);
long deltapoint(Point *ptA,Point *ptB); 
#ifdef __cplusplus
}
#endif

#endif
