{
     File:       KeychainHI.p
 
     Contains:   Keychain API's with Human Interfaces
 
     Version:    Technology: Keychain 3.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT KeychainHI;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __KEYCHAINHI__}
{$SETC __KEYCHAINHI__ := 1}

{$I+}
{$SETC KeychainHIIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __KEYCHAINCORE__}
{$I KeychainCore.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}
{$IFC UNDEFINED __CFARRAY__}
{$I CFArray.p}
{$ENDC}
{$IFC UNDEFINED __CFDATE__}
{$I CFDate.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Managing the Human Interface }
{
 *  KCSetInteractionAllowed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCSetInteractionAllowed(state: BOOLEAN): OSStatus;

{
 *  KCIsInteractionAllowed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCIsInteractionAllowed: BOOLEAN;

{ Locking and unlocking a keychain }
{
 *  KCUnlock()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCUnlock(keychain: KCRef; password: StringPtr): OSStatus;

{
 *  KCLock()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCLock(keychain: KCRef): OSStatus;

{ Creating a new keychain }
{
 *  KCCreateKeychain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCCreateKeychain(password: StringPtr; keychain: KCRefPtr): OSStatus;


{ Changing a keychain's settings }
{
 *  KCChangeSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCChangeSettings(keychain: KCRef): OSStatus;

{ Managing keychain items }
{
 *  KCAddItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCAddItem(item: KCItemRef): OSStatus;

{
 *  KCDeleteItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCDeleteItem(item: KCItemRef): OSStatus;

{
 *  KCGetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCGetData(item: KCItemRef; maxLength: UInt32; data: UNIV Ptr; VAR actualLength: UInt32): OSStatus;

{ Storing and retrieving AppleShare passwords }
{
 *  KCAddAppleSharePassword()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCAddAppleSharePassword(VAR serverSignature: AFPServerSignature; serverAddress: StringPtr; serverName: StringPtr; volumeName: StringPtr; accountName: StringPtr; passwordLength: UInt32; passwordData: UNIV Ptr; item: KCItemRefPtr): OSStatus;

{
 *  KCFindAppleSharePassword()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCFindAppleSharePassword(VAR serverSignature: AFPServerSignature; serverAddress: StringPtr; serverName: StringPtr; volumeName: StringPtr; accountName: StringPtr; maxLength: UInt32; passwordData: UNIV Ptr; VAR actualLength: UInt32; item: KCItemRefPtr): OSStatus;

{ Storing and retrieving Internet passwords }
{
 *  KCAddInternetPassword()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCAddInternetPassword(serverName: StringPtr; securityDomain: StringPtr; accountName: StringPtr; port: UInt16; protocol: OSType; authType: OSType; passwordLength: UInt32; passwordData: UNIV Ptr; item: KCItemRefPtr): OSStatus;

{
 *  KCAddInternetPasswordWithPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCAddInternetPasswordWithPath(serverName: StringPtr; securityDomain: StringPtr; accountName: StringPtr; path: StringPtr; port: UInt16; protocol: OSType; authType: OSType; passwordLength: UInt32; passwordData: UNIV Ptr; item: KCItemRefPtr): OSStatus;

{
 *  KCFindInternetPassword()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCFindInternetPassword(serverName: StringPtr; securityDomain: StringPtr; accountName: StringPtr; port: UInt16; protocol: OSType; authType: OSType; maxLength: UInt32; passwordData: UNIV Ptr; VAR actualLength: UInt32; item: KCItemRefPtr): OSStatus;

{
 *  KCFindInternetPasswordWithPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCFindInternetPasswordWithPath(serverName: StringPtr; securityDomain: StringPtr; accountName: StringPtr; path: StringPtr; port: UInt16; protocol: OSType; authType: OSType; maxLength: UInt32; passwordData: UNIV Ptr; VAR actualLength: UInt32; item: KCItemRefPtr): OSStatus;

{ Storing and retrieving other types of passwords }
{
 *  KCAddGenericPassword()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCAddGenericPassword(serviceName: StringPtr; accountName: StringPtr; passwordLength: UInt32; passwordData: UNIV Ptr; item: KCItemRefPtr): OSStatus;

{
 *  KCFindGenericPassword()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCFindGenericPassword(serviceName: StringPtr; accountName: StringPtr; maxLength: UInt32; passwordData: UNIV Ptr; VAR actualLength: UInt32; item: KCItemRefPtr): OSStatus;



{ Working with certificates }
{$IFC CALL_NOT_IN_CARBON }
{
 *  KCFindX509Certificates()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION KCFindX509Certificates(keychain: KCRef; name: CFStringRef; emailAddress: CFStringRef; options: KCCertSearchOptions; certificateItems: CFMutableArrayRefPtr): OSStatus;

{
 *  KCChooseCertificate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION KCChooseCertificate(items: CFArrayRef; VAR certificate: KCItemRef; policyOIDs: CFArrayRef; stopOn: KCVerifyStopOn): OSStatus;


{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := KeychainHIIncludes}

{$ENDC} {__KEYCHAINHI__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
