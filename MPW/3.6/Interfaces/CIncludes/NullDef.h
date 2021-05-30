/*
	NullDef.h -- Common definitions
	
	Copyright Apple Computer,Inc.	1987-1990, 1994
	All rights reserved.


	NULL - this macro is defined by all ANSI headers and Types.h
*/

#ifndef __NULLDEF__
#define __NULLDEF__

#ifdef NULL
#undef NULL
#endif

#if !defined(__cplusplus) && (defined(__SC__) || defined(THINK_C))
	#define NULL ((void *) 0)
#else
	#define NULL 0
#endif
	
#endif	/* __NULLDEF__ */

