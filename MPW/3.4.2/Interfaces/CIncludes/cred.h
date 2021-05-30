/*
	File:		cred.h

	Copyright:	© 1993-1996 by Mentat Inc., all rights reserved.

*/


#ifndef __CRED__
#define __CRED__

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

typedef struct cred
{
	unsigned short	cr_ref;			/* reference count on processes using cred structures */
	unsigned short	cr_ngroups;		/* number of groups in cr_groups */
	uid_t			cr_uid;			/* effective user id */
	gid_t			cr_gid;			/* effective group id */
	uid_t			cr_ruid;		/* real user id */
	gid_t			cr_rgid;		/* real group id */
	uid_t			cr_suid;		/* user id saved by exec */
	gid_t			cr_sgid;		/* group id saved by exec */
	gid_t			cr_groups[1];	/* supplementary groups list */
} cred_t;

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#endif
