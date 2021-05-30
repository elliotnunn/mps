{
     File:       KeychainCore.p
 
     Contains:   Keychain low-level Interfaces
 
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
 UNIT KeychainCore;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __KEYCHAINCORE__}
{$SETC __KEYCHAINCORE__ := 1}

{$I+}
{$SETC KeychainCoreIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __ALIASES__}
{$I Aliases.p}
{$ENDC}
{$IFC UNDEFINED __CODEFRAGMENTS__}
{$I CodeFragments.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __PROCESSES__}
{$I Processes.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Data structures and types }

TYPE
	SecKeychainRef    = ^LONGINT; { an opaque 32-bit type }
	SecKeychainRefPtr = ^SecKeychainRef;  { when a VAR xx:SecKeychainRef parameter can be nil, it is changed to xx: SecKeychainRefPtr }
	SecKeychainItemRef    = ^LONGINT; { an opaque 32-bit type }
	SecKeychainItemRefPtr = ^SecKeychainItemRef;  { when a VAR xx:SecKeychainItemRef parameter can be nil, it is changed to xx: SecKeychainItemRefPtr }
	SecKeychainSearchRef    = ^LONGINT; { an opaque 32-bit type }
	SecKeychainSearchRefPtr = ^SecKeychainSearchRef;  { when a VAR xx:SecKeychainSearchRef parameter can be nil, it is changed to xx: SecKeychainSearchRefPtr }
	SecKeychainAttrType					= OSType;
	SecKeychainStatus					= UInt32;
	SecKeychainAttributePtr = ^SecKeychainAttribute;
	SecKeychainAttribute = RECORD
		tag:					SecKeychainAttrType;					{  4-byte attribute tag  }
		length:					UInt32;									{  Length of attribute data  }
		data:					Ptr;									{  Pointer to attribute data  }
	END;

	SecKeychainAttributeListPtr = ^SecKeychainAttributeList;
	SecKeychainAttributeList = RECORD
		count:					UInt32;									{  How many attributes in the array  }
		attr:					SecKeychainAttributePtr;				{  Pointer to first attribute in array  }
	END;

	KCRef								= SecKeychainRef;
	KCItemRef							= SecKeychainItemRef;
	KCSearchRef							= SecKeychainSearchRef;
	KCRefPtr							= ^KCRef;
	KCItemRefPtr						= ^KCItemRef;
	KCSearchRefPtr						= ^KCSearchRef;
	KCAttribute							= SecKeychainAttribute;
	KCAttributePtr 						= ^KCAttribute;
	KCAttributeList						= SecKeychainAttributeList;
	KCAttributeListPtr 					= ^KCAttributeList;
	KCAttrType							= SecKeychainAttrType;
	KCStatus							= SecKeychainStatus;
	KCEvent 					= UInt16;
