/*
	File:		stropts.h

	Copyright:	© 1991-1996 by Mentat Inc., all rights reserved.

*/

#ifndef __STROPTS__
#define __STROPTS__

#ifndef __OPENTRANSPORT__
#include <OpenTransport.h>
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif
#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

#define I_NREAD 		MIOC_CMD(MIOC_STREAMIO,1)		/* return the number of bytes in 1st msg */
#define I_PUSH			MIOC_CMD(MIOC_STREAMIO,2)		/* push module just below stream head */
#define I_POP			MIOC_CMD(MIOC_STREAMIO,3)		/* pop module below stream head */
#define I_LOOK			MIOC_CMD(MIOC_STREAMIO,4)		/* retrieve name of first stream module */
#define I_FLUSH 		MIOC_CMD(MIOC_STREAMIO,5)		/* flush all input and/or output queues */
#define I_SRDOPT		MIOC_CMD(MIOC_STREAMIO,6)		/* set the read mode */
#define I_GRDOPT		MIOC_CMD(MIOC_STREAMIO,7)		/* get the current read mode */
#define	I_STR			MIOC_CMD(MIOC_STREAMIO,8)		/* create an internal ioctl message			*/
#define I_SETSIG		MIOC_CMD(MIOC_STREAMIO,9)		/* request SIGPOLL signal on events */
#define I_GETSIG		MIOC_CMD(MIOC_STREAMIO,10)		/* query the registered events */
#define	I_FIND			MIOC_CMD(MIOC_STREAMIO,11)		/* check for module in stream				*/
#define I_LINK			MIOC_CMD(MIOC_STREAMIO,12)		/* connect stream under mux fd */
#define I_UNLINK		MIOC_CMD(MIOC_STREAMIO,13)		/* disconnect two streams */
#define I_PEEK			MIOC_CMD(MIOC_STREAMIO,15)		/* peek at data on read queue */
#define I_FDINSERT		MIOC_CMD(MIOC_STREAMIO,16)		/* create a message and send downstream */
#define I_SENDFD		MIOC_CMD(MIOC_STREAMIO,17)		/* send an fd to a connected pipe stream */
#define I_RECVFD		MIOC_CMD(MIOC_STREAMIO,18)		/* retrieve a file descriptor */
#define I_FLUSHBAND 	MIOC_CMD(MIOC_STREAMIO,19)		/* flush a particular input and/or output band */
#define I_SWROPT		MIOC_CMD(MIOC_STREAMIO,20)		/* set the write mode */
#define I_GWROPT		MIOC_CMD(MIOC_STREAMIO,21)		/* get the current write mode */
#define I_LIST			MIOC_CMD(MIOC_STREAMIO,22)		/* get a list of all modules on a stream	*/
#define I_ATMARK		MIOC_CMD(MIOC_STREAMIO,23)		/* check to see if the next message is "marked" */
#define I_CKBAND		MIOC_CMD(MIOC_STREAMIO,24)		/* check for a message of a particular band */
#define I_GETBAND		MIOC_CMD(MIOC_STREAMIO,25)		/* get the band of the next message to be read */
#define I_CANPUT		MIOC_CMD(MIOC_STREAMIO,26)		/* check to see if a message may be passed on a stream */
#define I_SETCLTIME 	MIOC_CMD(MIOC_STREAMIO,27)		/* set the close timeout wait */
#define I_GETCLTIME 	MIOC_CMD(MIOC_STREAMIO,28)		/* get the current close timeout wait */
#define I_PLINK 		MIOC_CMD(MIOC_STREAMIO,29)		/* permanently connect a stream under a mux */
#define I_PUNLINK		MIOC_CMD(MIOC_STREAMIO,30)		/* disconnect a permanent link */

