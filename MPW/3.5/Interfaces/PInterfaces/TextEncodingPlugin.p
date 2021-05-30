{
     File:       TextEncodingPlugin.p
 
     Contains:   Required interface for Text Encoding Converter-Plugins
 
     Version:    Technology: Mac OS 8
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1996-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT TextEncodingPlugin;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TEXTENCODINGPLUGIN__}
{$SETC __TEXTENCODINGPLUGIN__ := 1}

{$I+}
{$SETC TextEncodingPluginIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}
{$IFC UNDEFINED __TEXTENCODINGCONVERTER__}
{$I TextEncodingConverter.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
####################################################################################
        Structs
####################################################################################
}

TYPE
	TECBufferContextRecPtr = ^TECBufferContextRec;
	TECBufferContextRec = RECORD
		textInputBuffer:		TextPtr;
		textInputBufferEnd:		TextPtr;
		textOutputBuffer:		TextPtr;
		textOutputBufferEnd:	TextPtr;
		encodingInputBuffer:	TextEncodingRunPtr;
		encodingInputBufferEnd:	TextEncodingRunPtr;
		encodingOutputBuffer:	TextEncodingRunPtr;
		encodingOutputBufferEnd: TextEncodingRunPtr;
	END;

	TECPluginStateRecPtr = ^TECPluginStateRec;
	TECPluginStateRec = RECORD
		state1:					SInt8;
		state2:					SInt8;
		state3:					SInt8;
		state4:					SInt8;
		longState1:				UInt32;
		longState2:				UInt32;
		longState3:				UInt32;
		longState4:				UInt32;
	END;

	TECConverterContextRecPtr = ^TECConverterContextRec;
	TECConverterContextRec = RECORD
																		{  public - manipulated externally and by plugin }
		pluginRec:				Ptr;
		sourceEncoding:			TextEncoding;
		destEncoding:			TextEncoding;
		reserved1:				UInt32;
		reserved2:				UInt32;
		bufferContext:			TECBufferContextRec;
																		{  private - manipulated only within Plugin }
		contextRefCon:			UInt32;
		conversionProc:			ProcPtr;
		flushProc:				ProcPtr;
		clearContextInfoProc:	ProcPtr;
		options1:				UInt32;
		options2:				UInt32;
		pluginState:			TECPluginStateRec;
	END;

	TECSnifferContextRecPtr = ^TECSnifferContextRec;
	TECSnifferContextRec = RECORD
																		{  public - manipulated externally }
		pluginRec:				Ptr;
		encoding:				TextEncoding;
		maxErrors:				ItemCount;
		maxFeatures:			ItemCount;
		textInputBuffer:		TextPtr;
		textInputBufferEnd:		TextPtr;
		numFeatures:			ItemCount;
		numErrors:				ItemCount;
																		{  private - manipulated only within Plugin }
		contextRefCon:			UInt32;
		sniffProc:				ProcPtr;
		clearContextInfoProc:	ProcPtr;
		pluginState:			TECPluginStateRec;
	END;

	{
	  ####################################################################################
	        Functional Messages
	  ####################################################################################
	}

