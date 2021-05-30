{*-------------------------------------------------------------------------------*
 |																				 |
 |						  <<< Pascal Library Interface >>>						 |
 |																				 |
 |					  Copyright Apple Computer, Inc. 1986, 1992, 1994			 |
 |							   All rights reserved. 							 |
 |																				 |
 *-------------------------------------------------------------------------------*}

{
 Interface to the Pascal I/O and Memory Manager Library.
 Built-in procedure and function declarations are marked with
 the (* *) comment characters
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT PASLIBIntf;
  	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingPASLIBINTF AND UNDEFINED __PASLIBINTF__}
{$SETC UsingPASLIBINTF := 1}

{$I+}
{$SETC PASLIBINTFIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes AND UNDEFINED __TYPES__}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$IFC UNDEFINED UsingFiles AND UNDEFINED __FILES__}
{$I $$Shell(PInterfaces)Files.p}
{$ENDC}
{$IFC UNDEFINED UsingAliases AND UNDEFINED __ALIASES__}
{$I $$Shell(PInterfaces)Aliases.p}
{$ENDC}
{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}

{$ALIGN MAC68K}
{$SETC UsingIncludes := PASLIBINTFIncludes}

	TYPE
	  PASCALPOINTER = ^INTEGER; { Universal POINTER type }
	  PASCALFILE = FILE; { Universal FILE type }
(*
 *	  PASCALBLOCK =    { Universal block of chars }
 *			PACKED ARRAY [0..511] OF CHAR;
 *)

	CONST
	  { <StdIO.h> PLSetVBuf styles }
	  _IOFBF = $00; { File buffering }
	  _IOLBF = $40; { Line buffering }
	  _IONBF = $04; { No buffering }

{
 Mac Pascal heap management
}

	PROCEDURE PLHeapInit(sizepheap: LONGINT; heapDelta: LONGINT;
						 memerrProc: UNIV PASCALPOINTER; allowNonCont: BOOLEAN;
						 forDispose: BOOLEAN);
{
 The following procedure is obsolete, use PLHeapInit
}

	PROCEDURE PLInitHeap(sizepheap: LONGINT; memerrProc: UNIV PASCALPOINTER;
						 allowNonCont: BOOLEAN; allowDispose: BOOLEAN);

	PROCEDURE PLSetNonCont(allowNonCont: BOOLEAN);

	PROCEDURE PLSetMErrProc(memerrProc: UNIV PASCALPOINTER);

	PROCEDURE PLSetHeapType(forDispose: BOOLEAN);

	PROCEDURE PLSetHeapCheck(DoIt: BOOLEAN);

{
 File I/O
}

(*
 *	  PROCEDURE
 *		RESET(VAR fvar:  UNIV PASCALFILE; OPT fname: STRING);
 *		BUILTIN;
 *
 *	  PROCEDURE
 *		REWRITE(VAR fvar: UNIV PASCALFILE; OPT fname: STRING);
 *		BUILTIN;
 *
 *	  PROCEDURE
 *		OPEN(VAR fvar:	UNIV PASCALFILE; fname: STRING);
 *		BUILTIN;
 *)

	PROCEDURE PLSetVBuf(VAR fvar: TEXT; buffer: UNIV PASCALPOINTER;
						style: INTEGER; bufsize: INTEGER);
(*
 *	  FUNCTION
 *		BLOCKREAD(
 *		  VAR fvar: FILE;
 *		  VAR buffer: UNIV PASCALBLOCK;
 *		  nBlocks: INTEGER;
 *		  OPT stBlock:INTEGER
 *		):
 *		INTEGER;
 *		BUILTIN;
 *
 *	  FUNCTION
 *		BLOCKWRITE(
 *		  VAR fvar: FILE;
 *		  VAR buffer: UNIV PASCALBLOCK;
 *		  nBlocks: INTEGER;
 *		  OPT stBlock:INTEGER
 *		):
 *		INTEGER;
 *		BUILTIN;
 *
 *	  FUNCTION
 *		BYTEREAD(
 *		  VAR fvar: FILE;
 *		  VAR buffer: UNIV PASCALBLOCK;
 *		  nBytes:  LONGINT;
 *		  OPT stByte: LONGINT
 *		):
 *		LONGINT;
 *		BUILTIN;
 *
 *	  FUNCTION
 *		BYTEWRITE(
 *		  VAR fvar: FILE;
 *		  VAR buffer: UNIV PASCALBLOCK;
 *		  nBytes:  LONGINT;
 *		  OPT stByte: LONGINT
 *		):
 *		LONGINT;
 *		BUILTIN;
 *
 *	  FUNCTION
 *		EOF(OPT VAR fvar: UNIV PASCALFILE):
 *		BOOLEAN;
 *		BUILTIN;
 *
 *	  FUNCTION
 *		EOLN(OPT VAR fvar: TEXT):
 *		BOOLEAN;
 *		BUILTIN;
 *
 *	  PROCEDURE
 *		READ(VAR fvar: TEXT; OPT EXPR_LIST);
 *		BUILTIN;
 *
 *	  PROCEDURE
 *		READLN(OPT VAR fvar: TEXT; OPT EXPR_LIST);
 *		BUILTIN;
 *
 *	  PROCEDURE
 *		WRITE(VAR fvar: TEXT; OPT EXPR_LIST);
 *		BUILTIN;
 *
 *	  PROCEDURE
 *		WRITELN(OPT VAR fvar: TEXT; OPT EXPR_LIST);
 *		BUILTIN;
 *
 *	  PROCEDURE
 *		GET(VAR fvar: UNIV PASCALFILE);
 *		BUILTIN;
 *
 *	  PROCEDURE
 *		PUT(VAR fvar: UNIV PASCALFILE);
 *		BUILTIN;
 *
 *	  PROCEDURE
 *		SEEK(VAR fvar: UNIV PASCALFILE; recno: LONGINT);
 *		BUILTIN;
 *)

	FUNCTION PLFilePos(VAR fvar: UNIV PASCALFILE): LONGINT;

	PROCEDURE PLFlush(VAR fvar: TEXT);

	PROCEDURE PLCrunch(VAR fvar: UNIV PASCALFILE);
	
