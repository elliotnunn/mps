/*
	ioctl.h -- Device-handler-specific requests

	Copyright, Apple Computer Inc. (1985)
	All rights reserved.
*/

# ifndef __IOCTL__
# define __IOCTL__
/*
 *   IO Control commands.
 *
 *   IOCTLs which begin with "FIO" are controls which are general
 * 		 control requests.  They may be executed by the top-level
 * 		 ioctl() procedure, or previewed by it before passing it on
 * 		 to the driver xxIoctl()s.
 *
 * FIOLSEEK and FIODUPFD are for internal use only.
 */
# define FIOLSEEK 		(('f'<<8)|00)	 /* 3rd arg is a _SeekType (below) */
# define FIODUPFD 		(('f'<<8)|01)	 /* 3rd arg is min new fd number */

# define FIOINTERACTIVE (('f'<<8)|02)	 /* If device is interactive */
# define FIOBUFSIZE		(('f'<<8)|03)	 /* Return optimal buffer size */
# define FIOFNAME 		(('f'<<8)|04)	 /* Return filename */
# define FIOREFNUM		(('f'<<8)|05)	 /* Return fs refnum */
# define FIOSETEOF		(('f'<<8)|06)	 /* Set file length */
/*
 * Implementation of lseek() uses this as its 3rd argument.
 */
typedef struct {
	  int  posMode;
	  long posOff;
} _SeekType;


/*
 * TTY stuff.
 */

# define TIOFLUSH   (('t'<<8)|00)
# define TIOSPORT   (('t'<<8)|01)
# define TIOGPORT   (('t'<<8)|02)


# endif __IOCTL__
