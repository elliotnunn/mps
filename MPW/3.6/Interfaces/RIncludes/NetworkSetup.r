/*
     File:       NetworkSetup.r
 
     Contains:   Network Setup Interfaces
 
     Version:    Technology: 1.3.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1998-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/

#ifndef __NETWORKSETUP_R__
#define __NETWORKSETUP_R__

#ifndef __CONDITIONALMACROS_R__
#include "ConditionalMacros.r"
#endif

#if CALL_NOT_IN_CARBON
#define kCfgErrDatabaseChanged 			(-3290)				/*  database has changed since last call - close and reopen DB */
#define kCfgErrAreaNotFound 			(-3291)				/*  Area doesn't exist */
#define kCfgErrAreaAlreadyExists 		(-3292)				/*  Area already exists */
#define kCfgErrAreaNotOpen 				(-3293)				/*  Area needs to open first */
#define kCfgErrConfigLocked 			(-3294)				/*  Access conflict - retry later */
#define kCfgErrEntityNotFound 			(-3295)				/*  An entity with this name doesn't exist */
#define kCfgErrEntityAlreadyExists 		(-3296)				/*  An entity with this name already exists */
#define kCfgErrPrefsTypeNotFound 		(-3297)				/*  A preference with this prefsType doesn't exist */
#define kCfgErrDataTruncated 			(-3298)				/*  Data truncated when read buffer too small */
#define kCfgErrFileCorrupted 			(-3299)				/*  The database format appears to be corrupted. */
#define kCfgErrFirst 					(-3290)
#define kCfgErrLast 					(-3299)

#define kCfgFreePref 					'free'
#define kCfgClassAnyEntity 				'****'
#define kCfgClassUnknownEntity 			'????'
#define kCfgTypeAnyEntity 				'****'
#define kCfgTypeUnknownEntity 			'????'

#define kCfgIgnoreArea 					1
#define kCfgDontIgnoreArea 				0

#define kOTCfgIgnoreArea 				1
#define kOTCfgDontIgnoreArea 			0

#define kOTCfgDatabaseChanged 			0x10000000			/*  result will be kCfgErrDatabaseChanged, cookie is meaningless */
#define kOTCfgClassNetworkConnection 	'otnc'
#define kOTCfgClassGlobalSettings 		'otgl'
#define kOTCfgClassServer 				'otsv'
#define kOTCfgTypeGeneric 				'otan'
#define kOTCfgTypeAppleTalk 			'atlk'
#define kOTCfgTypeTCPv4 				'tcp4'
#define kOTCfgTypeTCPv6 				'tcp6'
#define kOTCfgTypeDNS 					'dns '
#define kOTCfgTypeRemote 				'ara '
#define kOTCfgTypeDial 					'dial'
#define kOTCfgTypeModem 				'modm'
#define kOTCfgTypeInfrared 				'infr'
#define kOTCfgClassSetOfSettings 		'otsc'
#define kOTCfgTypeSetOfSettings 		'otst'

#define kOTCfgSetsStructPref 			'stru'				/*  CfgSetsStruct */
#define kOTCfgSetsElementPref 			'elem'				/*  CfgSetsElement */
#define kOTCfgSetsVectorPref 			'vect'				/*  CfgSetsVector */

#define kOTCfgSetsFlagActiveBit 		0
#define kOTCfgSetsFlagActiveMask 		0x0001
#define kOTCfgIndexSetsActive 			0
#define kOTCfgIndexSetsEdit 			1
#define kOTCfgIndexSetsLimit 			2					/*     last value, no comma */

#define kOTCfgFlagRecordVersion 		0x01200120
#define kOTCfgProtocolActive 			0x01
#define kOTCfgProtocolMultihoming 		0x00010000
#define kOTCfgProtocolLimit 			0x00010001

#define kOTCfgUserVisibleNamePref 		'pnam'				/*  Pascal string */
#define kOTCfgVersionPref 				'cvrs'				/*  UInt16, values should be 1 */
#define kOTCfgPortUserVisibleNamePref 	'port'				/*  Pascal string */
#define kOTCfgPortUIName 				'otgn'				/*  Pascal String */
#define kOTCfgProtocolUserVisibleNamePref  'prot'			/*  C string (TCP/IP = "tcp", AppleTalk = "ddp", n/a for others) */
#define kOTCfgAdminPasswordPref 		'pwrd'				/*  not to be documented */
#define kOTCfgProtocolOptionsPref 		'opts'				/*  UInt32, protocol specific flags */

