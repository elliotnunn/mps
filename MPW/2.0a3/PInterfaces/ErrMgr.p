{*-------------------------------------------------------------------------------*
 |																				 |
 |							 <<< Error File Manager >>> 						 |
 |																				 |
 |									 07/31/86									 |
 |																				 |
 |				  Copyright Apple Computer, Inc. 1984, 1985, 1986				 |
 |							   All rights reserved. 							 |
 |																				 |
 *-------------------------------------------------------------------------------*}

UNIT ErrMgr;

  INTERFACE

	USES {$u MemTypes.p} MemTypes,
	  {$u QuickDraw.p} QuickDraw,
	  {$u OSIntf.p} OSIntf,
	  {$u PasLibIntf.p} PasLibIntf,
	  {$u IntEnv.p} IntEnv;

	PROCEDURE InitErrMgr(ToolErrFileName: Str255; SysErrFileName: Str255;
						 ShowToolErrNbrs: Boolean);
   {ErrMgr initialization.	Must be done before using any other ErrMgr
	routine.  Set ShowToolErrNbrs to TRUE if you want all messages to
	begin with the error number, as in "[OS] Error <n> <msg txt>".
	Failure by the ErrMgr to find the message text will always result
	in a message of this form (without the <msg txt>).	ToolErrFileName
	is used to specify the name of the tool-specific error file, and
	should be the null string if not used (or if the tool's data fork is
	to be used as the error file).	SysErrFileName is used to specify the
	name of the system error file, and should normally be the null string
	which causes the ErrMgr to look in the MPW Shell directory for
	"SysErrs.Err".	Specifying names for the error files will avoid IntEnv
	calls which look up the values of shell variables.}

	PROCEDURE CloseErrMgr;
   {Ideally should be done at the end of execution to make sure all files
	opened by the ErrMgr are closed.  You can let normal program termination
	do the closing.  But if you are a purist...}

	PROCEDURE GetToolErrText(MsgNbr: Integer; ErrInsert: Str255;
							 ErrMsg: StringPtr);
   {Get error message text corresponding to error number ErrNbr from the
	tool error message file (whose name is specified in the InitErrMgr call).
	The text of the message is returned in ErrMsg.	If the message is to
	have an insert, then ErrInsert should contain it.  Otherwise it should
	be null.}

	PROCEDURE GetSysErrText(MsgNbr: Integer; ErrMsg: StringPtr);
   {Get error message text corresponding to error number ErrNbr from the
	system error message file ("SysErrs.Err" in the "ShellDirectory").
	The text of the message is returned in ErrMsg.}

	PROCEDURE AddErrInsert(ErrInsert: Str255; ErrMsg: StringPtr);
   {Add another insert to an error message string.	This call is used
	when more than one insert is needed in a message}

END.
