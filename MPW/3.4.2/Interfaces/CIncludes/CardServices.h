/*
 	File:		CardServices.h
 
	Contains:	This file contains constants and data structures that describe
				the client interface to Card and Socket Services.

 	Version:	Technology: PCMCIA Software 2.0
				Package:	Universal Interfaces 2.1.1 in “MPW Latest” on ETO #19
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
  
*/

#ifndef __CARDSERVICES__
#define __CARDSERVICES__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __PCCARDTUPLES__
#include <PCCardTuples.h>
#endif

#ifndef __MIXEDMODE__
#include <MixedMode.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif


enum {
	CS_MAX_SOCKETS				= 32							/* a long is used as a socket bitmap*/
};

/* ••• Should eventually move to <Gestalt.h>*/
enum {
	gestaltCardServicesAttr		= 'pccd',						/* Card Services attributes*/
	gestaltCardServicesPresent	= 0								/* if set, Card Services is present*/
};

/* ••• Should eventually move to <Traps.h>*/
enum {
	_PCCardDispatch				= 0xAAF0						/* Card Services entry trap*/
};

/* 
	The PC Card Manager will migrate towards a complete Mac name space very soon.
	Part of that process will be to reassign result codes to a range reserved for
	the PC Card Manager...the range will be...-9050 to -9305 (decimal inclusive).
*/
/*	result codes*/
enum {
	kCSBadAdapterErr			= -9050,						/* invalid adapter number*/
	kCSBadAttributeErr			= -9051,						/* specified attributes field value is invalid*/
	kCSBadBaseErr				= -9052,						/* specified base system memory address is invalid*/
	kCSBadEDCErr				= -9053,						/* specified EDC generator specified is invalid*/
	kCSBadIRQErr				= -9054,						/* specified IRQ level is invalid*/
	kCSBadOffsetErr				= -9055,						/* specified PC card memory array offset is invalid*/
	kCSBadPageErr				= -9056,						/* specified page is invalid*/
	kCSBadSizeErr				= -9057,						/* specified size is invalid*/
	kCSBadSocketErr				= -9058,						/* specified logical or physical socket number is invalid*/
	kCSBadTypeErr				= -9059,						/* specified window or interface type is invalid*/
	kCSBadVccErr				= -9060,						/* specified Vcc power level index is invalid*/
	kCSBadVppErr				= -9061,						/* specified Vpp1 or Vpp2 power level index is invalid*/
	kCSBadWindowErr				= -9062,						/* specified window is invalid*/
	kCSBadArgLengthErr			= -9063,						/* ArgLength argument is invalid*/
	kCSBadArgsErr				= -9064,						/* values in argument packet are invalid*/
	kCSBadHandleErr				= -9065,						/* clientHandle is invalid*/
	kCSBadCISErr				= -9066,						/* CIS on card is invalid*/
	kCSBadSpeedErr				= -9067,						/* specified speed is unavailable*/
	kCSReadFailureErr			= -9068,						/* unable to complete read request*/
	kCSWriteFailureErr			= -9069,						/* unable to complete write request*/
	kCSGeneralFailureErr		= -9070,						/* an undefined error has occurred*/
	kCSNoCardErr				= -9071,						/* no PC card in the socket*/
	kCSUnsupportedFunctionErr	= -9072,						/* function is not supported by this implementation*/
	kCSUnsupportedModeErr		= -9073,						/* mode is not supported*/
	kCSBusyErr					= -9074,						/* unable to process request at this time - try later*/
	kCSWriteProtectedErr		= -9075,						/* media is write-protected*/
	kCSConfigurationLockedErr	= -9076,						/* a configuration has already been locked*/
	kCSInUseErr					= -9077,						/* requested resource is being used by a client*/
	kCSNoMoreItemsErr			= -9078,						/* there are no more of the requested item*/
	kCSOutOfResourceErr			= -9079							/* Card Services has exhausted the resource*/
};

