{
     File:       CryptoMessageSyntax.p
 
     Contains:   CMS Interfaces.
 
     Version:    Technology: 1.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CryptoMessageSyntax;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CRYPTOMESSAGESYNTAX__}
{$SETC __CRYPTOMESSAGESYNTAX__ := 1}

{$I+}
{$SETC CryptoMessageSyntaxIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __CODEFRAGMENTS__}
{$I CodeFragments.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
    Data structures and types
}

TYPE
	SecTypeRef    = ^LONGINT; { an opaque 32-bit type }
	SecTypeRefPtr = ^SecTypeRef;  { when a VAR xx:SecTypeRef parameter can be nil, it is changed to xx: SecTypeRefPtr }
	SecSignerRef    = ^LONGINT; { an opaque 32-bit type }
	SecSignerRefPtr = ^SecSignerRef;  { when a VAR xx:SecSignerRef parameter can be nil, it is changed to xx: SecSignerRefPtr }
	{	 Signer object manipulation 	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  SecSignerGetStatus()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in CMSLib 1.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION SecSignerGetStatus(signer: SecSignerRef): OSStatus;

{
 *  SecRetain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CMSLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SecRetain(sec: SecTypeRef): SecTypeRef;

{
 *  SecRelease()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CMSLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SecRelease(sec: SecTypeRef);

{
 *  SecRetainCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CMSLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SecRetainCount(sec: SecTypeRef): UInt32;

{ Errors Codes  }
{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	errSecUnsupported			= -13843;
	errSecInvalidData			= -13844;
	errSecTooMuchData			= -13845;
	errSecMissingData			= -13846;
	errSecNoSigners				= -13847;
	errSecSignerFailed			= -13848;
	errSecInvalidPolicy			= -13849;
	errSecUnknownPolicy			= -13850;
	errSecInvalidStopOn			= -13851;
	errSecMissingCert			= -13852;
	errSecInvalidCert			= -13853;
	errSecNotSigner				= -13854;
	errSecNotTrusted			= -13855;
	errSecMissingAttribute		= -13856;
	errSecMissingDigest			= -13857;
	errSecDigestMismatch		= -13858;
	errSecInvalidSignature		= -13859;
	errSecAlgMismatch			= -13860;
	errSecUnsupportedAlgorithm	= -13864;
	errSecContentTypeMismatch	= -13865;
	errSecDebugRoot				= -13866;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CryptoMessageSyntaxIncludes}

{$ENDC} {__CRYPTOMESSAGESYNTAX__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
