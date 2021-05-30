/************************************************************

	String.h
	String handling
	
	Copyright Apple Computer,Inc.  1987-1990, 1993-1996
	All rights reserved

************************************************************/


#ifndef __STRING__
#define __STRING__

/*
 * Get common declarations 
 */

#include <NullDef.h>
#include <SizeTDef.h>

#ifdef __cplusplus
extern "C" {
#endif


#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
	#pragma import on
#endif

/*
 *	Copying functions
 */

void *memcpy (void *s1, const void *s2, size_t n);
void *memmove (void *s1, const void *s2, size_t n);
char *strcpy (char *s1, const char *s2);
char *strncpy (char *s1, const char *s2, size_t n);

/* Apple library extentions.  The prefered mechanism for enabling these is by defining
 * __useAppleExts__.  In the absence of this symbol, the __STDC__ symbol is used to 
 * enable or disable these extentions. */

/* CFront can't handle the pretty version of this conditional 
#if defined (__useAppleExts__) || \
	((defined (applec) && ! defined (__STDC__)) || \
	 (defined (__PPCC__) && __STDC__ == 0))
*/
#if defined (__useAppleExts__) || ((defined (applec) && ! defined (__STDC__)) || (defined (__PPCC__) && __STDC__ == 0))

void *memccpy(void *s1, const void *s2, int c, size_t n);

#endif

/*
 *	Concatenation functions
 */

char *strcat (char *s1, const char *s2);
char *strncat (char *s1, const char *s2, size_t n);

/*
 *	Comparison functions
 */

int memcmp (const void *s1, const void *s2, size_t n);
int strcmp (const char *s1, const char *s2);
int strcoll (const char *s1, const char *s2);
int strncmp (const char *s1, const char *s2, size_t n);
size_t strxfrm (char *s1, const char *s2, size_t n);


/*
 *	Search functions
 */

void *memchr (const void *s, int c, size_t n);
char *strchr (const char *s, int c);
size_t strcspn (const char *s1, const char *s2);
char * strpbrk (const char *s1, const char *s2);
char *strrchr (const char *s, int c);
size_t strspn (const char *s1, const char *s2);
char *strstr (const char *s1, const char *s2);
char *strtok (char *s1, const char *s2);


/*
 *	Miscellaneous functions
 */

void *memset (void *s, int c, size_t n);
char *strerror (int errnum);
size_t strlen (const char *s);


#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
	#pragma import off
#endif


#ifdef __cplusplus
}
#endif

#endif
