/*
**	Apple Macintosh Developer Technical Support
**
**	Collection of String Utilities for DTS Sample code
**
**	File:		StringUtils.c
**
**	Copyright © 1988-1993 Apple Computer, Inc.
**	All rights reserved.
*/

/* You may incorporate this sample code into your applications without
** restriction, though the sample code has been provided "AS IS" and the
** responsibility for its operation is 100% yours.  However, what you are
** not permitted to do is to redistribute the source as "DSC Sample Code"
** after having made changes. If you're going to re-distribute the source,
** we require that you make it clear in the source that the code was
** descended from Apple Sample Code, but that you've made changes. */

#ifndef __MEMORY__
#include <Memory.h>
#endif

#ifndef __STRINGUTILS__
#include "StringUtils.h"
#endif



/* These functions should be linked into whatever segment holds main().  This will
** guarantee that the functions will always be in memory when called.  It is important
** that they are in memory, because if a pointer is passed in that points into an
** unlocked handle, the mere fact that the code needs to get loaded may cause the
** handle that is pointed into to move.  If you stick to these string functions,
** you will not have to worry about the handle moving when the string function is
** called.  If you have your own string functions, and you wish the same safety
** factor, link the string handling code into the same segment as main(), as you
** do with these string functions. */

static short	gBase;
static Boolean	gHandleChars;



/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/



/* Return the length of the c-string.  (Same as strlen, but this function isn't
** part of the string library.  The entire library may be more than you wish to
** link into the code segment that holds main, so this (and other) standard
** library function has been duplicated here. */

#pragma segment StringUtils
short	clen(char *cptr)
{
	short	i;

	for (i = 0; cptr[i]; ++i);
	return(i);
}



/*****************************************************************************/



/* Catenate two c-strings. */

#pragma segment StringUtils
char	*ccat(char *s1, char *s2)
{
	ccpy(s1 + clen(s1), s2);
	return(s1);
}



/*****************************************************************************/



/* Copy a c-string. */

#pragma segment StringUtils
char	*ccpy(char *s1, char *s2)
{
	char	*c1, *c2;

	c1 = s1;
	c2 = s2;
	while (*c1++ = *c2++);
	return(s1);
}



/*****************************************************************************/



/* Compare two pascal-strings. */

#pragma segment StringUtils
short	pcmp(StringPtr s1, StringPtr s2)
{
	short	i, len;
	char	j;

	if ((len = s1[0]) > s2[0]) len = s2[0];

	for (i = 1; i <= len; ++i)
		if (j = s1[i] - s2[i]) return(j);

	return(s1[0] - s2[0]);
}



/*****************************************************************************/



/* Catenate two pascal-strings. */

#pragma segment StringUtils
void	pcat(StringPtr d, StringPtr s)
{
	short	i, j;

	if (((j = s[0]) + d[0]) > 255)
		j = 255 - d[0];
			/* Limit dest string to 255. */

	for (i = 0; i < j;) d[++d[0]] = s[++i];
}



/*****************************************************************************/



/* Copy a pascal-string. */

#pragma segment StringUtils
void	pcpy(StringPtr d, StringPtr s)
{
	short	i;

	i = *s;
	do {
		d[i] = s[i];
	} while (i--);
}



/*****************************************************************************/



/* Convert a c-string to a pascal-string. */

#pragma segment StringUtils
void	c2p(char *cptr)
{
	char	len;

	BlockMove(cptr, cptr + 1, len = clen(cptr));
	*cptr = len;
}



/*****************************************************************************/



/* Convert a pascal-string to a c-string. */

#pragma segment StringUtils
void	p2c(StringPtr cptr)
{
	unsigned char	len;

	BlockMove(cptr + 1, cptr, len = *cptr);
	cptr[len] = 0;
}



/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/



/* Catenate a single character multiple times onto the designated string. */

#pragma segment StringUtils
void	ccatchr(char *cptr, char c, short count)
{
	ccpychr(cptr + clen(cptr), c, count);
}



/*****************************************************************************/



/* Convert the value into text for the base-10 number and catenate it to
** the designated string.  The value is assumed to be signed.  If you wish
** to have an unsigned decimal value, call ccatnum with a base of 10. */

