/*
 	File:		OCE.h
 
 	Contains:	Apple Open Collaboration Environment (AOCE) Interfaces.
 
 	Version:	Technology:	AOCE Toolbox 1.02
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __OCE__
#define __OCE__

#ifndef REZ

#ifndef __ALIASES__
#include <Aliases.h>
#endif
/*	#include <Types.h>											*/
/*		#include <ConditionalMacros.h>							*/
/*	#include <AppleTalk.h>										*/
/*		#include <OSUtils.h>									*/
/*			#include <MixedMode.h>								*/
/*			#include <Memory.h>									*/
/*	#include <Files.h>											*/
/*		#include <Finder.h>										*/

#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif
/*	#include <Errors.h>											*/
/*	#include <Events.h>											*/
/*		#include <Quickdraw.h>									*/
/*			#include <QuickdrawText.h>							*/
/*	#include <EPPC.h>											*/
/*		#include <PPCToolbox.h>									*/
/*		#include <Processes.h>									*/
/*	#include <Notification.h>									*/

#ifndef __SCRIPT__
#include <Script.h>
#endif
/*	#include <IntlResources.h>									*/

#ifndef __TYPES__
#include <Types.h>
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

/* All utility routines defined here are callable at interrupt level. */
/* Trap selectors */
#define kOCECopyCreationID 768
#define kOCECopyDirDiscriminator 769
#define kOCECopyLocalRecordID 770
#define kOCECopyPackedDSSpec 771
#define kOCECopyPackedPathName 772
#define kOCECopyPackedRLI 773
#define kOCECopyPackedRecordID 774
#define kOCECopyRLI 775
#define kOCECopyRString 776
#define kOCECopyRecordID 777
#define kOCECopyShortRecordID 778
#define kOCEDuplicateRLI 779
#define kOCEEqualCreationID 780
#define kOCEEqualDirDiscriminator 781
#define kOCEEqualDSSpec 782
#define kOCEEqualLocalRecordID 783
#define kOCEEqualPackedDSSpec 784
#define kOCEEqualPackedPathName 785
#define kOCEEqualPackedRecordID 786
#define kOCEEqualPackedRLI 787
#define kOCEEqualRecordID 788
#define kOCEEqualRLI 789
#define kOCEEqualRString 790
#define kOCEEqualShortRecordID 791
#define kOCEExtractAlias 792
#define kOCEGetDSSpecInfo 793
#define kOCEGetIndAttributeType 794
#define kOCEGetIndRecordType 795
#define kOCEGetXtnType 796
#define kOCEIsNullPackedPathName 797
#define kOCENewLocalRecordID 798
#define kOCENewRLI 799
#define kOCENewRecordID 800
#define kOCENewShortRecordID 801
#define kOCEPackDSSpec 802
#define kOCEPackPathName 803
#define kOCEPackRLI 804
#define kOCEPackRLIParts 805
#define kOCEPackRecordID 806
#define kOCEPackedDSSpecSize 807
#define kOCEPackedPathNameSize 808
#define kOCEPackedRLIPartsSize 809
#define kOCEPackedRLISize 810
#define kOCEPackedRecordIDSize 811
#define kOCEDNodeNameCount 812
#define kOCERelRString 813
#define kOCESetCreationIDtoNull 814
#define kOCEUnpackDSSpec 815
#define kOCEUnpackPathName 816
#define kOCEUnpackRLI 817
#define kOCEUnpackRecordID 818
#define kOCEValidPackedDSSpec 819
#define kOCEValidPackedPathName 820
#define kOCEValidPackedRecordID 821
#define kOCEValidPackedRLI 822
#define kOCEValidRLI 823
#define kOCEValidRString 824
#define kOCECToRString 825
#define kOCEPToRString 826
#define kOCERToPString 827
#define kOCEPathFinderCID 828
#define kOCEStreamPackedDSSpec 829
#define kOCENullCID 836
#define kOCEGetAccessControlDSSpec 837
#define kOCEGetRootPackedRLI 838
typedef unsigned short OCERecordTypeIndex;

typedef unsigned short OCEAttributeTypeIndex;

