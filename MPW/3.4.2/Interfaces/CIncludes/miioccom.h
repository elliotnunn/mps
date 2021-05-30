/** Copyright (c) 1993  Mentat Inc.
 ** miioccom.h 4.1, last change 31 Aug 1993
 **/


#ifndef _MIIOCCOM_
#define _MIIOCCOM_

#if 0

#ifndef	MIOC_CMD
#ifdef _IO
#define MIOC_CMD	_IO
#else
#define	MIOC_CMD(t,v)	(((t&0xFF) << 8)|(v&0xFF))
#endif
#endif

/*
 * The following is a complete registry of ALL ioctl() command prefix bytes used
 * by any Mentat Source code.  You may freely and safely change definitions here 
 * as needed so as not to collide with existing ioctl() command definitions 
 * on your system.
 */

#define	MIOC_STREAMIO	'A'		/* Basic Stream ioctl() cmds - I_PUSH, I_LOOK, etc. */
#define MIOC_TMOD		'a'		/* ioctl's for tmod test module */
#define MIOC_STRLOG		'b'		/* ioctl's for Mentat's log device */
#define MIOC_ND			'c'		/* ioctl's for Mentat's nd device */
#define MIOC_ECHO		'd'		/* ioctl's for Mentat's echo device */
#define MIOC_TLI		'e'		/* ioctl's for Mentat's timod module */
/* skip 'f' -- used in SVR4 FIOxxx */
#define MIOC_SAD		'g'		/* ioctl's for Mentat's sad module */
#define MIOC_ARP		'h'		/* ioctl's for Mentat's arp module */
#define	MIOC_HAVOC		'H'		/* Havoc module ioctls. */
/* skip 'i' -- used in SVR4 SIOCxxx */
#define MIOC_SIOC		'j'		/* sockio.h socket ioctl's */
#define MIOC_TCP			'k'		/* tcp.h ioctl's */
#define MIOC_DLPI	'l'		/* dlpi.h Sun additions */
#define MIOC_SOCKETS	'm'		/* Mentat sockmod ioctl's */
/* skip 'p' -- used in SVR4 */
/* skip 'r' -- used in SVR4 */
/* skip 's' -- used in SVR4 */

#endif

#endif	/* _MIIOCCOM_ */
