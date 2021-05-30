{
     File:       Packages.p
 
     Contains:   Package Manager Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Packages;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PACKAGES__}
{$SETC __PACKAGES__ := 1}

{$I+}
{$SETC PackagesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	listMgr						= 0;							{  list manager  }
	dskInit						= 2;							{  Disk Initializaton  }
	stdFile						= 3;							{  Standard File  }
	flPoint						= 4;							{  Floating-Point Arithmetic  }
	trFunc						= 5;							{  Transcendental Functions  }
	intUtil						= 6;							{  International Utilities  }
	bdConv						= 7;							{  Binary/Decimal Conversion  }
	editionMgr					= 11;							{  Edition Manager  }

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  InitPack()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE InitPack(packID: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9E5;
	{$ENDC}

{
 *  InitAllPacks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InitAllPacks;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9E6;
	{$ENDC}


{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PackagesIncludes}

{$ENDC} {__PACKAGES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