#endif /* REZ */
/* For anyone who absolutely needs a define of the body of the standard record or
attribute type, use these below.  CAUTION!  All the types below are assumed to be
in character set 'smRoman'.  If you try to compare these to some RString or
AttributeType variable, you must take the character set code into account.  Future
standard types may be defined using character sets other than 'smRoman'. */
/*
All these standard definitions begin with the Apple symbol (not shown here).

NOTE:  To access these, you must call OCEGetIndRecordType or OCEGetIndAttributeType
with the proper index.  These routines return pointers to the standard type.
This was done so that code fragments (INITs, CDEVs, CSAMs, etc). which cannot
use global data can also use these.
*/
/* Indices for the standard definitions for certain record types (OCERecordTypeIndex): */
#define kUserRecTypeNum 1
#define kGroupRecTypeNum 2
#define kMnMRecTypeNum 3
#define kMnMForwarderRecTypeNum 4
#define kNetworkSpecRecTypeNum 5
#define kADAPServerRecTypeNum 6
#define kADAPDNodeRecTypeNum 7
#define kADAPDNodeRepRecTypeNum 8
#define kServerSetupRecTypeNum 9
#define kDirectoryRecTypeNum 10
#define kDNodeRecTypeNum 11
#define kSetupRecTypeNum 12
#define kMSAMRecTypeNum 13
#define kDSAMRecTypeNum 14
#define kAttributeValueRecTypeNum 15
#define kBusinessCardRecTypeNum 16
#define kMailServiceRecTypeNum 17
#define kCombinedRecTypeNum 18
#define kOtherServiceRecTypeNum 19
#define kAFPServiceRecTypeNum 20
#define kFirstOCERecTypeNum kUserRecTypeNum
#define kLastOCERecTypeNum kAFPServiceRecTypeNum
#define kNumOCERecTypes (kLastOCERecTypeNum - kFirstOCERecTypeNum + 1)
/* Indices for the standard definitions for certain attribute types (OCEAttributeTypeIndex): */
#define kMemberAttrTypeNum 1001
#define kAdminsAttrTypeNum 1002
#define kMailSlotsAttrTypeNum 1003
#define kPrefMailAttrTypeNum 1004
#define kAddressAttrTypeNum 1005
#define kPictureAttrTypeNum 1006
#define kAuthKeyAttrTypeNum 1007
#define kTelephoneAttrTypeNum 1008
#define kNBPNameAttrTypeNum 1009
#define kQMappingAttrTypeNum 1010
#define kDialupSlotAttrTypeNum 1011
#define kHomeNetAttrTypeNum 1012
#define kCoResAttrTypeNum 1013
#define kFwdrLocalAttrTypeNum 1014
#define kConnectAttrTypeNum 1015
#define kForeignAttrTypeNum 1016
#define kOwnersAttrTypeNum 1017
#define kReadListAttrTypeNum 1018
#define kWriteListAttrTypeNum 1019
#define kDescriptorAttrTypeNum 1020
#define kCertificateAttrTypeNum 1021
#define kMsgQsAttrTypeNum 1022
#define kPrefMsgQAttrTypeNum 1023
#define kMasterPFAttrTypeNum 1024
#define kMasterNetSpecAttrTypeNum 1025
#define kServersOfAttrTypeNum 1026
#define kParentCIDAttrTypeNum 1027
#define kNetworkSpecAttrTypeNum 1028
#define kLocationAttrTypeNum 1029
#define kTimeSvrTypeAttrTypeNum 1030
#define kUpdateTimerAttrTypeNum 1031
#define kShadowsOfAttrTypeNum 1032
#define kShadowServerAttrTypeNum 1033
#define kTBSetupAttrTypeNum 1034
#define kMailSetupAttrTypeNum 1035
#define kSlotIDAttrTypeNum 1036
#define kGatewayFileIDAttrTypeNum 1037
#define kMailServiceAttrTypeNum 1038
#define kStdSlotInfoAttrTypeNum 1039
#define kAssoDirectoryAttrTypeNum 1040
#define kDirectoryAttrTypeNum 1041
#define kDirectoriesAttrTypeNum 1042
#define kSFlagsAttrTypeNum 1043
#define kLocalNameAttrTypeNum 1044
#define kLocalKeyAttrTypeNum 1045
#define kDirUserRIDAttrTypeNum 1046
#define kDirUserKeyAttrTypeNum 1047
#define kDirNativeNameAttrTypeNum 1048
#define kCommentAttrTypeNum 1049
#define kRealNameAttrTypeNum 1050
#define kPrivateDataAttrTypeNum 1051
#define kDirTypeAttrTypeNum 1052
#define kDSAMFileAliasAttrTypeNum 1053
#define kCanAddressToAttrTypeNum 1054
#define kDiscriminatorAttrTypeNum 1055
#define kAliasAttrTypeNum 1056
#define kParentMSAMAttrTypeNum 1057
#define kParentDSAMAttrTypeNum 1058
#define kSlotAttrTypeNum 1059
#define kAssoMailServiceAttrTypeNum 1060
#define kFakeAttrTypeNum 1061
#define kInheritSysAdminAttrTypeNum 1062
#define kPreferredPDAttrTypeNum 1063
#define kLastLoginAttrTypeNum 1064
#define kMailerAOMStateAttrTypeNum 1065
#define kMailerSendOptionsAttrTypeNum 1066
#define kJoinedAttrTypeNum 1067
#define kUnconfiguredAttrTypeNum 1068
#define kVersionAttrTypeNum 1069
#define kLocationNamesAttrTypeNum 1070
#define kActiveAttrTypeNum 1071
#define kDeleteRequestedAttrTypeNum 1072
#define kGatewayTypeAttrTypeNum 1073
#define kFirstOCEAttrTypeNum kMemberAttrTypeNum
#define kLastOCEAttrTypeNum kGatewayTypeAttrTypeNum
#define kNumOCEAttrTypes (kLastOCEAttrTypeNum - kFirstOCEAttrTypeNum + 1)
/* Standard definitions for certain record types: */
#define kUserRecTypeBody "aoce User"
#define kGroupRecTypeBody "aoce Group"
#define kMnMRecTypeBody "aoce AppleMail™ M&M"
#define kMnMForwarderRecTypeBody "aoce AppleMail™ Fwdr"
#define kNetworkSpecRecTypeBody "aoce NetworkSpec"
#define kADAPServerRecTypeBody "aoce ADAP Server"
#define kADAPDNodeRecTypeBody "aoce ADAP DNode"
#define kADAPDNodeRepRecTypeBody "aoce ADAP DNode Rep"
#define kServerSetupRecTypeBody "aoce Server Setup"
#define kDirectoryRecTypeBody "aoce Directory"
#define kDNodeRecTypeBody "aoce DNode"
#define kSetupRecTypeBody "aoce Setup"
#define kMSAMRecTypeBody "aoce MSAM"
#define kDSAMRecTypeBody "aoce DSAM"
#define kAttributeValueRecTypeBody "aoce Attribute Value"
#define kBusinessCardRecTypeBody "aoce Business Card"
#define kMailServiceRecTypeBody "aoce Mail Service"
#define kCombinedRecTypeBody "aoce Combined"
#define kOtherServiceRecTypeBody "aoce Other Service"
#define kAFPServiceRecTypeBody "aoce Other Service afps"
/* Standard definitions for certain attribute types: */
#define kMemberAttrTypeBody "aoce Member"
#define kAdminsAttrTypeBody "aoce Administrators"
#define kMailSlotsAttrTypeBody "aoce mailslots"
#define kPrefMailAttrTypeBody "aoce pref mailslot"
#define kAddressAttrTypeBody "aoce Address"
#define kPictureAttrTypeBody "aoce Picture"
#define kAuthKeyAttrTypeBody "aoce auth key"
#define kTelephoneAttrTypeBody "aoce Telephone"
#define kNBPNameAttrTypeBody "aoce NBP Name"
#define kQMappingAttrTypeBody "aoce ForwarderQMap"
#define kDialupSlotAttrTypeBody "aoce DialupSlotInfo"
#define kHomeNetAttrTypeBody "aoce Home Internet"
#define kCoResAttrTypeBody "aoce Co-resident M&M"
#define kFwdrLocalAttrTypeBody "aoce FwdrLocalRecord"
#define kConnectAttrTypeBody "aoce Connected To"
#define kForeignAttrTypeBody "aoce Foreign RLIs"
#define kOwnersAttrTypeBody "aoce Owners"
#define kReadListAttrTypeBody "aoce ReadList"
#define kWriteListAttrTypeBody "aoce WriteList"
#define kDescriptorAttrTypeBody "aoce Descriptor"
#define kCertificateAttrTypeBody "aoce Certificate"
#define kMsgQsAttrTypeBody "aoce MessageQs"
#define kPrefMsgQAttrTypeBody "aoce PrefMessageQ"
#define kMasterPFAttrTypeBody "aoce MasterPF"
#define kMasterNetSpecAttrTypeBody "aoce MasterNetSpec"
#define kServersOfAttrTypeBody "aoce Servers Of"
#define kParentCIDAttrTypeBody "aoce Parent CID"
#define kNetworkSpecAttrTypeBody "aoce NetworkSpec"
#define kLocationAttrTypeBody "aoce Location"
#define kTimeSvrTypeAttrTypeBody "aoce TimeServer Type"
#define kUpdateTimerAttrTypeBody "aoce Update Timer"
#define kShadowsOfAttrTypeBody "aoce Shadows Of"
#define kShadowServerAttrTypeBody "aoce Shadow Server"
#define kTBSetupAttrTypeBody "aoce TB Setup"
#define kMailSetupAttrTypeBody "aoce Mail Setup"
#define kSlotIDAttrTypeBody "aoce SlotID"
#define kGatewayFileIDAttrTypeBody "aoce Gateway FileID"
#define kMailServiceAttrTypeBody "aoce Mail Service"
#define kStdSlotInfoAttrTypeBody "aoce Std Slot Info"
#define kAssoDirectoryAttrTypeBody "aoce Asso. Directory"
#define kDirectoryAttrTypeBody "aoce Directory"
#define kDirectoriesAttrTypeBody "aoce Directories"
#define kSFlagsAttrTypeBody "aoce SFlags"
#define kLocalNameAttrTypeBody "aoce Local Name"
#define kLocalKeyAttrTypeBody "aoce Local Key"
#define kDirUserRIDAttrTypeBody "aoce Dir User RID"
#define kDirUserKeyAttrTypeBody "aoce Dir User Key"
#define kDirNativeNameAttrTypeBody "aoce Dir Native Name"
#define kCommentAttrTypeBody "aoce Comment"
#define kRealNameAttrTypeBody "aoce Real Name"
#define kPrivateDataAttrTypeBody "aoce Private Data"
#define kDirTypeAttrTypeBody "aoce Directory Type"
#define kDSAMFileAliasAttrTypeBody "aoce DSAM File Alias"
#define kCanAddressToAttrTypeBody "aoce Can Address To"
#define kDiscriminatorAttrTypeBody "aoce Discriminator"
#define kAliasAttrTypeBody "aoce Alias"
#define kParentMSAMAttrTypeBody "aoce Parent MSAM"
#define kParentDSAMAttrTypeBody "aoce Parent DSAM"
#define kSlotAttrTypeBody "aoce Slot"
#define kAssoMailServiceAttrTypeBody "aoce Asso. Mail Service"
#define kFakeAttrTypeBody "aoce Fake"
#define kInheritSysAdminAttrTypeBody "aoce Inherit SysAdministrators"
#define kPreferredPDAttrTypeBody "aoce Preferred PD"
#define kLastLoginAttrTypeBody "aoce Last Login"
#define kMailerAOMStateAttrTypeBody "aoce Mailer AOM State"
#define kMailerSendOptionsAttrTypeBody "aoce Mailer Send Options"
#define kJoinedAttrTypeBody "aoce Joined"
#define kUnconfiguredAttrTypeBody "aoce Unconfigured"
#define kVersionAttrTypeBody "aoce Version"
#define kLocationNamesAttrTypeBody "aoce Location Names"
#define kActiveAttrTypeBody "aoce Active"
#define kDeleteRequestedAttrTypeBody "aoce Delete Requested"
#define kGatewayTypeAttrTypeBody "aoce Gateway Type"
#ifndef REZ
/* Miscellaneous enums: */

