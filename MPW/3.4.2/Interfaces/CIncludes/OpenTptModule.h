/*
	File:		OpenTptModule.h

	Contains:	headers for STREAM modules developement

	Copyright:	© 1993-1996 by Apple Computer, Inc. and Mentat Inc., all rights reserved.

*/

#ifndef __OPENTPTMODULE__
#define __OPENTPTMODULE__

#define OTKERNEL	1

#ifndef __OPENTPTCOMMON__
#include <OpenTptCommon.h>
#endif
/*
 * Some typedefs needed to include cred.h and mistream.h
 */
typedef UInt32	uid_t;
typedef UInt32	gid_t;
typedef UInt32	dev_t;

#ifndef __CRED__
#include <cred.h>
#endif
#ifndef __MISTREAM__
#include <mistream.h>
#endif
#ifndef __STROPTS__
#include <stropts.h>
#endif
#ifndef __STRLOG__
#include <strlog.h>
#endif

#ifndef __MEMORY__
#include <Memory.h>
#endif

#if defined(__MWERKS__) && GENERATING68K
#pragma pointers_in_D0
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

/*******************************************************************************
** Printing functions
********************************************************************************/

enum
{
	kOTPrintOnly		= 0,
	kOTPrintThenStop	= 1
};

#ifdef __cplusplus
extern "C" {
#endif

int OTKernelPrintf(int toDo, char* fmt, ...);

#define CE_CONT		0			/* Does kOTPrintOnly		*/
#define CE_WARN		1			/* Does kOTPrintThenStop	*/
#define	CE_PANIC	2			/* Does System Error 107	*/

void cmn_err(int type, char* fmt, ...);

#ifdef __cplusplus
}
#endif

/*******************************************************************************
** Function to convert the "long" value that comes back in some of the
** netbufs as a result code to the equivalent OSStatus
********************************************************************************/

typedef long					OTError;

#define GetEError(v)			((OTUnixErr)(((v) >> 16) & 0xffff))
#define GetXTIError(v)			((OTXTIErr)((v) & 0xffff))
#define MakeTPIEError(e)		((OTError)(((((UInt16)(e)) << 16) | TSYSERR)))
#define MakeDLPIEError(e)		((OTError)(((((UInt16)(e)) << 16) | DL_SYSERR)))
#define MakeXTIError(xti)		((OTError)(xti))
#define MakeOTError(xti, e)		((OTError)((xti) | ((UInt16)(e)) << 16))

#ifdef __cplusplus
extern "C" {
#endif

OSStatus OTErrorToOSStatus(OTError);
					
#ifdef __cplusplus
}
#endif

/*******************************************************************************
** Things need to be able to export a module
********************************************************************************/

/*	-------------------------------------------------------------------------
	Synchronization level codes.  These are supplied to modsw_install and
	stored in the appropriate tables.  sth_osr_open and
	sth_ipush use these to set up synch queue subordination for new devices
	and modules.
	------------------------------------------------------------------------- */

	enum
	{
		SQLVL_QUEUE			= 1,
		SQLVL_QUEUEPAIR		= 2,
		SQLVL_MODULE		= 3,
		SQLVL_GLOBAL		= 4,
	
		SQLVL_DEFAULT		= SQLVL_MODULE
	};

/*	-------------------------------------------------------------------------
	The install_info structure.
	------------------------------------------------------------------------- */

	struct install_info
	{
		struct streamtab*	install_str; 	/* Streamtab pointer.		*/
		UInt32 				install_flags;
		UInt32 				install_sqlvl;	/* Synchronization level.	*/
		char*				install_buddy;	/* Shared writer list buddy */
		long				ref_load;		/* Set to 0					*/
		UInt32				ref_count;		/* set to 0					*/
	};
	
	typedef struct install_info	install_info;
	
	//
	//	Flags used in the install_flags field
	//
	enum
	{
		 kOTModIsDriver			= 0x00000001,
		 kOTModIsModule			= 0x00000002,
		 
		 kOTModUpperIsTPI		= 0x00001000,
		 kOTModUpperIsDLPI		= 0x00002000,
		 kOTModLowerIsTPI		= 0x00004000,
		 kOTModLowerIsDLPI		= 0x00008000,
		//
		// This flag says you don't want per-context globals
		//
		kOTModGlobalContext		= 0x00800000,
		//
		// This flag is only valid if kOTModIsDriver is set
		// and the driver is a PCI-card driver using the Name Registry
		//
		kOTModUsesInterrupts	= 0x08000000,
		//
		// This flag is only valid if kOTModIsDriver is set.
		//
		kOTModIsComplexDriver	= 0x20000000,
		//
		// These flags are only valid if kOTModIsModule is set.
		//
		kOTModIsFilter			= 0x40000000
	};

