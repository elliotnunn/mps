/*
	StdLib.h -- General utilities

	Copyright Apple Computer,Inc.	1987, 1990, 1993-1995
	All rights reserved.

*/


#ifndef __STDLIB__
#define __STDLIB__

/*
 * Get common declarations 
 */

#include <NullDef.h>
#include <SizeTDef.h>
#include <WCharTDef.h>

#ifdef powerc
#pragma options align=power
#endif
struct div_t {
	int quot;			/* quotient */
	int rem;			/* remainder */
} ;
#ifdef powerc
#pragma options align=reset
#endif
typedef struct div_t div_t;

#ifdef powerc
#pragma options align=power
#endif
struct ldiv_t {
	long int quot;		/* quotient */
	long int rem;		/* remainder */
};
#ifdef powerc
#pragma options align=reset
#endif
typedef struct ldiv_t ldiv_t;

#define EXIT_FAILURE 1
#define EXIT_SUCCESS 0

#define RAND_MAX 32767

#define MB_CUR_MAX 1

#ifdef __cplusplus
extern "C" {
#endif


#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
	#pragma import on
#endif


/*
 *	String conversion functions
 */

double atof (const char *nptr);
int atoi (const char *nptr);
long int atol (const char *nptr);
double strtod (const char *nptr, char **endptr);
long int strtol (const char *nptr, char **endptr, int base);
unsigned long int strtoul (const char *nptr, char **endptr, int base);


/*
 *	Pseudo-random sequence generation functions
 */

int rand (void);
void srand (unsigned int seed);


/*
 *	Memory management functions
 */

void *calloc (size_t nmemb, size_t size);
void free (void *ptr);
void *malloc (size_t size);
void *realloc (void *ptr, size_t size);


/*
 *	Communication with the environment
 */

void abort (void);
int atexit (void (*func)(void));
void exit (int status);
char *getenv (const char *name);
int system (const char *string);


/*
 *	Searching and sorting utilities
 */

void *bsearch (const void *key, const void *base,
			   size_t nmemb, size_t size,
			   int (*compar)(const void *, const void *));
void qsort (void *base, size_t nmemb, size_t size,
			int (*compar)(const void *, const void *));


/*
 *	Integer arithmetic functions
 */

int abs (int j);
div_t div (int numer, int denom);
long int labs (long int j);
ldiv_t ldiv (long int numer, long int denom);


/*
 *	Multibyte functions
 */

int mblen (const char *s, size_t n);
int mbtowc (wchar_t *pwc, const char *s, size_t n);
int wctomb (char *s, wchar_t wchar);
size_t mbstowcs (wchar_t *pwcs, const char *s, size_t n);
size_t wcstombs (char *s, const wchar_t *pwcs, size_t n);

/*
 *  Apple extentions
 */
 
/* CFront can't handle the pretty version of this conditional 
#if defined (__useAppleExts__) || \
	((defined (applec) && ! defined (__STDC__)) || \
	 (defined (__PPCC__) && __STDC__ == 0))
*/
#if defined (__useAppleExts__) || ((defined (applec) && ! defined (__STDC__)) || (defined (__PPCC__) && __STDC__ == 0))

void _exit (int status);
int setenv(const char *varName, const char *value);
#define putenv(x, y) setenv((x), (y))

#endif

#if _LONG_LONG   /* Is long long supported? */

struct lldiv_t {
	long long int quot;		/* quotient  */
	long long int rem;		/* remainder */
};

typedef struct lldiv_t lldiv_t;

long long int llabs (long long int j);
lldiv_t lldiv (long long int numer, long long int denom);
long long int strtoll (const char *nptr, char **endptr, int base);
unsigned long long int strtoull (const char *nptr, char **endptr, int base);
long long int atoll (const char *nptr);

#endif  /* If _LONG_LONG is supported */


#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
	#pragma import off
#endif


#ifdef __cplusplus
}
#endif

#endif