enum {
	kRString32Size				= 32,							/* max size of the body field in RString32 */
	kRString64Size				= 64,							/* max size of the body field in RString64 */
	kNetworkSpecMaxBytes		= 32,							/* max size of the body field in NetworkSpec */
	kPathNameMaxBytes			= 1024,							/* max size of the data field in PackedPathName */
	kDirectoryNameMaxBytes		= 32,							/* max size of the body field in DirectoryName */
	kAttributeTypeMaxBytes		= 32,							/* max size of the body field in AttributeType */
	kAttrValueMaxBytes			= 65536,						/* max size of any attribute value */
	kRStringMaxBytes			= 256,							/* max size (in bytes) of the body field of a recordName or recordType */
	kRStringMaxChars			= 128							/* max size (in chars) of the body field of a recordName or recordType */
};

enum {
	kNULLDNodeNumber			= 0,							/* Special value meaning none specified */
	kRootDNodeNumber			= 2								/* DNodeNum corresponding to the root of the tree */
};

/* This enum is used to select the kind of RString in calls such as OCERelRString,
OCEEqualRString, and OCEValidRString.

eGenericSensitive and eGenericInsensitive are enumerators that can be used if you
use RStrings for things other than what you see in this file.  If you want them to
be compared in a case- and diacritical-sensitive manner (c ≠ C ≠ ç), use
eGenericSensitive.  If you want them to be compared in a case- and diacritical-
insensitive manner (c = C = ç), use eGenericInensitive.
WARNING:  do not use eGenericSensitive and eGenericInsensitive with catalog
names, entity names, pathname parts, entity types, network specs, or attribute
types!  Don't assume that you know how they should be compared!!! */
enum {
	kOCEDirName					= 0,
	kOCERecordOrDNodeName		= 1,
	kOCERecordType				= 2,
	kOCENetworkSpec				= 3,
	kOCEAttrType				= 4,
	kOCEGenericSensitive		= 5,
	kOCEGenericInsensitive		= 6
};

typedef unsigned short RStringKind;

/* Values for the signature field in Discriminator */

enum {
	kDirAllKinds				= 0,
	kDirADAPKind				= 'adap',
	kDirPersonalDirectoryKind	= 'pdir',
	kDirDSAMKind				= 'dsam'
};

typedef unsigned long OCEDirectoryKind;

/* Values returned by GetDSSpecInfo() */

enum {
	kOCEInvalidDSSpec			= 0x3F3F3F3FL,					/* could not be determined */
	kOCEDirsRootDSSpec			= 'root',						/* root of all catalogs ("Catalogs" icon) */
	kOCEDirectoryDSSpec			= 'dire',						/* catalog */
	kOCEDNodeDSSpec				= 'dnod',						/* d-node */
	kOCERecordDSSpec			= 'reco',						/* record */
	kOCEentnDSSpec				= 'entn',						/* extensionType is 'entn' */
	kOCENOTentnDSSpec			= 'not '
};

/* Values for AttributeTag */
enum {
	typeRString					= 'rstr',
	typePackedDSSpec			= 'dspc',
	typeBinary					= 'bnry'
};

/* Bit flag corresponding to the canContainRecords bit.  Use it like this:
	if (foo & kCanContainRecords)
		then this dNode can contain records!
kForeignNode is used to indicate nodes in the name hierarchy that correspond to
foreign catalogs (meaning ADAP sees no clusters or DNodes beneath it, but
mail routers might be able to route to clusters beneath it. */
enum {
	kCanContainRecordsBit,
	kForeignNodeBit
};

/* DirNodeKind */
enum {
	kCanContainRecords			= 1L << kCanContainRecordsBit,
	kForeignNode				= 1L << kForeignNodeBit
};

typedef unsigned long DirNodeKind;

/**** Toolbox Control ****/
/* We will have a version number and attributes for toolboxes off the aa5e trap
and the S&F server trap.

This includes the OCE toolbox and S&F Server.  [Note: the S&F server will
change to ONLY service ServerGateway calls —it will then be necessary to run
it co–resident with an OCE toolbox].

The high order word will represent the S&F Server version number.  The low
order word will represent the OCE toolbox version number.  These will be zero
until the component is up and running.  It is not possible to know these
a–priori. Note: there will not be a seperate version numbers for each component
in the OCE toolbox or S&F server.

The above is consistent with the standard System 7.0 usage of Gestalt.

The oce tb attribute gestaltOCETBPresent implies the existence of OCE on a
machine.

The OCE TB attribute gestaltOCETBAvailable implies the availablity of OCE calls.

The attribute gestaltOCESFServerAvailable implies the availablity of OCE calls
available through the S&F server. This are essentially the server gateway calls.

Any (future) remaining OCE attributes may not be established correctly until
the attribute gestaltOCETBAvailable is set.

The gestalt selectors and values are listed below: */

enum {
	gestaltOCEToolboxVersion	= 'ocet',						/* OCE Toolbox version */
	gestaltOCEToolboxAttr		= 'oceu'
};

enum {
/* version includes:
 *  dirtb
 *  authtb
 *  mailtb
 *  ipmtb
 *  personal catalog
 *  ADSPSecure
 * e.g. all interfaces dependent on the aa5e trap. */
	gestaltOCETB				= 0x0102,						/* OCE Toolbox version 1.02 */
	gestaltSFServer				= 0x0100,						/* S&F Server version 1.0 */
	gestaltOCETBPresent			= 0x01,							/* OCE toolbox is present, not running */
	gestaltOCETBAvailable		= 0x02,							/* OCE toolbox is running and available */
	gestaltOCESFServerAvailable	= 0x04,							/* S&F Server is running and available */
	gestaltOCETBNativeGlueAvailable = 0x10						/* Native PowerPC Glue routines are availible */
};

/*	Constants used for Transitions. */
enum {
	ATTransIPMStart				= 'ipms',
	ATTransIPMShutdown			= 'ipmd',
	ATTransDirStart				= 'dirs',
	ATTransDirShutdown			= 'dird',
	ATTransAuthStart			= 'auts',
	ATTransAuthShutdown			= 'autd',
	ATTransSFStart				= 's&fs',
	ATTransSFShutdown			= 's&fd'
};

/* Some definitions for time-related parameters: */
/* Interpreted as UTC seconds since 1/1/1904 */
typedef unsigned long UTCTime;

/* seconds EAST of Greenwich */
typedef long UTCOffset;

/* This is the same as the ScriptManager script. */
typedef short CharacterSet;

/**** RString ****/
/* struct RString is a maximum-sized structure.  Allocate one of these and it will
hold any valid RString. */
#define RStringHeader 			\
	CharacterSet charSet;			\
	unsigned short dataLength;
struct RString {
	CharacterSet					charSet;
	unsigned short					dataLength;
	Byte							body[kRStringMaxBytes];		/* place for characters */
};

typedef struct RString RString;

/* struct ProtoRString is a minimum-sized structure.  Use this for a variable-length RString. */
struct ProtoRString {
	CharacterSet					charSet;
	unsigned short					dataLength;
};

typedef struct ProtoRString ProtoRString;

typedef RString *RStringPtr, **RStringHandle;

