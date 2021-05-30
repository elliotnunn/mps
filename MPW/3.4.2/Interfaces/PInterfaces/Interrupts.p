{
 	File:		Interrupts.p
 
 	Contains:	Interface to the Interrupt Manager
 
 	Version:	Technology:	PowerSurge 1.0.2
 				Package:	Universal Interfaces 2.1.4
 
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
 UNIT Interrupts;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __INTERRUPTS__}
{$SETC __INTERRUPTS__ := 1}

{$I+}
{$SETC InterruptsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{   Interrupt types   }

TYPE
	InterruptSetID = ^LONGINT;
	InterruptMemberNumber				= LONGINT;
	InterruptSetMemberPtr = ^InterruptSetMember;
	InterruptSetMember = RECORD
		setID:					InterruptSetID;
		member:					InterruptMemberNumber;
	END;


CONST
	kISTChipInterruptSource		= 0;
	kISTOutputDMAInterruptSource = 1;
	kISTInputDMAInterruptSource	= 2;
	kISTPropertyMemberCount		= 3;


TYPE
	ISTProperty							= ARRAY [0..2] OF InterruptSetMember;
	InterruptReturnValue				= LONGINT;

CONST
	kFirstMemberNumber			= 1;
	kIsrIsComplete				= 0;
	kIsrIsNotComplete			= -1;
	kMemberNumberParent			= -2;


TYPE
	InterruptSourceState				= BOOLEAN;

CONST
	kSourceWasEnabled			= 1;
	kSourceWasDisabled			= 0;


TYPE
	InterruptHandler = ProcPtr;  { FUNCTION InterruptHandler(ISTmember: InterruptSetMember; refCon: UNIV Ptr; theIntCount: UInt32): InterruptMemberNumber; C; }

	InterruptEnabler = ProcPtr;  { PROCEDURE InterruptEnabler(ISTmember: InterruptSetMember; refCon: UNIV Ptr); C; }

	InterruptDisabler = ProcPtr;  { FUNCTION InterruptDisabler(ISTmember: InterruptSetMember; refCon: UNIV Ptr): ByteParameter; C; }


CONST
	kReturnToParentWhenComplete	= $00000001;
	kReturnToParentWhenNotComplete = $00000002;


TYPE
	InterruptSetOptions					= OptionBits;
	
{   Interrupt Services   }
FUNCTION CreateInterruptSet(parentSet: InterruptSetID; parentMember: InterruptMemberNumber; setSize: InterruptMemberNumber; VAR setID: InterruptSetID; options: InterruptSetOptions): OSStatus; C;
FUNCTION InstallInterruptFunctions(setID: InterruptSetID; member: InterruptMemberNumber; refCon: UNIV Ptr; handlerFunction: InterruptHandler; enableFunction: InterruptEnabler; disableFunction: InterruptDisabler): OSStatus; C;
FUNCTION GetInterruptFunctions(setID: InterruptSetID; member: InterruptMemberNumber; VAR refCon: UNIV Ptr; VAR handlerFunction: InterruptHandler; VAR enableFunction: InterruptEnabler; VAR disableFunction: InterruptDisabler): OSStatus; C;
FUNCTION ChangeInterruptSetOptions(setID: InterruptSetID; options: InterruptSetOptions): OSStatus; C;
FUNCTION GetInterruptSetOptions(setID: InterruptSetID; VAR options: InterruptSetOptions): OSStatus; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := InterruptsIncludes}

{$ENDC} {__INTERRUPTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
