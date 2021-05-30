{
 	File:		ConnectionTools.p
 
 	Contains:	Communications Toolbox Connection Tools Interfaces.
 
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
 UNIT ConnectionTools;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CONNECTIONTOOLS__}
{$SETC __CONNECTIONTOOLS__ := 1}

{$I+}
{$SETC ConnectionToolsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __WINDOWS__}
{$I Windows.p}
{$ENDC}
{	Types.p														}
{		ConditionalMacros.p										}
{	Memory.p													}
{		MixedMode.p												}
{	Quickdraw.p													}
{		QuickdrawText.p											}
{	Events.p													}
{		OSUtils.p												}
{	Controls.p													}
{		Menus.p													}

{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{	Errors.p													}
{	TextEdit.p													}

{$IFC UNDEFINED __CONNECTIONS__}
{$I Connections.p}
{$ENDC}
{	CTBUtilities.p												}
{		StandardFile.p											}
{			Files.p												}
{				Finder.p										}
{		AppleTalk.p												}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
{ messages for DefProc }
	cmInitMsg					= 0;
	cmDisposeMsg				= 1;
	cmSuspendMsg				= 2;
	cmResumeMsg					= 3;
	cmMenuMsg					= 4;
	cmEventMsg					= 5;
	cmActivateMsg				= 6;
	cmDeactivateMsg				= 7;
	cmIdleMsg					= 50;
	cmResetMsg					= 51;
	cmAbortMsg					= 52;
	cmReadMsg					= 100;
	cmWriteMsg					= 101;
	cmStatusMsg					= 102;
	cmListenMsg					= 103;
	cmAcceptMsg					= 104;
	cmCloseMsg					= 105;
	cmOpenMsg					= 106;
	cmBreakMsg					= 107;
	cmIOKillMsg					= 108;
	cmEnvironsMsg				= 109;
{ new connection tool messages for ctb 1.1 }
	cmNewIOPBMsg				= 110;
	cmDisposeIOPBMsg			= 111;
	cmGetErrorStringMsg			= 112;
	cmPBReadMsg					= 113;
	cmPBWriteMsg				= 114;
	cmPBIOKillMsg				= 115;
{	messages for validate DefProc	}
	cmValidateMsg				= 0;
	cmDefaultMsg				= 1;
{	messages for Setup DefProc	}
	cmSpreflightMsg				= 0;
	cmSsetupMsg					= 1;
	cmSitemMsg					= 2;
	cmSfilterMsg				= 3;
	cmScleanupMsg				= 4;
{	messages for scripting defProc	}
	cmMgetMsg					= 0;
	cmMsetMsg					= 1;
{	messages for localization defProc	}
	cmL2English					= 0;
	cmL2Intl					= 1;

{ private data constants }
	cdefType					= 'cdef';						{ main connection definition procedure }
	cvalType					= 'cval';						{ validation definition procedure }
	csetType					= 'cset';						{ connection setup definition procedure }
	clocType					= 'cloc';						{ connection configuration localization defProc }
	cscrType					= 'cscr';						{ connection scripting defProc interfaces }
	cbndType					= 'cbnd';						{ bundle type for connection }
	cverType					= 'vers';


TYPE
	CMDataBuffer = RECORD
		thePtr:					Ptr;
		count:					LONGINT;
		channel:				CMChannel;
		flags:					CMFlags;
	END;

	CMDataBufferPtr = ^CMDataBuffer;

	CMCompletorRecord = RECORD
		async:					BOOLEAN;
		completionRoutine:		ConnectionCompletionUPP;
	END;

	CMCompletorPtr = ^CMCompletorRecord;

{	Private Data Structure	}
	CMSetupStruct = RECORD
		theDialog:				DialogPtr;
		count:					INTEGER;
		theConfig:				Ptr;
		procID:					INTEGER;								{ procID of the tool	}
	END;

	CMSetupPtr = ^CMSetupStruct;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ConnectionToolsIncludes}

{$ENDC} {__CONNECTIONTOOLS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
