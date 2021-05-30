{
     File:       OpenTransportProtocol.p
 
     Contains:   Definitions likely to be used by low-level protocol stack implementation.
 
     Version:    Technology: 2.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1993-2001 by Apple Computer, Inc. and Mentat Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OpenTransportProtocol;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTRANSPORTPROTOCOL__}
{$SETC __OPENTRANSPORTPROTOCOL__ := 1}

{$I+}
{$SETC OpenTransportProtocolIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __CODEFRAGMENTS__}
{$I CodeFragments.p}
{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC UNDEFINED __OPENTRANSPORT__}
{$I OpenTransport.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$ifc not undefined __MWERKS and TARGET_CPU_68K}
    {$pragmac d0_pointers on}
{$endc}

{  ***** Setup Default Compiler Variables ***** }

{
   OTKERNEL is used to indicate whether the code is being built
   for the kernel environment.  It defaults to 0.  If you include
   "OpenTransportKernel.h" before including this file,
   it will be 1 and you will only be able to see stuff available
   to kernel code.
   As we've included "OpenTransport.h" and it defaults this variable
   to 0 if it's not already been defined, it should always be defined
   by the time we get here.  So we just assert that.  Assertions in
   header files!  Cool (-:
}

{$IFC UNDEFINED OTKERNEL }
{$ENDC}

{  ***** Shared Client Memory ***** }
{$IFC NOT OTKERNEL }
{
   These allocators allocate memory in the shared client pool,
   which is shared between all clients and is not disposed when
   a particular client goes away.  See DTS Technote •••
   "Understanding Open Transport Memory Management" for details.
}
{$IFC CALL_NOT_IN_CARBON }
{
 *  OTAllocSharedClientMem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTAllocSharedClientMem(size: OTByteCount): Ptr; C;

{
 *  OTFreeSharedClientMem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTFreeSharedClientMem(mem: UNIV Ptr); C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{  ***** UNIX Types ***** }
{$IFC CALL_NOT_IN_CARBON }
{
   On UNIX, uid_t and gid_t are defined to be big enough
   to hold a user ID and group ID respectively.  As Mac OS
   has no such concepts, we just define them as UInt32 place
   holders.
}

TYPE
	uid_t								= UInt32;
	gid_t								= UInt32;
	{  Similarly, dev_t is a UNIX type for denoting a device number. }
	dev_t								= UInt32;
	{  ***** From the Mentat "strstat.h" ***** }

	{	 module statistics structure 	}
	module_statPtr = ^module_stat;
	module_stat = RECORD
		ms_pcnt:				LONGINT;								{  count of calls to put proc  }
		ms_scnt:				LONGINT;								{  count of calls to service proc  }
		ms_ocnt:				LONGINT;								{  count of calls to open proc  }
		ms_ccnt:				LONGINT;								{  count of calls to close proc  }
		ms_acnt:				LONGINT;								{  count of calls to admin proc  }
		ms_xptr:				CStringPtr;								{  pointer to private statistics  }
		ms_xsize:				INTEGER;								{  length of private statistics buffer  }
	END;

	{  ***** From the Mentat "cred.h" ***** }

	credPtr = ^cred;
	cred = RECORD
		cr_ref:					UInt16;									{  reference count on processes using cred structures  }
		cr_ngroups:				UInt16;									{  number of groups in cr_groups  }
		cr_uid:					uid_t;									{  effective user id  }
		cr_gid:					gid_t;									{  effective group id  }
		cr_ruid:				uid_t;									{  real user id  }
		cr_rgid:				gid_t;									{  real group id  }
		cr_suid:				uid_t;									{  user id saved by exec  }
		cr_sgid:				gid_t;									{  group id saved by exec  }
		cr_groups:				ARRAY [0..0] OF gid_t;					{  supplementary groups list  }
	END;

	cred_t								= cred;
	cred_tPtr 							= ^cred_t;
	{	 Free return structure for esballoc 	}
{$IFC TYPED_FUNCTION_POINTERS}
	FreeFuncType = PROCEDURE(arg: CStringPtr); C;
{$ELSEC}
	FreeFuncType = ProcPtr;
{$ENDC}

	free_rtnPtr = ^free_rtn;
	free_rtn = RECORD
		free_func:				FreeFuncType;							{  Routine to call to free buffer  }
		free_arg:				CStringPtr;								{  Parameter to free_func  }
	END;

	frtn_t								= free_rtn;
	frtn_tPtr 							= ^frtn_t;
	{	 data descriptor 	}
	databPtr = ^datab;
	datab_db_fPtr = ^datab_db_f;
	datab_db_f = RECORD
		CASE INTEGER OF
		0: (
			freep:				databPtr;
			);
		1: (
			frtnp:				free_rtnPtr;
			);
	END;

	datab = RECORD
		db_f:					datab_db_f;
		db_base:				Ptr;									{  first byte of buffer  }
		db_lim:					Ptr;									{  last byte+1 of buffer  }
		db_ref:					SInt8;									{  count of messages pointing to block }
		db_type:				SInt8;									{  message type  }
		db_iswhat:				SInt8;									{  message status  }
		db_filler2:				SInt8;									{  for spacing  }
		db_size:				UInt32;									{  used internally  }
		db_msgaddr:				Ptr;									{  used internally  }
		db_filler:				LONGINT;
	END;

	dblk_t								= datab;
	dblk_tPtr 							= ^dblk_t;

	{	 message block 	}
	msgbPtr = ^msgb;
	msgb = RECORD
		b_next:					msgbPtr;								{  next message on queue  }
		b_prev:					msgbPtr;								{  previous message on queue  }
		b_cont:					msgbPtr;								{  next message block of message  }
		b_rptr:					Ptr;									{  first unread data byte in buffer  }
		b_wptr:					Ptr;									{  first unwritten data byte  }
		b_datap:				databPtr;								{  data block  }
		b_band:					SInt8;									{  message priority  }
		b_pad1:					SInt8;
		b_flag:					UInt16;
	END;

	mblk_t								= msgb;
	mblk_tPtr 							= ^mblk_t;
	{	 mblk flags 	}

CONST
	MSGMARK						= $01;							{  last byte of message is tagged  }
	MSGNOLOOP					= $02;							{  don't pass message to write-side of stream  }
	MSGDELIM					= $04;							{  message is delimited  }
	MSGNOGET					= $08;

	{  STREAMS environments are expected to define these constants in a public header file. }

	STRCTLSZ					= 256;							{  Maximum Control buffer size for messages    }
	STRMSGSZ					= 8192;							{  Maximum # data bytes for messages    }

	{	 Message types 	}
	QNORM						= 0;
	M_DATA						= 0;							{  Ordinary data  }
	M_PROTO						= 1;							{  Internal control info and data  }
	M_BREAK						= $08;							{  Request a driver to send a break  }
	M_PASSFP					= $09;							{  Used to pass a file pointer  }
	M_SIG						= $0B;							{  Requests a signal to be sent  }
	M_DELAY						= $0C;							{  Request a real-time delay  }
	M_CTL						= $0D;							{  For inter-module communication  }
	M_IOCTL						= $0E;							{  Used internally for I_STR requests  }
	M_SETOPTS					= $10;							{  Alters characteristics of Stream head  }
	M_RSE						= $11;							{  Reserved for internal use  }

	{	 MPS private type 	}
	M_MI						= $40;
	M_MI_READ_RESET				= 1;
	M_MI_READ_SEEK				= 2;
	M_MI_READ_END				= 4;

	{	 Priority messages types 	}
	QPCTL						= $80;
	M_IOCACK					= $81;							{  Positive ack of previous M_IOCTL  }
	M_IOCNAK					= $82;							{  Previous M_IOCTL failed  }
	M_PCPROTO					= $83;							{  Same as M_PROTO except for priority  }
	M_PCSIG						= $84;							{  Priority signal  }
	M_FLUSH						= $86;							{  Requests modules to flush queues  }
	M_STOP						= $87;							{  Request drivers to stop output  }
	M_START						= $88;							{  Request drivers to start output  }
	M_HANGUP					= $89;							{  Driver can no longer produce data  }
	M_ERROR						= $8A;							{  Reports downstream error condition  }
	M_READ						= $8B;							{  Reports client read at Stream head  }
	M_COPYIN					= $8C;							{  Requests the Stream to copy data in for a module  }
	M_COPYOUT					= $8D;							{  Requests the Stream to copy data out for a module  }
	M_IOCDATA					= $8E;							{  Status from M_COPYIN/M_COPYOUT message  }
	M_PCRSE						= $90;							{  Reserved for internal use  }
	M_STOPI						= $91;							{  Request drivers to stop input  }
	M_STARTI					= $92;							{  Request drivers to start input  }
	M_HPDATA					= $93;							{  MPS-private type; high priority data  }

	{	 Defines for flush messages 	}
	FLUSHALL					= 1;
	FLUSHDATA					= 0;


	NOERROR						= -1;							{  used in M_ERROR messages  }


TYPE
	sth_sPtr = ^sth_s;
	sth_s = RECORD
		dummy:					UInt32;
	END;

	sqh_sPtr = ^sqh_s;
	sqh_s = RECORD
		dummy:					UInt32;
	END;

	q_xtraPtr = ^q_xtra;
	q_xtra = RECORD
		dummy:					UInt32;
	END;

{$IFC OTKERNEL }
	{
	   module_info is aligned differently on 68K than
	   on PowerPC.  Yucky.  I can't defined a conditionalised
	   pad field because a) you can't conditionalise specific
	   fields in the interface definition language used to
	   create Universal Interfaces, and b) lots of code 
	   assigns C structured constants to global variables
	   of this type, and these assignments break if you
	   add an extra field to the type.  Instead, I
	   set the alignment appropriately before defining the 
	   structure.  The problem with doing that is that
	   the interface definition language doesn't allow
	   my to set the alignment in the middle of a file,
	   so I have to do this via "pass throughs".  This
	   works fine for the well known languages (C, Pascal),
	   but may cause problems for other languages (Java,
	   Asm).
	}
	module_infoPtr = ^module_info;
	module_info = RECORD
		mi_idnum:				UInt16;									{  module ID number  }
		mi_idname:				CStringPtr;								{  module name  }
		mi_minpsz:				LONGINT;								{  min pkt size, for developer use  }
		mi_maxpsz:				LONGINT;								{  max pkt size, for developer use  }
		mi_hiwat:				UInt32;									{  hi-water mark, for flow control  }
		mi_lowat:				UInt32;									{  lo-water mark, for flow control  }
	END;



	queuePtr = ^queue;
{$IFC TYPED_FUNCTION_POINTERS}
	admin_t = FUNCTION: OTInt32; C;
{$ELSEC}
	admin_t = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	bufcall_t = PROCEDURE(size: LONGINT); C;
{$ELSEC}
	bufcall_t = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	bufcallp_t = PROCEDURE(size: LONGINT); C;
{$ELSEC}
	bufcallp_t = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	closep_t = FUNCTION(q: queuePtr; foo: OTInt32; VAR cred: cred_t): OTInt32; C;
{$ELSEC}
	closep_t = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	old_closep_t = FUNCTION(q: queuePtr): OTInt32; C;
{$ELSEC}
	old_closep_t = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	openp_t = FUNCTION(q: queuePtr; VAR dev: dev_t; foo: OTInt32; bar: OTInt32; VAR cred: cred_t): OTInt32; C;
{$ELSEC}
	openp_t = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	openOld_t = FUNCTION(q: queuePtr; dev: dev_t; foo: OTInt32; bar: OTInt32): OTInt32; C;
{$ELSEC}
	openOld_t = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	old_openp_t = FUNCTION(q: queuePtr; dev: dev_t; foo: OTInt32; bar: OTInt32): OTInt32; C;
{$ELSEC}
	old_openp_t = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	closeOld_t = FUNCTION(q: queuePtr): OTInt32; C;
{$ELSEC}
	closeOld_t = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	putp_t = FUNCTION(q: queuePtr; VAR mp: msgb): OTInt32; C;
{$ELSEC}
	putp_t = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	srvp_t = FUNCTION(q: queuePtr): OTInt32; C;
{$ELSEC}
	srvp_t = ProcPtr;
{$ENDC}

	qinitPtr = ^qinit;
	qinit = RECORD
		qi_putp:				putp_t;									{  put procedure  }
		qi_srvp:				srvp_t;									{  service procedure  }
		qi_qopen:				openp_t;								{  called on each open or a push  }
		qi_qclose:				closep_t;								{  called on last close or a pop  }
		qi_qadmin:				admin_t;								{  reserved for future use  }
		qi_minfo:				module_infoPtr;							{  information structure  }
		qi_mstat:				module_statPtr;							{  statistics structure - optional  }
	END;

	{	 defines module or driver 	}
	streamtabPtr = ^streamtab;
	streamtab = RECORD
		st_rdinit:				qinitPtr;								{  defines read QUEUE  }
		st_wrinit:				qinitPtr;								{  defines write QUEUE  }
		st_muxrinit:			qinitPtr;								{  for multiplexing drivers only  }
		st_muxwinit:			qinitPtr;								{  ditto  }
	END;

	qbandPtr = ^qband;
	qband = RECORD
		qb_next:				qbandPtr;								{  next band for this queue  }
		qb_count:				UInt32;									{  weighted count of characters in this band  }
		qb_first:				msgbPtr;								{  head of message queue  }
		qb_last:				msgbPtr;								{  tail of message queue  }
		qb_hiwat:				UInt32;									{  high water mark  }
		qb_lowat:				UInt32;									{  low water mark  }
		qb_flag:				UInt16;									{  ••• state  }
		qb_pad1:				INTEGER;								{  ••• reserved  }
	END;

	qband_t								= qband;
	qband_tPtr 							= ^qband_t;
	queue_q_uPtr = ^queue_q_u;
	queue_q_u = RECORD
		CASE INTEGER OF
		0: (
			q_u_link:			queuePtr;								{  link to scheduling queue  }
			);
		1: (
			q_u_sqh_parent:		sqh_sPtr;
			);
	END;

	queue = RECORD
		q_qinfo:				qinitPtr;								{  procedures and limits for queue  }
		q_first:				msgbPtr;								{  head of message queue  }
		q_last:					msgbPtr;								{  tail of message queue  }
		q_next:					queuePtr;								{  next queue in Stream  }
		q_u:					queue_q_u;
		q_ptr:					CStringPtr;								{  to private data structure  }
		q_count:				UInt32;									{  weighted count of characters on q  }
		q_minpsz:				LONGINT;								{  min packet size accepted  }
		q_maxpsz:				LONGINT;								{  max packet size accepted  }
		q_hiwat:				UInt32;									{  high water mark, for flow control  }
		q_lowat:				UInt32;									{  low water mark  }
		q_bandp:				qbandPtr;								{  band information  }
		q_flag:					UInt16;									{  ••• queue state  }
		q_nband:				SInt8;									{  ••• number of bands  }
		q_pad1:					SInt8;									{  ••• reserved  }
		q_osx:					q_xtraPtr;								{  Pointer to OS-dependent extra stuff  }
		q_ffcp:					queuePtr;								{  Forward flow control pointer  }
		q_bfcp:					queuePtr;								{  Backward flow control pointer  }
	END;

	queue_t								= queue;
	queue_tPtr 							= ^queue_t;

	{	 queue_t flag defines 	}

CONST
	QREADR						= $01;							{  This queue is a read queue  }
	QNOENB						= $02;							{  Don't enable in putq  }
	QFULL						= $04;							{  The queue is full  }
	QWANTR						= $08;							{  The queue should be scheduled in the next putq  }
	QWANTW						= $10;							{  The stream should be back enabled when this queue drains  }
	QUSE						= $20;							{  The queue is allocated and ready for use  }
	QENAB						= $40;							{  The queue is scheduled (on the run queue)  }
	QBACK						= $80;							{  The queue has been back enabled  }
	QOLD						= $0100;						{  Module supports old style opens and closes  }
	QHLIST						= $0200;						{  The Stream head is doing something with this queue (Not supported by MPS)  }
	QWELDED						= $0400;						{  Mentat flag for welded queues  }
	QUNWELDING					= $0800;						{  Queue is scheduled to be unwelded  }
	QPROTECTED					= $1000;						{  Mentat flag for unsafe q access  }
	QEXCOPENCLOSE				= $2000;						{  Queue wants exclusive open/close calls  }

	{	 qband_t flag defines 	}
	QB_FULL						= $01;							{  The band is full  }
	QB_WANTW					= $02;							{  The stream should be back enabled when this band/queue drains  }
	QB_BACK						= $04;							{  The queue has been back enabled  }

{$ELSEC}
	{
	   Client code views a queue_t as a simple cookie.
	   The real definition lives above and is only available
	   to kernel code.
	}
	queue_t								= SInt32;
    queue_tPtr = ^queue_t;
{$ENDC}  {OTKERNEL}
{ structure contained in M_COPYIN/M_COPYOUT messages }

TYPE
	caddr_t								= ^CHAR;
	copyreqPtr = ^copyreq;
	copyreq = RECORD
		cq_cmd:					SInt32;									{  ioctl command (from ioc_cmd)  }
		cq_cr:					credPtr;								{  pointer to full credentials  }
		cq_id:					UInt32;									{  ioctl id (from ioc_id)  }
		cq_addr:				caddr_t;								{  address to copy data to/from  }
		cq_size:				UInt32;									{  number of bytes to copy  }
		cq_flag:				SInt32;									{  state  }
		cq_private:				mblk_tPtr;								{  private state information  }
		cq_filler:				ARRAY [0..3] OF LONGINT;
	END;



	{	 copyreq defines 	}

CONST
	STRCANON					= $01;							{  b_cont data block contains canonical format specifier  }
	RECOPY						= $02;							{  perform I_STR copyin again this time using canonical format specifier  }

	{	 structure contained in M_IOCDATA message block 	}

TYPE
	copyrespPtr = ^copyresp;
	copyresp = RECORD
		cp_cmd:					SInt32;									{  ioctl command (from ioc_cmd)  }
		cp_cr:					credPtr;								{  pointer to full credentials  }
		cp_id:					UInt32;									{  ioctl id (from ioc_id)  }
		cp_rval:				caddr_t;								{  status of request; 0 for success; error value for failure  }
		cp_pad1:				UInt32;
		cp_pad2:				SInt32;
		cp_private:				mblk_tPtr;								{  private state information  }
		cp_filler:				ARRAY [0..3] OF LONGINT;
	END;


	{	 structure contained in an M_IOCTL message block 	}
	iocblkPtr = ^iocblk;
	iocblk = RECORD
		ioc_cmd:				SInt32;									{  ioctl command type  }
		ioc_cr:					credPtr;								{  pointer to full credentials  }
		ioc_id:					UInt32;									{  ioctl id  }
		ioc_count:				UInt32;									{  count of bytes in data field  }
		ioc_error:				SInt32;									{  error code  }
		ioc_rval:				SInt32;									{  return value  }
		ioc_filler:				ARRAY [0..3] OF LONGINT;
	END;





CONST
	kOTTRANSPARENT				= $FFFFFFFF;

	{	 Used in M_IOCTL mblks to muxes (ioc_cmd I_LINK) 	}

TYPE
	linkblkPtr = ^linkblk;
	linkblk = RECORD
		l_qtop:					queue_tPtr;								{  lowest level write queue of upper stream  }
		l_qbot:					queue_tPtr;								{  highest level write queue of lower stream  }
		l_index:				SInt32;									{  system-unique index for lower stream  }
		l_pad:					ARRAY [0..4] OF LONGINT;
	END;

	{	 structure contained in an M_PASSFP message block 	}
	strpfpPtr = ^strpfp;
	strpfp = RECORD
		pass_file_cookie:		UInt32;									{  file 'pointer'  }
		pass_uid:				UInt16;									{  user id of sending stream  }
		pass_gid:				UInt16;
		pass_sth:				sth_sPtr;								{  Stream head pointer of passed stream  }
	END;

	{	 structure contained in an M_SETOPTS message block 	}
	stroptionsPtr = ^stroptions;
	stroptions = RECORD
		so_flags:				UInt32;									{  options to set  }
		so_readopt:				INTEGER;								{  read option  }
		so_wroff:				UInt16;									{  write offset  }
		so_minpsz:				LONGINT;								{  minimum read packet size  }
		so_maxpsz:				LONGINT;								{  maximum read packet size  }
		so_hiwat:				UInt32;									{  read queue high-water mark  }
		so_lowat:				UInt32;									{  read queue low-water mark  }
		so_band:				SInt8;									{  band for water marks  }
		so_filler:				PACKED ARRAY [0..2] OF UInt8;			{  added for alignment  }
		so_poll_set:			UInt32;									{  poll events to set  }
		so_poll_clr:			UInt32;									{  poll events to clear  }
	END;

	{	 definitions for so_flags field 	}

CONST
	SO_ALL						= $7FFF;						{  Update all options  }
	SO_READOPT					= $0001;						{  Set the read mode  }
	SO_WROFF					= $0002;						{  Insert an offset in write M_DATA mblks  }
	SO_MINPSZ					= $0004;						{  Change the min packet size on sth rq  }
	SO_MAXPSZ					= $0008;						{  Change the max packet size on sth rq  }
	SO_HIWAT					= $0010;						{  Change the high water mark on sth rq  }
	SO_LOWAT					= $0020;						{  Change the low water mark  }
	SO_MREADON					= $0040;						{  Request M_READ messages  }
	SO_MREADOFF					= $0080;						{  Don't gen M_READ messages  }
	SO_NDELON					= $0100;						{  old TTY semantics for O_NDELAY reads and writes  }
	SO_NDELOFF					= $0200;						{  STREAMS semantics for O_NDELAY reads and writes  }
	SO_ISTTY					= $0400;						{  Become a controlling tty  }
	SO_ISNTTY					= $0800;						{  No longer a controlling tty  }
	SO_TOSTOP					= $1000;						{  Stop on background writes  }
	SO_TONSTOP					= $2000;						{  Don't stop on background writes  }
	SO_BAND						= $4000;						{  Water marks are for a band  }
	SO_POLL_SET					= $8000;						{  Set events to poll  }
	SO_POLL_CLR					= $00010000;					{  Clear events to poll  }

	{	 Buffer Allocation Priority 	}
	BPRI_LO						= 1;
	BPRI_MED					= 2;
	BPRI_HI						= 3;

	INFPSZ						= -1;



	CLONEOPEN					= $02;
	MODOPEN						= $01;
	OPENFAIL					= -1;


	{	 Enumeration values for strqget and strqset 	}

TYPE
	qfields 					= SInt32;
CONST
	QHIWAT						= 0;
	QLOWAT						= 1;
	QMAXPSZ						= 2;
	QMINPSZ						= 3;
	QCOUNT						= 4;
	QFIRST						= 5;
	QLAST						= 6;
	QFLAG						= 7;
	QBAD						= 8;


TYPE
	qfields_t							= qfields;
{$ENDC}  {CALL_NOT_IN_CARBON}

{  ***** From the Mentat "stropts.h" ***** }



CONST
	I_NREAD						= $4101;						{  return the number of bytes in 1st msg  }
	I_PUSH						= $4102;						{  push module just below stream head  }
	I_POP						= $4103;						{  pop module below stream head  }
	I_LOOK						= $4104;						{  retrieve name of first stream module  }
	I_FLUSH						= $4105;						{  flush all input and/or output queues  }
	I_SRDOPT					= $4106;						{  set the read mode  }
	I_GRDOPT					= $4107;						{  get the current read mode  }
	I_STR						= $4108;						{  create an internal ioctl message       }
	I_SETSIG					= $4109;						{  request SIGPOLL signal on events  }
	I_GETSIG					= $410A;						{  query the registered events  }
	I_FIND						= $410B;						{  check for module in stream           }
	I_LINK						= $410C;						{  connect stream under mux fd  }
	I_UNLINK					= $410D;						{  disconnect two streams  }
	I_PEEK						= $410F;						{  peek at data on read queue  }
	I_FDINSERT					= $4110;						{  create a message and send downstream  }
	I_SENDFD					= $4111;						{  send an fd to a connected pipe stream  }
	I_RECVFD					= $4112;						{  retrieve a file descriptor  }
	I_FLUSHBAND					= $4113;						{  flush a particular input and/or output band  }
	I_SWROPT					= $4114;						{  set the write mode  }
	I_GWROPT					= $4115;						{  get the current write mode  }
	I_LIST						= $4116;						{  get a list of all modules on a stream   }
	I_ATMARK					= $4117;						{  check to see if the next message is "marked"  }
	I_CKBAND					= $4118;						{  check for a message of a particular band  }
	I_GETBAND					= $4119;						{  get the band of the next message to be read  }
	I_CANPUT					= $411A;						{  check to see if a message may be passed on a stream  }
	I_SETCLTIME					= $411B;						{  set the close timeout wait  }
	I_GETCLTIME					= $411C;						{  get the current close timeout wait  }
	I_PLINK						= $411D;						{  permanently connect a stream under a mux  }
	I_PUNLINK					= $411E;						{  disconnect a permanent link  }
	I_GETMSG					= $4128;						{  getmsg() system call  }
	I_PUTMSG					= $4129;						{  putmsg() system call  }
	I_POLL						= $412A;						{  poll() system call  }
	I_SETDELAY					= $412B;						{  set blocking status  }
	I_GETDELAY					= $412C;						{  get blocking status  }
	I_RUN_QUEUES				= $412D;						{  sacrifice for the greater good  }
	I_GETPMSG					= $412E;						{  getpmsg() system call  }
	I_PUTPMSG					= $412F;						{  putpmsg() system call  }
	I_AUTOPUSH					= $4130;						{  for systems that cannot do the autopush in open  }
	I_PIPE						= $4131;						{  for pipe library call  }
	I_HEAP_REPORT				= $4132;						{  get heap statistics  }
	I_FIFO						= $4133;						{  for fifo library call  }

	{	 priority message request on putmsg() or strpeek 	}
	RS_HIPRI					= $01;

	{	 flags for getpmsg and putpmsg 	}
	MSG_HIPRI					= $01;
	MSG_BAND					= $02;							{  Retrieve a message from a particular band  }
	MSG_ANY						= $04;							{  Retrieve a message from any band  }

	{	 return values from getmsg(), 0 indicates all ok 	}
	MORECTL						= $01;							{  more control info available  }
	MOREDATA					= $02;							{  more data available  }


	FMNAMESZ					= 31;							{  maximum length of a module or device name  }


	{	 Infinite poll wait time 	}
	INFTIM						= $FFFFFFFF;

	{	 flush requests 	}
	FLUSHR						= $01;							{  Flush the read queue  }
	FLUSHW						= $02;							{  Flush the write queue  }
	FLUSHRW						= $03;							{  Flush both  }

	{
	   FLUSHBAND conflicts with flushband in "OpenTransportKernel.h"
	   in case-sensitive languages, so we define kOTFLUSHBAND instead.
	}
	kOTFLUSHBAND				= $40;							{  Flush a particular band  }

	{	 I_FLUSHBAND 	}

TYPE
	bandinfoPtr = ^bandinfo;
	bandinfo = RECORD
		bi_pri:					SInt8;									{  Band to flush  }
		pad1:					SInt8;
		bi_flag:				SInt32;									{  One of the above flush requests  }
	END;

	{	 flags for I_ATMARK 	}

CONST
	ANYMARK						= $01;							{  Check if message is marked  }
	LASTMARK					= $02;							{  Check if this is the only message marked  }

	{	 signal event masks 	}
	S_INPUT						= $01;							{  A non-M_PCPROTO message has arrived  }
	S_HIPRI						= $02;							{  A priority (M_PCPROTO) message is available  }
	S_OUTPUT					= $04;							{  The write queue is no longer full  }
	S_MSG						= $08;							{  A signal message has reached the front of read queue  }
	S_RDNORM					= $10;							{  A non-priority message is available  }
	S_RDBAND					= $20;							{  A banded messsage is available  }
	S_WRNORM					= $40;							{  Same as S_OUTPUT  }
	S_WRBAND					= $80;							{  A priority band exists and is writable  }
	S_ERROR						= $0100;						{  Error message has arrived  }
	S_HANGUP					= $0200;						{  Hangup message has arrived  }
	S_BANDURG					= $0400;						{  Use SIGURG instead of SIGPOLL on S_RDBAND signals  }

	{	 read mode bits for I_S|GRDOPT; choose one of the following 	}
	RNORM						= $01;							{  byte-stream mode, default  }
	RMSGD						= $02;							{  message-discard mode  }
	RMSGN						= $04;							{  message-nondiscard mode  }
	RFILL						= $08;							{  fill read buffer mode (PSE private)  }

	{	 More read modes, these are bitwise or'ed with the modes above 	}
	RPROTNORM					= $10;							{  Normal handling of M_PROTO/M_PCPROTO messages, default  }
	RPROTDIS					= $20;							{  Discard M_PROTO/M_PCPROTO message blocks  }
	RPROTDAT					= $40;							{  Convert M_PROTO/M_PCPROTO message blocks into M_DATA  }

	{	 write modes for I_S|GWROPT 	}
	SNDZERO						= $01;							{  Send a zero-length message downstream on a write of zero bytes  }

	MUXID_ALL					= -1;							{  Unlink all lower streams for I_UNLINK and I_PUNLINK  }

	{
	   strbuf is moved to "OpenTransport.h" because that header file
	   exports provider routines that take it as a parameter.
	}

	{	 structure of ioctl data on I_FDINSERT 	}

TYPE
	strfdinsertPtr = ^strfdinsert;
	strfdinsert = RECORD
		ctlbuf:					strbuf;
		databuf:				strbuf;
		flags:					LONGINT;								{  type of message, 0 or RS_HIPRI  }
		fildes:					LONGINT;								{  fd of other stream (FDCELL)  }
		offset:					SInt32;									{  where to put other stream read qp  }
	END;

	{	 I_LIST structures 	}
	str_mlistPtr = ^str_mlist;
	str_mlist = RECORD
		l_name:					PACKED ARRAY [0..31] OF CHAR;
	END;

	str_listPtr = ^str_list;
	str_list = RECORD
		sl_nmods:				SInt32;									{  number of modules in sl_modlist array  }
		sl_modlist:				str_mlistPtr;
	END;

	{	 I_PEEK structure 	}
	strpeekPtr = ^strpeek;
	strpeek = RECORD
		ctlbuf:					strbuf;
		databuf:				strbuf;
		flags:					LONGINT;								{  if RS_HIPRI, get priority messages only  }
	END;

	{	 structure for getpmsg and putpmsg 	}
	strpmsgPtr = ^strpmsg;
	strpmsg = RECORD
		ctlbuf:					strbuf;
		databuf:				strbuf;
		band:					SInt32;
		flags:					LONGINT;
	END;

	{	 structure of ioctl data on I_RECVFD 	}
	strrecvfdPtr = ^strrecvfd;
	strrecvfd = RECORD
		fd:						LONGINT;								{  new file descriptor (FDCELL)  }
		uid:					UInt16;									{  user id of sending stream  }
		gid:					UInt16;
		fill:					PACKED ARRAY [0..7] OF CHAR;
	END;

	{	 structure of ioctl data on I_STR 	}
	strioctlPtr = ^strioctl;
	strioctl = RECORD
		ic_cmd:					SInt32;									{  downstream command  }
		ic_timout:				SInt32;									{  ACK/NAK timeout  }
		ic_len:					SInt32;									{  length of data arg  }
		ic_dp:					CStringPtr;								{  ptr to data arg  }
	END;

	{  ***** From the Mentat "strlog.h" ***** }

	log_ctlPtr = ^log_ctl;
	log_ctl = RECORD
		mid:					INTEGER;
		sid:					INTEGER;
		level:					SInt8;
		pad1:					SInt8;
		flags:					INTEGER;
		ltime:					LONGINT;
		ttime:					LONGINT;
		seq_no:					SInt32;
	END;


CONST
	SL_FATAL					= $01;							{  Fatal error  }
	SL_NOTIFY					= $02;							{  Notify the system administrator  }
	SL_ERROR					= $04;							{  Pass message to error logger  }
	SL_TRACE					= $08;							{  Pass message to tracer  }
	SL_CONSOLE					= $00;							{  Console messages are disabled  }
	SL_WARN						= $20;							{  Warning  }
	SL_NOTE						= $40;							{  Notice this message  }


TYPE
	trace_idsPtr = ^trace_ids;
	trace_ids = RECORD
		ti_mid:					INTEGER;
		ti_sid:					INTEGER;
		ti_level:				SInt8;
	END;


CONST
	I_TRCLOG					= $6201;
	I_ERRLOG					= $6202;

	LOGMSGSZ					= 128;

	{  ***** From the Mentat "tihdr.h" ***** }

{$IFC CALL_NOT_IN_CARBON }

	{  TPI Primitives }


	kOTT_BIND_REQ				= 101;
	kOTT_CONN_REQ				= 102;							{  connection request  }
	kOTT_CONN_RES				= 103;							{  respond to connection indication  }
	kOTT_DATA_REQ				= 104;
	kOTT_DISCON_REQ				= 105;
	kOTT_EXDATA_REQ				= 106;
	kOTT_INFO_REQ				= 107;
	kOTT_OPTMGMT_REQ			= 108;
	kOTT_ORDREL_REQ				= 109;
	kOTT_UNBIND_REQ				= 110;
	kOTT_UNITDATA_REQ			= 111;
	kOTT_ADDR_REQ				= 112;							{  Get address request           }
	kOTT_UREQUEST_REQ			= 113;							{  UnitRequest (transaction) req   }
	kOTT_REQUEST_REQ			= 114;							{  Request (CO transaction) req      }
	kOTT_UREPLY_REQ				= 115;							{  UnitRequest (transaction) req   }
	kOTT_REPLY_REQ				= 116;							{  REPLY (CO transaction) req      }
	kOTT_CANCELREQUEST_REQ		= 117;							{  Cancel outgoing request          }
	kOTT_CANCELREPLY_REQ		= 118;							{  Cancel incoming request          }
	kOTT_REGNAME_REQ			= 119;							{  Request name registration       }
	kOTT_DELNAME_REQ			= 120;							{  Request delete name registration  }
	kOTT_LKUPNAME_REQ			= 121;							{  Request name lookup             }
	kOTT_BIND_ACK				= 122;
	kOTT_CONN_CON				= 123;							{  connection confirmation        }
	kOTT_CONN_IND				= 124;							{  incoming connection indication      }
	kOTT_DATA_IND				= 125;
	kOTT_DISCON_IND				= 126;
	kOTT_ERROR_ACK				= 127;
	kOTT_EXDATA_IND				= 128;
	kOTT_INFO_ACK				= 129;
	kOTT_OK_ACK					= 130;
	kOTT_OPTMGMT_ACK			= 131;
	kOTT_ORDREL_IND				= 132;
	kOTT_UNITDATA_IND			= 133;
	kOTT_UDERROR_IND			= 134;
	kOTT_ADDR_ACK				= 135;							{  Get address ack               }
	kOTT_UREQUEST_IND			= 136;							{  UnitRequest (transaction) ind   }
	kOTT_REQUEST_IND			= 137;							{  Request (CO transaction) ind    }
	kOTT_UREPLY_IND				= 138;							{  Incoming unit reply           }
	kOTT_REPLY_IND				= 139;							{  Incoming reply            }
	kOTT_UREPLY_ACK				= 140;							{  outgoing Unit Reply is complete     }
	kOTT_REPLY_ACK				= 141;							{  outgoing Reply is complete      }
	kOTT_RESOLVEADDR_REQ		= 142;
	kOTT_RESOLVEADDR_ACK		= 143;
	kOTT_LKUPNAME_CON			= 146;							{  Results of name lookup          }
	kOTT_LKUPNAME_RES			= 147;							{  Partial results of name lookup  }
	kOTT_REGNAME_ACK			= 148;							{  Request name registration       }
	kOTT_SEQUENCED_ACK			= 149;							{  Sequenced version of OK or ERROR ACK  }
	kOTT_EVENT_IND				= 160;							{  Miscellaneous event Indication      }

	{	 State values 	}
	TS_UNBND					= 1;
	TS_WACK_BREQ				= 2;
	TS_WACK_UREQ				= 3;
	TS_IDLE						= 4;
	TS_WACK_OPTREQ				= 5;
	TS_WACK_CREQ				= 6;
	TS_WCON_CREQ				= 7;
	TS_WRES_CIND				= 8;
	TS_WACK_CRES				= 9;
	TS_DATA_XFER				= 10;
	TS_WIND_ORDREL				= 11;
	TS_WREQ_ORDREL				= 12;
	TS_WACK_DREQ6				= 13;
	TS_WACK_DREQ7				= 14;
	TS_WACK_DREQ9				= 15;
	TS_WACK_DREQ10				= 16;
	TS_WACK_DREQ11				= 17;
	TS_WACK_ORDREL				= 18;
	TS_NOSTATES					= 19;
	TS_BAD_STATE				= 19;

	{	 Transport events 	}
	TE_OPENED					= 1;
	TE_BIND						= 2;
	TE_OPTMGMT					= 3;
	TE_UNBIND					= 4;
	TE_CLOSED					= 5;
	TE_CONNECT1					= 6;
	TE_CONNECT2					= 7;
	TE_ACCEPT1					= 8;
	TE_ACCEPT2					= 9;
	TE_ACCEPT3					= 10;
	TE_SND						= 11;
	TE_SNDDIS1					= 12;
	TE_SNDDIS2					= 13;
	TE_SNDREL					= 14;
	TE_SNDUDATA					= 15;
	TE_LISTEN					= 16;
	TE_RCVCONNECT				= 17;
	TE_RCV						= 18;
	TE_RCVDIS1					= 19;
	TE_RCVDIS2					= 20;
	TE_RCVDIS3					= 21;
	TE_RCVREL					= 22;
	TE_RCVUDATA					= 23;
	TE_RCVUDERR					= 24;
	TE_PASS_CONN				= 25;
	TE_BAD_EVENT				= 26;


TYPE
	T_addr_ackPtr = ^T_addr_ack;
	T_addr_ack = RECORD
		PRIM_type:				LONGINT;								{  Always T_ADDR_ACK  }
		LOCADDR_length:			LONGINT;
		LOCADDR_offset:			LONGINT;
		REMADDR_length:			LONGINT;
		REMADDR_offset:			LONGINT;
	END;

	T_addr_reqPtr = ^T_addr_req;
	T_addr_req = RECORD
		PRIM_type:				LONGINT;								{  Always T_ADDR_REQ  }
	END;

	T_bind_ackPtr = ^T_bind_ack;
	T_bind_ack = RECORD
		PRIM_type:				LONGINT;								{  always T_BIND_ACK  }
		ADDR_length:			LONGINT;
		ADDR_offset:			LONGINT;
		CONIND_number:			UInt32;
	END;

	T_bind_reqPtr = ^T_bind_req;
	T_bind_req = RECORD
		PRIM_type:				LONGINT;								{  always T_BIND_REQ  }
		ADDR_length:			LONGINT;
		ADDR_offset:			LONGINT;
		CONIND_number:			UInt32;
	END;

	T_conn_conPtr = ^T_conn_con;
	T_conn_con = RECORD
		PRIM_type:				LONGINT;								{  always T_CONN_CON  }
		RES_length:				LONGINT;								{  responding address length  }
		RES_offset:				LONGINT;
		OPT_length:				LONGINT;
		OPT_offset:				LONGINT;
	END;

	T_conn_indPtr = ^T_conn_ind;
	T_conn_ind = RECORD
		PRIM_type:				LONGINT;								{  always T_CONN_IND  }
		SRC_length:				LONGINT;
		SRC_offset:				LONGINT;
		OPT_length:				LONGINT;
		OPT_offset:				LONGINT;
		SEQ_number:				LONGINT;
	END;

	T_conn_reqPtr = ^T_conn_req;
	T_conn_req = RECORD
		PRIM_type:				LONGINT;								{  always T_CONN_REQ  }
		DEST_length:			LONGINT;
		DEST_offset:			LONGINT;
		OPT_length:				LONGINT;
		OPT_offset:				LONGINT;
	END;

	T_conn_resPtr = ^T_conn_res;
	T_conn_res = RECORD
		PRIM_type:				LONGINT;								{  always T_CONN_RES  }
		QUEUE_ptr:				queue_tPtr;
		OPT_length:				LONGINT;
		OPT_offset:				LONGINT;
		SEQ_number:				LONGINT;
	END;

	T_data_indPtr = ^T_data_ind;
	T_data_ind = RECORD
		PRIM_type:				LONGINT;								{  always T_DATA_IND  }
		MORE_flag:				LONGINT;
	END;

	T_data_reqPtr = ^T_data_req;
	T_data_req = RECORD
		PRIM_type:				LONGINT;								{  always T_DATA_REQ  }
		MORE_flag:				LONGINT;
	END;

	T_discon_indPtr = ^T_discon_ind;
	T_discon_ind = RECORD
		PRIM_type:				LONGINT;								{  always T_DISCON_IND  }
		DISCON_reason:			LONGINT;
		SEQ_number:				LONGINT;
	END;

	T_discon_reqPtr = ^T_discon_req;
	T_discon_req = RECORD
		PRIM_type:				LONGINT;								{  always T_DISCON_REQ  }
		SEQ_number:				LONGINT;
	END;

	T_exdata_indPtr = ^T_exdata_ind;
	T_exdata_ind = RECORD
		PRIM_type:				LONGINT;								{  always T_EXDATA_IND  }
		MORE_flag:				LONGINT;
	END;

	T_exdata_reqPtr = ^T_exdata_req;
	T_exdata_req = RECORD
		PRIM_type:				LONGINT;								{  always T_EXDATA_REQ  }
		MORE_flag:				LONGINT;
	END;

	T_error_ackPtr = ^T_error_ack;
	T_error_ack = RECORD
		PRIM_type:				LONGINT;								{  always T_ERROR_ACK  }
		ERROR_prim:				LONGINT;								{  primitive in error  }
		TLI_error:				LONGINT;
		UNIX_error:				LONGINT;
	END;

	T_info_ackPtr = ^T_info_ack;
	T_info_ack = RECORD
		PRIM_type:				LONGINT;								{  always T_INFO_ACK  }
		TSDU_size:				LONGINT;								{  max TSDU size  }
		ETSDU_size:				LONGINT;								{  max ETSDU size  }
		CDATA_size:				LONGINT;								{  connect data size  }
		DDATA_size:				LONGINT;								{  disconnect data size  }
		ADDR_size:				LONGINT;								{  TSAP size  }
		OPT_size:				LONGINT;								{  options size  }
		TIDU_size:				LONGINT;								{  TIDU size  }
		SERV_type:				LONGINT;								{  service type  }
		CURRENT_state:			LONGINT;								{  current state  }
		PROVIDER_flag:			LONGINT;								{  provider flags (see xti.h for defines)  }
	END;

	{	 Provider flags 	}

CONST
	SENDZERO					= $0001;						{  supports 0-length TSDU's  }
	XPG4_1						= $0002;						{  provider supports recent stuff  }


TYPE
	T_info_reqPtr = ^T_info_req;
	T_info_req = RECORD
		PRIM_type:				LONGINT;								{  always T_INFO_REQ  }
	END;

	T_ok_ackPtr = ^T_ok_ack;
	T_ok_ack = RECORD
		PRIM_type:				LONGINT;								{  always T_OK_ACK  }
		CORRECT_prim:			LONGINT;
	END;

	T_optmgmt_ackPtr = ^T_optmgmt_ack;
	T_optmgmt_ack = RECORD
		PRIM_type:				LONGINT;								{  always T_OPTMGMT_ACK  }
		OPT_length:				LONGINT;
		OPT_offset:				LONGINT;
		MGMT_flags:				LONGINT;
	END;

	T_optmgmt_reqPtr = ^T_optmgmt_req;
	T_optmgmt_req = RECORD
		PRIM_type:				LONGINT;								{  always T_OPTMGMT_REQ  }
		OPT_length:				LONGINT;
		OPT_offset:				LONGINT;
		MGMT_flags:				LONGINT;
	END;

	T_ordrel_indPtr = ^T_ordrel_ind;
	T_ordrel_ind = RECORD
		PRIM_type:				LONGINT;								{  always T_ORDREL_IND  }
	END;

	T_ordrel_reqPtr = ^T_ordrel_req;
	T_ordrel_req = RECORD
		PRIM_type:				LONGINT;								{  always T_ORDREL_REQ  }
	END;

	T_unbind_reqPtr = ^T_unbind_req;
	T_unbind_req = RECORD
		PRIM_type:				LONGINT;								{  always T_UNBIND_REQ  }
	END;

	T_uderror_indPtr = ^T_uderror_ind;
	T_uderror_ind = RECORD
		PRIM_type:				LONGINT;								{  always T_UDERROR_IND  }
		DEST_length:			LONGINT;
		DEST_offset:			LONGINT;
		OPT_length:				LONGINT;
		OPT_offset:				LONGINT;
		ERROR_type:				LONGINT;
	END;

	T_unitdata_indPtr = ^T_unitdata_ind;
	T_unitdata_ind = RECORD
		PRIM_type:				LONGINT;								{  always T_UNITDATA_IND  }
		SRC_length:				LONGINT;
		SRC_offset:				LONGINT;
		OPT_length:				LONGINT;
		OPT_offset:				LONGINT;
	END;

	T_unitdata_reqPtr = ^T_unitdata_req;
	T_unitdata_req = RECORD
		PRIM_type:				LONGINT;								{  always T_UNITDATA_REQ  }
		DEST_length:			LONGINT;
		DEST_offset:			LONGINT;
		OPT_length:				LONGINT;
		OPT_offset:				LONGINT;
	END;

	T_resolveaddr_ackPtr = ^T_resolveaddr_ack;
	T_resolveaddr_ack = RECORD
		PRIM_type:				LONGINT;								{  always T_RESOLVEADDR_ACK  }
		SEQ_number:				LONGINT;
		ADDR_length:			LONGINT;
		ADDR_offset:			LONGINT;
		ORIG_client:			LONGINT;
		ORIG_data:				LONGINT;
		TLI_error:				LONGINT;
		UNIX_error:				LONGINT;
	END;

	T_resolveaddr_reqPtr = ^T_resolveaddr_req;
	T_resolveaddr_req = RECORD
		PRIM_type:				LONGINT;								{  always T_RESOLVEADDR_REQ  }
		SEQ_number:				LONGINT;
		ADDR_length:			LONGINT;
		ADDR_offset:			LONGINT;
		ORIG_client:			LONGINT;
		ORIG_data:				LONGINT;
		MAX_milliseconds:		LONGINT;
	END;

	T_unitreply_indPtr = ^T_unitreply_ind;
	T_unitreply_ind = RECORD
		PRIM_type:				LONGINT;								{  Always T_UREPLY_IND  }
		SEQ_number:				LONGINT;
		OPT_length:				LONGINT;
		OPT_offset:				LONGINT;
		REP_flags:				LONGINT;
		TLI_error:				LONGINT;
		UNIX_error:				LONGINT;
	END;

	T_unitrequest_indPtr = ^T_unitrequest_ind;
	T_unitrequest_ind = RECORD
		PRIM_type:				LONGINT;								{  Always T_UREQUEST_IND  }
		SEQ_number:				LONGINT;
		SRC_length:				LONGINT;
		SRC_offset:				LONGINT;
		OPT_length:				LONGINT;
		OPT_offset:				LONGINT;
		REQ_flags:				LONGINT;
	END;

	T_unitrequest_reqPtr = ^T_unitrequest_req;
	T_unitrequest_req = RECORD
		PRIM_type:				LONGINT;								{  Always T_UREQUEST_REQ  }
		SEQ_number:				LONGINT;
		DEST_length:			LONGINT;
		DEST_offset:			LONGINT;
		OPT_length:				LONGINT;
		OPT_offset:				LONGINT;
		REQ_flags:				LONGINT;
	END;

	T_unitreply_reqPtr = ^T_unitreply_req;
	T_unitreply_req = RECORD
		PRIM_type:				LONGINT;								{  Always T_UREPLY_REQ  }
		SEQ_number:				LONGINT;
		OPT_length:				LONGINT;
		OPT_offset:				LONGINT;
		REP_flags:				LONGINT;
	END;

	T_unitreply_ackPtr = ^T_unitreply_ack;
	T_unitreply_ack = RECORD
		PRIM_type:				LONGINT;								{  Always T_UREPLY_ACK  }
		SEQ_number:				LONGINT;
		TLI_error:				LONGINT;
		UNIX_error:				LONGINT;
	END;

	T_cancelrequest_reqPtr = ^T_cancelrequest_req;
	T_cancelrequest_req = RECORD
		PRIM_type:				LONGINT;								{  Always T_CANCELREQUEST_REQ  }
		SEQ_number:				LONGINT;
	END;

	T_cancelreply_reqPtr = ^T_cancelreply_req;
	T_cancelreply_req = RECORD
		PRIM_type:				LONGINT;								{  Always T_CANCELREPLY_REQ  }
		SEQ_number:				LONGINT;
	END;

	T_reply_indPtr = ^T_reply_ind;
	T_reply_ind = RECORD
		PRIM_type:				LONGINT;								{  Always T_REPLY_IND  }
		SEQ_number:				LONGINT;
		OPT_length:				LONGINT;
		OPT_offset:				LONGINT;
		REP_flags:				LONGINT;
		TLI_error:				LONGINT;
		UNIX_error:				LONGINT;
	END;

	T_request_indPtr = ^T_request_ind;
	T_request_ind = RECORD
		PRIM_type:				LONGINT;								{  Always T_REQUEST_IND  }
		SEQ_number:				LONGINT;
		OPT_length:				LONGINT;
		OPT_offset:				LONGINT;
		REQ_flags:				LONGINT;
	END;

	T_request_reqPtr = ^T_request_req;
	T_request_req = RECORD
		PRIM_type:				LONGINT;								{  Always T_REQUEST_REQ  }
		SEQ_number:				LONGINT;
		OPT_length:				LONGINT;
		OPT_offset:				LONGINT;
		REQ_flags:				LONGINT;
	END;

	T_reply_reqPtr = ^T_reply_req;
	T_reply_req = RECORD
		PRIM_type:				LONGINT;								{  Always T_REPLY_REQ  }
		SEQ_number:				LONGINT;
		OPT_length:				LONGINT;
		OPT_offset:				LONGINT;
		REP_flags:				LONGINT;
	END;

	T_reply_ackPtr = ^T_reply_ack;
	T_reply_ack = RECORD
		PRIM_type:				LONGINT;								{  Always T_REPLY_ACK  }
		SEQ_number:				LONGINT;
		TLI_error:				LONGINT;
		UNIX_error:				LONGINT;
	END;

	T_regname_reqPtr = ^T_regname_req;
	T_regname_req = RECORD
		PRIM_type:				LONGINT;								{  Always T_REGNAME_REQ  }
		SEQ_number:				LONGINT;								{  Reply is sequence ack  }
		NAME_length:			LONGINT;
		NAME_offset:			LONGINT;
		ADDR_length:			LONGINT;
		ADDR_offset:			LONGINT;
		REQ_flags:				LONGINT;
	END;

	T_regname_ackPtr = ^T_regname_ack;
	T_regname_ack = RECORD
		PRIM_type:				LONGINT;								{  always T_REGNAME_ACK      }
		SEQ_number:				LONGINT;
		REG_id:					LONGINT;
		ADDR_length:			LONGINT;
		ADDR_offset:			LONGINT;
	END;

	T_delname_reqPtr = ^T_delname_req;
	T_delname_req = RECORD
		PRIM_type:				LONGINT;								{  Always T_DELNAME_REQ  }
		SEQ_number:				LONGINT;								{  Reply is sequence ack  }
		NAME_length:			LONGINT;
		NAME_offset:			LONGINT;
	END;

	T_lkupname_reqPtr = ^T_lkupname_req;
	T_lkupname_req = RECORD
		PRIM_type:				LONGINT;								{  Always T_LKUPNAME_REQ  }
		SEQ_number:				LONGINT;								{  Reply is sequence ack  }
		NAME_length:			LONGINT;								{  ... or T_LKUPNAME_CON  }
		NAME_offset:			LONGINT;
		ADDR_length:			LONGINT;
		ADDR_offset:			LONGINT;
		MAX_number:				LONGINT;
		MAX_milliseconds:		LONGINT;
		REQ_flags:				LONGINT;
	END;

	T_lkupname_conPtr = ^T_lkupname_con;
	T_lkupname_con = RECORD
		PRIM_type:				LONGINT;								{  Either T_LKUPNAME_CON  }
		SEQ_number:				LONGINT;								{  Or T_LKUPNAME_RES  }
		NAME_length:			LONGINT;
		NAME_offset:			LONGINT;
		RSP_count:				LONGINT;
		RSP_cumcount:			LONGINT;
	END;

	T_sequence_ackPtr = ^T_sequence_ack;
	T_sequence_ack = RECORD
		PRIM_type:				LONGINT;								{  always T_SEQUENCED_ACK      }
		ORIG_prim:				LONGINT;								{  original primitive         }
		SEQ_number:				LONGINT;
		TLI_error:				LONGINT;
		UNIX_error:				LONGINT;
	END;

	T_event_indPtr = ^T_event_ind;
	T_event_ind = RECORD
		PRIM_type:				LONGINT;								{  always T_EVENT_IND         }
		EVENT_code:				LONGINT;
		EVENT_cookie:			LONGINT;
	END;

	T_primitivesPtr = ^T_primitives;
	T_primitives = RECORD
		CASE INTEGER OF
		0: (
			primType:			LONGINT;
			);
		1: (
			taddrack:			T_addr_ack;
			);
		2: (
			tbindack:			T_bind_ack;
			);
		3: (
			tbindreq:			T_bind_req;
			);
		4: (
			tconncon:			T_conn_con;
			);
		5: (
			tconnind:			T_conn_ind;
			);
		6: (
			tconnreq:			T_conn_req;
			);
		7: (
			tconnres:			T_conn_res;
			);
		8: (
			tdataind:			T_data_ind;
			);
		9: (
			tdatareq:			T_data_req;
			);
		10: (
			tdisconind:			T_discon_ind;
			);
		11: (
			tdisconreq:			T_discon_req;
			);
		12: (
			texdataind:			T_exdata_ind;
			);
		13: (
			texdatareq:			T_exdata_req;
			);
		14: (
			terrorack:			T_error_ack;
			);
		15: (
			tinfoack:			T_info_ack;
			);
		16: (
			tinforeq:			T_info_req;
			);
		17: (
			tokack:				T_ok_ack;
			);
		18: (
			toptmgmtack:		T_optmgmt_ack;
			);
		19: (
			toptmgmtreq:		T_optmgmt_req;
			);
		20: (
			tordrelind:			T_ordrel_ind;
			);
		21: (
			tordrelreq:			T_ordrel_req;
			);
		22: (
			tunbindreq:			T_unbind_req;
			);
		23: (
			tuderrorind:		T_uderror_ind;
			);
		24: (
			tunitdataind:		T_unitdata_ind;
			);
		25: (
			tunitdatareq:		T_unitdata_req;
			);
		26: (
			tunitreplyind:		T_unitreply_ind;
			);
		27: (
			tunitrequestind:	T_unitrequest_ind;
			);
		28: (
			tunitrequestreq:	T_unitrequest_req;
			);
		29: (
			tunitreplyreq:		T_unitreply_req;
			);
		30: (
			tunitreplyack:		T_unitreply_ack;
			);
		31: (
			treplyind:			T_reply_ind;
			);
		32: (
			trequestind:		T_request_ind;
			);
		33: (
			trequestreq:		T_request_req;
			);
		34: (
			treplyreq:			T_reply_req;
			);
		35: (
			treplyack:			T_reply_ack;
			);
		36: (
			tcancelreqreq:		T_cancelrequest_req;
			);
		37: (
			tresolvereq:		T_resolveaddr_req;
			);
		38: (
			tresolveack:		T_resolveaddr_ack;
			);
		39: (
			tregnamereq:		T_regname_req;
			);
		40: (
			tregnameack:		T_regname_ack;
			);
		41: (
			tdelnamereq:		T_delname_req;
			);
		42: (
			tlkupnamereq:		T_lkupname_req;
			);
		43: (
			tlkupnamecon:		T_lkupname_con;
			);
		44: (
			tsequenceack:		T_sequence_ack;
			);
		45: (
			teventind:			T_event_ind;
			);
	END;

	{  ***** From the Mentat "dlpi.h" ***** }

	{
	   This header file has encoded the values so an existing driver
	   or user which was written with the Logical Link Interface(LLI)
	   can migrate to the DLPI interface in a binary compatible manner.
	   Any fields which require a specific format or value are flagged
	   with a comment containing the message LLI compatibility.
	}

	{  DLPI revision definition history }


CONST
	DL_CURRENT_VERSION			= $02;							{  current version of dlpi  }
	DL_VERSION_2				= $02;							{  version of dlpi March 12,1991  }


	DL_INFO_REQ					= $00;							{  Information Req, LLI compatibility  }
	DL_INFO_ACK					= $03;							{  Information Ack, LLI compatibility  }
	DL_ATTACH_REQ				= $0B;							{  Attach a PPA  }
	DL_DETACH_REQ				= $0C;							{  Detach a PPA  }
	DL_BIND_REQ					= $01;							{  Bind dlsap address, LLI compatibility  }
	DL_BIND_ACK					= $04;							{  Dlsap address bound, LLI compatibility  }
	DL_UNBIND_REQ				= $02;							{  Unbind dlsap address, LLI compatibility  }
	DL_OK_ACK					= $06;							{  Success acknowledgment, LLI compatibility  }
	DL_ERROR_ACK				= $05;							{  Error acknowledgment, LLI compatibility  }
	DL_SUBS_BIND_REQ			= $1B;							{  Bind Subsequent DLSAP address  }
	DL_SUBS_BIND_ACK			= $1C;							{  Subsequent DLSAP address bound  }
	DL_SUBS_UNBIND_REQ			= $15;							{  Subsequent unbind  }
	DL_ENABMULTI_REQ			= $1D;							{  Enable multicast addresses  }
	DL_DISABMULTI_REQ			= $1E;							{  Disable multicast addresses  }
	DL_PROMISCON_REQ			= $1F;							{  Turn on promiscuous mode  }
	DL_PROMISCOFF_REQ			= $20;							{  Turn off promiscuous mode  }
	DL_UNITDATA_REQ				= $07;							{  datagram send request, LLI compatibility  }
	DL_UNITDATA_IND				= $08;							{  datagram receive indication, LLI compatibility  }
	DL_UDERROR_IND				= $09;							{  datagram error indication, LLI compatibility  }
	DL_UDQOS_REQ				= $0A;							{  set QOS for subsequent datagram transmissions  }
	DL_CONNECT_REQ				= $0D;							{  Connect request  }
	DL_CONNECT_IND				= $0E;							{  Incoming connect indication  }
	DL_CONNECT_RES				= $0F;							{  Accept previous connect indication  }
	DL_CONNECT_CON				= $10;							{  Connection established  }
	DL_TOKEN_REQ				= $11;							{  Passoff token request  }
	DL_TOKEN_ACK				= $12;							{  Passoff token ack  }
	DL_DISCONNECT_REQ			= $13;							{  Disconnect request  }
	DL_DISCONNECT_IND			= $14;							{  Disconnect indication  }
	DL_RESET_REQ				= $17;							{  Reset service request  }
	DL_RESET_IND				= $18;							{  Incoming reset indication  }
	DL_RESET_RES				= $19;							{  Complete reset processing  }
	DL_RESET_CON				= $1A;							{  Reset processing complete  }
	DL_DATA_ACK_REQ				= $21;							{  data unit transmission request  }
	DL_DATA_ACK_IND				= $22;							{  Arrival of a command PDU  }
	DL_DATA_ACK_STATUS_IND		= $23;							{  Status indication of DATA_ACK_REQ }
	DL_REPLY_REQ				= $24;							{  Request a DLSDU from the remote  }
	DL_REPLY_IND				= $25;							{  Arrival of a command PDU  }
	DL_REPLY_STATUS_IND			= $26;							{  Status indication of REPLY_REQ  }
	DL_REPLY_UPDATE_REQ			= $27;							{  Hold a DLSDU for transmission  }
	DL_REPLY_UPDATE_STATUS_IND	= $28;							{  Status of REPLY_UPDATE req  }
	DL_XID_REQ					= $29;							{  Request to send an XID PDU  }
	DL_XID_IND					= $2A;							{  Arrival of an XID PDU  }
	DL_XID_RES					= $2B;							{  request to send a response XID PDU }
	DL_XID_CON					= $2C;							{  Arrival of a response XID PDU  }
	DL_TEST_REQ					= $2D;							{  TEST command request  }
	DL_TEST_IND					= $2E;							{  TEST response indication  }
	DL_TEST_RES					= $2F;							{  TEST response  }
	DL_TEST_CON					= $30;							{  TEST Confirmation  }
	DL_PHYS_ADDR_REQ			= $31;							{  Request to get physical addr  }
	DL_PHYS_ADDR_ACK			= $32;							{  Return physical addr  }
	DL_SET_PHYS_ADDR_REQ		= $33;							{  set physical addr  }
	DL_GET_STATISTICS_REQ		= $34;							{  Request to get statistics  }
	DL_GET_STATISTICS_ACK		= $35;							{  Return statistics  }

	{  DLPI interface states }
	DL_UNATTACHED				= $04;							{  PPA not attached  }
	DL_ATTACH_PENDING			= $05;							{  Waiting ack of DL_ATTACH_REQ  }
	DL_DETACH_PENDING			= $06;							{  Waiting ack of DL_DETACH_REQ  }
	DL_UNBOUND					= $00;							{  PPA attached, LLI compatibility  }
	DL_BIND_PENDING				= $01;							{  Waiting ack of DL_BIND_REQ, LLI compatibility  }
	DL_UNBIND_PENDING			= $02;							{  Waiting ack of DL_UNBIND_REQ, LLI compatibility  }
	DL_IDLE						= $03;							{  dlsap bound, awaiting use, LLI compatibility  }
	DL_UDQOS_PENDING			= $07;							{  Waiting ack of DL_UDQOS_REQ  }
	DL_OUTCON_PENDING			= $08;							{  outgoing connection, awaiting DL_CONN_CON  }
	DL_INCON_PENDING			= $09;							{  incoming connection, awaiting DL_CONN_RES  }
	DL_CONN_RES_PENDING			= $0A;							{  Waiting ack of DL_CONNECT_RES  }
	DL_DATAXFER					= $0B;							{  connection-oriented data transfer  }
	DL_USER_RESET_PENDING		= $0C;							{  user initiated reset, awaiting DL_RESET_CON  }
	DL_PROV_RESET_PENDING		= $0D;							{  provider initiated reset, awaiting DL_RESET_RES  }
	DL_RESET_RES_PENDING		= $0E;							{  Waiting ack of DL_RESET_RES  }
	DL_DISCON8_PENDING			= $0F;							{  Waiting ack of DL_DISC_REQ when in DL_OUTCON_PENDING  }
	DL_DISCON9_PENDING			= $10;							{  Waiting ack of DL_DISC_REQ when in DL_INCON_PENDING  }
	DL_DISCON11_PENDING			= $11;							{  Waiting ack of DL_DISC_REQ when in DL_DATAXFER  }
	DL_DISCON12_PENDING			= $12;							{  Waiting ack of DL_DISC_REQ when in DL_USER_RESET_PENDING  }
	DL_DISCON13_PENDING			= $13;							{  Waiting ack of DL_DISC_REQ when in DL_DL_PROV_RESET_PENDING  }
	DL_SUBS_BIND_PND			= $14;							{  Waiting ack of DL_SUBS_BIND_REQ  }
	DL_SUBS_UNBIND_PND			= $15;							{  Waiting ack of DL_SUBS_UNBIND_REQ  }

	{  DL_ERROR_ACK error return values }

	DL_ACCESS					= $02;							{  Improper permissions for request, LLI compatibility  }
	DL_BADADDR					= $01;							{  DLSAP address in improper format or invalid  }
	DL_BADCORR					= $05;							{  Sequence number not from outstanding DL_CONN_IND  }
	DL_BADDATA					= $06;							{  User data exceeded provider limit  }
	DL_BADPPA					= $08;							{  Specified PPA was invalid  }
	DL_BADPRIM					= $09;							{  Primitive received is not known by DLS provider  }
	DL_BADQOSPARAM				= $0A;							{  QOS parameters contained invalid values  }
	DL_BADQOSTYPE				= $0B;							{  QOS structure type is unknown or unsupported  }
	DL_BADSAP					= $00;							{  Bad LSAP selector, LLI compatibility  }
	DL_BADTOKEN					= $0C;							{  Token used not associated with an active stream  }
	DL_BOUND					= $0D;							{  Attempted second bind with dl_max_conind or     }
																{     dl_conn_mgmt > 0 on same DLSAP or PPA  }
	DL_INITFAILED				= $0E;							{  Physical Link initialization failed  }
	DL_NOADDR					= $0F;							{  Provider couldn't allocate alternate address  }
	DL_NOTINIT					= $10;							{  Physical Link not initialized  }
	DL_OUTSTATE					= $03;							{  Primitive issued in improper state, LLI compatibility  }
	DL_SYSERR					= $04;							{  UNIX system error occurred, LLI compatibility  }
	DL_UNSUPPORTED				= $07;							{  Requested service not supplied by provider  }
	DL_UNDELIVERABLE			= $11;							{  Previous data unit could not be delivered  }
	DL_NOTSUPPORTED				= $12;							{  Primitive is known but not supported by DLS provider  }
	DL_TOOMANY					= $13;							{  limit exceeded  }
	DL_NOTENAB					= $14;							{  Promiscuous mode not enabled  }
	DL_BUSY						= $15;							{  Other streams for a particular PPA in the post-attached state  }
	DL_NOAUTO					= $16;							{  Automatic handling of XID & TEST responses not supported  }
	DL_NOXIDAUTO				= $17;							{  Automatic handling of XID not supported  }
	DL_NOTESTAUTO				= $18;							{  Automatic handling of TEST not supported  }
	DL_XIDAUTO					= $19;							{  Automatic handling of XID response  }
	DL_TESTAUTO					= $1A;							{  AUtomatic handling of TEST response }
	DL_PENDING					= $1B;							{  pending outstanding connect indications  }

	{  DLPI media types supported }

	DL_CSMACD					= $00;							{  IEEE 802.3 CSMA/CD network, LLI Compatibility  }
	DL_TPB						= $01;							{  IEEE 802.4 Token Passing Bus, LLI Compatibility  }
	DL_TPR						= $02;							{  IEEE 802.5 Token Passing Ring, LLI Compatibility  }
	DL_METRO					= $03;							{  IEEE 802.6 Metro Net, LLI Compatibility  }
	DL_ETHER					= $04;							{  Ethernet Bus, LLI Compatibility  }
	DL_HDLC						= $05;							{  ISO HDLC protocol support, bit synchronous  }
	DL_CHAR						= $06;							{  Character Synchronous protocol support, eg BISYNC  }
	DL_CTCA						= $07;							{  IBM Channel-to-Channel Adapter  }
	DL_FDDI						= $08;							{  Fiber Distributed data interface  }
	DL_OTHER					= $09;							{  Any other medium not listed above  }

	{
	   DLPI provider service supported.
	   These must be allowed to be bitwise-OR for dl_service_mode in
	   DL_INFO_ACK.
	}
	DL_CODLS					= $01;							{  support connection-oriented service  }
	DL_CLDLS					= $02;							{  support connectionless data link service  }
	DL_ACLDLS					= $04;							{  support acknowledged connectionless service }

	{
	   DLPI provider style.
	   The DLPI provider style which determines whether a provider
	   requires a DL_ATTACH_REQ to inform the provider which PPA
	   user messages should be sent/received on.
	}

	DL_STYLE1					= $0500;						{  PPA is implicitly bound by open(2)  }
	DL_STYLE2					= $0501;						{  PPA must be explicitly bound via DL_ATTACH_REQ  }

	{  DLPI Originator for Disconnect and Resets }

	DL_PROVIDER					= $0700;
	DL_USER						= $0701;

	{  DLPI Disconnect Reasons }

	DL_CONREJ_DEST_UNKNOWN		= $0800;
	DL_CONREJ_DEST_UNREACH_PERMANENT = $0801;
	DL_CONREJ_DEST_UNREACH_TRANSIENT = $0802;
	DL_CONREJ_QOS_UNAVAIL_PERMANENT = $0803;
	DL_CONREJ_QOS_UNAVAIL_TRANSIENT = $0804;
	DL_CONREJ_PERMANENT_COND	= $0805;
	DL_CONREJ_TRANSIENT_COND	= $0806;
	DL_DISC_ABNORMAL_CONDITION	= $0807;
	DL_DISC_NORMAL_CONDITION	= $0808;
	DL_DISC_PERMANENT_CONDITION	= $0809;
	DL_DISC_TRANSIENT_CONDITION	= $080A;
	DL_DISC_UNSPECIFIED			= $080B;

	{  DLPI Reset Reasons }

	DL_RESET_FLOW_CONTROL		= $0900;
	DL_RESET_LINK_ERROR			= $0901;
	DL_RESET_RESYNCH			= $0902;

	{  DLPI status values for acknowledged connectionless data transfer }

	DL_CMD_MASK					= $0F;							{  mask for command portion of status  }
	DL_CMD_OK					= $00;							{  Command Accepted  }
	DL_CMD_RS					= $01;							{  Unimplemented or inactivated service  }
	DL_CMD_UE					= $05;							{  Data Link User interface error  }
	DL_CMD_PE					= $06;							{  Protocol error  }
	DL_CMD_IP					= $07;							{  Permanent implementation dependent error }
	DL_CMD_UN					= $09;							{  Resources temporarily unavailable  }
	DL_CMD_IT					= $0F;							{  Temporary implementation dependent error  }
	DL_RSP_MASK					= $F0;							{  mask for response portion of status  }
	DL_RSP_OK					= $00;							{  Response DLSDU present  }
	DL_RSP_RS					= $10;							{  Unimplemented or inactivated service  }
	DL_RSP_NE					= $30;							{  Response DLSDU never submitted  }
	DL_RSP_NR					= $40;							{  Response DLSDU not requested  }
	DL_RSP_UE					= $50;							{  Data Link User interface error  }
	DL_RSP_IP					= $70;							{  Permanent implementation dependent error  }
	DL_RSP_UN					= $90;							{  Resources temporarily unavailable  }
	DL_RSP_IT					= $F0;							{  Temporary implementation dependent error  }

	{  Service Class values for acknowledged connectionless data transfer }

	DL_RQST_RSP					= $01;							{  Use acknowledge capability in MAC sublayer }
	DL_RQST_NORSP				= $02;							{  No acknowledgement service requested  }

	{  DLPI address type definition }

	DL_FACT_PHYS_ADDR			= $01;							{  factory physical address  }
	DL_CURR_PHYS_ADDR			= $02;							{  current physical address  }

	{  DLPI flag definitions }

	DL_POLL_FINAL				= $01;							{  if set,indicates poll/final bit set }

	{  XID and TEST responses supported by the provider }

	DL_AUTO_XID					= $01;							{  provider will respond to XID  }
	DL_AUTO_TEST				= $02;							{  provider will respond to TEST  }

	{  Subsequent bind type }

	DL_PEER_BIND				= $01;							{  subsequent bind on a peer addr  }
	DL_HIERARCHICAL_BIND		= $02;							{  subs_bind on a hierarchical addr }

	{  DLPI promiscuous mode definitions }

	DL_PROMISC_PHYS				= $01;							{  promiscuous mode at phys level  }
	DL_PROMISC_SAP				= $02;							{  promiscous mode at sap level  }
	DL_PROMISC_MULTI			= $03;							{  promiscuous mode for multicast  }

	{
	   DLPI Quality Of Service definition for use in QOS structure definitions.
	   The QOS structures are used in connection establishment, DL_INFO_ACK,
	   and setting connectionless QOS values.
	}

	{
	   Throughput
	   
	   This parameter is specified for both directions.
	}


TYPE
	dl_through_tPtr = ^dl_through_t;
	dl_through_t = RECORD
		dl_target_value:		SInt32;									{  desired bits/second desired  }
		dl_accept_value:		SInt32;									{  min. acceptable bits/second  }
	END;

	{
	   transit delay specification
	   
	   This parameter is specified for both directions.
	   expressed in milliseconds assuming a DLSDU size of 128 octets.
	   The scaling of the value to the current DLSDU size is provider dependent.
	}
	dl_transdelay_tPtr = ^dl_transdelay_t;
	dl_transdelay_t = RECORD
		dl_target_value:		SInt32;									{  desired value of service  }
		dl_accept_value:		SInt32;									{  min. acceptable value of service  }
	END;

	{
	   priority specification
	   priority range is 0-100, with 0 being highest value.
	}

	dl_priority_tPtr = ^dl_priority_t;
	dl_priority_t = RECORD
		dl_min:					SInt32;
		dl_max:					SInt32;
	END;

	{  protection specification }

CONST
	DL_NONE						= $0B01;						{  no protection supplied  }
	DL_MONITOR					= $0B02;						{  protection against passive monitoring  }
	DL_MAXIMUM					= $0B03;						{  protection against modification, replay, addition, or deletion  }


TYPE
	dl_protect_tPtr = ^dl_protect_t;
	dl_protect_t = RECORD
		dl_min:					SInt32;
		dl_max:					SInt32;
	END;

	{
	   Resilience specification
	   probabilities are scaled by a factor of 10,000 with a time interval
	   of 10,000 seconds.
	}
	dl_resilience_tPtr = ^dl_resilience_t;
	dl_resilience_t = RECORD
		dl_disc_prob:			SInt32;									{  probability of provider init DISC  }
		dl_reset_prob:			SInt32;									{  probability of provider init RESET  }
	END;

	{	
	    QOS type definition to be used for negotiation with the
	    remote end of a connection, or a connectionless unitdata request.
	    There are two type definitions to handle the negotiation 
	    process at connection establishment. The typedef dl_qos_range_t
	    is used to present a range for parameters. This is used
	    in the DL_CONNECT_REQ and DL_CONNECT_IND messages. The typedef
	    dl_qos_sel_t is used to select a specific value for the QOS
	    parameters. This is used in the DL_CONNECT_RES, DL_CONNECT_CON,
	    and DL_INFO_ACK messages to define the selected QOS parameters
	    for a connection.
	
	    NOTE
	    A DataLink provider which has unknown values for any of the fields
	    will use a value of DL_UNKNOWN for all values in the fields.
	
	    NOTE
	    A QOS parameter value of DL_QOS_DONT_CARE informs the DLS
	    provider the user requesting this value doesn't care 
	    what the QOS parameter is set to. This value becomes the
	    least possible value in the range of QOS parameters.
	    The order of the QOS parameter range is then:
	
	        DL_QOS_DONT_CARE < 0 < MAXIMUM QOS VALUE
		}

CONST
	DL_UNKNOWN					= -1;
	DL_QOS_DONT_CARE			= -2;

	{	
	    Every QOS structure has the first 4 bytes containing a type
	    field, denoting the definition of the rest of the structure.
	    This is used in the same manner has the dl_primitive variable
	    is in messages.
	
	    The following list is the defined QOS structure type values and structures.
		}
	DL_QOS_CO_RANGE1			= $0101;						{  QOS range struct. for Connection modeservice  }
	DL_QOS_CO_SEL1				= $0102;						{  QOS selection structure  }
	DL_QOS_CL_RANGE1			= $0103;						{  QOS range struct. for connectionless }
	DL_QOS_CL_SEL1				= $0104;						{  QOS selection for connectionless mode }


TYPE
	dl_qos_co_range1_tPtr = ^dl_qos_co_range1_t;
	dl_qos_co_range1_t = RECORD
		dl_qos_type:			UInt32;
		dl_rcv_throughput:		dl_through_t;							{  desired and acceptable }
		dl_rcv_trans_delay:		dl_transdelay_t;						{  desired and acceptable }
		dl_xmt_throughput:		dl_through_t;
		dl_xmt_trans_delay:		dl_transdelay_t;
		dl_priority:			dl_priority_t;							{  min and max values  }
		dl_protection:			dl_protect_t;							{  min and max values  }
		dl_residual_error:		SInt32;
		dl_resilience:			dl_resilience_t;
	END;

	dl_qos_co_sel1_tPtr = ^dl_qos_co_sel1_t;
	dl_qos_co_sel1_t = RECORD
		dl_qos_type:			UInt32;
		dl_rcv_throughput:		SInt32;
		dl_rcv_trans_delay:		SInt32;
		dl_xmt_throughput:		SInt32;
		dl_xmt_trans_delay:		SInt32;
		dl_priority:			SInt32;
		dl_protection:			SInt32;
		dl_residual_error:		SInt32;
		dl_resilience:			dl_resilience_t;
	END;

	dl_qos_cl_range1_tPtr = ^dl_qos_cl_range1_t;
	dl_qos_cl_range1_t = RECORD
		dl_qos_type:			UInt32;
		dl_trans_delay:			dl_transdelay_t;
		dl_priority:			dl_priority_t;
		dl_protection:			dl_protect_t;
		dl_residual_error:		SInt32;
	END;

	dl_qos_cl_sel1_tPtr = ^dl_qos_cl_sel1_t;
	dl_qos_cl_sel1_t = RECORD
		dl_qos_type:			UInt32;
		dl_trans_delay:			SInt32;
		dl_priority:			SInt32;
		dl_protection:			SInt32;
		dl_residual_error:		SInt32;
	END;

	{	
	    DLPI interface primitive definitions.
	
	    Each primitive is sent as a stream message. It is possible that
	    the messages may be viewed as a sequence of bytes that have the
	    following form without any padding. The structure definition
	    of the following messages may have to change depending on the
	    underlying hardware architecture and crossing of a hardware
	    boundary with a different hardware architecture.
	
	    Fields in the primitives having a name of the form
	    dl_reserved cannot be used and have the value of
	    binary zero, no bits turned on.
	
	    Each message has the name defined followed by the
	    stream message type (M_PROTO, M_PCPROTO, M_DATA)
	 	}
	{  LOCAL MANAGEMENT SERVICE PRIMITIVES }

	{  DL_INFO_REQ, M_PCPROTO type }

	dl_info_req_tPtr = ^dl_info_req_t;
	dl_info_req_t = RECORD
		dl_primitive:			UInt32;									{  set to DL_INFO_REQ  }
	END;

	{  DL_INFO_ACK, M_PCPROTO type }
	dl_info_ack_tPtr = ^dl_info_ack_t;
	dl_info_ack_t = RECORD
		dl_primitive:			UInt32;									{  set to DL_INFO_ACK  }
		dl_max_sdu:				UInt32;									{  Max bytes in a DLSDU  }
		dl_min_sdu:				UInt32;									{  Min bytes in a DLSDU  }
		dl_addr_length:			UInt32;									{  length of DLSAP address  }
		dl_mac_type:			UInt32;									{  type of medium supported }
		dl_reserved:			UInt32;									{  value set to zero  }
		dl_current_state:		UInt32;									{  state of DLPI interface  }
		dl_sap_length:			SInt32;									{  current length of SAP part of dlsap address  }
		dl_service_mode:		UInt32;									{  CO, CL or ACL  }
		dl_qos_length:			UInt32;									{  length of qos values  }
		dl_qos_offset:			UInt32;									{  offset from beg. of block }
		dl_qos_range_length:	UInt32;									{  available range of qos  }
		dl_qos_range_offset:	UInt32;									{  offset from beg. of block }
		dl_provider_style:		UInt32;									{  style1 or style2  }
		dl_addr_offset:			UInt32;									{  offset of the dlsap addr  }
		dl_version:				UInt32;									{  version number  }
		dl_brdcst_addr_length:	UInt32;									{  length of broadcast addr  }
		dl_brdcst_addr_offset:	UInt32;									{  offset from beg. of block }
		dl_growth:				UInt32;									{  set to zero  }
	END;

	{  DL_ATTACH_REQ, M_PROTO type }
	dl_attach_req_tPtr = ^dl_attach_req_t;
	dl_attach_req_t = RECORD
		dl_primitive:			UInt32;									{  set to DL_ATTACH_REQ }
		dl_ppa:					UInt32;									{  id of the PPA  }
	END;

	{  DL_DETACH_REQ, M_PROTO type }
	dl_detach_req_tPtr = ^dl_detach_req_t;
	dl_detach_req_t = RECORD
		dl_primitive:			UInt32;									{  set to DL_DETACH_REQ  }
	END;

	{  DL_BIND_REQ, M_PROTO type }
	dl_bind_req_tPtr = ^dl_bind_req_t;
	dl_bind_req_t = RECORD
		dl_primitive:			UInt32;									{  set to DL_BIND_REQ  }
		dl_sap:					UInt32;									{  info to identify dlsap addr }
		dl_max_conind:			UInt32;									{  max # of outstanding con_ind }
		dl_service_mode:		UInt16;									{  CO, CL or ACL  }
		dl_conn_mgmt:			UInt16;									{  if non-zero, is con-mgmt stream }
		dl_xidtest_flg:			UInt32;									{  if set to 1 indicates automatic initiation of test and xid frames  }
	END;

	{  DL_BIND_ACK, M_PCPROTO type }
	dl_bind_ack_tPtr = ^dl_bind_ack_t;
	dl_bind_ack_t = RECORD
		dl_primitive:			UInt32;									{  DL_BIND_ACK  }
		dl_sap:					UInt32;									{  DLSAP addr info  }
		dl_addr_length:			UInt32;									{  length of complete DLSAP addr  }
		dl_addr_offset:			UInt32;									{  offset from beginning of M_PCPROTO }
		dl_max_conind:			UInt32;									{  allowed max. # of con-ind  }
		dl_xidtest_flg:			UInt32;									{  responses supported by provider }
	END;

	{  DL_SUBS_BIND_REQ, M_PROTO type }
	dl_subs_bind_req_tPtr = ^dl_subs_bind_req_t;
	dl_subs_bind_req_t = RECORD
		dl_primitive:			UInt32;									{  DL_SUBS_BIND_REQ  }
		dl_subs_sap_offset:		UInt32;									{  offset of subs_sap  }
		dl_subs_sap_length:		UInt32;									{  length of subs_sap  }
		dl_subs_bind_class:		UInt32;									{  peer or hierarchical  }
	END;

	{  DL_SUBS_BIND_ACK, M_PCPROTO type }
	dl_subs_bind_ack_tPtr = ^dl_subs_bind_ack_t;
	dl_subs_bind_ack_t = RECORD
		dl_primitive:			UInt32;									{  DL_SUBS_BIND_ACK  }
		dl_subs_sap_offset:		UInt32;									{  offset of subs_sap  }
		dl_subs_sap_length:		UInt32;									{  length of subs_sap  }
	END;

	{  DL_UNBIND_REQ, M_PROTO type }
	dl_unbind_req_tPtr = ^dl_unbind_req_t;
	dl_unbind_req_t = RECORD
		dl_primitive:			UInt32;									{  DL_UNBIND_REQ  }
	END;

	{  DL_SUBS_UNBIND_REQ, M_PROTO type }
	dl_subs_unbind_req_tPtr = ^dl_subs_unbind_req_t;
	dl_subs_unbind_req_t = RECORD
		dl_primitive:			UInt32;									{  DL_SUBS_UNBIND_REQ  }
		dl_subs_sap_offset:		UInt32;									{  offset of subs_sap  }
		dl_subs_sap_length:		UInt32;									{  length of subs_sap  }
	END;

	{  DL_OK_ACK, M_PCPROTO type }
	dl_ok_ack_tPtr = ^dl_ok_ack_t;
	dl_ok_ack_t = RECORD
		dl_primitive:			UInt32;									{  DL_OK_ACK  }
		dl_correct_primitive:	UInt32;									{  primitive being acknowledged  }
	END;

	{  DL_ERROR_ACK, M_PCPROTO type }
	dl_error_ack_tPtr = ^dl_error_ack_t;
	dl_error_ack_t = RECORD
		dl_primitive:			UInt32;									{  DL_ERROR_ACK  }
		dl_error_primitive:		UInt32;									{  primitive in error  }
		dl_errno:				UInt32;									{  DLPI error code  }
		dl_unix_errno:			UInt32;									{  UNIX system error code  }
	END;

	{  DL_ENABMULTI_REQ, M_PROTO type }
	dl_enabmulti_req_tPtr = ^dl_enabmulti_req_t;
	dl_enabmulti_req_t = RECORD
		dl_primitive:			UInt32;									{  DL_ENABMULTI_REQ  }
		dl_addr_length:			UInt32;									{  length of multicast address  }
		dl_addr_offset:			UInt32;									{  offset from beg. of M_PROTO block }
	END;

	{  DL_DISABMULTI_REQ, M_PROTO type }
	dl_disabmulti_req_tPtr = ^dl_disabmulti_req_t;
	dl_disabmulti_req_t = RECORD
		dl_primitive:			UInt32;									{  DL_DISABMULTI_REQ  }
		dl_addr_length:			UInt32;									{  length of multicast address  }
		dl_addr_offset:			UInt32;									{  offset from beg. of M_PROTO block }
	END;

	{  DL_PROMISCON_REQ, M_PROTO type }
	dl_promiscon_req_tPtr = ^dl_promiscon_req_t;
	dl_promiscon_req_t = RECORD
		dl_primitive:			UInt32;									{  DL_PROMISCON_REQ  }
		dl_level:				UInt32;									{  physical,SAP level or ALL multicast }
	END;

	{  DL_PROMISCOFF_REQ, M_PROTO type }
	dl_promiscoff_req_tPtr = ^dl_promiscoff_req_t;
	dl_promiscoff_req_t = RECORD
		dl_primitive:			UInt32;									{  DL_PROMISCOFF_REQ  }
		dl_level:				UInt32;									{  Physical,SAP level or ALL multicast }
	END;

	{  Primitives to get and set the Physical address }
	{  DL_PHYS_ADDR_REQ, M_PROTO type }

	dl_phys_addr_req_tPtr = ^dl_phys_addr_req_t;
	dl_phys_addr_req_t = RECORD
		dl_primitive:			UInt32;									{  DL_PHYS_ADDR_REQ  }
		dl_addr_type:			UInt32;									{  factory or current physical addr  }
	END;

	{  DL_PHYS_ADDR_ACK, M_PCPROTO type }
	dl_phys_addr_ack_tPtr = ^dl_phys_addr_ack_t;
	dl_phys_addr_ack_t = RECORD
		dl_primitive:			UInt32;									{  DL_PHYS_ADDR_ACK  }
		dl_addr_length:			UInt32;									{  length of the physical addr  }
		dl_addr_offset:			UInt32;									{  offset from beg. of block  }
	END;

	{  DL_SET_PHYS_ADDR_REQ, M_PROTO type }
	dl_set_phys_addr_req_tPtr = ^dl_set_phys_addr_req_t;
	dl_set_phys_addr_req_t = RECORD
		dl_primitive:			UInt32;									{  DL_SET_PHYS_ADDR_REQ  }
		dl_addr_length:			UInt32;									{  length of physical addr  }
		dl_addr_offset:			UInt32;									{  offset from beg. of block  }
	END;

	{  Primitives to get statistics }
	{  DL_GET_STATISTICS_REQ, M_PROTO type }

	dl_get_statistics_req_tPtr = ^dl_get_statistics_req_t;
	dl_get_statistics_req_t = RECORD
		dl_primitive:			UInt32;									{  DL_GET_STATISTICS_REQ  }
	END;

	{  DL_GET_STATISTICS_ACK, M_PCPROTO type }
	dl_get_statistics_ack_tPtr = ^dl_get_statistics_ack_t;
	dl_get_statistics_ack_t = RECORD
		dl_primitive:			UInt32;									{  DL_GET_STATISTICS_ACK  }
		dl_stat_length:			UInt32;									{  length of statistics structure }
		dl_stat_offset:			UInt32;									{  offset from beg. of block  }
	END;

	{  CONNECTION-ORIENTED SERVICE PRIMITIVES }

	{  DL_CONNECT_REQ, M_PROTO type }

	dl_connect_req_tPtr = ^dl_connect_req_t;
	dl_connect_req_t = RECORD
		dl_primitive:			UInt32;									{  DL_CONNECT_REQ  }
		dl_dest_addr_length:	UInt32;									{  len. of dlsap addr }
		dl_dest_addr_offset:	UInt32;									{  offset  }
		dl_qos_length:			UInt32;									{  len. of QOS parm val }
		dl_qos_offset:			UInt32;									{  offset  }
		dl_growth:				UInt32;									{  set to zero  }
	END;

	{  DL_CONNECT_IND, M_PROTO type }
	dl_connect_ind_tPtr = ^dl_connect_ind_t;
	dl_connect_ind_t = RECORD
		dl_primitive:			UInt32;									{  DL_CONNECT_IND  }
		dl_correlation:			UInt32;									{  provider's correlation token }
		dl_called_addr_length:	UInt32;									{  length of called address  }
		dl_called_addr_offset:	UInt32;									{  offset from beginning of block  }
		dl_calling_addr_length:	UInt32;									{  length of calling address  }
		dl_calling_addr_offset:	UInt32;									{  offset from beginning of block  }
		dl_qos_length:			UInt32;									{  length of qos structure  }
		dl_qos_offset:			UInt32;									{  offset from beginning of block  }
		dl_growth:				UInt32;									{  set to zero  }
	END;

	{  DL_CONNECT_RES, M_PROTO type }
	dl_connect_res_tPtr = ^dl_connect_res_t;
	dl_connect_res_t = RECORD
		dl_primitive:			UInt32;									{  DL_CONNECT_RES  }
		dl_correlation:			UInt32;									{  provider's correlation token  }
		dl_resp_token:			UInt32;									{  token associated with responding stream  }
		dl_qos_length:			UInt32;									{  length of qos structure  }
		dl_qos_offset:			UInt32;									{  offset from beginning of block  }
		dl_growth:				UInt32;									{  set to zero  }
	END;

	{  DL_CONNECT_CON, M_PROTO type }
	dl_connect_con_tPtr = ^dl_connect_con_t;
	dl_connect_con_t = RECORD
		dl_primitive:			UInt32;									{  DL_CONNECT_CON }
		dl_resp_addr_length:	UInt32;									{  length of responder's address  }
		dl_resp_addr_offset:	UInt32;									{  offset from beginning of block }
		dl_qos_length:			UInt32;									{  length of qos structure  }
		dl_qos_offset:			UInt32;									{  offset from beginning of block }
		dl_growth:				UInt32;									{  set to zero  }
	END;

	{  DL_TOKEN_REQ, M_PCPROTO type }
	dl_token_req_tPtr = ^dl_token_req_t;
	dl_token_req_t = RECORD
		dl_primitive:			UInt32;									{  DL_TOKEN_REQ  }
	END;

	{  DL_TOKEN_ACK, M_PCPROTO type }
	dl_token_ack_tPtr = ^dl_token_ack_t;
	dl_token_ack_t = RECORD
		dl_primitive:			UInt32;									{  DL_TOKEN_ACK  }
		dl_token:				UInt32;									{  Connection response token associated with the stream  }
	END;

	{  DL_DISCONNECT_REQ, M_PROTO type }
	dl_disconnect_req_tPtr = ^dl_disconnect_req_t;
	dl_disconnect_req_t = RECORD
		dl_primitive:			UInt32;									{  DL_DISCONNECT_REQ  }
		dl_reason:				UInt32;									{ normal, abnormal, perm. or transient }
		dl_correlation:			UInt32;									{  association with connect_ind  }
	END;

	{  DL_DISCONNECT_IND, M_PROTO type }
	dl_disconnect_ind_tPtr = ^dl_disconnect_ind_t;
	dl_disconnect_ind_t = RECORD
		dl_primitive:			UInt32;									{  DL_DISCONNECT_IND  }
		dl_originator:			UInt32;									{  USER or PROVIDER  }
		dl_reason:				UInt32;									{  permanent or transient  }
		dl_correlation:			UInt32;									{  association with connect_ind  }
	END;

	{  DL_RESET_REQ, M_PROTO type }
	dl_reset_req_tPtr = ^dl_reset_req_t;
	dl_reset_req_t = RECORD
		dl_primitive:			UInt32;									{  DL_RESET_REQ  }
	END;

	{  DL_RESET_IND, M_PROTO type }
	dl_reset_ind_tPtr = ^dl_reset_ind_t;
	dl_reset_ind_t = RECORD
		dl_primitive:			UInt32;									{  DL_RESET_IND  }
		dl_originator:			UInt32;									{  Provider or User  }
		dl_reason:				UInt32;									{  flow control, link error or resynch }
	END;

	{  DL_RESET_RES, M_PROTO type }
	dl_reset_res_tPtr = ^dl_reset_res_t;
	dl_reset_res_t = RECORD
		dl_primitive:			UInt32;									{  DL_RESET_RES  }
	END;

	{  DL_RESET_CON, M_PROTO type }
	dl_reset_con_tPtr = ^dl_reset_con_t;
	dl_reset_con_t = RECORD
		dl_primitive:			UInt32;									{  DL_RESET_CON  }
	END;

	{  CONNECTIONLESS SERVICE PRIMITIVES }
	{  DL_UNITDATA_REQ, M_PROTO type, with M_DATA block(s) }

	dl_unitdata_req_tPtr = ^dl_unitdata_req_t;
	dl_unitdata_req_t = RECORD
		dl_primitive:			UInt32;									{  DL_UNITDATA_REQ  }
		dl_dest_addr_length:	UInt32;									{  DLSAP length of dest. user  }
		dl_dest_addr_offset:	UInt32;									{  offset from beg. of block  }
		dl_priority:			dl_priority_t;							{  priority value  }
	END;

	{  DL_UNITDATA_IND, M_PROTO type, with M_DATA block(s) }
	dl_unitdata_ind_tPtr = ^dl_unitdata_ind_t;
	dl_unitdata_ind_t = RECORD
		dl_primitive:			UInt32;									{  DL_UNITDATA_IND  }
		dl_dest_addr_length:	UInt32;									{  DLSAP length of dest. user  }
		dl_dest_addr_offset:	UInt32;									{  offset from beg. of block  }
		dl_src_addr_length:		UInt32;									{  DLSAP addr length of sending user }
		dl_src_addr_offset:		UInt32;									{  offset from beg. of block  }
		dl_group_address:		UInt32;									{  set to one if multicast/broadcast }
	END;

	{
	   DL_UDERROR_IND, M_PROTO type
	   (or M_PCPROTO type if LLI-based provider)
	}
	dl_uderror_ind_tPtr = ^dl_uderror_ind_t;
	dl_uderror_ind_t = RECORD
		dl_primitive:			UInt32;									{  DL_UDERROR_IND  }
		dl_dest_addr_length:	UInt32;									{  Destination DLSAP  }
		dl_dest_addr_offset:	UInt32;									{  Offset from beg. of block  }
		dl_unix_errno:			UInt32;									{  unix system error code }
		dl_errno:				UInt32;									{  DLPI error code  }
	END;

	{  DL_UDQOS_REQ, M_PROTO type }
	dl_udqos_req_tPtr = ^dl_udqos_req_t;
	dl_udqos_req_t = RECORD
		dl_primitive:			UInt32;									{  DL_UDQOS_REQ  }
		dl_qos_length:			UInt32;									{  length in bytes of requested qos }
		dl_qos_offset:			UInt32;									{  offset from beg. of block  }
	END;

	{  Primitives to handle XID and TEST operations }
	{  DL_TEST_REQ, M_PROTO type }

	dl_test_req_tPtr = ^dl_test_req_t;
	dl_test_req_t = RECORD
		dl_primitive:			UInt32;									{  DL_TEST_REQ  }
		dl_flag:				UInt32;									{  poll/final  }
		dl_dest_addr_length:	UInt32;									{  DLSAP length of dest. user  }
		dl_dest_addr_offset:	UInt32;									{  offset from beg. of block  }
	END;

	{  DL_TEST_IND, M_PROTO type }
	dl_test_ind_tPtr = ^dl_test_ind_t;
	dl_test_ind_t = RECORD
		dl_primitive:			UInt32;									{  DL_TEST_IND  }
		dl_flag:				UInt32;									{  poll/final  }
		dl_dest_addr_length:	UInt32;									{  dlsap length of dest. user  }
		dl_dest_addr_offset:	UInt32;									{  offset from beg. of block  }
		dl_src_addr_length:		UInt32;									{  dlsap length of source user  }
		dl_src_addr_offset:		UInt32;									{  offset from beg. of block  }
	END;

	{  DL_TEST_RES, M_PROTO type }
	dl_test_res_tPtr = ^dl_test_res_t;
	dl_test_res_t = RECORD
		dl_primitive:			UInt32;									{  DL_TEST_RES  }
		dl_flag:				UInt32;									{  poll/final  }
		dl_dest_addr_length:	UInt32;									{  DLSAP length of dest. user  }
		dl_dest_addr_offset:	UInt32;									{  offset from beg. of block  }
	END;

	{  DL_TEST_CON, M_PROTO type }
	dl_test_con_tPtr = ^dl_test_con_t;
	dl_test_con_t = RECORD
		dl_primitive:			UInt32;									{  DL_TEST_CON  }
		dl_flag:				UInt32;									{  poll/final  }
		dl_dest_addr_length:	UInt32;									{  dlsap length of dest. user  }
		dl_dest_addr_offset:	UInt32;									{  offset from beg. of block  }
		dl_src_addr_length:		UInt32;									{  dlsap length of source user  }
		dl_src_addr_offset:		UInt32;									{  offset from beg. of block  }
	END;

	{  DL_XID_REQ, M_PROTO type }
	dl_xid_req_tPtr = ^dl_xid_req_t;
	dl_xid_req_t = RECORD
		dl_primitive:			UInt32;									{  DL_XID_REQ  }
		dl_flag:				UInt32;									{  poll/final  }
		dl_dest_addr_length:	UInt32;									{  dlsap length of dest. user  }
		dl_dest_addr_offset:	UInt32;									{  offset from beg. of block  }
	END;

	{  DL_XID_IND, M_PROTO type }
	dl_xid_ind_tPtr = ^dl_xid_ind_t;
	dl_xid_ind_t = RECORD
		dl_primitive:			UInt32;									{  DL_XID_IND  }
		dl_flag:				UInt32;									{  poll/final  }
		dl_dest_addr_length:	UInt32;									{  dlsap length of dest. user  }
		dl_dest_addr_offset:	UInt32;									{  offset from beg. of block  }
		dl_src_addr_length:		UInt32;									{  dlsap length of source user  }
		dl_src_addr_offset:		UInt32;									{  offset from beg. of block  }
	END;

	{  DL_XID_RES, M_PROTO type }
	dl_xid_res_tPtr = ^dl_xid_res_t;
	dl_xid_res_t = RECORD
		dl_primitive:			UInt32;									{  DL_XID_RES  }
		dl_flag:				UInt32;									{  poll/final  }
		dl_dest_addr_length:	UInt32;									{  DLSAP length of dest. user  }
		dl_dest_addr_offset:	UInt32;									{  offset from beg. of block  }
	END;

	{  DL_XID_CON, M_PROTO type }
	dl_xid_con_tPtr = ^dl_xid_con_t;
	dl_xid_con_t = RECORD
		dl_primitive:			UInt32;									{  DL_XID_CON  }
		dl_flag:				UInt32;									{  poll/final  }
		dl_dest_addr_length:	UInt32;									{  dlsap length of dest. user  }
		dl_dest_addr_offset:	UInt32;									{  offset from beg. of block  }
		dl_src_addr_length:		UInt32;									{  dlsap length of source user  }
		dl_src_addr_offset:		UInt32;									{  offset from beg. of block  }
	END;

	{  ACKNOWLEDGED CONNECTIONLESS SERVICE PRIMITIVES }

	{  DL_DATA_ACK_REQ, M_PROTO type }

	dl_data_ack_req_tPtr = ^dl_data_ack_req_t;
	dl_data_ack_req_t = RECORD
		dl_primitive:			UInt32;									{  DL_DATA_ACK_REQ  }
		dl_correlation:			UInt32;									{  User's correlation token  }
		dl_dest_addr_length:	UInt32;									{  length of destination addr  }
		dl_dest_addr_offset:	UInt32;									{  offset from beginning of block  }
		dl_src_addr_length:		UInt32;									{  length of source address  }
		dl_src_addr_offset:		UInt32;									{  offset from beginning of block  }
		dl_priority:			UInt32;									{  priority  }
		dl_service_class:		UInt32;									{  DL_RQST_RSP or DL_RQST_NORSP  }
	END;

	{  DL_DATA_ACK_IND, M_PROTO type }
	dl_data_ack_ind_tPtr = ^dl_data_ack_ind_t;
	dl_data_ack_ind_t = RECORD
		dl_primitive:			UInt32;									{  DL_DATA_ACK_IND  }
		dl_dest_addr_length:	UInt32;									{  length of destination addr  }
		dl_dest_addr_offset:	UInt32;									{  offset from beginning of block  }
		dl_src_addr_length:		UInt32;									{  length of source address  }
		dl_src_addr_offset:		UInt32;									{  offset from beginning of block  }
		dl_priority:			UInt32;									{  priority for data unit transm.  }
		dl_service_class:		UInt32;									{  DL_RQST_RSP or DL_RQST_NORSP  }
	END;

	{  DL_DATA_ACK_STATUS_IND, M_PROTO type }
	dl_data_ack_status_ind_tPtr = ^dl_data_ack_status_ind_t;
	dl_data_ack_status_ind_t = RECORD
		dl_primitive:			UInt32;									{  DL_DATA_ACK_STATUS_IND  }
		dl_correlation:			UInt32;									{  User's correlation token  }
		dl_status:				UInt32;									{  success or failure of previous req }
	END;

	{  DL_REPLY_REQ, M_PROTO type }
	dl_reply_req_tPtr = ^dl_reply_req_t;
	dl_reply_req_t = RECORD
		dl_primitive:			UInt32;									{  DL_REPLY_REQ  }
		dl_correlation:			UInt32;									{  User's correlation token  }
		dl_dest_addr_length:	UInt32;									{  length of destination address  }
		dl_dest_addr_offset:	UInt32;									{  offset from beginning of block  }
		dl_src_addr_length:		UInt32;									{  source address length  }
		dl_src_addr_offset:		UInt32;									{  offset from beginning of block  }
		dl_priority:			UInt32;									{  priority for data unit transmission }
		dl_service_class:		UInt32;
	END;

	{  DL_REPLY_IND, M_PROTO type }
	dl_reply_ind_tPtr = ^dl_reply_ind_t;
	dl_reply_ind_t = RECORD
		dl_primitive:			UInt32;									{  DL_REPLY_IND  }
		dl_dest_addr_length:	UInt32;									{  length of destination address  }
		dl_dest_addr_offset:	UInt32;									{  offset from beginning of block }
		dl_src_addr_length:		UInt32;									{  length of source address  }
		dl_src_addr_offset:		UInt32;									{  offset from beginning of block  }
		dl_priority:			UInt32;									{  priority for data unit transmission }
		dl_service_class:		UInt32;									{  DL_RQST_RSP or DL_RQST_NORSP  }
	END;

	{  DL_REPLY_STATUS_IND, M_PROTO type }
	dl_reply_status_ind_tPtr = ^dl_reply_status_ind_t;
	dl_reply_status_ind_t = RECORD
		dl_primitive:			UInt32;									{  DL_REPLY_STATUS_IND  }
		dl_correlation:			UInt32;									{  User's correlation token  }
		dl_status:				UInt32;									{  success or failure of previous req }
	END;

	{  DL_REPLY_UPDATE_REQ, M_PROTO type }
	dl_reply_update_req_tPtr = ^dl_reply_update_req_t;
	dl_reply_update_req_t = RECORD
		dl_primitive:			UInt32;									{  DL_REPLY_UPDATE_REQ  }
		dl_correlation:			UInt32;									{  user's correlation token  }
		dl_src_addr_length:		UInt32;									{  length of source address  }
		dl_src_addr_offset:		UInt32;									{  offset from beginning of block  }
	END;

	{  DL_REPLY_UPDATE_STATUS_IND, M_PROTO type }
	dl_reply_update_status_ind_tPtr = ^dl_reply_update_status_ind_t;
	dl_reply_update_status_ind_t = RECORD
		dl_primitive:			UInt32;									{  DL_REPLY_UPDATE_STATUS_IND  }
		dl_correlation:			UInt32;									{  User's correlation token  }
		dl_status:				UInt32;									{  success or failure of previous req }
	END;

	DL_primitivesPtr = ^DL_primitives;
	DL_primitives = RECORD
		CASE INTEGER OF
		0: (
			dl_primitive:		UInt32;
			);
		1: (
			info_req:			dl_info_req_t;
			);
		2: (
			info_ack:			dl_info_ack_t;
			);
		3: (
			attach_req:			dl_attach_req_t;
			);
		4: (
			detach_req:			dl_detach_req_t;
			);
		5: (
			bind_req:			dl_bind_req_t;
			);
		6: (
			bind_ack:			dl_bind_ack_t;
			);
		7: (
			unbind_req:			dl_unbind_req_t;
			);
		8: (
			subs_bind_req:		dl_subs_bind_req_t;
			);
		9: (
			subs_bind_ack:		dl_subs_bind_ack_t;
			);
		10: (
			subs_unbind_req:	dl_subs_unbind_req_t;
			);
		11: (
			ok_ack:				dl_ok_ack_t;
			);
		12: (
			error_ack:			dl_error_ack_t;
			);
		13: (
			connect_req:		dl_connect_req_t;
			);
		14: (
			connect_ind:		dl_connect_ind_t;
			);
		15: (
			connect_res:		dl_connect_res_t;
			);
		16: (
			connect_con:		dl_connect_con_t;
			);
		17: (
			token_req:			dl_token_req_t;
			);
		18: (
			token_ack:			dl_token_ack_t;
			);
		19: (
			disconnect_req:		dl_disconnect_req_t;
			);
		20: (
			disconnect_ind:		dl_disconnect_ind_t;
			);
		21: (
			reset_req:			dl_reset_req_t;
			);
		22: (
			reset_ind:			dl_reset_ind_t;
			);
		23: (
			reset_res:			dl_reset_res_t;
			);
		24: (
			reset_con:			dl_reset_con_t;
			);
		25: (
			unitdata_req:		dl_unitdata_req_t;
			);
		26: (
			unitdata_ind:		dl_unitdata_ind_t;
			);
		27: (
			uderror_ind:		dl_uderror_ind_t;
			);
		28: (
			udqos_req:			dl_udqos_req_t;
			);
		29: (
			enabmulti_req:		dl_enabmulti_req_t;
			);
		30: (
			disabmulti_req:		dl_disabmulti_req_t;
			);
		31: (
			promiscon_req:		dl_promiscon_req_t;
			);
		32: (
			promiscoff_req:		dl_promiscoff_req_t;
			);
		33: (
			physaddr_req:		dl_phys_addr_req_t;
			);
		34: (
			physaddr_ack:		dl_phys_addr_ack_t;
			);
		35: (
			set_physaddr_req:	dl_set_phys_addr_req_t;
			);
		36: (
			get_statistics_req:	dl_get_statistics_req_t;
			);
		37: (
			get_statistics_ack:	dl_get_statistics_ack_t;
			);
		38: (
			test_req:			dl_test_req_t;
			);
		39: (
			test_ind:			dl_test_ind_t;
			);
		40: (
			test_res:			dl_test_res_t;
			);
		41: (
			test_con:			dl_test_con_t;
			);
		42: (
			xid_req:			dl_xid_req_t;
			);
		43: (
			xid_ind:			dl_xid_ind_t;
			);
		44: (
			xid_res:			dl_xid_res_t;
			);
		45: (
			xid_con:			dl_xid_con_t;
			);
		46: (
			data_ack_req:		dl_data_ack_req_t;
			);
		47: (
			data_ack_ind:		dl_data_ack_ind_t;
			);
		48: (
			data_ack_status_ind: dl_data_ack_status_ind_t;
			);
		49: (
			reply_req:			dl_reply_req_t;
			);
		50: (
			reply_ind:			dl_reply_ind_t;
			);
		51: (
			reply_status_ind:	dl_reply_status_ind_t;
			);
		52: (
			reply_update_req:	dl_reply_update_req_t;
			);
		53: (
			reply_update_status_ind: dl_reply_update_status_ind_t;
			);
	END;


CONST
	DL_INFO_REQ_SIZE			= 4;
	DL_INFO_ACK_SIZE			= 76;
	DL_ATTACH_REQ_SIZE			= 8;
	DL_DETACH_REQ_SIZE			= 4;
	DL_BIND_REQ_SIZE			= 20;
	DL_BIND_ACK_SIZE			= 24;
	DL_UNBIND_REQ_SIZE			= 4;
	DL_SUBS_BIND_REQ_SIZE		= 16;
	DL_SUBS_BIND_ACK_SIZE		= 12;
	DL_SUBS_UNBIND_REQ_SIZE		= 12;
	DL_OK_ACK_SIZE				= 8;
	DL_ERROR_ACK_SIZE			= 16;
	DL_CONNECT_REQ_SIZE			= 24;
	DL_CONNECT_IND_SIZE			= 36;
	DL_CONNECT_RES_SIZE			= 24;
	DL_CONNECT_CON_SIZE			= 24;
	DL_TOKEN_REQ_SIZE			= 4;
	DL_TOKEN_ACK_SIZE			= 8;
	DL_DISCONNECT_REQ_SIZE		= 12;
	DL_DISCONNECT_IND_SIZE		= 16;
	DL_RESET_REQ_SIZE			= 4;
	DL_RESET_IND_SIZE			= 12;
	DL_RESET_RES_SIZE			= 4;
	DL_RESET_CON_SIZE			= 4;
	DL_UNITDATA_REQ_SIZE		= 20;
	DL_UNITDATA_IND_SIZE		= 24;
	DL_UDERROR_IND_SIZE			= 20;
	DL_UDQOS_REQ_SIZE			= 12;
	DL_ENABMULTI_REQ_SIZE		= 12;
	DL_DISABMULTI_REQ_SIZE		= 12;
	DL_PROMISCON_REQ_SIZE		= 8;
	DL_PROMISCOFF_REQ_SIZE		= 8;
	DL_PHYS_ADDR_REQ_SIZE		= 8;
	DL_PHYS_ADDR_ACK_SIZE		= 12;
	DL_SET_PHYS_ADDR_REQ_SIZE	= 12;
	DL_GET_STATISTICS_REQ_SIZE	= 4;
	DL_GET_STATISTICS_ACK_SIZE	= 12;
	DL_XID_REQ_SIZE				= 16;
	DL_XID_IND_SIZE				= 24;
	DL_XID_RES_SIZE				= 16;
	DL_XID_CON_SIZE				= 24;
	DL_TEST_REQ_SIZE			= 16;
	DL_TEST_IND_SIZE			= 24;
	DL_TEST_RES_SIZE			= 16;
	DL_TEST_CON_SIZE			= 24;
	DL_DATA_ACK_REQ_SIZE		= 32;
	DL_DATA_ACK_IND_SIZE		= 28;
	DL_DATA_ACK_STATUS_IND_SIZE	= 12;
	DL_REPLY_REQ_SIZE			= 32;
	DL_REPLY_IND_SIZE			= 28;
	DL_REPLY_STATUS_IND_SIZE	= 12;
	DL_REPLY_UPDATE_REQ_SIZE	= 16;
	DL_REPLY_UPDATE_STATUS_IND_SIZE = 12;

	DL_IOC_HDR_INFO				= $6C0A;						{  Fast path request  }

	{  ***** From the Mentat "modnames.h" ***** }


	{  ***** Raw Streams ***** }


	{
	   Flags used in the fType field of OTReadInfo for functions.
	   I've removed the terse and confusing comments in this header
	   file.  For a full description, read "Open Transport Advanced
	   Client Programming".
	}

	kOTNoMessagesAvailable		= $FFFFFFFF;
	kOTAnyMsgType				= $FFFFFFFE;
	kOTDataMsgTypes				= $FFFFFFFC;
	kOTMProtoMsgTypes			= $FFFFFFFB;
	kOTOnlyMProtoMsgTypes		= $FFFFFFFA;

{$IFC NOT OTKERNEL }
	{  StreamRef is an opaque reference to a raw stream. }


TYPE
	StreamRef    = ^LONGINT; { an opaque 32-bit type }
	StreamRefPtr = ^StreamRef;  { when a VAR xx:StreamRef parameter can be nil, it is changed to xx: StreamRefPtr }

CONST
	kOTInvalidStreamRef			= 0;

	{  PollRef structure is used with the OTStreamPoll function. }

TYPE
	PollRefPtr = ^PollRef;
	PollRef = RECORD
		filler:					SInt32;									{  holds a file descriptor an a UNIX system, replaced by ref (at end of structure) under OT }
		events:					SInt16;
		revents:				SInt16;
		ref:					StreamRef;
	END;

	{  OTReadInfo structure is used with the various functions that read and peek at the stream head. }
	OTReadInfoPtr = ^OTReadInfo;
	OTReadInfo = RECORD
		fType:					UInt32;
		fCommand:				OTCommand;
		fFiller:				UInt32;									{  For compatibility with OT 1.0 and 1.1  }
		fBytes:					ByteCount;
		fError:					OSStatus;
	END;

	{  Opening and closing raw streams }
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  OTStreamOpen()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION OTStreamOpen(name: ConstCStringPtr; oFlags: OTOpenFlags; VAR errPtr: OSStatus): StreamRef;

{
 *  OTAsyncStreamOpen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTAsyncStreamOpen(name: ConstCStringPtr; oFlags: OTOpenFlags; proc: OTNotifyUPP; contextPtr: UNIV Ptr): OSStatus;

{
 *  OTCreateStream()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCreateStream(cfig: OTConfigurationRef; oFlags: OTOpenFlags; VAR errPtr: OSStatus): StreamRef;

{
 *  OTAsyncCreateStream()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTAsyncCreateStream(cfig: OTConfigurationRef; oFlags: OTOpenFlags; proc: OTNotifyUPP; contextPtr: UNIV Ptr): OSStatus;

{
 *  OTStreamClose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTStreamClose(strm: StreamRef): OSStatus;

{  Polling a stream for activity }

{
 *  OTStreamPoll()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTStreamPoll(VAR fds: PollRef; nfds: UInt32; timeout: OTTimeout): OTResult;

{
 *  OTAsyncStreamPoll()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTAsyncStreamPoll(VAR fds: PollRef; nfds: UInt32; timeout: OTTimeout; proc: OTNotifyUPP; contextPtr: UNIV Ptr): OTResult;

{  Classic UNIX file descriptor operations }

{
 *  OTStreamRead()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTStreamRead(strm: StreamRef; buf: UNIV Ptr; len: OTByteCount): OTResult;

{
 *  OTStreamWrite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTStreamWrite(strm: StreamRef; buf: UNIV Ptr; len: OTByteCount): OTResult;

{
 *  OTStreamIoctl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTStreamIoctl(strm: StreamRef; cmd: UInt32; data: UNIV Ptr): OTResult;

{
 *  OTStreamPipe()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTStreamPipe(VAR streamsToPipe: StreamRef): OTResult;

{  there can be only 2! }
{  Notifiers and modes of operation }
{
 *  OTStreamInstallNotifier()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTStreamInstallNotifier(strm: StreamRef; proc: OTNotifyUPP; contextPtr: UNIV Ptr): OSStatus;

{
 *  OTStreamRemoveNotifier()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTStreamRemoveNotifier(strm: StreamRef);

{
 *  OTStreamUseSyncIdleEvents()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTStreamUseSyncIdleEvents(strm: StreamRef; useEvents: BOOLEAN): OSStatus;

{
 *  OTStreamSetBlocking()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTStreamSetBlocking(strm: StreamRef);

{
 *  OTStreamSetNonBlocking()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTStreamSetNonBlocking(strm: StreamRef);

{
 *  OTStreamIsBlocking()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTStreamIsBlocking(strm: StreamRef): BOOLEAN;

{
 *  OTStreamSetSynchronous()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTStreamSetSynchronous(strm: StreamRef);

{
 *  OTStreamSetAsynchronous()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTStreamSetAsynchronous(strm: StreamRef);

{
 *  OTStreamIsSynchronous()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTStreamIsSynchronous(strm: StreamRef): BOOLEAN;

{  STREAMS primitives }

{
 *  OTStreamGetMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTStreamGetMessage(strm: StreamRef; VAR ctlbuf: strbuf; VAR databuf: strbuf; VAR flags: OTFlags): OTResult;

{
 *  OTStreamGetPriorityMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTStreamGetPriorityMessage(strm: StreamRef; VAR ctlbuf: strbuf; VAR databuf: strbuf; VAR band: OTBand; VAR flags: OTFlags): OTResult;

{
 *  OTStreamPutMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTStreamPutMessage(strm: StreamRef; {CONST}VAR ctlbuf: strbuf; {CONST}VAR databuf: strbuf; flags: OTFlags): OSStatus;

{
 *  OTStreamPutPriorityMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTStreamPutPriorityMessage(strm: StreamRef; {CONST}VAR ctlbuf: strbuf; {CONST}VAR databuf: strbuf; band: OTBand; flags: OTFlags): OSStatus;

{  Miscellaneous stuff }

{
 *  OTStreamSetControlMask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTStreamSetControlMask(strm: StreamRef; mask: UInt32; setClear: BOOLEAN);

{
   Opening endpoints and mappers on a Stream - these calls are synchronous, and may
   only be used at System Task time. Once the stream has been installed into a provider
   or endpoint, you should not continue to use STREAMS APIs on it
}

{
 *  OTOpenProviderOnStream()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTOpenProviderOnStream(strm: StreamRef; VAR errPtr: OSStatus): ProviderRef;

{
 *  OTOpenEndpointOnStream()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTOpenEndpointOnStream(strm: StreamRef; VAR errPtr: OSStatus): EndpointRef;

{
   To quote an earlier version of this header file:
   
        Some functions that should only be used if
        you really know what you're doing.
}

{
 *  OTRemoveStreamFromProvider()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTRemoveStreamFromProvider(ref: ProviderRef): StreamRef;

{
 *  OTPeekMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTPeekMessage(strm: StreamRef; VAR readInfo: OTReadInfo): OSStatus;

{
 *  OTReadMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTReadMessage(strm: StreamRef; VAR readInfo: OTReadInfo): OTBufferPtr;

{
 *  OTPutBackBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTPutBackBuffer(strm: StreamRef; VAR buffer: OTBuffer);

{
 *  OTPutBackPartialBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTPutBackPartialBuffer(strm: StreamRef; VAR readInfo: OTBufferInfo; VAR buffer: OTBuffer);

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{  ***** Port Utilities ***** }
{$IFC NOT OTKERNEL }
{
   These types and routines are used during sophisticated
   port management.  High-level clients may get involved
   for things like request a port to be yielding, but typically
   this stuff is used by protocol infrastructure.
}
{
   OTPortCloseStruct is used when processing the kOTClosePortRequest
   and kOTYieldPortRequest events.
}


TYPE
	OTPortCloseStructPtr = ^OTPortCloseStruct;
	OTPortCloseStruct = RECORD
		fPortRef:				OTPortRef;								{  The port requested to be closed. }
		fTheProvider:			ProviderRef;							{  The provider using the port. }
		fDenyReason:			OSStatus;								{  Set to a negative number to deny the request }
	END;

	{  OTClientList structure is used with the OTYieldPortRequest function. }
	OTClientListPtr = ^OTClientList;
	OTClientList = RECORD
		fNumClients:			ItemCount;
		fBuffer:				PACKED ARRAY [0..3] OF UInt8;
	END;

	{
	   Returns a buffer containing all of the clients that refused to yield the port.
	   "size" is the total number of bytes @ buffer, including the fNumClients field.
	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  OTYieldPortRequest()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION OTYieldPortRequest(ref: ProviderRef; portRef: OTPortRef; VAR buffer: OTClientList; size: OTByteCount): OSStatus; C;

{  Send a notification to all Open Transport registered clients }
{
 *  OTNotifyAllClients()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTNotifyAllClients(code: OTEventCode; result: OTResult; cookie: UNIV Ptr); C;

{  Determine if "child" is a child port of "parent" }
{
 *  OTIsDependentPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTIsDependentPort(parent: OTPortRef; child: OTPortRef): BOOLEAN; C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{  ***** Timers *****  }
{
   STREAMS plug-ins code should not use these timers, instead
   they should use timer messages, ie mi_timer etc.
}

{$IFC NOT OTKERNEL }

TYPE
	OTTimerTask							= LONGINT;
	{
	   Under Carbon, OTCreateTimerTask takes a client context pointer.  Applications may pass NULL
	   after calling InitOpenTransport(kInitOTForApplicationMask, ...).  Non-applications must always pass a
	   valid client context.
	}
	{
	 *  OTCreateTimerTaskInContext()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION OTCreateTimerTaskInContext(upp: OTProcessUPP; arg: UNIV Ptr; clientContext: OTClientContextPtr): LONGINT;

{$IFC CALL_NOT_IN_CARBON }
{
 *  OTCreateTimerTask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCreateTimerTask(proc: OTProcessUPP; arg: UNIV Ptr): OTTimerTask;

{$ENDC}  {CALL_NOT_IN_CARBON}
{
 *  OTCancelTimerTask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTCancelTimerTask(timerTask: OTTimerTask): BOOLEAN;

{
 *  OTDestroyTimerTask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE OTDestroyTimerTask(timerTask: OTTimerTask);

{
 *  OTScheduleTimerTask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTScheduleTimerTask(timerTask: OTTimerTask; milliSeconds: OTTimeout): BOOLEAN;

{$IFC OTCARBONAPPLICATION }
{  The following macro may be used by applications only. }
{$ENDC}  {OTCARBONAPPLICATION}
{$ENDC}

{  ***** Miscellaneous Helpful Functions ***** }

{$IFC NOT OTKERNEL }
{
   These routines allow you to manipulate OT's buffer structures.
   If you use no-copy receives (described in "OpenTransport.h")
   you will need some of these routines, and may choose to use others.
   See "Open Tranport Advanced Client Programming" for documentation.
}
{
 *  OTBufferDataSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTBufferDataSize(VAR buffer: OTBuffer): OTByteCount; C;

{
 *  OTReadBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTReadBuffer(VAR buffer: OTBufferInfo; dest: UNIV Ptr; VAR len: OTByteCount): BOOLEAN; C;

{
 *  OTReleaseBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE OTReleaseBuffer(VAR buffer: OTBuffer); C;


{$IFC CALL_NOT_IN_CARBON }
{
 *  StoreIntoNetbuf()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION StoreIntoNetbuf(VAR netBuf: TNetbuf; source: UNIV Ptr; len: SInt32): BOOLEAN; C;

{
 *  StoreMsgIntoNetbuf()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION StoreMsgIntoNetbuf(VAR netBuf: TNetbuf; VAR buffer: OTBuffer): BOOLEAN; C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{  ***** OTConfiguration ***** }
{$IFC CALL_NOT_IN_CARBON }
{$IFC NOT OTKERNEL }
{
   As promised in "OpenTransport.h", here are the routines
   for advanced operations on configurations.
}
{  Manipulating a configuration }

{$IFC CALL_NOT_IN_CARBON }
{
 *  OTCfigNewConfiguration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfigNewConfiguration(path: ConstCStringPtr): OTConfigurationRef; C;

{
 *  OTCfigDeleteConfiguration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTCfigDeleteConfiguration(cfig: OTConfigurationRef); C;

{
 *  OTCfigCloneConfiguration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfigCloneConfiguration(cfig: OTConfigurationRef): OTConfigurationRef; C;

{
 *  OTCfigPushNewSingleChild()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfigPushNewSingleChild(cfig: OTConfigurationRef; path: ConstCStringPtr; VAR errPtr: OSStatus): OTConfigurationRef; C;

{
 *  OTCfigPushParent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfigPushParent(cfig: OTConfigurationRef; path: ConstCStringPtr; VAR errPtr: OSStatus): OTConfigurationRef; C;

{
 *  OTCfigPushChild()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfigPushChild(cfig: OTConfigurationRef; index: OTItemCount; path: ConstCStringPtr; VAR errPtr: OSStatus): OTConfigurationRef; C;

{
 *  OTCfigPopChild()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfigPopChild(cfig: OTConfigurationRef; index: OTItemCount): OSStatus; C;

{
 *  OTCfigGetChild()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfigGetChild(cfig: OTConfigurationRef; index: OTItemCount): OTConfigurationRef; C;

{
 *  OTCfigSetPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfigSetPath(cfig: OTConfigurationRef; path: ConstCStringPtr): OSStatus; C;

{
 *  OTCfigNewChild()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfigNewChild(cfig: OTConfigurationRef; path: ConstCStringPtr; VAR errPtr: OSStatus): OTConfigurationRef; C;

{
 *  OTCfigAddChild()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfigAddChild(cfig: OTConfigurationRef; child: OTConfigurationRef): OSStatus; C;

{
 *  OTCfigRemoveChild()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfigRemoveChild(cfig: OTConfigurationRef; index: OTItemCount): OTConfigurationRef; C;

{
 *  OTCfigSetPortRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTCfigSetPortRef(cfig: OTConfigurationRef; portRef: OTPortRef); C;

{
 *  OTCfigChangeProviderName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTCfigChangeProviderName(cfig: OTConfigurationRef; name: ConstCStringPtr); C;

{  Query a configuration }

{
 *  OTCfigNumberOfChildren()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfigNumberOfChildren(cfig: OTConfigurationRef): UInt16; C;

{
 *  OTCfigGetParent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfigGetParent(cfig: OTConfigurationRef): OTConfigurationRef; C;

{
 *  OTCfigGetOptionNetbuf()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfigGetOptionNetbuf(cfig: OTConfigurationRef): TNetbufPtr; C;

{
 *  OTCfigGetPortRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfigGetPortRef(cfig: OTConfigurationRef): OTPortRef; C;

{
 *  OTCfigGetInstallFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfigGetInstallFlags(cfig: OTConfigurationRef): UInt32; C;

{
 *  OTCfigGetProviderName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfigGetProviderName(cfig: OTConfigurationRef): ConstCStringPtr; C;

{
 *  OTCfigIsPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfigIsPort(cfig: OTConfigurationRef): BOOLEAN; C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}
{  ***** Configurators ***** }
{
   The kOTConfiguratorInterfaceID define is what you need to add to your
   export file for the "interfaceID = " clause to export a configurator
   for ASLM.  Similarly, kOTConfiguratorCFMTag is used for CFM-based
   configurators.
}



{$IFC NOT OTKERNEL }

TYPE
	TOTConfiguratorRef    = ^LONGINT; { an opaque 32-bit type }
	TOTConfiguratorRefPtr = ^TOTConfiguratorRef;  { when a VAR xx:TOTConfiguratorRef parameter can be nil, it is changed to xx: TOTConfiguratorRefPtr }
	{
	   Typedef for the OTCanConfigure function, and the enum for which pass we're doing.
	   The first (kOTSpecificConfigPass) is to give configurators a shot at the configuration
	   before we start allowing the generic configurators to get into the act.
	}

CONST
	kOTSpecificConfigPass		= 0;
	kOTGenericConfigPass		= 1;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	OTCanConfigureProcPtr = FUNCTION(cfig: OTConfigurationRef; pass: UInt32): BOOLEAN; C;
{$ELSEC}
	OTCanConfigureProcPtr = ProcPtr;
{$ENDC}

	{  Typedef for the function to create and return a configurator object }
{$IFC TYPED_FUNCTION_POINTERS}
	OTCreateConfiguratorProcPtr = FUNCTION(VAR cfigor: TOTConfiguratorRef): OSStatus; C;
{$ELSEC}
	OTCreateConfiguratorProcPtr = ProcPtr;
{$ENDC}

	{
	   Typedef for the "OTSetupConfigurator" function that your configurator library must export.
	   The enum is for the type of configurator that it is.
	}

CONST
	kOTDefaultConfigurator		= 0;
	kOTProtocolFamilyConfigurator = 1;
	kOTLinkDriverConfigurator	= 2;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	OTSetupConfiguratorProcPtr = FUNCTION(VAR canConfigure: OTCanConfigureProcPtr; VAR createConfigurator: OTCreateConfiguratorProcPtr; VAR configuratorType: UInt8): OSStatus; C;
{$ELSEC}
	OTSetupConfiguratorProcPtr = ProcPtr;
{$ENDC}

	{
	   Procedure pointer definitions for the three key callbacks associated
	   with a configurator, as established by OTNewConfigurator.
	}
{$IFC TYPED_FUNCTION_POINTERS}
	OTCFConfigureProcPtr = FUNCTION(cfigor: TOTConfiguratorRef; cfig: OTConfigurationRef): OSStatus; C;
{$ELSEC}
	OTCFConfigureProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	OTCFCreateStreamProcPtr = FUNCTION(cfigor: TOTConfiguratorRef; cfig: OTConfigurationRef; oFlags: OTOpenFlags; proc: OTNotifyUPP; contextPtr: UNIV Ptr): OSStatus; C;
{$ELSEC}
	OTCFCreateStreamProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	OTCFHandleSystemEventProcPtr = PROCEDURE(cfigor: TOTConfiguratorRef; code: OTEventCode; result: OTResult; cookie: UNIV Ptr); C;
{$ELSEC}
	OTCFHandleSystemEventProcPtr = ProcPtr;
{$ENDC}

	{
	   Determine if this instance of your configurator is the "master"
	   (the one that can create and destroy control streams)
	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  OTIsMasterConfigurator()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION OTIsMasterConfigurator(cfigor: TOTConfiguratorRef): BOOLEAN; C;

{  Get back the userData you passed in to OTNewConfigurator }
{
 *  OTGetConfiguratorUserData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTGetConfiguratorUserData(cfigor: TOTConfiguratorRef): Ptr; C;

{  Create a configurator object for use by Open Transport }
{
 *  OTNewConfigurator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTNewConfigurator(userData: UNIV Ptr; configure: OTCFConfigureProcPtr; createStream: OTCFCreateStreamProcPtr; handleEvent: OTCFHandleSystemEventProcPtr): TOTConfiguratorRef; C;

{  Delete a configurator object created by OTNewConfigurator }
{
 *  OTDeleteConfigurator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTDeleteConfigurator(cfigor: TOTConfiguratorRef); C;

{
   A utility function to send notifications to the user - it takes care of calls
   from deferred tasks
}
{
 *  OTNotifyUser()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTNotifyUser(VAR theFile: FSSpec; rsrcID: SInt32; index: OTItemCount; parm1: CStringPtr; parm2: CStringPtr): OSStatus; C;

{  Call when the configurator unloads from memory }
{
 *  OTConfiguratorUnloaded()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTConfiguratorUnloaded(cfigor: TOTConfiguratorRef); C;

{
   Call to create your control stream if you're not the master
   configurator.  You can also use the state machine function
   OTSMCreateControlStream(OTStateMachine*, OTConfigurationRef, TOTConfiguratorRef cfigor).
}
{
 *  OTCreateControlStream()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCreateControlStream(cfig: OTConfigurationRef; cfigor: TOTConfiguratorRef; proc: OTNotifyUPP; contextPtr: UNIV Ptr): OSStatus; C;

{
   A helpful function for the configurators to
   be able to recursively configure the children.
}
{
 *  OTConfigureChildren()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTConfigureChildren(cfig: OTConfigurationRef): OSStatus; C;

{  Allocate a bit in the system-wide control mask for streams. }
{
 *  OTNewControlMask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTNewControlMask: UInt32; C;

{  Warning: These 2 APIs is going away }
{
 *  OTCloseProvidersByUseCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTCloseProvidersByUseCount(VAR useCount: SInt32; reason: OTResult; doneDeal: OTBooleanParam); C;

{
 *  OTCloseProvidersByPortRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTCloseProvidersByPortRef(ref: OTPortRef; reason: OTResult; doneDeal: OTBooleanParam); C;

{  These are the "real" APIs }
{
 *  OTCloseProviderByStream()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTCloseProviderByStream(ref: StreamRef; reason: OTResult; doneDeal: OTBooleanParam); C;

{
 *  OTCloseMatchingProviders()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTCloseMatchingProviders(mask: UInt32; port: OTPortRef; reason: OTResult; doneDeal: OTBooleanParam); C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{  ***** OTStateMachine ***** }
{$IFC CALL_NOT_IN_CARBON }
{
   This utility set allows you to write an asynchronous chain of code that looks 
   somewhat like it is synchronous.  This is primarily used for plumbing 
   streams asynchronously, especially in configurators
}
{$IFC NOT OTKERNEL }
{  Alas, the state machine is only available to client code.  Sorry. }

{
   There are 12 or 8 bytes of reserved space at the front of
   the OTStateMachine structure, depending on whether you're
   building PowerPC or 68K code..  The OTStateMachineDataPad
   type compensates for this.
}

{$IFC TARGET_CPU_PPC }

TYPE
	OTStateMachineDataPad				= PACKED ARRAY [0..11] OF UInt8;
{$ELSEC}

TYPE
	OTStateMachineDataPad				= PACKED ARRAY [0..7] OF UInt8;
{$ENDC}  {TARGET_CPU_PPC}
	{
	   Forward define OTStateMachine so that OTStateProcPtr has
	   access to it.
	}
	OTStateMachinePtr = ^OTStateMachine;
	{
	   This type is is the required prototype of a state machine
	   entry point.
	}
{$IFC TYPED_FUNCTION_POINTERS}
	OTStateProcPtr = PROCEDURE(sm: OTStateMachinePtr);
{$ELSEC}
	OTStateProcPtr = ProcPtr;
{$ENDC}

	{
	   This type defines a routine that the state machine will
	   call when the top level completes.
	}
{$IFC TYPED_FUNCTION_POINTERS}
	OTSMCompleteProcPtr = PROCEDURE(contextPtr: UNIV Ptr); C;
{$ELSEC}
	OTSMCompleteProcPtr = ProcPtr;
{$ENDC}

	{  And now for the state machine structure itself. }
	OTStateMachine = RECORD
		fData:					OTStateMachineDataPad;
		fCookie:				Ptr;
		fCode:					OTEventCode;
		fResult:				OTResult;
	END;

	{
	   For structSize, pass the size of your structure that you want associated with
	   the state machine.  It can later be obtained by calling OTSMGetClientData.
	   For bufSize, use the kOTSMBufferSize macro, plus the size of your structure
	   to create a buffer on the stack. For synchronous calls, the stack buffer will
	   be used (unless you pass in NULL).  The callDepth is the depth level of nested
	   calls using OTSMCallStateProc.
	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  OTCreateStateMachine()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION OTCreateStateMachine(buf: UNIV Ptr; bufSize: OTByteCount; structSize: OTByteCount; proc: OTNotifyUPP; contextPtr: UNIV Ptr): OTStateMachinePtr; C;

{
 *  OTDestroyStateMachine()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTDestroyStateMachine(VAR sm: OTStateMachine); C;

{
   OTSMCallStateProc used to take a parameter of type UInt16_p,
   which was defined to be the same as UInt32.  In an attempt
   to reduce the number of wacky types defined by the OT
   interfaces, we've changed these routines to just take a
   straight UInt32.  You should be warned that the current
   implementation does not support values outside of the
   range 0..32767.  The same applies to OTSMSetState.
}

{
 *  OTSMCallStateProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTSMCallStateProc(VAR sm: OTStateMachine; proc: OTStateProcPtr; state: UInt32): BOOLEAN; C;

{
 *  OTSMGetState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTSMGetState(VAR sm: OTStateMachine): UInt16; C;

{
 *  OTSMSetState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTSMSetState(VAR sm: OTStateMachine; state: UInt32); C;

{  Fill out the fCookie, fCode, and fResult fields before calling! }
{
 *  OTSMComplete()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTSMComplete(VAR sm: OTStateMachine); C;

{
 *  OTSMPopCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTSMPopCallback(VAR sm: OTStateMachine); C;

{
 *  OTSMWaitForComplete()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTSMWaitForComplete(VAR sm: OTStateMachine): BOOLEAN; C;

{
 *  OTSMCreateStream()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTSMCreateStream(VAR sm: OTStateMachine; cfig: OTConfigurationRef; flags: OTOpenFlags): BOOLEAN; C;

{
 *  OTSMOpenStream()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTSMOpenStream(VAR sm: OTStateMachine; name: ConstCStringPtr; flags: OTOpenFlags): BOOLEAN; C;

{
 *  OTSMIoctl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTSMIoctl(VAR sm: OTStateMachine; strm: StreamRef; cmd: UInt32; data: LONGINT): BOOLEAN; C;

{
 *  OTSMPutMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTSMPutMessage(VAR sm: OTStateMachine; strm: StreamRef; VAR ctlbuf: strbuf; VAR databuf: strbuf; flags: OTFlags): BOOLEAN; C;

{
 *  OTSMGetMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTSMGetMessage(VAR sm: OTStateMachine; strm: StreamRef; VAR ctlbuf: strbuf; VAR databuf: strbuf; VAR flagsPtr: OTFlags): BOOLEAN; C;

{
 *  OTSMReturnToCaller()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTSMReturnToCaller(VAR sm: OTStateMachine): OSStatus; C;

{
 *  OTSMGetClientData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTSMGetClientData(VAR sm: OTStateMachine): Ptr; C;

{
 *  OTSMInstallCompletionProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTSMInstallCompletionProc(VAR sm: OTStateMachine; completeProc: OTSMCompleteProcPtr; contextPtr: UNIV Ptr); C;

{
 *  OTSMCreateControlStream()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTSMCreateControlStream(VAR sm: OTStateMachine; cfig: OTConfigurationRef; cfigor: TOTConfiguratorRef): BOOLEAN; C;



{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}
{  ***** Autopush Definitions ***** }
{
   The autopush functionality for Open Transport is based on the names of
   devices and modules, rather than on the major number information like 
   SVR4.  This is so that autopush information can be set up for modules
   that are not yet loaded.
}


{  Autopush ioctls. }

CONST
	I_SAD_SAP					= $6701;						{  Set autopush information      }
	I_SAD_GAP					= $6702;						{  Get autopush information      }
	I_SAD_VML					= $6703;						{  Validate a list of modules (uses str_list structure)  }

	{  Maximum number of modules autopushed on a driver. }

	kOTAutopushMax				= 8;


	{  ioctl structure used for SAD_SAP and SAD_GAP commands. }


TYPE
	OTAutopushInfoPtr = ^OTAutopushInfo;
	OTAutopushInfo = RECORD
		sap_cmd:				UInt32;
		sap_device_name:		PACKED ARRAY [0..31] OF CHAR;
		sap_minor:				SInt32;
		sap_lastminor:			SInt32;
		sap_npush:				SInt32;
		sap_list:				PACKED ARRAY [0..7,0..31] OF CHAR;
	END;

	{  Command values for sap_cmd field of the above. }

CONST
	kSAP_ONE					= 1;							{  Configure a single minor device          }
	kSAP_RANGE					= 2;							{  Configure a range of minor devices      }
	kSAP_ALL					= 3;							{  Configure all minor devices           }
	kSAP_CLEAR					= 4;							{  Clear autopush information           }


	{  ***** Configuration Helpers ***** }

	{
	   These definitions are used by device driver and port scanner
	   developers to provide a library giving client-side information about
	   the registered ports, such as a user-visible name or an icon.
	}

	{  Configuration helper library prefix }

	{
	   This prefix is prepended to the string found in the "fResourceInfo"
	   field of the OTPortRecord to build the actual library name of the
	   configuration helper library.
	}


	{  Get user visible port name entry point. }

	{
	   This entry point returns the user visible name of the port.  If includeSlot
	   is true, a slot distinguishing suffix (eg "slot X") should be added.  If
	   includePort is true, a port distinguishing suffix (eg " port X") should be added for
	   multiport cards.
	}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	OTGetPortNameProcPtr = PROCEDURE(VAR port: OTPortRecord; includeSlot: OTBooleanParam; includePort: OTBooleanParam; VAR userVisibleName: Str255); C;
{$ELSEC}
	OTGetPortNameProcPtr = ProcPtr;
{$ENDC}

	{  Get icon entry point. }
	{
	   This entry point returns the location of the icon for the port.  Return false if no
	   icon is provided.
	}

	OTResourceLocatorPtr = ^OTResourceLocator;
	OTResourceLocator = RECORD
		fFile:					FSSpec;
		fResID:					UInt16;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	OTGetPortIconProcPtr = FUNCTION(VAR port: OTPortRecord; VAR iconLocation: OTResourceLocator): BOOLEAN; C;
{$ELSEC}
	OTGetPortIconProcPtr = ProcPtr;
{$ENDC}

	{  ***** Application Access to Configuration Helpers ***** }

{$IFC NOT OTKERNEL }
	{
	   These routines are used by clients to get information about ports.
	   The canonical user of these routines is the OT control panel(s),
	   but applications may want to use them as well (to display the list
	   of available Ethernet cards, for example).
	}
	{   Returns a user friendly name for a port. }
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  OTGetUserPortNameFromPortRef()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE OTGetUserPortNameFromPortRef(ref: OTPortRef; VAR friendlyName: Str255); C;

{
    Returns the location for the icon familly representing the port.
    Returns false if the port has no icon.
}
{
 *  OTGetPortIconFromPortRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTGetPortIconFromPortRef(ref: OTPortRef; VAR iconLocation: OTResourceLocator): BOOLEAN; C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{  Returns true if the port can be used with the specified protocol. }
{$IFC CALL_NOT_IN_CARBON }
{
 *  OTIsPortCompatibleWith()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTIsPortCompatibleWith({CONST}VAR port: OTPortRecord; protocolName: CStringPtr): BOOLEAN; C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{  ***** Common Utilities ***** }
{
   The utilities defined in this section are available to both client
   and kernel code.  Cool huh?  These utilities differ from those
   provided in "OpenTransport.h" in that they are only available to native
   architecture clients.
}

{  Bitmap functions }

{  These functions atomically deal with a bitmap that is multiple-bytes long }

{
   Set the first clear bit in "bitMap", starting with bit "startBit",
   giving up after "numBits".  Returns the bit # that was set, or
   a kOTNotFoundErr if there was no clear bit available
}
{
 *  OTSetFirstClearBit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTSetFirstClearBit(VAR bitMap: UInt8; startBit: OTByteCount; numBits: OTByteCount): OTResult; C;

{  Standard clear, set and test bit functions }
{
 *  OTClearBit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTClearBit(VAR bitMap: UInt8; bitNo: OTByteCount): BOOLEAN; C;

{
 *  OTSetBit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTSetBit(VAR bitMap: UInt8; bitNo: OTByteCount): BOOLEAN; C;

{
 *  OTTestBit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTTestBit(VAR bitMap: UInt8; bitNo: OTByteCount): BOOLEAN; C;

{  OTHashList }

{
   This implements a simple, but efficient hash list.  It is not
   thread-safe.
}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	OTHashProcPtr = FUNCTION(VAR linkToHash: OTLink): UInt32; C;
{$ELSEC}
	OTHashProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	OTHashSearchProcPtr = FUNCTION(ref: UNIV Ptr; VAR linkToCheck: OTLink): BOOLEAN; C;
{$ELSEC}
	OTHashSearchProcPtr = ProcPtr;
{$ENDC}

	OTHashListPtr = ^OTHashList;
	OTHashList = RECORD
		fHashProc:				OTHashProcPtr;
		fHashTableSize:			ByteCount;
		fHashBuckets:			^OTLinkPtr;
	END;

	{
	   Return the number of bytes of memory needed to create a hash list
	   of at least "numEntries" entries.
	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  OTCalculateHashListMemoryNeeds()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION OTCalculateHashListMemoryNeeds(numEntries: OTItemCount): OTByteCount; C;

{
   Create an OTHashList from "memory".  Return an error if it
   couldn't be done.
}
{
 *  OTInitHashList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTInitHashList(memory: UNIV Ptr; numBytes: OTByteCount; hashProc: OTHashProcPtr): OTResult; C;

{
 *  OTAddToHashList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTAddToHashList(VAR hashList: OTHashList; VAR linkToAdd: OTLink); C;

{
 *  OTRemoveLinkFromHashList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTRemoveLinkFromHashList(VAR hashList: OTHashList; VAR linkToRemove: OTLink): BOOLEAN; C;

{
 *  OTIsInHashList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTIsInHashList(VAR hashList: OTHashList; VAR link: OTLink): BOOLEAN; C;

{
 *  OTFindInHashList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTFindInHashList(VAR hashList: OTHashList; searchProc: OTHashSearchProcPtr; refPtr: UNIV Ptr; hashValue: UInt32): OTLinkPtr; C;

{
 *  OTRemoveFromHashList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTRemoveFromHashList(VAR hashList: OTHashList; searchProc: OTHashSearchProcPtr; refPtr: UNIV Ptr; hashValue: UInt32): OTLinkPtr; C;

{$ENDC}  {CALL_NOT_IN_CARBON}

{  Random functions }

{
   These implement a very simple random number generator, suitable
   for protocol implementations but not "cryptographically" random.
}

{$IFC CALL_NOT_IN_CARBON }
{
 *  OTGetRandomSeed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTGetRandomSeed: UInt32; C;

{
 *  OTGetRandomNumber()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTGetRandomNumber(VAR seed: UInt32; lo: UInt32; hi: UInt32): UInt32; C;

{  Concurrency Control }

{
   OTGate implements a cool concurrency control primitive.
   You're not going to understand it without reading the documentation!
   See "Open Transport Advanced Client Programming" for details.
   WARNING:
   This structure must be on a 4-byte boundary.
}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	OTGateProcPtr = FUNCTION(VAR thisLink: OTLink): BOOLEAN; C;
{$ELSEC}
	OTGateProcPtr = ProcPtr;
{$ENDC}

	OTGatePtr = ^OTGate;
	OTGate = RECORD
		fLIFO:					OTLIFO;
		fList:					OTList;
		fProc:					OTGateProcPtr;
		fNumQueued:				SInt32;
		fInside:				SInt32;
	END;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  OTInitGate()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE OTInitGate(VAR gate: OTGate; proc: OTGateProcPtr); C;

{
 *  OTEnterGate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTEnterGate(VAR gate: OTGate; VAR withLink: OTLink): BOOLEAN; C;

{
 *  OTLeaveGate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTLeaveGate(VAR gate: OTGate): BOOLEAN; C;

{  ***** Shared Library Bonus Extras ***** }

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
   These routines provide addition shared library support beyond
   that provided by the base shared library mechanism.
}
{
   Some flags which can be passed to the "loadFlags" parameter of the
   various CFM routines.  Not all flags can be used with all routines.
   See "Open Transport Advanced Client Programming" for details.
}


CONST
	kOTGetDataSymbol			= 0;
	kOTGetCodeSymbol			= 1;
	kOTLoadNewCopy				= 2;
	kOTLoadACopy				= 4;
	kOTFindACopy				= 8;
	kOTLibMask					= 14;
	kOTLoadLibResident			= $20;

	{  Finding all matching CFM libraries. }

	{
	   The routine OTFindCFMLibraries allows you to find all CFM libraries
	   that match specific criteria.  The result is placed in a list
	   of CFMLibraryInfo structures.  OT allocates those structures using
	   a routine of type OTAllocMemProcPtr that you pass to OTFindCFMLibraries.
	}

	{
	   A list of CFMLibraryInfo structures is returned by the OTFindCFMLibraries routine.
	   The list is created out of the data that is passed to the function.
	   
	   IMPORTANT:
	   Only the first 3 fields are valid when using OT 1.2 and older.
	}


TYPE
	CFMLibraryInfoPtr = ^CFMLibraryInfo;
	CFMLibraryInfo = RECORD
		link:					OTLink;									{  To link them all up on a list             }
		libName:				CStringPtr;								{  "C" String which is fragment name           }
		intlName:				StringPtr;								{  Pascal String which is internationalized name   }
		fileSpec:				FSSpecPtr;								{  location of fragment's file  }
		pstring2:				StringPtr;								{  Secondary string from extended cfrg           }
		pstring3:				StringPtr;								{  Extra info from extended cfrg             }
	END;

	{
	   You must pass a routine of type OTAllocMemProcPtr to OTFindCFMLibraries
	   which it calls to allocate memory for the CFMLibraryInfo structures.
	}
{$IFC TYPED_FUNCTION_POINTERS}
	OTAllocMemProcPtr = FUNCTION(size: OTByteCount): Ptr; C;
{$ELSEC}
	OTAllocMemProcPtr = ProcPtr;
{$ENDC}

	{  Find CFM libraries of the specified kind and type }
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  OTFindCFMLibraries()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION OTFindCFMLibraries(libKind: OSType; libType: ConstCStringPtr; VAR theList: OTList; allocator: OTAllocMemProcPtr): OSStatus; C;

{  Loading libraries and connecting to symbols. }

{  Load a CFM library by name }
{
 *  OTLoadCFMLibrary()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTLoadCFMLibrary(libName: ConstCStringPtr; VAR connID: UInt32; loadFlags: UInt32): OSStatus; C;

{  Load a CFM library and get a named pointer from it }
{
 *  OTGetCFMPointer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTGetCFMPointer(libName: ConstCStringPtr; entryName: ConstCStringPtr; VAR connID: UInt32; loadFlags: UInt32): Ptr; C;

{  Get a named pointer from a CFM library that's already loaded }
{
 *  OTGetCFMSymbol()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTGetCFMSymbol(entryName: ConstCStringPtr; connID: UInt32; loadFlags: UInt32): Ptr; C;

{  Release a connection to a CFM library }
{
 *  OTReleaseCFMConnection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTReleaseCFMConnection(VAR connID: UInt32); C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC NOT TARGET_CPU_68K }
{
   You can call these routines in your CFM initialisation and termination
   routines to hold or unhold your libraries sections.
}
{
   Used in a CFM InitProc, will hold the executable code, if applicable.
   This can also be the InitProc of the library
}
{$IFC CALL_NOT_IN_CARBON }
{
 *  OTHoldThisCFMLibrary()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTHoldThisCFMLibrary({CONST}VAR initBlock: CFragInitBlock): OSStatus; C;

{
   Used in a CFM terminate proc, will unhold the executable code, if applicable.
   This can also be the terminate proc of the library
}
{
 *  OTUnholdThisCFMLibrary()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTUnholdThisCFMLibrary; C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}
{  ASLM Utilities }
{  Load an ASLM library }
{$IFC CALL_NOT_IN_CARBON }
{
 *  OTLoadASLMLibrary()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTLoadASLMLibrary(libName: ConstCStringPtr): OSStatus; C;

{  Unload an ASLM library }
{
 *  OTUnloadASLMLibrary()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTUnloadASLMLibrary(libName: ConstCStringPtr); C;

{
   This is an ASLM utility routine.  You can get it by including
   "LibraryManagerUtilities.h", but since we only use a few ASLM utilities,
   we put the prototype here for convenience.
}

{
 *  UnloadUnusedLibraries()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE UnloadUnusedLibraries; C;


{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC NOT OTKERNEL }
{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$ifc not undefined __MWERKS and TARGET_CPU_68K}
    {$pragmac d0_pointers reset}
{$endc}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OpenTransportProtocolIncludes}

{$ENDC} {__OPENTRANSPORTPROTOCOL__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
