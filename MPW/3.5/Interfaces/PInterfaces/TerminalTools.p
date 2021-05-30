{
     File:       TerminalTools.p
 
     Contains:   Communications Toolbox Terminal tools Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1988-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT TerminalTools;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TERMINALTOOLS__}
{$SETC __TERMINALTOOLS__ := 1}

{$I+}
{$SETC TerminalToolsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __TERMINALS__}
{$I Terminals.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$IFC CALL_NOT_IN_CARBON }

CONST
	tdefType					= 'tdef';
	tvalType					= 'tval';
	tsetType					= 'tset';
	tlocType					= 'tloc';
	tscrType					= 'tscr';
	tbndType					= 'tbnd';
	tverType					= 'vers';

																{  messages  }
	tmInitMsg					= 0;
	tmDisposeMsg				= 1;
	tmSuspendMsg				= 2;
	tmResumeMsg					= 3;
	tmMenuMsg					= 4;
	tmEventMsg					= 5;
	tmActivateMsg				= 6;
	tmDeactivateMsg				= 7;
	tmGetErrorStringMsg			= 8;
	tmIdleMsg					= 50;
	tmResetMsg					= 51;
	tmKeyMsg					= 100;
	tmStreamMsg					= 101;
	tmResizeMsg					= 102;
	tmUpdateMsg					= 103;
	tmClickMsg					= 104;
	tmGetSelectionMsg			= 105;
	tmSetSelectionMsg			= 106;
	tmScrollMsg					= 107;
	tmClearMsg					= 108;
	tmGetLineMsg				= 109;
	tmPaintMsg					= 110;
	tmCursorMsg					= 111;
	tmGetEnvironsMsg			= 112;
	tmDoTermKeyMsg				= 113;
	tmCountTermKeysMsg			= 114;
	tmGetIndTermKeyMsg			= 115;

																{  messages for validate DefProc     }
	tmValidateMsg				= 0;
	tmDefaultMsg				= 1;

																{  messages for Setup DefProc     }
	tmSpreflightMsg				= 0;
	tmSsetupMsg					= 1;
	tmSitemMsg					= 2;
	tmSfilterMsg				= 3;
	tmScleanupMsg				= 4;

																{  messages for scripting defProc     }
	tmMgetMsg					= 0;
	tmMsetMsg					= 1;

																{  messages for localization defProc   }
	tmL2English					= 0;
	tmL2Intl					= 1;


TYPE
	TMSearchBlockPtr = ^TMSearchBlock;
	TMSearchBlock = RECORD
		theString:				StringHandle;
		where:					Rect;
		searchType:				TMSearchTypes;
		callBack:				TerminalSearchCallBackUPP;
		refnum:					INTEGER;
		next:					TMSearchBlockPtr;
	END;

	TMSetupStructPtr = ^TMSetupStruct;
	TMSetupStruct = RECORD
		theDialog:				DialogRef;
		count:					INTEGER;
		theConfig:				Ptr;
		procID:					INTEGER;								{  procID of the tool  }
	END;

	TMSetupPtr							= ^TMSetupStruct;
{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TerminalToolsIncludes}

{$ENDC} {__TERMINALTOOLS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
