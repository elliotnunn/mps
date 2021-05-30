/*
	File:		strstat.h

	Copyright:	© 1993-1996 by Mentat Inc., all rights reserved.

*/

#ifndef __STRSTAT__
#define __STRSTAT__

#ifndef __OPENTRANSPORT__
#include <OpenTransport.h>
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

/* module statistics structure */
struct	module_stat {
	long	ms_pcnt;	/* count of calls to put proc */
	long	ms_scnt;	/* count of calls to service proc */
	long	ms_ocnt;	/* count of calls to open proc */
	long	ms_ccnt;	/* count of calls to close proc */
	long	ms_acnt;	/* count of calls to admin proc */
	char*	ms_xptr;	/* pointer to private statistics */
	short	ms_xsize;	/* length of private statistics buffer */
};

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#endif