#ifdef __cplusplus
extern "C" {
#endif
	
/*	-------------------------------------------------------------------------
	Typedef for the GetOTInstallInfo function
	
	Your module must export this function, and return a pointer to the
	install_info structure for the module.
	------------------------------------------------------------------------- */

	typedef install_info* (*GetOTInstallInfoProcPtr)(void);

/*	-------------------------------------------------------------------------
	Typedef for the InitStreamModule function
	
	Your module can optionally export this function.  It will be called 
	whenever your module is about to be loaded into a stream for the
	first time, or if it is about to be reloaded after having been 
	unloaded. Return false if your module should NOT be loaded.
	For STREAMS modules, the void* parameter will be NULL.  For drivers, it
	will be the same cookie parameter that was used for registering the module.
	For PCI card drivers, this will be a pointer to the OTPCIInfo structure,
	which can also be interpreted as a RegEntryIDPtr.
	------------------------------------------------------------------------- */
	
	typedef Boolean (*InitStreamModuleProcPtr)(void*);

/*	-------------------------------------------------------------------------
	Typedef for the TerminateStreamModule function
	
	Your module can optionally export this function.  It will be called 
	whenever your module has been closed for the last time (i.e. no other 
	outstanding instances of the module exist).
	------------------------------------------------------------------------- */
	
	typedef void (*TerminateStreamModuleProcPtr)(void*);

#ifdef __cplusplus
}
#endif

/*******************************************************************************
** Equates for shared library prefixes
********************************************************************************/

	/*
	 * Prefixes for Open Transport driver experts.
	 */
	#define kOTPortScannerPrefix		"ot:pScnr$"
	
	/*
	 * Interface ID for STREAMS Modules for ASLM
	 */
	#define kOTModuleInterfaceID		kOTModulePrefix "StrmMod"

/*******************************************************************************
** Functions for dealing with major and minor device numbers
********************************************************************************/

	typedef UInt16			major_t;
	typedef UInt16			minor_t;
	
	/* major part of a device */
	#define getmajor(x) 		((major_t)(((unsigned long)(x)>>16)&0xffff))
	
	/* minor part of a device */
	#define getminor(x) 		((minor_t)((x)&0xffff))
	
	/* make a device number */
	#define makedev(x,y)		((dev_t)((((dev_t)(x))<<16) | ((y) & 0xffff)))
	
	#define getemajor			getmajor
	#define geteminor			getminor
	#define makedevice			makedev
	
	#define	etoimajor(majnum)	(majnum)
	#define	itoemajor(majnum,j)	(majnum)

/*******************************************************************************
** Some definitions
********************************************************************************/

	/*
	 * The first minor number that you should use for CLONEOPENs.
	 * Minor numbers 0 through 9 are reserved for use by the modules
	 * for various control streams.
	 */
	 enum
	 {
	 	kFirstMinorNumber	= 10
	};

	/*
	 * Extra OTCommand codes that may appear on your module queue.
	 * These are extensions to the TPI specification for Open Transport.
	 * T_PRIVATE_REQ is the first available TPI message number for private
	 * use by modules (assuming you don't want to be confused by standard
	 * TPI messages).
	 */
	enum
	{
		T_TIMER_REQ		= 80,	// Timer event
		T_MIB_REQ		= 81,	// Request module's MIB
		T_MIB_ACK		= 82,	// The module's MIB is available
		
		T_PRIVATE_REQ	= 90	// The first private request available
	};

/*******************************************************************************
** Logging Macros
********************************************************************************/

#ifdef __cplusplus
extern "C" {
#endif

void			OTStrlog(queue_t*, int, int, const char*);

#ifdef __cplusplus
}
#endif
//
// These are enums for the level value
//
enum
{
	kOTLvlFatal				= 0,
	kOTLvlNonfatal			= 1,
	kOTLvlExtFatal			= 2,
	kOTLvlExtNonfatal		= 3,
	kOTLvlUserErr			= 4,
	kOTLvlInfoErr			= 5,
	kOTLvlInfoOnly			= 6
};