typedef ProtoRString *ProtoRStringPtr;

struct RString64 {
	CharacterSet					charSet;
	unsigned short					dataLength;
	Byte							body[kRString64Size];
};

typedef struct RString64 RString64;

struct RString32 {
	CharacterSet					charSet;
	unsigned short					dataLength;
	Byte							body[kRString32Size];
};

typedef struct RString32 RString32;

/* Standard definitions for the entity type field and attribute type
have been moved to the end of the file. */
/* Copies str1 to str2.  str2Length is the size of str2, excluding header.
A memFull error will be returned if that is not as large as str1->dataLength. */
extern pascal OSErr OCECopyRString(const RString *str1, RString *str2, unsigned short str2Length)
 THREEWORDINLINE(0x303C, 776, 0xAA5C);
/*	Make an RString from a C string.  If the c string is bigger than rStrLength,
only rStrLength bytes will be copied. (rStrLength does not include the header size) */
extern pascal void OCECToRString(const char *cStr, CharacterSet charSet, RString *rStr, unsigned short rStrLength)
 THREEWORDINLINE(0x303C, 825, 0xAA5C);
/*	Make an RString from a Pascal string.  If the Pascal string is bigger than rStrLength,
only rStrLength bytes will be copied. (rStrLength does not include the header size) */
extern pascal void OCEPToRString(ConstStr255Param pStr, CharacterSet charSet, RString *rStr, unsigned short rStrLength)
 THREEWORDINLINE(0x303C, 826, 0xAA5C);
/*	Make a Pascal string from an RString.  It's up to you to check the char set of
the RString, or if the length of the RString is greater than 255 (the Pascal string's
length will simply be the lower byte of the RString's length).  The StringPtr that is
returned will point directly into the RString (no memory will be allocated). */
extern pascal StringPtr OCERToPString(const RString *rStr)
 THREEWORDINLINE(0x303C, 827, 0xAA5C);
/*	Check the relative equality of two RStrings.  Determines if str1 is greater than,
equal to, or less than str2.  Result types for OCERelRString are defined in <OSUtils.h>
(same as for RelString). */
extern pascal short OCERelRString(const void *str1, const void *str2, RStringKind kind)
 THREEWORDINLINE(0x303C, 813, 0xAA5C);
/*	Check for equality of two RStrings. Returns true if equal. */
extern pascal Boolean OCEEqualRString(const void *str1, const void *str2, RStringKind kind)
 THREEWORDINLINE(0x303C, 790, 0xAA5C);
/*	Check the validity of an RString.  Returns true if the RString is valid */
extern pascal Boolean OCEValidRString(const void *str, RStringKind kind)
 THREEWORDINLINE(0x303C, 824, 0xAA5C);
/**** CreationID ****/
struct CreationID {
	unsigned long					source;						/* Fields definitions and usage are not defined */
	unsigned long					seq;
};

typedef struct CreationID CreationID;

typedef CreationID AttributeCreationID;

/* Returns a pointer to a null CreationID . */
extern pascal const CreationID *OCENullCID(void)
 THREEWORDINLINE(0x303C, 836, 0xAA5C);
/* Returns a pointer to a special CreationID used within the PathFinder. */
extern pascal const CreationID *OCEPathFinderCID(void)
 THREEWORDINLINE(0x303C, 828, 0xAA5C);
/* Sets the CreationID to a null value. */
extern pascal void OCESetCreationIDtoNull(CreationID *cid)
 THREEWORDINLINE(0x303C, 814, 0xAA5C);
/* Copies the value of cid1 to cid2. */
extern pascal void OCECopyCreationID(const CreationID *cid1, CreationID *cid2)
 THREEWORDINLINE(0x303C, 768, 0xAA5C);
/* Check the equality of two CreationIDs. */
extern pascal Boolean OCEEqualCreationID(const CreationID *cid1, const CreationID *cid2)
 THREEWORDINLINE(0x303C, 780, 0xAA5C);
/**** NetworkSpec ****/
/* For the record, a NetworkSpec is an RString with a smaller maximum size.
I don't just typedef it to an RString, because I want the definition of the NetworkSpec
struct to contain the max length.  But it should be possible to typecast any
NetworkSpec to an RString and use all the RString utilities on it. */
struct NetworkSpec {
	CharacterSet					charSet;
	unsigned short					dataLength;
	Byte							body[kNetworkSpecMaxBytes];	/* always fixed at the max size */
};

typedef struct NetworkSpec NetworkSpec;

typedef NetworkSpec *NetworkSpecPtr;

/**** PackedPathName ****/
/* struct PackedPathName is a maximum-sized structure.  Allocate one of
these and it will hold any valid packed pathname. */
#define PackedPathNameHeader 	\
	unsigned short dataLength;
struct PackedPathName {
	unsigned short					dataLength;
	Byte							data[kPathNameMaxBytes - 2];
};

typedef struct PackedPathName PackedPathName;

/* struct ProtoPackedPathName is a minimum-sized structure.  Use this
for a variable-length packed PathName. */
struct ProtoPackedPathName {
	unsigned short					dataLength;
};

typedef struct ProtoPackedPathName ProtoPackedPathName;

typedef PackedPathName *PackedPathNamePtr;

typedef ProtoPackedPathName *ProtoPackedPathNamePtr;

/*
Copy the contents of path1 to path2.  path2Length is the size of path2, and must
be large enough to hold a copy of path1.  A memFull error will be returned if that
is not the case.
*/
extern pascal OSErr OCECopyPackedPathName(const PackedPathName *path1, PackedPathName *path2, unsigned short path2Length)
 THREEWORDINLINE(0x303C, 772, 0xAA5C);
/*
Returns true if packed path pointer is nil, or is of zero length, or is of
length 2 and nParts of zero.
*/
extern pascal Boolean OCEIsNullPackedPathName(const PackedPathName *path)
 THREEWORDINLINE(0x303C, 797, 0xAA5C);
/*
OCEUnpackPathName breaks apart the path into its component RStrings, writing string
pointers into the array 'parts', which the client asserts can hold as many as
'nParts' elements. The number of parts actually found is returned.  Strings are
placed in the array in order from lowest to highest.  The first pathName element
beneath the root appears last.  NOTE THAT THE UNPACKED STRUCT CONTAINS POINTERS INTO
THE PACKED STRUCT - DON'T DELETE OR REUSE THE PACKED STRUCT UNTIL YOU ARE FINISHED
WITH THE UNPACKED STRUCT AS WELL
*/
extern pascal unsigned short OCEUnpackPathName(const PackedPathName *path, RString *parts[], unsigned short nParts)
 THREEWORDINLINE(0x303C, 816, 0xAA5C);
extern pascal unsigned short OCEPackedPathNameSize(const RStringPtr parts[], unsigned short nParts)
 THREEWORDINLINE(0x303C, 808, 0xAA5C);
/* OCEDNodeNameCount returns the number of RStrings contained within the path. */
extern pascal unsigned short OCEDNodeNameCount(const PackedPathName *path)
 THREEWORDINLINE(0x303C, 812, 0xAA5C);
/*
OCEPackPathName packs the parts into the storage provided as 'path'.  path must be
large enough to hold the packed pathname.  A memFull error will be returned if
pathLength is too small.  parts[0] should contain the deepest pathName element,
and parts[nParts - 1] should contain the name of the first pathName element beneath
the root. 
*/
extern pascal OSErr OCEPackPathName(const RStringPtr parts[], unsigned short nParts, PackedPathName *path, unsigned short pathLength)
 THREEWORDINLINE(0x303C, 803, 0xAA5C);
/*
Check the equality of two packed paths.
*/
extern pascal Boolean OCEEqualPackedPathName(const PackedPathName *path1, const PackedPathName *path2)
 THREEWORDINLINE(0x303C, 785, 0xAA5C);
