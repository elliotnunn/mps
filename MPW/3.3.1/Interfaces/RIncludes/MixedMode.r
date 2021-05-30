/*
	File:		MixedMode.r

	Contains:	Rez templates for creating resource based Mixed Mode stuff

	Written by:	Bruce Jones

	Copyright:	© 1993-1994 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

		 <9>	  2/9/94	M		<BKJ> (#1140370) sdes doesn't work with old ROMS.
		 <8>	11/19/93	M		<BKJ> (#1126144) Remove private ISA types
		 <7>	 9/15/93	EPT		<EPT, jrc> (#1112486) Added ALIGN directives to the rez
									templates for fat and safe fat resources.
		 <6>	 9/14/93	EPT		<EPT, jrc> (#1112486) Added rez template for safe fat resources.
		 <5>	 7/23/93	BKJ		Add support for fat routine descriptors. (BRC #1088593)
		 <4>	 5/10/93	jrc		The RoutineFlags bits are in the wrong order.  Fix them.
		 <3>	  5/5/93	BKJ		Update to latest version of Routine Descriptors.
		 <2>	  3/8/93	BKJ		Fix bug in definition of rdes.  Revise example.
		 <1>	 2/26/93	BKJ		first checked in
*/



#define	GoMixedModeTrapType	unsigned hex integer
#define	VersionType byte
#define	SelectorsAreIndexableType boolean
#define	Reserved1Type fill long
#define	Reserved2Type fill byte
#define	SelectorInfoType hex byte
#define	RoutineCountType integer

#define ProcInfoType binary longint
#define	Reserved3Type fill byte
#define	ISAType byte
#define ProcDescriptorIsRelativeType boolean
#define	FragmentNeedsPreparingType boolean
#define	UseNativeISAType boolean
#define	DontPassSelectorType boolean
#define	RoutineIsDispatchedDefaultType boolean
#define	ProcDescriptorType longint
#define	Reserved4Type fill long
#define	SelectorType longint

#define	_MixedModeMagic 0xAAFE
#define	kRoutineDescriptorVersion 7

#define	kM68kISA 0
#define	kPowerPCISA 1

/*
	Use the 'rdes' template to define a “native resource” which 
	starts with a routine descriptor. Such resources contain 
	just PowerPC code. 
	
	Note that such resources can only be executed on PowerPC
	machines. Executing them on a 68K machine will result 
	in a crash.

	To create a “native resource”, use something like the following:
	
#include "MixedMode.r"

type 'BDef' as 'rdes';

resource 'BDef' (1) {
	$1,										// ProcInfo
	$$Resource("BDef.rsrc", 'pCod', 128)	// Specify name, type, and ID of resource
											//   containing a pef container
};

*/

type 'rdes' { 
Top:
	/* Routine Descriptor */
	GoMixedModeTrapType 			= _MixedModeMagic;
	VersionType						= kRoutineDescriptorVersion;
	fill bit [7];
	SelectorsAreIndexableType		= FALSE;
	Reserved1Type;
	Reserved2Type;
	SelectorInfoType				= 0;
	RoutineCountType				= 0;

	/* Routine Record */
	ProcInfoType;
	Reserved3Type;
	ISAType							= kPowerPCISA;
	fill bit [11];
	RoutineIsDispatchedDefaultType 	= FALSE;
	DontPassSelectorType			= FALSE;
	UseNativeISAType				= TRUE;
	FragmentNeedsPreparingType		= TRUE;
	ProcDescriptorIsRelativeType	= TRUE;
	ProcDescriptorType				= (BeginningOfPowerPCCode-Top) / 8;
	Reserved4Type;
	SelectorType					= 0;
	Align LONG;

BeginningOfPowerPCCode:
	hex string;						// The PEF container starts here
};


/*
	Use the 'fdes' template to define a “fat resource” which 
	starts with a routine descriptor and contains both 68K and 
	PowerPC code. 
	
	Note that such resources can only be executed on a machine
	with MixedMode installed. To create “safe fat resources”
	which will run on all machines, use the 'sdes' template
	defined below.

	To create a “fat resource”, use something like the following:
	
#include "MixedMode.r"

type 'BDef' as 'fdes';

resource 'BDef' (1) {
	$1,										// 68K ProcInfo
	$1,										// PowerPC ProcInfo
	$$Resource("BDef.rsrc", 'oCod', 128),	// Specify name, type, and ID of resource
											//   containing 68k code
	$$Resource("BDef.rsrc", 'pCod', 128)	// Specify name, type, and ID of resource
											//   containing a pef container
};

*/