#pragma segment StringUtils
void	ccatdec(char *cptr, long v)
{
	ccatnum(cptr + clen(cptr), v, -10);		/* Catenate value base 10, signed. */
}



/*****************************************************************************/



/* Convert the value into text for base-16, format it, and catenate it to the
** designated string.  ccatnum could be used, since it handles multiple bases,
** but ccathex allows for additional common formatting and padding of the
** hex value. */

#pragma segment StringUtils
void	ccathex(char *cptr, char padChr, short minApnd, short maxApnd, long v)
{
	char	str[33], *sptr;
	short	len;

	cptr += clen(cptr);			/* We're appending, so point to the end of the string. */
	ccpynum(str, v, 16);		/* Generate minimum-digit hex value. */

	if ((len = clen(sptr = str)) > maxApnd)
		sptr = str + len - maxApnd;

	if ((len = clen(sptr)) < minApnd)
		if (padChr)
			ccatchr(cptr, padChr, (minApnd - len));
				/* if we have a pad character, and if necessary, pad the string. */

	ccat(cptr, sptr);			/* Add the hex digits to the string. */
}



/*****************************************************************************/



/* Convert the value into text for the designated base.  Catenate the text to
** the designated string. */

#pragma segment StringUtils
void	ccatnum(char *cptr, long v, short base)
{
	ccpynum(cptr + clen(cptr), v, base);
}



/*****************************************************************************/



#pragma segment StringUtils
void	ccpychr(char *cptr, char c, short count)
{
	for (;count--; ++cptr) *cptr = c;
	*cptr = 0;
}



/*****************************************************************************/



#pragma segment StringUtils
void	ccpydec(char *cptr, long v)
{
	ccpynum(cptr, v, -10);
}



/*****************************************************************************/



#pragma segment StringUtils
void	ccpyhex(char *cptr, char padChr, short minApnd, short maxApnd, long v)
{
	cptr[0] = 0;
	ccathex(cptr, padChr, minApnd, maxApnd, v);
}



/*****************************************************************************/



#pragma segment StringUtils
void	ccpynum(char *cptr, long v, short base)
{
	pcpynum((StringPtr)cptr, v, base);
	p2c((StringPtr)cptr);
}



/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/



#pragma segment StringUtils
long	c2dec(char *cptr, short *charsUsed)
{
	return(c2num(cptr, 10, charsUsed));
}



/*****************************************************************************/



#pragma segment StringUtils
long	c2hex(char *cptr, short *charsUsed)
{
	return(c2num(cptr, 16, charsUsed));
}



/*****************************************************************************/



#pragma segment StringUtils
long	c2num(char *cptr, short base, short *charsUsed)
{
	Boolean	firstDigit;
	short	i, sgn;
	short	c;
	long	val;

	sgn = 1;
	for (firstDigit = false, val = 0, i = 0;;) {
		c = cptr[i++];
		if (base == 256) {
			if (!c) break;
			if (c == '\'') {
				++i;
				break;
			}
			val *= base;
			val += c;
			continue;
		}
		if (c == '-') {
			if (firstDigit) break;
			if (sgn == -1)  break;
			sgn = -1;
			continue;
		}
		if (c == '$') {
			if (firstDigit) break;
			base = 16;
			continue;
		}
		if (gHandleChars) {
			if (c == '\'') {
				if (firstDigit) break;
				base = 256;
				continue;
			}
		}
		if ((!firstDigit) && (c == ' ')) continue;
		c -= '0';
		if (c > 16) c -= 7;		/* Make 'A' a 10, etc. */
		if (c > 32) c -= 32;	/* Make lower-case upper-case. */
		if (c < 0) break;
		if (c >= base) break;
		val *= base;
		val += (c * sgn);
		firstDigit = true;
	}

	if (charsUsed) *charsUsed = --i;

	gBase = base;
	return(val);
}



/*****************************************************************************/



#pragma segment StringUtils
short	GetLastBase(Boolean handleChars)
{
	gHandleChars = handleChars;
	return(gBase);
}



/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/



/* Catenate a single character multiple times onto the designated string. */

#pragma segment StringUtils
void	pcatchr(StringPtr pptr, char c, short count)
{
	while (count--) pptr[++(pptr[0])] = c;
}



/*****************************************************************************/



#pragma segment StringUtils
void	pcatdec(StringPtr pptr, long v)
{
	pcatnum(pptr, v, -10);
}