/*	messages sent to client's event handler*/
enum {
	kCSNullMessage				= 0x00,							/* no messages pending (not sent to clients)*/
	kCSCardInsertionMessage		= 0x01,							/* card has been inserted into the socket*/
	kCSCardRemovalMessage		= 0x02,							/* card has been removed from the socket*/
	kCSCardLockMessage			= 0x03,							/* card is locked into the socket with a mechanical latch*/
	kCSCardUnlockMessage		= 0x04,							/* card is no longer locked into the socket*/
	kCSCardReadyMessage			= 0x05,							/* card is ready to be accessed*/
	kCSCardResetMessage			= 0x06,							/* physical reset has completed*/
	kCSInsertionRequestMessage	= 0x07,							/* request to insert a card using insertion motor*/
	kCSInsertionCompleteMessage	= 0x08,							/* insertion motor has finished inserting a card*/
	kCSEjectionRequestMessage	= 0x09,							/* user or other client is requesting a card ejection*/
	kCSEjectionFailedMessage	= 0x0A,							/* eject failure due to electrical/mechanical problems*/
	kCSPMResumeMessage			= 0x0B,							/* power management resume (TBD)*/
	kCSPMSuspendMessage			= 0x0C,							/* power management suspend (TBD)*/
	kCSResetPhysicalMessage		= 0x0D,							/* physical reset is about to occur on this card*/
	kCSResetRequestMessage		= 0x0E,							/* physical reset has been requested by a client*/
	kCSResetCompleteMessage		= 0x0F,							/* ResetCard() background reset has completed*/
	kCSBatteryDeadMessage		= 0x10,							/* battery is no longer useable, data will be lost*/
	kCSBatteryLowMessage		= 0x11,							/* battery is weak and should be replaced*/
	kCSWriteProtectMessage		= 0x12,							/* card is now write protected*/
	kCSWriteEnabledMessage		= 0x13,							/* card is now write enabled*/
	kCSClientInfoMessage		= 0x14,							/* client is to return client information*/
	kCSSSUpdatedMessage			= 0x15,							/* AddSocketServices/ReplaceSocket services has changed SS support*/
	kCSFunctionInterruptMessage	= 0x16,							/* card function interrupt*/
	kCSAccessErrorMessage		= 0x17,							/* client bus errored on access to socket*/
	kCSCardUnconfiguredMessage	= 0x18,							/* a CARD_READY was delivered to all clients and no client */
/*	requested a configuration for the socket*/
	kCSStatusChangedMessage		= 0x19							/* status change for cards in I/O mode*/
};

/*
	The following is a mapping of the PCMCIA name space to the Macintosh name space.
	These two enum lists will be removed and given to developers as a separate file.
*/
enum {
	SUCCESS						= noErr,
	BAD_ADAPTER					= kCSBadAdapterErr,
	BAD_ATTRIBUTE				= kCSBadAttributeErr,
	BAD_BASE					= kCSBadBaseErr,
	BAD_EDC						= kCSBadEDCErr,
	BAD_IRQ						= kCSBadIRQErr,
	BAD_OFFSET					= kCSBadOffsetErr,
	BAD_PAGE					= kCSBadPageErr,
	BAD_SIZE					= kCSBadSizeErr,
	BAD_SOCKET					= kCSBadSocketErr,
	BAD_TYPE					= kCSBadTypeErr,
	BAD_VCC						= kCSBadVccErr,
	BAD_VPP						= kCSBadVppErr,
	BAD_WINDOW					= kCSBadWindowErr,
	BAD_ARG_LENGTH				= kCSBadArgLengthErr,
	BAD_ARGS					= kCSBadArgsErr,
	BAD_HANDLE					= kCSBadHandleErr,
	BAD_CIS						= kCSBadCISErr,
	BAD_SPEED					= kCSBadSpeedErr,
	READ_FAILURE				= kCSReadFailureErr,
	WRITE_FAILURE				= kCSWriteFailureErr,
	GENERAL_FAILURE				= kCSGeneralFailureErr,
	NO_CARD						= kCSNoCardErr,
	UNSUPPORTED_FUNCTION		= kCSUnsupportedFunctionErr,
	UNSUPPORTED_MODE			= kCSUnsupportedModeErr,
	BUSY						= kCSBusyErr,
	WRITE_PROTECTED				= kCSWriteProtectedErr,
	CONFIGURATION_LOCKED		= kCSConfigurationLockedErr,
	IN_USE						= kCSInUseErr,
	NO_MORE_ITEMS				= kCSNoMoreItemsErr,
	OUT_OF_RESOURCE				= kCSOutOfResourceErr
};

/*	messages sent to client's event handler*/
enum {
	NULL_MESSAGE				= kCSNullMessage,
	CARD_INSERTION				= kCSCardInsertionMessage,
	CARD_REMOVAL				= kCSCardRemovalMessage,
	CARD_LOCK					= kCSCardLockMessage,
	CARD_UNLOCK					= kCSCardUnlockMessage,
	CARD_READY					= kCSCardReadyMessage,
	CARD_RESET					= kCSCardResetMessage,
	INSERTION_REQUEST			= kCSInsertionRequestMessage,
	INSERTION_COMPLETE			= kCSInsertionCompleteMessage,
	EJECTION_REQUEST			= kCSEjectionRequestMessage,
	EJECTION_FAILED				= kCSEjectionFailedMessage,
	PM_RESUME					= kCSPMResumeMessage,
	PM_SUSPEND					= kCSPMSuspendMessage,
	RESET_PHYSICAL				= kCSResetPhysicalMessage,
	RESET_REQUEST				= kCSResetRequestMessage,
	RESET_COMPLETE				= kCSResetCompleteMessage,
	BATTERY_DEAD				= kCSBatteryDeadMessage,
	BATTERY_LOW					= kCSBatteryLowMessage,
	WRITE_PROTECT				= kCSWriteProtectMessage,
	WRITE_ENABLED				= kCSWriteEnabledMessage,
	CLIENT_INFO					= kCSClientInfoMessage,
	SS_UPDATED					= kCSSSUpdatedMessage,
	FUNCTION_INTERRUPT			= kCSFunctionInterruptMessage,
	ACCESS_ERROR				= kCSAccessErrorMessage,
	CARD_UNCONFIGURED			= kCSCardUnconfiguredMessage,
	STATUS_CHANGED				= kCSStatusChangedMessage
};