CONST
	kIdleKCEvent				= 0;							{  null event  }
	kLockKCEvent				= 1;							{  a keychain was locked  }
	kUnlockKCEvent				= 2;							{  a keychain was unlocked  }
	kAddKCEvent					= 3;							{  an item was added to a keychain  }
	kDeleteKCEvent				= 4;							{  an item was deleted from a keychain  }
	kUpdateKCEvent				= 5;							{  an item was updated  }
	kPasswordChangedKCEvent		= 6;							{  the keychain identity was changed  }
	kSystemKCEvent				= 8;							{  the keychain client can process events  }
	kDefaultChangedKCEvent		= 9;							{  the default keychain was changed  }
	kDataAccessKCEvent			= 10;							{  a process has accessed a keychain item's data  }
	kKeychainListChangedKCEvent	= 11;							{  the list of keychains has changed  }


TYPE
	KCEventMask 				= UInt16;
CONST
	kIdleKCEventMask			= $01;
	kLockKCEventMask			= $02;
	kUnlockKCEventMask			= $04;
	kAddKCEventMask				= $08;
	kDeleteKCEventMask			= $10;
	kUpdateKCEventMask			= $20;
	kPasswordChangedKCEventMask	= $40;
	kSystemEventKCEventMask		= $0100;
	kDefaultChangedKCEventMask	= $0200;
	kDataAccessKCEventMask		= $0400;
	kEveryKCEventMask			= $FFFF;						{  all of the above }


TYPE
	AFPServerSignature					= PACKED ARRAY [0..15] OF UInt8;
	KCPublicKeyHash						= PACKED ARRAY [0..19] OF UInt8;
	KCCallbackInfoPtr = ^KCCallbackInfo;
	KCCallbackInfo = RECORD
		version:				UInt32;
		item:					KCItemRef;
		processID:				ProcessSerialNumber;
		event:					EventRecord;
		keychain:				KCRef;
	END;


CONST
	kUnlockStateKCStatus		= 1;
	kRdPermKCStatus				= 2;
	kWrPermKCStatus				= 4;


	kCertificateKCItemClass		= 'cert';						{  Certificate  }
	kAppleSharePasswordKCItemClass = 'ashp';					{  Appleshare password  }
	kInternetPasswordKCItemClass = 'inet';						{  Internet password  }
	kGenericPasswordKCItemClass	= 'genp';						{  Generic password  }


TYPE
	KCItemClass							= FourCharCode;

CONST
																{  Common attributes  }
	kClassKCItemAttr			= 'clas';						{  Item class (KCItemClass)  }
	kCreationDateKCItemAttr		= 'cdat';						{  Date the item was created (UInt32)  }
	kModDateKCItemAttr			= 'mdat';						{  Last time the item was updated (UInt32)  }
	kDescriptionKCItemAttr		= 'desc';						{  User-visible description string (string)  }
	kCommentKCItemAttr			= 'icmt';						{  User's comment about the item (string)  }
	kCreatorKCItemAttr			= 'crtr';						{  Item's creator (OSType)  }
	kTypeKCItemAttr				= 'type';						{  Item's type (OSType)  }
	kScriptCodeKCItemAttr		= 'scrp';						{  Script code for all strings (ScriptCode)  }
	kLabelKCItemAttr			= 'labl';						{  Item label (string)  }
	kInvisibleKCItemAttr		= 'invi';						{  Invisible (boolean)  }
	kNegativeKCItemAttr			= 'nega';						{  Negative (boolean)  }
	kCustomIconKCItemAttr		= 'cusi';						{  Custom icon (boolean)  }
	kAccountKCItemAttr			= 'acct';						{  User account (string)  }
																{  Unique Generic password attributes  }
	kServiceKCItemAttr			= 'svce';						{  Service (string)  }
	kGenericKCItemAttr			= 'gena';						{  User-defined attribute (untyped bytes)  }
																{  Unique Internet password attributes  }
	kSecurityDomainKCItemAttr	= 'sdmn';						{  Security domain (string)  }
	kServerKCItemAttr			= 'srvr';						{  Server's domain name or IP address (string)  }
	kAuthTypeKCItemAttr			= 'atyp';						{  Authentication Type (KCAuthType)  }
	kPortKCItemAttr				= 'port';						{  Port (UInt16)  }
	kPathKCItemAttr				= 'path';						{  Path (string)  }
																{  Unique Appleshare password attributes  }
	kVolumeKCItemAttr			= 'vlme';						{  Volume (string)  }
	kAddressKCItemAttr			= 'addr';						{  Server address (IP or domain name) or zone name (string)  }
	kSignatureKCItemAttr		= 'ssig';						{  Server signature block (AFPServerSignature)  }
																{  Unique AppleShare and Internet attributes  }
	kProtocolKCItemAttr			= 'ptcl';						{  Protocol (KCProtocolType)  }
																{  Certificate attributes  }
	kSubjectKCItemAttr			= 'subj';						{  Subject distinguished name (DER-encoded data)  }
	kCommonNameKCItemAttr		= 'cn  ';						{  Common Name (UTF8-encoded string)  }
	kIssuerKCItemAttr			= 'issu';						{  Issuer distinguished name (DER-encoded data)  }
	kSerialNumberKCItemAttr		= 'snbr';						{  Certificate serial number (DER-encoded data)  }
	kEMailKCItemAttr			= 'mail';						{  E-mail address (ASCII-encoded string)  }
	kPublicKeyHashKCItemAttr	= 'hpky';						{  Hash of public key (KCPublicKeyHash), 20 bytes max.  }
	kIssuerURLKCItemAttr		= 'iurl';						{  URL of the certificate issuer (ASCII-encoded string)  }
																{  Shared by keys and certificates  }
	kEncryptKCItemAttr			= 'encr';						{  Encrypt (Boolean)  }
	kDecryptKCItemAttr			= 'decr';						{  Decrypt (Boolean)  }
	kSignKCItemAttr				= 'sign';						{  Sign (Boolean)  }
	kVerifyKCItemAttr			= 'veri';						{  Verify (Boolean)  }
	kWrapKCItemAttr				= 'wrap';						{  Wrap (Boolean)  }
	kUnwrapKCItemAttr			= 'unwr';						{  Unwrap (Boolean)  }
	kStartDateKCItemAttr		= 'sdat';						{  Start Date (UInt32)  }
	kEndDateKCItemAttr			= 'edat';						{  End Date (UInt32)  }


TYPE
	KCItemAttr							= FourCharCode;

CONST
	kKCAuthTypeNTLM				= 'ntlm';
	kKCAuthTypeMSN				= 'msna';
	kKCAuthTypeDPA				= 'dpaa';
	kKCAuthTypeRPA				= 'rpaa';
	kKCAuthTypeHTTPDigest		= 'httd';
	kKCAuthTypeDefault			= 'dflt';


TYPE
	KCAuthType							= FourCharCode;

CONST
	kKCProtocolTypeFTP			= 'ftp ';
	kKCProtocolTypeFTPAccount	= 'ftpa';
	kKCProtocolTypeHTTP			= 'http';
	kKCProtocolTypeIRC			= 'irc ';
	kKCProtocolTypeNNTP			= 'nntp';
	kKCProtocolTypePOP3			= 'pop3';
	kKCProtocolTypeSMTP			= 'smtp';
	kKCProtocolTypeSOCKS		= 'sox ';
	kKCProtocolTypeIMAP			= 'imap';
	kKCProtocolTypeLDAP			= 'ldap';
	kKCProtocolTypeAppleTalk	= 'atlk';
	kKCProtocolTypeAFP			= 'afp ';
	kKCProtocolTypeTelnet		= 'teln';


TYPE
	KCProtocolType						= FourCharCode;
	KCCertAddOptions 			= UInt32;
CONST
	kSecOptionReserved			= $000000FF;					{  First byte reserved for SecOptions flags  }
	kCertUsageShift				= 8;							{  start at bit 8  }
	kCertUsageSigningAdd		= $0100;
	kCertUsageSigningAskAndAdd	= $0200;
	kCertUsageVerifyAdd			= $0400;
	kCertUsageVerifyAskAndAdd	= $0800;
	kCertUsageEncryptAdd		= $1000;
	kCertUsageEncryptAskAndAdd	= $2000;
	kCertUsageDecryptAdd		= $4000;
	kCertUsageDecryptAskAndAdd	= $8000;
	kCertUsageKeyExchAdd		= $00010000;
	kCertUsageKeyExchAskAndAdd	= $00020000;
	kCertUsageRootAdd			= $00040000;
	kCertUsageRootAskAndAdd		= $00080000;
	kCertUsageSSLAdd			= $00100000;
	kCertUsageSSLAskAndAdd		= $00200000;
	kCertUsageAllAdd			= $7FFFFF00;


TYPE
	KCVerifyStopOn 				= UInt16;
CONST
	kPolicyKCStopOn				= 0;
	kNoneKCStopOn				= 1;
	kFirstPassKCStopOn			= 2;
	kFirstFailKCStopOn			= 3;


TYPE
	KCCertSearchOptions 		= UInt32;
CONST
	kCertSearchShift			= 0;							{  start at bit 0  }
	kCertSearchSigningIgnored	= 0;
	kCertSearchSigningAllowed	= $01;
	kCertSearchSigningDisallowed = $02;
	kCertSearchSigningMask		= $03;
	kCertSearchVerifyIgnored	= 0;
	kCertSearchVerifyAllowed	= $04;
	kCertSearchVerifyDisallowed	= $08;
	kCertSearchVerifyMask		= $0C;
	kCertSearchEncryptIgnored	= 0;
	kCertSearchEncryptAllowed	= $10;
	kCertSearchEncryptDisallowed = $20;
	kCertSearchEncryptMask		= $30;
	kCertSearchDecryptIgnored	= 0;
	kCertSearchDecryptAllowed	= $40;
	kCertSearchDecryptDisallowed = $80;
	kCertSearchDecryptMask		= $C0;
	kCertSearchWrapIgnored		= 0;
	kCertSearchWrapAllowed		= $0100;
	kCertSearchWrapDisallowed	= $0200;
	kCertSearchWrapMask			= $0300;
	kCertSearchUnwrapIgnored	= 0;
	kCertSearchUnwrapAllowed	= $0400;
	kCertSearchUnwrapDisallowed	= $0800;
	kCertSearchUnwrapMask		= $0C00;
	kCertSearchPrivKeyRequired	= $1000;
	kCertSearchAny				= 0;

	{	 Other constants 	}
	kAnyPort					= 0;

	kAnyProtocol				= 0;
	kAnyAuthType				= 0;

	{	 Opening and getting information about the Keychain Manager 	}
	{
	 *  KCGetKeychainManagerVersion()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         not available
	 	}
FUNCTION KCGetKeychainManagerVersion(VAR returnVers: UInt32): OSStatus;

{$IFC TARGET_RT_MAC_CFM }
{
        KeychainManagerAvailable() is a macro/inline available only in C/C++.  
        To get the same functionality from pascal or assembly, you need
        to test if KCGetKeychainManagerVersion function is not NULL.  For instance:
        
            gKeychainManagerAvailable = FALSE;
            IF @KCGetKeychainManagerVersion <> kUnresolvedCFragSymbolAddress THEN
                gKeychainManagerAvailable = TRUE;
            END
    
    }
{$ELSEC}
  {$IFC TARGET_RT_MAC_MACHO }
  {$ENDC}
{$ENDC}

{ Creating references to keychains }
{
 *  KCMakeKCRefFromFSSpec()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCMakeKCRefFromFSSpec(VAR keychainFSSpec: FSSpec; VAR keychain: KCRef): OSStatus;

{
 *  KCMakeKCRefFromAlias()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCMakeKCRefFromAlias(keychainAlias: AliasHandle; VAR keychain: KCRef): OSStatus;

{
 *  KCMakeAliasFromKCRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCMakeAliasFromKCRef(keychain: KCRef; VAR keychainAlias: AliasHandle): OSStatus;

{
 *  KCReleaseKeychain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCReleaseKeychain(VAR keychain: KCRef): OSStatus;

{ Specifying the default keychain }
{
 *  KCGetDefaultKeychain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCGetDefaultKeychain(VAR keychain: KCRef): OSStatus;

{
 *  KCSetDefaultKeychain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCSetDefaultKeychain(keychain: KCRef): OSStatus;

{ Getting information about a keychain }
{
 *  KCGetStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCGetStatus(keychain: KCRef; VAR keychainStatus: UInt32): OSStatus;

{
 *  KCGetKeychain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCGetKeychain(item: KCItemRef; VAR keychain: KCRef): OSStatus;

{
 *  KCGetKeychainName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCGetKeychainName(keychain: KCRef; keychainName: StringPtr): OSStatus;

{ Enumerating available keychains }
{
 *  KCCountKeychains()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCCountKeychains: UInt16;

{
 *  KCGetIndKeychain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCGetIndKeychain(index: UInt16; VAR keychain: KCRef): OSStatus;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	KCCallbackProcPtr = FUNCTION(keychainEvent: KCEvent; VAR info: KCCallbackInfo; userContext: UNIV Ptr): OSStatus;
{$ELSEC}
	KCCallbackProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	KCCallbackUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	KCCallbackUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppKCCallbackProcInfo = $00000FB0;
	{
	 *  NewKCCallbackUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewKCCallbackUPP(userRoutine: KCCallbackProcPtr): KCCallbackUPP; { old name was NewKCCallbackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeKCCallbackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeKCCallbackUPP(userUPP: KCCallbackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeKCCallbackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeKCCallbackUPP(keychainEvent: KCEvent; VAR info: KCCallbackInfo; userContext: UNIV Ptr; userRoutine: KCCallbackUPP): OSStatus; { old name was CallKCCallbackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{ Keychain Manager callbacks }
{
 *  KCAddCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCAddCallback(callbackProc: KCCallbackUPP; eventMask: KCEventMask; userContext: UNIV Ptr): OSStatus;

{
 *  KCRemoveCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCRemoveCallback(callbackProc: KCCallbackUPP): OSStatus;


{ Creating and editing a keychain item }
{
 *  KCNewItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCNewItem(itemClass: KCItemClass; itemCreator: OSType; length: UInt32; data: UNIV Ptr; VAR item: KCItemRef): OSStatus;

{
 *  KCSetAttribute()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCSetAttribute(item: KCItemRef; VAR attr: KCAttribute): OSStatus;

{
 *  KCGetAttribute()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCGetAttribute(item: KCItemRef; VAR attr: KCAttribute; VAR actualLength: UInt32): OSStatus;

{
 *  KCSetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCSetData(item: KCItemRef; length: UInt32; data: UNIV Ptr): OSStatus;

{ Managing keychain items }
{
 *  KCUpdateItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCUpdateItem(item: KCItemRef): OSStatus;

{
 *  KCReleaseItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCReleaseItem(VAR item: KCItemRef): OSStatus;

{
 *  KCCopyItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCCopyItem(item: KCItemRef; destKeychain: KCRef; VAR copy: KCItemRef): OSStatus;

{ Searching and enumerating keychain items }
{
 *  KCFindFirstItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCFindFirstItem(keychain: KCRef; attrList: {Const}KCAttributeListPtr; VAR search: KCSearchRef; VAR item: KCItemRef): OSStatus;

{
 *  KCFindNextItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCFindNextItem(search: KCSearchRef; VAR item: KCItemRef): OSStatus;

{
 *  KCReleaseSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KCReleaseSearch(VAR search: KCSearchRef): OSStatus;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := KeychainCoreIncludes}

{$ENDC} {__KEYCHAINCORE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
