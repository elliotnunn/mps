/*
	File:		Perf.h

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

*/

#ifndef __PERF__
#define __PERF__

#ifndef __TYPES__
#include <Types.h>
#endif

struct TPerfGlobals {
	long startROM;				/*ROM Base*/
	long romHits;				/*used if MeasureROM is false*/
	long misses;				/*count of PC values outside measured memory*/
	long (*segArray)[1];		/*array of segment handles*/
	long (*sizeArray)[1];		/*array of segment sizes*/
	short (**idArray)[1];		/*array of segment rsrc IDs*/
	long (*baseArray)[1];		/*array of offsets to counters for each segment*/
	long (*samples)[1]; 		/*samples buffer*/
	long buffSize;				/*size of samples buffer in bytes*/
	short timeInterval; 		/*number of clock intervals between interrupts*/
	short bucketSize;			/*size of buckets power of 2*/
	short log2buckSize; 		/*used in CvtPC*/
	short pcOffset; 			/*offset to the user PC at interrupt time.*/
	short numMeasure;			/*# Code segments (w/o jump table)- ROM etc.*/
	short firstCode;			/*index of first Code segment*/
	Boolean takingSamples;		/*true if sampling is enabled.*/
	Boolean measureROM;
	Boolean measureCode;
	short ramSeg;				/*index of "segment" record to cover RAM > 0 if RAM (misses) are to be bucketed.*/
	long ramBase;				/*beginning of RAM being measured.*/
	short measureRAMbucketSize;
	short measureRAMlog2buckSize;
	short romVersion;
	short vRefNum;				/*Volume where the report file is to be created*/
	Boolean volumeSelected; 	/*True if user selects the report file name*/
	Str255 rptFileName; 		/*Report file name*/
	Str255 rptFileCreator;		/*Report File Creator*/
	Str255 rptFileType; 		/*Report File type*/
	ResType getResType; 		/*Resource type*/
};

typedef struct TPerfGlobals TPerfGlobals;
typedef TPerfGlobals *TP2PerfGlobals;

/* PerfGlobals are declared as a record, so main program can allocate
as globals, desk accessory can add to globals allocated via pointer,
print driver can allocate via low memory, etc. */



#ifdef __cplusplus
extern "C" {
#endif
pascal Boolean InitPerf(TP2PerfGlobals *thePerfGlobals,short timerCount,
	short codeAndROMBucketSize,Boolean doROM,Boolean doAppCode,const Str255 appCodeType,
	short romID,const Str255 romName,Boolean doRAM,long ramLow,long ramHigh,
	short ramBucketSize);								/* called once to setup Performance monitoring
 */
pascal void TermPerf(TP2PerfGlobals thePerfGlobals);	/* if InitPerf succeeds then TermPerf must be called before terminating program.
 */
pascal Boolean PerfControl(TP2PerfGlobals thePerfGlobals,Boolean turnOn);
/*
	Call this to turn off/on measuring.
	 Returns previous state.
*/

pascal short PerfDump(TP2PerfGlobals thePerfGlobals,const Str255 reportFile,
	Boolean doHistogram,short rptFileColumns);			/* Call this to dump the statistics into a file. */
#ifdef __cplusplus
}
#endif

#endif
