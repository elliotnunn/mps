{
 	File:		GXMessages.p
 
 	Contains:	This file contains all of the public data structures,
 
 	Version:	Technology:	Quickdraw GX 1.1
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
 UNIT GXMessages;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __GXMESSAGES__}
{$SETC __GXMESSAGES__ := 1}

{$I+}
{$SETC GXMessagesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}

{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{	Types.p														}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
{

	>>>>>> CONSTANTS <<<<<<

}
{ Message Manager Trap }

CONST
	messageManagerTrap			= $ABFB;

{ Message Manager Gestalt Selector }
	gestaltMessageMgrVersion	= 'mess';

{ Message Manager Error Result Codes }
	messageStopLoopingErr		= -5775;
	cantDeleteRunningHandlerErr	= -5776;
	noMessageTableErr			= -5777;
	dupSignatureErr				= -5778;
	messageNotReceivedErr		= -5799;

TYPE
	MessageGlobalsInitProcPtr = ProcPtr;  { PROCEDURE MessageGlobalsInit(messageGlobals: UNIV Ptr); }
	MessageGlobalsInitUPP = UniversalProcPtr;

CONST
	uppMessageGlobalsInitProcInfo = $000000C1; { PROCEDURE (4 byte param); }

FUNCTION NewMessageGlobalsInitProc(userRoutine: MessageGlobalsInitProcPtr): MessageGlobalsInitUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallMessageGlobalsInitProc(messageGlobals: UNIV Ptr; userRoutine: MessageGlobalsInitUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	MessageGlobalsInitProc = MessageGlobalsInitUPP;

{

	PUBLIC INTERFACES

	Message Handler API Routines
}

FUNCTION CountMessageHandlerInstances: LONGINT; C;
FUNCTION GetMessageHandlerClassContext: Ptr; C;
FUNCTION SetMessageHandlerClassContext(anyValue: UNIV Ptr): Ptr; C;
FUNCTION GetMessageHandlerInstanceContext: Ptr; C;
FUNCTION SetMessageHandlerInstanceContext(anyValue: UNIV Ptr): Ptr; C;
FUNCTION NewMessageGlobals(messageGlobalsSize: LONGINT; initProc: MessageGlobalsInitUPP): OSErr; C;
PROCEDURE DisposeMessageGlobals; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := GXMessagesIncludes}

{$ENDC} {__GXMESSAGES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
