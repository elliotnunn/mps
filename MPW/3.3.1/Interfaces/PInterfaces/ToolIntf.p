{
	File:		ToolIntf.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT ToolIntf;
	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingToolIntf}
{$SETC UsingToolIntf := 1}

{$I+}
{$SETC ToolIntfIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingEvents}
{$I $$Shell(PInterfaces)Events.p}
{$ENDC}
{$IFC UNDEFINED UsingControls}
{$I $$Shell(PInterfaces)Controls.p}
{$ENDC}
{$IFC UNDEFINED UsingDesk}
{$I $$Shell(PInterfaces)Desk.p}
{$ENDC}
{$IFC UNDEFINED UsingWindows}
{$I $$Shell(PInterfaces)Windows.p}
{$ENDC}
{$IFC UNDEFINED UsingTextEdit}
{$I $$Shell(PInterfaces)TextEdit.p}
{$ENDC}
{$IFC UNDEFINED UsingDialogs}
{$I $$Shell(PInterfaces)Dialogs.p}
{$ENDC}
{$IFC UNDEFINED UsingFonts}
{$I $$Shell(PInterfaces)Fonts.p}
{$ENDC}
{$IFC UNDEFINED UsingLists}
{$I $$Shell(PInterfaces)Lists.p}
{$ENDC}
{$IFC UNDEFINED UsingMenus}
{$I $$Shell(PInterfaces)Menus.p}
{$ENDC}
{$IFC UNDEFINED UsingResources}
{$I $$Shell(PInterfaces)Resources.p}
{$ENDC}
{$IFC UNDEFINED UsingScrap}
{$I $$Shell(PInterfaces)Scrap.p}
{$ENDC}
{$IFC UNDEFINED UsingToolUtils}
{$I $$Shell(PInterfaces)ToolUtils.p}
{$ENDC}
{$SETC UsingIncludes := ToolIntfIncludes}

{$ENDC}    { UsingToolIntf }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}

