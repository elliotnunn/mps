{
Created: Tuesday, August 2, 1988 at 10:06 AM
    Retrace.p
    Pascal Interface to the Macintosh Libraries

    Copyright Apple Computer, Inc.  1985-1988
    All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
    UNIT Retrace;
    INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingRetrace}
{$SETC UsingRetrace := 1}

{$I+}
{$SETC RetraceIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$IFC UNDEFINED UsingOSUtils}
{$I $$Shell(PInterfaces)OSUtils.p}
{$ENDC}
{$SETC UsingIncludes := RetraceIncludes}

{TYPE}


FUNCTION GetVBLQHdr: QHdrPtr;
FUNCTION SlotVInstall(vblBlockPtr: QElemPtr;theSlot: INTEGER): OSErr;
FUNCTION SlotVRemove(vblBlockPtr: QElemPtr;theSlot: INTEGER): OSErr;
FUNCTION AttachVBL(theSlot: INTEGER): OSErr;
FUNCTION DoVBLTask(theSlot: INTEGER): OSErr;
FUNCTION VInstall(vblTaskPtr: QElemPtr): OSErr;
FUNCTION VRemove(vblTaskPtr: QElemPtr): OSErr;

{$ENDC}    { UsingRetrace }

{$IFC NOT UsingIncludes}
    END.
{$ENDC}