/*
OCEValidPackedPathName checks that the packed PathName is internally consistent.
Returns true if it's ok.
*/
extern pascal Boolean OCEValidPackedPathName(const PackedPathName *path)
 THREEWORDINLINE(0x303C, 820, 0xAA5C);
/**** DirDiscriminator ****/
struct DirDiscriminator {
	OCEDirectoryKind				signature;
	unsigned long					misc;
};

typedef struct DirDiscriminator DirDiscriminator;

/* Copies the value of disc1 to disc2. */
extern pascal void OCECopyDirDiscriminator(const DirDiscriminator *disc1, DirDiscriminator *disc2)
 THREEWORDINLINE(0x303C, 769, 0xAA5C);
/* Check the equality of two DirDiscriminators. */
extern pascal Boolean OCEEqualDirDiscriminator(const DirDiscriminator *disc1, const DirDiscriminator *disc2)
 THREEWORDINLINE(0x303C, 781, 0xAA5C);
/*
This structure is called RLI because it really contains all the info you
need to locate a record within the entire name space.  It contains four fields.
The first two are the name of the catalog and a catalog discriminator.  These
two fields are used to indicate to which catalog a given record belongs.  The
discriminator is used to distinguish between two different catalogs that have
the same name.

The other two fields in the RLI structure are used to indicate a particular
catalog node within the catalog specified by the directoryName and
discriminator fields.  These fields are exactly analagous to the dirID and
pathname used in HFS.  It is possible to specify a dNode just by dNodeNumber
(pathname is nil), or just by pathname (dNodeNumber is set to kNULLDNodeNumber),
or by a combination of the two.  The latter is called a 'partial pathname', and
while it is valid in the Catalog Manager API, it is not supported by ADAP
catalogs in Release 1.

Note that the path parameter does not include the catalog name, but holds
the names of all the nodes on the path to the desired catalog node, starting
with the catalog node and working its way up the tree.
*/
/**** RLI ****/
struct DirectoryName {
	CharacterSet					charSet;
	unsigned short					dataLength;
	Byte							body[kDirectoryNameMaxBytes]; /* space for catalog name */
};

typedef struct DirectoryName DirectoryName;

typedef DirectoryName *DirectoryNamePtr;

/* Catalog node number */
typedef unsigned long DNodeNum;

struct RLI {
	DirectoryNamePtr				directoryName;				/* pointer to the name of the catalog root */
	DirDiscriminator				discriminator;				/* used to discriminate between dup catalog names */
	DNodeNum						dNodeNumber;				/* number of the node */
	PackedPathNamePtr				path;						/* old-style RLI */
};

typedef struct RLI RLI;

typedef RLI *RLIPtr;

/*
Create a new RLI from the catalog name, discriminator, DNode number, and
PackedPathName.  You must allocate the storage for the RLI and pass in a pointer
to it.
*/
extern pascal void OCENewRLI(RLI *newRLI, const DirectoryName *dirName, DirDiscriminator *discriminator, DNodeNum dNodeNumber, const PackedPathName *path)
 THREEWORDINLINE(0x303C, 799, 0xAA5C);
/*
Duplicate the contents of rli1 to rli2.  No errors are returned. This
simply copies the pointers to the catalog name and path, wiping out any pointer
that you might have had in there.
*/
extern pascal void OCEDuplicateRLI(const RLI *rli1, RLI *rli2)
 THREEWORDINLINE(0x303C, 779, 0xAA5C);
/*
Copy the contents of rli1 to rli2.  rli2 must already contain
pointers to structures large enough to hold copies of the corresponding
fields from rli1.  A memFull error will be returned if that is not the case.
So if you allocate a brand new empty destination, you must at least set up
its length fields.
*/
extern pascal OSErr OCECopyRLI(const RLI *rli1, RLI *rli2)
 THREEWORDINLINE(0x303C, 775, 0xAA5C);
/*
Check the equality of two RLIs.  This will take into account differences
in the case and diacriticals of the directoryName and the PathName.
NOTE THAT THIS WILL FAIL IF rli1 CONTAINS A DNODENUMBER AND A NIL PATHNAME,
AND rli2 CONTAINS kNULLDNodeNumber AND A NON-NIL PATHNAME.  IN OTHER WORDS,
THE TWO rlis MUST BE OF THE SAME FORM TO CHECK FOR EQUALITY.
The one exception is that if the pathname is nil, a dNodeNumber of zero and
kRootDNodeNumber will be treated as equal.
*/
extern pascal Boolean OCEEqualRLI(const RLI *rli1, const RLI *rli2)
 THREEWORDINLINE(0x303C, 789, 0xAA5C);
/*
Check the validity of an RLI.  This checks that the catalog name length
is within bounds, and the packed pathname (if specified) is valid.
*/
extern pascal Boolean OCEValidRLI(const RLI *theRLI)
 THREEWORDINLINE(0x303C, 823, 0xAA5C);
/**** PackedRLI ****/
/*
struct PackedRLI is a maximum-sized structure.  Allocate one of
these and it will hold any valid packed pathname.
*/
#define PackedRLIHeader 		\
	unsigned short dataLength;

enum {
	kRLIMaxBytes				= (sizeof(RString) + sizeof(DirDiscriminator) + sizeof(DNodeNum) + kPathNameMaxBytes)
};

struct PackedRLI {
	unsigned short					dataLength;
	Byte							data[kRLIMaxBytes];
};

typedef struct PackedRLI PackedRLI;

/*
struct ProtoPackedRLI is a minimum-sized structure.  Use this
for a variable-length packed RLI.
*/
struct ProtoPackedRLI {
	unsigned short					dataLength;
};

typedef struct ProtoPackedRLI ProtoPackedRLI;

typedef PackedRLI *PackedRLIPtr;

typedef ProtoPackedRLI *ProtoPackedRLIPtr;

/*
Copy the contents of prli1 to prli2.  prli2Length is the size of prli2, and must
be large enough to hold a copy of prli1.  A memFull error will be returned if that
is not the case.
*/
extern pascal OSErr OCECopyPackedRLI(const PackedRLI *prli1, PackedRLI *prli2, unsigned short prli2Length)
 THREEWORDINLINE(0x303C, 773, 0xAA5C);
/*
OCEUnpackRLI breaks apart the prli into its components, writing pointers into
the rli structure.  NOTE THAT THE UNPACKED STRUCT CONTAINS POINTERS INTO THE
PACKED STRUCT - DON'T DELETE OR REUSE THE PACKED STRUCT UNTIL YOU ARE FINISHED
WITH THE UNPACKED STRUCT AS WELL
*/
extern pascal void OCEUnpackRLI(const PackedRLI *prli, RLI *theRLI)
 THREEWORDINLINE(0x303C, 817, 0xAA5C);
/*
OCEPackedRLISize computes the number of bytes of memory needed to hold a
PackedRLI manufactured from an RLI.  This length
includes the length of the length field of PackedRLI, so it
is safe to do a NewPtr (OCEPackedRLISize(...)).
*/
extern pascal unsigned short OCEPackedRLISize(const RLI *theRLI)
 THREEWORDINLINE(0x303C, 810, 0xAA5C);
/*
OCEPackRLI packs the RLI into the storage provided as 'prli'.  prli must be
large enough to hold the packed RLI.  A memFull error will be returned if
prliLength is too small.
*/
extern pascal OSErr OCEPackRLI(const RLI *theRLI, PackedRLI *prli, unsigned short prliLength)
 THREEWORDINLINE(0x303C, 804, 0xAA5C);
/*
OCEPackedRLIPartsSize computes the number of bytes of memory needed to hold a
PackedRLI manufactured from the parts of an RLI.  This length
includes the length of the length field of PackedRLI, so it
is safe to do a NewPtr (OCEPackedRLIPartsSize(...)).
*/
extern pascal unsigned short OCEPackedRLIPartsSize(const DirectoryName *dirName, const RStringPtr parts[], unsigned short nParts)
 THREEWORDINLINE(0x303C, 809, 0xAA5C);
