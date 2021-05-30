//
//	SharedLib.h - header for simple shared library
//
//
//	Copyright © 1994, Apple Computer, Inc.  All rights reserved.
//

#include <Windows.h>
#include <Quickdraw.h>
#include <Fonts.h>
#include <string.h>

#ifdef __CFM68K__
#pragma lib_export on
#endif

extern void DoMessage (WindowPtr);

#ifdef __CFM68K__
#pragma lib_export off
#endif

