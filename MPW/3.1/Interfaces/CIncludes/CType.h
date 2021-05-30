/*
	CType.h -- character types
	
	Copyright American Telephone & Telegraph
	Used with permission, Apple Computer Inc.	(1985-1988)
	All rights reserved.
*/

#ifndef __CTYPE__
#define __CTYPE__

/* 	  @(#)ctype.h		2.1  */
/* 	  3.0 SID # 		1.2	  */
#define _U		 01
#define _L		 02
#define _N		 04
#define _S		 010
#define _P		 020
#define _C		 040
#define _B		 0100
#define _X		 0200

extern char 	 _CType[];

#ifdef __safe_link
extern "C" {
#endif

#ifndef lint

int isalpha (int c);
#define isalpha(c)		((_CType+1)[c]&(_U|_L))

int isupper (int c);
#define isupper(c)		((_CType+1)[c]&_U)

int islower (int c);
#define islower(c)		((_CType+1)[c]&_L)

int isdigit (int c);
#define isdigit(c)		((_CType+1)[c]&_N)

int isxdigit (int c);
#define isxdigit(c)		((_CType+1)[c]&_X)

int isalnum (int c);
#define isalnum(c)		((_CType+1)[c]&(_U|_L|_N))

int isspace (int c);
#define isspace(c)		((_CType+1)[c]&_S)

int ispunct (int c);
#define ispunct(c)		((_CType+1)[c]&_P)

int isprint (int c);
#define isprint(c)		((_CType+1)[c]&(_P|_U|_L|_N|_B))

int isgraph (int c);
#define isgraph(c)		((_CType+1)[c]&(_P|_U|_L|_N))

int iscntrl (int c);
#define iscntrl(c)		((_CType+1)[c]&_C)

int isascii (int c);
#define isascii(c)		((unsigned char)(c)<=0177)

int toupper (int c);
#define __toupper(c)		((c)-'a'+'A')
#define _toupper(c)		((c)-'a'+'A')

int tolower (int c);
#define __tolower(c)		((c)-'A'+'a')
#define _tolower(c)		((c)-'A'+'a')

int toascii (int c);
#define toascii(c)		((c)&0177)

#endif

#ifdef __safe_link
}
#endif

#endif __CTYPE__
