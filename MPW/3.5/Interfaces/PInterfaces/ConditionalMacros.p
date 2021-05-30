{
     File:       ConditionalMacros.p
 
     Contains:   Set up for compiler independent conditionals
 
     Version:    Technology: Universal Interface Files
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1993-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{***************************************************************************************************
    UNIVERSAL_INTERFACES_VERSION
    
        0x0400 --> version 4.0 (Mac OS X only)
        0x0335 --> version 3.4 
        0x0331 --> version 3.3.1
        0x0330 --> version 3.3
        0x0320 --> version 3.2
        0x0310 --> version 3.1
        0x0301 --> version 3.0.1
        0x0300 --> version 3.0
        0x0210 --> version 2.1
        This conditional did not exist prior to version 2.1
***************************************************************************************************}
{$SETC UNIVERSAL_INTERFACES_VERSION := $0340}


{***************************************************************************************************

    TARGET_CPU_≈    
    These conditionals specify which microprocessor instruction set is being
    generated.  At most one of these is true, the rest are false.

        TARGET_CPU_PPC          - Compiler is generating PowerPC instructions
        TARGET_CPU_68K          - Compiler is generating 680x0 instructions
        TARGET_CPU_X86          - Compiler is generating x86 instructions
        TARGET_CPU_MIPS         - Compiler is generating MIPS instructions
        TARGET_CPU_SPARC        - Compiler is generating Sparc instructions
        TARGET_CPU_ALPHA        - Compiler is generating Dec Alpha instructions


    TARGET_OS_≈ 
    These conditionals specify in which Operating System the generated code will
    run. At most one of the these is true, the rest are false.

        TARGET_OS_MAC           - Generate code will run under Mac OS
        TARGET_OS_WIN32         - Generate code will run under 32-bit Windows
        TARGET_OS_UNIX          - Generate code will run under some unix 


    TARGET_RT_≈ 
    These conditionals specify in which runtime the generated code will
    run. This is needed when the OS and CPU support more than one runtime
    (e.g. MacOS on 68K supports CFM68K and Classic 68k).

        TARGET_RT_LITTLE_ENDIAN - Generated code uses little endian format for integers
        TARGET_RT_BIG_ENDIAN    - Generated code uses big endian format for integers    
        TARGET_RT_MAC_CFM       - TARGET_OS_MAC is true and CFM68K or PowerPC CFM (TVectors) are used
        TARGET_RT_MAC_MACHO     - TARGET_OS_MAC is true and Mach-O style runtime
        TARGET_RT_MAC_68881     - TARGET_OS_MAC is true and 68881 floating point instructions used  


    TARGET__API_≈_≈ 
    These conditionals are used to differentiate between sets of API's on the same
    processor under the same OS.  The first section after _API_ is the OS.  The
    second section is the API set.  Unlike TARGET_OS_ and TARGET_CPU_, these
    conditionals are not mutally exclusive. This file will attempt to auto-configure
    all TARGET_API_≈_≈ values, but will often need a TARGET_API_≈_≈ value predefined
    in order to disambiguate.
    
        TARGET_API_MAC_OS8      - Code is being compiled to run on System 7 through Mac OS 8.x
        TARGET_API_MAC_CARBON   - Code is being compiled to run on Mac OS 8 and Mac OS X via CarbonLib
        TARGET_API_MAC_OSX      - Code is being compiled to run on Mac OS X


    PRAGMA_≈
    These conditionals specify whether the compiler supports particular #pragma's
    
        PRAGMA_IMPORT           - Compiler supports: #pragma import on/off/reset
        PRAGMA_ONCE             - Compiler supports: #pragma once
        PRAGMA_STRUCT_ALIGN     - Compiler supports: #pragma options align=mac68k/power/reset
        PRAGMA_STRUCT_PACK      - Compiler supports: #pragma pack(n)
        PRAGMA_STRUCT_PACKPUSH  - Compiler supports: #pragma pack(push, n)/pack(pop)
        PRAGMA_ENUM_PACK        - Compiler supports: #pragma options(!pack_enums)
        PRAGMA_ENUM_ALWAYSINT   - Compiler supports: #pragma enumsalwaysint on/off/reset
        PRAGMA_ENUM_OPTIONS     - Compiler supports: #pragma options enum=int/small/reset


    FOUR_CHAR_CODE
    This conditional does the proper byte swapping to assue that a four character code (e.g. 'TEXT')
    is compiled down to the correct value on all compilers.

        FOUR_CHAR_CODE('abcd')  - Convert a four-char-code to the correct 32-bit value


    TYPE_≈
    These conditionals specify whether the compiler supports particular types.

        TYPE_LONGLONG               - Compiler supports "long long" 64-bit integers
        TYPE_BOOL                   - Compiler supports "bool"
        TYPE_EXTENDED               - Compiler supports "extended" 80/96 bit floating point
        TYPE_LONGDOUBLE_IS_DOUBLE   - Compiler implements "long double" same as "double"


    FUNCTION_≈
    These conditionals specify whether the compiler supports particular language extensions
    to function prototypes and definitions.

        FUNCTION_PASCAL         - Compiler supports "pascal void Foo()"
        FUNCTION_DECLSPEC       - Compiler supports "__declspec(xxx) void Foo()"
        FUNCTION_WIN32CC        - Compiler supports "void __cdecl Foo()" and "void __stdcall Foo()"

***************************************************************************************************}

{$IFC NOT UNDEFINED MWERKS}
    {
        CodeWarrior Pascal compiler from Metrowerks, Inc.
    }
    {$IFC MAC68K}
        {$SETC TARGET_CPU_PPC           := FALSE}
        {$SETC TARGET_CPU_68K           := TRUE}
        {$SETC TARGET_CPU_X86           := FALSE}
        {$SETC TARGET_CPU_MIPS          := FALSE}
        {$SETC TARGET_CPU_SPARC         := FALSE}
        {$SETC TARGET_RT_MAC_CFM        := FALSE}
        {$SETC TARGET_RT_MAC_MACHO      := FALSE}
        {$SETC TARGET_RT_MAC_68881      := OPTION(mc68881)}
        {$SETC TARGET_OS_MAC            := TRUE}
        {$SETC TARGET_OS_WIN32          := FALSE}
        {$SETC TARGET_OS_UNIX           := FALSE}
        {$SETC TARGET_RT_LITTLE_ENDIAN  := FALSE}
        {$SETC TARGET_RT_BIG_ENDIAN     := TRUE}
    {$ELSEC}
        {$IFC POWERPC}
            {$SETC TARGET_CPU_PPC           := TRUE}
            {$SETC TARGET_CPU_68K           := FALSE}
            {$SETC TARGET_CPU_X86           := FALSE}
            {$SETC TARGET_CPU_MIPS          := FALSE}
            {$SETC TARGET_CPU_SPARC         := FALSE}
            {$SETC TARGET_RT_MAC_CFM        := TRUE}
            {$SETC TARGET_RT_MAC_MACHO      := FALSE}
            {$SETC TARGET_RT_MAC_68881      := FALSE}
            {$SETC TARGET_OS_MAC            := TRUE}
            {$SETC TARGET_OS_WIN32          := FALSE}
            {$SETC TARGET_OS_UNIX           := FALSE}
            {$SETC TARGET_RT_LITTLE_ENDIAN  := FALSE}
            {$SETC TARGET_RT_BIG_ENDIAN     := TRUE}
        {$ELSEC}
            {$IFC INTEL}
                {$SETC TARGET_CPU_PPC           := FALSE}
                {$SETC TARGET_CPU_68K           := FALSE}
                {$SETC TARGET_CPU_X86           := TRUE}
                {$SETC TARGET_CPU_MIPS          := FALSE}
                {$SETC TARGET_CPU_SPARC         := FALSE}
                {$SETC TARGET_OS_MAC            := FALSE}
                {$SETC TARGET_OS_WIN32          := TRUE}
                {$SETC TARGET_OS_UNIX           := FALSE}
                {$SETC TARGET_RT_LITTLE_ENDIAN  := TRUE}
                {$SETC TARGET_RT_BIG_ENDIAN     := FALSE}
            {$ELSEC}
                Error unknown compiler targer
            {$ENDC}
        {$ENDC}
    {$ENDC} 
    {$SETC TYPE_EXTENDED                := TRUE}
    {$SETC TYPE_LONGLONG                := FALSE}
    {$SETC TYPE_BOOL                    := FALSE}
    {$IFC UNDEFINED TYPED_FUNCTION_POINTERS}
        {$IFC MWERKS >= 190}
            {$SETC TYPED_FUNCTION_POINTERS  := PROCTYPE}
        {$ELSEC}
            {$SETC TYPED_FUNCTION_POINTERS  := 0}
        {$ENDC}
    {$ENDC} 
{$ELSEC} 


{$IFC NOT UNDEFINED THINK}
    {
        THINK Pascal compiler from Symantec, Inc.    << WARNING: Unsupported Compiler >>
    }
    {$SETC TARGET_CPU_68K               := 1}
    {$SETC TARGET_CPU_PPC               := 0}
    {$SETC TARGET_CPU_X86               := 0}
    {$SETC TARGET_CPU_MIPS              := 0}
    {$SETC TARGET_CPU_SPARC             := 0}
    {$SETC TARGET_RT_MAC_CFM            := 0}
    {$SETC TARGET_RT_MAC_MACHO          := 0}
    {$SETC TARGET_RT_MAC_68881          := OPTION(mc68881)}
    {$SETC TARGET_OS_MAC                := 1}
    {$SETC TARGET_OS_WIN32              := 0}
    {$SETC TARGET_OS_UNIX               := 0}
    {$SETC TARGET_RT_LITTLE_ENDIAN      := 0}
    {$SETC TARGET_RT_BIG_ENDIAN         := 1}
    {$SETC TYPE_EXTENDED                := 1}
    {$SETC TYPE_LONGLONG                := 0}
    {$SETC TYPE_BOOL                    := 0}
    {$SETC TYPED_FUNCTION_POINTERS      := 0}
{$ELSEC}


{$IFC NOT UNDEFINED __PPCPASCAL__}
    {
        LSPascal compiler from Language Systems  << WARNING: Unsupported Compiler >>
        
        Note: LSPascal doesn't have any predefined identifiers, so __PPCPASCAL__ must
        be defined on the command line with a '-d __PPCPASCAL=TRUE'.
    }
    {$SETC TARGET_CPU_PPC               := TRUE}
    {$SETC TARGET_CPU_68K               := FALSE}
    {$SETC TARGET_CPU_X86               := FALSE}
    {$SETC TARGET_CPU_MIPS              := FALSE}
    {$SETC TARGET_CPU_SPARC             := FALSE}
    {$SETC TARGET_RT_MAC_CFM            := TRUE}
    {$SETC TARGET_RT_MAC_MACHO          := FALSE}
    {$SETC TARGET_RT_MAC_68881          := FALSE}
    {$SETC TARGET_OS_MAC                := TRUE}
    {$SETC TARGET_OS_WIN32              := FALSE}
    {$SETC TARGET_OS_UNIX               := FALSE}
    {$SETC TARGET_RT_LITTLE_ENDIAN      := FALSE}
    {$SETC TARGET_RT_BIG_ENDIAN         := TRUE}
    {$SETC TYPE_EXTENDED                := TRUE}
    {$SETC TYPE_LONGLONG                := FALSE}
    {$SETC TYPE_BOOL                    := FALSE}
    {$SETC TYPED_FUNCTION_POINTERS      := 0}
{$ELSEC}


    {
        MPW Pascal compiler from Apple Computer, Inc.    << WARNING: Unsupported Compiler >>
    }
    {$SETC TARGET_CPU_68K               := 1}
    {$SETC TARGET_CPU_PPC               := 0}
    {$SETC TARGET_CPU_X86               := 0}
    {$SETC TARGET_CPU_MIPS              := 0}
    {$SETC TARGET_CPU_SPARC             := 0}
    {$SETC TARGET_RT_MAC_CFM            := 0}
    {$SETC TARGET_RT_MAC_MACHO          := 0}
    {$SETC TARGET_RT_MAC_68881          := OPTION(mc68881)}
    {$SETC TARGET_OS_MAC                := 1}
    {$SETC TARGET_OS_WIN32              := 0}
    {$SETC TARGET_OS_UNIX               := 0}
    {$SETC TARGET_RT_LITTLE_ENDIAN      := 0}
    {$SETC TARGET_RT_BIG_ENDIAN         := 1}
    {$SETC TYPE_EXTENDED                := 1}
    {$SETC TYPE_LONGLONG                := 0}
    {$SETC TYPE_BOOL                    := 0}
    {$SETC TYPED_FUNCTION_POINTERS      := 0}
{$ENDC}
{$ENDC}
{$ENDC}



{***************************************************************************************************
    
    Set up TARGET_API_≈_≈ values

***************************************************************************************************}
{$IFC TARGET_OS_MAC }
{$IFC NOT NOT UNDEFINED TARGET_API_MAC_OS8 AND NOT NOT UNDEFINED TARGET_API_MAC_OSX AND NOT NOT UNDEFINED TARGET_API_MAC_CARBON }
{$IFC TARGET_CPU_PPC AND TARGET_RT_MAC_CFM }
{ Looks like CFM style PPC compiler }
{$SETC TARGET_API_MAC_OS8 := 1 }
{$SETC TARGET_API_MAC_CARBON := 0 }
{$SETC TARGET_API_MAC_OSX := 0 }
{$ELSEC}
  {$IFC TARGET_RT_MAC_MACHO }
{ Looks like MachO style PPC compiler }
{$SETC TARGET_API_MAC_OS8 := 0 }
{$SETC TARGET_API_MAC_CARBON := 0 }
{$SETC TARGET_API_MAC_OSX := 1 }
  {$ELSEC}
{ 68k or some other compiler }
{$SETC TARGET_API_MAC_OS8 := 1 }
{$SETC TARGET_API_MAC_CARBON := 0 }
{$SETC TARGET_API_MAC_OSX := 0 }
  {$ENDC}
{$ENDC}
{$ELSEC}
{$IFC UNDEFINED TARGET_API_MAC_OS8 }
{$SETC TARGET_API_MAC_OS8 := 0 }
{$ENDC}
{$IFC UNDEFINED TARGET_API_MAC_OSX }
{$SETC TARGET_API_MAC_OSX := TARGET_RT_MAC_MACHO }
{$ENDC}
{$IFC UNDEFINED TARGET_API_MAC_CARBON }
{$SETC TARGET_API_MAC_CARBON := TARGET_API_MAC_OSX }
{$ENDC}
{$ENDC}
{$IFC TARGET_API_MAC_OS8 AND TARGET_API_MAC_OSX }
{$ENDC}
{$IFC NOT TARGET_API_MAC_OS8 AND NOT TARGET_API_MAC_CARBON AND NOT TARGET_API_MAC_OSX }
{$ENDC}
{$ELSEC}
{$SETC TARGET_API_MAC_OS8 := 0 }
{$SETC TARGET_API_MAC_CARBON := 0 }
{$SETC TARGET_API_MAC_OSX := 0 }
{$ENDC}  {TARGET_OS_MAC}

{ Support source code still using TARGET_CARBON }
{$IFC UNDEFINED TARGET_CARBON }
{$IFC TARGET_API_MAC_CARBON AND NOT TARGET_API_MAC_OS8 }
{$SETC TARGET_CARBON := 1 }
{$ELSEC}
{$SETC TARGET_CARBON := 0 }
{$ENDC}
{$ENDC}

{***************************************************************************************************
    Backward compatibility for clients expecting 2.x version on ConditionalMacros.h

    GENERATINGPOWERPC       - Compiler is generating PowerPC instructions
    GENERATING68K           - Compiler is generating 68k family instructions
    GENERATING68881         - Compiler is generating mc68881 floating point instructions
    GENERATINGCFM           - Code being generated assumes CFM calling conventions
    CFMSYSTEMCALLS          - No A-traps.  Systems calls are made using CFM and UPP's
    PRAGMA_ALIGN_SUPPORTED  - Compiler supports: #pragma options align=mac68k/power/reset
    PRAGMA_IMPORT_SUPPORTED - Compiler supports: #pragma import on/off/reset
    CGLUESUPPORTED          - Clients can use all lowercase toolbox functions that take C strings instead of pascal strings

***************************************************************************************************}
{$IFC NOT TARGET_API_MAC_CARBON }
{$SETC GENERATINGPOWERPC := TARGET_CPU_PPC }
{$SETC GENERATING68K := TARGET_CPU_68K }
{$SETC GENERATING68881 := TARGET_RT_MAC_68881 }
{$SETC GENERATINGCFM := TARGET_RT_MAC_CFM }
{$SETC CFMSYSTEMCALLS := TARGET_RT_MAC_CFM }
{$IFC UNDEFINED CGLUESUPPORTED }
{$SETC CGLUESUPPORTED := 0 }
{$ENDC}
{$IFC UNDEFINED OLDROUTINELOCATIONS }
{$SETC OLDROUTINELOCATIONS := 0 }
{$ENDC}
{$ELSEC}
{$ENDC}



{***************************************************************************************************

    OLDROUTINENAMES         - "Old" names for Macintosh system calls are allowed in source code.
                              (e.g. DisposPtr instead of DisposePtr). The names of system routine
                              are now more sensitive to change because CFM binds by name.  In the 
                              past, system routine names were compiled out to just an A-Trap.  
                              Macros have been added that each map an old name to its new name.  
                              This allows old routine names to be used in existing source files,
                              but the macros only work if OLDROUTINENAMES is true.  This support
                              will be removed in the near future.  Thus, all source code should 
                              be changed to use the new names! You can set OLDROUTINENAMES to false
                              to see if your code has any old names left in it.
    
***************************************************************************************************}
{$IFC UNDEFINED OLDROUTINENAMES }
{$SETC OLDROUTINENAMES := 0 }
{$ENDC}



{***************************************************************************************************

    TARGET_CARBON                   - default: false. Switches all of the above as described.  Overrides all others
                                    - NOTE: If you set TARGET_CARBON to 1, then the other switches will be setup by
                                            ConditionalMacros, and should not be set manually.

    If you wish to do development for pre-Carbon Systems, you can set the following:

    OPAQUE_TOOLBOX_STRUCTS          - default: false. True for Carbon builds, hides struct fields.
    OPAQUE_UPP_TYPES                - default: false. True for Carbon builds, UPP types are unique and opaque.
    ACCESSOR_CALLS_ARE_FUNCTIONS    - default: false. True for Carbon builds, enables accessor functions.
    CALL_NOT_IN_CARBON              - default: true.  False for Carbon builds, hides calls not supported in Carbon.
    
    Specifically, if you are building a non-Carbon application (one that links against InterfaceLib)
    but you wish to use some of the accessor functions, you can set ACCESSOR_CALLS_ARE_FUNCTIONS to 1
    and link with CarbonAccessors.o, which implements just the accessor functions. This will help you
    preserve source compatibility between your Carbon and non-Carbon application targets.
    
    MIXEDMODE_CALLS_ARE_FUNCTIONS   - deprecated.

***************************************************************************************************}
{$IFC TARGET_API_MAC_CARBON AND NOT TARGET_API_MAC_OS8 }
{$IFC UNDEFINED OPAQUE_TOOLBOX_STRUCTS }
{$SETC OPAQUE_TOOLBOX_STRUCTS := 1 }
{$ENDC}
{$IFC UNDEFINED OPAQUE_UPP_TYPES }
{$SETC OPAQUE_UPP_TYPES := 1 }
{$ENDC}
{$IFC UNDEFINED ACCESSOR_CALLS_ARE_FUNCTIONS }
{$SETC ACCESSOR_CALLS_ARE_FUNCTIONS := 1 }
{$ENDC}
{$IFC UNDEFINED CALL_NOT_IN_CARBON }
{$SETC CALL_NOT_IN_CARBON := 0 }
{$ENDC}
{$IFC UNDEFINED MIXEDMODE_CALLS_ARE_FUNCTIONS }
{$SETC MIXEDMODE_CALLS_ARE_FUNCTIONS := 1 }
{$ENDC}
{$ELSEC}
{$IFC UNDEFINED OPAQUE_TOOLBOX_STRUCTS }
{$SETC OPAQUE_TOOLBOX_STRUCTS := 0 }
{$ENDC}
{$IFC UNDEFINED OPAQUE_UPP_TYPES }
{$SETC OPAQUE_UPP_TYPES := 0 }
{$ENDC}
{$IFC UNDEFINED ACCESSOR_CALLS_ARE_FUNCTIONS }
{$SETC ACCESSOR_CALLS_ARE_FUNCTIONS := 0 }
{$ENDC}
{
     * It's possible to have ACCESSOR_CALLS_ARE_FUNCTIONS set to true and OPAQUE_TOOLBOX_STRUCTS
     * set to false, but not the other way around, so make sure the defines are not set this way.
     }
{$IFC OPAQUE_TOOLBOX_STRUCTS AND NOT ACCESSOR_CALLS_ARE_FUNCTIONS }
{$ENDC}
{$IFC UNDEFINED CALL_NOT_IN_CARBON }
{$SETC CALL_NOT_IN_CARBON := 1 }
{$ENDC}
{$IFC UNDEFINED MIXEDMODE_CALLS_ARE_FUNCTIONS }
{$SETC MIXEDMODE_CALLS_ARE_FUNCTIONS := 0 }
{$ENDC}
{$ENDC}



{$SETC UsingIncludes := ConditionalMacrosIncludes}

{$ENDC} {__CONDITIONALMACROS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
