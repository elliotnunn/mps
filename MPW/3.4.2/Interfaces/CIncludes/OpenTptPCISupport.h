/*
	File:		OpenTptPCISupport.h

	Contains:	File to include everything you need to declare a module

	Copyright:	© 1993-1995 by Apple Computer, Inc., all rights reserved.


*/

#ifndef __OPENTPTPCISUPPORT__
#define __OPENTPTPCISUPPORT__

#ifndef __OPENTPTCOMMON__
#include <OpenTptCommon.h>
#endif
#ifndef __DEVICES__	
#include <Devices.h>
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

/*******************************************************************************
** This is the cookie that is passed to your STREAM Module
********************************************************************************/

struct OTPCIInfo
{
	RegEntryID			fTheID;
	void*				fConfigurationInfo;
	size_t				fConfigurationLength;
};

typedef struct OTPCIInfo OTPCIInfo;

/*******************************************************************************
** PCI Card support
********************************************************************************/
/*
 * All PCI card modules should have the following bits set in their
 * install_info structure:
 * kOTModIsDriver.
 * 
 * They should NEVER have the kOTModPushAlways or the kOTModIsModule
 * flags set.
 *
 * The kOTModIsLowerMux bits should be set if the driver is a lower
 * multiplexor, although Open Transport does nothing with the information
 * today.
 *
 * The kOTModUpperIsDLPI bit should be set if the driver uses the DLPI message
 * specification.  The kOTModUpperIsTPI bit should be set if the driver uses
 * the TPI message specification.
 */
 
 /*	-------------------------------------------------------------------------
	Macro to put together the driverServices.service[x].serviceType field
	
	// xxxxxddd dddddddd ffffffff xxxxxxTD
	//
	// where "d" is the device type for Open Transport,
	// the lower two bits are whether the driver is TPI or DLPI,
	// and the "f" bits are the framing option flags.
	// and all other bits should be 0
	------------------------------------------------------------------------- */

#define OTPCIServiceType(devType, framingFlags, isTPI, isDLPI)	\
	((devType << 16) | (((framingFlags) & 0xff) << 8) | (isTPI ? 2 : 0) | (isDLPI ? 1 : 0 ))

 /*	-------------------------------------------------------------------------
	Typedef for the ValidateHardware function.  This function will be
	called only once, at system boot time, before installing your driver
	into the Open Transport module registry.
	The param pointer will is a RegEntryIDPtr - don't be changing the
	values there!
	------------------------------------------------------------------------- */

typedef OTResult	(* _CDECL ValidateHardwareProcPtr)(OTPCIInfo* param);

enum
{
	kOTPCINoErrorStayLoaded		= 1
};

/*	-------------------------------------------------------------------------
	Some descriptors we use - these should eventually show up
	in system header files somewhere.
	------------------------------------------------------------------------- */

#define kDescriptorProperty		"driver-descriptor"
#define kDriverProperty			"driver,AAPL,MacOS,PowerPC"
#define kDriverPtrProperty		"driver-ptr"
#define kSlotProperty			"AAPL,slot-name"

/*	-------------------------------------------------------------------------
	Maximum # of services support by Open Transport.  If your module
	exports more than this # of services, Open Transport will not be
	able to use the module.
	------------------------------------------------------------------------- */

enum
{
	kMaxServices				= 20
};

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#endif	/* __OPENTPTPCISUPPORT__ */
