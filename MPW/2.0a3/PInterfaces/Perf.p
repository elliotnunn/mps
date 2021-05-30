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

	Copyright Apple Computer, Inc. 1987, 1986
	All rights reserved.

BUGS
}

{ Interface Change History: }
{ 30-Jan-87 Changes for A2: }
{			Parameter for InitPerf to choose resource type: CODE, PDEF, etc. }
{ 12-Jan-86 Option to control number of '*'s }
{			Process Code segments in opposite order. }
{			Add Segment names to output }
{ 10-Jan-86 Improve independence from PInterfaces, segmentation }
{ 31-Dec-86 Added MeasureRAM funtion. }

{$I Flags.text}

unit Perf;

interface

	uses
		MemTypes, { used in INTERFACE of Perf, required to use Perf.p }
		QuickDraw, OSIntf, ToolIntf, PackIntf; { used only in IMPLEMENTATION }

	type
		PLongs = ^ALongs;
		ALongs = ARRAY [1..8000] OF longint;
		
		HInts = ^PInts;
		PInts = ^AInts;
		AInts = ARRAY [1..8000] OF integer;
		
		{ PerfGlobals are declared as a record, so main program can allocate }
		{ as globals, desk accessory can add to globals allocated via pointer, }
		{ print driver can allocate via low memory, etc. }
		TP2PerfGlobals = ^TPerfGlobals;
		TPerfGlobals = 
			record
				startROM: longint;		{ ROM Base }
				romHits: longint;			{ used if MeasureROM is false }
				misses: longint;			{ count of PC values outside measured memory }
				segArray: PLongs;			{ array of segment handles }
				sizeArray: PLongs;		{ array of segment sizes }
				idArray: HInts;				{ array of segment rsrc IDs }
				baseArray: PLongs;		{ array of offsets to counters for each segment }
				samples: PLongs;			{ samples buffer }
				buffSize: longint; 		{ size of samples buffer, in bytes }
				timeInterval: integer; { number of clock intervals between interrupts }
				bucketSize: integer; 	{ size of buckets, power of 2 }
				log2buckSize: integer; { used in CvtPC }
				PCOffset: integer;		{ offset to the user PC at interrupt time. }
				numMeasure: integer;	{# Code segments (w/o jump table), ROM, etc.}
				firstCode: integer; 	{ index of first Code segment }
				takingSamples: Boolean; { true if sampling is enabled. }
				MeasureROM: Boolean;	{ true if ROM is to be measured }
				MeasureCode: Boolean;	{ true if Code segments are to be measured. }
				RAMSeg: integer;			{ index of "segment" record to cover RAM }
															{ > 0 if RAM (misses) are to be bucketed. }
				RAMBase: longint;			{ beginning of RAM being measured. }
				MeasureRAMbucketSize: integer;
				MeasureRAMlog2buckSize: integer;

				rom128K: Boolean;
					{ variables from dialog: }
				VRefNum: Integer;					{Volume where the report file is to be created}
				VolumeSelected: Boolean;	{True if user selects the report file name }
				RptFileName: Str255;			{Report file name}
				RptFileCreator: Str255;		{Report File Creator}
				RptFileType: Str255;			{Report File type}
			end;

	function InitPerf (var ThePerfGlobals: TP2PerfGlobals;
											timerCount, CodeAndROMBucketSize: integer;
											doROM, doAppCode: Boolean;
											AppCodeType: Str255;
											ROMID: integer;
											ROMName: Str255;
											doRAM: Boolean;
											RAMLow, RAMHigh: longint;
											RAMBucketSize: integer
											): Boolean;
		{ called once to setup Performance monitoring }

	procedure TermPerf (ThePerfGlobals: TP2PerfGlobals);
		{ if InitPerf succeeds then }
		{ must be called before terminating program. }
		
	function PerfControl (ThePerfGlobals: TP2PerfGlobals; 
				turnOn: Boolean): Boolean;
		{ Call this to turn off/on measuring. }
		{ Returns previous state. }
	
	function  PerfDump (ThePerfGlobals: TP2PerfGlobals; 
				ReportFile: Str255; DoHistogram:Boolean;
				RptFileColumns: Integer	{Number of columns in the report file}
		): integer{OSErr};
		{Call this to dump the statistics into a file}
	
	{ for Internal use only: }
	function  CvtPC (ThePerfGlobals: TP2PerfGlobals; pc: longint): longint;

implementation
{$I Perf2.p}
end.