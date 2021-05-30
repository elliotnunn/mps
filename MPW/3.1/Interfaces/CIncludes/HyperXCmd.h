/************************************************************

Created: Thursday, September 7, 1989 at 4:42 PM
	HyperXCmd.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1987-1989
	All rights reserved

************************************************************/


#ifndef __HYPERXCMD__
#define __HYPERXCMD__

#ifndef __TYPES__
#include <Types.h>
#endif


/* result codes */

#define xresSucc 0
#define xresFail 1
#define xresNotImp 2

struct XCmdBlock {
	short paramCount;
	Handle params[16];
	Handle returnValue;
	Boolean passFlag;
	void (*entryPoint)();	/*to call back to HyperCard*/
	short request;
	short result;
	long inArgs[8];
	long outArgs[4];
};

typedef struct XCmdBlock XCmdBlock;
typedef XCmdBlock *XCmdPtr;

#ifdef __cplusplus
extern "C" {
#endif
pascal void SendCardMessage(XCmdPtr paramPtr,const Str255 msg); 
pascal void SendHCMessage(XCmdPtr paramPtr,const Str255 msg);
pascal Handle GetGlobal(XCmdPtr paramPtr,const Str255 globName);
pascal void SetGlobal(XCmdPtr paramPtr,const Str255 globName,Handle globValue); 
pascal Handle GetFieldByID(XCmdPtr paramPtr,Boolean cardFieldFlag,short fieldID);
pascal Handle GetFieldByName(XCmdPtr paramPtr,Boolean cardFieldFlag,const Str255 fieldName);
pascal Handle GetFieldByNum(XCmdPtr paramPtr,Boolean cardFieldFlag,short fieldNum); 
pascal void SetFieldByID(XCmdPtr paramPtr,Boolean cardFieldFlag,short fieldID,
	Handle fieldVal);
pascal void SetFieldByName(XCmdPtr paramPtr,Boolean cardFieldFlag,const Str255 fieldName,
	Handle fieldVal);
pascal void SetFieldByNum(XCmdPtr paramPtr,Boolean cardFieldFlag,short fieldNum,
	Handle fieldVal);
pascal void BoolToStr(XCmdPtr paramPtr,Boolean bool,Str255 str);
pascal void ExtToStr(XCmdPtr paramPtr,extended *num,Str255 str);
pascal void LongToStr(XCmdPtr paramPtr,long posNum,Str255 str); 
pascal void NumToStr(XCmdPtr paramPtr,long num,Str255 str); 
pascal void NumToHex(XCmdPtr paramPtr,long num,short nDigits,Str255 str);
pascal Boolean StrToBool(XCmdPtr paramPtr,const Str255 str);
pascal extended StrToExt(XCmdPtr paramPtr,const Str255 str);
pascal long StrToLong(XCmdPtr paramPtr,const Str255 str);
pascal long StrToNum(XCmdPtr paramPtr,const Str255 str);
pascal Handle PasToZero(XCmdPtr paramPtr,const Str255 str); 
pascal void ZeroToPas(XCmdPtr paramPtr,char *zeroStr,Str255 pasStr);
pascal Handle EvalExpr(XCmdPtr paramPtr,const Str255 expr); 
pascal void ReturnToPas(XCmdPtr paramPtr,Ptr zeroStr,Str255 pasStr);
pascal void ScanToReturn(XCmdPtr paramPtr,Ptr *scanPtr);
pascal void ScanToZero(XCmdPtr paramPtr,Ptr *scanPtr);
pascal Boolean StringEqual(XCmdPtr paramPtr,const Str255 str1,const Str255 str2);
pascal Ptr StringMatch(XCmdPtr paramPtr,const Str255 pattern,Ptr target);
pascal long StringLength(XCmdPtr paramPtr,char *strPtr);
pascal void ZeroBytes(XCmdPtr paramPtr,Ptr dstPtr,long longCount);
#ifdef __cplusplus
}
#endif

#endif
