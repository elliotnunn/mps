/*
	Perf.h - Macintosh Performance Analysis Tools

	version	2.0a3

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1986-1987
	All rights reserved.
*/

/*
DESCRIPTION
		Provides for PC-sampling of User code resources, ROM code, and RAM (misses).
		Produces output text file suitable for input to PerformReport.
		
		Design objectives:
			Language independent, i.e. works with Pascal, C, and Assembly.
			Covers user resources as well as ROM code.
			Memory model independent, i.e. works for Desk Accessories and drivers.
			Uses TimeManager on new ROMs, Vertical Blanking interrupt on 64 K ROMs.

BUGS

{ Change History: }
{ 30-Jan-87 Changes for A2: }
{			Parameter for InitPerf to choose resource type: CODE, PDEF, etc. }
{ 12-Jan-86 Option to control number of '*'s }
{						Process Code resources in opposite order. }
{						Add Segment names to output }
{ 10-Jan-86 Improve independence from PInterfaces, segmentation }
{ 31-Dec-86 Added MeasureRAM funtion. }
*/


#ifndef __Perf__
#define __Perf__
#ifndef __TYPES__
#include <Types.h>
#endif


/*	PerfGlobals are declared as a record, so main program can allocate
		as globals, desk accessory can add to globals allocated via pointer,
		print driver can allocate via low memory, etc.
*/

typedef struct TPerfGlobals { 
	long startROM;				/* ROM Base */
	long romHits;					/* used if MeasureROM is false */
	long misses;					/* count of PC values outside measured memory */
	long (*segArray)[];		/* array of segment handles */
	long (*sizeArray)[];	/* array of segment sizes */
	short (**idArray)[];	/* array of segment rsrc IDs */
	long (*baseArray)[];	/* array of offsets to counters for each segment */
	long (*samples)[];		/* samples buffer */
	long buffSize; 				/* size of samples buffer, in bytes */
	short timeInterval; 	/* number of clock intervals between interrupts */
	short bucketSize; 		/* size of buckets, power of 2 */
	short log2buckSize; 	/* used in CvtPC */
	short PCOffset;				/* offset to the user PC at interrupt time. */
	short numMeasure;			/* # Code segments (w/o jump table), ROM, etc.*/
	short firstCode; 			/* index of first Code segment */
	Boolean takingSamples;/* true if sampling is enabled. */
	Boolean measureROM;
	Boolean measureCode;
	short RAMSeg;					/* index of "segment" record to cover RAM */
												/* > 0 if RAM (misses) are to be bucketed. */
	long RAMBase;					/* beginning of RAM being measured. */
	short measureRAMbucketSize;
	short measureRAMlog2buckSize;
	Boolean rom128K;
	 	/* variables from dialog: */
	short vRefNum;					/* Volume where the report file is to be created */
	Boolean volumeSelected;	/* True if user selects the report file name */
	Str255 rptFileName;			/* Report file name */
	Str255 rptFileCreator;	/* Report File Creator */
	Str255 rptFileType;			/* Report File type */
} TPerfGlobals, *TP2PerfGlobals;

pascal Boolean InitPerf (thePerfGlobals, timerCount, codeAndROMBucketSize,
				doROM, doAppCode, 
				appCodeType,
				romID, romName, 
				doRAM, ramLow, ramHigh, ramBucketSize)
	TP2PerfGlobals *thePerfGlobals;
	short timerCount, codeAndROMBucketSize;
	Boolean doROM, doAppCode;
	Str255 *appCodeType; /* resource type: CODE, PDEF, ect. */
	short romID;
	Str255 *romName;
	Boolean doRAM;
	long ramLow, ramHigh;
	short ramBucketSize;
	extern;
/* called once to setup Performance monitoring */

pascal void TermPerf (thePerfGlobals)
	TP2PerfGlobals thePerfGlobals;
	extern;
/* if InitPerf succeeds then TermPerf */
/* must be called before terminating program. */
		
pascal Boolean PerfControl (thePerfGlobals, turnOn)
	TP2PerfGlobals thePerfGlobals;
	Boolean	turnOn;
	extern;
/* Call this to turn off/on measuring. */
/* Returns previous state. */
	
pascal short /* OSErr */
		PerfDump (thePerfGlobals, reportFile, doHistogram, rptFileColumns)
			TP2PerfGlobals thePerfGlobals;
			Str255	*reportFile;
			Boolean doHistogram;
			short rptFileColumns;
	extern;
/* Call this to dump the statistics into a file */
	
#endif
