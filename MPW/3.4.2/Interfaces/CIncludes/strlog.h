/*
	File:		strlog.h

	Copyright:	© 1993-1996 by Mentat Inc., all rights reserved.

*/

#ifndef __STRLOG__
#define __STRLOG__

#ifndef __OPENTRANSPORT__
#include <OpenTransport.h>
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

struct log_ctl {
	short	mid;
	short	sid;
	char	level;
	short	flags;
	long	ltime;
	long	ttime;
	int_t	seq_no;
};

#define	SL_FATAL	0x1	/* Fatal error */
#define	SL_NOTIFY	0x2	/* Notify the system administrator */
#define	SL_ERROR	0x4	/* Pass message to error logger */
#define	SL_TRACE	0x8	/* Pass message to tracer */
#define	SL_CONSOLE	0x10	/* Print the message on the console */
#define	SL_WARN		0x20	/* Warning */
#define	SL_NOTE		0x40	/* Notice this message */

struct trace_ids {
	short	ti_mid;
	short	ti_sid;
	char	ti_level;
};

#ifndef MIOC_CMD
#include <miioccom.h>
#endif	/* MIOC_CMD */

#define	I_TRCLOG	MIOC_CMD(MIOC_STRLOG, 1)
#define	I_ERRLOG	MIOC_CMD(MIOC_STRLOG, 2)

#define	LOGMSGSZ	128

#ifdef __cplusplus
extern "C" {
#endif

extern	int_t	strlog( int_t mid, int_t sid, int_t level, uint_t flags, char* fmt, ...);

#ifdef __cplusplus
}
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#endif	/* _STRLOG_ */
