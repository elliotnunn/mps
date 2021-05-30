{
 	File:		Notification.p
 
 	Contains:	Notification Manager interfaces
 
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
 UNIT Notification;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __NOTIFICATION__}
{$SETC __NOTIFICATION__ := 1}

{$I+}
{$SETC NotificationIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}
{	MixedMode.p													}
{	Memory.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
	
TYPE
	NMRecPtr = ^NMRec;

	NMProcPtr = ProcPtr;  { PROCEDURE NM(nmReqPtr: NMRecPtr); }
	NMUPP = UniversalProcPtr;

	NMRec = RECORD
		qLink:					QElemPtr;								{ next queue entry}
		qType:					INTEGER;								{ queue type -- ORD(nmType) = 8}
		nmFlags:				INTEGER;								{ reserved}
		nmPrivate:				LONGINT;								{ reserved}
		nmReserved:				INTEGER;								{ reserved}
		nmMark:					INTEGER;								{ item to mark in Apple menu}
		nmIcon:					Handle;									{ handle to small icon}
		nmSound:				Handle;									{ handle to sound record}
		nmStr:					StringPtr;								{ string to appear in alert}
		nmResp:					NMUPP;									{ pointer to response routine}
		nmRefCon:				LONGINT;								{ for application use}
	END;

CONST
	uppNMProcInfo = $000000C0; { PROCEDURE (4 byte param); }

PROCEDURE CallNMProc(nmReqPtr: NMRecPtr; userRoutine: NMUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION NewNMProc(userRoutine: NMProcPtr): NMUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NMInstall(nmReqPtr: NMRecPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A05E, $3E80;
	{$ENDC}
FUNCTION NMRemove(nmReqPtr: NMRecPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A05F, $3E80;
	{$ENDC}
{ ------------------ }

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := NotificationIncludes}

{$ENDC} {__NOTIFICATION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
