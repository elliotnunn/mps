{
FILE
  Perf.p -- Pascal UNIT interface to Macintosh Performance Analysis Tools.

DESCRIPTION
  Provides for PC-sampling of User code resources, ROM code, and RAM (misses).
  Produces output text file suitable for input to PerformReport.

  Design objectives:
	Language independent, i.e. works with Pascal, C, and Assembly.
	Covers user resources as well as ROM code.
	Memory model independent, i.e. works for Desk Accessories and drivers.
	Uses TimeManager on new ROMs, Vertical Blanking interrupt on 64 K ROMs.

  Copyright Apple Computer, Inc. 1986, 1987
  All rights reserved.
}

{$I Flags.text}

UNIT Perf;

INTERFACE

  USES
	MemTypes, { used in INTERFACE of Perf, required to use Perf.p }
	QuickDraw, OSIntf, ToolIntf, PackIntf; { used only in IMPLEMENTATION }
	
  TYPE
	PLongs = ^ALongs;
	ALongs = ARRAY [1..8000] OF LONGINT;
	
	HInts = ^PInts;
	PInts = ^AInts;
	AInts = ARRAY [1..8000] OF INTEGER;
	
	{ PerfGlobals are declared as a record, so main program can allocate }
	{ as globals, desk accessory can add to globals allocated via pointer, }
	{ print driver can allocate via low memory, etc. }
	TP2PerfGlobals = ^TPerfGlobals;
	TPerfGlobals =
	record
		startROM: LONGINT;	{ ROM Base }
		romHits: LONGINT;	{ used if MeasureROM is false }
		misses: LONGINT;	{ count of PC values outside measured memory }
		segArray: PLongs;	{ array of segment handles }
		sizeArray: PLongs;	{ array of segment sizes }
		idArray: HInts; 	{ array of segment rsrc IDs }
		baseArray: PLongs;	{ array of offsets to counters for each segment }
		samples: PLongs;	{ samples buffer }
		buffSize: LONGINT;	{ size of samples buffer, in bytes }
		timeInterval: INTEGER; { number of clock intervals between interrupts }
		bucketSize: INTEGER;  { size of buckets, power of 2 }
		log2buckSize: INTEGER; { used in CvtPC }
		pcOffset: INTEGER;	{ offset to the user PC at interrupt time. }
		numMeasure: INTEGER;  {# Code segments (w/o jump table), ROM, etc.}
		firstCode: INTEGER;   { index of first Code segment }
		takingSamples: BOOLEAN; { true if sampling is enabled. }
		measureROM: BOOLEAN;  { true if ROM is to be measured }
		measureCode: BOOLEAN; { true if Code segments are to be measured. }
		ramSeg: INTEGER;	{ index of "segment" record to cover RAM }
							{ > 0 if RAM (misses) are to be bucketed. }
		ramBase: LONGINT;	{ beginning of RAM being measured. }
		measureRAMbucketSize: INTEGER;
		measureRAMlog2buckSize: INTEGER;

		romVersion: INTEGER;
		{ variables from dialog: }
		vRefNum: INTEGER;		{Volume where the report file is to be created}
		volumeSelected: BOOLEAN;  {True if user selects the report file name }
		rptFileName: Str255;	{Report file name}
		rptFileCreator: Str255;   {Report File Creator}
		rptFileType: Str255;	{Report File type}
	end;

  FUNCTION InitPerf (VAR thePerfGlobals: TP2PerfGlobals;
					timerCount, codeAndROMBucketSize: INTEGER;
					doROM, doAppCode: BOOLEAN;
					appCodeType: Str255;
					romID: INTEGER;
					romName: Str255;
					doRAM: BOOLEAN;
					ramLow, RAMHigh: LONGINT;
					ramBucketSize: INTEGER
					): BOOLEAN;
	{ called once to setup Performance monitoring }

  PROCEDURE TermPerf (thePerfGlobals: TP2PerfGlobals);
	{ if InitPerf succeeds then }
	{ must be called before terminating program. }
	
  FUNCTION PerfControl (thePerfGlobals: TP2PerfGlobals; 
		turnOn: BOOLEAN): BOOLEAN;
	{ Call this to turn off/on measuring. }
	{ Returns previous state. }

  FUNCTION	PerfDump (thePerfGlobals: TP2PerfGlobals;
		reportFile: Str255; doHistogram:BOOLEAN;
		rptFileColumns: INTEGER {Number of columns in the report file}
	): INTEGER{OSErr};
	{Call this to dump the statistics into a file}

  { for Internal use only: }
  FUNCTION	CvtPC (thePerfGlobals: TP2PerfGlobals; pc: LONGINT): LONGINT;

IMPLEMENTATION
{$I Perf2.p}
END.
