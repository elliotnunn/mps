/*
 *	string.h -- Standard C Strings Package
 *	Modified for use with Macintosh C
 *	Apple Computer, Inc.  1985
 *
 *	version	2.0a3
 *
 *	Copyright American Telephone & Telegraph
 *	Used with permission, Apple Computer Inc. (1985)
 *	All rights reserved.
 */


#ifndef __STRING__
#define __STRING__


extern char *strcat();
extern char *strncat();
extern int strcmp();
extern int strncmp();
extern char *strcpy();
extern char *strncpy();
extern int strlen();
extern char *strchr();
extern char *strrchr();
extern char *strpbrk();
extern int strspn();
extern int strcspn();
extern char *strtok();

#endif __STRING__