/*----------------		CSAccessConfigurationRegister	----------------*/
typedef struct AccessConfigurationRegisterPB AccessConfigurationRegisterPB;

struct AccessConfigurationRegisterPB {
	UInt16							socket;						/*  -> global socket number*/
	UInt8							action;						/*  -> read/write*/
	UInt8							offset;						/*  -> offset from config register base*/
	UInt8							value;						/* <-> value to read/write*/
	UInt8							padding[1];					/* */
};
/*	‘action’ field values*/

enum {
	kCSReadConfigRegister		= 0x00,
	kCSWriteConfigRegister		= 0x01
};

/*----------------		CSGetCardServicesInfo			----------------*/
typedef struct GetCardServicesInfoPB GetCardServicesInfoPB;

struct GetCardServicesInfoPB {
	UInt8							signature[2];				/* <-  two ascii chars 'CS'*/
	UInt16							count;						/* <-  total number of sockets installed*/
	UInt16							revision;					/* <-  BCD*/
	UInt16							csLevel;					/* <-  BCD*/
	UInt16							reserved;					/*  -> zero*/
	UInt16							vStrLen;					/* <-> in: client's buffer size, out: vendor string length*/
	UInt8							*vendorString;				/* <-> in: pointer to buffer to hold CS vendor string (zero-terminated)*/
/*  	out: CS vendor string copied to buffer*/
};
/*----------------		CSGetClientInfo					----------------*/
typedef struct ClientInfoParam ClientInfoParam;

struct ClientInfoParam {
	UInt32							clientHandle;				/*  -> clientHandle returned by RegisterClient*/
	UInt16							attributes;					/* <-> subfunction + bitmapped client attributes*/
	UInt16							revision;					/* <-  BCD value of client's revision*/
	UInt16							csLevel;					/* <-  BCD value of CS release*/
	UInt16							revDate;					/* <-  revision date: y[15-9], m[8-5], d[4-0]*/
	SInt16							nameLen;					/* <-> in: max length of client name string, out: actual length*/
	SInt16							vStringLen;					/* <-> in: max length of vendor string, out: actual length*/
	UInt8							*nameString;				/* <-  pointer to client name string (zero-terminated)*/
	UInt8							*vendorString;				/* <-  pointer to vendor string (zero-terminated)*/
};
/* upper byte of attributes is kCSCardNameSubfunction,*/
/*							   kCSCardTypeSubfunction,*/
/*							   kCSHelpStringSubfunction*/
typedef struct AlternateTextStringParam AlternateTextStringParam;

struct AlternateTextStringParam {
	UInt32							clientHandle;				/*  -> clientHandle returned by RegisterClient*/
	UInt16							attributes;					/* <-> subfunction + bitmapped client attributes*/
	UInt16							socket;						/*  -> logical socket number*/
	UInt16							reserved;					/*  -> zero*/
	SInt16							length;						/* <-> in: max length of string, out: actual length*/
	UInt8							*text;						/* <-  pointer to string (zero-terminated)*/
};
/* upper byte of attributes is kCSCardIconSubfunction*/
typedef struct AlternateCardIconParam AlternateCardIconParam;

struct AlternateCardIconParam {
	UInt32							clientHandle;				/*  -> clientHandle returned by RegisterClient*/
	UInt16							attributes;					/* <-> subfunction + bitmapped client attributes*/
	UInt16							socket;						/*  -> logical socket number*/
	Handle							iconSuite;					/* <-  handle to icon suite containing all icons*/
};
/* upper byte of attributes is kCSActionProcSubfunction*/
typedef struct CustomActionProcParam CustomActionProcParam;

struct CustomActionProcParam {
	UInt32							clientHandle;				/*  -> clientHandle returned by RegisterClient*/
	UInt16							attributes;					/* <-> subfunction + bitmapped client attributes*/
	UInt16							socket;						/*  -> logical socket number*/
};
typedef struct GetClientInfoPB GetClientInfoPB;

