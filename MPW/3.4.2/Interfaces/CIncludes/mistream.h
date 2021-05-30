/*
	File:		mistream.h

	Copyright:	© 1993-1996 by Mentat Inc., all rights reserved.

*/

#ifndef __MISTREAM__
#define __MISTREAM__

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if OTKERNEL

/* defines module or driver */
struct streamtab 
{
	struct qinit*	st_rdinit;		/* defines read QUEUE */
	struct qinit*	st_wrinit;		/* defines write QUEUE */
	struct qinit*	st_muxrinit;	/* for multiplexing drivers only */
	struct qinit*	st_muxwinit;	/* ditto */
};

typedef struct queue 
{
	struct qinit*	q_qinfo;	/* procedures and limits for queue */
	struct msgb* 	q_first;	/* head of message queue */
	struct msgb* 	q_last;		/* tail of message queue */
	struct queue*	q_next;		/* next queue in Stream */
	union 
	{
		struct queue*	q_u_link; 	/* link to scheduling queue */
		struct sqh_s*	q_u_sqh_parent;
	} q_u;
	char*			q_ptr;		/* to private data structure */
	unsigned long	q_count;	/* weighted count of characters on q */
	long			q_minpsz;	/* min packet size accepted */
	long			q_maxpsz;	/* max packet size accepted */
	unsigned long	q_hiwat;	/* high water mark, for flow control */
	unsigned long	q_lowat;	/* low water mark */
	struct qband*	q_bandp;	/* band information */
	unsigned short	q_flag; 	/* %%% queue state */
	unsigned char	q_nband;	/* %%% number of bands */
	unsigned char	q_pad1[1];	/* %%% reserved */
	struct q_xtra*	q_osx;		/* Pointer to OS-dependent extra stuff */
	struct queue*	q_ffcp;		/* Forward flow control pointer */
	struct queue*	q_bfcp;		/* Backward flow control pointer */
} queue_t;

#define q_link			q_u.q_u_link
#define q_sqh_parent	q_u.q_u_sqh_parent

/* queue_t flag defines */
#define QREADR					0x1 	/* This queue is a read queue */
#define QNOENB					0x2 	/* Don't enable in putq */
#define QFULL					0x4 	/* The queue is full */
#define QWANTR					0x8 	/* The queue should be scheduled in the next putq */
#define QWANTW					0x10	/* The stream should be back enabled when this queue drains */
#define QUSE					0x20	/* The queue is allocated and ready for use */
#define QENAB					0x40	/* The queue is scheduled (on the run queue) */
#define QBACK					0x80	/* The queue has been back enabled */
#define QOLD					0x100	/* Module supports old style opens and closes */
#define QHLIST					0x200	/* The Stream head is doing something with this queue (Not supported by MPS) */
#define QWELDED 				0x400	/* Mentat flag for welded queues */
#define	QUNWELDING				0x800	/* Queue is scheduled to be unwelded */
#define	QPROTECTED				0x1000	/* Mentat flag for unsafe q access */

typedef struct qband 
{
	struct qband*	qb_next;	/* next band for this queue */
	unsigned long	qb_count;	/* weighted count of characters in this band */ 
	struct msgb* 	qb_first; 	/* head of message queue */
	struct msgb* 	qb_last;	/* tail of message queue */
	unsigned long	qb_hiwat;	/* high water mark */
	unsigned long	qb_lowat;	/* low water mark */
	unsigned short	qb_flag;	/* %%% state */
	short			qb_pad1;	/* %%% reserved */
} qband_t;

/* qband_t flag defines */
#define QB_FULL 		0x1 			/* The band is full */
#define QB_WANTW		0x2 			/* The stream should be back enabled when this band/queue drains */
#define QB_BACK 		0x4 			/* The queue has been back enabled */

