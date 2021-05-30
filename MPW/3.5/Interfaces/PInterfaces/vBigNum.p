{
     File:       vBigNum.p
 
     Contains:   Algebraic and logical operations on large operands.
 
     Version:    Technology: 1.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT vBigNum;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __VBIGNUM__}
{$SETC __VBIGNUM__ := 1}

{$I+}
{$SETC vBigNumIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := vBigNumIncludes}

{$ENDC} {__VBIGNUM__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