struct GetClientInfoPB {
	union {
		ClientInfoParam					clientInfo;
		AlternateTextStringParam		alternateTextString;
		AlternateCardIconParam			alternateIcon;
		CustomActionProcParam			customActionProc;
	}								u;
};
/*	‘attributes’ field values*/

enum {
	kCSMemoryClient				= 0x0001,
	kCSIOClient					= 0x0004,
	kCSClientTypeMask			= 0x0007,
	kCSShareableCardInsertEvents = 0x0008,
	kCSExclusiveCardInsertEvents = 0x0010,
	kCSInfoSubfunctionMask		= 0xFF00,
	kCSClientInfoSubfunction	= 0x0000,
	kCSCardNameSubfunction		= 0x8000,
	kCSCardTypeSubfunction		= 0x8100,
	kCSHelpStringSubfunction	= 0x8200,
	kCSCardIconSubfunction		= 0x8300,
	kCSActionProcSubfunction	= 0x8400
};

/*----------------		CSGetConfigurationInfo			----------------*/
/*----------------		CSModifyConfiguration			----------------*/
/*----------------		CSRequestConfiguration			----------------*/
typedef struct GetModRequestConfigInfoPB GetModRequestConfigInfoPB;

struct GetModRequestConfigInfoPB {
	UInt32							clientHandle;				/*  -> clientHandle returned by RegisterClient*/
	UInt16							socket;						/*  -> logical socket number*/
	UInt16							attributes;					/* <-> bitmap of configuration attributes*/
	UInt8							vcc;						/* <-> Vcc setting*/
	UInt8							vpp1;						/* <-> Vpp1 setting*/
	UInt8							vpp2;						/* <-> Vpp2 setting*/
	UInt8							intType;					/* <-> interface type (memory or memory+I/O)*/
	UInt32							configBase;					/* <-> card base address of configuration registers*/
	UInt8							status;						/* <-> card status register setting, if present*/
	UInt8							pin;						/* <-> card pin register setting, if present*/
	UInt8							copy;						/* <-> card socket/copy register setting, if present*/
	UInt8							configIndex;				/* <-> card option register setting, if present*/
	UInt8							present;					/* <-> bitmap of which configuration registers are present*/
	UInt8							firstDevType;				/* <-  from DeviceID tuple*/
	UInt8							funcCode;					/* <-  from FuncID tuple*/
	UInt8							sysInitMask;				/* <-  from FuncID tuple*/
	UInt16							manufCode;					/* <-  from ManufacturerID tuple*/
	UInt16							manufInfo;					/* <-  from ManufacturerID tuple*/
	UInt8							cardValues;					/* <-  valid card register values*/
	UInt8							padding[1];					/* */
};
/*	‘attributes’ field values*/

enum {
	kCSExclusivelyUsed			= 0x0001,
	kCSEnableIREQs				= 0x0002,
	kCSVccChangeValid			= 0x0004,
	kCSVpp1ChangeValid			= 0x0008,
	kCSVpp2ChangeValid			= 0x0010,
	kCSValidClient				= 0x0020,
	kCSSleepPower				= 0x0040,						/* request that power be applied to socket during Sleep*/
	kCSLockSocket				= 0x0080,
	kCSTurnOnInUse				= 0x0100
};

/*	‘intType’ field values*/
enum {
	kCSMemoryInterface			= 0x01,
	kCSMemory_And_IO_Interface	= 0x02
};

/*	‘present’ field values*/
enum {
	kCSOptionRegisterPresent	= 0x01,
	kCSStatusRegisterPresent	= 0x02,
	kCSPinReplacementRegisterPresent = 0x04,
	kCSCopyRegisterPresent		= 0x08
};

/*	‘cardValues’ field values*/
enum {
	kCSOptionValueValid			= 0x01,
	kCSStatusValueValid			= 0x02,
	kCSPinReplacementValueValid	= 0x04,
	kCSCopyValueValid			= 0x08
};

/*----------------		CSGetClientEventMask			----------------*/
/*----------------		CSSetClientEventMask			----------------*/
typedef struct GetSetClientEventMaskPB GetSetClientEventMaskPB;

struct GetSetClientEventMaskPB {
	UInt32							clientHandle;				/*  -> clientHandle returned by RegisterClient*/
	UInt16							attributes;					/* <-> bitmap of attributes*/
	UInt16							eventMask;					/* <-> bitmap of events to be passed to client for this socket*/
	UInt16							socket;						/*  -> logical socket number*/
};
/*	‘attributes’ field values*/

enum {
	kCSEventMaskThisSocketOnly	= 0x0001
};

