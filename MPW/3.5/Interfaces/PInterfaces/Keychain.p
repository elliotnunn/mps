{
     File:       Keychain.p
 
     Contains:   Keychain Interfaces.
 
     Version:    Technology: Keychain 2.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1997-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Keychain;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __KEYCHAIN__}
{$SETC __KEYCHAIN__ := 1}

{$I+}
{$SETC KeychainIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __KEYCHAINCORE__}
{$I KeychainCore.p}
{$ENDC}
{$IFC UNDEFINED __KEYCHAINHI__}
{$I KeychainHI.p}
{$ENDC}

{ this file has been split into KeychainCore.h and KeychainHI.h }
{$SETC UsingIncludes := KeychainIncludes}

{$ENDC} {__KEYCHAIN__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
