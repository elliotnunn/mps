/*
 	File:		PCI.h
 
 	Contains:	Access Routines to PCI Config and I/O registers
 
 	Version:	Technology:	PowerSurge 1.0.2.
 				Package:	Universal Interfaces 2.1.3
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __PCI__
#define __PCI__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __NAMEREGISTRY__
#include <NameRegistry.h>
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

#define kPCIAssignedAddressProperty "assigned-addresses"

enum {
	kPCIRelocatableSpace		= 0x80,
	kPCIPrefetchableSpace		= 0x40,
	kPCIAliasedSpace			= 0x20,
	kPCIAddressTypeCodeMask		= 0x03,
	kPCIConfigSpace				= 0,
	kPCIIOSpace					= 1,
	kPCI32BitMemorySpace		= 2,
	kPCI64BitMemorySpace		= 3
};

typedef UInt8 PCIAddressSpaceFlags;


enum {
	kPCIDeviceNumberMask		= 0x1F,
	kPCIFunctionNumberMask		= 0x07
};

typedef UInt8 PCIDeviceFunction;

typedef UInt8 PCIBusNumber;

typedef UInt8 PCIRegisterNumber;

struct PCIAssignedAddress {
	PCIAddressSpaceFlags			addressSpaceFlags;
	PCIBusNumber					busNumber;
	PCIDeviceFunction				deviceFunctionNumber;
	PCIRegisterNumber				registerNumber;
	UnsignedWide					address;
	UnsignedWide					size;
};
typedef struct PCIAssignedAddress PCIAssignedAddress, *PCIAssignedAddressPtr;

#define GetPCIIsRelocatable( AssignedAddressPtr )		((AssignedAddressPtr)->addressSpaceFlags & kPCIRelocatableSpace)
#define GetPCIIsPrefetchable( AssignedAddressPtr )		((AssignedAddressPtr)->addressSpaceFlags & kPCIPrefetchableSpace)
#define GetPCIIsAliased( AssignedAddressPtr )			((AssignedAddressPtr)->addressSpaceFlags & kPCIAliasedSpace)
#define GetPCIAddressSpaceType( AssignedAddressPtr )	((AssignedAddressPtr)->addressSpaceFlags & kPCIAddressTypeCodeMask)
#define GetPCIBusNumber( AssignedAddressPtr )			((AssignedAddressPtr)->busNumber)
#define GetPCIDeviceNumber( AssignedAddressPtr )		(((AssignedAddressPtr)->deviceFunctionNumber >> 3) & kPCIDeviceNumberMask)
#define GetPCIFunctionNumber( AssignedAddressPtr )		((AssignedAddressPtr)->deviceFunctionNumber & kPCIFunctionNumberMask)
#define GetPCIRegisterNumber( AssignedAddressPtr )		((AssignedAddressPtr)->registerNumber)

#if !GENERATINGCFM
#pragma parameter __D0 EndianSwap16Bit(__D0)
#endif
extern pascal UInt16 EndianSwap16Bit(UInt16 data16)
 ONEWORDINLINE(0xE158);

#if !GENERATINGCFM
#pragma parameter __D0 EndianSwap32Bit(__D0)
#endif
extern pascal UInt32 EndianSwap32Bit(UInt32 data32)
 THREEWORDINLINE(0xE158, 0x4840, 0xE158);
extern pascal OSErr ExpMgrConfigReadByte(RegEntryIDPtr node, LogicalAddress configAddr, UInt8 *valuePtr)
 THREEWORDINLINE(0x303C, 0x0620, 0xAAF3);
extern pascal OSErr ExpMgrConfigReadWord(RegEntryIDPtr node, LogicalAddress configAddr, UInt16 *valuePtr)
 THREEWORDINLINE(0x303C, 0x0621, 0xAAF3);
extern pascal OSErr ExpMgrConfigReadLong(RegEntryIDPtr node, LogicalAddress configAddr, UInt32 *valuePtr)
 THREEWORDINLINE(0x303C, 0x0622, 0xAAF3);
extern pascal OSErr ExpMgrConfigWriteByte(RegEntryIDPtr node, LogicalAddress configAddr, UInt8 value)
 THREEWORDINLINE(0x303C, 0x0523, 0xAAF3);
extern pascal OSErr ExpMgrConfigWriteWord(RegEntryIDPtr node, LogicalAddress configAddr, UInt16 value)
 THREEWORDINLINE(0x303C, 0x0524, 0xAAF3);
extern pascal OSErr ExpMgrConfigWriteLong(RegEntryIDPtr node, LogicalAddress configAddr, UInt32 value)
 THREEWORDINLINE(0x303C, 0x0625, 0xAAF3);
extern pascal OSErr ExpMgrIOReadByte(RegEntryIDPtr node, LogicalAddress ioAddr, UInt8 *valuePtr)
 THREEWORDINLINE(0x303C, 0x0626, 0xAAF3);
extern pascal OSErr ExpMgrIOReadWord(RegEntryIDPtr node, LogicalAddress ioAddr, UInt16 *valuePtr)
 THREEWORDINLINE(0x303C, 0x0627, 0xAAF3);
extern pascal OSErr ExpMgrIOReadLong(RegEntryIDPtr node, LogicalAddress ioAddr, UInt32 *valuePtr)
 THREEWORDINLINE(0x303C, 0x0628, 0xAAF3);
extern pascal OSErr ExpMgrIOWriteByte(RegEntryIDPtr node, LogicalAddress ioAddr, UInt8 value)
 THREEWORDINLINE(0x303C, 0x0529, 0xAAF3);
extern pascal OSErr ExpMgrIOWriteWord(RegEntryIDPtr node, LogicalAddress ioAddr, UInt16 value)
 THREEWORDINLINE(0x303C, 0x052A, 0xAAF3);
extern pascal OSErr ExpMgrIOWriteLong(RegEntryIDPtr node, LogicalAddress ioAddr, UInt32 value)
 THREEWORDINLINE(0x303C, 0x062B, 0xAAF3);
extern pascal OSErr ExpMgrInterruptAcknowledgeReadByte(RegEntryIDPtr entry, UInt8 *valuePtr)
 THREEWORDINLINE(0x303C, 0x0411, 0xAAF3);
extern pascal OSErr ExpMgrInterruptAcknowledgeReadWord(RegEntryIDPtr entry, UInt16 *valuePtr)
 THREEWORDINLINE(0x303C, 0x0412, 0xAAF3);
extern pascal OSErr ExpMgrInterruptAcknowledgeReadLong(RegEntryIDPtr entry, UInt32 *valuePtr)
 THREEWORDINLINE(0x303C, 0x0413, 0xAAF3);
extern pascal OSErr ExpMgrSpecialCycleWriteLong(RegEntryIDPtr entry, UInt32 value)
 THREEWORDINLINE(0x303C, 0x0419, 0xAAF3);
extern pascal OSErr ExpMgrSpecialCycleBroadcastLong(UInt32 value)
 THREEWORDINLINE(0x303C, 0x021A, 0xAAF3);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __PCI__ */