/*
OCEPackRLIParts packs the parts of an RLI into the storage provided as 'prli'.
prli must be large enough to hold the packed RLI.  A memFull error will be returned
if prliLength is too small.
*/
extern pascal OSErr OCEPackRLIParts(const DirectoryName *dirName, const DirDiscriminator *discriminator, DNodeNum dNodeNumber, const RStringPtr parts[], unsigned short nParts, PackedRLI *prli, unsigned short prliLength)
 THREEWORDINLINE(0x303C, 805, 0xAA5C);
/*
Check the equality of two packed prlis.
*/
extern pascal Boolean OCEEqualPackedRLI(const PackedRLI *prli1, const PackedRLI *prli2)
 THREEWORDINLINE(0x303C, 787, 0xAA5C);
/*
Check the validity of a packed RLI.  This checks that the catalog name length
is within bounds, and the packed pathname (if specified) is valid.
*/
extern pascal Boolean OCEValidPackedRLI(const PackedRLI *prli)
 THREEWORDINLINE(0x303C, 822, 0xAA5C);
/*
If this packed RLI describes a Personal Catalog, this call will return a pointer
to an alias record that can be used to find the actual file.  Otherwise, it returns nil.
*/
extern pascal AliasPtr OCEExtractAlias(const PackedRLI *prli)
 THREEWORDINLINE(0x303C, 792, 0xAA5C);
/*
This call returns a pointer to a packed RLI that represents the "Catalogs" icon, or
the root of all catalogs.  It is used in the CollabPack.
*/
extern pascal const PackedRLI *OCEGetDirectoryRootPackedRLI(void)
 THREEWORDINLINE(0x303C, 838, 0xAA5C);
/**** LocalRecordID ****/
struct LocalRecordID {
	CreationID						cid;
	RStringPtr						recordName;
	RStringPtr						recordType;
};

typedef struct LocalRecordID LocalRecordID;

typedef LocalRecordID *LocalRecordIDPtr;

/* Create a LocalRecordID from a name, type, and CreationID */
extern pascal void OCENewLocalRecordID(const RString *recordName, const RString *recordType, const CreationID *cid, LocalRecordID *lRID)
 THREEWORDINLINE(0x303C, 798, 0xAA5C);
/*
Copy LocalRecordID lRID1 to LocalRecordID lRID2.  lRID2 must already contain
pointers to RString structures large enough to hold copies of the corresponding
fields from lRID1.  A memFull error will be returned if that is not the case.
So if you allocate a brand new empty destination, you must at least set up
its length field.
*/
extern pascal OSErr OCECopyLocalRecordID(const LocalRecordID *lRID1, LocalRecordID *lRID2)
 THREEWORDINLINE(0x303C, 770, 0xAA5C);
/*
Check the equality of two local RIDs.
*/
extern pascal Boolean OCEEqualLocalRecordID(const LocalRecordID *lRID1, const LocalRecordID *lRID2)
 THREEWORDINLINE(0x303C, 783, 0xAA5C);
/**** ShortRecordID ****/
struct ShortRecordID {
	PackedRLIPtr					rli;
	CreationID						cid;
};

typedef struct ShortRecordID ShortRecordID;

typedef ShortRecordID *ShortRecordIDPtr;

/* Create a ShortRecordID from an RLI struct and a CreationID */
extern pascal void OCENewShortRecordID(const PackedRLI *theRLI, const CreationID *cid, ShortRecordIDPtr sRID)
 THREEWORDINLINE(0x303C, 801, 0xAA5C);
/*
Copy ShortRecordID sRID1 to ShortRecordID sRID2.  sRID2 must already contain
pointers to structures large enough to hold copies of the corresponding
fields from sRID1.  A memFull error will be returned if that is not the case.
So if you allocate a brand new empty destination, you must at least set up
its length fields.
*/
extern pascal OSErr OCECopyShortRecordID(const ShortRecordID *sRID1, ShortRecordID *sRID2)
 THREEWORDINLINE(0x303C, 778, 0xAA5C);
/*
Check the equality of two short RIDs.
*/
extern pascal Boolean OCEEqualShortRecordID(const ShortRecordID *sRID1, const ShortRecordID *sRID2)
 THREEWORDINLINE(0x303C, 791, 0xAA5C);
/**** RecordID ****/
struct RecordID {
	PackedRLIPtr					rli;						/* pointer to a packed rli structure */
	LocalRecordID					local;
};

typedef struct RecordID RecordID;

typedef RecordID *RecordIDPtr;

/*	Create a RecordID from a packed RLI struct and a LocalRecordID.
This doesn't allocate any new space; the RecordID points to the same
packed RLI struct and the same name and type RStrings. */
extern pascal void OCENewRecordID(const PackedRLI *theRLI, const LocalRecordID *lRID, RecordID *rid)
 THREEWORDINLINE(0x303C, 800, 0xAA5C);
/*
Copy RecordID RID1 to RecordID RID2.  RID2 must already contain
pointers to structures large enough to hold copies of the corresponding
fields from lRID1.  A memFull error will be returned if that is not the case.
So if you allocate a brand new empty destination, you must at least set up
its length fields.
*/
extern pascal OSErr OCECopyRecordID(const RecordID *rid1, const RecordID *rid2)
 THREEWORDINLINE(0x303C, 777, 0xAA5C);
/*	Check the equality of two RIDs. */
extern pascal Boolean OCEEqualRecordID(const RecordID *rid1, const RecordID *rid2)
 THREEWORDINLINE(0x303C, 788, 0xAA5C);
/**** PackedRecordID ****/
/*
struct PackedRecordID is a maximum-sized structure.  Allocate one of
these and it will hold any valid packed RecordID.
*/
#define PackedRecordIDHeader 	\
	unsigned short dataLength;

enum {
	kPackedRecordIDMaxBytes		= (kPathNameMaxBytes + sizeof(DNodeNum) + sizeof(DirDiscriminator) + sizeof(CreationID) + (3 * sizeof(RString)))
};

struct PackedRecordID {
	unsigned short					dataLength;
	Byte							data[kPackedRecordIDMaxBytes];
};

typedef struct PackedRecordID PackedRecordID;

/*
struct ProtoPackedRecordID is a minimum-sized structure.  Use this
for a variable-length packed RecordID.
*/
struct ProtoPackedRecordID {
	unsigned short					dataLength;
};

typedef struct ProtoPackedRecordID ProtoPackedRecordID;

typedef PackedRecordID *PackedRecordIDPtr;

typedef ProtoPackedRecordID *ProtoPackedRecordIDPtr;

/*
Copy PackedRecordID pRID1 to PackedRecordID pRID2.  pRID2 must already contain
pointers to structures large enough to hold copies of the corresponding
fields from pRID1.  A memFull error will be returned if that is not the case.
pRID2Length is the number of bytes that can be put into pRID2, not counting the
packed RecordID header.
*/
extern pascal OSErr OCECopyPackedRecordID(const PackedRecordID *pRID1, const PackedRecordID *pRID2, unsigned short pRID2Length)
 THREEWORDINLINE(0x303C, 774, 0xAA5C);
/*
Create a RecordID from a PackedRecordID.
NOTE THAT THE UNPACKED STRUCT CONTAINS POINTERS INTO THE PACKED STRUCT - DON'T DELETE
OR REUSE THE PACKED STRUCT UNTIL YOU ARE FINISHED WITH THE UNPACKED STRUCT AS WELL
*/
extern pascal void OCEUnpackRecordID(const PackedRecordID *pRID, RecordID *rid)
 THREEWORDINLINE(0x303C, 818, 0xAA5C);
