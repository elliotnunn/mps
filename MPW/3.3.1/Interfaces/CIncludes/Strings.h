/*
	File:		Strings.h

	Copyright:	© 1984-1993 by Apple Computer, Inc., all rights reserved.

	WARNING
	This file was auto generated by the interfacer tool. Modifications
	must be made to the master file.

*/

#ifndef __STRINGS__
#define __STRINGS__

#ifndef __TYPES__
#include <Types.h>
/*	#include <ConditionalMacros.h>								*/
/*	#include <MixedMode.h>										*/
/*		#include <Traps.h>										*/
#endif

#ifdef __cplusplus
extern "C" {
#endif

extern StringPtr c2pstr(char *aStr);
extern pascal StringPtr C2PStr(Ptr cString);
extern char *p2cstr(StringPtr aStr);
extern pascal Ptr P2CStr(StringPtr pString);
#ifdef __cplusplus
}
#endif

#endif

