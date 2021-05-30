/*
	Limits.h -- Sizes of integral types 
	
	Copyright Apple Computer,Inc.	1987, 1990, 1994-95
	All rights reserved.

*/

#ifndef __LIMITS__
#define __LIMITS__

#define CHAR_BIT	8
#define CHAR_MAX	127
/* #define CHAR_MIN	(-128) */
#define CHAR_MIN	(-CHAR_MAX - 1)
#define MB_LEN_MAX	1
#define INT_MAX		2147483647
/* #define INT_MIN	(-2147483648) */
#define INT_MIN		(-INT_MAX - 1)
#define LONG_MAX	2147483647
/* #define LONG_MIN	(-2147483648) */
#define LONG_MIN	(-LONG_MAX - 1)
#define SCHAR_MAX	127
#define SCHAR_MIN	(-128)
#define SHRT_MAX	32767
#define SHRT_MIN	(-32768)
#define UCHAR_MAX	255U
#define UINT_MAX	4294967295U
#define ULONG_MAX	4294967295U
#define USHRT_MAX	65535U

#if _LONG_LONG   /* Is long long supported? */

#define	LLONG_MAX	9223372036854775807LL
#define	LLONG_MIN	(-LLONG_MAX - 1)
#define	ULLONG_MAX	18446744073709551615ULL

#endif  /* If _LONG_LONG is supported */


#endif