/* ioctl values needed on non-SYS V systems */
#define I_GETMSG		MIOC_CMD(MIOC_STREAMIO,40)		/* getmsg() system call */
#define I_PUTMSG		MIOC_CMD(MIOC_STREAMIO,41)		/* putmsg() system call */
#define I_POLL			MIOC_CMD(MIOC_STREAMIO,42)		/* poll() system call */
#define I_SETDELAY		MIOC_CMD(MIOC_STREAMIO,43)		/* set blocking status */
#define I_GETDELAY		MIOC_CMD(MIOC_STREAMIO,44)		/* get blocking status */
#define I_RUN_QUEUES	MIOC_CMD(MIOC_STREAMIO,45)		/* sacrifice for the greater good */
#define I_GETPMSG		MIOC_CMD(MIOC_STREAMIO,46)		/* getpmsg() system call */
#define I_PUTPMSG		MIOC_CMD(MIOC_STREAMIO,47)		/* putpmsg() system call */
#define I_AUTOPUSH		MIOC_CMD(MIOC_STREAMIO,48)		/* for systems that cannot do the autopush in open */
#define I_PIPE			MIOC_CMD(MIOC_STREAMIO,49)		/* for pipe library call */
#define I_HEAP_REPORT	MIOC_CMD(MIOC_STREAMIO,50)		/* get heap statistics */
#define	I_FIFO			MIOC_CMD(MIOC_STREAMIO,51)		/* for fifo library call */

/* priority message request on putmsg() or strpeek */
#define RS_HIPRI		0x1

/* flags for getpmsg and putpmsg */
#define MSG_HIPRI		RS_HIPRI
#define MSG_BAND		0x2 			/* Retrieve a message from a particular band */
#define MSG_ANY 		0x4 			/* Retrieve a message from any band */

/* return values from getmsg(), 0 indicates all ok */
#define MORECTL 		0x1 	/* more control info available */
#define MOREDATA		0x2 	/* more data available */

#ifndef FMNAMESZ
#define FMNAMESZ		31	/* maximum length of a module or device name */
#endif

/* Infinite poll wait time */
#define INFTIM			-1

/* flush requests */
#define FLUSHR			0x1 			/* Flush the read queue */
#define FLUSHW			0x2 			/* Flush the write queue */
#define FLUSHRW 		(FLUSHW|FLUSHR) /* Flush both */
#define FLUSHBAND		0x40			/* Flush a particular band */

/* I_FLUSHBAND */
struct bandinfo 
{
	unsigned char	bi_pri; 		/* Band to flush */
	int_t 			bi_flag;		/* One of the above flush requests */
};

/* flags for I_ATMARK */
#define ANYMARK 		0x1 			/* Check if message is marked */
#define LASTMARK		0x2 			/* Check if this is the only message marked */

/* signal event masks */
#define S_INPUT 		0x1 	/* A non-M_PCPROTO message has arrived */
#define S_HIPRI 		0x2 	/* A priority (M_PCPROTO) message is available */
#define S_OUTPUT		0x4 	/* The write queue is no longer full */
#define S_MSG			0x8 	/* A signal message has reached the front of read queue */
#define S_RDNORM		0x10	/* A non-priority message is available */
#define S_RDBAND		0x20	/* A banded messsage is available */
#define S_WRNORM		0x40	/* Same as S_OUTPUT */
#define S_WRBAND		0x80	/* A priority band exists and is writable */
#define S_ERROR 		0x100	/* Error message has arrived */
#define S_HANGUP		0x200	/* Hangup message has arrived */
#define S_BANDURG		0x400	/* Use SIGURG instead of SIGPOLL on S_RDBAND signals */

/* read mode bits for I_S|GRDOPT; choose one of the following */
#define RNORM			0x01	/* byte-stream mode, default */
#define RMSGD			0x02	/* message-discard mode */
#define RMSGN			0x04	/* message-nondiscard mode */
#define RFILL			0x08	/* fill read buffer mode (PSE private) */

