/************************************************************

Created: Thursday, September 28, 1989 at 12:21 PM
	Power.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1989
	All rights reserved

************************************************************/


#ifndef __POWER__
#define __POWER__

#ifndef __TYPES__
#include <Types.h>
#endif


/* PMgrResultCode values
 */

#define pmBusyErr -13000		/* PMgr stuck busy */
#define pmReplyTOErr -13001 	/* Timed out waiting to begin reply handshake */
#define pmSendStartErr -13002	/* PMgr did not start handshake */
#define pmSendEndErr -13003 	/* During send, PMgr did not finish handshake */
#define pmRecvStartErr -13004	/* During receive, PMgr did not start handshake */
#define pmRecvEndErr -13005 	/* During receive, PMgr did not finish handshake */

/* bit positions for PowerClockByte
 */

#define pmSCCBit 1				/*SCC clock*/
#define pmModemBit 3			/*Internal modem power*/
#define pmSerialBit 4			/*Serial drivers power*/
#define pmVoltBit 6 			/*-5 volt power*/
#define pmDevEnableBit 7

/* Masks for PowerClockByte */

#define pmSCCMask 0x2
#define pmModemMask 0x8
#define pmSerialMask 0x10
#define pmVoltMask 0x40
#define pmDevEnableMask 0x80

/* Bit positions for ModemByte
 */

#define modemOnBit 0
#define ringWakeUpBit 2
#define modemInstalledBit 3
#define ringDetectBit 4
#define modemOnHookBit 5

/* masks for ModemByte */

#define modemOnMask 0x1
#define ringWakeUpMask 0x4
#define modemInstalledMask 0x8
#define ringDetectMask 0x10
#define modemOnHookMask 0x20

/* bit positions for BatteryByte */

#define chargerConnBit 0
#define hiChargeBit 1
#define chargeOverFlowBit 2
#define batteryDeadBit 3
#define batteryLowBit 4
#define connChangedBit 5

/* masks for BatteryByte */

#define chargerConnMask 0x1
#define hiChargeMask 0x2
#define chargeOverFlowMask 0x4
#define batteryDeadMask 0x8
#define batteryLowMask 0x10
#define connChangedMask 0x20

/* Commands for PMOp function */

#define powerCntl 0x10			/* Power/clock control */
#define powerRead 0x18			/* Power/clock control */
#define modemRead 0x58			/* Internal modem setup */
#define batteryRead 0x68		/* Battery/charger level and status */
#define setWakeUp 0x80			/* Set Wake-up timer */
#define disableWakeUp 0x82		/* Disable Wake-up timer */
#define readWakeUp 0x88 		/* Read Wake-up timer */

/* SleepQRec.sleepQFlags
 */

#define noCalls 1
#define noRequest 2

typedef char PowerClockByte;
typedef char ModemByte;
typedef char BatteryByte;


typedef long PMResultCode;

struct PMParamBlock {
	short pmCommand;
	short pmCount;
	Ptr pmSendBuff;
	Ptr pmReceiveBuff;
};

typedef struct PMParamBlock PMParamBlock;
typedef PMParamBlock *PMParamBlockPtr;

struct SleepQRec {
	struct SleepQRec *sleepQLink;
	short sleepQType;			/*type = 16*/
	ProcPtr sleepQProc; 		/*Pointer to sleep routine*/
	short sleepQFlags;
};

typedef struct SleepQRec SleepQRec;
typedef SleepQRec *SleepQRecPtr;

#ifdef __cplusplus
extern "C" {
#endif
PMResultCode PMOp(PMParamBlockPtr pBlockPtr)
	= {0x205F,0xA085};
long IdleUpdate(void)
	= 0xA285;
long GetCPUSpeed(void)
	= {0x70FF,0xA485};
void EnableIdle(void)
	= {0x7000,0xA485};
void DisableIdle(void)
	= {0x7001,0xA485};
void SleepQInstall(SleepQRecPtr qRecPtr)
	= {0x205F,0xA28A};
void SleepQRemove(SleepQRecPtr qRecPtr)
	= {0x205F,0xA48A};
void AOn(void)
	= {0x7004,0xA685};
void AOnIgnoreModem(void)
	= {0x7005,0xA685};
void BOn(void)
	= {0x7000,0xA685};
void BOnIgnoreModem(void)
	= {0x7001,0xA685};
void AOff(void)
	= {0x7084,0xA685};
void BOff(void)
	= {0x7080,0xA685};
#ifdef __cplusplus
}
#endif

#endif
