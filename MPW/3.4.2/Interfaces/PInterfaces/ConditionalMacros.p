{
 	File:		ConditionalMacros.p
 
 	Contains:	Compile time feature switches to achieve platform independent sources.
 
 	Version:	Technology:	Universal Interface Files 2.1
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
 UNIT ConditionalMacros;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$SETC __CONDITIONALMACROS__ := 1}

{$I+}
{$SETC ConditionalMacrosIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{

	Set up UNIVERSAL_INTERFACES_VERSION
	
		0x210 => version 2.1
		This conditional did not exist prior to version 2.1
}
{$SETC UNIVERSAL_INTERFACES_VERSION := $0210}

{***************************************************************************************************
	
	GENERATINGPOWERPC		- Compiler is generating PowerPC instructions
	GENERATING68K			- Compiler is generating 68k family instructions

		Invariant:
			GENERATINGPOWERPC != GENERATING68K
			
***************************************************************************************************}
{$IFC NOT UNDEFINED GENERATINGPOWERPC }
  {$IFC UNDEFINED GENERATING68K }
    {$SETC GENERATING68K := NOT GENERATINGPOWERPC }
  {$ENDC}
{$ENDC}

{$IFC NOT UNDEFINED GENERATING68K }
  {$IFC UNDEFINED GENERATINGPOWERPC }
    {$SETC GENERATINGPOWERPC := NOT GENERATING68K }
  {$ENDC}
{$ENDC}

{$IFC UNDEFINED GENERATINGPOWERPC }
  {$IFC NOT UNDEFINED MWERKS }
    {$SETC GENERATINGPOWERPC := POWERPC }
  {$ELSEC}
    {$IFC NOT UNDEFINED LSPWRP }
      {$SETC GENERATINGPOWERPC := 1 }
    {$ELSEC}
      {$SETC GENERATINGPOWERPC := 0 }
    {$ENDC}
  {$ENDC}
{$ENDC}

{$IFC UNDEFINED GENERATING68K }
    {$SETC GENERATING68K := NOT GENERATINGPOWERPC }
{$ENDC}
{***************************************************************************************************
	
	GENERATING68881			- Compiler is generating mc68881 floating point instructions
	
		Invariant:
			GENERATING68881 => GENERATING68K
			
***************************************************************************************************}
{$IFC GENERATING68K AND OPTION(mc68881) }
{$SETC GENERATING68881 := 1 }
{$ENDC}
{$IFC UNDEFINED GENERATING68881 }
{$SETC GENERATING68881 := 0}
{$ENDC}
{***************************************************************************************************
	
	GENERATINGCFM			- Code being generated assumes CFM calling conventions
	CFMSYSTEMCALLS			- No A-traps.  Systems calls are made using CFM and UPP's

		Invariants:
			GENERATINGPOWERPC => GENERATINGCFM
			GENERATINGPOWERPC => CFMSYSTEMCALLS
			CFMSYSTEMCALLS => GENERATINGCFM
			
***************************************************************************************************}
{$SETC GENERATINGCFM := GENERATINGPOWERPC}
{$SETC CFMSYSTEMCALLS := GENERATINGPOWERPC}

{***************************************************************************************************
	
	SystemSevenFiveOrLater	- Compiled code will only be run on a System 7.5 or later Macintosh
	SystemSevenOrLater		- Compiled code will only be run on a System 7.0 or later Macintosh
	SystemSixOrLater		- Compiled code will only be run on a System 6.0 or later Macintosh
							  A developer should set the appropriate flag on the compiler command-
							  line or in a file processed before this file.  This will allow the
							  certain optimizations to be made which can result in smaller, faster
							  applications.


***************************************************************************************************}
{$IFC UNDEFINED SystemSevenFiveOrLater }
{$SETC SystemSevenFiveOrLater := 0}
{$ENDC}
{$IFC UNDEFINED SystemSevenOrLater }
 {$IFC GENERATINGCFM }
{$SETC SystemSevenOrLater := 1}
 {$ELSEC}
{$SETC SystemSevenOrLater := SystemSevenFiveOrLater}
 {$ENDC}
{$ENDC}
{$IFC UNDEFINED SystemSixOrLater }
{$SETC SystemSixOrLater := SystemSevenOrLater}
{$ENDC}
{***************************************************************************************************

	OLDROUTINENAMES			- "Old" names for Macintosh system calls are allowed in source code.
							  (e.g. DisposPtr instead of DisposePtr). The names of system routine
							  are now more sensitive to change because CFM binds by name.  In the 
							  past, system routine names were compiled out to just an A-Trap.  
							  Macros have been added that each map an old name to its new name.  
							  This allows old routine names to be used in existing source files,
							  but the macros only work if OLDROUTINENAMES is true.  This support
							  will be removed in the near future.  Thus, all source code should 
							  be changed to use the new names! You can set OLDROUTINENAMES to false
							  to see if your code has any old names left in it.
	
	OLDROUTINELOCATIONS     - "Old" location of Macintosh system calls are used.  For example, c2pstr 
							  has been moved from Strings to TextUtils.  It is conditionalized in
							  Strings with OLDROUTINELOCATIONS and in TextUtils with !OLDROUTINELOCATIONS.
							  This allows developers to upgrade to newer interface files without suddenly
							  all their code not compiling becuase of "incorrect" includes.  But, it
							  allows the slow migration of system calls to more understandable file
							  locations.  OLDROUTINELOCATIONS currently defaults to true, but eventually
							  will default to false.

***************************************************************************************************}
{$IFC UNDEFINED OLDROUTINENAMES }
{$SETC OLDROUTINENAMES := 1}
{$ENDC}
{$IFC UNDEFINED OLDROUTINELOCATIONS }
{$SETC OLDROUTINELOCATIONS := 1}
{$ENDC}

{$SETC UsingIncludes := ConditionalMacrosIncludes}

{$ENDC} {__CONDITIONALMACROS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
