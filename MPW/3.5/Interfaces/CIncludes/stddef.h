/*
	StdDef.h -- Common definitions
	
	Copyright Apple Computer,Inc.	1987-1990, 1994, 1995
	All rights reserved.


*/

#if ! defined (__STDDEF__)
#define __STDDEF__

/*	
	NULL - this macro is defined by several ANSI headers and Types.h
*/

#include <NullDef.h>

/*
	size_t - this type is defined by several ANSI headers.
*/

#include <SizeTDef.h>

/*
	wchar_t - this type is defined only by stddef and stdlib.
*/

#include <WCharTDef.h>

/* Definitions unique to stddef.h */

typedef int ptrdiff_t;
#define offsetof(structure,field) ((size_t)&((structure *) 0)->field)

#endif
