{
	MC68000Test.p
	Pascal Interface to routines to test to see if they are running on a MC68000 Processor

	Copyright Apple Computer, Inc. 1991, 1994
	All rights reserved

}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT MC68000Test;
	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingMC68000Test AND UNDEFINED __MC68000TEST__}
{$SETC UsingMC68000Test := 1}
{$SETC __MC68000TEST__ := 1}
 
(*
The following routines are provided to the outside caller to handle checking to see if
we are runing on the “proper” processor:

• To just do the check for the MC68000...

			FUNCTION onMC68000: Boolean; C;
			
• To do the check for MC68000 for MPW tools and to abort with an error message to stderr
	if we're on a MC68000...

			PROCEDURE abortToolOnMC68000(exitCode: Integer); C;
			
• To do the check for MC68000 for MPW tools or applications and to abort with an alert
	dialog if we're on a MC68000...
	
			PROCEDURE abortOnMC68000; C;

If the machine is an MC68000, then abortToolOnMC68000() and abortOnMC68000() generate the
following message (appropriately formatted):

	“Sorry!  This program assumes an MC68020, MC68030, or MC68040 processor.  It cannot be
	 run on your MC68000 machine.”

There is a possible error condition where the processor cannot be determined using the
SysEnvirons() system trap (on systems older than 4.1).  In that case the following message
is generated:

	“Sorry! I cannot determine what processor you are running on!  Since this program assumes
	 you are running on an MC68020, MC68030, or MC68040, I am going to assume you have an
	 MC68000 so it cannot be run on your machine.”

Roughly, the cose of using abortToolOnMC68000() is about 750 bytes and abortOnMC68000()
is about 1000 bytes.  By contrast, onMC68000, which doesn't really do much of anything
costs about 100 bytes.

Note: these routines live in their own private segment, MC68000Test.  The caller might
want to do an UnloadSeg() on return since these routines would normally only be called
once or you may want to resegment these routines to be part of your initialization code.
They were segmented seperately to allow easy unloading or resegmenting.
*)

FUNCTION onMC68000: Boolean; C;
	(*
	This routine returns true if we are currently running on an MC68000 and false otherwise.
	It is provided for convenience for those callers who wish to take some more appropriate
	actions based on the processor (other than just aborting with a canned error message).
	*)


PROCEDURE abortToolOnMC68000(exitCode: Integer); C;
	(*
	This routine aborts a MPW Shell tool if it's running on an MC68000 processor.  It is
	assumed that we are being called by an MPW Shell tool.  It writes a message to stderr and
	aborts the tool if we are on a MC68000.  The tool exit status code is specified by the
	caller (in exitCode).  If 0 is specified, 1 will be used.
	
	If we are NOT on a MC68000, the routine simply returns to allow running of the tool.
	*)


PROCEDURE abortOnMC68000; C;
	(*
	This routine aborts the calling program if it's running on an MC68000 processor.  The
	caller can be either an MPW Shell tool OR a standard Mac application.  It displays a
	message in an alert dialog and aborts if we are on a MC68000.  
	*)

{$ENDC}    { UsingMC68000Test }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}