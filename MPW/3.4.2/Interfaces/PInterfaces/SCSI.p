{
 	File:		SCSI.p
 
 	Contains:	SCSI Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.5
 
 	Copyright:	© 1984-1997 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT SCSI;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SCSI__}
{$SETC __SCSI__ := 1}

{$I+}
{$SETC SCSIIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	scInc						= 1;
	scNoInc						= 2;
	scAdd						= 3;
	scMove						= 4;
	scLoop						= 5;
	scNop						= 6;
	scStop						= 7;
	scComp						= 8;

{ SCSI Manager errors }
	scCommErr					= 2;							{ communications error, operation timeout }
	scArbNBErr					= 3;							{ arbitration timeout waiting for not BSY }
	scBadParmsErr				= 4;							{ bad parameter or TIB opcode }
	scPhaseErr					= 5;							{ SCSI bus not in correct phase for attempted operation }
	scCompareErr				= 6;							{ data compare error }
	scMgrBusyErr				= 7;							{ SCSI Manager busy  }
	scSequenceErr				= 8;							{ attempted operation is out of sequence }
	scBusTOErr					= 9;							{ CPU bus timeout }
	scComplPhaseErr				= 10;							{ SCSI bus wasn't in Status phase }

{ Signatures }
	sbSIGWord					= $4552;						{ signature word for Block 0 ('ER') }
	sbMac						= 1;							{ system type for Mac }
	pMapSIG						= $504D;						{ partition map signature ('PM') }
	pdSigWord					= $5453;

	oldPMSigWord				= pdSigWord;
	newPMSigWord				= pMapSIG;

{ Driver Descriptor Map }

TYPE
	Block0 = PACKED RECORD
		sbSig:					INTEGER;								{ unique value for SCSI block 0 }
		sbBlkSize:				INTEGER;								{ block size of device }
		sbBlkCount:				LONGINT;								{ number of blocks on device }
		sbDevType:				INTEGER;								{ device type }
		sbDevId:				INTEGER;								{ device id }
		sbData:					LONGINT;								{ not used }
		sbDrvrCount:			INTEGER;								{ driver descriptor count }
		ddBlock:				LONGINT;								{ 1st driver's starting block }
		ddSize:					INTEGER;								{ size of 1st driver (512-byte blks) }
		ddType:					INTEGER;								{ system type (1 for Mac+) }
		ddPad:					ARRAY [0..242] OF INTEGER;				{ ARRAY[0..242] OF INTEGER; not used }
	END;

{Driver descriptor}
	DDMap = RECORD
		ddBlock:				LONGINT;								{ 1st driver's starting block }
		ddSize:					INTEGER;								{ size of 1st driver (512-byte blks) }
		ddType:					INTEGER;								{ system type (1 for Mac+) }
	END;

{ Partition Map Entry }
	Partition = PACKED RECORD
		pmSig:					INTEGER;								{ unique value for map entry blk }
		pmSigPad:				INTEGER;								{ currently unused }
		pmMapBlkCnt:			LONGINT;								{ # of blks in partition map }
		pmPyPartStart:			LONGINT;								{ physical start blk of partition }
		pmPartBlkCnt:			LONGINT;								{ # of blks in this partition }
		pmPartName:				PACKED ARRAY [0..31] OF CHAR;			{ ASCII partition name }
		pmParType:				PACKED ARRAY [0..31] OF CHAR;			{ ASCII partition type }
		pmLgDataStart:			LONGINT;								{ log. # of partition's 1st data blk }
		pmDataCnt:				LONGINT;								{ # of blks in partition's data area }
		pmPartStatus:			LONGINT;								{ bit field for partition status }
		pmLgBootStart:			LONGINT;								{ log. blk of partition's boot code }
		pmBootSize:				LONGINT;								{ number of bytes in boot code }
		pmBootAddr:				LONGINT;								{ memory load address of boot code }
		pmBootAddr2:			LONGINT;								{ currently unused }
		pmBootEntry:			LONGINT;								{ entry point of boot code }
		pmBootEntry2:			LONGINT;								{ currently unused }
		pmBootCksum:			LONGINT;								{ checksum of boot code }
		pmProcessor:			PACKED ARRAY [0..15] OF CHAR;			{ ASCII for the processor type }
		pmPad:					ARRAY [0..187] OF INTEGER;				{ ARRAY[0..187] OF INTEGER; not used }
	END;

{ TIB instruction }
	SCSIInstr = RECORD
		scOpcode:				INTEGER;
		scParam1:				LONGINT;
		scParam2:				LONGINT;
	END;


FUNCTION SCSIReset: OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $4267, $A815;
	{$ENDC}
FUNCTION SCSIGet: OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0001, $A815;
	{$ENDC}
FUNCTION SCSISelect(targetID: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0002, $A815;
	{$ENDC}
FUNCTION SCSICmd(buffer: Ptr; count: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0003, $A815;
	{$ENDC}
FUNCTION SCSIRead(tibPtr: Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0005, $A815;
	{$ENDC}
FUNCTION SCSIRBlind(tibPtr: Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0008, $A815;
	{$ENDC}
FUNCTION SCSIWrite(tibPtr: Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0006, $A815;
	{$ENDC}
FUNCTION SCSIWBlind(tibPtr: Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0009, $A815;
	{$ENDC}
FUNCTION SCSIComplete(VAR stat: INTEGER; VAR message: INTEGER; wait: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0004, $A815;
	{$ENDC}
FUNCTION SCSIStat: INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $000A, $A815;
	{$ENDC}
FUNCTION SCSISelAtn(targetID: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $000B, $A815;
	{$ENDC}
FUNCTION SCSIMsgIn(VAR message: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $000C, $A815;
	{$ENDC}
FUNCTION SCSIMsgOut(message: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $000D, $A815;
	{$ENDC}
{——————————————————————— New SCSI Manager Interface ———————————————————————}

CONST
	scsiVERSION					= 43;

{ SCSI Manager function codes }
	SCSINop						= $00;							{ Execute nothing 										}
	SCSIExecIO					= $01;							{ Execute the specified IO 							}
	SCSIBusInquiry				= $03;							{ Get parameters for entire path of HBAs 				}
	SCSIReleaseQ				= $04;							{ Release the frozen SIM queue for particular LUN 		}
	SCSIAbortCommand			= $10;							{ Abort the selected Control Block  					}
	SCSIResetBus				= $11;							{ Reset the SCSI bus  									}
	SCSIResetDevice				= $12;							{ Reset the SCSI device  								}
	SCSITerminateIO				= $13;							{ Terminate any pending IO  							}
	SCSIGetVirtualIDInfo		= $80;							{ Find out which bus old ID is on 						}
	SCSILoadDriver				= $82;							{ Load a driver for a device ident 					}
	SCSIOldCall					= $84;							{ XPT->SIM private call for old-API 					}
	SCSICreateRefNumXref		= $85;							{ Register a DeviceIdent to drvr RefNum xref 			}
	SCSILookupRefNumXref		= $86;							{ Get DeviceIdent to drvr RefNum xref 					}
	SCSIRemoveRefNumXref		= $87;							{ Remove a DeviceIdent to drvr RefNum xref 			}
	SCSIRegisterWithNewXPT		= $88;							{ XPT has changed - SIM needs to re-register itself 	}
	vendorUnique				= $C0;							{ 0xC0 thru 0xFF }

{ SCSI Callback Procedure Prototypes }
{ SCSIInterruptPollProcPtr is obsolete (use SCSIInterruptProcPtr) but still here for compatibility }
TYPE
	SCSICallbackProcPtr = ProcPtr;  { PROCEDURE SCSICallback(scsiPB: UNIV Ptr); }
	AENCallbackProcPtr = ProcPtr;  { PROCEDURE AENCallback; }
	SIMInitProcPtr = ProcPtr;  { FUNCTION SIMInit(SIMinfoPtr: Ptr): OSErr; }
	SIMActionProcPtr = ProcPtr;  { PROCEDURE SIMAction(scsiPB: UNIV Ptr; SIMGlobals: Ptr); }
	SCSIProcPtr = ProcPtr;  { PROCEDURE SCSI; }
	SCSIMakeCallbackProcPtr = ProcPtr;  { PROCEDURE SCSIMakeCallback(scsiPB: UNIV Ptr); }
	SCSIInterruptPollProcPtr = ProcPtr;  { FUNCTION SCSIInterruptPoll(SIMGlobals: Ptr): LONGINT; }
	SCSIInterruptProcPtr = ProcPtr;  { FUNCTION SCSIInterrupt(SIMGlobals: Ptr): LONGINT; }
	SCSICallbackUPP = UniversalProcPtr;
	AENCallbackUPP = UniversalProcPtr;
	SIMInitUPP = UniversalProcPtr;
	SIMActionUPP = UniversalProcPtr;
	SCSIUPP = UniversalProcPtr;
	SCSIMakeCallbackUPP = UniversalProcPtr;
	SCSIInterruptPollUPP = UniversalProcPtr;
	SCSIInterruptUPP = UniversalProcPtr;

CONST
	uppSCSICallbackProcInfo = $000000C0; { PROCEDURE (4 byte param); }
	uppAENCallbackProcInfo = $00000001; { PROCEDURE ; }
	uppSIMInitProcInfo = $000000E1; { FUNCTION (4 byte param): 2 byte result; }
	uppSIMActionProcInfo = $000003C1; { PROCEDURE (4 byte param, 4 byte param); }
	uppSCSIProcInfo = $00000001; { PROCEDURE ; }
	uppSCSIMakeCallbackProcInfo = $000000C1; { PROCEDURE (4 byte param); }
	uppSCSIInterruptPollProcInfo = $000000F1; { FUNCTION (4 byte param): 4 byte result; }
	uppSCSIInterruptProcInfo = $000000F1; { FUNCTION (4 byte param): 4 byte result; }

FUNCTION NewSCSICallbackProc(userRoutine: SCSICallbackProcPtr): SCSICallbackUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewAENCallbackProc(userRoutine: AENCallbackProcPtr): AENCallbackUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSIMInitProc(userRoutine: SIMInitProcPtr): SIMInitUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSIMActionProc(userRoutine: SIMActionProcPtr): SIMActionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSCSIProc(userRoutine: SCSIProcPtr): SCSIUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSCSIMakeCallbackProc(userRoutine: SCSIMakeCallbackProcPtr): SCSIMakeCallbackUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSCSIInterruptPollProc(userRoutine: SCSIInterruptPollProcPtr): SCSIInterruptPollUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSCSIInterruptProc(userRoutine: SCSIInterruptProcPtr): SCSIInterruptUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallSCSICallbackProc(scsiPB: UNIV Ptr; userRoutine: SCSICallbackUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallAENCallbackProc(userRoutine: AENCallbackUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallSIMInitProc(SIMinfoPtr: Ptr; userRoutine: SIMInitUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallSIMActionProc(scsiPB: UNIV Ptr; SIMGlobals: Ptr; userRoutine: SIMActionUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallSCSIProc(userRoutine: SCSIUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallSCSIMakeCallbackProc(scsiPB: UNIV Ptr; userRoutine: SCSIMakeCallbackUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallSCSIInterruptPollProc(SIMGlobals: Ptr; userRoutine: SCSIInterruptPollUPP): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallSCSIInterruptProc(SIMGlobals: Ptr; userRoutine: SCSIInterruptUPP): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

CONST
	handshakeDataLength			= 8;							{ Handshake data length }
	maxCDBLength				= 16;							{ Space for the CDB bytes/pointer }
	vendorIDLength				= 16;							{ ASCII string len for Vendor ID  }

{ Define DeviceIdent structure }

TYPE
	DeviceIdent = PACKED RECORD
		diReserved:				UInt8;									{ reserved 				}
		bus:					UInt8;									{ SCSI - Bus Number		}
		targetID:				UInt8;									{ SCSI - Target SCSI ID	}
		LUN:					UInt8;									{ SCSI - LUN  				}
	END;

{ Command Descriptor Block structure }
	CDB = RECORD
		CASE INTEGER OF
		0: (
			cdbPtr:						^UInt8;								{ pointer to the CDB, or }
		   );
		1: (
			cdbBytes:					PACKED ARRAY [0..maxCDBLength-1] OF SInt8; (* UInt8 *) { the actual CDB to send }
		   );
	END;

	CDBPtr = ^CDB;

{ Scatter/gather list element }
	SGRecord = RECORD
		SGAddr:					Ptr;
		SGCount:				UInt32;
	END;

{ SCSI Phases (used by SIMs to support the Original SCSI Manager }

CONST
	kDataOutPhase				= 0;							{ Encoded MSG, C/D, I/O bits }
	kDataInPhase				= 1;
	kCommandPhase				= 2;
	kStatusPhase				= 3;
	kPhaseIllegal0				= 4;
	kPhaseIllegal1				= 5;
	kMessageOutPhase			= 6;
	kMessageInPhase				= 7;
	kBusFreePhase				= 8;							{ Additional Phases }
	kArbitratePhase				= 9;
	kSelectPhase				= 10;
	kMessageInPhaseNACK			= 11;							{ Message In Phase with ACK hanging on the bus }


TYPE
	SCSIHdr = RECORD
		qLink:					^SCSIHdr;
		scsiReserved1:			INTEGER;
		scsiPBLength:			UInt16;
		scsiFunctionCode:		SInt8; (* UInt8 *)
		scsiReserved2:			SInt8; (* UInt8 *)
		scsiResult:				OSErr;
		scsiDevice:				DeviceIdent;
		scsiCompletion:			SCSICallbackUPP;
		scsiFlags:				UInt32;
		scsiDriverStorage:		^UInt8;
		scsiXPTprivate:			Ptr;
		scsiReserved3:			LONGINT;
	END;

	SCSI_PB = RECORD
		qLink:					^SCSIHdr;
		scsiReserved1:			INTEGER;
		scsiPBLength:			UInt16;
		scsiFunctionCode:		SInt8; (* UInt8 *)
		scsiReserved2:			SInt8; (* UInt8 *)
		scsiResult:				OSErr;
		scsiDevice:				DeviceIdent;
		scsiCompletion:			SCSICallbackUPP;
		scsiFlags:				UInt32;
		scsiDriverStorage:		^UInt8;
		scsiXPTprivate:			Ptr;
		scsiReserved3:			LONGINT;
	END;

	SCSI_IO = RECORD
		qLink:					^SCSIHdr;
		scsiReserved1:			INTEGER;
		scsiPBLength:			UInt16;
		scsiFunctionCode:		SInt8; (* UInt8 *)
		scsiReserved2:			SInt8; (* UInt8 *)
		scsiResult:				OSErr;
		scsiDevice:				DeviceIdent;
		scsiCompletion:			SCSICallbackUPP;
		scsiFlags:				UInt32;
		scsiDriverStorage:		^UInt8;
		scsiXPTprivate:			Ptr;
		scsiReserved3:			LONGINT;
		scsiResultFlags:		UInt16;
		scsiReserved3pt5:		UInt16;
		scsiDataPtr:			^UInt8;
		scsiDataLength:			UInt32;
		scsiSensePtr:			^UInt8;
		scsiSenseLength:		SInt8; (* UInt8 *)
		scsiCDBLength:			SInt8; (* UInt8 *)
		scsiSGListCount:		UInt16;
		scsiReserved4:			UInt32;
		scsiSCSIstatus:			SInt8; (* UInt8 *)
		scsiSenseResidual:		SInt8;
		scsiReserved5:			UInt16;
		scsiDataResidual:		LONGINT;
		scsiCDB:				CDB;
		scsiTimeout:			LONGINT;
		scsiReserved5pt5:		^UInt8;
		scsiReserved5pt6:		UInt16;
		scsiIOFlags:			UInt16;
		scsiTagAction:			SInt8; (* UInt8 *)
		scsiReserved6:			SInt8; (* UInt8 *)
		scsiReserved7:			UInt16;
		scsiSelectTimeout:		UInt16;
		scsiDataType:			SInt8; (* UInt8 *)
		scsiTransferType:		SInt8; (* UInt8 *)
		scsiReserved8:			UInt32;
		scsiReserved9:			UInt32;
		scsiHandshake:			ARRAY [0..handshakeDataLength-1] OF UInt16;
		scsiReserved10:			UInt32;
		scsiReserved11:			UInt32;
		scsiCommandLink:		^SCSI_IO;
		scsiSIMpublics:			ARRAY [0..7] OF SInt8; (* UInt8 *)
		scsiAppleReserved6:		ARRAY [0..7] OF SInt8; (* UInt8 *)
		scsiCurrentPhase:		UInt16;
		scsiSelector:			INTEGER;
		scsiOldCallResult:		OSErr;
		scsiSCSImessage:		SInt8; (* UInt8 *)
		XPTprivateFlags:		SInt8; (* UInt8 *)
		XPTextras:				ARRAY [0..11] OF SInt8; (* UInt8 *)
	END;

	SCSIExecIOPB = SCSI_IO;

{ Bus inquiry PB }
	SCSIBusInquiryPB = RECORD
		qLink:					^SCSIHdr;
		scsiReserved1:			INTEGER;
		scsiPBLength:			UInt16;
		scsiFunctionCode:		SInt8; (* UInt8 *)
		scsiReserved2:			SInt8; (* UInt8 *)
		scsiResult:				OSErr;
		scsiDevice:				DeviceIdent;
		scsiCompletion:			SCSICallbackUPP;
		scsiFlags:				UInt32;
		scsiDriverStorage:		^UInt8;
		scsiXPTprivate:			Ptr;
		scsiReserved3:			LONGINT;
		scsiEngineCount:		UInt16;									{ <- Number of engines on HBA 						}
		scsiMaxTransferType:	UInt16;									{ <- Number of transfer types for this HBA			}
		scsiDataTypes:			UInt32;									{ <- which data types are supported by this SIM 	}
		scsiIOpbSize:			UInt16;									{ <- Size of SCSI_IO PB for this SIM/HBA 			}
		scsiMaxIOpbSize:		UInt16;									{ <- Size of max SCSI_IO PB for all SIM/HBAs 		}
		scsiFeatureFlags:		UInt32;									{ <- Supported features flags field 				}
		scsiVersionNumber:		SInt8; (* UInt8 *)						{ <- Version number for the SIM/HBA 				}
		scsiHBAInquiry:			SInt8; (* UInt8 *)						{ <- Mimic of INQ byte 7 for the HBA 				}
		scsiTargetModeFlags:	SInt8; (* UInt8 *)						{ <- Flags for target mode support 				}
		scsiScanFlags:			SInt8; (* UInt8 *)						{ <- Scan related feature flags 					}
		scsiSIMPrivatesPtr:		UInt32;									{ <- Ptr to SIM private data area 					}
		scsiSIMPrivatesSize:	UInt32;									{ <- Size of SIM private data area 				}
		scsiAsyncFlags:			UInt32;									{ <- Event cap. for Async Callback 				}
		scsiHiBusID:			SInt8; (* UInt8 *)						{ <- Highest path ID in the subsystem  			}
		scsiInitiatorID:		SInt8; (* UInt8 *)						{ <- ID of the HBA on the SCSI bus 				}
		scsiBIReserved0:		UInt16;									{													}
		scsiBIReserved1:		UInt32;									{ <-  												}
		scsiFlagsSupported:		UInt32;									{ <- which scsiFlags are supported 				}
		scsiIOFlagsSupported:	UInt16;									{ <- which scsiIOFlags are supported 				}
		scsiWeirdStuff:			UInt16;									{ <- 												}
		scsiMaxTarget:			UInt16;									{ <- maximum Target number supported 				}
		scsiMaxLUN:				UInt16;									{ <- maximum Logical Unit number supported 		}
		scsiSIMVendor:			PACKED ARRAY [0..vendorIDLength-1] OF CHAR; { <- Vendor ID of SIM (or XPT if bus<FF) 		}
		scsiHBAVendor:			PACKED ARRAY [0..vendorIDLength-1] OF CHAR; { <- Vendor ID of the HBA 						}
		scsiControllerFamily:	PACKED ARRAY [0..vendorIDLength-1] OF CHAR; { <- Family of SCSI Controller 				}
		scsiControllerType:		PACKED ARRAY [0..vendorIDLength-1] OF CHAR; { <- Specific Model of SCSI Controller used 	}
		scsiXPTversion:			PACKED ARRAY [0..3] OF CHAR;			{ <- version number of XPT 						}
		scsiSIMversion:			PACKED ARRAY [0..3] OF CHAR;			{ <- version number of SIM 						}
		scsiHBAversion:			PACKED ARRAY [0..3] OF CHAR;			{ <- version number of HBA 						}
		scsiHBAslotType:		SInt8; (* UInt8 *)						{ <- type of "slot" that this HBA is in			}
		scsiHBAslotNumber:		SInt8; (* UInt8 *)						{ <- slot number of this HBA 						}
		scsiSIMsRsrcID:			UInt16;									{ <- resource ID of this SIM 						}
		scsiBIReserved3:		UInt16;									{ <- 												}
		scsiAdditionalLength:	UInt16;									{ <- additional BusInquiry PB len					}
	END;

{ Abort SIM Request PB }
	SCSIAbortCommandPB = RECORD
		qLink:					^SCSIHdr;
		scsiReserved1:			INTEGER;
		scsiPBLength:			UInt16;
		scsiFunctionCode:		SInt8; (* UInt8 *)
		scsiReserved2:			SInt8; (* UInt8 *)
		scsiResult:				OSErr;
		scsiDevice:				DeviceIdent;
		scsiCompletion:			SCSICallbackUPP;
		scsiFlags:				UInt32;
		scsiDriverStorage:		^UInt8;
		scsiXPTprivate:			Ptr;
		scsiReserved3:			LONGINT;
		scsiIOptr:				^SCSI_IO;								{ Pointer to the PB to abort						}
	END;

{ Terminate I/O Process Request PB }
	SCSITerminateIOPB = RECORD
		qLink:					^SCSIHdr;
		scsiReserved1:			INTEGER;
		scsiPBLength:			UInt16;
		scsiFunctionCode:		SInt8; (* UInt8 *)
		scsiReserved2:			SInt8; (* UInt8 *)
		scsiResult:				OSErr;
		scsiDevice:				DeviceIdent;
		scsiCompletion:			SCSICallbackUPP;
		scsiFlags:				UInt32;
		scsiDriverStorage:		^UInt8;
		scsiXPTprivate:			Ptr;
		scsiReserved3:			LONGINT;
		scsiIOptr:				^SCSI_IO;								{ Pointer to the PB to terminate 					}
	END;

{ Reset SCSI Bus PB }
	SCSIResetBusPB = RECORD
		qLink:					^SCSIHdr;
		scsiReserved1:			INTEGER;
		scsiPBLength:			UInt16;
		scsiFunctionCode:		SInt8; (* UInt8 *)
		scsiReserved2:			SInt8; (* UInt8 *)
		scsiResult:				OSErr;
		scsiDevice:				DeviceIdent;
		scsiCompletion:			SCSICallbackUPP;
		scsiFlags:				UInt32;
		scsiDriverStorage:		^UInt8;
		scsiXPTprivate:			Ptr;
		scsiReserved3:			LONGINT;
	END;

{ Reset SCSI Device PB }
	SCSIResetDevicePB = RECORD
		qLink:					^SCSIHdr;
		scsiReserved1:			INTEGER;
		scsiPBLength:			UInt16;
		scsiFunctionCode:		SInt8; (* UInt8 *)
		scsiReserved2:			SInt8; (* UInt8 *)
		scsiResult:				OSErr;
		scsiDevice:				DeviceIdent;
		scsiCompletion:			SCSICallbackUPP;
		scsiFlags:				UInt32;
		scsiDriverStorage:		^UInt8;
		scsiXPTprivate:			Ptr;
		scsiReserved3:			LONGINT;
	END;

{ Release SIM Queue PB }
	SCSIReleaseQPB = RECORD
		qLink:					^SCSIHdr;
		scsiReserved1:			INTEGER;
		scsiPBLength:			UInt16;
		scsiFunctionCode:		SInt8; (* UInt8 *)
		scsiReserved2:			SInt8; (* UInt8 *)
		scsiResult:				OSErr;
		scsiDevice:				DeviceIdent;
		scsiCompletion:			SCSICallbackUPP;
		scsiFlags:				UInt32;
		scsiDriverStorage:		^UInt8;
		scsiXPTprivate:			Ptr;
		scsiReserved3:			LONGINT;
	END;

{ SCSI Get Virtual ID Info PB }
	SCSIGetVirtualIDInfoPB = RECORD
		qLink:					^SCSIHdr;
		scsiReserved1:			INTEGER;
		scsiPBLength:			UInt16;
		scsiFunctionCode:		SInt8; (* UInt8 *)
		scsiReserved2:			SInt8; (* UInt8 *)
		scsiResult:				OSErr;
		scsiDevice:				DeviceIdent;
		scsiCompletion:			SCSICallbackUPP;
		scsiFlags:				UInt32;
		scsiDriverStorage:		^UInt8;
		scsiXPTprivate:			Ptr;
		scsiReserved3:			LONGINT;
		scsiOldCallID:			UInt16;									{ -> SCSI ID of device in question 			}
		scsiExists:				BOOLEAN;								{ <- true if device exists 					}
	END;

{ Create/Lookup/Remove RefNum for Device PB }
	SCSIDriverPB = RECORD
		qLink:					^SCSIHdr;
		scsiReserved1:			INTEGER;
		scsiPBLength:			UInt16;
		scsiFunctionCode:		SInt8; (* UInt8 *)
		scsiReserved2:			SInt8; (* UInt8 *)
		scsiResult:				OSErr;
		scsiDevice:				DeviceIdent;
		scsiCompletion:			SCSICallbackUPP;
		scsiFlags:				UInt32;
		scsiDriverStorage:		^UInt8;
		scsiXPTprivate:			Ptr;
		scsiReserved3:			LONGINT;
		scsiDriver:				INTEGER;								{ -> DriverRefNum, For SetDriver, <- For GetNextDriver }
		scsiDriverFlags:		UInt16;									{ <> Details of driver/device 					}
		scsiNextDevice:			DeviceIdent;							{ <- DeviceIdent of the NEXT Item in the list  }
	END;

{ Load Driver PB }
	SCSILoadDriverPB = RECORD
		qLink:					^SCSIHdr;
		scsiReserved1:			INTEGER;
		scsiPBLength:			UInt16;
		scsiFunctionCode:		SInt8; (* UInt8 *)
		scsiReserved2:			SInt8; (* UInt8 *)
		scsiResult:				OSErr;
		scsiDevice:				DeviceIdent;
		scsiCompletion:			SCSICallbackUPP;
		scsiFlags:				UInt32;
		scsiDriverStorage:		^UInt8;
		scsiXPTprivate:			Ptr;
		scsiReserved3:			LONGINT;
		scsiLoadedRefNum:		INTEGER;								{ <- SIM returns refnum of driver 					}
		scsiDiskLoadFailed:		BOOLEAN;								{ -> if true, indicates call after failure to load }
	END;

{ Defines for the scsiTransferType field }

CONST
	scsiTransferBlind			= 0;
	scsiTransferPolled			= 1;

{ Defines for the scsiDataType field }
	scsiDataBuffer				= 0;							{ single contiguous buffer supplied  				}
	scsiDataTIB					= 1;							{ TIB supplied (ptr in scsiDataPtr) 				}
	scsiDataSG					= 2;							{ scatter/gather list supplied  					}

{ Defines for the SCSIMgr scsiResult field in the PB header. }
{  $E100 thru  E1FF }
{ -$1EFF thru -1E00 }
{ -#7935 thru -7681  }
{ = 0xE100 }
	scsiErrorBase				= -7936;

	scsiRequestInProgress		= 1;							{ 1	 = PB request is in progress 			}
{ Execution failed  00-2F }
	scsiRequestAborted			= scsiErrorBase + 2;			{ -7934 = PB request aborted by the host 		}
	scsiUnableToAbort			= scsiErrorBase + 3;			{ -7933 = Unable to Abort PB request 			}
	scsiNonZeroStatus			= scsiErrorBase + 4;			{ -7932 = PB request completed with an err 	}
	scsiUnused05				= scsiErrorBase + 5;			{ -7931 =  									}
	scsiUnused06				= scsiErrorBase + 6;			{ -7930 =  									}
	scsiUnused07				= scsiErrorBase + 7;			{ -7929 =  									}
	scsiUnused08				= scsiErrorBase + 8;			{ -7928 =  									}
	scsiUnableToTerminate		= scsiErrorBase + 9;			{ -7927 = Unable to Terminate I/O PB req 		}
	scsiSelectTimeout			= scsiErrorBase + 10;			{ -7926 = Target selection timeout 			}
	scsiCommandTimeout			= scsiErrorBase + 11;			{ -7925 = Command timeout  					}
	scsiIdentifyMessageRejected	= scsiErrorBase + 12;			{ -7924 =  									}
	scsiMessageRejectReceived	= scsiErrorBase + 13;			{ -7923 = Message reject received 				}
	scsiSCSIBusReset			= scsiErrorBase + 14;			{ -7922 = SCSI bus reset sent/received 		}
	scsiParityError				= scsiErrorBase + 15;			{ -7921 = Uncorrectable parity error occured 	}
	scsiAutosenseFailed			= scsiErrorBase + 16;			{ -7920 = Autosense: Request sense cmd fail 	}
	scsiUnused11				= scsiErrorBase + 17;			{ -7919 =  									}
	scsiDataRunError			= scsiErrorBase + 18;			{ -7918 = Data overrun/underrun error  		}
	scsiUnexpectedBusFree		= scsiErrorBase + 19;			{ -7917 = Unexpected BUS free 					}
	scsiSequenceFailed			= scsiErrorBase + 20;			{ -7916 = Target bus phase sequence failure 	}
	scsiWrongDirection			= scsiErrorBase + 21;			{ -7915 = Data phase was in wrong direction 	}
	scsiUnused16				= scsiErrorBase + 22;			{ -7914 =  									}
	scsiBDRsent					= scsiErrorBase + 23;			{ -7913 = A SCSI BDR msg was sent to target 	}
	scsiTerminated				= scsiErrorBase + 24;			{ -7912 = PB request terminated by the host 	}
	scsiNoNexus					= scsiErrorBase + 25;			{ -7911 = Nexus is not established 			}
	scsiCDBReceived				= scsiErrorBase + 26;			{ -7910 = The SCSI CDB has been received 		}
{ Couldn't begin execution  30-3F }
	scsiTooManyBuses			= scsiErrorBase + 48;			{ -7888 = Register failed because we're full	}
	scsiBusy					= scsiErrorBase + 49;			{ -7887 = SCSI subsystem is busy 				}
	scsiProvideFail				= scsiErrorBase + 50;			{ -7886 = Unable to provide requ. capability	}
	scsiDeviceNotThere			= scsiErrorBase + 51;			{ -7885 = SCSI device not installed/there  	}
	scsiNoHBA					= scsiErrorBase + 52;			{ -7884 = No HBA detected Error 				}
	scsiDeviceConflict			= scsiErrorBase + 53;			{ -7883 = sorry, max 1 refNum per DeviceIdent 	}
	scsiNoSuchXref				= scsiErrorBase + 54;			{ -7882 = no such RefNum xref 					}
	scsiQLinkInvalid			= scsiErrorBase + 55;			{ -7881 = pre-linked PBs not supported			
																   (The QLink field was nonzero)		}
{ Parameter errors  40-7F }
	scsiPBLengthError			= scsiErrorBase + 64;			{ -7872 = (scsiPBLength is insuf'ct/invalid 	}
	scsiFunctionNotAvailable	= scsiErrorBase + 65;			{ -7871 = The requ. func is not available  	}
	scsiRequestInvalid			= scsiErrorBase + 66;			{ -7870 = PB request is invalid 				}
	scsiBusInvalid				= scsiErrorBase + 67;			{ -7869 = Bus ID supplied is invalid  			}
	scsiTIDInvalid				= scsiErrorBase + 68;			{ -7868 = Target ID supplied is invalid 		}
	scsiLUNInvalid				= scsiErrorBase + 69;			{ -7867 = LUN supplied is invalid  			}
	scsiIDInvalid				= scsiErrorBase + 70;			{ -7866 = The initiator ID is invalid  		}
	scsiDataTypeInvalid			= scsiErrorBase + 71;			{ -7865 = scsiDataType requested not supported }
	scsiTransferTypeInvalid		= scsiErrorBase + 72;			{ -7864 = scsiTransferType field is too high 	}
	scsiCDBLengthInvalid		= scsiErrorBase + 73;			{ -7863 = scsiCDBLength field is too big 		}

	scsiExecutionErrors			= scsiErrorBase;
	scsiNotExecutedErrors		= scsiTooManyBuses;
	scsiParameterErrors			= scsiPBLengthError;

{ Defines for the scsiResultFlags field }
	scsiSIMQFrozen				= $0001;						{ The SIM queue is frozen w/this err			}
	scsiAutosenseValid			= $0002;						{ Autosense data valid for target  			}
	scsiBusNotFree				= $0004;						{ At time of callback, SCSI bus is not free	}

{ Defines for the bit numbers of the scsiFlags field in the PB header for the SCSIExecIO function }
	kbSCSIDisableAutosense		= 29;							{ Disable auto sense feature 					}
	kbSCSIFlagReservedA			= 28;							{  											}
	kbSCSIFlagReserved0			= 27;							{  											}
	kbSCSICDBLinked				= 26;							{ The PB contains a linked CDB					}
	kbSCSIQEnable				= 25;							{ Target queue actions are enabled				}
	kbSCSICDBIsPointer			= 24;							{ The CDB field contains a pointer				}
	kbSCSIFlagReserved1			= 23;							{ 												}
	kbSCSIInitiateSyncData		= 22;							{ Attempt Sync data xfer and SDTR				}
	kbSCSIDisableSyncData		= 21;							{ Disable sync, go to async					}
	kbSCSISIMQHead				= 20;							{ Place PB at the head of SIM Q				}
	kbSCSISIMQFreeze			= 19;							{ Return the SIM Q to frozen state				}
	kbSCSISIMQNoFreeze			= 18;							{ Disallow SIM Q freezing						}
	kbSCSIDoDisconnect			= 17;							{ Definitely do disconnect						}
	kbSCSIDontDisconnect		= 16;							{ Definitely don't disconnect					}
	kbSCSIDataReadyForDMA		= 15;							{ Data buffer(s) are ready for DMA				}
	kbSCSIFlagReserved3			= 14;							{ 												}
	kbSCSIDataPhysical			= 13;							{ SG/Buffer data ptrs are physical				}
	kbSCSISensePhysical			= 12;							{ Autosense buffer ptr is physical				}
	kbSCSIFlagReserved5			= 11;							{ 												}
	kbSCSIFlagReserved6			= 10;							{ 												}
	kbSCSIFlagReserved7			= 9;							{ 												}
	kbSCSIFlagReserved8			= 8;							{ 												}
	kbSCSIDataBufferValid		= 7;							{ Data buffer valid							}
	kbSCSIStatusBufferValid		= 6;							{ Status buffer valid 							}
	kbSCSIMessageBufferValid	= 5;							{ Message buffer valid							}
	kbSCSIFlagReserved9			= 4;							{  											}

{ Defines for the bit masks of the scsiFlags field }
	scsiDirectionMask			= $C0000000;					{ Data direction mask						}
	scsiDirectionNone			= $C0000000;					{ Data direction (11: no data)				}
	scsiDirectionReserved		= $00000000;					{ Data direction (00: reserved)			}
	scsiDirectionOut			= $80000000;					{ Data direction (10: DATA OUT)			}
	scsiDirectionIn				= $40000000;					{ Data direction (01: DATA IN)				}
	scsiDisableAutosense		= $20000000;					{ Disable auto sense feature				}
	scsiFlagReservedA			= $10000000;					{ 											}
	scsiFlagReserved0			= $08000000;					{ 											}
	scsiCDBLinked				= $04000000;					{ The PB contains a linked CDB				}
	scsiQEnable					= $02000000;					{ Target queue actions are enabled			}
	scsiCDBIsPointer			= $01000000;					{ The CDB field contains a pointer			}
	scsiFlagReserved1			= $00800000;					{ 											}
	scsiInitiateSyncData		= $00400000;					{ Attempt Sync data xfer and SDTR			}
	scsiDisableSyncData			= $00200000;					{ Disable sync, go to async				}
	scsiSIMQHead				= $00100000;					{ Place PB at the head of SIM Q			}
	scsiSIMQFreeze				= $00080000;					{ Return the SIM Q to frozen state			}
	scsiSIMQNoFreeze			= $00040000;					{ Disallow SIM Q freezing					}
	scsiDoDisconnect			= $00020000;					{ Definitely do disconnect					}
	scsiDontDisconnect			= $00010000;					{ Definitely don't disconnect				}
	scsiDataReadyForDMA			= $00008000;					{ Data buffer(s) are ready for DMA			}
	scsiFlagReserved3			= $00004000;					{  }
	scsiDataPhysical			= $00002000;					{ SG/Buffer data ptrs are physical			}
	scsiSensePhysical			= $00001000;					{ Autosense buffer ptr is physical			}
	scsiFlagReserved5			= $00000800;					{  										}
	scsiFlagReserved6			= $00000400;					{ 											}
	scsiFlagReserved7			= $00000200;					{ 											}
	scsiFlagReserved8			= $00000100;					{ 											}

{ bit masks for the scsiIOFlags field in SCSIExecIOPB }
	scsiNoParityCheck			= $0002;						{ disable parity checking 							}
	scsiDisableSelectWAtn		= $0004;						{ disable select w/Atn  							}
	scsiSavePtrOnDisconnect		= $0008;						{ do SaveDataPointer upon Disconnect msg 			}
	scsiNoBucketIn				= $0010;						{ don’t bit bucket in during this I/O 				}
	scsiNoBucketOut				= $0020;						{ don’t bit bucket out during this I/O 			}
	scsiDisableWide				= $0040;						{ disable wide transfer negotiation 				}
	scsiInitiateWide			= $0080;						{ initiate wide transfer negotiation 				}
	scsiRenegotiateSense		= $0100;						{ renegotiate sync/wide before issuing autosense 	}
	scsiDisableDiscipline		= $0200;						{ disable parameter checking on SCSIExecIO calls	}
	scsiIOFlagReserved0080		= $0080;						{  												}
	scsiIOFlagReserved8000		= $8000;						{ 													}

{ Defines for the SIM/HBA queue actions.  These values are used in the }
{ SCSIExecIOPB, for the queue action field. [These values should match the }
{ defines from some other include file for the SCSI message phases.  We may }
{ not need these definitions here. ] }
	scsiSimpleQTag				= $20;							{ Tag for a simple queue 								}
	scsiHeadQTag				= $21;							{ Tag for head of queue  								}
	scsiOrderedQTag				= $22;							{ Tag for ordered queue 								}

{ Defines for the Bus Inquiry PB fields. }
{ scsiHBAInquiry field bits }
	scsiBusMDP					= $80;							{ Supports Modify Data Pointer message						}
	scsiBusWide32				= $40;							{ Supports 32 bit wide SCSI								}
	scsiBusWide16				= $20;							{ Supports 16 bit wide SCSI								}
	scsiBusSDTR					= $10;							{ Supports Sync Data Transfer Req message					}
	scsiBusLinkedCDB			= $08;							{ Supports linked CDBs										}
	scsiBusTagQ					= $02;							{ Supports tag queue message								}
	scsiBusSoftReset			= $01;							{ Supports soft reset										}

{ scsiDataTypes field bits  }
{	bits 0->15 Apple-defined, 16->30 3rd-party unique, 31 = reserved }
	scsiBusDataTIB				= 0+(1 * (2**(scsiDataTIB)));	{ TIB supplied (ptr in scsiDataPtr)		}
	scsiBusDataBuffer			= 0+(1 * (2**(scsiDataBuffer))); { single contiguous buffer supplied 		}
	scsiBusDataSG				= 0+(1 * (2**(scsiDataSG)));	{ scatter/gather list supplied 			}
	scsiBusDataReserved			= $80000000;					{   										}

{ scsiScanFlags field bits }
	scsiBusScansDevices			= $80;							{ Bus scans for and maintains device list			}
	scsiBusScansOnInit			= $40;							{ Bus scans performed at power-up/reboot			}
	scsiBusLoadsROMDrivers		= $20;							{ may load ROM drivers to support targets 			}

{ scsiFeatureFlags field bits }
	scsiBusInternalExternalMask	= $000000C0;					{ bus internal/external mask					}
	scsiBusInternalExternalUnknown = $00000000;					{ not known whether bus is inside or outside 	}
	scsiBusInternalExternal		= $000000C0;					{ bus goes inside and outside the box 			}
	scsiBusInternal				= $00000080;					{ bus goes inside the box 						}
	scsiBusExternal				= $00000040;					{ bus goes outside the box 					}
	scsiBusCacheCoherentDMA		= $00000020;					{ DMA is cache coherent 						}
	scsiBusOldCallCapable		= $00000010;					{ SIM is old call capable 						}
	scsiBusDifferential			= $00000004;					{ Single Ended (0) or Differential (1) 		}
	scsiBusFastSCSI				= $00000002;					{ HBA supports fast SCSI 						}
	scsiBusDMAavailable			= $00000001;					{ DMA is available 							}

{ scsiWeirdStuff field bits }
	scsiOddDisconnectUnsafeRead1 = $0001;						{ Disconnects on odd byte boundries are unsafe with DMA and/or blind reads }
	scsiOddDisconnectUnsafeWrite1 = $0002;						{ Disconnects on odd byte boundries are unsafe with DMA and/or blind writes }
	scsiBusErrorsUnsafe			= $0004;						{ Non-handshaked delays or disconnects during blind transfers may cause a crash }
	scsiRequiresHandshake		= $0008;						{ Non-handshaked delays or disconnects during blind transfers may cause data corruption }
	scsiTargetDrivenSDTRSafe	= $0010;						{ Targets which initiate synchronous negotiations are supported }
	scsiOddCountForPhysicalUnsafe = $0020;						{ If using physical addrs all counts must be even, and disconnects must be on even boundries }

{ scsiHBAslotType values }
	scsiMotherboardBus			= $00;							{ A built in Apple supplied bus 					}
	scsiNuBus					= $01;							{ A SIM on a NuBus card 							}
	scsiPDSBus					= $03;							{    "  on a PDS card								}
	scsiPCIBus					= $04;							{    "  on a PCI bus card							}
	scsiPCMCIABus				= $05;							{    "  on a PCMCIA card							}
	scsiFireWireBridgeBus		= $06;							{    "  connected through a FireWire bridge		}

{ Defines for the scsiDriverFlags field (in SCSIDriverPB) }
	scsiDeviceSensitive			= $0001;						{ Only driver should access this device				}
	scsiDeviceNoOldCallAccess	= $0002;						{ no old call access to this device 					}

{  SIMInitInfo PB }
{ directions are for SCSIRegisterBus call ( -> parm, <- result) 			}

TYPE
	SIMInitInfo = RECORD
		SIMstaticPtr:			^UInt8;									{ <- alloc. ptr to the SIM's static vars 				}
		staticSize:				LONGINT;								{ -> num bytes SIM needs for static vars 				}
		SIMInit:				SIMInitUPP;								{ -> pointer to the SIM init routine 					}
		SIMAction:				SIMActionUPP;							{ -> pointer to the SIM action routine 				}
		SIM_ISR:				SCSIInterruptUPP;						{ 	  reserved 											}
		SIMInterruptPoll:		SCSIInterruptUPP;						{ -> pointer to the SIM interrupt poll routine			}
		NewOldCall:				SIMActionUPP;							{ -> pointer to the SIM NewOldCall routine				}
		ioPBSize:				UInt16;									{ -> size of SCSI_IO_PBs required for this SIM			}
		oldCallCapable:			BOOLEAN;								{ -> true if this SIM can handle old-API calls			}
		simInfoUnused1:			SInt8; (* UInt8 *)						{ 	  reserved											}
		simInternalUse:			LONGINT;								{ xx not affected or viewed by XPT						}
		XPT_ISR:				SCSIUPP;								{    reserved											}
		EnteringSIM:			SCSIUPP;								{ <- ptr to the EnteringSIM routine					}
		ExitingSIM:				SCSIUPP;								{ <- ptr to the ExitingSIM routine						}
		MakeCallback:			SCSIMakeCallbackUPP;					{ <- the XPT layer’s SCSIMakeCallback routine	        }
		busID:					UInt16;									{ <- bus number for the registered bus					}
		simSlotNumber:			SInt8; (* UInt8 *)						{ <- Magic cookie to place in scsiHBASlotNumber (PCI)	}
		simSRsrcID:				SInt8; (* UInt8 *)						{ <- Magic cookie to place in scsiSIMsRsrcID	 (PCI)	}
		simRegEntry:			Ptr;									{ -> The SIM's RegEntryIDPtr					 (PCI)	}
	END;

{ Glue between SCSI calls and SCSITrap format }

CONST
	xptSCSIAction				= $0001;
	xptSCSIRegisterBus			= $0002;
	xptSCSIDeregisterBus		= $0003;
	xptSCSIReregisterBus		= $0004;
	xptSCSIKillXPT				= $0005;						{ kills Mini-XPT after transition }
	xptSCSIInitialize			= $000A;						{ Initialize the SCSI manager }

{ SCSI status}
	scsiStatGood				= $00;							{ Good Status}
	scsiStatCheckCondition		= $02;							{ Check Condition}
	scsiStatConditionMet		= $04;							{ Condition Met}
	scsiStatBusy				= $08;							{ Busy}
	scsiStatIntermediate		= $10;							{ Intermediate}
	scsiStatIntermedMet			= $14;							{ Intermediate - Condition Met}
	scsiStatResvConflict		= $18;							{ Reservation conflict}
	scsiStatTerminated			= $22;							{ Command terminated}
	scsiStatQFull				= $28;							{ Queue full}

{ SCSI messages}
	kCmdCompleteMsg				= 0;
	kExtendedMsg				= 1;							{ 0x01}
	kSaveDataPointerMsg			= 2;							{ 0x02}
	kRestorePointersMsg			= 3;							{ 0x03}
	kDisconnectMsg				= 4;							{ 0x04}
	kInitiatorDetectedErrorMsg	= 5;							{ 0x05}
	kAbortMsg					= 6;							{ 0x06}
	kMsgRejectMsg				= 7;							{ 0x07}
	kNoOperationMsg				= 8;							{ 0x08}
	kMsgParityErrorMsg			= 9;							{ 0x09}
	kLinkedCmdCompleteMsg		= 10;							{ 0x0a}
	kLinkedCmdCompleteWithFlagMsg = 11;							{ 0x0b}
	kBusDeviceResetMsg			= 12;							{ 0x0c}
	kAbortTagMsg				= 13;							{ 0x0d}
	kClearQueueMsg				= 14;							{ 0x0e}
	kInitiateRecoveryMsg		= 15;							{ 0x0f}
	kReleaseRecoveryMsg			= 16;							{ 0x10}
	kTerminateIOProcessMsg		= 17;							{ 0x11}
	kSimpleQueueTag				= $20;							{ 0x20}
	kHeadOfQueueTagMsg			= 33;							{ 0x21}
	kOrderedQueueTagMsg			= 34;							{ 0x22}
	kIgnoreWideResidueMsg		= 35;							{ 0x23}

{ moveq #kSCSIx, D0;  _SCSIAtomic }

FUNCTION SCSIAction(VAR parameterBlock: SCSI_PB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7001, $A089, $3E80;
	{$ENDC}
FUNCTION SCSIRegisterBus(VAR parameterBlock: SIMInitInfo): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7002, $A089, $3E80;
	{$ENDC}
FUNCTION SCSIDeregisterBus(VAR parameterBlock: SCSI_PB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7003, $A089, $3E80;
	{$ENDC}
FUNCTION SCSIReregisterBus(VAR parameterBlock: SIMInitInfo): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7004, $A089, $3E80;
	{$ENDC}
FUNCTION SCSIKillXPT(VAR parameterBlock: SIMInitInfo): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7005, $A089, $3E80;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SCSIIncludes}

{$ENDC} {__SCSI__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
