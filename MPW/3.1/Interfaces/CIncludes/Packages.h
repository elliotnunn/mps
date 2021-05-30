/************************************************************

Created: Tuesday, September 12, 1989 at 7:10 PM
	Packages.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1985-1989
	All rights reserved

************************************************************/


#ifndef __PACKAGES__
#define __PACKAGES__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __DIALOGS__
#include <Dialogs.h>
#endif

#ifndef __FILES__
#include <Files.h>
#endif

#define listMgr 0				/*list manager*/
#define dskInit 2				/*Disk Initializaton*/
#define stdFile 3				/*Standard File*/
#define flPoint 4				/*Floating-Point Arithmetic*/
#define trFunc 5				/*Transcendental Functions*/
#define intUtil 6				/*International Utilities*/
#define bdConv 7				/*Binary/Decimal Conversion*/
#define putDlgID -3999
#define putSave 1
#define putCancel 2
#define putEject 5
#define putDrive 6
#define putName 7
#define getDlgID -4000
#define getOpen 1
#define getCancel 3
#define getEject 5
#define getDrive 6
#define getNmList 7
#define getScroll 8
#define currSymLead 16
#define currNegSym 32
#define currTrailingZ 64
#define currLeadingZ 128
#define zeroCycle 1 			/*0:00 AM/PM format*/
#define longDay 0				/*day of the month*/
#define longWeek 1				/*day of the week*/
#define longMonth 2 			/*month of the year*/
#define longYear 3				/*year*/
#define supDay 1				/*suppress day of month*/
#define supWeek 2				/*suppress day of week*/
#define supMonth 4				/*suppress month*/
#define supYear 8				/*suppress year*/
#define dayLdingZ 32
#define mntLdingZ 64
#define century 128
#define secLeadingZ 32
#define minLeadingZ 64
#define hrLeadingZ 128

/* Date Orders */

#define mdy 0
#define dmy 1
#define ymd 2
#define myd 3
#define dym 4
#define ydm 5

/* Country Version */

#define verUS 0
#define verFrance 1
#define verBritain 2
#define verGermany 3
#define verItaly 4
#define verNetherlands 5
#define verBelgiumLux 6
#define verSweden 7
#define verSpain 8
#define verDenmark 9
#define verPortugal 10
#define verFrCanada 11
#define verNorway 12
#define verIsrael 13
#define verJapan 14
#define verAustralia 15
#define verArabia 16
#define verFinland 17
#define verFrSwiss 18
#define verGrSwiss 19
#define verGreece 20
#define verIceland 21
#define verMalta 22
#define verCyprus 23
#define verFarsi 48
#define verCyrillic 49
#define verFaroese 47
#define verTurkey 24
#define verYugoslavia 25
#define verIreland 50
#define verKorea 51
#define verChina 52
#define verTaiwan 53
#define verThailand 54
#define minCountry verUS
#define maxCountry verThailand

enum {shortDate,longDate,abbrevDate};
typedef unsigned char DateForm;

typedef OSType SFTypeList[4];
typedef pascal short (*DlgHookProcPtr)(short item, DialogPtr theDialog);
typedef pascal Boolean (*FileFilterProcPtr)(ParmBlkPtr paramBlock);

struct SFReply {
	Boolean good;
	Boolean copy;
	OSType fType;
	short vRefNum;
	short version;
	Str63 fName;
};

typedef struct SFReply SFReply;
struct Intl0Rec {
	char decimalPt; 			/*decimal point character*/
	char thousSep;				/*thousands separator*/
	char listSep;				/*list separator*/
	char currSym1;				/*currency symbol*/
	char currSym2;
	char currSym3;
	unsigned char currFmt;		/*currency format*/
	unsigned char dateOrder;	/*order of short date elements*/
	unsigned char shrtDateFmt;	/*short date format*/
	char dateSep;				/*date separator*/
	unsigned char timeCycle;	/*0 if 24-hour cycle, 255 if 12-hour*/
	unsigned char timeFmt;		/*time format*/
	char mornStr[4];			/*trailing string for first 12-hour cycle*/
	char eveStr[4]; 			/*trailing string for last 12-hour cycle*/
	char timeSep;				/*time separator*/
	char time1Suff; 			/*trailing string for 24-hour cycle*/
	char time2Suff;
	char time3Suff;
	char time4Suff;
	char time5Suff;
	char time6Suff;
	char time7Suff;
	char time8Suff;
	unsigned char metricSys;	/*255 if metric, 0 if not*/
	short intl0Vers;			/*version information*/
};

