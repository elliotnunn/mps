/*ident	"@(#)ctrans:incl-master/proto-headers/new.h	1.4" */

/***********************************************************************

	Copyright (c) 1984 AT&T, Inc. All rights Reserved
	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF AT&T, INC.

        The copyright notice above does not evidence any
        actual or intended publication of such source code.

**************************************************************************/

#ifndef __NEW__
#define __NEW__

#ifndef __STDDEF__
#include <stddef.h>
#endif

extern void (*set_new_handler (void(*)()))();

void *operator new(size_t, void*);

#endif
