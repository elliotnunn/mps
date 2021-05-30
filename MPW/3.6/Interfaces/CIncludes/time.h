/************************************************************

	Time.h
	Date and time
	
	Copyright © Apple Computer,Inc.  1987-1991, 1993, 1994, 2000-2001.
	All Rights Reserved.

************************************************************/


#ifndef __TIME_H__ /* __TIME__ is a reserved preprocessor symbol */
#define __TIME_H__


#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif

/*
 * Get common declarations 
 */

#include <NullDef.h>
#include <SizeTDef.h>

/*
 *	Declarations
 */

typedef unsigned long int clock_t;
#if CALL_NOT_IN_CARBON || __MPWINTERNAL__
#define CLOCKS_PER_SEC 60
typedef unsigned long int time_t;
#else
#define CLOCKS_PER_SEC 100		/* UNIX time on OS X. */
typedef signed long int time_t;	/* UNIX time on OS X. */
#endif
#ifdef powerc
#pragma options align=power
#endif
struct tm {
	int tm_sec;		/* Seconds after the minute -- [0, 61] */
	int tm_min;		/* Minutes after the hour -- [0, 59] */
	int tm_hour;	/* Hours after midnight -- [0, 23] */
	int tm_mday;	/* Day of the month -- [1, 31] */
	int tm_mon;		/* Months since January -- [0, 11] */
	int tm_year;	/* Years since 1900 */
	int tm_wday;	/* Days since Sunday -- [0, 6] */
	int tm_yday;	/* Days since January 1 -- [0, 365] */
	int tm_isdst;	/* Daylight Savings Time flag */
#if !(CALL_NOT_IN_CARBON || __MPWINTERNAL__)
	long	tm_gmtoff;	/* offset from CUT in seconds */
	char	*tm_zone;	/* timezone abbreviation */
#endif
};
#ifdef powerc
#pragma options align=reset
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
	#pragma import on
#endif

/*
 *	Time manipulation functions
 */

clock_t clock(void);						/* function */
#if CALL_NOT_IN_CARBON || __MPWINTERNAL__
	#if !defined (__powerc) && !defined (powerc) && !defined (__CFM68K__)
		#define clock() __tickcount()			/* macro - use TickCount() */
		pascal unsigned long __tickcount(void)
			= 0xA975; 
	#endif /* powerc */
#endif  /* CALL_NOT_IN_CARBON || __MPWINTERNAL__ */

double  difftime(time_t time1, time_t time0);        		/* function */
#if CALL_NOT_IN_CARBON || __MPWINTERNAL__
	#define difftime(time1,time0) ((long double)time1 - time0)	/* macro */
#endif  /* CALL_NOT_IN_CARBON || __MPWINTERNAL__ */

time_t mktime(struct tm *timeptr);
time_t time(time_t *timer);

/*
 *	Time conversion functions
 */

char *asctime (const struct tm *timeptr);
char *ctime(const time_t *timer);
struct tm *gmtime(const time_t *timer);
struct tm *localtime(const time_t *timer);
size_t strftime(char *s, size_t maxsize,
				 const char *format, const struct tm *timerptr);

#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
	#pragma import off
#endif

#ifdef __cplusplus
}
#endif

#endif