#define kOTCfgUserModePref 				'ulvl'				/*  OTCfgUserMode, TCP/IP and AppleTalk only */
#define kOTCfgPrefWindowPositionPref 	'wpos'				/*  Point, global coordinates, TCP/IP, AppleTalk, Infrared only */

#define kOTCfgCompatNamePref 			'cnam'
#define kOTCfgCompatResourceNamePref 	'resn'

#define kOTCfgCompatSelectedPref 		'ccfg'
#define kOTCfgCompatResourceIDPref 		'resi'

#define kOTCfgBasicUserMode 			1
#define kOTCfgAdvancedUserMode 			2
#define kOTCfgAdminUserMode 			3					/*  admin mode is never valid in a preference, here for completeness only */

#define kOTCfgATalkGeneralPref 			'atpf'				/*  OTCfgATalkGeneral */
#define kOTCfgATalkLocksPref 			'lcks'				/*  OTCfgATalkLocks */
#define kOTCfgATalkPortDeviceTypePref 	'ptfm'				/*  OTCfgATalkPortDeviceType */

#define kOTCfgATalkNetworkArchitecturePref  'neta'			/*  OTCfgATalkNetworkArchitecture */
#define kOTCfgATalkInactive 			0
#define kOTCfgATalkDefaultUnloadTimeout  5
#define kOTCfgATalkActive 				0xFF

#define kOTCfgATalkPortLockMask 		0x01
#define kOTCfgATalkZoneLockMask 		0x02
#define kOTCfgATalkAddressLockMask 		0x04
#define kOTCfgATalkConnectionLockMask 	0x08
#define kOTCfgATalkSharingLockMask 		0x10

#define kOTCfgATalkNoBadRouterUpNotification  0x01
#define kOTCfgATalkNoAllNodesTakenNotification  0x02
#define kOTCfgATalkNoFixedNodeTakenNotification  0x04
#define kOTCfgATalkNoInternetAvailableNotification  0x08
#define kOTCfgATalkNoCableRangeChangeNotification  0x10
#define kOTCfgATalkNoRouterDownNotification  0x20
#define kOTCfgATalkNoRouterUpNotification  0x40
#define kOTCfgATalkNoFixedNodeBadNotification  0x80

#define kOTCfgIRGeneralPref 			'atpf'				/*  OTCfgIRGeneral */
#define kOTCfgIRIrDA 					0
#define kOTCfgIRIRTalk 					1

#define kOTCfgTCPInterfacesPref 		'iitf'				/*  OTCfgTCPInterfaces (packed) */
#define kOTCfgTCPDeviceTypePref 		'dtyp'				/*  UInt16 (device type) */
#define kOTCfgTCPRoutersListPref 		'irte'				/*  OTCfgTCPRoutersList */
#define kOTCfgTCPSearchListPref 		'ihst'				/*  OTCfgTCPSearchList (packed) */
#define kOTCfgTCPDNSServersListPref 	'idns'				/*  OTCfgTCPDNSServersList */
#define kOTCfgTCPSearchDomainsPref 		'isdm'				/*  OTCfgTCPSearchDomains */
#define kOTCfgTCPDHCPLeaseInfoPref 		'dclt'				/*  OTCfgTCPDHCPLeaseInfo */
#define kOTCfgTCPDHCPClientIDPref 		'dcid'				/*  DHCP client ID, Pascal string */
#define kOTCfgTCPUnloadAttrPref 		'unld'				/*  OTCfgTCPUnloadAttr */
#define kOTCfgTCPLocksPref 				'stng'				/*  OTCfgTCPLocks */
#define kOTCfgTCPPushBelowIPPref 		'crpt'				/*  single module to push below IP, Pascal string */
#define kOTCfgTCPPushBelowIPListPref 	'blip'				/*  list of modules to push below IP (Mac OS 9.0 and higher), 'STR#' format */

