{
     File:       DriverSynchronization.p
 
     Contains:   Driver Synchronization Interfaces.
 
     Version:    Technology: MacOS 8
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT DriverSynchronization;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DRIVERSYNCHRONIZATION__}
{$SETC __DRIVERSYNCHRONIZATION__ := 1}

{$I+}
{$SETC DriverSynchronizationIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$IFC CALL_NOT_IN_CARBON }
{
 *  SynchronizeIO()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SynchronizeIO; C;
{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  CompareAndSwap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CompareAndSwap(oldVvalue: UInt32; newValue: UInt32; VAR OldValueAdr: UInt32): BOOLEAN; C;

{
 *  TestAndClear()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TestAndClear(bit: UInt32; VAR startAddress: UInt8): BOOLEAN; C;

{
 *  TestAndSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TestAndSet(bit: UInt32; VAR startAddress: UInt8): BOOLEAN; C;

{
 *  IncrementAtomic8()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IncrementAtomic8(VAR value: SInt8): SInt8; C;

{
 *  DecrementAtomic8()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DecrementAtomic8(VAR value: SInt8): SInt8; C;

{
 *  AddAtomic8()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AddAtomic8(amount: SInt32; VAR value: SInt8): SInt8; C;

{
 *  BitAndAtomic8()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION BitAndAtomic8(mask: UInt32; VAR value: UInt8): ByteParameter; C;

{
 *  BitOrAtomic8()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION BitOrAtomic8(mask: UInt32; VAR value: UInt8): ByteParameter; C;

{
 *  BitXorAtomic8()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION BitXorAtomic8(mask: UInt32; VAR value: UInt8): ByteParameter; C;

{
 *  IncrementAtomic16()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IncrementAtomic16(VAR value: SInt16): SInt16; C;

{
 *  DecrementAtomic16()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DecrementAtomic16(VAR value: SInt16): SInt16; C;

{
 *  AddAtomic16()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AddAtomic16(amount: SInt32; VAR value: SInt16): SInt16; C;

{
 *  BitAndAtomic16()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION BitAndAtomic16(mask: UInt32; VAR value: UInt16): UInt16; C;

{
 *  BitOrAtomic16()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION BitOrAtomic16(mask: UInt32; VAR value: UInt16): UInt16; C;

{
 *  BitXorAtomic16()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION BitXorAtomic16(mask: UInt32; VAR value: UInt16): UInt16; C;

{
 *  IncrementAtomic()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IncrementAtomic(VAR value: SInt32): SInt32; C;

{
 *  DecrementAtomic()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DecrementAtomic(VAR value: SInt32): SInt32; C;

{
 *  AddAtomic()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AddAtomic(amount: SInt32; VAR value: SInt32): SInt32; C;

{
 *  BitAndAtomic()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION BitAndAtomic(mask: UInt32; VAR value: UInt32): UInt32; C;

{
 *  BitOrAtomic()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION BitOrAtomic(mask: UInt32; VAR value: UInt32): UInt32; C;

{
 *  BitXorAtomic()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION BitXorAtomic(mask: UInt32; VAR value: UInt32): UInt32; C;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DriverSynchronizationIncludes}

{$ENDC} {__DRIVERSYNCHRONIZATION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