/* More read modes, these are bitwise or'ed with the modes above */
#define RPROTNORM		0x10	/* Normal handling of M_PROTO/M_PCPROTO messages, default */
#define RPROTDIS		0x20	/* Discard M_PROTO/M_PCPROTO message blocks */
#define RPROTDAT		0x40	/* Convert M_PROTO/M_PCPROTO message blocks into M_DATA */

/* write modes for I_S|GWROPT */
#define SNDZERO 		0x1 	/* Send a zero-length message downstream on a write of zero bytes */

#define MUXID_ALL		-1		/* Unlink all lower streams for I_UNLINK and I_PUNLINK */

struct strbuf 
{
	int_t 	maxlen; 		/* max buffer length */
	int_t 	len;			/* length of data */
	char*	buf;			/* pointer to buffer */
};

/* structure of ioctl data on I_FDINSERT */
struct strfdinsert 
{
	struct strbuf	ctlbuf;
	struct strbuf	databuf;
	long			flags;	/* type of message, 0 or RS_HIPRI */
	long			fildes; /* fd of other stream (FDCELL) */
	int_t 			offset; /* where to put other stream read qp */
};

/* I_LIST structures */
struct str_list 
{
	int_t 	sl_nmods;				/* number of modules in sl_modlist array */
	struct str_mlist* sl_modlist;
};

struct str_mlist 
{
	char	l_name[FMNAMESZ + 1];
};

/* I_PEEK structure */
struct strpeek 
{
	struct strbuf	ctlbuf;
	struct strbuf	databuf;
	long			flags;	/* if RS_HIPRI, get priority messages only */
};

struct strpmsg 				/* structure for getpmsg and putpmsg */
{
	struct strbuf	ctlbuf;
	struct strbuf	databuf;
	int_t 			band;
	long			flags;
};

/* structure of ioctl data on I_RECVFD */
struct strrecvfd 
{
	long			fd; 	/* new file descriptor (FDCELL) */
	unsigned short	uid;	/* user id of sending stream */
	unsigned short	gid;
	char			fill[8];
};

/* structure of ioctl data on I_STR */
struct strioctl 
{
	int_t 	ic_cmd; 		/* downstream command */
	int_t 	ic_timout;		/* ACK/NAK timeout */
	int_t 	ic_len; 		/* length of data arg */
	char*	ic_dp;		/* ptr to data arg */
};

#if !OTKERNEL

#ifdef __cplusplus
extern "C" {
#endif

pascal	int getmsg(int fd, struct strbuf* ctlbuf, struct strbuf* databuf, int* flagsp);
pascal	int putmsg(int fd, const struct strbuf* ctlbuf, const struct strbuf* databuf, int flags);
pascal	int getpmsg(int fd, struct strbuf* ctlbuf, struct strbuf* databuf, int* bandp, int* flagsp);
pascal	int putpmsg(int fd, const struct strbuf* ctlbuf, const struct strbuf* databuf, int band, int flags);
//
// These are here for compatibility with the rest of xti, but are not the preferred interfaces.
//
#ifdef __OPENTRANSPORT__
pascal int	stream_installnotifier(int fd, OTNotifyProcPtr, void* contextPtr);
pascal int	stream_blocking(int fd);
pascal int	stream_nonblocking(int fd);
pascal int	stream_isblocking(int fd);
pascal int	stream_synchronous(int fd);
pascal int	stream_asynchronous(int fd);
pascal int	stream_issynchronous(int fd);
#endif
pascal int	stream_open(char* path, unsigned long);
pascal int	stream_close(int fd);
pascal int	stream_read(int fd, void* buf, size_t len);
pascal int	stream_write(int fd, void* buf, size_t len);
	   int	stream_ioctl(int fd, unsigned long type, ...);
pascal int	stream_pipe(int*);
pascal int	poll(struct pollfd* fds, size_t nfds, unsigned long timeout);

#ifdef __cplusplus
}
#endif

#endif /* OTKERNEL */

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif
#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#endif	/* ifdef _STROPTS_ */

