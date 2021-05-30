{
     File:       OpenTransportKernel.p
 
     Contains:   Definitions for Open Transport kernel code, such as drivers and protocol modules.
 
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
 UNIT OpenTransportKernel;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTRANSPORTKERNEL__}
{$SETC __OPENTRANSPORTKERNEL__ := 1}

{$I+}
{$SETC OpenTransportKernelIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC NOT UNDEFINED OTKERNEL }
{$IFC NOT OTKERNEL }
{$ENDC}
{$ENDC}

{$SETC OTKERNEL := 1 }
{
   We include "OpenTransportProtocol.h", which in turn includes
   "OpenTransport.h", thereby picking up all the stuff which
   is shared between client and kernel.
}
{$IFC UNDEFINED __OPENTRANSPORTPROTOCOL__}
{$I OpenTransportProtocol.p}
{$ENDC}
{$IFC UNDEFINED __NAMEREGISTRY__}
{$I NameRegistry.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


{$ifc not undefined __MWERKS and TARGET_CPU_68K}
    {$pragmac d0_pointers on}
{$endc}

{  ***** From the Mentat "mistream.h" ***** }


{
   Parts of "mistream.h" that are shared by the client
   and the kernel are in "OpenTransportProtocol.h".
}


{$IFC CALL_NOT_IN_CARBON }
{
 *  allocb()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION allocb(size: OTByteCount; pri: OTInt32): mblk_tPtr; C;

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	allocbiProc = PROCEDURE(arg: CStringPtr); C;
{$ELSEC}
	allocbiProc = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  allocbi()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION allocbi(size: OTByteCount; pri: OTInt32; pfv: allocbiProc; arg: CStringPtr; VAR base: UInt8): mblk_tPtr; C;

{
 *  allocq()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION allocq: queue_tPtr; C;

{
 *  adjmsg()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION adjmsg(VAR mp: mblk_t; len_param: OTInt32): OTInt32; C;

{
 *  backq()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION backq(VAR q: queue_t): queue_tPtr; C;

{
 *  bcanput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION bcanput(VAR q: queue_t; pri: OTUInt8Param): OTInt32; C;

{
 *  bcanputnext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION bcanputnext(VAR q: queue_t; pri: OTUInt8Param): OTInt32; C;

{
 *  bufcall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION bufcall(memNeeded: OTByteCount; pri: OTInt32; proc: bufcallp_t; context: LONGINT): OTInt32; C;

{
 *  canput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION canput(VAR q: queue_t): OTInt32; C;

{
 *  canputnext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION canputnext(VAR q: queue_t): OTInt32; C;

{
 *  copyb()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION copyb(VAR mp: mblk_t): mblk_tPtr; C;

{
 *  copymsg()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION copymsg(VAR mp: mblk_t): mblk_tPtr; C;

{
 *  dupb()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION dupb(VAR mp: mblk_t): mblk_tPtr; C;

{
 *  dupmsg()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION dupmsg(VAR mp: mblk_t): mblk_tPtr; C;

{
 *  esballoc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION esballoc(VAR base: UInt8; size: OTByteCount; pri: OTInt32; VAR freeInfo: frtn_t): mblk_tPtr; C;

{
 *  esballoca()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION esballoca(VAR base: UInt8; size: OTByteCount; pri: OTInt32; VAR freeInfo: frtn_t): mblk_tPtr; C;

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	esbbcallProc = PROCEDURE(arg: LONGINT); C;
{$ELSEC}
	esbbcallProc = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  esbbcall()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION esbbcall(pri: OTInt32; func: esbbcallProc; arg: LONGINT): OTInt32; C;

{
 *  flushband()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE flushband(VAR q: queue_t; pri: OTUInt8Param; flag: OTInt32); C;

{
 *  flushq()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE flushq(VAR q: queue_t; flag: OTInt32); C;

{
 *  freeb()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE freeb(VAR mp: mblk_t); C;

{
 *  freemsg()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE freemsg(VAR mp: mblk_t); C;

{
 *  freeq()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION freeq(VAR q: queue_t): OTInt32; C;

{
 *  freezestr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION freezestr(VAR q: queue_t): OTInt32; C;

{
 *  getadmin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION getadmin(mid: OTUInt16Param): admin_t; C;

{
 *  getmid()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION getmid(name: CStringPtr): UInt16; C;

{
 *  getq()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION getq(VAR q: queue_t): mblk_tPtr; C;

{
 *  insq()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION insq(VAR q: queue_t; VAR emp: mblk_t; VAR nmp: mblk_t): OTInt32; C;

{
 *  linkb()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE linkb(VAR mp1: mblk_t; VAR mp2: mblk_t); C;

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	mpnotifyProc = PROCEDURE(arg: CStringPtr); C;
{$ELSEC}
	mpnotifyProc = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  mpnotify()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION mpnotify(VAR mp: mblk_t; pfv: mpnotifyProc; arg: CStringPtr): OTInt32; C;

{
 *  msgdsize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION msgdsize({CONST}VAR mp: mblk_t): OTInt32; C;

{
 *  msgpullup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION msgpullup(VAR mp: mblk_t; len: OTInt32): mblk_tPtr; C;

{
 *  pullupmsg()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION pullupmsg(VAR mp: mblk_t; len: OTInt32): OTInt32; C;

{
 *  put()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION put(VAR q: queue_t; VAR mp: mblk_t): OTInt32; C;

{
 *  putbq()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION putbq(VAR q: queue_t; VAR mp: mblk_t): OTInt32; C;

{
 *  putctl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION putctl(VAR q: queue_t; mType: OTInt32): OTInt32; C;

{
 *  putnextctl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION putnextctl(VAR q: queue_t; mType: OTInt32): OTInt32; C;

{
 *  putctl1()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION putctl1(VAR q: queue_t; mType: OTInt32; c: OTInt32): OTInt32; C;

{
 *  putnextctl1()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION putnextctl1(VAR q: queue_t; mType: OTInt32; c: OTInt32): OTInt32; C;

{
 *  putctl2()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION putctl2(VAR q: queue_t; mType: OTInt32; c1: OTInt32; c2: OTInt32): OTInt32; C;

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC UNDEFINED puthere }
{$IFC CALL_NOT_IN_CARBON }
{
 *  puthere()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION puthere(VAR q: queue_t; VAR mp: mblk_t): OTInt32; C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  putnext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION putnext(VAR q: queue_t; VAR mp: mblk_t): OTInt32; C;

{
 *  putq()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION putq(VAR q: queue_t; VAR mp: mblk_t): OTInt32; C;

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  qenable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE qenable(VAR q: queue_t); C;

{
 *  qprocson()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE qprocson(VAR q: queue_t); C;

{
 *  qprocsoff()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE qprocsoff(VAR q: queue_t); C;

{
 *  qreply()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION qreply(VAR q: queue_t; VAR mp: mblk_t): OTInt32; C;

{
 *  qsize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION qsize(VAR q: queue_t): OTInt32; C;

{
 *  rmvb()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION rmvb(VAR mp: mblk_t; VAR bp: mblk_t): mblk_tPtr; C;

{
 *  rmvq()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE rmvq(VAR q: queue_t; VAR mp: mblk_t); C;

{ prototype for strlog in "strlog.h" section, below }
{
 *  strqget()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION strqget(VAR q: queue_t; what: qfields_t; pri: OTUInt8Param; VAR valp: LONGINT): OTInt32; C;

{
 *  strqset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION strqset(VAR q: queue_t; what: qfields_t; pri: OTUInt8Param; val: LONGINT): OTInt32; C;

{
 *  testb()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION testb(size: OTByteCount; pri: OTInt32): OTInt32; C;

{
 *  unbufcall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE unbufcall(id: OTInt32); C;

{
 *  unfreezestr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE unfreezestr(VAR q: queue_t; oldpri: OTInt32); C;

{
 *  unlinkb()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION unlinkb(VAR mp: mblk_t): mblk_tPtr; C;

{  ***** From the Mentat "strlog.h" ***** }


{$IFC NOT UNDEFINED __MWERKS }
{
 *  strlog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION strlog(mid: OTInt32; sid: OTInt32; level: OTInt32; flags: OTUInt32; fmt: CStringPtr; ...): OTInt32; C;

{$ENDC}
{  ***** Printing Functions ***** }

{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	kOTPrintOnly				= 0;
	kOTPrintThenStop			= 1;

{$IFC NOT UNDEFINED __MWERKS }
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  OTKernelPrintf()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION OTKernelPrintf(toDo: OTInt32; fmt: CStringPtr; ...): OTInt32; C;

{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	CE_CONT						= 0;							{  Does kOTPrintOnly    }
	CE_NOTE						= 0;							{  Just print  }
	CE_WARN						= 1;							{  Does kOTPrintThenStop   }
	CE_PANIC					= 2;							{  Does System Error 107   }

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  cmn_err()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE cmn_err(errType: OTInt32; fmt: CStringPtr; ...); C;

{$IFC NOT UNDEFINED __MWERKS }
{
 *  mi_sprintf()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_sprintf(buf: CStringPtr; fmt: CStringPtr; ...): OTInt32; C;

{$ENDC}
{  Create sprintf and printf functions that will work in STREAM modules. }

{  ***** FIIK ***** }

{  ••• useful header comment please ••• }

{
   Function to convert the "long" value that comes back in some of the
   netbufs as a result code to the equivalent OSStatus
}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	OTError								= LONGINT;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  OTErrorToOSStatus()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION OTErrorToOSStatus(err: OTError): OSStatus; C;

{  ***** STREAMS Plug-in Interface **** }

{
   Synchronization level codes.  These are supplied to modsw_install and
   stored in the appropriate tables.  sth_osr_open and
   sth_ipush use these to set up synch queue subordination for new devices
   and modules.
}

{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	SQLVL_QUEUE					= 1;
	SQLVL_QUEUEPAIR				= 2;
	SQLVL_MODULE				= 3;
	SQLVL_GLOBAL				= 4;
	SQLVL_DEFAULT				= 3;

	{  The install_info structure. }


TYPE
	install_infoPtr = ^install_info;
	install_info = RECORD
		install_str:			streamtabPtr;							{  Streamtab pointer.      }
		install_flags:			UInt32;
		install_sqlvl:			UInt32;									{  Synchronization level.  }
		install_buddy:			CStringPtr;								{  Shared writer list buddy  }
		ref_load:				LONGINT;								{  Set to 0              }
		ref_count:				UInt32;									{  set to 0              }
	END;

	{   Flags used in the install_flags field }

CONST
	kOTModIsDriver				= $00000001;
	kOTModIsModule				= $00000002;
	kOTModNoWriter				= $00000010;
	kOTModUpperIsTPI			= $00001000;
	kOTModUpperIsDLPI			= $00002000;
	kOTModLowerIsTPI			= $00004000;
	kOTModLowerIsDLPI			= $00008000;
	kOTModGlobalContext			= $00800000;					{  This flag says you don't want per-context globals }
	kOTModUsesInterrupts		= $08000000;					{  This flag is only valid if kOTModIsDriver is set and the driver is a PCI-card driver using the Name Registry }
	kOTModIsComplexDriver		= $20000000;					{  This flag is only valid if kOTModIsDriver is set. }
	kOTModIsFilter				= $40000000;					{  This flag is only valid if kOTModIsModule is set. }

	{  Typedef for the GetOTInstallInfo function }

	{
	   Your module must export this function, and return a pointer to the
	   install_info structure for the module.
	}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	GetOTInstallInfoProcPtr = FUNCTION: install_infoPtr; C;
{$ELSEC}
	GetOTInstallInfoProcPtr = ProcPtr;
{$ENDC}

	{  Typedef for the InitStreamModule function }
	{
	   Your module can optionally export this function.  It will be called 
	   whenever your module is about to be loaded into a stream for the
	   first time, or if it is about to be reloaded after having been 
	   unloaded. Return false if your module should NOT be loaded.
	   For STREAMS modules, the void* parameter will be NULL.  For drivers, it
	   will be the same cookie parameter that was used for registering the module.
	   For PCI card drivers, this will be a pointer to the OTPCIInfo structure,
	   which can also be interpreted as a RegEntryIDPtr.
	}

{$IFC TYPED_FUNCTION_POINTERS}
	InitStreamModuleProcPtr = FUNCTION(portInfo: UNIV Ptr): BOOLEAN; C;
{$ELSEC}
	InitStreamModuleProcPtr = ProcPtr;
{$ENDC}

	{  Typedef for the TerminateStreamModule function }
	{
	   Your module can optionally export this function.  It will be called 
	   whenever your module has been closed for the last time (i.e. no other 
	   outstanding instances of the module exist).
	}

{$IFC TYPED_FUNCTION_POINTERS}
	TerminateStreamModuleProcPtr = PROCEDURE(portInfo: UNIV Ptr); C;
{$ELSEC}
	TerminateStreamModuleProcPtr = ProcPtr;
{$ENDC}

	{  Equates for shared library prefixes }

	{  ***** Majors and Minors ***** }

	{  Functions for dealing with major and minor device numbers }

	major_t								= UInt16;
	minor_t								= UInt16;
	{
	   This is the first minor number that Apple OT drivers use for CLONEOPENs.
	   Minor numbers 0 through 9 are reserved for use by the modules
	   for various control streams.  Note that Mentat drivers, which
	   use mi_open_comm, start minor numbers from 5.
	}

CONST
	kFirstMinorNumber			= 10;

	{  ***** Logging Macros ***** }

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  OTStrlog()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE OTStrlog(VAR q: queue_t; lvl: OTInt32; flags: OTInt32; str: ConstCStringPtr); C;

{  These are enums for the level value }

{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	kOTLvlFatal					= 0;
	kOTLvlNonfatal				= 1;
	kOTLvlExtFatal				= 2;
	kOTLvlExtNonfatal			= 3;
	kOTLvlUserErr				= 4;
	kOTLvlInfoErr				= 5;
	kOTLvlInfoOnly				= 6;


	{  ***** TPI Additions ***** }

	{
	   Extra OTCommand codes that may appear on your module queue.
	   These are extensions to the TPI specification for Open Transport.
	   T_PRIVATE_REQ is the first available TPI message number for private
	   use by modules (assuming you don't want to be confused by standard
	   TPI messages).
	}


	kOTT_TIMER_REQ				= 80;							{  Timer event                    }
	kOTT_MIB_REQ				= 81;							{  Request module's MIB              }
	kOTT_MIB_ACK				= 82;							{  The module's MIB is available    }
	kOTT_PRIVATE_REQ			= 90;							{  The first private request available     }


TYPE
	T_MIB_reqPtr = ^T_MIB_req;
	T_MIB_req = RECORD
		PRIM_type:				LONGINT;								{  Always T_MIB_REQ  }
	END;

	T_MIB_ackPtr = ^T_MIB_ack;
	T_MIB_ack = RECORD
		PRIM_type:				LONGINT;								{  Always T_MIB_ACK    }
		MIB_length:				LONGINT;								{  MIB length           }
		MIB_offset:				LONGINT;								{  MIB Offset          }
	END;

	T_stream_timerPtr = ^T_stream_timer;
	T_stream_timer = RECORD
		PRIM_type:				LONGINT;								{  Always T_TIMER_REQ  }
		CASE INTEGER OF
		0: (
			USER_long:			LONGINT;
			);
		1: (
			USER_ptr:			Ptr;
			);
	END;

	{  ***** Kernel Port Stuff ***** }
	{
	   Kernel port record, which is a direct analogue of
	   the OTPortRecord in "OpenTransport.h".  Note that
	   when working with TPortRecord's, you're always
	   working with OT's one true copy of the record,
	   whereas when working with OTPortRecord's, you're
	   always working with a copy.
	}

	TPortRecordPtr = ^TPortRecord;
	TPortRecord = RECORD
		fLink:					OTLink;
		fPortName:				CStringPtr;
		fModuleName:			CStringPtr;
		fResourceInfo:			CStringPtr;
		fSlotID:				CStringPtr;
		fAlias:					TPortRecordPtr;
		fNumChildren:			ItemCount;
		fChildPorts:			OTPortRefPtr;
		fPortFlags:				UInt32;
		fInfoFlags:				UInt32;
		fCapabilities:			UInt32;
		fRef:					OTPortRef;
		fStreamtab:				streamtabPtr;
		fContext:				Ptr;
		fExtra:					Ptr;
	END;

	{  Port utilities }
	{
	   These routines can be used by kernel code to register, find and iterate
	   through the various ports on the machine.  Do not confuse these with
	   the client-side routines, defined in "OpenTransport.h".
	}

	{
	   Register a port. The name the port was registered under is returned in
	   the fPortName field.  This routine allocates a TPortRecord and
	   copies the supplied OTPortRecord into it.
	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  OTRegisterPort()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION OTRegisterPort(VAR portInfo: OTPortRecord; ref: UNIV Ptr): OSStatus; C;

{
   Unregister the port with the given name (If you re-register the
   port, it may get a different name - use OTChangePortState if
   that is not desireable).  Since a single OTPortRef can be registered
   with several names, the API needs to use the portName rather than
   the OTPortRef to disambiguate.
}
{
 *  OTUnregisterPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTUnregisterPort(portName: ConstCStringPtr; VAR refPtr: UNIV Ptr): OSStatus; C;

{  Change the state of the port. }
{
 *  OTChangePortState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTChangePortState(portRef: OTPortRef; theChange: OTEventCode; why: OTResult): OSStatus; C;

{  Find the TPortRecord for a given Port Name }
{
 *  OTFindPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTFindPort(portName: ConstCStringPtr): TPortRecordPtr; C;

{  Find the "nth" TPortRecord }
{
 *  OTGetIndexedPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTGetIndexedPort(index: OTItemCount): TPortRecordPtr; C;

{
   Find another port that is active and conflicts with
   the port described by "ref"
}
{
 *  OTFindPortConflict()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTFindPortConflict(ref: OTPortRef): TPortRecordPtr; C;

{  Other ways of finding the port }
{
 *  OTFindPortByRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTFindPortByRef(ref: OTPortRef): TPortRecordPtr; C;

{
 *  OTFindPortByDev()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTFindPortByDev(dev: dev_t): TPortRecordPtr; C;

{  ***** Port Scanners ***** }

{  Shared library definitions }

{
   Prefix for Open Transport port scanners.
   Your port-scanning ASLM function set must use the prefix kOTPortScannerPrefix.
}

{
   The kOTPortScannerInterfaceID define is what you need to add to your
   export file for the "interfaceID = " clause.  
}


{  OTScanPorts entry point. }

{  Your port-scanning function must be exported by the name "OTScanPorts". }

{  Selectors for the scanType parameter to PortScanProcPtr. }

{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	kOTInitialScan				= 0;
	kOTScanAfterSleep			= 1;

	{  PortScanProcPtr is the typedef for the scanning function. }


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PortScanProcPtr = PROCEDURE(scanType: UInt32); C;
{$ELSEC}
	PortScanProcPtr = ProcPtr;
{$ENDC}

	{
	   Memory allocation for port persistent data, such as the
	   memory referenced by the ref parameter you pass to
	   OTRegisterPort.
	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  OTAllocPortMem()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION OTAllocPortMem(size: OTByteCount): Ptr; C;

{
 *  OTFreePortMem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTFreePortMem(mem: UNIV Ptr); C;

{  ***** Interrupt Control Functions **** }

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC TARGET_CPU_68K }
{
   MPS_INTR_STATE saves the current interrupt state
   Its definition changes with the definition
   of mps_intr_enable/disable, so this typedef is
   also inside the TARGET_CPU_68K conditional.
}

TYPE
	MPS_INTR_STATE						= UInt8;
	{  Disable interrupts and save the state }
{$IFC OTDEBUG }
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  mps_intr_disable()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE mps_intr_disable(VAR oldState: MPS_INTR_STATE); C;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ELSEC}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  mps_intr_disable()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE mps_intr_disable(VAR oldState: MPS_INTR_STATE); C;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OTDEBUG}
{
   move sr,d0
   asr.w #8,d0
   ori #$600,sr
   andi #$FEFF,sr
   move.b d0,(a0)
   #if OTDEBUG
       andi.b #$70,d0
       cmpi.b #$70,d0
       bne.s @3
       DebugBreak
   #endif
}
{  Enable interrupts from the saved state }
{$IFC OTDEBUG }
{$IFC CALL_NOT_IN_CARBON }
{
 *  mps_intr_enable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE mps_intr_enable(VAR oldState: MPS_INTR_STATE); C;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ELSEC}
{$IFC CALL_NOT_IN_CARBON }
{
 *  mps_intr_enable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE mps_intr_enable(VAR oldState: MPS_INTR_STATE); C;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OTDEBUG}
{
   #if OTDEBUG
       move sr,d0
       andi.w #$700,d0
       cmpi.w #$600,d0
       beq.s @2
       DebugBreak
   #endif
   move.b (a0),d0
   #if OTDEBUG
       andi.b #$70,d0
       cmpi.b #$70,d0
       bne.s @3
       DebugBreak
       move.b (a0),d0
   #endif
   asl.w #8,d0
   move d0,sr
}
{$ELSEC}

TYPE
	MPS_INTR_STATE						= UInt8;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  mps_intr_disable()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE mps_intr_disable(VAR oldState: MPS_INTR_STATE); C;

{
 *  mps_intr_enable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE mps_intr_enable(VAR oldState: MPS_INTR_STATE); C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_CPU_68K}

{  ***** Timer Functions ***** }

CONST
	kOTMinimumTimerValue		= 8;							{  8 milliseconds is the minimum timeout value }

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  mi_timer_alloc()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION mi_timer_alloc(VAR q: queue_t; size: OTByteCount): mblk_tPtr; C;

{
 *  mi_timer_free()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE mi_timer_free(VAR mp: mblk_t); C;

{
 *  mi_timer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE mi_timer(VAR mp: mblk_t; milliSeconds: UInt32); C;

{
 *  mi_timer_cancel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_timer_cancel(VAR mp: mblk_t): BOOLEAN; C;

{
 *  mi_timer_valid()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_timer_valid(VAR mp: mblk_t): BOOLEAN; C;

{
 *  mi_timer_q_switch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_timer_q_switch(VAR mp: mblk_t; VAR q: queue_t; VAR new_mp: mblk_t): mblk_tPtr; C;

{  ***** Driver Deferred Task Extras ***** }

{
   This routine is used by a driver at interrupt time to schedule
   a deferred task to run their interrupt processing code.
}
{
 *  OTScheduleDriverDeferredTask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTScheduleDriverDeferredTask(dtCookie: LONGINT): BOOLEAN; C;

{  ***** Driver Memory Routines ***** }

{
   These routines are different from the
   similarly named routines in "OpenTransport.h" because they allocate
   memory in the OT kernel pool.  See Technote •••• "Understanding
   Open Transport Memory Management" for details.
}

{
   This is the typedef for a function that will be called when a message
   created by OTAllocMsg is destroyed.
}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	EsbFreeProcPtr = PROCEDURE(arg: CStringPtr); C;
{$ELSEC}
	EsbFreeProcPtr = ProcPtr;
{$ENDC}

	{
	   This function creates a message which points to "size" bytes of data
	   at "buf".  When the message is freed, the EsbFreeProcPtr function "func"
	   will be called with the argument "arg".
	   NOTE: This function allows users of your buffer to modify the buffer.
	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  OTAllocMsg()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION OTAllocMsg(buf: UNIV Ptr; size: OTByteCount; func: EsbFreeProcPtr; arg: UNIV Ptr): mblk_tPtr; C;

{
   Routines to allocate and free memory in your modules (these are
   interrupt-time safe!).
}

{
 *  OTAllocMem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTAllocMem(size: OTByteCount): Ptr; C;

{
 *  OTFreeMem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTFreeMem(mem: UNIV Ptr); C;

{
 *  OTReallocMem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTReallocMem(ptr: UNIV Ptr; newSize: OTByteCount): Ptr; C;

{
   Also, make sure that calling traditional "C" allocation routines
   will not compile.
}

{  ***** Kernel Memory Utilities ***** }

{
 *  mi_bcmp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_bcmp(first: ConstCStringPtr; second: ConstCStringPtr; nBytes: OTByteCount): OTInt32; C;

{  Standard STREAMS memory utilities. }

{
   Standard STREAMS bcopy, bzero, & bcmp take char* parameters.
   The BCOPY, BZERO, and BCMP routines take void* so that we do not have
   to cast all the pointers.
}


{******************************************************************************
** Some helpful utilites from Mentat
*******************************************************************************}
{  Routines to calculate various sizes of STREAM messages }

{  Useful macros for STREAMS copy in and out. }

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	OTWriterProcPtr = PROCEDURE(VAR q: queue_t; VAR mp: mblk_t); C;
{$ELSEC}
	OTWriterProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  mps_become_writer()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE mps_become_writer(VAR q: queue_t; VAR mp: mblk_t; proc: OTWriterProcPtr); C;

{
 *  drv_priv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION drv_priv(VAR credp: cred): OTInt32; C;

{
 *  mi_allocq()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_allocq(VAR st: streamtab): queue_tPtr; C;

{
 *  mi_tpi_ack_alloc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_tpi_ack_alloc(VAR mp: mblk_t; size: OTByteCount; primType: LONGINT): mblk_tPtr; C;

{
 *  mi_tpi_conn_con()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_tpi_conn_con(VAR trailer_mp: mblk_t; src: CStringPtr; src_length: OTByteCount; opt: CStringPtr; opt_length: OTByteCount): mblk_tPtr; C;

{
 *  mi_tpi_conn_ind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_tpi_conn_ind(VAR trailer_mp: mblk_t; src: CStringPtr; src_length: OTByteCount; opt: CStringPtr; opt_length: OTByteCount; seqnum: OTInt32): mblk_tPtr; C;

{
 *  mi_tpi_conn_req()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_tpi_conn_req(VAR trailer_mp: mblk_t; dest: CStringPtr; dest_length: OTByteCount; opt: CStringPtr; opt_length: OTByteCount): mblk_tPtr; C;

{
 *  mi_tpi_data_ind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_tpi_data_ind(VAR trailer_mp: mblk_t; flags: OTInt32; ptype: LONGINT): mblk_tPtr; C;

{
 *  mi_tpi_data_req()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_tpi_data_req(VAR trailer_mp: mblk_t; flags: OTInt32; pttype: LONGINT): mblk_tPtr; C;

{
 *  mi_tpi_discon_ind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_tpi_discon_ind(VAR trailer_mp: mblk_t; reason: OTInt32; seqnum: OTInt32): mblk_tPtr; C;

{
 *  mi_tpi_discon_req()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_tpi_discon_req(VAR trailer_mp: mblk_t; seqnum: OTInt32): mblk_tPtr; C;

{
 *  mi_tpi_err_ack_alloc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_tpi_err_ack_alloc(VAR mp: mblk_t; tlierr: OTInt32; unixerr: OTInt32): mblk_tPtr; C;

{
 *  mi_tpi_exdata_ind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_tpi_exdata_ind(VAR trailer_mp: mblk_t; flags: OTInt32; ptype: LONGINT): mblk_tPtr; C;

{
 *  mi_tpi_exdata_req()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_tpi_exdata_req(VAR trailer_mp: mblk_t; flags: OTInt32; ptype: LONGINT): mblk_tPtr; C;

{
 *  mi_tpi_info_req()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_tpi_info_req: mblk_tPtr; C;

{
 *  mi_tpi_ok_ack_alloc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_tpi_ok_ack_alloc(VAR mp: mblk_t): mblk_tPtr; C;

{
 *  mi_tpi_ordrel_ind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_tpi_ordrel_ind: mblk_tPtr; C;

{
 *  mi_tpi_ordrel_req()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_tpi_ordrel_req: mblk_tPtr; C;

{
 *  mi_tpi_uderror_ind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_tpi_uderror_ind(dest: CStringPtr; dest_length: OTByteCount; opt: CStringPtr; opt_length: OTByteCount; error: OTInt32): mblk_tPtr; C;

{
 *  mi_tpi_unitdata_ind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_tpi_unitdata_ind(VAR trailer_mp: mblk_t; src: CStringPtr; src_length: OTByteCount; opt: CStringPtr; opt_length: OTByteCount): mblk_tPtr; C;

{
 *  mi_tpi_unitdata_req()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_tpi_unitdata_req(VAR trailer_mp: mblk_t; dst: CStringPtr; dst_length: OTByteCount; opt: CStringPtr; opt_length: OTByteCount): mblk_tPtr; C;

{
 *  mi_reuse_proto()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_reuse_proto(VAR toReuse: mblk_t; sizeDesired: OTByteCount; keepOnError: OTBooleanParam): mblk_tPtr; C;

{
 *  mi_reallocb()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_reallocb(VAR old_mp: mblk_t; new_size: OTByteCount): mblk_tPtr; C;

{
 *  mi_set_sth_hiwat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_set_sth_hiwat(VAR q: queue_t; size: OTByteCount): BOOLEAN; C;

{
 *  mi_set_sth_lowat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_set_sth_lowat(VAR q: queue_t; size: OTByteCount): BOOLEAN; C;

{
 *  mi_set_sth_maxblk()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_set_sth_maxblk(VAR q: queue_t; size: OTByteCount): BOOLEAN; C;

{
 *  mi_set_sth_wroff()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_set_sth_wroff(VAR q: queue_t; size: OTByteCount): BOOLEAN; C;

{
 *  mi_offset_param()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_offset_param(VAR mp: mblk_t; offset: LONGINT; len: LONGINT): Ptr; C;

{
 *  mi_offset_paramc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_offset_paramc(VAR mp: mblk_t; offset: LONGINT; len: LONGINT): Ptr; C;

{
 *  mi_open_detached()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_open_detached(VAR mi_opp_orig: CStringPtr; size: OTByteCount; VAR devp: dev_t): CStringPtr; C;

{
 *  mi_open_comm()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_open_comm(VAR mi_opp_orig: CStringPtr; size: OTByteCount; VAR q: queue_t; VAR dev: dev_t; flag: OTInt32; sflag: OTInt32; VAR credp: cred_t): OTInt32; C;

{
 *  mi_close_comm()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_close_comm(VAR mi_opp_orig: CStringPtr; VAR q: queue_t): OTInt32; C;

{
 *  mi_bufcall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE mi_bufcall(VAR q: queue_t; size: OTByteCount; pri: OTInt32); C;

{
 *  mi_detach()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE mi_detach(VAR q: queue_t; ptr: CStringPtr); C;

{
 *  mi_close_detached()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE mi_close_detached(VAR mi_opp_orig: CStringPtr; ptr: CStringPtr); C;

{
 *  mi_next_ptr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_next_ptr(ptr: CStringPtr): CStringPtr; C;

{
 *  mi_copyin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE mi_copyin(VAR q: queue_t; VAR mp: mblk_t; uaddr: CStringPtr; len: OTByteCount); C;

{
 *  mi_copyout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE mi_copyout(VAR q: queue_t; VAR mp: mblk_t); C;

{
 *  mi_copyout_alloc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_copyout_alloc(VAR q: queue_t; VAR mp: mblk_t; uaddr: CStringPtr; len: OTByteCount): mblk_tPtr; C;

{
 *  mi_copy_done()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE mi_copy_done(VAR q: queue_t; VAR mp: mblk_t; err: OTInt32); C;

{
 *  mi_copy_set_rval()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE mi_copy_set_rval(VAR mp: mblk_t; rval: OTInt32); C;

{
 *  mi_copy_state()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION mi_copy_state(VAR q: queue_t; VAR mp: mblk_t; VAR mpp: UNIV Ptr): OTInt32; C;

{  ***** PCI-Specific Stuff }

{  This is the cookie that is passed to your STREAM Module. }

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	OTPCIInfoPtr = ^OTPCIInfo;
	OTPCIInfo = RECORD
		fTheID:					RegEntryID;
		fConfigurationInfo:		Ptr;
		fConfigurationLength:	ByteCount;
	END;

	{  Driver Description }
	{
	   All PCI card drivers should have the following bits set in their
	   install_info structure:
	   
	   o kOTModIsDriver.
	   
	   They should NEVER have the kOTModPushAlways or the kOTModIsModule
	   flags set.
	   The kOTModIsLowerMux bits should be set if the driver is a lower
	   multiplexor, although Open Transport does nothing with the information
	   today.
	   The kOTModUpperIsDLPI bit should be set if the driver uses the DLPI message
	   specification.  The kOTModUpperIsTPI bit should be set if the driver uses
	   the TPI message specification.
	}

	{
	   Macro to put together the driverServices.service[x].serviceType field:
	   xxxxxddd dddddddd ffffffff xxxxxxTD
	   where "d" is the device type for Open Transport,
	   the lower two bits are whether the driver is TPI or DLPI,
	   and the "f" bits are the framing option flags.
	   and all other bits should be 0
	}

	{
	   Typedef for the ValidateHardware function.  This function will be
	   called only once, at system boot time, before installing your driver
	   into the Open Transport module registry.
	   The param pointer will is a OTPCIInfo pointer - don't be changing the
	   values there!
	}

{$IFC TYPED_FUNCTION_POINTERS}
	ValidateHardwareProcPtr = FUNCTION(VAR param: OTPCIInfo): OTResult; C;
{$ELSEC}
	ValidateHardwareProcPtr = ProcPtr;
{$ENDC}

	{
	   Your driver can return this value if it loaded correctly
	   but wants to stay resident, presumably because it's hooked
	   itself irrevokably into some other system service.
	}

CONST
	kOTPCINoErrorStayLoaded		= 1;

	{
	   Some descriptors we use - these should eventually show up
	   in system header files somewhere.
	}

	{
	   Maximum # of services support by Open Transport.  If your module
	   exports more than this # of services, Open Transport will not be
	   able to use the module.
	}


	kMaxServices				= 20;



{$ifc not undefined __MWERKS and TARGET_CPU_68K}
    {$pragmac d0_pointers reset}
{$endc}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OpenTransportKernelIncludes}

{$ENDC} {__OPENTRANSPORTKERNEL__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
