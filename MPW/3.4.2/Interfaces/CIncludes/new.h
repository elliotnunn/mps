/*
	new.h -- Standard definitions for "operator new".

	Copyright Apple Computer,Inc.	1994-1995
	All rights reserved.

*/

#ifndef __NEW__
#define __NEW__	1

#include <stddef.h>

extern void (*set_new_handler (void(*)()))();

extern void* operator new(size_t, void*);
extern void* operator new(size_t);

#endif	/* __NEW__ */