#define STRLOG(q, lvl, flags, str)		OTStrlog(q, lvl, flags, str)

#if qDebug
	#define STRLOG1(q, lvl, flags, str)	OTStrlog(q, lvl, flags, str)
#else
	#define STRLOG1(q, lvl, flags, str)
#endif

#if qDebug > 1 || qDebug2 > 1
	#define STRLOG2(q, lvl, flags, str)	OTStrlog(q, lvl, flags, str)
#else
	#define STRLOG2(q, lvl, flags, str)
#endif

/*******************************************************************************
** Structure definitions
**
** These go along with the extra definitions above.
********************************************************************************/

	struct  T_MIB_req
	{
		long	PRIM_type;		/* Always T_MIB_REQ */
	};
	
	struct  T_MIB_ack
	{
		long	PRIM_type;		/* Always T_MIB_ACK 	*/
		long	MIB_length;		/* MIB length 			*/		
		long	MIB_offset;		/* MIB Offset    		*/		
	};
	
	struct T_stream_timer
	{
		long		PRIM_type;	/* Always T_TIMER_REQ */
		union
		{
			long	USER_long;
			void*	USER_ptr;
	#ifndef __cplusplus
		}			USER_data;
	#else
		};
	#endif
	};

/*	-------------------------------------------------------------------------
	Internal port record structures
	------------------------------------------------------------------------- */

	/*	
	 * One TPortRecord is created for each instance of a port.
	 * For Instance 'enet' identifies an ethernet port.
	 * An TPortRecord for each ethernet card it finds, with an
	 * OTPortRef that will uniquely allow the ethernet driver to determine which
	 * port it is supposed to open on.
	 */

	typedef struct TPortRecord	TPortRecord;

	struct TPortRecord
	{
		OTLink					fLink;
		char*					fPortName;
		char*					fModuleName;
		char*					fResourceInfo;
		char*					fSlotID;
		struct TPortRecord*		fAlias;
		size_t					fNumChildren;
		OTPortRef*				fChildPorts;
		UInt32					fPortFlags;
		UInt32					fInfoFlags;
		UInt32					fCapabilities;
		OTPortRef				fRef;
		struct streamtab*		fStreamtab;
		void*					fContext;
		void*					fExtra;
	};

/*******************************************************************************
** "C" Interface routines
********************************************************************************/