#define kOTCfgManualConfig 				0
#define kOTCfgRARPConfig 				1
#define kOTCfgBOOTPConfig 				2
#define kOTCfgDHCPConfig 				3
#define kOTCfgMacIPConfig 				4

#define kOTCfgTCPActiveLoadedOnDemand 	1
#define kOTCfgTCPActiveAlwaysLoaded 	2
#define kOTCfgTCPInactive 				3

#define kOTCfgTCPLocksPrefPre2_0Size 	25
#define kOTCfgTCPLocksPref2_0Size 		27
#define kOTCfgTCPLocksPrefCurrentSize 	27

#define kOTCfgDontDoPMTUDiscoveryMask 	0x0001				/*  Turns off Path MTU Discovery */
#define kOTCfgDontShutDownOnARPCollisionMask  0x0002		/*  To be able to Disable ARP Collision ShutDown  */
#define kOTCfgDHCPInformMask 			0x0004				/*  Enables DHCPINFORM instead of DHCPREQUEST */
#define kOTCfgOversizeOffNetPacketsMask  0x0008				/*  With PMTU off, don't limit off-net packet to 576 bytes */
#define kOTCfgDHCPDontPreserveLeaseMask  0x0010				/*  Turns off DHCP INIT-REBOOT capability. */

#define kOTCfgTypeDNSidns 				'idns'
#define kOTCfgTypeDNSisdm 				'isdm'
#define kOTCfgTypeDNSihst 				'ihst'
#define kOTCfgTypeDNSstng 				'stng'

#define kOTCfgModemGeneralPrefs 		'ccl '				/*  OTCfgModemGeneral */
#define kOTCfgModemLocksPref 			'lkmd'				/*  OTCfgModemLocks */
#define kOTCfgModemAdminPasswordPref 	'mdpw'				/*  not to be documented */

#define kOTCfgModemApplicationPref 		'mapt'				/*  OTCfgModemApplication */
#define kOTCfgModemDialToneNormal 		0
#define kOTCfgModemDialToneIgnore 		1
#define kOTCfgModemDialToneManual 		2

#define kOTCfgRemoteDefaultVersion 		0x00020003
#define kOTCfgRemoteAcceptedVersion 	0x00010000

#define kOTCfgRemoteARAPPref 			'arap'				/*  OTCfgRemoteARAP */
#define kOTCfgRemoteAddressPref 		'cadr'				/*  'TEXT' format, max 255 characters, see also OTCfgRemoteConnect */
#define kOTCfgRemoteChatPref 			'ccha'				/*  'TEXT', see also OTCfgRemoteConnect */
#define kOTCfgRemoteDialingPref 		'cdia'				/*  OTCfgRemoteDialing */
#define kOTCfgRemoteAlternateAddressPref  'cead'			/*  OTCfgRemoteAlternateAddress */
#define kOTCfgRemoteClientLocksPref 	'clks'				/*  OTCfgRemoteClientLocks */
#define kOTCfgRemoteClientMiscPref 		'cmsc'				/*  OTCfgRemoteClientMisc */
#define kOTCfgRemoteConnectPref 		'conn'				/*  OTCfgRemoteConnect */
#define kOTCfgRemoteUserPref 			'cusr'				/*  user name, Pascal string */
#define kOTCfgRemoteDialAssistPref 		'dass'				/*  OTCfgRemoteDialAssist */
#define kOTCfgRemoteIPCPPref 			'ipcp'				/*  OTCfgRemoteIPCP */
#define kOTCfgRemoteLCPPref 			'lcp '				/*  OTCfgRemoteLCP */
#define kOTCfgRemoteLogOptionsPref 		'logo'				/*  OTCfgRemoteLogOptions */
#define kOTCfgRemotePasswordPref 		'pass'				/*  OTCfgRemotePassword */
#define kOTCfgRemoteTerminalPref 		'term'				/*  OTCfgRemoteTerminal */
#define kOTCfgRemoteUserModePref 		'usmd'				/*  OTCfgRemoteUserMode */
#define kOTCfgRemoteSecurityDataPref 	'csec'				/*  untyped data for external security modules */
#define kOTCfgRemoteX25Pref 			'x25 '				/*  OTCfgRemoteX25 */