#ifdef __cplusplus
extern "C" {
#endif

typedef	int	(* putp_t)(queue_t *, struct msgb *);
typedef	int	(* srvp_t)(queue_t *);
typedef int (* admin_t)(void);
typedef void (* bufcall_t)(long);
typedef int	(* openp_t)(queue_t*, dev_t*, int, int, cred_t*);
typedef int (* closep_t)(queue_t*, int, cred_t*);
typedef int	(* openOld_t)(queue_t*, dev_t, int, int);
typedef int (* closeOld_t)(queue_t*);

#ifdef __cplusplus
}
#endif

struct qinit 
{
	putp_t		qi_putp;				/* put procedure */
	srvp_t		qi_srvp;				/* service procedure */
	openp_t		qi_qopen;				/* called on each open or a push */
	closep_t	qi_qclose; 				/* called on last close or a pop */
	admin_t		qi_qadmin; 				/* reserved for future use */
	struct module_info* qi_minfo;		/* information structure */
	struct module_stat* qi_mstat;		/* statistics structure - optional */
};

#if PRAGMA_ALIGN_SUPPORTED
	#if GENERATINGPOWERPC
	#pragma options align=power
	#endif
	#if GENERATING68K
	#pragma options align=mac68k
	#endif
#endif

struct module_info 
{
	unsigned short	mi_idnum;		/* module ID number */
	char*			mi_idname;		/* module name */
	long			mi_minpsz;		/* min pkt size, for developer use */
	long			mi_maxpsz;		/* max pkt size, for developer use */
	unsigned long	mi_hiwat;		/* hi-water mark, for flow control */
	unsigned long	mi_lowat;		/* lo-water mark, for flow control */
};

#if PRAGMA_ALIGN_SUPPORTED
	#pragma options align=reset
#endif

#else

typedef int	queue_t;

#endif	/* OTKERNEL */

/* message block */

typedef struct msgb 
{
	struct msgb* 	b_next;		/* next message on queue */
	struct msgb* 	b_prev;		/* previous message on queue */
	struct msgb* 	b_cont;		/* next message block of message */
	unsigned char*	b_rptr;		/* first unread data byte in buffer */
	unsigned char*	b_wptr;		/* first unwritten data byte */
	struct datab*	b_datap;	/* data block */
	unsigned char	b_band; 	/* message priority */
	unsigned char	b_pad1;
	unsigned short	b_flag;
#ifdef	MSGB_XTRA
	MSGB_XTRA
#endif
} mblk_t;

/* mblk flags */
#define MSGMARK 		0x01			/* last byte of message is tagged */
#define MSGNOLOOP		0x02			/* don't pass message to write-side of stream */
#define MSGDELIM		0x04			/* message is delimited */
#define MSGNOGET		0x08

/* data descriptor */

typedef struct datab 
{
	union 
	{
		struct datab*	freep;
		struct free_rtn* frtnp;
	} db_f;
	unsigned char*	db_base;		/* first byte of buffer */
	unsigned char*	db_lim;			/* last byte+1 of buffer */
	unsigned char	db_ref; 		/* count of messages pointing to block*/
	unsigned char	db_type;		/* message type */
	unsigned char	db_iswhat;		/* message status */
	unsigned char	db_filler2;		/* for spacing */
	unsigned int	db_size;		/* used internally */
	unsigned char*	db_msgaddr; 	/* used internally */
	long			db_filler;
} dblk_t;
#define db_freep		db_f.freep
#define db_frtnp		db_f.frtnp

/* Free return structure for esballoc */

#ifdef __cplusplus
extern "C" {
#endif

typedef struct free_rtn 
{
	void	(*free_func)(char* arg); 	/* Routine to call to free buffer */
	char*	free_arg; 							/* Parameter to free_func */
} frtn_t;

#ifdef __cplusplus
}
#endif

