/*
	IOCtl.h -- Device-handler-specific requests

	Warning:  This interface is NOT a part of the ANSI C standard.
			 We do NOT claim to be POSIX compliant.
			 If you want your code to be portable, don't use this interface.

	Copyright, Apple Computer Inc. 1985-1991, 1995
	All rights reserved.
*/

# ifndef __IOCTL__
# define __IOCTL__


/*
 *		ioctl() function prototype
 */

#ifdef __cplusplus
extern "C" {
#endif

#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
	#pragma import on
#endif

int ioctl(int fildes, unsigned int cmd, long *arg);

#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
	#pragma import off
#endif

#ifdef __cplusplus
}
#endif
 
/*
 *   IO Control commands.
 *
 *   IOCTLs which begin with "FIO" are controls which are general
 * 		 (device driver) control requests.  They may be executed by 
 *		 the top-level ioctl() procedure, or previewed by it before 
 *		 passing it on to the driver xxIoctl()s.
 */
 
# define FIOLSEEK 		(('f'<<8)|0x00)	 /* Apple internal use only */
# define FIODUPFD 		(('f'<<8)|0x01)	 /* Apple internal use only */

# define FIOINTERACTIVE (('f'<<8)|0x02)	 /* If device is interactive */
# define FIOBUFSIZE		(('f'<<8)|0x03)	 /* Return optimal buffer size */
# define FIOFNAME 		(('f'<<8)|0x04)	 /* Return filename */
# define FIOREFNUM		(('f'<<8)|0x05)	 /* Return fs refnum */
# define FIOSETEOF		(('f'<<8)|0x06)	 /* Set file length */

/*
 *   IOCTLs which begin with "TIO" are for TTY (i.e., console or 
 *		 terminal-related) device control requests.
 */

# define TIOFLUSH   (('t'<<8)|0x00)		/* discard unread input.  arg is ignored */
# define TIOSPORT   (('t'<<8)|0x01)		/* Obsolete -- do not use */
# define TIOGPORT   (('t'<<8)|0x02)		/* Obsolete -- do not use */

# endif /*__IOCTL__*/
