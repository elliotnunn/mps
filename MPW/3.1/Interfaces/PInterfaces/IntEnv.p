{*-------------------------------------------------------------------------------*
 |																				 |
 |						  <<< Integrated Environment >>>						 |
 |																				 |
 |				 Copyright Apple Computer, Inc. 1986, 1987, 1988		 		 |
 |							   All rights reserved. 							 |
 |																				 |
 *-------------------------------------------------------------------------------*}

UNIT IntEnv;

  INTERFACE

	USES PasLibIntf; { For definition of PASCALFILE }

	CONST

	  { CMD words for IEfaccess(), from <fcntl.h> }

	  F_OPEN = $6400; { (('d'<<8)|00), d => "directory" ops }
	  F_DELETE = $6401;
	  F_RENAME = $6402;

	  F_GTABINFO = $6500; { (('e'<<8)|00), e => "editor" ops }
	  F_STABINFO = $6501;
	  F_GFONTINFO = $6502;
	  F_SFONTINFO = $6503;
	  F_GPRINTREC = $6504;
	  F_SPRINTREC = $6505;
	  F_GSELINFO = $6506;
	  F_SSELINFO = $6507;
	  F_GWININFO = $6508;
	  F_SWININFO = $6509;

	  { Open modes for IEopen(), from <fcntl.h> }

	  O_RDONLY = $0000;
	  O_WRONLY = $0001;
	  O_RDWR = $0002;
	  O_APPEND = $0008;
	  O_RSRC = $0010;
	  O_CREAT = $0100;
	  O_TRUNC = $0200;
	  O_EXCL = $0400;

	  { IOCtl parameters }

	  FIOINTERACTIVE = $6602; { (('f'<<8)|02), f => "open file" ops }
	  FIOBUFSIZE = $6603;
	  FIOFNAME = $6604;
	  FIOREFNUM = $6605;
	  FIOSETEOF = $6606;

	  TIOFLUSH = $7400; { (('t'<<8)|00), t => "terminal" ops }
	  TIOSPORT = $7401;
	  TIOGPORT = $7402;

	TYPE
	  IEString = STRING;
	  IEStringPtr = ^IEString;
	  IEStringVec = ARRAY [0..8191] OF IEStringPtr;
	  IEStringVecPtr = ^IEStringVec;

	  {$PUSH}
	  {$J+} { EXPORTed unit globals }

	VAR
	  ArgC: LONGINT;
	  ArgV: IEStringVecPtr;
	  EnvP: IEStringVecPtr;

	  Diagnostic: TEXT;
	  {$POP}

	FUNCTION IEStandAlone: BOOLEAN;

	FUNCTION IEgetenv(envName: STRING; VAR envValue: UNIV IEString): BOOLEAN;

	FUNCTION IEfaccess(fName: STRING; opCode: LONGINT;
					   arg: UNIV LONGINT): LONGINT;

	PROCEDURE IEopen(VAR fvar: UNIV PASCALFILE; fName: STRING; mode: LONGINT);

	FUNCTION IEioctl(VAR fvar: UNIV PASCALFILE; request: LONGINT;
					 arg: UNIV LONGINT): LONGINT;

	FUNCTION IElseek(VAR fvar: UNIV PASCALFILE; offset: LONGINT;
					 whence: LONGINT): LONGINT;

	PROCEDURE IEatexit(exitProc: UNIV LONGINT);
	  C;

	PROCEDURE IEexit(status: LONGINT);
	  C;

	PROCEDURE IE_exit(status: LONGINT);
	  C;

END.
