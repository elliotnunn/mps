/************************************************************

Created: Monday, October 31, 1988 at 3:32 PM
    Memory.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1985-1988
    All rights reserved

************************************************************/


#ifndef __MEMORY__
#define __MEMORY__

#ifndef __TYPES__
#include <Types.h>
#endif

#define maxSize 0x800000    /*Max data block size is 8 megabytes*/

typedef long Size;
typedef pascal long (*GrowZoneProcPtr)(Size cbNeeded);

struct Zone {
    Ptr bkLim;
    Ptr purgePtr;
    Ptr hFstFree;
    long zcbFree;
    GrowZoneProcPtr gzProc;
    short moreMast;
    short flags;
    short cntRel;
    short maxRel;
    short cntNRel;
    short maxNRel;
    short cntEmpty;
    short cntHandles;
    long minCBFree;
    ProcPtr purgeProc;
    Ptr sparePtr;
    Ptr allocPtr;
    short heapData;
};

#ifndef __cplusplus
typedef struct Zone Zone;
#endif

typedef Zone *THz;

#ifdef __safe_link
extern "C" {
#endif
pascal Ptr GetApplLimit(void)
    = {0x2EB8,0x0130}; 
pascal THz GetZone(void); 
pascal THz SystemZone(void)
    = {0x2EB8,0x02A6}; 
pascal THz ApplicZone(void)
    = {0x2EB8,0x02AA}; 
pascal Handle NewHandle(Size byteCount); 
pascal Handle NewHandleSys(Size byteCount); 
pascal Handle NewHandleClear(Size byteCount); 
pascal Handle NewHandleSysClear(Size byteCount); 
pascal THz HandleZone(Handle h); 
pascal Handle RecoverHandle(Ptr p); 
pascal Ptr NewPtr(Size byteCount); 
pascal Ptr NewPtrSys(Size byteCount); 
pascal Ptr NewPtrClear(Size byteCount); 
pascal Ptr NewPtrSysClear(Size byteCount); 
pascal THz PtrZone(Ptr p); 
pascal Handle GZSaveHnd(void)
    = {0x2EB8,0x0328}; 
pascal Ptr TopMem(void)
    = {0x2EB8,0x0108}; 
pascal long MaxBlock(void); 
pascal long StackSpace(void); 
pascal Handle NewEmptyHandle(void); 
pascal void HLock(Handle h); 
pascal void HUnlock(Handle h); 
pascal void HPurge(Handle h); 
pascal void HNoPurge(Handle h); 
pascal Ptr StripAddress(Ptr theAddress); 
pascal Size MFMaxMem(Size *grow)
    = {0x3F3C,0x0015,0xA88F}; 
pascal long MFFreeMem(void)
    = {0x3F3C,0x0018,0xA88F}; 
pascal Handle MFTempNewHandle(Size logicalSize,OSErr *resultCode)
    = {0x3F3C,0x001D,0xA88F}; 
pascal void MFTempHLock(Handle h,OSErr *resultCode)
    = {0x3F3C,0x001E,0xA88F}; 
pascal void MFTempHUnlock(Handle h,OSErr *resultCode)
    = {0x3F3C,0x001F,0xA88F}; 
pascal void MFTempDisposHandle(Handle h,OSErr *resultCode)
    = {0x3F3C,0x0020,0xA88F}; 
pascal Ptr MFTopMem(void)
    = {0x3F3C,0x0016,0xA88F}; 
pascal void InitApplZone(void); 
pascal void InitZone(GrowZoneProcPtr pgrowZone,short cmoreMasters,Ptr limitPtr,
    Ptr startPtr); 
pascal void SetZone(THz hz); 
pascal Size CompactMem(Size cbNeeded); 
pascal void PurgeMem(Size cbNeeded); 
pascal long FreeMem(void); 
pascal void ResrvMem(Size cbNeeded); 
pascal Size MaxMem(Size *grow); 
pascal void SetGrowZone(GrowZoneProcPtr growZone); 
pascal void SetApplLimit(Ptr zoneLimit); 
pascal void MoveHHi(Handle h); 
pascal void DisposPtr(Ptr p); 
pascal Size GetPtrSize(Ptr p); 
pascal void SetPtrSize(Ptr p,Size newSize); 
pascal void DisposHandle(Handle h); 
pascal Size GetHandleSize(Handle h); 
pascal void SetHandleSize(Handle h,Size newSize); 
pascal void EmptyHandle(Handle h); 
pascal void ReallocHandle(Handle h,Size byteCount); 
pascal void HSetRBit(Handle h); 
pascal void HClrRBit(Handle h); 
pascal void MoreMasters(void); 
pascal void BlockMove(Ptr srcPtr,Ptr destPtr,Size byteCount); 
pascal OSErr MemError(void)
    = {0x3EB8,0x0220}; 
pascal void PurgeSpace(long *total,long *contig); 
pascal char HGetState(Handle h); 
pascal void HSetState(Handle h,char flags); 
pascal void SetApplBase(Ptr startPtr); 
pascal void MaxApplZone(void); 
#ifdef __safe_link
}
#endif

#endif
