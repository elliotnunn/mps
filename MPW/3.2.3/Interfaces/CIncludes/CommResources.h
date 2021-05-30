
/************************************************************

Created: Thursday, September 12, 1991 at 11:53 AM
 CommResources.h
 C Interface to the Macintosh Libraries


  Copyright Apple Computer, Inc. 1988-1991
  All rights reserved

************************************************************/


#ifndef __COMMRESOURCES__
#define __COMMRESOURCES__

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif


enum {


/*    version of the Comm Resource Manager    */
 curCRMVersion = 2,

/*    tool classes (also the tool file types)    */

#define classCM 'cbnd'
#define classFT 'fbnd'
#define classTM 'tbnd'

/* constants general to the use of the Communications Resource Manager */

 crmType = 9,			/* queue type    */
 crmRecVersion = 1,		/* version of queue structure */

/*    error codes */
 crmGenericError = -1,
 crmNoErr = 0
};

/* data structures general to the use of the Communications Resource Manager */
typedef OSErr CRMErr;

struct CRMRec {
 QElemPtr qLink;		/*reserved*/
 short qType;			/*queue type -- ORD(crmType) = 9*/
 short crmVersion;		/*version of queue element data structure*/
 long crmPrivate;		/*reserved*/
 short crmReserved;		/*reserved*/
 long crmDeviceType;	/*type of device, assigned by DTS*/
 long crmDeviceID;		/*device ID; assigned when CRMInstall is called*/
 long crmAttributes;	/*pointer to attribute block*/
 long crmStatus;		/*status variable - device specific*/
 long crmRefCon;		/*for device private use*/
};

typedef struct CRMRec CRMRec;
typedef CRMRec *CRMRecPtr;


#ifdef __cplusplus
extern "C" {
#endif
pascal CRMErr InitCRM(void); 
pascal QHdrPtr CRMGetHeader(void); 
pascal void CRMInstall(QElemPtr crmReqPtr); 
pascal OSErr CRMRemove(QElemPtr crmReqPtr); 
pascal QElemPtr CRMSearch(QElemPtr crmReqPtr); 
pascal short CRMGetCRMVersion(void); 

pascal Handle CRMGetResource(ResType theType,short theID); 
pascal Handle CRMGet1Resource(ResType theType,short theID); 
pascal Handle CRMGetIndResource(ResType theType,short index); 
pascal Handle CRMGet1IndResource(ResType theType,short index); 
pascal Handle CRMGetNamedResource(ResType theType,ConstStr255Param name); 
pascal Handle CRMGet1NamedResource(ResType theType,ConstStr255Param name); 
pascal void CRMReleaseResource(Handle theHandle); 
pascal Handle CRMGetToolResource(short procID,ResType theType,short theID); 
pascal Handle CRMGetToolNamedResource(short procID,ResType theType,ConstStr255Param name); 
pascal void CRMReleaseToolResource(short procID,Handle theHandle); 
pascal long CRMGetIndex(Handle theHandle); 

pascal short CRMLocalToRealID(ResType bundleType,short toolID,ResType theType,
 short localID); 
pascal short CRMRealToLocalID(ResType bundleType,short toolID,ResType theType,
 short realID); 

pascal OSErr CRMGetIndToolName(OSType bundleType,short index,Str255 toolName); 

pascal OSErr CRMFindCommunications(short *vRefNum,long *dirID); 

pascal Boolean CRMIsDriverOpen(ConstStr255Param driverName); 

pascal CRMErr CRMParseCAPSResource(Handle theHandle,ResType selector,unsigned long *value); 

pascal OSErr CRMReserveRF(short refNum); 
/*  decrements useCount by one  */
pascal OSErr CRMReleaseRF(short refNum); 

#ifdef __cplusplus
}
#endif

#endif
