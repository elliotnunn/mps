/*
 errno.h -- error return codes

 Copyright American Telephone & Telegraph
 Used with permission, Apple Computer Inc. (1985)
 All rights reserved.
*/

#ifndef __ERRNO__
#define __ERRNO__

/* @(#)errno.h 2.1 */
/* 3.0 SID # 1.3 */
/*
 * Error codes
 */

extern int errno;

#define EPERM			1 /* Permission Denied */
#define ENOENT 		2 /* No such file or directory */
#define ENORSRC		3 /* No such Resource */
#define EINTR			4 /* interrupted system call */
#define EIO 			5 /* I/O error */
#define ENXIO			6 /* No such device or address */
#define E2BIG			7 /* Insufficient space for return argument */
/* #define ENOEXEC	8 /* Exec format error */
#define EBADF			9 /* Bad file number */
/* #define ECHILD   10 /* No children */
/* #define EAGAIN   11 /* No more processes */
#define ENOMEM 	  12 /* Not enough core */
#define EACCES 	  13 /* Permission denied */
#define EFAULT 	  14 /* Bad address */
#define ENOTBLK	  15 /* Block device required */
#define EBUSY		  16 /* Mount device busy */
#define EEXIST 	  17 /* File exists */
#define EXDEV		  18 /* Cross-device link */
#define ENODEV 	  19 /* No such device */
#define ENOTDIR	  20 /* Not a directory */
#define EISDIR 	  21 /* Is a directory */
#define EINVAL 	  22 /* Invalid argument */
#define ENFILE 	  23 /* File table overflow */
#define EMFILE 	  24 /* Too many open files */
#define ENOTTY 	  25 /* Not a typewriter */
#define ETXTBSY	  26 /* Text file busy */
#define EFBIG		  27 /* File too large */
#define ENOSPC 	  28 /* No space left on device */
#define ESPIPE 	  29 /* Illegal seek */
#define EROFS		  30 /* Read only file system */
#define EMLINK 	  31 /* Too many links */
/* #define EPIPE	  32 /* Broken pipe */
#define EDOM		  33 /* Math arg out of domain of func */
#define ERANGE 	  34 /* Math result not representable */

#endif __ERRNO__
