{------------------------------------------------------------------------------

FILE ResEqual.p
 Copyright Apple Computer, Inc. 1986
 All rights reserved.

NAME
 ResEqual -- compare resources in two files

SYNOPSIS
 resequal [-p] file1 file2

DESCRIPTION
 "resequal" compares the resources in two files.  If both files contain
 the same resources, and all of the resources are equal, it runs silently.
 It reports resources found in only one of the files, resources of
 different sizes, and resources with different contents. Output is
 written to standard output. The -p option writes progress information
 to diagnostic output.


------------------------------------------------------------------------------}
{$R-} { Turn off range checking}
PROGRAM ResEqual;

  USES Memtypes,
	   Quickdraw,
	   OSIntf,
	   ToolIntf,
	   PackIntf,		   { Standard Includes}
	   CursorCtl,		   { for the spinning cursor}
	   Signal,			   { to handle command-period}
	   PasLibIntf,		   { for standard I/O, etc.}
	   IntEnv;			   { for argV and argC}

  CONST
	Version = '1.0';	   { Current version}

  VAR

	file1Ref,
	file2Ref,
	curRes: Integer;	   { the refnums for our files }
	file1Name,
	file2Name: Str255;	   { the names of the files we're comparing}
	quiet: Boolean; 	   { True ==> no info on Diagnostic file}
	progName: Str255;	   { Program's file name}
	interrupted: Boolean;  { True ==> interrupted (Opt "." pressed)}
	retCode: (RC_Normal, RC_ParmErrs, RC_Abort);   {Return codes}


 {*----------------------------------*
  | Stop -	terminate  execution	 |
  *----------------------------------*}

  PROCEDURE Stop(msg: Str255);

	BEGIN {Stop}
	  IF Length(msg) > 0 THEN
		BEGIN
		WriteLn(Diagnostic);
		WriteLn(Diagnostic, msg);
		END;

	  IF interrupted THEN retCode := RC_Abort;
	  { don't worry about closing the files we opened.  The Shell
		will do so if appropriate.}
	  IEexit(Ord(retCode)); {exit, returning the appropriate status code}
	END; {Stop}

 {*--------------------------------------*
  | Intr -	Process external interrupt	 |
  | this routine is passed to IEsigset	 |
  *--------------------------------------*}

  PROCEDURE Intr;

	BEGIN {Intr}
	  interrupted := True; {we test this switch periodically}
	END; {Intr}

 {*-------------------------------------------------------------*
  | SyntaxError - Report an error in parameters or options		|
  *-------------------------------------------------------------*}

  PROCEDURE SyntaxError(suffix: Str255);

	BEGIN {SyntaxError}
	  WriteLn(Diagnostic, '### ', progName, ' - ', suffix);
	  Stop(Concat('# Usage: ', progName, ' file1 file2 [-p]'));
	END; {SyntaxError}

 {*-----------------------------------*
  | LetterOpt - Set a letter  option  |
  *-----------------------------------*}

  PROCEDURE LetterOpt(opt: Char; VAR argVIndex: Integer);
 { note only one option is supported.  argVIndex is passed to
  this routine so options that have arguments can 'eat' them}

	BEGIN {LetterOpt}
	  CASE opt OF
		'p', 'P': quiet := False;
		OTHERWISE SyntaxError(Concat(ArgV^[argVIndex]^, ' <invalid option>'));
	  END; {case}
	END; {LetterOpt}

 {*---------------------------*
  | Init - Tool initalization |
  *---------------------------*}

  PROCEDURE Init;

	VAR
	  ioRslt, argVIndex, fileCount, holdIndex: Integer;
	  prevSig: SignalHandler;
	  strH: StringHandle;
	  nextFileNamePtr: StringPtr;
	  arg: Str255;

	BEGIN {Init}
	  retCode := RC_Normal;

	  interrupted := False; 	 {becomes True when interrupted}
	  prevSig := IEsigset(SIGALLSIGS, @Intr);

	  quiet := True;
	  progName := ArgV^[0]^;
	  retCode := RC_ParmErrs;

	  fileCount := 0;
	  retCode := RC_ParmErrs;
	  file1Ref := - 1;			 { so we tell if the open works}
	  file2Ref := - 1;			 { as above}
	  argVIndex := 1;
	  WHILE argVIndex < ArgC DO  {ArgC is the number of args plus one}
		BEGIN
		arg := ArgV^[argVIndex]^;
		IF (Length(arg) <> 0) THEN
		  BEGIN
		  IF arg[1] = '-' THEN	 { we have an option }
			BEGIN
			holdIndex := argVIndex;
			LetterOpt(arg[2], argVIndex);
			IF argVIndex <> holdIndex THEN
			  CYCLE;			 { skip the increment of argVIndex below}
			END
		  ELSE					 { it must be a file to open}
			BEGIN
			fileCount := fileCount + 1;
			IF fileCount = 1 THEN
			  nextFileNamePtr := @file1Name
			ELSE
			  nextFileNamePtr := @file2Name;
			nextFileNamePtr^ := ArgV^[argVIndex]^;
			END;
		  END;
		argVIndex := argVIndex + 1;
		END;
	  IF fileCount <> 2 THEN SyntaxError('Invalid Parameters');
	  curRes := CurResFile;

	  SetResLoad(False);		 { keep preloads from loading}
	  file2Ref := OpenResFile(file2Name);
	  SetResLoad(True);
	  IF file2Ref = - 1 THEN
		Stop(Concat('### ', progName, ' - ', 'could not open ', file2Name));
	  SetResLoad(False);		 { keep preloads from loading}
	  file1Ref := OpenResFile(file1Name);
	  SetResLoad(True);
	  UseResFile(curRes);		 { in case file2 opened, but file one doesn't}
	  IF file1Ref = - 1 THEN
		Stop(Concat('### ', progName, ' - ', 'could not open ', file1Name));

	  retCode := RC_Normal;

	  IF NOT quiet THEN
		BEGIN
		WriteLn(Diagnostic);
		WriteLn(Diagnostic, progName, '  (Ver ', Version, ') ');
		WriteLn(Diagnostic);
		WriteLn(Diagnostic);
		END;

	  RotateCursor(0);
	  IF interrupted THEN Stop('');
	END; {Init}

 {*--------------------------------------*
  | DoIt -- check resources in each file |
  *--------------------------------------*}

  PROCEDURE DoIt; { the guts of our program--in a procedure so the compiler
					can do register optimizations}

	TYPE
	  ErrorType = (diffSize, diffContents, notInBoth, progress);

	VAR
	  cursorCount: Integer; 		{ for our spinning cursor}

	  badValue1, badValue2: Integer;

	  firstTime: Boolean;			{ is this our first problem? }
	  forFile1: Boolean;			{ are we looking at the first or second file?}

	  theType: ResType; 			{ parameters for GetResInfo calls}
	  theID: Integer;
	  theName: Str255;

	  theSize1, theSize2: LongInt;

 {*---------------------------------*
  | TellIt -- report problems		|
  *---------------------------------*}

	PROCEDURE TellIt(why: ErrorType);

	  VAR
		width: Integer;

	  BEGIN {TellIt}
		IF (firstTime) AND (why <> progress) THEN
		  BEGIN
		  WriteLn('  Type  ', 'ID': 8, 'Name': 16,' ', file1Name: 12,' ', file2Name: 19,
				  'position': 14);
		  firstTime := False;
		  END;

		IF forFile1 THEN
		  width := 10
		ELSE
		  width := 30;

		IF why <> progress THEN
		  BEGIN
		  Write(theType: 6, theID: 10, theName: 16);
		  END;
		CASE why OF
		  diffSize:
			BEGIN
			WriteLn(theSize1: 14, theSize2: 20)
			END;
		  diffContents:
			BEGIN
			WriteLn(badValue1: 14, badValue2: 20, theSize1: 10)
			END;
		  notInBoth:
			BEGIN
			WriteLn('•': width)
			END;
		  progress:
			BEGIN
			WriteLn(Diagnostic, 'checking resource ', theType, ' #', theID);
			END
		END; {case}
	  END; {TellIt}

 {*-------------------------------------------------*
  | NotEqual--return TRUE if handles are NOT equal	|
  *-------------------------------------------------*}

	FUNCTION NotEqual(a, b: handle; size: LongInt): Boolean;

	  VAR
		count: LongInt;
		source, target: Ptr;

	  BEGIN {NotEqual}
		NotEqual := False;
		source := a^; target := b^;
		FOR count := 1 TO size DO
		  IF source^ <> target^ THEN
			BEGIN
			NotEqual := True;
			badValue1 := source^;		  { so the values get displayed in TellIt}
			badValue2 := target^;
			LEAVE;
			END
		  ELSE
			BEGIN
			source := Ptr(Ord(source) + 1);
			target := Ptr(Ord(target) + 1);
			END;
	  END; {NotEqual}

 {*-------------------------------------------*
  | CheckResources -- compare those resources |
  *-------------------------------------------*}

	PROCEDURE CheckResources(prime, second: Integer; doCompare: Boolean);

	  VAR
		typeIndex, resIndex: Integer;	  { counters for our getindXXXX calls}

		theRes1, theRes2: handle;		  { handles for our resource compares}
		homeFile: Integer;				  { what file is this resource in?}
		clearRes1, clearRes2 : Boolean;   { call emptyhandle if True}
		
	  BEGIN { CheckResources}
		FOR typeIndex := 1 TO CountTypes DO { countTypes counts Types in ALL
											 open resource files}
		  BEGIN
		  GetIndType(theType, typeIndex); { get the next type--GetIndxxxx
										   routines do not use CurResFile}
		  FOR resIndex := 1 TO CountResources(theType) DO
			BEGIN
			SetResLoad(False);			  { we want the info, but not the
										  data right now}
			theRes1 := GetIndResource(theType, resIndex);
			SetResLoad(True);			  { so loadseg will really get
										  our segments}

			cursorCount := cursorCount + 1;
			RotateCursor(cursorCount);

			homeFile := HomeResFile(theRes1);
			IF (homeFile <> prime) & (homeFile <> second) THEN
			   LEAVE;					  { no reason to check handles below
										  our target files}
			IF homeFile <> prime THEN	  {we only want resources from Prime
										  for now}
			  CYCLE;					  { to FOR resIndex …}
			IF interrupted THEN Stop(''); { in case the user hit command-period}

			{ we want the resource ID and name}
			GetResInfo(theRes1, theID, theType, theName);
			UseResFile(second); 		  { now we will try to find a
										  match in Second}
			SetResLoad(False);			  { we want the info, but not the
										  data right now}
			theRes2 := GetResource(theType, theID); { resLoad is FALSE}
			SetResLoad(True);			  { so loadseg will really get
										  our segments}
			UseResFile(curRes); 		  { from our resource file}

			IF NOT quiet THEN
			  BEGIN
			  TellIt(progress);
			  END;

			IF (theRes2 = NIL) |		  { NOTE the short circuit evaluation!}
			   (HomeResFile(theRes2) <> second) THEN {either only one resource
													  ID matches, or 2nd not in 
													  our file}
			  TellIt(notInBoth)
			ELSE IF doCompare THEN
			  BEGIN
			  theSize1 := SizeResource(theRes1);
			  theSize2 := SizeResource(theRes2);
			  IF theSize1 <> theSize2 THEN
				TellIt(diffSize)
			  ELSE
				BEGIN
				clearRes1 := LongInt(theRes1^) = 0;
				LoadResource(theRes1);	  { resload is TRUE, so get the data--add
										  check for reserr}
				IF ResError <> 0 THEN
				  BEGIN
				  Stop('could not load resource');
				  END;
				clearRes2 := LongInt(theRes2^) = 0;
				LoadResource(theRes2);	  { as above}
				IF ResError <> 0 THEN
				  BEGIN
				  Stop('could not load resource');
				  END;
				IF NotEqual(theRes1, theRes2, theSize1) THEN
				  TellIt(diffContents);
				IF clearRes1 THEN
					EmptyHandle(theRes1); { free memory if we loaded resource}
				IF clearRes2 THEN
					EmptyHandle(theRes2); { as above}
				END;
			  END;
			END;
		  END;
	  END; {CheckResources}

	BEGIN {DoIt}
	  cursorCount := 0; 				  { prepare to spin that cursor}
	  firstTime := True;				  { looking good so far}
	  forFile1 := True;
	  CheckResources(file1Ref, file2Ref, True);
	  forFile1 := False;
	  CheckResources(file2Ref, file1Ref, False);
	  Stop('');
	END; {DoIt}

 {*----------------------------*
  | ResEqual -- main program   |
  *----------------------------*}

  BEGIN {ResEqual}
	Init;							{ sets up world, opens our resource files}
	UnLoadSeg(@Init);				{ release our initialization segment}
	DoIt;							{ and call our routine}
  END. {ResEqual}