typedef struct Intl0Rec Intl0Rec;
typedef Intl0Rec *Intl0Ptr, **Intl0Hndl;

struct Intl1Rec {
	Str15 days[7];				/*day names*/
	Str15 months[12];			/*month names*/
	unsigned char suppressDay;	/*0 for day name, 255 for none*/
	unsigned char lngDateFmt;	/*order of long date elements*/
	unsigned char dayLeading0;	/*255 for leading 0 in day number*/
	unsigned char abbrLen;		/*length for abbreviating names*/
	char st0[4];				/*strings for long date format*/
	char st1[4];
	char st2[4];
	char st3[4];
	char st4[4];
	short intl1Vers;			/*version information*/
	short localRtn[1];			/*routine for localizing string comparison*/
};

typedef struct Intl1Rec Intl1Rec;
typedef Intl1Rec *Intl1Ptr, **Intl1Hndl;

#ifdef __cplusplus
extern "C" {
#endif
pascal void InitPack(short packID)
	= 0xA9E5;
pascal void InitAllPacks(void)
	= 0xA9E6;
pascal Handle IUGetIntl(short theID);
void sfpputfile(Point *where,char *prompt,char *origName,DlgHookProcPtr dlgHook,
	SFReply *reply,short dlgID,ModalFilterProcPtr filterProc);
void sfgetfile(Point *where,char *prompt,FileFilterProcPtr fileFilter,short numTypes,
	SFTypeList typeList,DlgHookProcPtr dlgHook,SFReply *reply); 
void sfpgetfile(Point *where,char *prompt,FileFilterProcPtr fileFilter,
	short numTypes,SFTypeList typeList,DlgHookProcPtr dlgHook,SFReply *reply,
	short dlgID,ModalFilterProcPtr filterProc); 
pascal void IUSetIntl(short refNum,short theID,Handle intlParam);
pascal void IUDateString(long dateTime,DateForm longFlag,Str255 result);
void iudatestring(long dateTime,DateForm longFlag,char *result);
void iudatepstring(long dateTime,DateForm longFlag,char *result,Handle intlParam);
void iutimestring(long dateTime,Boolean wantSeconds,char *result);
pascal void IUDatePString(long dateTime,DateForm longFlag,Str255 result,
	Handle intlParam);
void iutimepstring(long dateTime,Boolean wantSeconds,char *result,Handle intlParam);
pascal Boolean IUMetric(void);
pascal void IUTimePString(long dateTime,Boolean wantSeconds,Str255 result,
	Handle intlParam);
pascal short IUMagString(Ptr aPtr,Ptr bPtr,short aLen,short bLen);
pascal void IUTimeString(long dateTime,Boolean wantSeconds,Str255 result);
pascal short IUMagIDString(Ptr aPtr,Ptr bPtr,short aLen,short bLen);
pascal short IUCompString(const Str255 aStr,const Str255 bStr); 
short iucompstring(char *aStr,char *bStr);
pascal short IUEqualString(const Str255 aStr,const Str255 bStr);
short iuequalstring(char *aStr,char *bStr); 
pascal void SFGetFile(Point where,const Str255 prompt,FileFilterProcPtr fileFilter,
	short numTypes,SFTypeList typeList,DlgHookProcPtr dlgHook,SFReply *reply);
pascal void StringToNum(const Str255 theString,long *theNum);
void stringtonum(char *theString,long *theNum); 
pascal void SFPGetFile(Point where,const Str255 prompt,FileFilterProcPtr fileFilter,
	short numTypes,SFTypeList typeList,DlgHookProcPtr dlgHook,SFReply *reply,
	short dlgID,ModalFilterProcPtr filterProc); 
pascal void NumToString(long theNum,Str255 theString);
void numtostring(long theNum,char *theString);
pascal void SFPPutFile(Point where,const Str255 prompt,const Str255 origName,
	DlgHookProcPtr dlgHook,SFReply *reply,short dlgID,ModalFilterProcPtr filterProc);
pascal void SFPutFile(Point where,const Str255 prompt,const Str255 origName,
	DlgHookProcPtr dlgHook,SFReply *reply); 
void sfputfile(Point *where,char *prompt,char *origName,DlgHookProcPtr dlgHook,
	SFReply *reply);
#ifdef __cplusplus
}
#endif

#endif