/*	‘eventMask’ field values*/
enum {
	kCSWriteProtectEvent		= 0x0001,
	kCSCardLockChangeEvent		= 0x0002,
	kCSEjectRequestEvent		= 0x0004,
	kCSInsertRequestEvent		= 0x0008,
	kCSBatteryDeadEvent			= 0x0010,
	kCSBatteryLowEvent			= 0x0020,
	kCSReadyChangeEvent			= 0x0040,
	kCSCardDetectChangeEvent	= 0x0080,
	kCSPMChangeEvent			= 0x0100,
	kCSResetEvent				= 0x0200,
	kCSSSUpdateEvent			= 0x0400,
	kCSFunctionInterrupt		= 0x0800,
	kCSAllEvents				= 0xFFFF
};

/*----------------		CSGetFirstClient				----------------*/
/*----------------		CSGetNextClient					----------------*/
typedef struct GetClientPB GetClientPB;

struct GetClientPB {
	UInt32							clientHandle;				/* <-  clientHandle for this client*/
	UInt16							socket;						/*  -> logical socket number*/
	UInt16							attributes;					/*  -> bitmap of attributes*/
};
/*	‘attributes’ field values*/

enum {
	kCSClientsForAllSockets		= 0x0000,
	kCSClientsThisSocketOnly	= 0x0001
};

/*----------------		CSGetFirstTuple					----------------*/
/*----------------		CSGetNextTuple					----------------*/
/*----------------		CSGetTupleData					----------------*/
typedef struct GetTuplePB GetTuplePB;

struct GetTuplePB {
	UInt16							socket;						/*  -> logical socket number*/
	UInt16							attributes;					/*  -> bitmap of attributes*/
	UInt8							desiredTuple;				/*  -> desired tuple code value, or $FF for all*/
	UInt8							tupleOffset;				/*  -> offset into tuple from link byte*/
	UInt16							flags;						/* <-> internal use*/
	UInt32							linkOffset;					/* <-> internal use*/
	UInt32							cisOffset;					/* <-> internal use*/
	union {
		struct {
			UInt8							tupleCode;			/* <-  tuple code found*/
			UInt8							tupleLink;			/* <-  link value for tuple found*/
		}								TuplePB;
		struct {
			UInt16							tupleDataMax;		/*  -> maximum size of tuple data area*/
			UInt16							tupleDataLen;		/* <-  number of bytes in tuple body*/
			TupleBody						tupleData;			/* <-  tuple data*/
		}								TupleDataPB;
	}								u;
};
/*	‘attributes’ field values*/

enum {
	kCSReturnLinkTuples			= 0x0001
};

/*----------------		CSRequestSocketMask				----------------*/
/*----------------		CSReleaseSocketMask				----------------*/
typedef struct ReqRelSocketMaskPB ReqRelSocketMaskPB;

struct ReqRelSocketMaskPB {
	UInt32							clientHandle;				/*  -> clientHandle returned by RegisterClient*/
	UInt16							socket;						/*  -> logical socket*/
	UInt16							eventMask;					/*  -> bitmap of events to be passed to client for this socket*/
};
/*	‘eventMask’ field values (see above for Get/SetClientEventMask*/
/*----------------		CSGetStatus						----------------*/
typedef struct GetStatusPB GetStatusPB;

struct GetStatusPB {
	UInt16							socket;						/*  -> logical socket number*/
	UInt16							cardState;					/* <-  current state of installed card*/
	UInt16							socketState;				/* <-  current state of the socket*/
};
/*	‘cardState’ field values*/

enum {
	kCSWriteProtected			= 0x0001,
	kCSCardLocked				= 0x0002,
	kCSEjectRequest				= 0x0004,
	kCSInsertRequest			= 0x0008,
	kCSBatteryDead				= 0x0010,
	kCSBatteryLow				= 0x0020,
	kCSReady					= 0x0040,
	kCSCardDetected				= 0x0080
};

/*	‘socketState’ field values*/
enum {
	kCSWriteProtectChanged		= 0x0001,
	kCSCardLockChanged			= 0x0002,
	kCSEjectRequestPending		= 0x0004,
	kCSInsertRequestPending		= 0x0008,
	kCSBatteryDeadChanged		= 0x0010,
	kCSBatteryLowChanged		= 0x0020,
	kCSReadyChanged				= 0x0040,
	kCSCardDetectChanged		= 0x0080
};

/*----------------		CSModifyWindow					----------------*/
/*----------------		CSReleaseWindow					----------------*/
/*----------------		CSRequestWindow					----------------*/
typedef struct ReqModRelWindowPB ReqModRelWindowPB;

