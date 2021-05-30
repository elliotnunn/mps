
/************************************************************

Created: Friday, September 13, 1991 at 1:06 PM
 Packages.h
 C Interface to the Macintosh Libraries


  Copyright Apple Computer, Inc. 1985-1991
  All rights reserved

************************************************************/


#ifndef __PACKAGES__
#define __PACKAGES__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __STANDARDFILE__
#include <StandardFile.h>
#endif

#ifndef __SCRIPT__
#include <Script.h>
#endif


enum {

 listMgr = 0,					/*list manager*/
 dskInit = 2,					/*Disk Initializaton*/
 stdFile = 3,					/*Standard File*/
 flPoint = 4,					/*Floating-Point Arithmetic*/
 trFunc = 5,					/*Transcendental Functions*/
 intUtil = 6,					/*International Utilities*/
 bdConv = 7,					/*Binary/Decimal Conversion*/
 editionMgr = 11,				/*Edition Manager*/
 currSymLead = 16,
 currNegSym = 32,
 currTrailingZ = 64,
 currLeadingZ = 128,
 zeroCycle = 1,					/*0:00 AM/PM format*/
 longDay = 0,					/*day of the month*/
 longWeek = 1,					/*day of the week*/
 longMonth = 2,					/*month of the year*/
 longYear = 3,					/*year*/
 supDay = 1,					/*suppress day of month*/
 supWeek = 2,					/*suppress day of week*/
 supMonth = 4					/*suppress month*/
};
enum {
 supYear = 8,					/*suppress year*/
 dayLdingZ = 32,
 mntLdingZ = 64,
 century = 128,
 secLeadingZ = 32,
 minLeadingZ = 64,
 hrLeadingZ = 128,


/* Regional version codes */
 verUS = 0,
 verFrance = 1,
 verBritain = 2,
 verGermany = 3,
 verItaly = 4,
 verNetherlands = 5,
 verFrBelgiumLux = 6,			/* French for Belgium & Luxembourg */
 verSweden = 7,
 verSpain = 8,
 verDenmark = 9,
 verPortugal = 10,
 verFrCanada = 11,
 verNorway = 12
};
enum {
 verIsrael = 13,
 verJapan = 14,
 verAustralia = 15,
 verArabic = 16,				/* synonym for verArabia */
 verFinland = 17,
 verFrSwiss = 18,				/* French Swiss */
 verGrSwiss = 19,				/* German Swiss */
 verGreece = 20,
 verIceland = 21,
 verMalta = 22,
 verCyprus = 23,
 verTurkey = 24,
 verYugoCroatian = 25,			/* Croatian system for Yugoslavia */
 verIndiaHindi = 33,			/* Hindi system for India */
 verPakistan = 34,
 verLithuania = 41,
 verPoland = 42,
 verHungary = 43,
 verEstonia = 44,
 verLatvia = 45
};
enum {
 verLapland = 46,
 verFaeroeIsl = 47,
 verIran = 48,
 verRussia = 49,
 verIreland = 50,				/* English-language version for Ireland */
 verKorea = 51,
 verChina = 52,
 verTaiwan = 53,
 verThailand = 54,

#define minCountry verUS
#define maxCountry verThailand

/*Obsolete region code names, kept for backward compatibility*/