/* Message types */
#define QNORM			0
#define M_DATA			0				/* Ordinary data */
#define M_PROTO 		1				/* Internal control info and data */
#define M_BREAK 		010 			/* Request a driver to send a break */
#define M_PASSFP		011 			/* Used to pass a file pointer */
#define M_SIG			013 			/* Requests a signal to be sent */
#define M_DELAY 		014 			/* Request a real-time delay */
#define M_CTL			015 			/* For inter-module communication */
#define M_IOCTL 		016 			/* Used internally for I_STR requests */
#define M_SETOPTS		020 			/* Alters characteristics of Stream head */
#define M_RSE			021 			/* Reserved for internal use */

/* MPS private type */
#define M_MI			0100
#define M_MI_READ_RESET    1
#define M_MI_READ_SEEK	   2
#define M_MI_READ_END	   4

/* Priority messages types */
#define QPCTL			0200
#define M_IOCACK		0201			/* Positive ack of previous M_IOCTL */
#define M_IOCNAK		0202			/* Previous M_IOCTL failed */
#define M_PCPROTO		0203			/* Same as M_PROTO except for priority */
#define M_PCSIG 		0204			/* Priority signal */
#define M_FLUSH 		0206			/* Requests modules to flush queues */
#define M_STOP			0207			/* Request drivers to stop output */
#define M_START 		0210			/* Request drivers to start output */
#define M_HANGUP		0211			/* Driver can no longer produce data */
#define M_ERROR 		0212			/* Reports downstream error condition */
#define M_READ			0213			/* Reports client read at Stream head */
#define M_COPYIN		0214			/* Requests the Stream to copy data in for a module */
#define M_COPYOUT		0215			/* Requests the Stream to copy data out for a module */
#define M_IOCDATA		0216			/* Status from M_COPYIN/M_COPYOUT message */
#define M_PCRSE 		0220			/* Reserved for internal use */
#define M_STOPI 		0221			/* Request drivers to stop input */
#define M_STARTI		0222			/* Request drivers to start input */
#define M_HPDATA		0223			/* MPS-private type; high priority data */

/* Defines for flush messages */
#define FLUSHALL		1
#define FLUSHDATA		0

#define NOERROR 		-1				/* used in M_ERROR messages */

/* structure contained in M_COPYIN/M_COPYOUT messages */
struct copyreq 
{
	int 			cq_cmd; 		/* ioctl command (from ioc_cmd) */
	struct cred*	cq_cr;			/* pointer to full credentials */
	unsigned int	cq_id;			/* ioctl id (from ioc_id) */
	unsigned char*	cq_addr;		/* address to copy data to/from */
	unsigned int	cq_size;		/* number of bytes to copy */
	int 			cq_flag;		/* state */
	mblk_t*			cq_private;		/* private state information */
	long			cq_filler[4];
};
#define cq_uid	cq_cr->cr_uid
#define cq_gid	cq_cr->cr_gid

/* copyreq defines */
#define STRCANON		0x1 			/* b_cont data block contains canonical format specifier */
#define RECOPY			0x2 			/* perform I_STR copyin again this time using canonical format specifier */

/* structure contained in M_IOCDATA message block */
struct copyresp 
{
	int 			cp_cmd; 		/* ioctl command (from ioc_cmd) */
	struct cred*	cp_cr;			/* pointer to full credentials */
	unsigned int	cp_id;			/* ioctl id (from ioc_id) */
	unsigned char*	cp_rval;		/* status of request; 0 for success; error value for failure */
	unsigned int	cp_pad1;
	int 			cp_pad2;
	mblk_t*			cp_private;		/* private state information */
	long			cp_filler[4];
};
#define cp_uid	cp_cr->cr_uid
#define cp_gid	cp_cr->cr_gid

/* structure contained in an M_IOCTL message block */
struct iocblk 
{
	int 			ioc_cmd;		/* ioctl command type */
	struct cred*	ioc_cr;			/* pointer to full credentials */
	unsigned int	ioc_id; 		/* ioctl id */
	unsigned int	ioc_count;		/* count of bytes in data field */
	int 			ioc_error;		/* error code */
	int 			ioc_rval;		/* return value */
	long			ioc_filler[4];
};
#define ioc_uid ioc_cr->cr_uid
#define ioc_gid ioc_cr->cr_gid

