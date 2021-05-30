/************************************************************

Created: Thursday, September 7, 1989 at 7:28 PM
	ShutDown.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1987-1989
	All rights reserved

************************************************************/


#ifndef __SHUTDOWN__
#define __SHUTDOWN__

#ifndef __TYPES__
#include <Types.h>
#endif

#define sdOnPowerOff 1		/*call procedure before power off.*/
#define sdOnRestart 2		/*call procedure before restart.*/
#define sdOnUnmount 4		/*call procedure before unmounting.*/
#define sdOnDrivers 8		/*call procedure before closing drivers.*/
#define sdRestartOrPower 3	/*call before either power off or restart.*/

typedef pascal void (*ShutDwnProcPtr)(void);

#ifdef __cplusplus
extern "C" {
#endif
pascal void ShutDwnPower(void)
	= {0x3F3C,0x0001,0xA895};
pascal void ShutDwnStart(void)
	= {0x3F3C,0x0002,0xA895};
pascal void ShutDwnInstall(ShutDwnProcPtr shutDownProc,short flags)
	= {0x3F3C,0x0003,0xA895};
pascal void ShutDwnRemove(ShutDwnProcPtr shutDownProc)
	= {0x3F3C,0x0004,0xA895};
#ifdef __cplusplus
}
#endif

#endif
