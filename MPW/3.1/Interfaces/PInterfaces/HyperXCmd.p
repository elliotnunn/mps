{
Created: Thursday, October 27, 1988 at 10:56 PM
	HyperXCmd.p
	Definition file for HyperCard XCMDs and XFCNs in Pascal.

	Copyright Apple Computer, Inc.	1987-1988
	All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT HyperXCmd;
	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingHyperXCmd}
{$SETC UsingHyperXCmd := 1}

{$I+}
{$SETC HyperXCmdIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$SETC UsingIncludes := HyperXCmdIncludes}

CONST

{ result codes }

xresSucc = 0;
xresFail = 1;
xresNotImp = 2;


TYPE


XCmdPtr = ^XCmdBlock;
XCmdBlock = RECORD
	paramCount: INTEGER;
	params: ARRAY [1..16] OF Handle;
	returnValue: Handle;
	passFlag: BOOLEAN;
	entryPoint: ProcPtr;	{to call back to HyperCard}
	request: INTEGER;
	result: INTEGER;
	inArgs: ARRAY [1..8] OF LONGINT;
	outArgs: ARRAY [1..4] OF LONGINT;
	END;



PROCEDURE SendCardMessage(paramPtr: XCmdPtr;msg: Str255);
PROCEDURE SendHCMessage(paramPtr: XCmdPtr;msg: Str255);
FUNCTION GetGlobal(paramPtr: XCmdPtr;globName: Str255): Handle;
PROCEDURE SetGlobal(paramPtr: XCmdPtr;globName: Str255;globValue: Handle);
FUNCTION GetFieldByID(paramPtr: XCmdPtr;cardFieldFlag: BOOLEAN;fieldID: INTEGER): Handle;
FUNCTION GetFieldByName(paramPtr: XCmdPtr;cardFieldFlag: BOOLEAN;fieldName: Str255): Handle;
FUNCTION GetFieldByNum(paramPtr: XCmdPtr;cardFieldFlag: BOOLEAN;fieldNum: INTEGER): Handle;
PROCEDURE SetFieldByID(paramPtr: XCmdPtr;cardFieldFlag: BOOLEAN;fieldID: INTEGER;
	fieldVal: Handle);
PROCEDURE SetFieldByName(paramPtr: XCmdPtr;cardFieldFlag: BOOLEAN;fieldName: Str255;
	fieldVal: Handle);
PROCEDURE SetFieldByNum(paramPtr: XCmdPtr;cardFieldFlag: BOOLEAN;fieldNum: INTEGER;
	fieldVal: Handle);
PROCEDURE BoolToStr(paramPtr: XCmdPtr;bool: BOOLEAN;VAR str: Str255);
PROCEDURE ExtToStr(paramPtr: XCmdPtr;num: Extended;VAR str: Str255);
PROCEDURE LongToStr(paramPtr: XCmdPtr;posNum: LONGINT;VAR str: Str255);
PROCEDURE NumToStr(paramPtr: XCmdPtr;num: LONGINT;VAR str: Str255);
PROCEDURE NumToHex(paramPtr: XCmdPtr;num: LONGINT;nDigits: INTEGER;VAR str: Str255);
FUNCTION StrToBool(paramPtr: XCmdPtr;str: Str255): BOOLEAN;
FUNCTION StrToExt(paramPtr: XCmdPtr;str: Str255): Extended;
FUNCTION StrToLong(paramPtr: XCmdPtr;str: Str255): LONGINT;
FUNCTION StrToNum(paramPtr: XCmdPtr;str: Str255): LONGINT;
FUNCTION PasToZero(paramPtr: XCmdPtr;str: Str255): Handle;
PROCEDURE ZeroToPas(paramPtr: XCmdPtr;zeroStr: Ptr;VAR pasStr: Str255);
FUNCTION EvalExpr(paramPtr: XCmdPtr;expr: Str255): Handle;
PROCEDURE ReturnToPas(paramPtr: XCmdPtr;zeroStr: Ptr;VAR pasStr: Str255);
PROCEDURE ScanToReturn(paramPtr: XCmdPtr;VAR scanPtr: Ptr);
PROCEDURE ScanToZero(paramPtr: XCmdPtr;VAR scanPtr: Ptr);
FUNCTION StringEqual(paramPtr: XCmdPtr;str1: Str255;str2: Str255): BOOLEAN;
FUNCTION StringMatch(paramPtr: XCmdPtr;pattern: Str255;target: Ptr): Ptr;
FUNCTION StringLength(paramPtr: XCmdPtr;strPtr: Ptr): LONGINT;
PROCEDURE ZeroBytes(paramPtr: XCmdPtr;dstPtr: Ptr;longCount: LONGINT);

{$ENDC}    { UsingHyperXCmd }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}

