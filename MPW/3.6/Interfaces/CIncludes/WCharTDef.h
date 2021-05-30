/*
	StdDef.h -- Common definitions
	
	Copyright Apple Computer,Inc.	1987-1990, 1994, 1997
	All rights reserved.

	wchar_t - this type is defined only by stddef and stdlib.
	          This type is now a built-in type in C++.
*/

#ifndef __WCHARTDEF__
#define __WCHARTDEF__

	#ifdef	__xlC
		typedef unsigned short wchar_t;
	#else
		#if __MRC__ || __SC__ >= 0x860
			#ifndef __WCHAR_T__
				typedef unsigned short wchar_t;
			#endif
		#else
			typedef short wchar_t;
		#endif
	#endif

#endif	/* __WCHARTDEF__ */
