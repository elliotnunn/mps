/*
	SizeTDef.h -- Common definitions
	
	Copyright Apple Computer,Inc.	1987-1990, 1994
	All rights reserved.

	size_t - this type is defined by several ANSI headers.
*/

#ifndef __SIZETDEF__
#define __SIZETDEF__

#if defined (__xlc) || defined (__xlC) || defined (__xlC__)
	typedef unsigned long size_t;
#else	/* __xlC */
	typedef unsigned int size_t;
#endif	/* __xlC */

#endif	/* __SIZETDEF__ */

