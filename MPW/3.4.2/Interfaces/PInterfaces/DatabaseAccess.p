{
 	File:		DatabaseAccess.p
 
 	Contains:	Database Access Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT DatabaseAccess;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DATABASEACCESS__}
{$SETC __DATABASEACCESS__ := 1}

{$I+}
{$SETC DatabaseAccessIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __RESOURCES__}
{$I Resources.p}
{$ENDC}
{	Types.p														}
{		ConditionalMacros.p										}
{	MixedMode.p													}
{	Files.p														}
{		OSUtils.p												}
{			Memory.p											}
{		Finder.p												}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	typeNone					= 'none';
	typeDate					= 'date';
	typeTime					= 'time';
	typeTimeStamp				= 'tims';
	typeDecimal					= 'deci';
	typeMoney					= 'mone';
	typeVChar					= 'vcha';
	typeVBin					= 'vbin';
	typeLChar					= 'lcha';
	typeLBin					= 'lbin';
	typeDiscard					= 'disc';
{ "dummy" types for DBResultsToText }
	typeUnknown					= 'unkn';
	typeColBreak				= 'colb';
	typeRowBreak				= 'rowb';
{ pass this in to DBGetItem for any data type }
	typeAnyType					= 0;

{ infinite timeout value for DBGetItem }
{ messages for status functions for DBStartQuery }
	kDBUpdateWind				= 0;
	kDBAboutToInit				= 1;
	kDBInitComplete				= 2;
	kDBSendComplete				= 3;
	kDBExecComplete				= 4;
	kDBStartQueryComplete		= 5;

{ messages for status functions for DBGetQueryResults }
	kDBGetItemComplete			= 6;
	kDBGetQueryResultsComplete	= 7;
	kDBWaitForever				= -1;
{  flags for DBGetItem  }
	kDBLastColFlag				= $0001;
	kDBNullFlag					= $0004;

	
