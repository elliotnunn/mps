/*
     File:       Types.h
 
     Contains:   Basic Macintosh data types.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
/*
    NOTE
    
    The file "Types.h" has been renamed to "MacTypes.h" to prevent a collision
    with the "Types.h" available on other platforms.  MacOS only developers may 
    continue to use #include <Types.h>.  Developers doing cross-platform work where 
    Types.h also exists should change their sources to use #include <MacTypes.h>
*/


#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif


#if TARGET_OS_MAC
#ifndef __MACTYPES__
#include <MacTypes.h>
#endif

#else
/*
    If you get here, your development environment is messed up.
    This file is for MacOS development only.
*/
#error This file (Types.h) is for developing MacOS software only!
#endif  /* TARGET_OS_MAC */