#ifdef __cplusplus
extern "C" {
#endif

/*	-------------------------------------------------------------------------
	Interrupt control functions
	------------------------------------------------------------------------- */

#if USES68KINLINES
	//
	// MPS_INTR_STATE saves the current interrupt state
	// Its definition undoubtably changes with the definition
	// of mps intr enable/disable, so this typedef is
	// also inside the USE68KINLINES conditional.
	//
	typedef UInt8	MPS_INTR_STATE;
	//
	// Disable interrupts and save the state
	//
	#pragma parameter mps_intr_disable(__A0)
	void mps_intr_disable(MPS_INTR_STATE*) =
	{
		0x40C0, 			/*		move	sr,d0		*/
		0xE040,				/*		asr.w	#8,d0		*/
		0x007C, 0x0600,		/*		ori		#$600,sr	*/
		0x027C, 0xFEFF, 	/*		andi	#$FEFF,sr	*/
		0x1080				/* 		move.b d0,(a0) 		*/
	#if qDebug
		, 0x0200, 0x0070,	/*		andi.b	#$70,d0		*/
		0x0c00, 0x0070,		/*		cmpi.b	#$70,d0		*/
		0x6602,				/*		bne.s	@3			*/
		0xA9FF				/*		DebugBreak			*/
	#endif
	};
	//
	// Enable interrupts from the saved state
	//
	#pragma parameter mps_intr_enable(__A0)
	void mps_intr_enable(MPS_INTR_STATE* ptr) =
	{
	#if qDebug
		0x40C0, 			/*		move	sr,d0		*/
		0x0240, 0x0700,		/*		andi.w	#$700,d0	*/
		0x0C40, 0x0600,		/*		cmpi.w	#$600,d0	*/
		0x6702,				/* 		beq.s	@2	 		*/
		0xA9FF,				/* 		DebugBreak	 		*/
	#endif
		0x1010,				/* @2	move.b	(a0),d0		*/
	#if qDebug
		0x0200, 0x0070,		/*		andi.b	#$70,d0		*/
		0x0c00, 0x0070,		/*		cmpi.b	#$70,d0		*/
		0x6602,				/*		bne.s	@3			*/
		0xA9FF,				/*		DebugBreak			*/
		0x1010,				/* @3	move.b	(a0),d0		*/
	#endif
		0xE140,				/*		asl.w	#8,d0		*/
		0x46C0				/*		move	d0,sr 		*/
	};
#else
	
		typedef UInt8	MPS_INTR_STATE;

		void mps_intr_disable(MPS_INTR_STATE*);
		void mps_intr_enable(MPS_INTR_STATE*);

#endif

/*	-------------------------------------------------------------------------
	The kOTPortScannerInterfaceID define is what you need to add to your
	export file for the "interfaceID = " clause.  
	PortScanProcPtr is the typedef for the scanning function.
	Your port-scanning function must be exported by the name "OTScanPorts".
	Your port-scanning function set must use the prefix kOTPortScannerPrefix.
	------------------------------------------------------------------------- */
 
	#define kOTPortScannerInterfaceID			kOTKernelPrefix "pScnr"
	#define kOTPseudoPortScannerInterfaceID		kOTKernelPrefix "ppScnr"
	
#ifdef __cplusplus
extern "C" {
#endif

	typedef void (*PortScanProcPtr)(UInt32 scanType);

#ifdef __cplusplus
}
#endif

	enum	/* scanType */
	{
		kOTInitialScan			= 0,
		kOTScanAfterSleep		= 1
	};
			
/*	-------------------------------------------------------------------------
	Port Registration
	
	These routines can be used to register, find and iterate through the
	various ports on the machine
	------------------------------------------------------------------------- */
		//
		// Register a port. The name the port was registered under is returned in
		// the fPortName field.
		//
	extern OSStatus	OTRegisterPort(OTPortRecord* portInfo, void* ref);
		//
		// Unregister the port with the given name (If you re-register the
		// port, it may get a different name - use OTChangePortState if
		// that is not desireable).  Since a single OTPortRef can be registered
		// with several names, the API needs to use the portName rather than
		// the OTPortRef to disambiguate.
		//
	extern OSStatus	OTUnregisterPort(const char* portName, void**);
		//
		// Change the state of the port.
		//
	extern OSStatus	OTChangePortState(OTPortRef, OTEventCode theChange, OTResult why);
		//
		// Find the TPortRecord for a given Port Name
		//
	TPortRecord*	OTFindPort(const char* portName);
		//
		// Find the "nth" TPortRecord
		//
	TPortRecord*	OTGetIndexedPort(size_t index);
		//
		// Find another port that is active and conflicts with
		// the port described by "ref"
		//
	TPortRecord*	OTFindPortConflict(OTPortRef ref);
		//
		// Other ways of finding the port
		//
	TPortRecord*	OTFindPortByRef(OTPortRef);
	TPortRecord*	OTFindPortByDev(dev_t);
		//
		// Memory allocation for OTRegisterPort persistent data
		//
	void*			OTAllocPortMem(size_t);
	void			OTFreePortMem(void*);
	
/*	-------------------------------------------------------------------------
	Timer functions
	------------------------------------------------------------------------- */

	enum
	{
		kOTMinimumTimerValue	= 8		// 8 milliseconds is the minimum timeout value
	};
	
	mblk_t*			mi_timer_q_switch(mblk_t*, queue_t*, mblk_t*);
	Boolean			mi_timer_cancel(mblk_t*);
	void			mi_timer(mblk_t*, unsigned long);
	mblk_t*			mi_timer_alloc(queue_t*, size_t);
	void			mi_timer_free(mblk_t*);
	Boolean			mi_timer_valid(mblk_t*);

/*	-------------------------------------------------------------------------
	Miscellaneous helpful routines
	------------------------------------------------------------------------- */
	/*
	 * This routine is used by a driver at interrupt time to schedule
	 * a deferred task or SWI to run their interrupt processing code.
	 */
	 Boolean OTScheduleDriverDeferredTask(long dtCookie);
	/*
	 * This is the typedef for a function that will be called when a message
	 * created by OTAllocMsg is destroyed.
	 */
#ifdef __cplusplus
extern "C" {
#endif

	typedef void	(*EsbFreeProcPtr)(char* arg);
	
#ifdef __cplusplus
}
#endif
	/*
	 * This function creates a message which points to "size" bytes of data
	 * at "buf".  When the message is freed, the EsbFreeProcPtr function "func"
	 * will be called with the argument "arg".
	 * NOTE: This function allows users of your buffer to modify the buffer.
	 */
	mblk_t* OTAllocMsg(void* buf, size_t size,  EsbFreeProcPtr func, void* arg);

	/*
	 * Routines to allocate and free memory in your modules (these are
	 * interrupt-time safe!). 
	 */

	void*	OTAllocMem(size_t);
	void	OTFreeMem(void*);
	void*	OTReallocMem(void* ptr, size_t newSize);

	/*
	 * Routines to calculate various sizes of STREAM messages
	 */
	#define HEAD_SIZE(mp)	((mp)->b_rptr - (mp)->b_datap->db_base)
	#define TAIL_SIZE(mp)	((mp)->b_datap->db_lim - (mp)->b_wptr)
	#define MBLK_SIZE(mp)	((mp)->b_wptr - (mp)->b_rptr)
	#define DBLK_SIZE(mp)	((mp)->b_datap->db_lim - (mp)->b_datap->db_base)
	
	#ifdef __cplusplus
	extern "C" {
	#endif
	
	int		mi_bcmp(const char* first, const char* second, size_t nBytes);
	int		mi_sprintf (char * buf, char * fmt, ...);
	
	#ifdef __cplusplus
	}
	#endif
	
	#define bcopy(s, d, l)			OTMemcpy(d, s, l)
	#define bzero(d, l)				OTMemzero(d, (size_t)(l))
	#define bcmp(s, d, l)			mi_bcmp(s, d, l)

	/*
	 * Standard STREAMS bcopy, bzero, & bcmp take char* parameters.
	 * The BCOPY, BZERO, and BCMP routines take void* so that we do not have
	 * to cast all the pointers.
	 */
	#define BCOPY(s, d, l)			bcopy((const char*)(s), (char*)(d), l)
	#define BZERO(d, l)				bzero((char*)(d), l)
	#define BCMP(s, d, l)			mi_bcmp((const char*)(s), (const char*)(d), l)

	/*
	 * Create sprintf and printf functions that will work in STREAM modules.
	 * Also, make sure that calling traditional "C" allocation routines
	 * will not compile.
	 */
	#define sprintf						mi_sprintf
	#define printf						OTKernelPrintf

	#define calloc						(DONT_CALL*THIS_FUNCTION)
	#define malloc						(DONT_CALL*THIS_FUNCTION)
	#define realloc						(DONT_CALL*THIS_FUNCTION)
	#define free						(DONT_CALL*THIS_FUNCTION)

	/*
	 * A few other miscellaneous functions
	 */
	int			drv_priv(struct cred* credp);
	queue_t*	mi_allocq(struct streamtab*);
	mblk_t*		mi_reallocb(mblk_t*, size_t new_Size);
	
#ifdef __cplusplus
}
#endif

