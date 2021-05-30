{
	File:		OSEvents.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OSEvents;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingOSEvents}
{$SETC UsingOSEvents := 1}

{$I+}
{$SETC OSEventsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingEvents}
{$I $$Shell(PInterfaces)Events.p}
{$ENDC}
{$SETC UsingIncludes := OSEventsIncludes}


{$ENDC} { UsingOSEvents }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

