/*
	StdDef.h -- Common definitions
	
	Copyright Apple Computer,Inc.	1987-1990, 1994
	All rights reserved.

*/

#ifndef __STDDEF__
#define __STDDEF__

typedef int ptrdiff_t;

#ifndef __size_t__
#define __size_t__
typedef unsigned int size_t;
#endif

#ifndef __wchar_t__
#define __wchar_t__
typedef short wchar_t;
#endif

#ifndef NULL
#define NULL 0
#endif

#define offsetof(structure,field) ((size_t)&((structure *) 0)->field)

#endif