/*******************************************************************************
** Some helpful utilites from Mentat
********************************************************************************/

#define	MI_COPY_IN		1
#define	MI_COPY_OUT		2
#define	MI_COPY_DIRECTION(mp)						     \
	(((UInt8*)&(mp)->b_cont->b_prev)[0])
#define	MI_COPY_COUNT(mp)				     \
	(((UInt8*)&(mp)->b_cont->b_prev)[1])
#define	MI_COPY_RVAL(mp)	(*(int *)&(mp)->b_cont->b_next)
#define	MI_COPY_CASE(dir,cnt)	((int)(((cnt)<<2)|dir))
#define	MI_COPY_STATE(mp)						     \
	((int)MI_COPY_CASE(MI_COPY_DIRECTION(mp),MI_COPY_COUNT(mp)))

#ifdef __cplusplus
extern "C" {
#endif

typedef void	(*OTWriterProcPtr)(queue_t*, mblk_t*);

void	mps_become_writer(queue_t* q, mblk_t* mp, OTWriterProcPtr proc);

mblk_t*	mi_tpi_ack_alloc(mblk_t* mp, size_t size, long);
mblk_t*	mi_tpi_conn_con(mblk_t* trailer_mp, char* src, size_t src_length, char* opt, size_t opt_length);
mblk_t*	mi_tpi_conn_ind(mblk_t* trailer_mp, char* src, size_t src_length, char* opt, size_t opt_length, int seqnum);
mblk_t*	mi_tpi_conn_req(mblk_t* trailer_mp, char* dest, size_t dest_length, char* opt, size_t opt_length);
mblk_t*	mi_tpi_data_ind(mblk_t* trailer_mp, int flags, long type);
mblk_t*	mi_tpi_data_req(mblk_t* trailer_mp, int flags, long type);
mblk_t*	mi_tpi_discon_ind(mblk_t* trailer_mp, int reason, int seqnum);
mblk_t*	mi_tpi_discon_req(mblk_t* trailer_mp, int seqnum);
mblk_t*	mi_tpi_err_ack_alloc(mblk_t* mp, int tlierr, int unixerr);
mblk_t*	mi_tpi_exdata_ind(mblk_t* trailer_mp, int flags, long type);
mblk_t*	mi_tpi_exdata_req(mblk_t* trailer_mp, int flags, long type);
mblk_t*	mi_tpi_info_req(void);
mblk_t*	mi_tpi_ok_ack_alloc(mblk_t* mp);
mblk_t*	mi_tpi_ordrel_ind(void);
mblk_t*	mi_tpi_ordrel_req(void);
mblk_t*	mi_tpi_uderror_ind(char* dest, size_t dest_length, char* opt, size_t opt_length, int error);
mblk_t*	mi_tpi_unitdata_ind(mblk_t* trailer_mp, char* src, size_t src_length, char* opt, size_t opt_length);
mblk_t*	mi_tpi_unitdata_req(mblk_t* trailer_mp, char* dst, size_t dst_length, char* opt, size_t opt_length);
mblk_t* mi_reuse_proto(mblk_t* toReuse, size_t sizeDesired, boolean_p keepOnError);

mblk_t* mi_reallocb(mblk_t* old_mp, size_t new_size);

Boolean	mi_set_sth_hiwat(queue_t* q, size_t size);
Boolean	mi_set_sth_lowat(queue_t* q, size_t size);
Boolean	mi_set_sth_maxblk(queue_t* q, size_t size);
Boolean	mi_set_sth_wroff(queue_t* q, size_t size);

UInt8* mi_offset_param(mblk_t* mp, long offset, long len);
UInt8* mi_offset_paramc(mblk_t* mp, long offset, long len);

char* mi_open_detached(char** mi_opp_orig, size_t size, dev_t* devp);
int mi_open_comm(char** mi_opp_orig, size_t size, queue_t* q, dev_t* dev,
				 int flag, int sflag, cred_t* credp);
int mi_close_comm(char** mi_opp_orig, queue_t* q);
void mi_bufcall(queue_t* q, size_t size, int pri);
void mi_detach(queue_t* q, char* ptr);
void mi_close_detached(char** mi_opp_orig, char* ptr);
char* mi_next_ptr(char*);

void mi_copyin(queue_t* q, mblk_t* mp, char* uaddr, size_t len);
void mi_copyout(queue_t* q, mblk_t* mp);
mblk_t* mi_copyout_alloc(queue_t* q, mblk_t* mp, char* uaddr, size_t len);
void mi_copy_done(queue_t* q, mblk_t* mp, int err);
void mi_copy_set_rval(mblk_t* mp, int rval);
int mi_copy_state(queue_t* q, mblk_t* mp, mblk_t** mpp);

#ifdef __cplusplus
}

