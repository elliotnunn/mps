/*
	TelOther601.h
	
	Header file for the TelOtherFunction call that can be used to identify the
	hardware being used by the GeoPort Telephone Tool.
	
	If you call  TelOtherFunction on the GeoPort Telephone Tool
	with the first short of the parameter blaock set to 0x601, the 
	tool will fill your parameter block with information on the
	harware device that is currently being used by the tool.
	
	The use that is envisioned for this call, is to provide more
	information for tech support in the future when more variants
	of the GeoPort Telecom Adapter exist.
	
	Other Telephone Tool vendors may also implement this TelOtherFunction
	call for the same purpose.  The next time we revise the Telephone Manager
	interface we will add this functionality as a standard API and data
	structure.
	
	Copyright © Apple Computer, Inc.  1995. All rights reserved.
*/

#define kTELOtherToolDeviceInfo 601

const unsigned char *kAppleToolManufacturerName= "\pApple Computer, Inc.";
const unsigned char *kGTAK01DeviceName= "\pGeoPort Telecom Adapter";

/****************************************************************/
/*			Country codes.										*/
/****************************************************************/

#define	CCInternational 	0
#define	CCSweden			1
#define	CCSwitzerland		2
#define	CCUnitedKingdom		3
#define	CCUnitedStates		4
#define	CCFinland			5
#define	CCAustralia			6
#define	CCAustria			7
#define	CCBelgium			8
#define	CCCanada			9
#define	CCDenmark			10
#define	CCFrance			11
#define	CCGermany			12
#define	CCHolland			13
#define	CCIreland			14
#define	CCItaly				15
#define	CCJapan				16
#define	CCLuxembourg		17
#define	CCNorway			18
#define	CCSpain				19
#define	CCNewZealand		20
#define	CCHongKong			21
#define	CCSingapore			22
#define	CCTaiwan			23
#define	CCKorea				24
#define	CCMalaysia			25
#define	CCBulgaria			26
#define	CCCzechRepublic		27
#define	CCSlovakia			28

#if defined(powerc) || defined(__powerc)
#pragma options align=mac68k
#endif
struct TELToolDeviceInfoRecord {
  short csCode; 	// Code 601 for hardware device identification
  short 		structVersion;       // "$0001" for this version of the data structure.
  OSType       toolManufacturer;     // "Appl" for Apple, "Cypr" for Cypress
  OSType       toolDeviceType;
  short		   deviceVersionNumber;  // "$0001"
  short		   CountryCode;		     // We always return zero now.
  Str31        toolManufacturerName; // "Apple Computer, Inc."
  Str31        toolDeviceName;       // "GeoPort Telephone Adapter" 
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif


typedef struct TELToolDeviceInfoRecord TELToolDeviceInfoRecord;
typedef TELToolDeviceInfoRecord *TELToolDeviceInfoPtr, **TELToolDeviceInfoHandle;


