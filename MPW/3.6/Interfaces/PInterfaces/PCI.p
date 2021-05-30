{
     File:       PCI.p
 
     Contains:   PCI Bus Interfaces.
 
     Version:    Technology: PowerSurge 1.0.2
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1993-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT PCI;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PCI__}
{$SETC __PCI__ := 1}

{$I+}
{$SETC PCIIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __NAMEREGISTRY__}
{$I NameRegistry.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{  Definitions for the PCI Config Registers }

CONST
	kPCIConfigVendorID			= $00;
	kPCIConfigDeviceID			= $02;
	kPCIConfigCommand			= $04;
	kPCIConfigStatus			= $06;
	kPCIConfigRevisionID		= $08;
	kPCIConfigClassCode			= $09;
	kPCIConfigCacheLineSize		= $0C;
	kPCIConfigLatencyTimer		= $0D;
	kPCIConfigHeaderType		= $0E;
	kPCIConfigBIST				= $0F;
	kPCIConfigBaseAddress0		= $10;
	kPCIConfigBaseAddress1		= $14;
	kPCIConfigBaseAddress2		= $18;
	kPCIConfigBaseAddress3		= $1C;
	kPCIConfigBaseAddress4		= $20;
	kPCIConfigBaseAddress5		= $24;
	kPCIConfigCardBusCISPtr		= $28;
	kPCIConfigSubSystemVendorID	= $2C;
	kPCIConfigSubSystemID		= $2E;
	kPCIConfigExpansionROMBase	= $30;
	kPCIConfigCapabilitiesPtr	= $34;
	kPCIConfigInterruptLine		= $3C;
	kPCIConfigInterruptPin		= $3D;
	kPCIConfigMinimumGrant		= $3E;
	kPCIConfigMaximumLatency	= $3F;

	{  Definitions for the Capabilities PCI Config Register }
	kPCICapabilityIDOffset		= $00;
	kPCINextCapabilityOffset	= $01;
	kPCIPowerManagementCapability = $01;
	kPCIAGPCapability			= $02;

	{  Types and structures for accessing the PCI Assigned-Address property. }

	kPCIRelocatableSpace		= $80;
	kPCIPrefetchableSpace		= $40;
	kPCIAliasedSpace			= $20;
	kPCIAddressTypeCodeMask		= $03;
	kPCIConfigSpace				= 0;
	kPCIIOSpace					= 1;
	kPCI32BitMemorySpace		= 2;
	kPCI64BitMemorySpace		= 3;


TYPE
	PCIAddressSpaceFlags				= UInt8;

CONST
	kPCIDeviceNumberMask		= $1F;
	kPCIFunctionNumberMask		= $07;


TYPE
	PCIDeviceFunction					= UInt8;
	PCIBusNumber						= UInt8;
	PCIRegisterNumber					= UInt8;
	PCIAssignedAddressPtr = ^PCIAssignedAddress;
	PCIAssignedAddress = PACKED RECORD
		addressSpaceFlags:		PCIAddressSpaceFlags;
		busNumber:				PCIBusNumber;
		deviceFunctionNumber:	PCIDeviceFunction;
		registerNumber:			PCIRegisterNumber;
		address:				UnsignedWide;
		size:					UnsignedWide;
	END;


{$IFC CALL_NOT_IN_CARBON }
	{
	 *  EndianSwap16Bit()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in PCILib 1.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION EndianSwap16Bit(data16: UInt16): UInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $E158, $3E80;
	{$ENDC}

{
 *  EndianSwap32Bit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCILib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianSwap32Bit(data32: UInt32): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $E158, $4840, $E158, $2E80;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  ExpMgrConfigReadByte()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCILib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ExpMgrConfigReadByte(node: RegEntryIDPtr; configAddr: LogicalAddress; VAR valuePtr: UInt8): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0620, $AAF3;
	{$ENDC}

{
 *  ExpMgrConfigReadWord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCILib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ExpMgrConfigReadWord(node: RegEntryIDPtr; configAddr: LogicalAddress; VAR valuePtr: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0621, $AAF3;
	{$ENDC}

{
 *  ExpMgrConfigReadLong()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCILib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ExpMgrConfigReadLong(node: RegEntryIDPtr; configAddr: LogicalAddress; VAR valuePtr: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0622, $AAF3;
	{$ENDC}

{
 *  ExpMgrConfigWriteByte()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCILib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ExpMgrConfigWriteByte(node: RegEntryIDPtr; configAddr: LogicalAddress; value: ByteParameter): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0523, $AAF3;
	{$ENDC}

{
 *  ExpMgrConfigWriteWord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCILib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ExpMgrConfigWriteWord(node: RegEntryIDPtr; configAddr: LogicalAddress; value: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0524, $AAF3;
	{$ENDC}

{
 *  ExpMgrConfigWriteLong()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCILib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ExpMgrConfigWriteLong(node: RegEntryIDPtr; configAddr: LogicalAddress; value: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0625, $AAF3;
	{$ENDC}

{
 *  ExpMgrIOReadByte()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCILib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ExpMgrIOReadByte(node: RegEntryIDPtr; ioAddr: LogicalAddress; VAR valuePtr: UInt8): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0626, $AAF3;
	{$ENDC}

{
 *  ExpMgrIOReadWord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCILib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ExpMgrIOReadWord(node: RegEntryIDPtr; ioAddr: LogicalAddress; VAR valuePtr: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0627, $AAF3;
	{$ENDC}

{
 *  ExpMgrIOReadLong()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCILib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ExpMgrIOReadLong(node: RegEntryIDPtr; ioAddr: LogicalAddress; VAR valuePtr: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0628, $AAF3;
	{$ENDC}

{
 *  ExpMgrIOWriteByte()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCILib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ExpMgrIOWriteByte(node: RegEntryIDPtr; ioAddr: LogicalAddress; value: ByteParameter): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0529, $AAF3;
	{$ENDC}

{
 *  ExpMgrIOWriteWord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCILib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ExpMgrIOWriteWord(node: RegEntryIDPtr; ioAddr: LogicalAddress; value: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $052A, $AAF3;
	{$ENDC}

{
 *  ExpMgrIOWriteLong()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCILib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ExpMgrIOWriteLong(node: RegEntryIDPtr; ioAddr: LogicalAddress; value: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $062B, $AAF3;
	{$ENDC}

{
 *  ExpMgrInterruptAcknowledgeReadByte()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCILib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ExpMgrInterruptAcknowledgeReadByte(entry: RegEntryIDPtr; VAR valuePtr: UInt8): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0411, $AAF3;
	{$ENDC}

{
 *  ExpMgrInterruptAcknowledgeReadWord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCILib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ExpMgrInterruptAcknowledgeReadWord(entry: RegEntryIDPtr; VAR valuePtr: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0412, $AAF3;
	{$ENDC}

{
 *  ExpMgrInterruptAcknowledgeReadLong()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCILib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ExpMgrInterruptAcknowledgeReadLong(entry: RegEntryIDPtr; VAR valuePtr: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0413, $AAF3;
	{$ENDC}

{
 *  ExpMgrSpecialCycleWriteLong()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCILib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ExpMgrSpecialCycleWriteLong(entry: RegEntryIDPtr; value: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0419, $AAF3;
	{$ENDC}

{
 *  ExpMgrSpecialCycleBroadcastLong()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCILib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ExpMgrSpecialCycleBroadcastLong(value: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $021A, $AAF3;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PCIIncludes}

{$ENDC} {__PCI__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
