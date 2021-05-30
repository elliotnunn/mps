/*
 *------------------------------------------------------------------------
 * Copyright:
 *      © 1993 by Apple Computer Inc.  all rights reserved.
 *
 * Project:
 *      PowerPC C++ Streams Library
 *
 * Filename:
 *      new.h
 *
 * Created:
 *      (unknown)
 *
 * Modified:
 *      Date     Engineer       Comment
 *      -------- -------------- ------------------------------------------
 *      12/17/93 Rudy Wang      Made this file universal.
 *------------------------------------------------------------------------
 */
#ifndef __NEWH__
#define __NEWH__	1

#include <stddef.h>

extern void (*set_new_handler (void(*)()))();

void* operator new(size_t, void*);
void* operator new(size_t);

#endif
