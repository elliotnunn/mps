{
     File:       CMScriptingPlugin.p
 
     Contains:   ColorSync Scripting Plugin API
 
     Version:    Technology: ColorSync 2.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1998-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CMScriptingPlugin;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CMSCRIPTINGPLUGIN__}
{$SETC __CMSCRIPTINGPLUGIN__ := 1}

{$I+}
{$SETC CMScriptingPluginIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __CMAPPLICATION__}
{$I CMApplication.p}
{$ENDC}




{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{  ColorSync Scripting AppleEvent Errors  }
	cmspInvalidImageFile		= -4220;						{  Plugin cannot handle this image file type  }
	cmspInvalidImageSpace		= -4221;						{  Plugin cannot create an image file of this colorspace  }
	cmspInvalidProfileEmbed		= -4222;						{  Specific invalid profile errors  }
	cmspInvalidProfileSource	= -4223;
	cmspInvalidProfileDest		= -4224;
	cmspInvalidProfileProof		= -4225;
	cmspInvalidProfileLink		= -4226;


	{	*** embedFlags field  ***	}
	{	 reserved for future use: currently 0 	}

	{	*** matchFlags field  ***	}
	cmspFavorEmbeddedMask		= $00000001;					{  if bit 0 is 0 then use srcProf profile, if 1 then use profile embedded in image if present }


	{	*** scripting plugin entry points  ***	}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ValidateImageProcPtr = FUNCTION({CONST}VAR spec: FSSpec): CMError; C;
{$ELSEC}
	ValidateImageProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	GetImageSpaceProcPtr = FUNCTION({CONST}VAR spec: FSSpec; VAR space: OSType): CMError; C;
{$ELSEC}
	GetImageSpaceProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ValidateSpaceProcPtr = FUNCTION({CONST}VAR spec: FSSpec; VAR space: OSType): CMError; C;
{$ELSEC}
	ValidateSpaceProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	EmbedImageProcPtr = FUNCTION({CONST}VAR specFrom: FSSpec; {CONST}VAR specInto: FSSpec; embedProf: CMProfileRef; embedFlags: UInt32): CMError; C;
{$ELSEC}
	EmbedImageProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	UnembedImageProcPtr = FUNCTION({CONST}VAR specFrom: FSSpec; {CONST}VAR specInto: FSSpec): CMError; C;
{$ELSEC}
	UnembedImageProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MatchImageProcPtr = FUNCTION({CONST}VAR specFrom: FSSpec; {CONST}VAR specInto: FSSpec; qual: UInt32; srcIntent: UInt32; srcProf: CMProfileRef; dstProf: CMProfileRef; prfProf: CMProfileRef; matchFlags: UInt32): CMError; C;
{$ELSEC}
	MatchImageProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CountImageProfilesProcPtr = FUNCTION({CONST}VAR spec: FSSpec; VAR count: UInt32): CMError; C;
{$ELSEC}
	CountImageProfilesProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	GetIndImageProfileProcPtr = FUNCTION({CONST}VAR spec: FSSpec; index: UInt32; VAR prof: CMProfileRef): CMError; C;
{$ELSEC}
	GetIndImageProfileProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	SetIndImageProfileProcPtr = FUNCTION({CONST}VAR specFrom: FSSpec; {CONST}VAR specInto: FSSpec; index: UInt32; prof: CMProfileRef; embedFlags: UInt32): CMError; C;
{$ELSEC}
	SetIndImageProfileProcPtr = ProcPtr;
{$ENDC}

	{	*** CSScriptingLib API  ***	}

	{
	 *  CMValidImage()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in CSScriptingLib 2.6 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in 3.0 and later
	 	}
FUNCTION CMValidImage({CONST}VAR spec: FSSpec): CMError; C;

{
 *  CMGetImageSpace()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CSScriptingLib 2.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetImageSpace({CONST}VAR spec: FSSpec; VAR space: OSType): CMError; C;

{
 *  CMEmbedImage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CSScriptingLib 2.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMEmbedImage({CONST}VAR specFrom: FSSpec; {CONST}VAR specInto: FSSpec; repl: BOOLEAN; embProf: CMProfileRef): CMError; C;

{
 *  CMUnembedImage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CSScriptingLib 2.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMUnembedImage({CONST}VAR specFrom: FSSpec; {CONST}VAR specInto: FSSpec; repl: BOOLEAN): CMError; C;

{
 *  CMMatchImage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CSScriptingLib 2.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMMatchImage({CONST}VAR specFrom: FSSpec; {CONST}VAR specInto: FSSpec; repl: BOOLEAN; qual: UInt32; srcProf: CMProfileRef; srcIntent: UInt32; dstProf: CMProfileRef): CMError; C;

{
 *  CMProofImage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CSScriptingLib 2.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMProofImage({CONST}VAR specFrom: FSSpec; {CONST}VAR specInto: FSSpec; repl: BOOLEAN; qual: UInt32; srcProf: CMProfileRef; srcIntent: UInt32; dstProf: CMProfileRef; prfProf: CMProfileRef): CMError; C;

{
 *  CMLinkImage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CSScriptingLib 2.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMLinkImage({CONST}VAR specFrom: FSSpec; {CONST}VAR specInto: FSSpec; repl: BOOLEAN; qual: UInt32; lnkProf: CMProfileRef; lnkIntent: UInt32): CMError; C;

{
 *  CMCountImageProfiles()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CSScriptingLib 2.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMCountImageProfiles({CONST}VAR spec: FSSpec; VAR count: UInt32): CMError; C;

{
 *  CMGetIndImageProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CSScriptingLib 2.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetIndImageProfile({CONST}VAR spec: FSSpec; index: UInt32; VAR prof: CMProfileRef): CMError; C;

{
 *  CMSetIndImageProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CSScriptingLib 2.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMSetIndImageProfile({CONST}VAR specFrom: FSSpec; {CONST}VAR specInto: FSSpec; repl: BOOLEAN; index: UInt32; prof: CMProfileRef): CMError; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMScriptingPluginIncludes}

{$ENDC} {__CMSCRIPTINGPLUGIN__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
