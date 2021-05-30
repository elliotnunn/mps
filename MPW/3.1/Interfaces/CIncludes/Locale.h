/*
	Locale.h - Localization
	
	Copyright Apple Computer, Inc.  1988
	All rights reserved.
	
*/

#ifndef __LOCALE__
#define __LOCALE__

#ifndef __LIMITS__
#include <Limits.h>              /* For 'CHAR_MAX' definition */
#endif __LIMITS__

/* 
 *   Declarations
 */
 
#ifndef NULL
#define NULL 0
#endif NULL

#define LC_ALL        1 /* entire locale */
#define LC_COLLATE    2 /* strcoll and strxfrm functions */
#define LC_CTYPE      3 /* character handling and multibyte functions */
#define LC_MONETARY   4 /* monetary formatting information returned by localeconv */
#define LC_NUMERIC    5 /* decimal point formatting input/output and string conversions */
#define LC_TIME       6 /* strftime function */

struct lconv {
	char *decimal_point;       /* "." */
	char *thousands_sep;       /* "" */
	char *grouping;            /* "" */
	char *int_curr_symbol;     /* "" */
	char *currency_symbol;     /* "" */
	char *mon_decimal_point;   /* "" */
	char *mon_thousands_sep;   /* "" */
	char *mon_grouping;        /* "" */
	char *positive_sign;       /* "" */
	char *negative_sign;       /* "" */
	char frac_digits;          /* CHAR_MAX */
	char int_frac_digits;      /* CHAR_MAX */
	char p_cs_precedes;        /* CHAR_MAX */
	char p_sep_by_space;       /* CHAR_MAX */
	char n_cs_precedes;        /* CHAR_MAX */
	char n_sep_by_space;       /* CHAR_MAX */
	char p_sign_posn;          /* CHAR_MAX */
	char n_sign_posn;          /* CHAR_MAX */
};


#ifdef __safe_link
extern "C" {
#endif

/*
 *  functions
 */
 
char *setlocale (int category, const char *locale);
struct lconv *localeconv (void);

#ifdef __safe_link
}
#endif
 
#endif __LOCALE__
