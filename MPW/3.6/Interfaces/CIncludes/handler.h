/*
 *------------------------------------------------------------------------
 * Copyright:
 *      © 1995 by Apple Computer Inc.  all rights reserved.
 *
 * Project:
 *      PowerPC C++ Library
 *
 * Filename:
 *      handler.h
 *
 * Created:
 *      01/04/95
 *
 * Modified:
 *      Date     Engineer       Comment
 *      -------- -------------- ------------------------------------------
 *      01/12/95 Scott Fraser   Updated for new runtime environments.
 *------------------------------------------------------------------------
 */

/********************
 * _new_handler can be modified to point to a function in case
 * the allocation fails. _new_handler can attempt to repair things.
 */

#ifndef __HANDLER__
#define __HANDLER__	1

extern void (*_new_handler)(void);

#endif	/* __HANDLER__ */