/*******************************************************************************
** Everything below here is C++ ONLY
********************************************************************************/

/*	-------------------------------------------------------------------------
	TStreamQueue class
	
	This class is just a convenient interface to the queue structure
	------------------------------------------------------------------------- */

	class TStreamQueue : public queue
	{
		public:
			void		EnableQueue();
	};
	
	/*	-------------------------------------------------------------------------
		Inline methods for TStreamQueue
		------------------------------------------------------------------------- */
	
		inline void TStreamQueue::EnableQueue()
		{
			if ( q_flag & QNOENB )
			{
				enableok(this);
				if ( q_first )
					qenable(this);
			}
		}

/*	-------------------------------------------------------------------------
	Class TStreamMessage
	
	This class is a C++ interface to the mblk_t structure defined in STREAMS
	------------------------------------------------------------------------- */
	//
	// The maximum stream buffer size is the largest "size_t" that
	// doesn't look negative if interpreted as a signed number
	//
	enum
	{
		kMaxStreamBufferSize	= (((size_t)-1L) >> 1)
	};

	class TStreamMessage : public msgb
	{
		private:
				void*		operator new (size_t)	{ return NULL; }
				
		public:
				void*		operator new(size_t, size_t size)
					{ return (TStreamMessage*)allocb(size, 0); }
				void*		operator new(size_t, void* buf, size_t size,
										 EsbFreeProcPtr func, void* arg)
					{ return OTAllocMsg(buf, size, func, arg); }
				void		operator delete(void* ptr)
					{ if ( ptr != NULL ) freemsg((mblk_t*)ptr); }
	
					void			Reset(size_t = 0);
					void			ResetWithLeader(size_t);
			
					void			FreeData();
					TStreamMessage*	RemoveData();
					void			AppendData(TStreamMessage* data);
			
					size_t			GetSize() const;
					size_t			GetDataSize() const;
					size_t			GetMessageDataSize() const;
					void			SetDataSize(size_t);
		
					void			SetType(UInt8);
					UInt8			GetType() const;
					TStreamMessage*	GetNextBlock() const;
					TStreamMessage*	ReuseMessage(size_t newSize, boolean_p keepOnFailure);
					
					void			SetNextBlock(TStreamMessage*);
					char*			GetDataPointer() const;
					Boolean			IsReuseable(size_t size) const;
			
					void			HideBytesAtFront(size_t);
					void			HideBytesAtEnd(size_t);
			//
			// The following functions ignore non-M_DATA blocks.
			//
					const TStreamMessage*
									_MDECL GetBlockAt(size_t& offset) const;
					const void*		_MDECL GetPointerTo(size_t offset, size_t* len) const;
					const void*		_MDECL GetPointerTo(size_t offset, size_t* len, void* bfr) const;
			//
			// This function makes a non-shared copy of any initial non-M_DATA block, and
			// then makes shared copies of the requested data.  It only assumes 1 leading
			// non-M_DATA block, but will skip any other non-M_DATA blocks while 
			// searching for data to copy.
			//
					TStreamMessage*	_MDECL MakeSharedCopy(size_t offset = 0, 
														  size_t len = kMaxStreamBufferSize);

					Boolean			_MDECL HasData() const;
					Boolean			_MDECL WriteData(void* buf, size_t len);
			//
			// These hide/remove the part of the data already read.  
			//
					TStreamMessage*	_MDECL ReadData(void* buf, size_t* len);
					size_t			_MDECL ReadControl(void* buf, size_t len);
	};
	
	/*	-------------------------------------------------------------------------
		Inline methods for TStreamMessage
		------------------------------------------------------------------------- */
	
		inline void TStreamMessage::Reset(size_t size)
		{
			b_rptr = b_datap->db_base;
			b_wptr = b_rptr + size;
		}
		
		inline size_t OTLengthWithLeader(size_t size)
		{
			return (size + 3) & ~3;
		}
		
		inline void TStreamMessage::ResetWithLeader(size_t size)
		{
			b_rptr = b_datap->db_lim - OTLengthWithLeader(size);
			b_wptr = b_rptr + size;
		}
		
		inline void TStreamMessage::FreeData()
		{
			if ( b_cont )
			{
				freemsg(b_cont);
				b_cont = NULL;
			}
		}
		
		inline TStreamMessage* TStreamMessage::RemoveData()
		{
			TStreamMessage* temp = (TStreamMessage*)b_cont;
			b_cont = NULL;
			return temp;
		}
		
		inline void TStreamMessage::AppendData(TStreamMessage* mp)
		{
			linkb(this, mp);
		}
	
		inline size_t TStreamMessage::GetSize() const
		{
			return b_datap->db_lim - b_datap->db_base;
		}
		
		inline size_t TStreamMessage::GetDataSize() const
		{
			return b_wptr - b_rptr;
		}
		
		inline size_t TStreamMessage::GetMessageDataSize() const
		{
			return (b_cont == NULL) ? 
				(b_datap->db_type == M_DATA ? (b_wptr - b_rptr) : 0) : msgdsize(this);
		}
	
		inline void TStreamMessage::SetDataSize(size_t size)
		{
			b_wptr = b_rptr + size;
		}
	
		inline void TStreamMessage::SetType(UInt8 type)
		{
			b_datap->db_type = type;
		}
	
		inline unsigned char TStreamMessage::GetType() const
		{
			return b_datap->db_type;
		}
		
		inline TStreamMessage* TStreamMessage::GetNextBlock() const
		{
			return (TStreamMessage*)b_cont;
		}
		
		inline void TStreamMessage::SetNextBlock(TStreamMessage* mp)
		{
			b_cont = (mblk_t*)mp;
		}
		
		inline char* TStreamMessage::GetDataPointer() const
		{
			return (char*)b_rptr;
		}
		
		inline Boolean TStreamMessage::IsReuseable(size_t size) const
		{
			return (b_datap->db_ref == 1 && GetSize() >= size);
		}
		
		inline void TStreamMessage::HideBytesAtFront(size_t len)
		{
			adjmsg(this, len);
		}
		
		inline void TStreamMessage::HideBytesAtEnd(size_t len)
		{
			adjmsg(this, -len);
		}

		inline TStreamMessage* TStreamMessage::ReuseMessage(size_t newSize, boolean_p keepOnFailure)
		{
			return (TStreamMessage*)mi_reuse_proto(this, newSize, keepOnFailure);
		}
		