TYPE
	DBType = OSType;

	DBAsyncParmBlkPtr = ^DBAsyncParamBlockRec;

	{
		DBCompletionProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => pb          	A1.L
	}
	DBCompletionProcPtr = Register68kProcPtr;  { register PROCEDURE DBCompletion(pb: DBAsyncParmBlkPtr); }
	DBCompletionUPP = UniversalProcPtr;

	DBAsyncParamBlockRec = RECORD
		completionProc:			DBCompletionUPP;						{ pointer to completion routine }
		result:					OSErr;									{ result of call }
		userRef:				LONGINT;								{ for application's use }
		ddevRef:				LONGINT;								{ for ddev's use }
		reserved:				LONGINT;								{ for internal use }
	END;

CONST
	uppDBCompletionProcInfo = $0000B802; { Register PROCEDURE (4 bytes in A1); }

PROCEDURE CallDBCompletionProc(pb: DBAsyncParmBlkPtr; userRoutine: DBCompletionUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

FUNCTION NewDBCompletionProc(userRoutine: DBCompletionProcPtr): DBCompletionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

TYPE
	ResListElem = RECORD
		theType:				ResType;								{ resource type }
		id:						INTEGER;								{ resource id }
	END;

	ResListPtr = ^ResListElem;
	ResListHandle = ^ResListPtr;

{ structure for query list in QueryRecord }
	QueryArray = ARRAY [0..255] OF Handle;

	QueryListPtr = ^QueryArray;
	QueryListHandle = ^QueryListPtr;

	QueryRecord = RECORD
		version:				INTEGER;								{ version }
		id:						INTEGER;								{ id of 'qrsc' this came from }
		queryProc:				Handle;									{ handle to query def proc }
		ddevName:				Str63;									{ ddev name }
		host:					Str255;									{ host name }
		user:					Str255;									{ user name }
		password:				Str255;									{ password }
		connStr:				Str255;									{ connection string }
		currQuery:				INTEGER;								{ index of current query }
		numQueries:				INTEGER;								{ number of queries in list }
		queryList:				QueryListHandle;						{ handle to array of handles to text }
		numRes:					INTEGER;								{ number of resources in list }
		resList:				ResListHandle;							{ handle to array of resource list elements }
		dataHandle:				Handle;									{ for use by query def proc }
		refCon:					LONGINT;								{ for use by application }
	END;

	QueryPtr = ^QueryRecord;
	QueryHandle = ^QueryPtr;

{ structure of column types array in ResultsRecord }
	ColTypesArray = ARRAY [0..255] OF DBType;

	ColTypesPtr = ^ColTypesArray;
	ColTypesHandle = ^ColTypesPtr;

	DBColInfoRecord = RECORD
		len:					INTEGER;
		places:					INTEGER;
		flags:					INTEGER;
	END;

	ColInfoArray = ARRAY [0..255] OF DBColInfoRecord;

	ColInfoPtr = ^ColInfoArray;
	ColInfoHandle = ^ColInfoPtr;

	ResultsRecord = RECORD
		numRows:				INTEGER;								{ number of rows in result }
		numCols:				INTEGER;								{ number of columns per row }
		colTypes:				ColTypesHandle;							{ data type array }
		colData:				Handle;									{ actual results }
		colInfo:				ColInfoHandle;							{ DBColInfoRecord array }
	END;

	DBQueryDefProcPtr = ProcPtr;  { FUNCTION DBQueryDef(VAR sessID: LONGINT; query: QueryHandle): OSErr; }
	DBStatusProcPtr = ProcPtr;  { FUNCTION DBStatus(message: INTEGER; result: OSErr; dataLen: INTEGER; dataPlaces: INTEGER; dataFlags: INTEGER; dataType: DBType; dataPtr: Ptr): BOOLEAN; }
	DBResultHandlerProcPtr = ProcPtr;  { FUNCTION DBResultHandler(dataType: DBType; theLen: INTEGER; thePlaces: INTEGER; theFlags: INTEGER; theData: Ptr; theText: Handle): OSErr; }
	DBQueryDefUPP = UniversalProcPtr;
	DBStatusUPP = UniversalProcPtr;
	DBResultHandlerUPP = UniversalProcPtr;

CONST
	uppDBQueryDefProcInfo = $000003E0; { FUNCTION (4 byte param, 4 byte param): 2 byte result; }
	uppDBStatusProcInfo = $000FAA90; { FUNCTION (2 byte param, 2 byte param, 2 byte param, 2 byte param, 2 byte param, 4 byte param, 4 byte param): 1 byte result; }
	uppDBResultHandlerProcInfo = $0003EAE0; { FUNCTION (4 byte param, 2 byte param, 2 byte param, 2 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewDBQueryDefProc(userRoutine: DBQueryDefProcPtr): DBQueryDefUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDBStatusProc(userRoutine: DBStatusProcPtr): DBStatusUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDBResultHandlerProc(userRoutine: DBResultHandlerProcPtr): DBResultHandlerUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallDBQueryDefProc(VAR sessID: LONGINT; query: QueryHandle; userRoutine: DBQueryDefUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallDBStatusProc(message: INTEGER; result: OSErr; dataLen: INTEGER; dataPlaces: INTEGER; dataFlags: INTEGER; dataType: DBType; dataPtr: Ptr; userRoutine: DBStatusUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallDBResultHandlerProc(dataType: DBType; theLen: INTEGER; thePlaces: INTEGER; theFlags: INTEGER; theData: Ptr; theText: Handle; userRoutine: DBResultHandlerUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InitDBPack: OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0004, $303C, $0100, $A82F;
	{$ENDC}
FUNCTION DBInit(VAR sessID: LONGINT; ddevName: ConstStr63Param; host: ConstStr255Param; user: ConstStr255Param; passwd: ConstStr255Param; connStr: ConstStr255Param; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0E02, $A82F;
	{$ENDC}
FUNCTION DBEnd(sessID: LONGINT; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0403, $A82F;
	{$ENDC}
FUNCTION DBGetConnInfo(sessID: LONGINT; sessNum: INTEGER; VAR returnedID: LONGINT; VAR version: LONGINT; VAR ddevName: Str63; VAR host: Str255; VAR user: Str255; VAR network: Str255; VAR connStr: Str255; VAR start: LONGINT; VAR state: OSErr; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $1704, $A82F;
	{$ENDC}
FUNCTION DBGetSessionNum(sessID: LONGINT; VAR sessNum: INTEGER; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0605, $A82F;
	{$ENDC}
FUNCTION DBSend(sessID: LONGINT; text: Ptr; len: INTEGER; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0706, $A82F;
	{$ENDC}
FUNCTION DBSendItem(sessID: LONGINT; dataType: DBType; len: INTEGER; places: INTEGER; flags: INTEGER; buffer: UNIV Ptr; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0B07, $A82F;
	{$ENDC}
FUNCTION DBExec(sessID: LONGINT; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0408, $A82F;
	{$ENDC}
FUNCTION DBState(sessID: LONGINT; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0409, $A82F;
	{$ENDC}
FUNCTION DBGetErr(sessID: LONGINT; VAR err1: LONGINT; VAR err2: LONGINT; VAR item1: Str255; VAR item2: Str255; VAR errorMsg: Str255; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0E0A, $A82F;
	{$ENDC}
FUNCTION DBBreak(sessID: LONGINT; abort: BOOLEAN; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $050B, $A82F;
	{$ENDC}
FUNCTION DBGetItem(sessID: LONGINT; timeout: LONGINT; VAR dataType: DBType; VAR len: INTEGER; VAR places: INTEGER; VAR flags: INTEGER; buffer: UNIV Ptr; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $100C, $A82F;
	{$ENDC}
FUNCTION DBUnGetItem(sessID: LONGINT; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $040D, $A82F;
	{$ENDC}
FUNCTION DBKill(asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $020E, $A82F;
	{$ENDC}
FUNCTION DBGetNewQuery(queryID: INTEGER; VAR query: QueryHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $030F, $A82F;
	{$ENDC}
FUNCTION DBDisposeQuery(query: QueryHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0210, $A82F;
	{$ENDC}
FUNCTION DBStartQuery(VAR sessID: LONGINT; query: QueryHandle; statusProc: DBStatusUPP; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0811, $A82F;
	{$ENDC}
FUNCTION DBGetQueryResults(sessID: LONGINT; VAR results: ResultsRecord; timeout: LONGINT; statusProc: DBStatusUPP; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0A12, $A82F;
	{$ENDC}
FUNCTION DBResultsToText(VAR results: ResultsRecord; VAR theText: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0413, $A82F;
	{$ENDC}
FUNCTION DBInstallResultHandler(dataType: DBType; theHandler: DBResultHandlerUPP; isSysHandler: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0514, $A82F;
	{$ENDC}
FUNCTION DBRemoveResultHandler(dataType: DBType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0215, $A82F;
	{$ENDC}
FUNCTION DBGetResultHandler(dataType: DBType; VAR theHandler: DBResultHandlerUPP; getSysHandler: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0516, $A82F;
	{$ENDC}
FUNCTION DBIdle: OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00FF, $A82F;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DatabaseAccessIncludes}

{$ENDC} {__DATABASEACCESS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
