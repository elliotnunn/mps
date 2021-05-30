/*
	PLStringFuncs.h -- C string conversion functions for pascal
		
	Copyright Apple Computer,Inc.  1989, 1990
	All rights reserved

*/

#ifndef __PLSTRINGFUNCS__
#define __PLSTRINGFUNCS__

#ifndef	__TYPES__
#include <Types.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

pascal short		PLstrcmp(ConstStr255Param str1, ConstStr255Param str2);
pascal short 		PLstrncmp(ConstStr255Param str1, ConstStr255Param str2, short num);
pascal StringPtr 	PLstrcpy(StringPtr str1, ConstStr255Param str2);
pascal StringPtr 	PLstrncpy(StringPtr str1, ConstStr255Param str2, short num);
pascal StringPtr	PLstrcat(StringPtr str1, ConstStr255Param str2);
pascal StringPtr 	PLstrncat(StringPtr str1, ConstStr255Param str2, short num);
pascal Ptr 			PLstrchr(ConstStr255Param str1, short ch1);
pascal Ptr 			PLstrrchr(ConstStr255Param str1, short ch1);
pascal Ptr 			PLstrpbrk(ConstStr255Param str1, ConstStr255Param str2);
pascal short 		PLstrspn(ConstStr255Param str1, ConstStr255Param str2);
pascal Ptr 			PLstrstr(ConstStr255Param str1, ConstStr255Param str2);
pascal short 		PLstrlen(ConstStr255Param str);
pascal short		PLpos(ConstStr255Param str1, ConstStr255Param str2);


#ifdef __cplusplus
}
#endif

#endif