struct ReqModRelWindowPB {
	UInt32							clientHandle;				/*  -> clientHandle returned by RegisterClient*/
	UInt32							windowHandle;				/* <-> window descriptor*/
	UInt16							socket;						/*  -> logical socket number*/
	UInt16							attributes;					/*  -> window attributes (bitmap)*/
	UInt32							base;						/* <-> system base address*/
	UInt32							size;						/* <-> memory window size*/
	UInt8							accessSpeed;				/*  -> window access speed (bitmap)*/
/*		(not applicable for I/O mode)*/
	UInt8							padding[1];					/* */
};
/*	‘attributes’ field values*/

enum {
	kCSMemoryWindow				= 0x0001,
	kCSIOWindow					= 0x0002,
	kCSAttributeWindow			= 0x0004,						/* not normally used by Card Services clients*/
	kCSWindowTypeMask			= 0x0007,
	kCSEnableWindow				= 0x0008,
	kCSAccessSpeedValid			= 0x0010,
	kCSLittleEndian				= 0x0020,						/* configure socket for little endianess*/
	kCS16BitDataPath			= 0x0040,						/**/
	kCSWindowPaged				= 0x0080,						/* */
	kCSWindowShared				= 0x0100,						/**/
	kCSWindowFirstShared		= 0x0200,						/* */
	kCSWindowProgrammable		= 0x0400						/* */
};

/*	‘accessSpeed’ field values*/
enum {
	kCSDeviceSpeedCodeMask		= 0x07,
	kCSSpeedExponentMask		= 0x07,
	kCSSpeedMantissaMask		= 0x78,
	kCSUseWait					= 0x80,
	kCSAccessSpeed250nsec		= 0x01,
	kCSAccessSpeed200nsec		= 0x02,
	kCSAccessSpeed150nsec		= 0x03,
	kCSAccessSpeed100nsec		= 0x04,
	kCSExtAccSpeedMant1pt0		= 0x01,
	kCSExtAccSpeedMant1pt2		= 0x02,
	kCSExtAccSpeedMant1pt3		= 0x03,
	kCSExtAccSpeedMant1pt5		= 0x04,
	kCSExtAccSpeedMant2pt0		= 0x05,
	kCSExtAccSpeedMant2pt5		= 0x06,
	kCSExtAccSpeedMant3pt0		= 0x07,
	kCSExtAccSpeedMant3pt5		= 0x08,
	kCSExtAccSpeedMant4pt0		= 0x09,
	kCSExtAccSpeedMant4pt5		= 0x0A,
	kCSExtAccSpeedMant5pt0		= 0x0B,
	kCSExtAccSpeedMant5pt5		= 0x0C,
	kCSExtAccSpeedMant6pt0		= 0x0D,
	kCSExtAccSpeedMant7pt0		= 0x0E,
	kCSExtAccSpeedMant8pt0		= 0x0F,
	kCSExtAccSpeedExp1ns		= 0x00,
	kCSExtAccSpeedExp10ns		= 0x01,
	kCSExtAccSpeedExp100ns		= 0x02,
	kCSExtAccSpeedExp1us		= 0x03,
	kCSExtAccSpeedExp10us		= 0x04,
	kCSExtAccSpeedExp100us		= 0x05,
	kCSExtAccSpeedExp1ms		= 0x06,
	kCSExtAccSpeedExp10ms		= 0x07
};

/*----------------		CSRegisterClient				----------------*/
/*----------------		CSDeregisterClient				----------------*/
typedef struct ClientCallbackPB ClientCallbackPB;

struct ClientCallbackPB {
	UInt16							message;					/*  -> which event this is*/
	UInt16							socket;						/*  -> logical socket number*/
	UInt16							info;						/*  -> function-specific*/
	UInt16							misc;						/*  -> function-specific*/
	Ptr								reserved;					/*  -> pointer to MTD request block*/
	Ptr								buffer;						/*  -> function-specific*/
	Ptr								clientData;					/*  -> pointer to client's data (from RegisterClient)*/
};
typedef ClientCallbackPB *ClientCallbackPBPtr;

typedef pascal UInt16 (*PCCardCSClientProcPtr)(ClientCallbackPBPtr ccPBPtr);

#if GENERATINGCFM
typedef UniversalProcPtr PCCardCSClientUPP;
#else
typedef PCCardCSClientProcPtr PCCardCSClientUPP;
#endif

enum {
	uppPCCardCSClientProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(UInt16)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ClientCallbackPBPtr)))
};

#if GENERATINGCFM
#define NewPCCardCSClientProc(userRoutine)		\
		(PCCardCSClientUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppPCCardCSClientProcInfo, GetCurrentArchitecture())
