/*
     File:       Errors.h
 
     Contains:   OSErr codes.
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
/*
    NOTE
    
    The file "Errors.h" has been renamed to "MacErrors.h" to prevent a collision
    with the "Errors.h" available on other platforms.  MacOS only developers may 
    continue to use #include <Errors.h>.  Developers doing cross-platform work where 
    Errors.h also exists should change their sources to use #include <MacErrors.h>
*/


#ifndef __ERRORS__
#define __ERRORS__

#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif


#if TARGET_OS_MAC
#ifndef __MACERRORS__
#include <MacErrors.h>
#endif

#else
/*
    If you get here, your development environment is messed up.
    This file is for MacOS development only.
*/
#error This file (Errors.h) is for developing MacOS software only!
#endif  /* TARGET_OS_MAC */


#endif /* __ERRORS__ */