/*
Create a PackedRecordID from a RecordID.  pRID must be large enough to contain
the packed RecordID.  A memFull error will be returned if that is not the case.
packedRecordIDLength is the number of bytes that can be put into pRID, not
counting the header.
*/
extern pascal OSErr OCEPackRecordID(const RecordID *rid, PackedRecordID *pRID, unsigned short packedRecordIDLength)
 THREEWORDINLINE(0x303C, 806, 0xAA5C);
/*
Compute the number of bytes of memory needed to hold a RecordID when packed. This
length includes the length of the length field of PackedRecordID, so it
is safe to do a NewPtr (OCEPackedRecordIDSize(...)).
*/
extern pascal unsigned short OCEPackedRecordIDSize(const RecordID *rid)
 THREEWORDINLINE(0x303C, 811, 0xAA5C);
/*
Check the equality of two packed RIDs.
*/
extern pascal Boolean OCEEqualPackedRecordID(const PackedRecordID *pRID1, const PackedRecordID *pRID2)
 THREEWORDINLINE(0x303C, 786, 0xAA5C);
/* OCEValidPackedRecordID checks the validity of a packed record ID. */
extern pascal Boolean OCEValidPackedRecordID(const PackedRecordID *pRID)
 THREEWORDINLINE(0x303C, 821, 0xAA5C);
/**** DSSpec ****/
struct DSSpec {
	RecordID						*entitySpecifier;
	OSType							extensionType;
	unsigned short					extensionSize;
	Ptr								extensionValue;
};

typedef struct DSSpec DSSpec;

typedef DSSpec *DSSpecPtr;

/*
struct PackedDSSpec is NOT a maximum-sized structure.  Allocate one of
these and it will hold any valid packed RecordID, but not necessarily any additional
data.
*/
#define PackedDSSpecHeader 		\
	unsigned short dataLength;

enum {
	kPackedDSSpecMaxBytes		= (sizeof(PackedRecordID) + sizeof(OSType) + sizeof(UInt16))
};

struct PackedDSSpec {
	unsigned short					dataLength;
	Byte							data[kPackedDSSpecMaxBytes];
};

typedef struct PackedDSSpec PackedDSSpec;

/*
struct ProtoPackedDSSpec is a minimum-sized structure.  Use this
for a variable-length packed DSSpec.
*/
struct ProtoPackedDSSpec {
	unsigned short					dataLength;
};

typedef struct ProtoPackedDSSpec ProtoPackedDSSpec;

typedef PackedDSSpec *PackedDSSpecPtr;

typedef ProtoPackedDSSpec *ProtoPackedDSSpecPtr;

/*
Copy PackedDSSpec pdss1 to PackedDSSpec pdss2.  pdss2 must already contain
pointers to structures large enough to hold copies of the corresponding
fields from pdss1.  A memFull error will be returned if that is not the case.
pdss2Length is the number of bytes that can be put into pdss2, not counting the
packed DSSpec header.
*/
extern pascal OSErr OCECopyPackedDSSpec(const PackedDSSpec *pdss1, const PackedDSSpec *pdss2, unsigned short pdss2Length)
 THREEWORDINLINE(0x303C, 771, 0xAA5C);
/*
Create a DSSpec from a PackedDSSpec.
NOTE THAT THE UNPACKED STRUCT CONTAINS POINTERS INTO THE PACKED STRUCT - DON'T DELETE
OR REUSE THE PACKED STRUCT UNTIL YOU ARE FINISHED WITH THE UNPACKED STRUCT AS WELL.
A pointer to the extension is returned in dss->extensionValue, and the length of that
extension is returned in dss->extensionSize.  If there is no extension, dss->extensionValue will
be set to nil.  This routine will unpack the RecordID (if any) into rid, unpack the rest
into dss, and set dss->entitySpecifier to rid.
*/
extern pascal void OCEUnpackDSSpec(const PackedDSSpec *pdss, DSSpec *dss, RecordID *rid)
 THREEWORDINLINE(0x303C, 815, 0xAA5C);
/*
Create a PackedDSSpec from a DSSpec.  pdss must be large enough to
contain the packed RecordID and any extension.  A memFull error will be returned if that
is not the case.  pdssLength is the number of bytes that can be put into pdss,
not counting the header.
*/
extern pascal OSErr OCEPackDSSpec(const DSSpec *dss, PackedDSSpec *pdss, unsigned short pdssLength)
 THREEWORDINLINE(0x303C, 802, 0xAA5C);
/*
Compute the number of bytes of memory needed to hold a DSSpec when packed. This
length includes the length of the length field of PackedDSSpec, so it
is safe to do a NewPtr (OCEPackedDSSpecSize(...)).
*/
extern pascal unsigned short OCEPackedDSSpecSize(const DSSpec *dss)
 THREEWORDINLINE(0x303C, 807, 0xAA5C);
/*	Check the equality of two DSSpecs.  This compares all fields, even the
extension (unless extensionSize == 0).  The extensions are compared in a case-insensitive and
diacrit-insensitive manner. */
extern pascal Boolean OCEEqualDSSpec(const DSSpec *pdss1, const DSSpec *pdss2)
 THREEWORDINLINE(0x303C, 782, 0xAA5C);
/*	Check the equality of two PackedDSSpecs.  This compares all fields, even the
extension (unless extensionSize == 0).  The extensions are compared in a case-insensitive and
diacrit-insensitive manner. */
extern pascal Boolean OCEEqualPackedDSSpec(const PackedDSSpec *pdss1, const PackedDSSpec *pdss2)
 THREEWORDINLINE(0x303C, 784, 0xAA5C);
/*
Check the validity of a PackedDSSpec.  If extensionType is
'entn', pdss must contain a valid entitySpecifier.  For all other extensionTypes, a nil
entitySpecifier is valid, but if non-nil, it will be checked for validity.  No check
is made on the extension.
*/
extern pascal Boolean OCEValidPackedDSSpec(const PackedDSSpec *pdss)
 THREEWORDINLINE(0x303C, 819, 0xAA5C);
/*
Return info about a DSSpec.  This routine does not check validity.  If the
DSSpec has no extension, we determine whether it represents the root of all
catalogs, a single catalog, a DNode, or a Record.  Else it is invalid.
If the DSSpec has an extension, we simply return the extension type.
*/
extern pascal OSType OCEGetDSSpecInfo(const DSSpec *spec)
 THREEWORDINLINE(0x303C, 793, 0xAA5C);
/* OCEGetExtensionType returns the extensionType imbedded in the PackedDSSpec. */
extern pascal OSType OCEGetExtensionType(const PackedDSSpec *pdss)
 THREEWORDINLINE(0x303C, 796, 0xAA5C);
/*
OCEStreamPackedDSSpec streams (flattens) a catalog object a little at a time by
calling the DSSpecStreamer routine that you provide.
*/
typedef pascal OSErr (*DSSpecStreamerProcPtr)(void *buffer, unsigned long count, Boolean eof, long userData);

#if GENERATINGCFM
typedef UniversalProcPtr DSSpecStreamerUPP;
#else
typedef DSSpecStreamerProcPtr DSSpecStreamerUPP;
#endif

enum {
	uppDSSpecStreamerProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(unsigned long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long)))
};

#if GENERATINGCFM
#define NewDSSpecStreamerProc(userRoutine)		\
		(DSSpecStreamerUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDSSpecStreamerProcInfo, GetCurrentArchitecture())
