{
 	File:		Retrace.p
 
 	Contains:	Vertical Retrace Interfaces.
 
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
 UNIT Retrace;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __RETRACE__}
{$SETC __RETRACE__ := 1}

{$I+}
{$SETC RetraceIncludes := UsingIncludes}
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
	VBLTaskPtr = ^VBLTask;

	{
		VBLProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => vblTaskPtr  	A0.L
	}
	VBLProcPtr = Register68kProcPtr;  { register PROCEDURE VBL(vblTaskPtr: VBLTaskPtr); }
	VBLUPP = UniversalProcPtr;

	VBLTask = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		vblAddr:				VBLUPP;
		vblCount:				INTEGER;
		vblPhase:				INTEGER;
	END;

CONST
	uppVBLProcInfo = $00009802; { Register PROCEDURE (4 bytes in A0); }

FUNCTION NewVBLProc(userRoutine: VBLProcPtr): VBLUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallVBLProc(vblTaskPtr: VBLTaskPtr; userRoutine: VBLUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

FUNCTION GetVBLQHdr: QHdrPtr;
	{$IFC NOT GENERATINGCFM}
	INLINE $2EBC, $0000, $0160;
	{$ENDC}
FUNCTION SlotVInstall(vblBlockPtr: QElemPtr; theSlot: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $205F, $A06F, $3E80;
	{$ENDC}
FUNCTION SlotVRemove(vblBlockPtr: QElemPtr; theSlot: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $205F, $A070, $3E80;
	{$ENDC}
FUNCTION AttachVBL(theSlot: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $A071, $3E80;
	{$ENDC}
FUNCTION DoVBLTask(theSlot: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $A072, $3E80;
	{$ENDC}
FUNCTION VInstall(vblTaskPtr: QElemPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A033, $3E80;
	{$ENDC}
FUNCTION VRemove(vblTaskPtr: QElemPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A034, $3E80;
	{$ENDC}
{}
{ Custom Glue for 68k.}
{}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := RetraceIncludes}

{$ENDC} {__RETRACE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
