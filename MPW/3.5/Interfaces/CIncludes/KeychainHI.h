/*
     File:       KeychainHI.h
 
     Contains:   Keychain API's with Human Interfaces
 
     Version:    Technology: Keychain 3.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __KEYCHAINHI__
#define __KEYCHAINHI__

#ifndef __KEYCHAINCORE__
#include <KeychainCore.h>
#endif

#ifndef __CFSTRING__
#include <CFString.h>
#endif

#ifndef __CFARRAY__
#include <CFArray.h>
#endif

#ifndef __CFDATE__
#include <CFDate.h>
#endif




#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
    #pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
    #pragma pack(2)
#endif

/* Managing the Human Interface */
/*
 *  KCSetInteractionAllowed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
KCSetInteractionAllowed(Boolean state);


/*
 *  KCIsInteractionAllowed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Boolean )
KCIsInteractionAllowed(void);


/* Locking and unlocking a keychain */
/*
 *  KCUnlock()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
KCUnlock(
  KCRef       keychain,       /* can be NULL */
  StringPtr   password);      /* can be NULL */


/*
 *  KCLock()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
KCLock(KCRef keychain);


/* Creating a new keychain */
/*
 *  KCCreateKeychain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
KCCreateKeychain(
  StringPtr   password,       /* can be NULL */
  KCRef *     keychain);      /* can be NULL */



/* Changing a keychain's settings */
/*
 *  KCChangeSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
KCChangeSettings(KCRef keychain);


/* Managing keychain items */
/*
 *  KCAddItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
KCAddItem(KCItemRef item);


/*
 *  KCDeleteItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
KCDeleteItem(KCItemRef item);


/*
 *  KCGetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
KCGetData(
  KCItemRef   item,
  UInt32      maxLength,
  void *      data,
  UInt32 *    actualLength);


/* Storing and retrieving AppleShare passwords */
/*
 *  KCAddAppleSharePassword()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
KCAddAppleSharePassword(
  AFPServerSignature *  serverSignature,
  StringPtr             serverAddress,
  StringPtr             serverName,
  StringPtr             volumeName,
  StringPtr             accountName,
  UInt32                passwordLength,
  const void *          passwordData,
  KCItemRef *           item);                 /* can be NULL */


/*
 *  KCFindAppleSharePassword()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
KCFindAppleSharePassword(
  AFPServerSignature *  serverSignature,       /* can be NULL */
  StringPtr             serverAddress,         /* can be NULL */
  StringPtr             serverName,            /* can be NULL */
  StringPtr             volumeName,            /* can be NULL */
  StringPtr             accountName,           /* can be NULL */
  UInt32                maxLength,
  void *                passwordData,
  UInt32 *              actualLength,
  KCItemRef *           item);                 /* can be NULL */


/* Storing and retrieving Internet passwords */
/*
 *  KCAddInternetPassword()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
KCAddInternetPassword(
  StringPtr     serverName,
  StringPtr     securityDomain,
  StringPtr     accountName,
  UInt16        port,
  OSType        protocol,
  OSType        authType,
  UInt32        passwordLength,
  const void *  passwordData,
  KCItemRef *   item);                /* can be NULL */


/*
 *  KCAddInternetPasswordWithPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
KCAddInternetPasswordWithPath(
  StringPtr     serverName,
  StringPtr     securityDomain,
  StringPtr     accountName,
  StringPtr     path,
  UInt16        port,
  OSType        protocol,
  OSType        authType,
  UInt32        passwordLength,
  const void *  passwordData,
  KCItemRef *   item);                /* can be NULL */


/*
 *  KCFindInternetPassword()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
KCFindInternetPassword(
  StringPtr    serverName,           /* can be NULL */
  StringPtr    securityDomain,       /* can be NULL */
  StringPtr    accountName,          /* can be NULL */
  UInt16       port,
  OSType       protocol,
  OSType       authType,
  UInt32       maxLength,
  void *       passwordData,
  UInt32 *     actualLength,
  KCItemRef *  item);                /* can be NULL */


/*
 *  KCFindInternetPasswordWithPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
KCFindInternetPasswordWithPath(
  StringPtr    serverName,           /* can be NULL */
  StringPtr    securityDomain,       /* can be NULL */
  StringPtr    accountName,          /* can be NULL */
  StringPtr    path,                 /* can be NULL */
  UInt16       port,
  OSType       protocol,
  OSType       authType,
  UInt32       maxLength,
  void *       passwordData,
  UInt32 *     actualLength,
  KCItemRef *  item);                /* can be NULL */


