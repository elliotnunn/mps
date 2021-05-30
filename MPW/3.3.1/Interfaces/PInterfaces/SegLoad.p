{
	File:		SegLoad.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
    UNIT SegLoad;
    INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingSegLoad}
{$SETC UsingSegLoad := 1}

{$I+}
{$SETC SegLoadIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$SETC UsingIncludes := SegLoadIncludes}

CONST
appOpen = 0;            {Open the Document (s)}
appPrint = 1;           {Print the Document (s)}

TYPE
AppFile = RECORD
    vRefNum: INTEGER;
    fType: OSType;
    versNum: INTEGER;   {versNum in high byte}
    fName: Str255;
    END;


PROCEDURE UnloadSeg(routineAddr: Ptr);
    INLINE $A9F1;
PROCEDURE ExitToShell;
    INLINE $A9F4;
PROCEDURE GetAppParms(VAR apName: Str255;VAR apRefNum: INTEGER;VAR apParam: Handle);
    INLINE $A9F5;
PROCEDURE CountAppFiles(VAR message: INTEGER;VAR count: INTEGER);
PROCEDURE GetAppFiles(index: INTEGER;VAR theFile: AppFile);
PROCEDURE ClrAppFiles(index: INTEGER);


{$ENDC}    { UsingSegLoad }

{$IFC NOT UsingIncludes}
    END.
{$ENDC}

