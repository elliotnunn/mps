{
     File:       CGBase.p
 
     Contains:   xxx put contents here xxx
 
     Version:    Technology: from CoreGraphics-70.root
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CGBase;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CGBASE__}
{$SETC __CGBASE__ := 1}

{$I+}
{$SETC CGBaseIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	size_t								= UInt32;
	int32_t								= SInt32;
	{	 define some unix types used by CoreGraphics 	}
	boolean_t							= LONGINT;
	u_int8_t							= UInt8;
	u_int16_t							= UInt16;
	u_int32_t							= UInt32;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CGBaseIncludes}

{$ENDC} {__CGBASE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
