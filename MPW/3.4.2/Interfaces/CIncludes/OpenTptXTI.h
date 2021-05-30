/*
	File:		OpenTptXTI.h

	Contains:	Prototypes for XTI-compatible routines for
				Open Transport



*/

#ifndef __OPENTPTXTI__
#define __OPENTPTXTI__

#ifndef __OPENTRANSPORT__
#include <OpenTransport.h>
#endif
	
#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif
#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

/*******************************************************************************
** Global Variables
********************************************************************************/
					
extern int	t_errno;

/*******************************************************************************
** Structures
**
** WARNING: These structures will only work if "int"s are the
**			same size as "size_t", "long", and "UInt32"
********************************************************************************/

struct netbuf
{
	unsigned int	maxlen;
	unsigned int	len;
	char*			buf;
};

struct t_bind 
{
	struct netbuf		addr;
	unsigned			qlen;
};

struct t_optmgmt 
{
	struct netbuf	opt;
	long			flags;
};

struct t_discon 
{
	struct netbuf	udata;
	int 			reason;
	int 			sequence;
};

struct t_call 
{
	struct netbuf	addr;
	struct netbuf	opt;
	struct netbuf	udata;
	int 			sequence;
};

struct t_unitdata 
{
	struct netbuf	addr;
	struct netbuf	opt;
	struct netbuf	udata;
};

struct t_uderr 
{
	struct netbuf	addr;
	struct netbuf	opt;
	long			error;
};

/*	-------------------------------------------------------------------------
	Transaction data structures
	------------------------------------------------------------------------- */

struct t_request		
{
	struct netbuf	data;
	struct netbuf	opt;
	long			sequence;
};

struct t_reply		
{
	struct netbuf	data;
	struct netbuf	opt;
	long			sequence;
};

struct t_unitrequest
{
	struct netbuf	addr;
	struct netbuf	opt;
	struct netbuf	udata;
	long			sequence;
};

struct t_unitreply
{
	struct netbuf	opt;
	struct netbuf	udata;
	long			sequence;
};

struct t_opthdr
{
	unsigned long	len;		/* total length of option = sizeof(struct t_opthdr) +	*/
								/*						length of option value in bytes	*/
	unsigned long	level;		/* protocol affected */
	unsigned long	name;		/* option name */
	unsigned long	status;		/* status value */
								/* followed by the option value */
};


/*******************************************************************************
** XTI Interfaces
********************************************************************************/

#ifdef __cplusplus
extern "C" {
#endif

extern pascal int 	t_accept(int fd, int resfd, struct t_call* call);
extern pascal char* t_alloc(int fd, int struct_type, int fields);
extern pascal int 	t_bind(int fd, struct t_bind* req, struct t_bind* ret);
extern pascal int 	t_close(int fd);
extern pascal int 	t_connect(int fd, struct t_call* sndcall, struct t_call* rcvcall);
extern pascal int 	t_free(char* ptr, int struct_type);
extern pascal int 	t_getinfo(int fd, struct t_info* info);
extern pascal int 	t_getstate(int fd);
extern pascal int 	t_listen(int fd, struct t_call* call);
extern pascal int 	t_look(int fd);
extern pascal int 	t_open(char* path, int oflag, struct t_info* info);
extern pascal int	t_blocking(int fd);
extern pascal int	t_nonblocking(int fd);
extern pascal int 	t_optmgmt(int fd, struct t_optmgmt* req, struct t_optmgmt* ret);
extern pascal int 	t_rcv(int fd, char* buf, size_t nbytes, int* flags);
extern pascal int 	t_rcvconnect(int fd, struct t_call* call);
extern pascal int 	t_rcvdis(int fd, struct t_discon* discon);
extern pascal int 	t_rcvrel(int fd);
extern pascal int 	t_rcvudata(int fd, struct t_unitdata* unitdata, int* flags);
extern pascal int 	t_rcvuderr(int fd, struct t_uderr* uderr);
extern pascal int 	t_snd(int fd, char* buf, size_t nbytes, int flags);
extern pascal int 	t_snddis(int fd, struct t_call* call);
extern pascal int 	t_sndrel(int fd);
extern pascal int 	t_sndudata(int fd, struct t_unitdata* unitdata);
extern pascal int 	t_sync(int fd);
extern pascal int 	t_unbind(int fd);
extern pascal int 	t_error(char* errmsg);
extern pascal int 	t_getprotaddr(int fd, struct t_bind* boundaddr, struct t_bind* peeraddr);
//
// Apple extensions
//
extern pascal int	t_isnonblocking(int fd);
extern pascal int	t_asynchronous(int fd);
extern pascal int	t_synchronous(int fd);
extern pascal int	t_issynchronous(int fd);
extern pascal int	t_usesyncidleevents(int fd, int useEvents);
/*
** Not XTI standard functions, but extensions for transaction endpoints	
*/
extern pascal int	t_sndrequest(int fd, struct t_request*, int flags);
extern pascal int	t_rcvreply(int fd, struct t_reply*, int* flags);
extern pascal int	t_rcvrequest(int fd, struct t_request*, int* flags);
extern pascal int	t_sndreply(int fd, struct t_reply*, int flags);
extern pascal int	t_cancelrequest(int fd, long sequence);
extern pascal int	t_cancelreply(int fd, long sequence);

extern pascal int	t_sndurequest(int fd, struct t_unitrequest*, int flags);
extern pascal int	t_rcvureply(int fd, struct t_unitreply*, int* flags);
extern pascal int	t_rcvurequest(int fd, struct t_unitrequest*, int* flags);
extern pascal int	t_sndureply(int fd, struct t_unitreply*, int flags);
extern pascal int	t_cancelurequest(int fd, long sequence);
extern pascal int	t_cancelureply(int fd, long sequence);

extern pascal int	t_resolveaddr(int fd, struct t_bind* reqAddr, struct t_bind* retAddr, OTTimeout timeout);
extern pascal int	t_cancelsynchronouscalls(int fd);
extern pascal int	t_installnotifier(int fd, OTNotifyProcPtr proc, void* contextPtr);
extern pascal void	t_removenotifier(int fd);

#ifdef __cplusplus
}
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif
#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#endif	/* __OPENTRANSPORT__ */

