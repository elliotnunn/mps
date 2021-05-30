/************************************************************

Created: Tuesday, October 4, 1988 at 9:39 PM
    Strings.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1985-1988
    All rights reserved

************************************************************/


#ifndef __STRINGS__
#define __STRINGS__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifdef __safe_link
extern "C" {
#endif
char *p2cstr(StringPtr aStr); 
StringPtr c2pstr(char *aStr); 
#ifdef __safe_link
}
#endif

#endif
