/*
	StdDef.h -- Common definitions
	
	Copyright Apple Computer,Inc.	1987, 1988
	All rights reserved.

*/

#ifndef __STDDEF__
#define __STDDEF__

typedef int ptrdiff_t;
typedef unsigned int size_t;
typedef short wchar_t;

#ifndef NULL
#define NULL 0
#endif NULL

#define offsetof(structure,field) ((size_t)&((structure *) 0)->field)

#endif __STDDEF__
