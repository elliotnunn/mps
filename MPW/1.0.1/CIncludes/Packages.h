/*
	Packages.h -- Packages

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __PACKAGES__
#define __PACKAGES__
#ifndef __TYPES__
#include <Types.h>
#endif

#define listMgr 0
#define dskInit 2
#define stdFile 3
#define flPoint 4
#define trFunc 5
#define intUtil 6
#define bdConv 7
pascal void InitPack(packID)
	short packID;
	extern 0xA9E5;
pascal void InitAllPacks()
	extern 0xA9E6;
#define putDlgID (-3999)
#define putSave 1
#define putCancel 2
#define putEject 5
#define putDrive 6
#define putName 7
#define getDlgID (-4000)
#define getOpen 1
#define getCancel 3
#define getEject 5
#define getDrive 6
#define getNmList 7
#define getScroll 8
typedef struct SFReply {
	Boolean good;
	Boolean copy;
	OSType fType;
	short vRefNum;
	short version;
	String(63) fName;
} SFReply;
typedef OSType SFTypeList[4];
#define currSymLead 16
#define currNegSym 32
#define currTrailingZ 64
#define currLeadingZ 128
#define mdy 0
#define dmy 1
#define ymd 2
#define dayLdingZ 32
#define mntLdingZ 64
#define century 128
#define secLeadingZ 32
#define minLeadingZ 64
#define hrLeadingZ 128
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
#define verTurkey 24
#define verYugoslavia 25
typedef struct Intl0Rec {
	char decimalPt;
	char thousSep;
	char listSep;
	char currSym1;
	char currSym2;
	char currSym3;
	unsigned char currFmt;
	unsigned char dateOrder;
	unsigned char shrtDateFmt;
	char dateSep;
	unsigned char timeCycle;
	unsigned char timeFmt;
	char mornStr[4];
	char eveStr[4];
	char timeSep;
	char time1Suff;
	char time2Suff;
	char time3Suff;
	char time4Suff;
	char time5Suff;
	char time6Suff;
	char time7Suff;
	char time8Suff;
	unsigned char metricSys;
	short intl0Vers;
} Intl0Rec,*Intl0Ptr,**Intl0Hndl;
typedef struct Intl1Rec {
	String(15) days[7];
	String(15) months[12];
	unsigned char suppressDay;
	unsigned char lngDateFmt;
	unsigned char dayLeading0;
	unsigned char abbrLen;
	char st0[4];
	char st1[4];
	char st2[4];
	char st3[4];
	char st4[4];
	short intl1Vers;
	short localRtn[1];
} Intl1Rec,*Intl1Ptr,**Intl1Hndl;
typedef enum {
	shortDate,
	longDate,
	abbrevDate
} DateForm;
Handle IUGetIntl();
#endif