/*  Fat Routines  */
type 'fdes' { 
Top:
	/* Routine Descriptor */
	GoMixedModeTrapType 			= _MixedModeMagic;
	VersionType						= kRoutineDescriptorVersion;
	fill bit [7];
	SelectorsAreIndexableType		= FALSE;
	Reserved1Type;
	Reserved2Type;
	SelectorInfoType				= 0;
	RoutineCountType				= 1;

	/* 68k Routine Record */
	ProcInfoType;
	Reserved3Type;
	ISAType							= kM68kISA;
	fill bit [11];
	RoutineIsDispatchedDefaultType 	= FALSE;
	DontPassSelectorType			= FALSE;
	UseNativeISAType				= TRUE;
	FragmentNeedsPreparingType		= FALSE;
	ProcDescriptorIsRelativeType	= TRUE;
	ProcDescriptorType				= (BeginningOf68KCode-Top) / 8;
	Reserved4Type;
	SelectorType					= 0;

	/* PowerPC Routine Record 1 */
	ProcInfoType;
	Reserved3Type;
	ISAType							= kPowerPCISA;
	fill bit [11];
	RoutineIsDispatchedDefaultType 	= FALSE;
	DontPassSelectorType			= FALSE;
	UseNativeISAType				= TRUE;
	FragmentNeedsPreparingType		= TRUE;
	ProcDescriptorIsRelativeType	= TRUE;
	ProcDescriptorType				= (BeginningOfPowerPCCode-Top) / 8;
	Reserved4Type;
	SelectorType					= 0;
	Align LONG;

BeginningOf68kCode:
	hex string;				// The code starts here
	
	Align LONG;

BeginningOfPowerPCCode:
	hex string;				// The PEF container starts here
};


/*
	Use the 'sdes' template to define a “safe fat resource” which 
	contains both 68K and PowerPC code. A safe fat resource starts
	with 68K code which is executed the first time the resource
	is called. This code determines if MixedMode is present. If
	so, a routine descriptor is moved to the beginning of the
	resource. If not, a branch instruction to the 68K portion
	of the code is placed at the beginning of the resource. 
	Therefore, the first time the resource is executed, there 
	is some overhead incurred. However, subsequent calls 
	will be fast.
	
	Note: This template cannot currently be used for resources
	containing code with register-based calling conventions
	because the 68K code at the beginning of the resource
	uses D0, A0, and A1.
	
	To create a “safe fat resource”, use something like the following:
	
#include "MixedMode.r"

type 'BDef' as 'sdes';

resource 'BDef' (1) {
	$1,										// 68K ProcInfo
	$1,										// PowerPC ProcInfo
	$$Resource("BDef.rsrc", 'oCod', 128),	// Specify name, type, and ID of resource
											//   containing 68k code
	$$Resource("BDef.rsrc", 'pCod', 128)	// Specify name, type, and ID of resource
											//   containing a pef container
};

*/