#else
#define NewDSSpecStreamerProc(userRoutine)		\
		((DSSpecStreamerUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallDSSpecStreamerProc(userRoutine, buffer, count, eof, userData)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDSSpecStreamerProcInfo, (buffer), (count), (eof), (userData))
#else
#define CallDSSpecStreamerProc(userRoutine, buffer, count, eof, userData)		\
		(*(userRoutine))((buffer), (count), (eof), (userData))
#endif

typedef DSSpecStreamerUPP DSSpecStreamer;

extern pascal OSErr OCEStreamPackedDSSpec(const DSSpec *dss, DSSpecStreamer stream, long userData, unsigned long *actualCount)
 THREEWORDINLINE(0x303C, 829, 0xAA5C);
/**** AttributeType ****/
/*
For the record, an AttributeType is an RString with a smaller maximum size.
I don't just typedef it to an RString, because I want the definition of the AttributeType
struct to contain the max length, because I need to include it in the Attribute struct
below.  But it should be possible to typecast any AttributeType to an RString and use
all the RString utilities on it.
*/
struct AttributeType {
	CharacterSet					charSet;
	unsigned short					dataLength;
	Byte							body[kAttributeTypeMaxBytes]; /* always fixed at the max size */
};

typedef struct AttributeType AttributeType;

typedef AttributeType *AttributeTypePtr;

/* Miscellaneous defines:  (these cannot be made into enums) */

enum {
	kMinPackedRStringLength		= (sizeof(ProtoRString))
};

enum {
	kMinPackedRLISize			= (sizeof(ProtoPackedRLI) + sizeof(DirDiscriminator) + sizeof(DNodeNum) + kMinPackedRStringLength + sizeof(ProtoPackedPathName))
};

/**** AttributeValue ****/
/* same class as is used in AppleEvents */
typedef DescType AttributeTag;

struct AttributeValue {
	AttributeTag					tag;
	unsigned long					dataLength;
	Ptr								bytes;
};

typedef struct AttributeValue AttributeValue;

typedef AttributeValue *AttributeValuePtr;

/**** Attribute ****/
struct Attribute {
	AttributeType					attributeType;
	AttributeCreationID				cid;
	AttributeValue					value;
};

typedef struct Attribute Attribute;

typedef Attribute *AttributePtr;

extern pascal RString *OCEGetIndRecordType(OCERecordTypeIndex stringIndex)
 THREEWORDINLINE(0x303C, 795, 0xAA5C);
extern pascal AttributeType *OCEGetIndAttributeType(OCEAttributeTypeIndex stringIndex)
 THREEWORDINLINE(0x303C, 794, 0xAA5C);

enum {
	_oceTBDispatch				= 0xAA5E
};

/****************************************************************************************
   PLEASE NOTE! ROUTINES HAVE MOVED TO THIS HEADER!
 
   OCESizePackedRecipient, OCEPackRecipient, OCEUnpackRecipient, OCEStreamRecipient,
   OCEGetRecipientType, and OCESetRecipientType have moved to the OCE header file.
   The OCEMessaging header includes the OCE header, so no changes to your code are
   required.

****************************************************************************************/
typedef DSSpec OCERecipient;


enum {
	kOCESizePackedRecipient		= 830,
	kOCEPackRecipient			= 831,
	kOCEUnpackRecipient			= 832,
	kOCEStreamRecipient			= 833,
	kOCEGetRecipientType		= 834,
	kOCESetRecipientType		= 835
};

/*
Compute the space that a OCERecipient would take if it were in packed
form.  [Note: does NOT even pad extensionSize, so you may get an odd #back out]
Safe to pass dereferenced handle(s).
*/
extern pascal unsigned short OCESizePackedRecipient(const OCERecipient *rcpt)
 THREEWORDINLINE(0x303C, 830, 0xAA5C);
/*
Take an OCERecipient (scatter) and (gather) stream into the specified
buffer.  It is assumed that there is sufficient space in the buffer (that is
OCESizePackedRecipient).  Safe to pass dereferenced handle(s).
*/
extern pascal unsigned short OCEPackRecipient(const OCERecipient *rcpt, void *buffer)
 THREEWORDINLINE(0x303C, 831, 0xAA5C);
/*
Take a packed OCERecipient and cast a the OCERecipient frame over it. Returns
amBadDestId if it doesn't look like an OCERecipient. Safe to pass dereferenced
handle(s).
*/
extern pascal OSErr OCEUnpackRecipient(const void *buffer, OCERecipient *rcpt, RecordID *entitySpecifier)
 THREEWORDINLINE(0x303C, 832, 0xAA5C);
/*
Take an OCERecipient (scatter) and (gather) stream using the specified
function.  Safe to pass dereferenced handle(s).  If streamer function returns
OCEError OCEStreamRecipient stops execution and passes the error back to the caller
*/
typedef pascal OSErr (*OCERecipientStreamerProcPtr)(void *buffer, unsigned long count, Boolean eof, long userData);

#if GENERATINGCFM
typedef UniversalProcPtr OCERecipientStreamerUPP;
#else
typedef OCERecipientStreamerProcPtr OCERecipientStreamerUPP;
#endif

enum {
	uppOCERecipientStreamerProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(unsigned long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long)))
};

#if GENERATINGCFM
#define NewOCERecipientStreamerProc(userRoutine)		\
		(OCERecipientStreamerUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppOCERecipientStreamerProcInfo, GetCurrentArchitecture())
#else
#define NewOCERecipientStreamerProc(userRoutine)		\
		((OCERecipientStreamerUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallOCERecipientStreamerProc(userRoutine, buffer, count, eof, userData)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppOCERecipientStreamerProcInfo, (buffer), (count), (eof), (userData))
#else
#define CallOCERecipientStreamerProc(userRoutine, buffer, count, eof, userData)		\
		(*(userRoutine))((buffer), (count), (eof), (userData))
#endif

typedef OCERecipientStreamerUPP OCERecipientStreamer;

extern pascal OSErr OCEStreamRecipient(const OCERecipient *rcpt, OCERecipientStreamer stream, long userData, unsigned long *actualCount)
 THREEWORDINLINE(0x303C, 833, 0xAA5C);
/* Get the OCERecipient's extensionType. Safe to pass dereferenced handle(s).*/
extern pascal OSType OCEGetRecipientType(const CreationID *cid)
 THREEWORDINLINE(0x303C, 834, 0xAA5C);
/*
Set the OCERecipient's extensionType in the specified cid.  (Note: we do NOT
check for a nil pointer).  If the extensionType is 'entn', the cid is assumed
to be "valid" and is not touched.  Note: to properly handle non 'entn''s this
routine must and will zero the high long (source) of the cid! Safe to pass
dereferenced handle(s).
*/
extern pascal void OCESetRecipientType(OSType extensionType, CreationID *cid)
 THREEWORDINLINE(0x303C, 835, 0xAA5C);
/****************************************************************************************
   PLEASE NOTE! ROUTINES HAVE MOVED TO THIS HEADER!
 
   OCEGetAccessControlDSSpec and its corresponding data type and constants have
   moved to the OCE header from OCEAuthDir. The OCEAuthDir header includes the OCE
   header, so no changes to your code are required.
   
****************************************************************************************/
/* access categories bit numbers */

enum {
	kThisRecordOwnerBit			= 0,
	kFriendsBit					= 1,
	kAuthenticatedInDNodeBit	= 2,
	kAuthenticatedInDirectoryBit = 3,
	kGuestBit					= 4,
	kMeBit						= 5
};

/* Values of CategoryMask */
enum {
	kThisRecordOwnerMask		= (1L << kThisRecordOwnerBit),
	kFriendsMask				= (1L << kFriendsBit),
	kAuthenticatedInDNodeMask	= (1L << kAuthenticatedInDNodeBit),
	kAuthenticatedInDirectoryMask = (1L << kAuthenticatedInDirectoryBit),
	kGuestMask					= (1L << kGuestBit),
	kMeMask						= (1L << kMeBit)
};

typedef unsigned long CategoryMask;

/*
pass kThisRecordOwnerMask, kFriendsMask, kAuthenticatedInDNodeMask, kAuthenticatedInDirectoryMask,
kGuestMask, or kMeMask to this routine, and it will return a pointer to a
DSSpec that can be used in the Get or Set Access Controls calls.
*/
extern pascal DSSpec *OCEGetAccessControlDSSpec(CategoryMask categoryBitMask)
 THREEWORDINLINE(0x303C, 837, 0xAA5C);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* REZ */
#endif /* __OCE__ */
