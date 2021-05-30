{
	File:		PickerIntf.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT PickerIntf;
	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingPickerIntf}
{$SETC UsingPickerIntf := 1}

{$I+}
{$SETC PickerIntfIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingPicker}
{$I $$Shell(PInterfaces)Picker.p}
{$ENDC}
{$SETC UsingIncludes := PickerIntfIncludes}

{$ENDC}    { UsingPickerIntf }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}

