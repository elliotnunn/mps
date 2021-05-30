{
     File:       vectorOps.p
 
     Contains:   vector and matrix functions for AltiVec
 
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
 UNIT vectorOps;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __VECTOROPS__}
{$SETC __VECTOROPS__ := 1}

{$I+}
{$SETC vectorOpsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := vectorOpsIncludes}

{$ENDC} {__VECTOROPS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
