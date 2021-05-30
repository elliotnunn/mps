
{
Created: Thursday, September 12, 1991 at 9:51 AM
 FileTransferTools.p
 Pascal Interface to the Macintosh Libraries

  Copyright Apple Computer, Inc. 1988-1991
  All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT FileTransferTools;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingFileTransferTools}
{$SETC UsingFileTransferTools := 1}

{$I+}
{$SETC FileTransferToolsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingDialogs}
{$I $$Shell(PInterfaces)Dialogs.p}
{$ENDC}
{$IFC UNDEFINED UsingFileTransfers}
{$I $$Shell(PInterfaces)FileTransfers.p}
{$ENDC}
{$SETC UsingIncludes := FileTransferToolsIncludes}

CONST

{ Control }
ftInitMsg = 0;
ftDisposeMsg = 1;
ftSuspendMsg = 2;
ftResumeMsg = 3;
ftMenuMsg = 4;
ftEventMsg = 5;
ftActivateMsg = 6;
ftDeactivateMsg = 7;
ftGetErrorStringMsg = 8;

ftAbortMsg = 52;

ftStartMsg = 100;
ftExecMsg = 102;
ftSendMsg = 103;
ftReceiveMsg = 104;

{Setup }
ftSpreflightMsg = 0;
ftSsetupMsg = 1;
ftSitemMsg = 2;
ftSfilterMsg = 3;
ftScleanupMsg = 4;

{ validate }
ftValidateMsg = 0;
ftDefaultMsg = 1;

{ scripting }
ftMgetMsg = 0;
ftMsetMsg = 1;

{ localization }
ftL2English = 0;
ftL2Intl = 1;

{ DEFs }
fdefType = 'fdef';
fsetType = 'fset';
fvalType = 'fval';
flocType = 'floc';
fscrType = 'fscr';

fbndType = 'fbnd';
fverType = 'vers';

TYPE
FTSetupPtr = ^FTSetupStruct;
FTSetupStruct = PACKED RECORD
 theDialog: DialogPtr;	{ the dialog form the application }
 count: INTEGER;		{ first appended item }
 theConfig: Ptr;		{ the config record to setup }
 procID: INTEGER;		{ procID of the tool }
 END;



{$ENDC} { UsingFileTransferTools }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

