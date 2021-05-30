/*
**	Apple Macintosh Developer Technical Support
**
**	Header file for collection of String Utilities for DTS Sample code
**
**	Copyright © 1988-1992 Apple Computer, Inc.
**	All rights reserved.
*/


#ifndef __STRINGUTILS__
#define __STRINGUTILS__

#ifdef applec

#ifndef __TYPES__
#include <Types.h>
#endif

#endif


/* These are duplicates of c-library functions.  The reason for duplicating them
** is so that the StringUtils code can be small and linked in with other code that
** stays resident at all times.  It is possible that when you call code to do
** something as seemingly innocent as getting the length of a string, memory can
** move.  This is because the code you are calling isn't necessarily in memory.
** If the code segment that contains the code you are calling isn't in ram, then
** it has to be loaded.  Loading the code may cause memory compaction, and therefore
** memory can move.  The pointer to the string is already pushed on the stack prior
** to the call, so if you passed a pointer into an unlocked handle, after calling
** the code, that handle may have moved, and therefore the pointer is invalid.
**
** To prevent the above problem, alternate names were used for these common library
** functions.  Link this code into the same segment that holds main(), and you will
** be guaranteed that they will be in memory whenever you call them. */

short	clen(char *cptr);
	/* Return the length of the c-string.  (Same as strlen, but this function isn't
	** part of the string library.  The entire library may be more than you wish to
	** link into the code segment that holds main, so this (and other) standard
	** library function has been duplicated here. */

char	*ccat(char *s1, char *s2);
	/* Catenate two c-strings. */

char	*ccpy(char *s1, char *s2);
	/* Copy a c-string. */

short	pcmp(StringPtr s1, StringPtr s2);
	/* Compare two pascal-strings. */

void	pcat(StringPtr d, StringPtr s);
	/* Catenate two pascal-strings. */

void	pcpy(StringPtr d, StringPtr s);
	/* Copy a pascal-string. */

void	c2p(char *cptr);
	/* Convert a c-string to a pascal-string. */

void	p2c(StringPtr cptr);
	/* Convert a pascal-string to a c-string. */


/*****************************************************************************/

/* These are useful, relatively small routines for string manipulation.  As with the
** above calls, link them into the code segment that holds main().
**
** With the below functions, you will have most of the functionality of sprintf
** using shorts and longs.  It will take more calls, but only what you call is linked
** in. */


/**/

void	ccatchr(char *cptr, char c, short count);
	/* Catenate a single character multiple times onto the designated string. */

void	ccatdec(char *cptr, long v);
	/* Convert the value into text for the base-10 number and catenate it to
	** the designated string.  The value is assumed to be signed.  If you wish
	** to have an unsigned decimal value, call ccatnum with a base of 10. */

void	ccathex(char *cptr, char padChr, short minApnd, short maxApnd, long v);
	/* Convert the value into text for base-16, format it, and catenate it to the
	** designated string.  ccatnum could be used, since it handles multiple bases,
	** but ccathex allows for additional common formatting and padding of the
	** hex value. */

void	ccatnum(char *cptr, long v, short base);
	/* Convert the value into text for the designated base.  Catenate the text to
	** the designated string. */

void	ccpychr(char *cptr, char c, short count);
	/* Copy a single character multiple times onto the designated string. */

void	ccpydec(char *cptr, long v);
	/* Convert the value into text for the base-10 number and copy it into
	** the designated string.  The value is assumed to be signed.  If you wish
	** to have an unsigned decimal value, call ccpynum with a base of 10. */

void	ccpyhex(char *cptr, char padChr, short minApnd, short maxApnd, long v);
	/* Convert the value into text for base-16, format it, and copy it into the
	** designated string.  ccpynum could be used, since it handles multiple bases,
	** but ccpyhex allows for additional common formatting and padding of the
	** hex value. */

void	ccpynum(char *cptr, long v, short base);
	/* Convert the value into text for the designated base.  Copy the text into
	** the designated string. */

long	c2dec(char *cptr, short *charsUsed);
	/* Convert the c-string to a decimal number. */

long	c2hex(char *cptr, short *charsUsed);
	/* Convert the c-string to a hex number. */

long	c2num(char *cptr, short base, short *charsUsed);
	/* Convert the c-string to a number.  The string can either be in decimal or hex notation. */

short	GetLastBase(Boolean handleChars);
	/* Use this to find out what base c2num determined the text to be. */

/**/

short	pcmp(StringPtr s1, StringPtr s2);
	/* Compare a pascal-string. */

void	pcatchr(StringPtr pptr, char c, short count);
	/* Catenate a single character multiple times onto the designated string. */

void	pcatdec(StringPtr pptr, long v);
	/* Convert the value into text for the base-10 number and catenate it to
	** the designated string.  The value is assumed to be signed.  If you wish
	** to have an unsigned decimal value, call pcatnum with a base of 10. */

void	pcathex(StringPtr pptr, char padChr, short minApnd, short maxApnd, long v);
	/* Convert the value into text for base-16, format it, and catenate it to the
	** designated string.  pcatnum could be used, since it handles multiple bases,
	** but pcathex allows for additional common formatting and padding of the
	** hex value. */

long	pcatnum(StringPtr pptr, long v, short base);
	/* Convert the value into text for the designated base.  Catenate the text to
	** the designated string. */

void	pcpychr(StringPtr pptr, char c, short count);
	/* Copy a single character multiple times onto the designated string. */

void	pcpydec(StringPtr pptr, long v);
	/* Convert the value into text for the base-10 number and copy it into
	** the designated string.  The value is assumed to be signed.  If you wish
	** to have an unsigned decimal value, call pcpynum with a base of 10. */

void	pcpyhex(StringPtr pptr, char padChr, short minApnd, short maxApnd, long v);
	/* Convert the value into text for base-16, format it, and copy it into the
	** designated string.  pcpynum could be used, since it handles multiple bases,
	** but pcpyhex allows for additional common formatting and padding of the
	** hex value. */

void	pcpynum(StringPtr pptr, long v, short base);
	/* Convert the value into text for the designated base.  Copy the text into
	** the designated string. */

long	p2dec(StringPtr pptr, short *charsUsed);
	/* Convert the pascal-string to a decimal number. */

long	p2hex(StringPtr pptr, short *charsUsed);
	/* Convert the pascal-string to a hex number. */

long	p2num(StringPtr pptr, short base, short *charsUsed);
	/* Convert the pascal-string to a number.  String can either be in decimal or hex notation. */

/**/

short	GetHexByte(char *cptr);

Boolean	EqualHandle(void *h1, void *h2);
	/* This function checks to see if two handles are identical. */

Boolean	EqualData(void *v1, void *v2, long size);
	/* This function checks to see if two blocks of data are identical. */

void	SetMem(void *vptr, unsigned char c, unsigned long len);

#endif