{$IFC TYPED_FUNCTION_POINTERS}
	TECPluginNewEncodingConverterPtr = FUNCTION(VAR newEncodingConverter: TECObjectRef; VAR plugContext: TECConverterContextRec; inputEncoding: TextEncoding; outputEncoding: TextEncoding): OSStatus; C;
{$ELSEC}
	TECPluginNewEncodingConverterPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TECPluginClearContextInfoPtr = FUNCTION(encodingConverter: TECObjectRef; VAR plugContext: TECConverterContextRec): OSStatus; C;
{$ELSEC}
	TECPluginClearContextInfoPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TECPluginConvertTextEncodingPtr = FUNCTION(encodingConverter: TECObjectRef; VAR plugContext: TECConverterContextRec): OSStatus; C;
{$ELSEC}
	TECPluginConvertTextEncodingPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TECPluginFlushConversionPtr = FUNCTION(encodingConverter: TECObjectRef; VAR plugContext: TECConverterContextRec): OSStatus; C;
{$ELSEC}
	TECPluginFlushConversionPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TECPluginDisposeEncodingConverterPtr = FUNCTION(newEncodingConverter: TECObjectRef; VAR plugContext: TECConverterContextRec): OSStatus; C;
{$ELSEC}
	TECPluginDisposeEncodingConverterPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TECPluginNewEncodingSnifferPtr = FUNCTION(VAR encodingSniffer: TECSnifferObjectRef; VAR snifContext: TECSnifferContextRec; inputEncoding: TextEncoding): OSStatus; C;
{$ELSEC}
	TECPluginNewEncodingSnifferPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TECPluginClearSnifferContextInfoPtr = FUNCTION(encodingSniffer: TECSnifferObjectRef; VAR snifContext: TECSnifferContextRec): OSStatus; C;
{$ELSEC}
	TECPluginClearSnifferContextInfoPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TECPluginSniffTextEncodingPtr = FUNCTION(encodingSniffer: TECSnifferObjectRef; VAR snifContext: TECSnifferContextRec): OSStatus; C;
{$ELSEC}
	TECPluginSniffTextEncodingPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TECPluginDisposeEncodingSnifferPtr = FUNCTION(encodingSniffer: TECSnifferObjectRef; VAR snifContext: TECSnifferContextRec): OSStatus; C;
{$ELSEC}
	TECPluginDisposeEncodingSnifferPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TECPluginGetCountAvailableTextEncodingsPtr = FUNCTION(VAR availableEncodings: TextEncoding; maxAvailableEncodings: ItemCount; VAR actualAvailableEncodings: ItemCount): OSStatus; C;
{$ELSEC}
	TECPluginGetCountAvailableTextEncodingsPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TECPluginGetCountAvailableTextEncodingPairsPtr = FUNCTION(VAR availableEncodings: TECConversionInfo; maxAvailableEncodings: ItemCount; VAR actualAvailableEncodings: ItemCount): OSStatus; C;
{$ELSEC}
	TECPluginGetCountAvailableTextEncodingPairsPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TECPluginGetCountDestinationTextEncodingsPtr = FUNCTION(inputEncoding: TextEncoding; VAR destinationEncodings: TextEncoding; maxDestinationEncodings: ItemCount; VAR actualDestinationEncodings: ItemCount): OSStatus; C;
{$ELSEC}
	TECPluginGetCountDestinationTextEncodingsPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TECPluginGetCountSubTextEncodingsPtr = FUNCTION(inputEncoding: TextEncoding; VAR subEncodings: TextEncoding; maxSubEncodings: ItemCount; VAR actualSubEncodings: ItemCount): OSStatus; C;
{$ELSEC}
	TECPluginGetCountSubTextEncodingsPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TECPluginGetCountAvailableSniffersPtr = FUNCTION(VAR availableEncodings: TextEncoding; maxAvailableEncodings: ItemCount; VAR actualAvailableEncodings: ItemCount): OSStatus; C;
{$ELSEC}
	TECPluginGetCountAvailableSniffersPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TECPluginGetTextEncodingInternetNamePtr = FUNCTION(textEncoding: TextEncoding; VAR encodingName: Str255): OSStatus; C;
{$ELSEC}
	TECPluginGetTextEncodingInternetNamePtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TECPluginGetTextEncodingFromInternetNamePtr = FUNCTION(VAR textEncoding: TextEncoding; encodingName: Str255): OSStatus; C;
{$ELSEC}
	TECPluginGetTextEncodingFromInternetNamePtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TECPluginGetCountWebEncodingsPtr = FUNCTION(VAR availableEncodings: TextEncoding; maxAvailableEncodings: ItemCount; VAR actualAvailableEncodings: ItemCount): OSStatus; C;
{$ELSEC}
	TECPluginGetCountWebEncodingsPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TECPluginGetCountMailEncodingsPtr = FUNCTION(VAR availableEncodings: TextEncoding; maxAvailableEncodings: ItemCount; VAR actualAvailableEncodings: ItemCount): OSStatus; C;
{$ELSEC}
	TECPluginGetCountMailEncodingsPtr = ProcPtr;
{$ENDC}

	{
	  ####################################################################################
	        Dispatch Table Definition
	  ####################################################################################
	}


CONST
	kTECPluginDispatchTableVersion1 = $00010000;				{  1.0 through 1.0.3 releases }
	kTECPluginDispatchTableVersion1_1 = $00010001;				{  1.1 releases }
	kTECPluginDispatchTableVersion1_2 = $00010002;				{  1.2 releases }
	kTECPluginDispatchTableCurrentVersion = $00010002;


TYPE
	TECPluginDispatchTablePtr = ^TECPluginDispatchTable;
	TECPluginDispatchTable = RECORD
		version:				TECPluginVersion;
		compatibleVersion:		TECPluginVersion;
		PluginID:				TECPluginSignature;
		PluginNewEncodingConverter: TECPluginNewEncodingConverterPtr;
		PluginClearContextInfo:	TECPluginClearContextInfoPtr;
		PluginConvertTextEncoding: TECPluginConvertTextEncodingPtr;
		PluginFlushConversion:	TECPluginFlushConversionPtr;
		PluginDisposeEncodingConverter: TECPluginDisposeEncodingConverterPtr;
		PluginNewEncodingSniffer: TECPluginNewEncodingSnifferPtr;
		PluginClearSnifferContextInfo: TECPluginClearSnifferContextInfoPtr;
		PluginSniffTextEncoding: TECPluginSniffTextEncodingPtr;
		PluginDisposeEncodingSniffer: TECPluginDisposeEncodingSnifferPtr;
		PluginGetCountAvailableTextEncodings: TECPluginGetCountAvailableTextEncodingsPtr;
		PluginGetCountAvailableTextEncodingPairs: TECPluginGetCountAvailableTextEncodingPairsPtr;
		PluginGetCountDestinationTextEncodings: TECPluginGetCountDestinationTextEncodingsPtr;
		PluginGetCountSubTextEncodings: TECPluginGetCountSubTextEncodingsPtr;
		PluginGetCountAvailableSniffers: TECPluginGetCountAvailableSniffersPtr;
		PluginGetCountWebTextEncodings: TECPluginGetCountWebEncodingsPtr;
		PluginGetCountMailTextEncodings: TECPluginGetCountMailEncodingsPtr;
		PluginGetTextEncodingInternetName: TECPluginGetTextEncodingInternetNamePtr;
		PluginGetTextEncodingFromInternetName: TECPluginGetTextEncodingFromInternetNamePtr;
	END;







{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TextEncodingPluginIncludes}

{$ENDC} {__TEXTENCODINGPLUGIN__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