#define kOTCfgRemoteServerPortPref 		'port'				/*  OTCfgRemoteServerPort */
#define kOTCfgRemoteServerPref 			'srvr'				/*  OTCfgRemoteServer */
#define kOTCfgRemoteApplicationPref 	'capt'				/*  OTCfgRemoteApplication */

#define kOTCfgRemoteRedialNone 			2
#define kOTCfgRemoteRedialMain 			3
#define kOTCfgRemoteRedialMainAndAlternate  4

#define kOTCfgRemotePPPConnectScriptNone  0					/*  no chat script */
#define kOTCfgRemotePPPConnectScriptTerminalWindow  1		/*  use a terminal window */
#define kOTCfgRemotePPPConnectScriptScript  2				/*  use save chat script (OTCfgRemoteChat) */

#define kOTCfgRemoteProtocolPPP 		1					/*  PPP only */
#define kOTCfgRemoteProtocolARAP 		2					/*  ARAP only */
#define kOTCfgRemoteProtocolAuto 		3					/*  auto-detect PPP or ARAP (not support in ARA 3.5 and above) */

#define kOTCfgRemoteLogLevelNormal 		0
#define kOTCfgRemoteLogLevelVerbose 	1

#define kOTCfgAnswerModeOff 			0					/*  answering disabled */
#define kOTCfgAnswerModeNormal 			1					/*  answering enabled */
#define kOTCfgAnswerModeTransfer 		2					/*  answering as a callback server, not valid for personal server */
#define kOTCfgAnswerModeCallback 		3					/*  answering enabled in callback mode */

#define kOTCfgNetProtoNone 				0
#define kOTCfgNetProtoIP 				1					/*  allow IPCP connections */
#define kOTCfgNetProtoAT 				2					/*  allow AppleTalk connections (ATCP, ARAP) */
#define kOTCfgNetProtoAny 				3					/*  allow connections of either type */

#define kOTCfgNetAccessModeUnrestricted  0					/*  connected client can see things on server and things on server's network */
#define kOTCfgNetAccessModeThisMacOnly 	1					/*  connected client can only see things on server machine */

#if OLDROUTINENAMES
#define kOTCfgTypeStruct 				'stru'
#define kOTCfgTypeElement 				'elem'
#define kOTCfgTypeVector 				'vect'

#define kOTCfgTypeConfigName 			'cnam'
#define kOTCfgTypeConfigSelected 		'ccfg'
#define kOTCfgTypeUserLevel 			'ulvl'
#define kOTCfgTypeWindowPosition 		'wpos'

