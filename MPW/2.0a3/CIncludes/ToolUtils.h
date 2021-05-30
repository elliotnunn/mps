/*
	Toolutils.h -- Toolbox Utilities

	version	2.0a3
	
	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __TOOLUTILS__
#define __TOOLUTILS__
#ifndef __QUICKDRAW__
#include <QuickDraw.h>
#endif

#define sysPatListID 0
#define iBeamCursor 1
#define crossCursor 2
#define plusCursor 3
#define watchCursor 4
typedef struct Int64Bit {
	long hiLong;
	long loLong;
} Int64Bit;
typedef struct Cursor *CursPtr,**CursHandle;
typedef Pattern *PatPtr,**PatHandle;

pascal Fixed FixRatio(numer,denom)
	short numer,denom;
	extern 0xA869;
pascal Fixed FixMul(a,b)
	Fixed a,b;
	extern 0xA868;
pascal short FixRound(x)
	Fixed x;
	extern 0xA86C;
StringHandle NewString();
pascal StringHandle GetString(stringID)
	short stringID;
	extern 0xA9BA;
pascal long Munger(h,offset,ptr1,len1,ptr2,len2)
	Handle h;
	long offset;
	Ptr ptr1;
	long len1;
	Ptr ptr2;
	long len2;
	extern 0xA9E0;
pascal void PackBits(srcPtr,dstPtr,srcBytes)
	Ptr *srcPtr,*dstPtr;
	short srcBytes;
	extern 0xA8CF;
pascal void UnpackBits(srcPtr,dstPtr,dstBytes)
	Ptr *srcPtr,*dstPtr;
	short dstBytes;
	extern 0xA8D0;
pascal Boolean BitTst(bytePtr,bitNum)
	Ptr bytePtr;
	long bitNum;
	extern 0xA85D;
pascal void BitSet(bytePtr,bitNum)
	Ptr bytePtr;
	long bitNum;
	extern 0xA85E;
pascal void BitClr(bytePtr,bitNum)
	Ptr bytePtr;
	long bitNum;
	extern 0xA85F;
pascal long BitAnd(value1,value2)
	long value1,value2;
	extern 0xA858;
pascal long BitOr(value1,value2)
	long value1,value2;
	extern 0xA85B;
pascal long BitXor(value1,value2)
	long value1,value2;
	extern 0xA859;
pascal long BitNot(value)
	long value;
	extern 0xA85A;
pascal long BitShift(value,count)
	long value;
	short count;
	extern 0xA85C;
pascal short HiWord(x)
	long x;
	extern 0xA86A;
pascal short LoWord(x)
	long x;
	extern 0xA86B;
pascal void LongMul(a,b,dest)
	long a,b;
	Int64Bit *dest;
	extern 0xA867;
pascal Handle GetIcon(iconID)
	short iconID;
	extern 0xA9BB;
pascal void PlotIcon(theRect,theIcon)
	Rect *theRect;
	Handle theIcon;
	extern 0xA94B;
pascal PatHandle GetPattern(patID)
	short patID;
	extern 0xA9B8;
pascal CursHandle GetCursor(cursorID)
	short cursorID;
	extern 0xA9B9;
pascal struct Picture **GetPicture(picID)
	short picID;
	extern 0xA9BC;
pascal Fixed SlopeFromAngle(angle)
	short angle;
	extern 0xA8BC;
pascal short AngleFromSlope(slope)
	Fixed slope;
	extern 0xA8C4;
#endif
