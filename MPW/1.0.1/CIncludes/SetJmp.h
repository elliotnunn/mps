/*
 * SetJmp.h
 *
 * Copyright 1986, Apple Computer
 * All rights reserved.
 */

typedef int *jmp_buf[12];		  /*	D2-D7,PC,A2-A4,A6,SP  */

extern int	setjmp(buf);
extern void longjmp(buf, value);