/* Storing and retrieving other types of passwords */
/*
 *  KCAddGenericPassword()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
KCAddGenericPassword(
  StringPtr     serviceName,
  StringPtr     accountName,
  UInt32        passwordLength,
  const void *  passwordData,
  KCItemRef *   item);                /* can be NULL */


/*
 *  KCFindGenericPassword()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
KCFindGenericPassword(
  StringPtr    serviceName,        /* can be NULL */
  StringPtr    accountName,        /* can be NULL */
  UInt32       maxLength,
  void *       passwordData,
  UInt32 *     actualLength,
  KCItemRef *  item);              /* can be NULL */




/* Routines that use "C" strings */
/*
 *  kcunlock()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
kcunlock(
  KCRef         keychain,       /* can be NULL */
  const char *  password);      /* can be NULL */


/*
 *  kccreatekeychain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
kccreatekeychain(
  const char *  password,       /* can be NULL */
  KCRef *       keychain);      /* can be NULL */


/*
 *  kcaddapplesharepassword()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
kcaddapplesharepassword(
  AFPServerSignature *  serverSignature,
  const char *          serverAddress,
  const char *          serverName,
  const char *          volumeName,
  const char *          accountName,
  UInt32                passwordLength,
  const void *          passwordData,
  KCItemRef *           item);                 /* can be NULL */


/*
 *  kcfindapplesharepassword()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
kcfindapplesharepassword(
  AFPServerSignature *  serverSignature,       /* can be NULL */
  const char *          serverAddress,         /* can be NULL */
  const char *          serverName,            /* can be NULL */
  const char *          volumeName,            /* can be NULL */
  const char *          accountName,           /* can be NULL */
  UInt32                maxLength,
  void *                passwordData,
  UInt32 *              actualLength,
  KCItemRef *           item);                 /* can be NULL */


/*
 *  kcaddinternetpassword()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
kcaddinternetpassword(
  const char *  serverName,
  const char *  securityDomain,
  const char *  accountName,
  UInt16        port,
  OSType        protocol,
  OSType        authType,
  UInt32        passwordLength,
  const void *  passwordData,
  KCItemRef *   item);                /* can be NULL */


/*
 *  kcaddinternetpasswordwithpath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
kcaddinternetpasswordwithpath(
  const char *  serverName,
  const char *  securityDomain,
  const char *  accountName,
  const char *  path,
  UInt16        port,
  OSType        protocol,
  OSType        authType,
  UInt32        passwordLength,
  const void *  passwordData,
  KCItemRef *   item);                /* can be NULL */


/*
 *  kcfindinternetpassword()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
kcfindinternetpassword(
  const char *  serverName,           /* can be NULL */
  const char *  securityDomain,       /* can be NULL */
  const char *  accountName,          /* can be NULL */
  UInt16        port,
  OSType        protocol,
  OSType        authType,
  UInt32        maxLength,
  void *        passwordData,
  UInt32 *      actualLength,
  KCItemRef *   item);                /* can be NULL */


/*
 *  kcfindinternetpasswordwithpath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
kcfindinternetpasswordwithpath(
  const char *  serverName,           /* can be NULL */
  const char *  securityDomain,       /* can be NULL */
  const char *  accountName,          /* can be NULL */
  const char *  path,                 /* can be NULL */
  UInt16        port,
  OSType        protocol,
  OSType        authType,
  UInt32        maxLength,
  void *        passwordData,
  UInt32 *      actualLength,
  KCItemRef *   item);                /* can be NULL */


/*
 *  kcaddgenericpassword()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
kcaddgenericpassword(
  const char *  serviceName,
  const char *  accountName,
  UInt32        passwordLength,
  const void *  passwordData,
  KCItemRef *   item);                /* can be NULL */


/*
 *  kcfindgenericpassword()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
kcfindgenericpassword(
  const char *  serviceName,        /* can be NULL */
  const char *  accountName,        /* can be NULL */
  UInt32        maxLength,
  void *        passwordData,
  UInt32 *      actualLength,
  KCItemRef *   item);              /* can be NULL */


/* Working with certificates */
#if CALL_NOT_IN_CARBON
/*
 *  KCFindX509Certificates()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
KCFindX509Certificates(
  KCRef                 keychain,
  CFStringRef           name,
  CFStringRef           emailAddress,
  KCCertSearchOptions   options,
  CFMutableArrayRef *   certificateItems);      /* can be NULL */


/*
 *  KCChooseCertificate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
KCChooseCertificate(
  CFArrayRef       items,
  KCItemRef *      certificate,
  CFArrayRef       policyOIDs,
  KCVerifyStopOn   stopOn);



#endif  /* CALL_NOT_IN_CARBON */


#if PRAGMA_STRUCT_ALIGN
    #pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
    #pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __KEYCHAINHI__ */