/*  Safe Fat Resources  */
type 'sdes' { 
Top:
	hex string	= 
		$"4E56 FFF0"      // SafeFatRsrc	LINK		A6, #-sysEnv1Size		; Allocate a sysEnvRec
		$"41EE FFF0"      //				LEA			-sysEnv1Size(A6), A0
		$"7001"           //				MOVEQ		#1, D0					; On 6.X, Gestalt not be implemented...
		$"A090"           //				_SysEnvirons	
		$"4A40"           //				TST.W		D0
		$"6640"           //				BNE.S		Install68K_60			; if call fails, load up the 68K without FlushCache
		$"0C68 0700 0004" //				CMPI		#$0700,systemVersion(A0)
		$"6D38"           //				BLT.S		Install68K_60			; if pre- 7.0, assume no cache		
		$"303C A89F"      //				MOVE.W		#$A89F, D0				; We have larger trap tables.  Is MixedMode installed?
		$"A746"           //				_GetToolBoxTrapAddress				; Leave _Unimplemented on the top of the stack...
		$"2F08"           //				MOVE.L		A0, -(SP)				; Unlk will clean this up
		$"303C AAFE"      //				MOVE.W		#$AAFE, D0 
		$"A746"           //				_GetToolBoxTrapAddress
		$"B1D7"           //				CMPA.L		(SP), A0				
		$"663E"           //				BNE.S		InstallPPCCode
		$"41FA FFD4"      // Install68K_70	LEA			SafeFatRsrc, A0
		$"30FC 6000"      //				MOVE.W		#$6000, (A0)+			; Generate a BRA instruction
		$"43FA 0044"      //				LEA			FatRD, A1
		$"2029 0014"      //				MOVE.L		20(A1), D0				; Get 68K code offset
		$"5580"           //				SUBQ.L		#2, D0
		$"3080"           //				MOVE.W		D0, (A0)				; Fill in the second word of the BRA
		$"303C A198"      //				MOVE.W		#$A198, D0 				; Is _HWPriv implemented?
		$"A346"           //				_GetOSTrapAddress
		$"B1D7"           //				CMPA.L		(SP), A0
		$"4E5E"           //				UNLK		A6
		$"67B6"           //				BEQ.S		SafeFatRsrc
		$"7001 A198"      //				_FlushInstructionCache
		$"60B0"           //				BRA.S		SafeFatRsrc
		$"4E5E"           // Install68K_60	UNLK		A6						; Old machine, FlushCache not supported
		$"41FA FFAC"      //				LEA			SafeFatRsrc, A0						
		$"30FC 6000"      //				MOVE.W		#$6000, (A0)+			; Generate a BRA instruction
		$"43FA 001C"      //				LEA			FatRD, A1
		$"2029 0014"      //				MOVE.L		20(A1), D0				; Get 68K code offset
		$"5580"           //				SUBQ.L		#2, D0
		$"3080"           //				MOVE.W		D0, (A0)				; Fill in the second word of the BRA
		$"6098"           //				BRA.S		SafeFatRsrc
		$"4E5E"           // InstallPPCCode	UNLK		A6
		$"43FA FF94"      //				LEA			SafeFatRsrc, A1
		$"41FA 0008"      //				LEA			FatRD, A0
		$"7034"           //				MOVE.L		#52, D0
		$"A02E"           //				_BlockMove							; Move R.D. to top of rsrc
		$"6088";          //				BRA.S		SafeFatRsrc
                          // FatRD	

	/* Routine Descriptor */
	GoMixedModeTrapType 			= _MixedModeMagic;
	VersionType						= kRoutineDescriptorVersion;
	fill bit [7];
	SelectorsAreIndexableType		= FALSE;
	Reserved1Type;
	Reserved2Type;
	SelectorInfoType				= 0;
	RoutineCountType				= 1;

	/* Routine Record */
	ProcInfoType;
	Reserved3Type;
	ISAType							= kM68kISA;
	fill bit [11];
	RoutineIsDispatchedDefaultType 	= FALSE;
	DontPassSelectorType			= FALSE;
	UseNativeISAType				= TRUE;
	FragmentNeedsPreparingType		= FALSE;
	ProcDescriptorIsRelativeType	= TRUE;
	ProcDescriptorType				= (BeginningOf68KCode-Top) / 8;
	Reserved4Type;
	SelectorType					= 0;

	/* PowerPC Routine Record 1 */
	ProcInfoType;
	Reserved3Type;
	ISAType	= kPowerPCISA;
	fill bit [11];
	RoutineIsDispatchedDefaultType 	= FALSE;
	DontPassSelectorType 			= FALSE;
	UseNativeISAType 				= TRUE;
	FragmentNeedsPreparingType		= TRUE;
	ProcDescriptorIsRelativeType	= TRUE;
	ProcDescriptorType 				= (BeginningOfPowerPCCode-Top) / 8;
	Reserved4Type;
	SelectorType 					= 0;
	Align LONG;

BeginningOf68KCode:
	hex string;		// The 68k code starts here

	Align LONG;

BeginningOfPowerPCCode:
	hex string;		// The PEF container starts here
};