{
 Directory operations.
}

	PROCEDURE PLPurge(fname: STRING);

	PROCEDURE PLRename(oldFname, newFname: STRING);

{
 Miscellaneous Operations
}

{$IFC NOT UNDEFINED __CFM68K__}
	{$IFC NOT UNDEFINED UsingSharedLibs}
		{$PUSH}
		{$LibExport+}
	{$ENDC}
{$ENDC}

{ The following definition has been moved to MacRuntime.p }
{	FUNCTION TrapAvailable(trap: INTEGER): BOOLEAN; }

{ The following functions can no longer be called directly from Pascal.
  They have been replaced by IExxxxx glue routines, defined below. }
 
 {
	FUNCTION ResolveFolderAliases (volume: INTEGER; directory: LONGINT;
								   path: Str255; resolveLeafName: BOOLEAN;
								   VAR theSpec: FSSpec; VAR isFolder, hadAlias,
								   leafIsAlias: BOOLEAN): OSErr; C;

	FUNCTION MakeResolvedFSSpec (volume: INTEGER; directory: LONGINT;
								 path: Str255; VAR theSpec: FSSpec; VAR isFolder,
								 hadAlias, leafIsAlias: BOOLEAN): OSErr; C;
	
	FUNCTION MakeResolvedPath (volume: INTEGER; directory: LONGINT; path: Str255;
							   resolveLeafAlias: BOOLEAN; VAR buffer: Str255;
							   VAR isFolder, hadAlias, leafIsAlias: BOOLEAN):
							   OSErr; C;
}

	FUNCTION IEResolveFolderAliases (volume: INTEGER; directory: LONGINT;
								     path: Str255; resolveLeafName: BOOLEAN;
								     VAR theSpec: FSSpec; VAR isFolder, hadAlias,
								     leafIsAlias: BOOLEAN): OSErr;

	FUNCTION IEMakeResolvedFSSpec (volume: INTEGER; directory: LONGINT;
								   path: Str255; VAR theSpec: FSSpec; VAR isFolder,
								   hadAlias, leafIsAlias: BOOLEAN): OSErr;
	
	FUNCTION IEResolvePath (VAR rawPath: Str255; VAR resolvedPath: Str255;
							VAR isFolder, hadAlias: BOOLEAN): OSErr;

	FUNCTION IEMakeResolvedPath (volume: INTEGER; directory: LONGINT; path: Str255;
							     resolveLeafAlias: BOOLEAN; VAR buffer: Str255;
							     VAR isFolder, hadAlias, leafIsAlias: BOOLEAN):
							     OSErr;
{
 C string functions for Pascal strings
}
 	FUNCTION PLStrCmp(string1, string2: Str255): INTEGER;

	FUNCTION PLStrnCmp(string1, string2: Str255; n: INTEGER): INTEGER;

	FUNCTION PLStrCpy(VAR string1: Str255; string2: Str255): StringPtr;

	FUNCTION PLStrnCpy(VAR string1: Str255; string2: Str255; n: INTEGER): StringPtr;

	FUNCTION PLStrCat(VAR string1: Str255; string2: Str255): StringPtr;

	FUNCTION PLStrnCat(VAR string1: Str255; string2: Str255; n: INTEGER): StringPtr;

	FUNCTION PLStrChr(string1: Str255; c: CHAR): Ptr;

	FUNCTION PLStrrChr(string1: Str255; c: CHAR): Ptr;

	FUNCTION PLStrPBrk(string1, string2: Str255): Ptr;

	FUNCTION PLStrSpn(string1, string2: Str255): INTEGER;

	FUNCTION PLStrStr(string1, string2: Str255): Ptr;

	FUNCTION PLStrLen(string1: Str255): INTEGER;
	
	FUNCTION PLPos(STRING1: Str255; STRING2: Str255): INTEGER;

{$IFC NOT UNDEFINED __CFM68K__}
	{$IFC NOT UNDEFINED UsingSharedLibs}
		{$POP}
	{$ENDC}
{$ENDC}

{$ALIGN RESET}

{$SETC UsingIncludes := PASLIBINTFIncludes}

{$ENDC}    { UsingPASLIBINTF }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}
