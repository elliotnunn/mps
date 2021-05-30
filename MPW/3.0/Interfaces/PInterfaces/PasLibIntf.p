{*-------------------------------------------------------------------------------*
 |																				 |
 |						  <<< Pascal Library Interface >>>						 |
 |																				 |
 |						Copyright Apple Computer, Inc. 1986 					 |
 |							   All rights reserved. 							 |
 |																				 |
 *-------------------------------------------------------------------------------*}

{
 Interface to the Pascal I/O and Memory Manager Library.
 Built-in procedure and function declarations are marked with
 the (* *) comment characters
}

UNIT PASLIBIntf;

  INTERFACE

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

END.