 verBelgiumLux = 6,				/* (use verFrBelgiumLux instead, less ambiguous) */
 verArabia = 16,
 verYugoslavia = 25,			/* (use verYugoCroatian instead, less ambiguous) */
 verIndia = 33,					/* (use verIndiaHindi instead, less ambiguous) */

/* Special script code values for International Utilities */
 iuSystemScript = -1,			/* system script */
 iuCurrentScript = -2,			/* current script (for font of grafPort) */

/* Special language code values for International Utilities */
 iuSystemCurLang = -2,			/* current (itlbLang) lang for system script */
 iuSystemDefLang = -3,			/* default (table) lang for system script */
 iuCurrentCurLang = -4,			/* current (itlbLang) lang for current script */
 iuCurrentDefLang = -5,			/* default lang for current script */
 iuScriptCurLang = -6			/* current (itlbLang) lang for specified script */
};
enum {
 iuScriptDefLang = -7,			/* default language for a specified script */

/* Table selectors for GetItlTable */
 iuWordSelectTable = 0,			/* get word select break table from 'itl2' */
 iuWordWrapTable = 1,			/* get word wrap break table from 'itl2' */
 iuNumberPartsTable = 2,		/* get default number parts table from 'itl4' */
 iuUnTokenTable = 3,			/* get unToken table from 'itl4' */
 iuWhiteSpaceList = 4			/* get white space list from 'itl4' */
};

enum {shortDate,longDate,abbrevDate};
typedef unsigned char DateForm;

enum {mdy,dmy,ymd,myd,dym,ydm};
typedef unsigned char DateOrders;


struct Intl0Rec {
 char decimalPt;				/*decimal point character*/
 char thousSep;					/*thousands separator character*/
 char listSep;					/*list separator character*/
 char currSym1;					/*currency symbol*/
 char currSym2;
 char currSym3;
 unsigned char currFmt;			/*currency format flags*/
 unsigned char dateOrder;		/*order of short date elements: mdy, dmy, etc.*/
 unsigned char shrtDateFmt;		/*format flags for each short date element*/
 char dateSep;					/*date separator character*/
 unsigned char timeCycle;		/*specifies time cycle: 0..23, 1..12, or 0..11*/
 unsigned char timeFmt;			/*format flags for each time element*/
 char mornStr[4];				/*trailing string for AM if 12-hour cycle*/
 char eveStr[4];				/*trailing string for PM if 12-hour cycle*/
 char timeSep;					/*time separator character*/
 char time1Suff;				/*trailing string for AM if 24-hour cycle*/
 char time2Suff;
 char time3Suff;
 char time4Suff;
 char time5Suff;				/*trailing string for PM if 24-hour cycle*/
 char time6Suff;
 char time7Suff;
 char time8Suff;
 unsigned char metricSys;		/*255 if metric, 0 if inches etc.*/
 short intl0Vers;				/*region code (hi byte) and version (lo byte)*/
};

typedef struct Intl0Rec Intl0Rec;
typedef Intl0Rec *Intl0Ptr, **Intl0Hndl;

