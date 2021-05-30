/*
     File:       CommResources.h
 
     Contains:   Communications Toolbox Resource Manager Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1988-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __COMMRESOURCES__
#define __COMMRESOURCES__

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif

#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif




#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
    #pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
    #pragma pack(2)
#endif

#if CALL_NOT_IN_CARBON
enum {
                                        /*    tool classes (also the tool file types)    */
  classCM                       = FOUR_CHAR_CODE('cbnd'),
  classFT                       = FOUR_CHAR_CODE('fbnd'),
  classTM                       = FOUR_CHAR_CODE('tbnd')
};

enum {
                                        /*    version of the Comm Resource Manager   */
  curCRMVersion                 = 2,    /* constants general to the use of the Communications Resource Manager */
  crmType                       = 9,    /* queue type */
  crmRecVersion                 = 1,    /* version of queue structure */
                                        /*    error codes */
  crmGenericError               = -1,
  crmNoErr                      = 0
};

/* data structures general to the use of the Communications Resource Manager */
typedef OSErr                           CRMErr;
struct CRMRec {
  QElemPtr            qLink;                  /*reserved*/
  short               qType;                  /*queue type -- ORD(crmType) = 9*/
  short               crmVersion;             /*version of queue element data structure*/
  long                crmPrivate;             /*reserved*/
  short               crmReserved;            /*reserved*/
  long                crmDeviceType;          /*type of device, assigned by DTS*/
  long                crmDeviceID;            /*device ID; assigned when CRMInstall is called*/
  long                crmAttributes;          /*pointer to attribute block*/
  long                crmStatus;              /*status variable - device specific*/
  long                crmRefCon;              /*for device private use*/
};
typedef struct CRMRec                   CRMRec;
typedef CRMRec *                        CRMRecPtr;
#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON
/*
 *  InitCRM()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( CRMErr )
InitCRM(void);


/*
 *  CRMGetHeader()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( QHdrPtr )
CRMGetHeader(void);


/*
 *  CRMInstall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
CRMInstall(CRMRecPtr crmReqPtr);


/*
 *  CRMRemove()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
CRMRemove(CRMRecPtr crmReqPtr);


/*
 *  CRMSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( CRMRecPtr )
CRMSearch(CRMRecPtr crmReqPtr);


/*
 *  CRMGetCRMVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( short )
CRMGetCRMVersion(void);


/*
 *  CRMGetResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Handle )
CRMGetResource(
  ResType   theType,
  short     theID);


/*
 *  CRMGet1Resource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Handle )
CRMGet1Resource(
  ResType   theType,
  short     theID);


/*
 *  CRMGetIndResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Handle )
CRMGetIndResource(
  ResType   theType,
  short     index);


/*
 *  CRMGet1IndResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Handle )
CRMGet1IndResource(
  ResType   theType,
  short     index);


/*
 *  CRMGetNamedResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Handle )
CRMGetNamedResource(
  ResType            theType,
  ConstStr255Param   name);


/*
 *  CRMGet1NamedResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Handle )
CRMGet1NamedResource(
  ResType            theType,
  ConstStr255Param   name);


/*
 *  CRMReleaseResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
CRMReleaseResource(Handle theHandle);


/*
 *  CRMGetToolResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Handle )
CRMGetToolResource(
  short     procID,
  ResType   theType,
  short     theID);


/*
 *  CRMGetToolNamedResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Handle )
CRMGetToolNamedResource(
  short              procID,
  ResType            theType,
  ConstStr255Param   name);


/*
 *  CRMReleaseToolResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
CRMReleaseToolResource(
  short    procID,
  Handle   theHandle);


/*
 *  CRMGetIndex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( long )
CRMGetIndex(Handle theHandle);


/*
 *  CRMLocalToRealID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( short )
CRMLocalToRealID(
  ResType   bundleType,
  short     toolID,
  ResType   theType,
  short     localID);


/*
 *  CRMRealToLocalID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( short )
CRMRealToLocalID(
  ResType   bundleType,
  short     toolID,
  ResType   theType,
  short     realID);


/*
 *  CRMGetIndToolName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
CRMGetIndToolName(
  OSType   bundleType,
  short    index,
  Str255   toolName);


/*
 *  CRMFindCommunications()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
CRMFindCommunications(
  short *  vRefNum,
  long *   dirID);


/*
 *  CRMIsDriverOpen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Boolean )
CRMIsDriverOpen(ConstStr255Param driverName);


/*
 *  CRMParseCAPSResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( CRMErr )
CRMParseCAPSResource(
  Handle           theHandle,
  ResType          selector,
  unsigned long *  value);


/*
 *  CRMReserveRF()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
CRMReserveRF(short refNum);


/*
 *  CRMReleaseRF()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
CRMReleaseRF(short refNum);


#endif  /* CALL_NOT_IN_CARBON */




#if PRAGMA_STRUCT_ALIGN
    #pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
    #pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __COMMRESOURCES__ */