#define TRANSPARENT 			((unsigned int)-1)		/* ioc_count value for transparent ioctl's */

/* Used in M_IOCTL mblks to muxes (ioc_cmd I_LINK) */
struct linkblk 
{
	struct queue* l_qtop;		/* lowest level write queue of upper stream */
	struct queue* l_qbot;		/* highest level write queue of lower stream */
	int 	l_index;		/* system-unique index for lower stream */
	long		l_pad[5];
};

/* structure contained in an M_PASSFP message block */
struct strpfp 
{
	unsigned long	pass_file_cookie;		/* file 'pointer' */
	unsigned short	pass_uid;				/* user id of sending stream */
	unsigned short	pass_gid;
	struct sth_s*	pass_sth; 			/* Stream head pointer of passed stream */
};

/* structure contained in an M_SETOPTS message block */
struct stroptions 
{
	unsigned long so_flags; /* options to set */
	short			so_readopt; 	/* read option */
	unsigned short	so_wroff;		/* write offset */
	long			so_minpsz;		/* minimum read packet size */
	long			so_maxpsz;		/* maximum read packet size */
	unsigned long	so_hiwat;		/* read queue high-water mark */
	unsigned long	so_lowat;		/* read queue low-water mark */
	unsigned char	so_band; 		/* band for water marks */
	unsigned char	so_filler[3];	/* added for alignment */
	unsigned long	so_poll_set;	/* poll events to set */
	unsigned long	so_poll_clr;	/* poll events to clear */
};
/* definitions for so_flags field */
#define SO_ALL			0x7fff	/* Update all options */
#define SO_READOPT		0x0001	/* Set the read mode */
#define SO_WROFF		0x0002	/* Insert an offset in write M_DATA mblks */
#define SO_MINPSZ		0x0004	/* Change the min packet size on sth rq */
#define SO_MAXPSZ		0x0008	/* Change the max packet size on sth rq */
#define SO_HIWAT		0x0010	/* Change the high water mark on sth rq */
#define SO_LOWAT		0x0020	/* Change the low water mark */
#define SO_MREADON		0x0040	/* Request M_READ messages */
#define SO_MREADOFF 	0x0080	/* Don't gen M_READ messages */
#define SO_NDELON		0x0100	/* old TTY semantics for O_NDELAY reads and writes */
#define SO_NDELOFF		0x0200	/* STREAMS semantics for O_NDELAY reads and writes */
#define SO_ISTTY		0x0400	/* Become a controlling tty */
#define SO_ISNTTY		0x0800	/* No longer a controlling tty */
#define SO_TOSTOP		0x1000	/* Stop on background writes */
#define SO_TONSTOP		0x2000	/* Don't stop on background writes */
#define SO_BAND 		0x4000	/* Water marks are for a band */
#define SO_POLL_SET		0x8000	/* Set events to poll */
#define SO_POLL_CLR		0x10000	/* Clear events to poll */

/* Buffer Allocation Priority */
#define BPRI_LO 		1
#define BPRI_MED		2
#define BPRI_HI 		3

#ifndef INFPSZ
#define INFPSZ			-1
#endif

/** Test whether message is a data message */
#define datamsg(type)	((type) == M_DATA || (type) == M_PROTO || (type) == M_PCPROTO  ||  (type) == M_DELAY)

#if OTKERNEL

/** Re-allow a queue to be scheduled for service */
#define enableok(q) 	((q)->q_flag &= ~QNOENB)

/** Prevent a queue from being scheduled */
#define noenable(q) 	((q)->q_flag |= QNOENB)

/** Get pointer to the mate queue */
#define OTHERQ(q)		(((q)->q_flag & QREADR) ? WR(q) : RD(q))