struct Intl1Rec {
 Str15 days[7];					/*day names*/
 Str15 months[12];				/*month names*/
 unsigned char suppressDay;		/*255 for no day, or flags to suppress any element*/
 unsigned char lngDateFmt;		/*order of long date elements*/
 unsigned char dayLeading0;		/*255 for leading 0 in day number*/
 unsigned char abbrLen;			/*length for abbreviating names*/
 char st0[4];					/*separator strings for long date format*/
 char st1[4];
 char st2[4];
 char st3[4];
 char st4[4];
 short intl1Vers;				/*region code (hi byte) and version (lo byte)*/
 short localRtn[1];				/*now a flag for opt extension*/
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

pascal Handle IUGetIntl(short theID)
 = {0x3F3C,0x0006,0xA9ED}; 
pascal void IUSetIntl(short refNum,short theID,Handle intlHandle)
 = {0x3F3C,0x0008,0xA9ED}; 
pascal void IUDateString(long dateTime,DateForm longFlag,Str255 result)
 = {0x4267,0xA9ED}; 
pascal void IUDatePString(long dateTime,DateForm longFlag,Str255 result,
 Handle intlHandle)
 = {0x3F3C,0x000E,0xA9ED}; 
pascal void IUTimeString(long dateTime,Boolean wantSeconds,Str255 result)
 = {0x3F3C,0x0002,0xA9ED}; 
pascal void IUTimePString(long dateTime,Boolean wantSeconds,Str255 result,
 Handle intlHandle)
 = {0x3F3C,0x0010,0xA9ED}; 
pascal Boolean IUMetric(void)
 = {0x3F3C,0x0004,0xA9ED}; 
void iudatestring(long dateTime,DateForm longFlag,char *result); 
void iudatepstring(long dateTime,DateForm longFlag,char *result,Handle intlHandle); 
void iutimestring(long dateTime,Boolean wantSeconds,char *result); 
void iutimepstring(long dateTime,Boolean wantSeconds,char *result,Handle intlHandle); 

pascal short IUMagString(const void *aPtr,const void *bPtr,short aLen,short bLen)
 = {0x3F3C,0x000A,0xA9ED}; 
pascal short IUMagIDString(const void *aPtr,const void *bPtr,short aLen,
 short bLen)
 = {0x3F3C,0x000C,0xA9ED}; 
pascal short IUCompString(ConstStr255Param aStr,ConstStr255Param bStr); 
pascal short IUEqualString(ConstStr255Param aStr,ConstStr255Param bStr); 
short iucompstring(char *aStr,char *bStr); 
short iuequalstring(char *aStr,char *bStr); 

pascal void StringToNum(ConstStr255Param theString,long *theNum); 
void stringtonum(char *theString,long *theNum); 
pascal void NumToString(long theNum,Str255 theString); 
void numtostring(long theNum,char *theString); 

pascal void IULDateString(LongDateTime *dateTime,DateForm longFlag,Str255 result,
 Handle intlHandle)
 = {0x3F3C,0x0014,0xA9ED}; 
pascal void IULTimeString(LongDateTime *dateTime,Boolean wantSeconds,Str255 result,
 Handle intlHandle)
 = {0x3F3C,0x0016,0xA9ED}; 
void iuldatestring(LongDateTime *dateTime,DateForm longFlag,char *result,
 Handle intlHandle); 
void iultimestring(LongDateTime *dateTime,Boolean wantSeconds,char *result,
 Handle intlHandle); 
pascal void IUClearCache(void)
 = {0x3F3C,0x0018,0xA9ED}; 
pascal short IUMagPString(const void *aPtr,const void *bPtr,short aLen,
 short bLen,Handle itl2Handle)
 = {0x3F3C,0x001A,0xA9ED}; 
pascal short IUMagIDPString(const void *aPtr,const void *bPtr,short aLen,
 short bLen,Handle itl2Handle)
 = {0x3F3C,0x001C,0xA9ED}; 
pascal short IUCompPString(ConstStr255Param aStr,ConstStr255Param bStr,
 Handle itl2Handle); 
pascal short IUEqualPString(ConstStr255Param aStr,ConstStr255Param bStr,
 Handle itl2Handle); 
pascal short IUScriptOrder(ScriptCode script1,ScriptCode script2)
 = {0x3F3C,0x001E,0xA9ED}; 
pascal short IULangOrder(LangCode language1,LangCode language2)
 = {0x3F3C,0x0020,0xA9ED}; 
pascal short IUTextOrder(const void *aPtr,const void *bPtr,short aLen,short bLen,
 ScriptCode aScript,ScriptCode bScript,LangCode aLang,LangCode bLang)
 = {0x3F3C,0x0022,0xA9ED}; 
pascal short IUStringOrder(ConstStr255Param aStr,ConstStr255Param bStr,
 ScriptCode aScript,ScriptCode bScript,LangCode aLang,LangCode bLang); 
pascal void IUGetItlTable(ScriptCode script,short tableCode,Handle *itlHandle,
 long *offset,long *length)
 = {0x3F3C,0x0024,0xA9ED}; 
short iucomppstring(char *aStr,char *bStr,Handle intlHandle); 
short iuequalpstring(char *aStr,char *bStr,Handle intlHandle); 
short iustringorder(char *aStr,char *bStr,ScriptCode aScript,ScriptCode bScript,
 LangCode aLang,LangCode bLang); 
#ifdef __cplusplus
}
#endif

#endif