#else
#define NewPCCardCSClientProc(userRoutine)		\
		((PCCardCSClientUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallPCCardCSClientProc(userRoutine, ccPBPtr)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppPCCardCSClientProcInfo, (ccPBPtr))
#else
#define CallPCCardCSClientProc(userRoutine, ccPBPtr)		\
		(*(userRoutine))((ccPBPtr))
#endif

typedef struct RegisterClientPB RegisterClientPB;

struct RegisterClientPB {
	UInt32							clientHandle;				/* <-  client descriptor*/
	PCCardCSClientUPP				clientEntry;				/*  -> universal procPtr to client's event handler*/
	UInt16							attributes;					/*  -> bitmap of client attributes*/
	UInt16							eventMask;					/*  -> bitmap of events to notify client*/
	Ptr								clientData;					/*  -> pointer to client's data*/
	UInt16							version;					/*  -> Card Services version this client expects*/
};
/*	‘attributes’ field values (see GetClientInfo)*/
/*	kCSMemoryClient					= 0x0001,*/
/*	kCSIOClient						= 0x0004,*/
/*	kCSShareableCardInsertEvents	= 0x0008,*/
/*	kCSExclusiveCardInsertEvents	= 0x0010*/
/*----------------		CSReleaseConfiguration			----------------*/
typedef struct ReleaseConfigurationPB ReleaseConfigurationPB;

struct ReleaseConfigurationPB {
	UInt32							clientHandle;				/*  -> clientHandle returned by RegisterClient*/
	UInt16							socket;						/*  -> */
};
/*----------------		CSResetCard						----------------*/
typedef struct ResetCardPB ResetCardPB;

struct ResetCardPB {
	UInt32							clientHandle;				/*  -> clientHandle returned by RegisterClient*/
	UInt16							socket;						/*  -> */
	UInt16							attributes;					/*  -> xxx*/
};
/*----------------		CSValidateCIS					----------------*/
typedef struct ValidateCISPB ValidateCISPB;

struct ValidateCISPB {
	UInt16							socket;						/*  -> */
	UInt16							chains;						/*  -> whether link/null tuples should be included*/
};
/*----------------		CSVendorSpecific				----------------*/
typedef struct VendorSpecificPB VendorSpecificPB;

struct VendorSpecificPB {
	UInt32							clientHandle;				/*  -> clientHandle returned by RegisterClient*/
	UInt16							vsCode;
	UInt16							socket;
	UInt32							dataLen;					/*  -> length of buffer pointed to by vsDataPtr*/
	UInt8							*vsDataPtr;					/*  -> Card Services version this client expects*/
};
/*	‘vsCode’ field values*/

enum {
	vsAppleReserved				= 0x0000,
	vsEjectCard					= 0x0001,
	vsGetCardInfo				= 0x0002,
	vsEnableSocketEvents		= 0x0003,
	vsGetCardLocationIcon		= 0x0004,
	vsGetCardLocationText		= 0x0005,
	vsGetAdapterInfo			= 0x0006
};

/*****************************************************************************************/
/**/
/*	GetAdapterInfo parameter block (vendor-specific call #6)*/
typedef struct GetAdapterInfoPB GetAdapterInfoPB;

struct GetAdapterInfoPB {
	UInt32							attributes;					/* <-  capabilties of socket's adapter*/
	UInt16							revision;					/* <-  id of adapter*/
	UInt16							reserved;					/* */
	UInt16							numVoltEntries;				/* <-  number of valid voltage values*/
	UInt8							*voltages;					/* <-> array of BCD voltage values*/
};
/*	‘attributes’ field values*/

enum {
	kCSLevelModeInterrupts		= 0x00000001,
	kCSPulseModeInterrupts		= 0x00000002,
	kCSProgrammableWindowAddr	= 0x00000004,
	kCSProgrammableWindowSize	= 0x00000008,
	kCSSocketSleepPower			= 0x00000010,
	kCSSoftwareEject			= 0x00000020,
	kCSLockableSocket			= 0x00000040,
	kCSInUseIndicator			= 0x00000080
};

/*****************************************************************************************/
/**/
/*	GetCardInfo parameter block (vendor-specific call #2)*/
typedef struct GetCardInfoPB GetCardInfoPB;

struct GetCardInfoPB {
	UInt8							cardType;					/* <-  type of card in this socket (defined at top of file)*/
	UInt8							subType;					/* <-  more detailed card type (defined at top of file)*/
	UInt16							reserved;					/* <-> reserved (should be set to zero)*/
	UInt16							cardNameLen;				/*  -> maximum length of card name to be returned*/
	UInt16							vendorNameLen;				/*  -> maximum length of vendor name to be returned*/
	UInt8							*cardName;					/*  -> pointer to card name string (read from CIS), or nil*/
	UInt8							*vendorName;				/*  -> pointer to vendor name string (read from CIS), or nil*/
};
/*	GetCardInfo card types*/

enum {
	kCSUnknownCardType			= 0,
	kCSMultiFunctionCardType	= 1,
	kCSMemoryCardType			= 2,
	kCSSerialPortCardType		= 3,
	kCSSerialOnlyType			= 0,
	kCSDataModemType			= 1,
	kCSFaxModemType				= 2,
	kCSFaxAndDataModemMask		= (kCSDataModemType | kCSFaxModemType),
	kCSVoiceEncodingType		= 4,
	kCSParallelPortCardType		= 4,
	kCSFixedDiskCardType		= 5,
	kCSUnknownFixedDiskType		= 0,
	kCSATAInterface				= 1,
	kCSRotatingDevice			= (0 << 7),
	kCSSiliconDevice			= (1 << 7),
	kCSVideoAdaptorCardType		= 6,
	kCSNetworkAdaptorCardType	= 7,
	kCSAIMSCardType				= 8,
	kCSNumCardTypes				= 9
};

extern pascal OSErr CSVendorSpecific(VendorSpecificPB *pb)
 TWOWORDINLINE(0x7000, 0xAAF0);
extern pascal OSErr CSRegisterClient(RegisterClientPB *pb)
 TWOWORDINLINE(0x7001, 0xAAF0);
extern pascal OSErr CSDeregisterClient(RegisterClientPB *pb)
 TWOWORDINLINE(0x7002, 0xAAF0);
extern pascal OSErr CSGetFirstTuple(GetTuplePB *pb)
 TWOWORDINLINE(0x7003, 0xAAF0);
extern pascal OSErr CSGetNextTuple(GetTuplePB *pb)
 TWOWORDINLINE(0x7004, 0xAAF0);
extern pascal OSErr CSGetTupleData(GetTuplePB *pb)
 TWOWORDINLINE(0x7005, 0xAAF0);
extern pascal OSErr CSGetConfigurationInfo(GetModRequestConfigInfoPB *pb)
 TWOWORDINLINE(0x7006, 0xAAF0);
extern pascal OSErr CSGetCardServicesInfo(GetCardServicesInfoPB *pb)
 TWOWORDINLINE(0x7007, 0xAAF0);
extern pascal OSErr CSGetStatus(GetStatusPB *pb)
 TWOWORDINLINE(0x7008, 0xAAF0);
extern pascal OSErr CSValidateCIS(ValidateCISPB *pb)
 TWOWORDINLINE(0x7009, 0xAAF0);
extern pascal OSErr CSGetFirstClient(GetClientPB *pb)
 TWOWORDINLINE(0x700F, 0xAAF0);
extern pascal OSErr CSGetNextClient(GetClientPB *pb)
 TWOWORDINLINE(0x7010, 0xAAF0);
extern pascal OSErr CSGetClientInfo(GetClientInfoPB *pb)
 TWOWORDINLINE(0x7011, 0xAAF0);
extern pascal OSErr CSResetCard(ResetCardPB *pb)
 TWOWORDINLINE(0x7012, 0xAAF0);
extern pascal OSErr CSRequestWindow(ReqModRelWindowPB *pb)
 TWOWORDINLINE(0x7013, 0xAAF0);
extern pascal OSErr CSModifyWindow(ReqModRelWindowPB *pb)
 TWOWORDINLINE(0x7014, 0xAAF0);
extern pascal OSErr CSReleaseWindow(ReqModRelWindowPB *pb)
 TWOWORDINLINE(0x7015, 0xAAF0);
extern pascal OSErr CSRequestConfiguration(GetModRequestConfigInfoPB *pb)
 TWOWORDINLINE(0x701B, 0xAAF0);
extern pascal OSErr CSModifyConfiguration(GetModRequestConfigInfoPB *pb)
 TWOWORDINLINE(0x701C, 0xAAF0);
extern pascal OSErr CSAccessConfigurationRegister(AccessConfigurationRegisterPB *pb)
 TWOWORDINLINE(0x701D, 0xAAF0);
extern pascal OSErr CSReleaseConfiguration(ReleaseConfigurationPB *pb)
 TWOWORDINLINE(0x701E, 0xAAF0);
extern pascal OSErr CSGetClientEventMask(GetSetClientEventMaskPB *pb)
 TWOWORDINLINE(0x701F, 0xAAF0);
extern pascal OSErr CSSetClientEventMask(GetSetClientEventMaskPB *pb)
 TWOWORDINLINE(0x7020, 0xAAF0);
extern pascal OSErr CSRequestSocketMask(ReqRelSocketMaskPB *pb)
 TWOWORDINLINE(0x7021, 0xAAF0);
extern pascal OSErr CSReleaseSocketMask(ReqRelSocketMaskPB *pb)
 TWOWORDINLINE(0x7022, 0xAAF0);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __CARDSERVICES__ */