/** Get pointer to the read queue, assumes 'q' is a write queue ptr */
#define RD(q)	(&q[-1])

/** Get pointer to the write queue, assumes 'q' is a read queue ptr */
#define WR(q)	(&q[1])

#endif	/* OTKERNEL */

#define CLONEOPEN		0x2
#define MODOPEN 		0x1
#define OPENFAIL		-1

/* Enumeration values for strqget and strqset */
typedef enum qfields {
	QHIWAT	= 0,
	QLOWAT	= 1,
	QMAXPSZ	= 2,
	QMINPSZ	= 3,
	QCOUNT	= 4,
	QFIRST	= 5,
	QLAST	= 6,
	QFLAG	= 7,
	QBAD	= 8
} qfields_t;

#ifdef __cplusplus
extern "C" {
#endif

#if OTKERNEL

extern mblk_t*	allocb(size_t size, int pri);
extern queue_t*	allocq(void);
extern int		adjmsg(mblk_t*, int len_param);
extern queue_t*	backq(queue_t*);

extern int		bcanput(queue_t*, uchar_p pri);
extern int		bcanputnext(queue_t*, uchar_p pri);
extern int		bufcall(size_t memNeeded, int pri, bufcall_t,
						long context);
extern int		canput(queue_t*);
extern int		canputnext(queue_t*);
extern mblk_t*	copyb(mblk_t*);
extern mblk_t*	copymsg(mblk_t*);
extern mblk_t*	dupb(mblk_t*);
extern mblk_t*	dupmsg(mblk_t*);
extern mblk_t*	esballoc(unsigned char* base, size_t size, int pri, frtn_t*);
extern void		flushband(queue_t*, uchar_p pri, int flag);
extern void		flushq(queue_t*, int flag);
extern void		freeb(mblk_t*);
extern void		freemsg(mblk_t*);
extern int		freeq(queue_t*);
extern int		freezestr(queue_t*);
extern admin_t	getadmin(ushort_p mid);
extern unsigned short	getmid(char * name);
extern mblk_t*	getq(queue_t*);
extern int		insq(queue_t*, mblk_t* emp, mblk_t* nmp);
extern void		linkb(mblk_t* mp1, mblk_t* mp2);
extern int		msgdsize(const mblk_t*);
extern mblk_t*	msgpullup(mblk_t*, int len);
extern int		pullupmsg(mblk_t*, int len);
extern int		putbq(queue_t*, mblk_t*);
extern int		putctl(queue_t*, int type);
extern int		putnextctl(queue_t*, int type);
extern int		putctl1(queue_t*, int type, int c);
extern int		putnextctl1(queue_t*, int type, int c);
extern int		putctl2(queue_t*, int type, int c1, int c2);
#ifndef puthere
extern int		puthere(queue_t*, mblk_t*);
#endif
extern int		putnext(queue_t*,  mblk_t*);
extern int		putq(queue_t*, mblk_t*);
extern void		qenable(queue_t*);
extern void		qprocson(queue_t*);
extern void		qprocsoff(queue_t*);
extern int		qreply(queue_t*, mblk_t*);
extern int		qsize(queue_t*);
extern mblk_t*	rmvb(mblk_t * mp, mblk_t * bp);
extern void		rmvq(queue_t*, mblk_t*);
/* prototype for strlog in strlog.h */
extern int		strqget(queue_t*, qfields_t what, uchar_p pri, long* valp);
extern int		strqset(queue_t*, qfields_t what, uchar_p pri, long val);
extern int		testb(int size, int pri);
extern void		unbufcall(int id);
extern void		unfreezestr(queue_t * q, int oldpri);
extern mblk_t*	unlinkb(mblk_t*);

#endif	/* OTKERNEL */

#ifdef __cplusplus
}
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif


#endif	/* ifdef _MPS_STREAM_	*/