#define kOTCfgTypeAppleTalkVersion 		'cvrs'
#define kOTCfgTypeTCPcvrs 				'cvrs'
#define kOTCfgTypeTCPVersion 			'cvrs'
#define kOTCfgTypeTCPPort 				'port'
#define kOTCfgTypeAppleTalkPort 		'port'
#define kOTCfgTypeTCPProtocol 			'prot'
#define kOTCfgTypeAppleTalkProtocol 	'prot'
#define kOTCfgTypeAppleTalkPassword 	'pwrd'
#define kOTCfgTypeDNSPassword 			'pwrd'
#define kOTCfgTypeTCPPassword 			'pwrd'
#define kOTCfgTypeRemoteARAP 			'arap'
#define kOTCfgTypeRemoteAddress 		'cadr'
#define kOTCfgTypeRemoteChat 			'ccha'
#define kOTCfgTypeRemoteDialing 		'cdia'
#define kOTCfgTypeRemoteExtAddress 		'cead'
#define kOTCfgTypeRemoteClientLocks 	'clks'
#define kOTCfgTypeRemoteClientMisc 		'cmsc'
#define kOTCfgTypeRemoteConnect 		'conn'
#define kOTCfgTypeRemoteUser 			'cusr'
#define kOTCfgTypeRemoteDialAssist 		'dass'
#define kOTCfgTypeRemoteIPCP 			'ipcp'
#define kOTCfgTypeRemoteLCP 			'lcp '
#define kOTCfgTypeRemoteLogOptions 		'logo'
#define kOTCfgTypeRemotePassword 		'pass'
#define kOTCfgTypeRemoteServer 			'srvr'
#define kOTCfgTypeRemoteTerminal 		'term'
#define kOTCfgTypeRemoteUserMode 		'usmd'
#define kOTCfgTypeRemoteX25 			'x25 '
#define kOTCfgTypeRemoteApp 			'capt'
#define kOTCfgTypeRemotePort 			'port'
#define kOTCfgTypeAppleTalkPrefs 		'atpf'
#define kOTCfgTypeAppleTalkLocks 		'lcks'
#define kOTCfgTypeAppleTalkPortFamily 	'ptfm'
#define kOTCfgTypeInfraredPrefs 		'atpf'
#define kOTCfgTypeInfraredGlobal 		'irgo'
#define kOTCfgTypeTCPdclt 				'dclt'
#define kOTCfgTypeTCPSearchList 		'ihst'
#define kOTCfgTypeTCPihst 				'ihst'
#define kOTCfgTypeTCPidns 				'idns'
#define kOTCfgTypeTCPServersList 		'idns'
#define kOTCfgTypeTCPiitf 				'iitf'
#define kOTCfgTypeTCPPrefs 				'iitf'
#define kOTCfgTypeTCPisdm 				'isdm'
#define kOTCfgTypeTCPDomainsList 		'isdm'
#define kOTCfgTypeTCPdcid 				'dcid'
#define kOTCfgTypeTCPdtyp 				'dtyp'
#define kOTCfgTypeTCPRoutersList 		'irte'
#define kOTCfgTypeTCPirte 				'irte'
#define kOTCfgTypeTCPstng 				'stng'
#define kOTCfgTypeTCPLocks 				'stng'
#define kOTCfgTypeTCPunld 				'unld'
#define kOTCfgTypeTCPUnloadType 		'unld'
#define kOTCfgTypeTCPalis 				'alis'
#define kOTCfgTypeTCPara 				'ipcp'				/*  defining this as 'ipcp' makes no sense, */
															/*  but changing it to kOTCfgRemoteIPCPPref could break someone */
#define kOTCfgTypeTCPDevType 			'dvty'
#define kOTCfgTypeModemModem 			'ccl '
#define kOTCfgTypeModemLocks 			'lkmd'
#define kOTCfgTypeModemAdminPswd 		'mdpw'
#define kOTCfgTypeModemApp 				'mapt'

#define kOTCfgIndexAppleTalkAARP 		0
#define kOTCfgIndexAppleTalkDDP 		1
#define kOTCfgIndexAppleTalkNBP 		2
#define kOTCfgIndexAppleTalkZIP 		3
#define kOTCfgIndexAppleTalkATP 		4
#define kOTCfgIndexAppleTalkADSP 		5
#define kOTCfgIndexAppleTalkPAP 		6
#define kOTCfgIndexAppleTalkASP 		7
#define kOTCfgIndexAppleTalkLast 		7

#define kOTCfgRemoteMaxPasswordLength 	255
#define kOTCfgRemoteMaxPasswordSize 	256
#define kOTCfgRemoteMaxUserNameLength 	255
#define kOTCfgRemoteMaxUserNameSize 	256
#define kOTCfgRemoteMaxAddressLength 	255
#define kOTCfgRemoteMaxAddressSize 		256
#define kOTCfgRemoteMaxServerNameLength  32
#define kOTCfgRemoteMaxServerNameSize 	33
#define kOTCfgRemoteMaxMessageLength 	255
#define kOTCfgRemoteMaxMessageSize 		256
#define kOTCfgRemoteMaxX25ClosedUserGroupLength  4
#define kOTCfgRemoteInfiniteSeconds 	0xFFFFFFFF
#define kOTCfgRemoteMinReminderMinutes 	1
#define kOTCfgRemoteChatScriptFileCreator  'ttxt'
#define kOTCfgRemoteChatScriptFileType 	'TEXT'
#define kOTCfgRemoteMaxChatScriptLength  0x8000

#define kOTCfgRemoteStatusIdle 			1
#define kOTCfgRemoteStatusConnecting 	2
#define kOTCfgRemoteStatusConnected 	3
#define kOTCfgRemoteStatusDisconnecting  4

#endif  /* OLDROUTINENAMES */

#endif  /* CALL_NOT_IN_CARBON */


#endif /* __NETWORKSETUP_R__ */