/*	-------------------------------------------------------------------------
	TTimerMessage class
	
	This class implements an interface to the STREAM environment timer
	facilities.  A TTimerMessage will be placed on the queue of your choice
	when it's timer expires.
	------------------------------------------------------------------------- */

#if GENERATINGPOWERPC
	#define TIMER_BUG	1
#else
	#define TIMER_BUG	0
#endif

	class TTimerMessage : public TStreamMessage
	{
	#if TIMER_BUG
		private:
	#else
		public:
	#endif
			inline void* operator new(size_t, queue_t* q)
				{	return mi_timer_alloc(q, sizeof(T_stream_timer)); }
			inline void* operator new(size_t, queue_t* q, size_t extra)
				{	return mi_timer_alloc(q, extra + sizeof(T_stream_timer)); }
	
			inline void operator delete(void* ptr)
				{	if ( ptr != NULL ) mi_timer_free((mblk_t*)ptr); }
	
		public:		
					Boolean			IsValid();
					TTimerMessage*	ChangeQueue(TStreamQueue* newQ, TTimerMessage* newMP);
					Boolean			Cancel();
					void			Schedule(OTTimeout time);
	
		private:
			inline void* operator new(size_t)
				{	return 0; }
	};
	
	inline TTimerMessage* NewTimerMsg(queue_t* q, size_t extra = 0)
	{
		return (TTimerMessage*)mi_timer_alloc(q, sizeof(T_stream_timer) + extra);
	}
	
	inline void FreeTimerMsg(TTimerMessage* msg)
	{
		mi_timer_free(msg);
	}
	
	/*	-------------------------------------------------------------------------
		Inline methods for TStreamTimer
		------------------------------------------------------------------------- */
	
		inline Boolean TTimerMessage::IsValid()
		{
			return mi_timer_valid(this);
		}
		
		inline TTimerMessage* TTimerMessage::ChangeQueue(TStreamQueue* q, TTimerMessage* newMP)
		{
			return( (TTimerMessage*) mi_timer_q_switch(this, q, newMP));
		}
	
		inline Boolean TTimerMessage::Cancel()
		{
			return mi_timer_cancel(this);
		}
		
		inline void TTimerMessage::Schedule(OTTimeout time)
		{
			((T_stream_timer*)b_rptr)->PRIM_type = T_TIMER_REQ;
			mi_timer(this, (unsigned long)time);
		}

#endif	/* __cplusplus	*/

#if defined(__MWERKS__) && GENERATING68K
#pragma pointers_in_A0
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif
	
#endif	/* __OPENTPTMODULE__	*/
