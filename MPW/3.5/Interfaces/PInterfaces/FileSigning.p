{
     File:       FileSigning.p
 
     Contains:   Apple File Signing Interfaces.
 
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
 UNIT FileSigning;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FILESIGNING__}
{$SETC __FILESIGNING__ := 1}

{$I+}
{$SETC FileSigningIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __KEYCHAIN__}
{$I Keychain.p}
{$ENDC}

{$IFC UNDEFINED __CRYPTOMESSAGESYNTAX__}
{$I CryptoMessageSyntax.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Data structures and types }

TYPE
	SecOptions 					= SInt32;
CONST
	kSecOptionProgress			= $01;
	kSecOptionShowVerifyUI		= $02;
	kSecOptionNeverShowUI		= $04;
	kCertUsageReserved			= $7FFFFF00;					{  Last 3 bytes reserved for SecOptions flags  }


TYPE
	SecSignatureType 			= UInt32;
CONST
	kSecSignatureTypeRawPKCS7	= 0;
	kSecSignatureTypeCMS		= 1;
	kSecSignatureTypePGP		= 2;							{  reserved but not implemented  }


TYPE
	SecTrustPolicy 				= UInt32;
CONST
	kSecTrustPolicyCodeSigning	= 0;
	kSecTrustPolicyPersonalFileSigning = 1;


TYPE
	SecProgressCallbackInfoPtr = ^SecProgressCallbackInfo;
	SecProgressCallbackInfo = RECORD
		version:				UInt32;
		bytesProcessed:			UInt32;
		totalBytes:				UInt32;
		itemsRemainingToSign:	UInt32;
		totalItemsToSign:		UInt32;
		secondsRemaining:		UInt32;
		secondsElapsed:			UInt32;
		microSecondsPerByte:	UInt32;
		fileName:				Str255;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	SecProgressCallbackProcPtr = FUNCTION(VAR callbackInfo: SecProgressCallbackInfo; userContext: UNIV Ptr): OSStatus;
{$ELSEC}
	SecProgressCallbackProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	SecProgressCallbackUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SecProgressCallbackUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppSecProgressCallbackProcInfo = $000003F0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewSecProgressCallbackUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewSecProgressCallbackUPP(userRoutine: SecProgressCallbackProcPtr): SecProgressCallbackUPP; { old name was NewSecProgressCallbackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeSecProgressCallbackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeSecProgressCallbackUPP(userUPP: SecProgressCallbackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeSecProgressCallbackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeSecProgressCallbackUPP(VAR callbackInfo: SecProgressCallbackInfo; userContext: UNIV Ptr; userRoutine: SecProgressCallbackUPP): OSStatus; { old name was CallSecProgressCallbackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  SecSetProgressCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FileSigningLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SecSetProgressCallback(callbackProc: SecProgressCallbackUPP; userContext: UNIV Ptr): OSStatus;

{
 *  SecRemoveProgressCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FileSigningLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SecRemoveProgressCallback(callbackProc: SecProgressCallbackUPP): OSStatus;

{
 *  DefaultSecProgressCallbackProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FileSigningLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DefaultSecProgressCallbackProc(VAR info: SecProgressCallbackInfo; userContext: UNIV Ptr): OSStatus;

{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	kSecDefaultSignatureResID	= 1;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  SecMacSignFile()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in FileSigningLib 1.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION SecMacSignFile(VAR theFile: FSSpec; signingCertificate: KCItemRef; sigH: Handle; options: SecOptions; progressProc: SecProgressCallbackUPP; userContext: UNIV Ptr): OSStatus;

{
 *  SecMacSignFileSimple()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FileSigningLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SecMacSignFileSimple(VAR theFile: FSSpec; signingCertificate: KCItemRef; options: SecOptions): OSStatus;

{
 *  SecMacLoadSigPound()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FileSigningLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SecMacLoadSigPound(VAR theFile: FSSpec; VAR resHandle: Handle): OSStatus;

{
 *  SecMacRemoveSignature()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FileSigningLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SecMacRemoveSignature(VAR theFile: FSSpec; signatureType: SecSignatureType; signatureToRemove: SInt16): OSStatus;

{
 *  SecMacRemoveAllSignatures()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FileSigningLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SecMacRemoveAllSignatures(VAR theFile: FSSpec; signatureType: SecSignatureType): OSStatus;


{
 *  SecMacVerifyFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FileSigningLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SecMacVerifyFile(VAR theFile: FSSpec; options: SecOptions; progressProc: SecProgressCallbackUPP; userContext: UNIV Ptr; signatureToVerify: SInt16; policyOIDs: CFArrayRef; stopOn: KCVerifyStopOn; VAR signer: SecSignerRef): OSStatus;

{
 *  SecMacVerifyFileSimple()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FileSigningLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SecMacVerifyFileSimple(VAR theFile: FSSpec; options: SecOptions; trustPolicy: SecTrustPolicy; VAR signer: SecSignerRef): OSStatus;

{
 *  SecMacHasSignature()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FileSigningLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SecMacHasSignature(VAR theFile: FSSpec; signatureType: SecSignatureType): BOOLEAN;

{
 *  SecMacFindSignatureToVerify()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FileSigningLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SecMacFindSignatureToVerify(VAR theFile: FSSpec; signatureType: SecSignatureType; VAR signatureToVerify: SInt16): OSStatus;

{
 *  SecMacGetDefaultPolicyOIDs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FileSigningLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SecMacGetDefaultPolicyOIDs(trustPolicy: SecTrustPolicy): CFArrayRef;


{
 *  SecMacDisplaySigner()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FileSigningLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SecMacDisplaySigner(inputErr: OSStatus; signer: SecSignerRef; alwaysShowUI: BOOLEAN; VAR theFile: FSSpec): OSStatus;

{ Errors Codes }
{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	errSecTooManySigners		= -13839;
	errSecSigningFailed			= -13838;
	errSecCorruptSigPound		= -13837;
	errSecNoSignatureFound		= -13836;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FileSigningIncludes}

{$ENDC} {__FILESIGNING__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
