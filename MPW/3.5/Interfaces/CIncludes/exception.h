/*
 *  exception.h
 *
 *  Copyright (c) 1995 Symantec Corporation.  All rights reserved.
 *
 *	$Header: /standard libs/headers and src/C++ Headers/exception.h 2     9/13/95 1:55p Jmicco $
 *
 */

#pragma once
#ifdef __cplusplus
	#pragma options(exceptions)
#endif

#ifndef __EXCEPTION_H
#define __EXCEPTION_H 1

#ifdef macintosh 
	typedef void (*terminate_handler)();
	typedef void (*unexpected_handler)();
#else
	typedef void (__cdecl *terminate_handler)();
	typedef void (__cdecl *unexpected_handler)();
#endif

terminate_handler set_terminate(terminate_handler);
unexpected_handler set_unexpected(unexpected_handler);

void terminate();
void unexpected();

#ifdef __cplusplus
	/* exception classes -- placeholders */
	class exception;
	class bad_exception;
#endif

#endif // __EXCEPTION_H