/*****************************************************************************/



#pragma segment StringUtils
void	pcathex(StringPtr pptr, char padChr, short minApnd, short maxApnd, long v)
{
	char	str[33];

	ccpyhex(str, padChr, minApnd, maxApnd, v);
	c2p(str);
	pcat(pptr, (StringPtr)str);
}



/*****************************************************************************/



#pragma segment StringUtils
long	pcatnum(StringPtr pptr, long v, short base)
{
	unsigned long	j, vv;

	vv = v;
	if (base < 0) {
		base = -base;
		if (v < 0) {
			pptr[++*pptr] = '-';
			vv = -vv;
		}
	}
	j = 0;
	if (vv >= base)
		j = pcatnum(pptr, vv / base, base);

	pptr[++*pptr] = "0123456789ABCDEF"[vv - j];
	return(base * vv);
}



/*****************************************************************************/



#pragma segment StringUtils
void	pcpychr(StringPtr pptr, char c, short count)
{
	pptr[0] = 0;
	pcatchr(pptr, c, count);
}



/*****************************************************************************/



#pragma segment StringUtils
void	pcpydec(StringPtr pptr, long v)
{
	*pptr = 0;
	pcatdec(pptr, v);
}



/*****************************************************************************/



#pragma segment StringUtils
void	pcpynum(StringPtr pptr, long v, short base)
{
	*pptr = 0;
	pcatnum(pptr, v, base);
}



/*****************************************************************************/



#pragma segment StringUtils
void	pcpyhex(StringPtr pptr, char padChr, short minApnd, short maxApnd, long v)
{
	*pptr = 0;
	pcathex(pptr, padChr, minApnd, maxApnd, v);
}



/*****************************************************************************/



#pragma segment StringUtils
long	p2dec(StringPtr pptr, short *charsUsed)
{
	return(p2num(pptr, 10, charsUsed));
}



/*****************************************************************************/



#pragma segment StringUtils
long	p2hex(StringPtr pptr, short *charsUsed)
{
	return(p2num(pptr, 16, charsUsed));
}



/*****************************************************************************/



#pragma segment StringUtils
long	p2num(StringPtr pptr, short base, short *charsUsed)
{
	long	val;

	p2c(pptr);
	val = c2num((char *)pptr, base, charsUsed);
	c2p((char *)pptr);
	return(val);
}



/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/



#pragma segment StringUtils
short	GetHexByte(char *cptr)
{
	short	val, i, chr;

	for (val = 0, i = 0; i < 2; ++i) {
		chr = cptr[i];
		if (chr == '=') return(cptr[++i]);
		if (chr == '≈') {
			chr = cptr[++i];
			if ((chr >= 'a') && (chr <= 'z')) chr -= 32;
			return(chr);
		}
		if (chr > 'F')
			chr -= 0x20;
		if (chr > '9')
			chr -= ('A' - '9' - 1);
		val = (val << 4) + chr - '0';
	}
	return(val);
}



/*****************************************************************************/



#pragma segment StringUtils
Boolean	EqualHandle(void *h1, void *h2)
{
	long	s1, s2;
	Ptr		p1, p2;

	if ((h1) && (!h2)) return(false);
	if ((h2) && (!h1)) return(false);
	if ((s1 = GetHandleSize(h1)) != (s2 = GetHandleSize(h2))) return(false);

	p1 = *(Handle)h1;
	p2 = *(Handle)h2;
	for (s1 = 0; s1 < s2; ++s1)
		if (p1[s1] != p2[s1]) return(false);
		
	return(true);
}



/*****************************************************************************/



#pragma segment StringUtils
Boolean	EqualData(void *v1, void *v2, long size)
{
	Ptr		p1, p2;
	long	ii;

	if ((v1) && (!v2)) return(false);
	if ((v2) && (!v1)) return(false);

	p1 = (Ptr)v1;
	p2 = (Ptr)v2;
	for (ii = 0; ii < size; ++ii)
		if (p1[ii] != p2[ii]) return(false);
		
	return(true);
}



/*****************************************************************************/



#pragma segment StringUtils
void	SetMem(void *vptr, unsigned char c, unsigned long len)
{
	Ptr	ptr;

	ptr = (Ptr)vptr;
	while (len--) *ptr++ = c;
}



