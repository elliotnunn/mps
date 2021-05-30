{
 	File:		SoundInput.p
 
 	Contains:	Sound Input Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.3
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT SoundInput;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SOUNDINPUT__}
{$SETC __SOUNDINPUT__ := 1}

{$I+}
{$SETC SoundInputIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{	Errors.p													}
{	Memory.p													}
{		MixedMode.p												}
{	OSUtils.p													}
{	Events.p													}
{		Quickdraw.p												}
{			QuickdrawText.p										}
{	EPPC.p														}
{		AppleTalk.p												}
{		Files.p													}
{			Finder.p											}
{		PPCToolbox.p											}
{		Processes.p												}
{	Notification.p												}

{$IFC UNDEFINED __WINDOWS__}
{$I Windows.p}
{$ENDC}
{	Controls.p													}
{		Menus.p													}

{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{	TextEdit.p													}

{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}

{$IFC UNDEFINED __SOUND__}
{$I Sound.p}
{$ENDC}
{	Components.p												}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
						* * *  N O T E  * * *

	This file has been updated to include Sound Input Manager 1.1 interfaces.

	Some of the Sound Input Manager 1.1 interfaces were not put into the InterfaceLib
	that originally shipped with the PowerMacs. These missing functions and the
	new 1.1 interfaces have been released in the SoundLib library for PowerPC
	developers to link with. The runtime library for these functions are
	installed by Sound Manager 3.2. The following functions are found in SoundLib.

		ParseAIFFHeader(), ParseSndHeader()

}

CONST
	siDeviceIsConnected			= 1;							{input device is connected and ready for input}
	siDeviceNotConnected		= 0;							{input device is not connected}
	siDontKnowIfConnected		= -1;							{can't tell if input device is connected}
	siReadPermission			= 0;							{permission passed to SPBOpenDevice}
	siWritePermission			= 1;							{permission passed to SPBOpenDevice}

{Info Selectors for Sound Input Drivers}
	siActiveChannels			= 'chac';						{active channels}
	siActiveLevels				= 'lmac';						{active meter levels}
	siAGCOnOff					= 'agc ';						{automatic gain control state}
	siAsync						= 'asyn';						{asynchronous capability}
	siChannelAvailable			= 'chav';						{number of channels available}
	siCompressionAvailable		= 'cmav';						{compression types available}
	siCompressionFactor			= 'cmfa';						{current compression factor}
	siCompressionHeader			= 'cmhd';						{return compression header}
	siCompressionNames			= 'cnam';						{compression type names available}
	siCompressionType			= 'comp';						{current compression type}
	siContinuous				= 'cont';						{continous recording}
	siDeviceBufferInfo			= 'dbin';						{size of interrupt buffer}
	siDeviceConnected			= 'dcon';						{input device connection status}
	siDeviceIcon				= 'icon';						{input device icon}
	siDeviceName				= 'name';						{input device name}
	siHardwareBusy				= 'hwbs';						{sound hardware is in use}
	siInputGain					= 'gain';						{input gain}
	siInputSource				= 'sour';						{input source selector}
	siInputSourceNames			= 'snam';						{input source names}
	siLevelMeterOnOff			= 'lmet';						{level meter state}
	siModemGain					= 'mgai';						{modem input gain}
	siNumberChannels			= 'chan';						{current number of channels}
	siOptionsDialog				= 'optd';						{display options dialog}
	siPlayThruOnOff				= 'plth';						{playthrough state}
	siRecordingQuality			= 'qual';						{recording quality}
	siSampleRate				= 'srat';						{current sample rate}
	siSampleRateAvailable		= 'srav';						{sample rates available}
	siSampleSize				= 'ssiz';						{current sample size}
	siSampleSizeAvailable		= 'ssav';						{sample sizes available}
	siSetupCDAudio				= 'sucd';						{setup sound hardware for CD audio}
	siSetupModemAudio			= 'sumd';						{setup sound hardware for modem audio}
	siStereoInputGain			= 'sgai';						{stereo input gain}
	siTwosComplementOnOff		= 'twos';						{two's complement state}
	siVoxRecordInfo				= 'voxr';						{VOX record parameters}
	siVoxStopInfo				= 'voxs';						{VOX stop parameters}
	siCloseDriver				= 'clos';						{reserved for internal use only}
	siInitializeDriver			= 'init';						{reserved for internal use only}
	siPauseRecording			= 'paus';						{reserved for internal use only}
	siUserInterruptProc			= 'user';						{reserved for internal use only}
{Qualities}
	siCDQuality					= 'cd  ';						{44.1kHz, stereo, 16 bit}
	siBestQuality				= 'best';						{22kHz, mono, 8 bit}
	siBetterQuality				= 'betr';						{22kHz, mono, MACE 3:1}
	siGoodQuality				= 'good';						{22kHz, mono, MACE 6:1}

	
TYPE
	SPBPtr = ^SPB;

{user procedures called by sound input routines}
	{
		SIInterruptProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => inParamPtr  	A0.L
		 => dataBuffer  	A1.L
		 => peakAmplitude	D0.W
		 => sampleSize  	D1.L
	}
	SIInterruptProcPtr = Register68kProcPtr;  { register PROCEDURE SIInterrupt(inParamPtr: SPBPtr; dataBuffer: Ptr; peakAmplitude: INTEGER; sampleSize: LONGINT); }
	SICompletionProcPtr = ProcPtr;  { PROCEDURE SICompletion(inParamPtr: SPBPtr); }
	SIInterruptUPP = UniversalProcPtr;
	SICompletionUPP = UniversalProcPtr;

	SPB = RECORD
		inRefNum:				LONGINT;								{reference number of sound input device}
		count:					LONGINT;								{number of bytes to record}
		milliseconds:			LONGINT;								{number of milliseconds to record}
		bufferLength:			LONGINT;								{length of buffer in bytes}
		bufferPtr:				Ptr;									{buffer to store sound data in}
		completionRoutine:		SICompletionUPP;						{completion routine}
		interruptRoutine:		SIInterruptUPP;							{interrupt routine}
		userLong:				LONGINT;								{user-defined field}
		error:					OSErr;									{error}
		unused1:				LONGINT;								{reserved - must be zero}
	END;


FUNCTION SPBVersion: NumVersion;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, $0014, $A800;
	{$ENDC}
FUNCTION SndRecord(filterProc: ModalFilterUPP; corner: Point; quality: OSType; VAR sndHandle: SndListHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0804, $0014, $A800;
	{$ENDC}
FUNCTION SndRecordToFile(filterProc: ModalFilterUPP; corner: Point; quality: OSType; fRefNum: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0708, $0014, $A800;
	{$ENDC}
FUNCTION SPBSignInDevice(deviceRefNum: INTEGER; deviceName: ConstStr255Param): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $030C, $0014, $A800;
	{$ENDC}
FUNCTION SPBSignOutDevice(deviceRefNum: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0110, $0014, $A800;
	{$ENDC}
FUNCTION SPBGetIndexedDevice(count: INTEGER; VAR deviceName: Str255; VAR deviceIconHandle: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0514, $0014, $A800;
	{$ENDC}
FUNCTION SPBOpenDevice(deviceName: ConstStr255Param; permission: INTEGER; VAR inRefNum: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0518, $0014, $A800;
	{$ENDC}
FUNCTION SPBCloseDevice(inRefNum: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $021C, $0014, $A800;
	{$ENDC}
FUNCTION SPBRecord(inParamPtr: SPBPtr; asynchFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0320, $0014, $A800;
	{$ENDC}
FUNCTION SPBRecordToFile(fRefNum: INTEGER; inParamPtr: SPBPtr; asynchFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0424, $0014, $A800;
	{$ENDC}
FUNCTION SPBPauseRecording(inRefNum: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0228, $0014, $A800;
	{$ENDC}
FUNCTION SPBResumeRecording(inRefNum: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $022C, $0014, $A800;
	{$ENDC}
FUNCTION SPBStopRecording(inRefNum: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0230, $0014, $A800;
	{$ENDC}
FUNCTION SPBGetRecordingStatus(inRefNum: LONGINT; VAR recordingStatus: INTEGER; VAR meterLevel: INTEGER; VAR totalSamplesToRecord: LONGINT; VAR numberOfSamplesRecorded: LONGINT; VAR totalMsecsToRecord: LONGINT; VAR numberOfMsecsRecorded: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0E34, $0014, $A800;
	{$ENDC}
FUNCTION SPBGetDeviceInfo(inRefNum: LONGINT; infoType: OSType; infoData: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0638, $0014, $A800;
	{$ENDC}
FUNCTION SPBSetDeviceInfo(inRefNum: LONGINT; infoType: OSType; infoData: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $063C, $0014, $A800;
	{$ENDC}
FUNCTION SPBMillisecondsToBytes(inRefNum: LONGINT; VAR milliseconds: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0440, $0014, $A800;
	{$ENDC}
FUNCTION SPBBytesToMilliseconds(inRefNum: LONGINT; VAR byteCount: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0444, $0014, $A800;
	{$ENDC}
FUNCTION SetupSndHeader(sndHandle: SndListHandle; numChannels: INTEGER; sampleRate: UnsignedFixed; sampleSize: INTEGER; compressionType: OSType; baseNote: INTEGER; numBytes: LONGINT; VAR headerLen: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0D48, $0014, $A800;
	{$ENDC}
FUNCTION SetupAIFFHeader(fRefNum: INTEGER; numChannels: INTEGER; sampleRate: UnsignedFixed; sampleSize: INTEGER; compressionType: OSType; numBytes: LONGINT; numFrames: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0B4C, $0014, $A800;
	{$ENDC}
{  Sound Input Manager 1.1 and later calls  }
FUNCTION ParseAIFFHeader(fRefNum: INTEGER; VAR sndInfo: SoundComponentData; VAR numFrames: LONGINT; VAR dataOffset: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0758, $0014, $A800;
	{$ENDC}
FUNCTION ParseSndHeader(sndHandle: SndListHandle; VAR sndInfo: SoundComponentData; VAR numFrames: LONGINT; VAR dataOffset: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $085C, $0014, $A800;
	{$ENDC}

CONST
	uppSIInterruptProcInfo = $1C579802; { Register PROCEDURE (4 bytes in A0, 4 bytes in A1, 2 bytes in D0, 4 bytes in D1); }
	uppSICompletionProcInfo = $000000C0; { PROCEDURE (4 byte param); }

FUNCTION NewSIInterruptProc(userRoutine: SIInterruptProcPtr): SIInterruptUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSICompletionProc(userRoutine: SICompletionProcPtr): SICompletionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallSIInterruptProc(inParamPtr: SPBPtr; dataBuffer: Ptr; peakAmplitude: INTEGER; sampleSize: LONGINT; userRoutine: SIInterruptUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

PROCEDURE CallSICompletionProc(inParamPtr: SPBPtr; userRoutine: SICompletionUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SoundInputIncludes}

{$ENDC} {__SOUNDINPUT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
