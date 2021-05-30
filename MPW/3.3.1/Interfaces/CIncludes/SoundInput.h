/*
	File:		SoundInput.h

	Copyright:	© 1984-1993 by Apple Computer, Inc., all rights reserved.

	WARNING
	This file was auto generated by the interfacer tool. Modifications
	must be made to the master file.

*/

#ifndef __SOUNDINPUT__
#define __SOUNDINPUT__

#ifndef __TYPES__
#include <Types.h>
/*	#include <ConditionalMacros.h>								*/
/*	#include <MixedMode.h>										*/
/*		#include <Traps.h>										*/
#endif

#ifndef __DIALOGS__
#include <Dialogs.h>
/*	#include <Windows.h>										*/
/*		#include <Quickdraw.h>									*/
/*			#include <QuickdrawText.h>							*/
/*				#include <IntlResources.h>						*/
/*		#include <Events.h>										*/
/*			#include <OSUtils.h>								*/
/*		#include <Controls.h>									*/
/*			#include <Menus.h>									*/
/*	#include <TextEdit.h>										*/
#endif

#ifndef __FILES__
#include <Files.h>
/*	#include <SegLoad.h>										*/
#endif

enum  {
	siDeviceIsConnected			= 1,							/* input device is connected and ready for input */
	siDeviceNotConnected		= 0,							/* input device is not connected */
	siDontKnowIfConnected		= -1,							/* can't tell if input device is connected */
	siReadPermission			= 0,							/* permission passed to SPBOpenDevice */
	siWritePermission			= 1								/* permission passed to SPBOpenDevice */
};


/* Info Selectors for Sound Input Drivers */

#define siDeviceConnected 'dcon'

#define siAGCOnOff 'agc '

#define siPlayThruOnOff 'plth'

#define siTwosComplementOnOff 'twos'

#define siLevelMeterOnOff 'lmet'

#define siRecordingQuality 'qual'

#define siVoxRecordInfo 'voxr'

#define siVoxStopInfo 'voxs'

#define siNumberChannels 'chan'

#define siSampleSize 'ssiz'

#define siSampleRate 'srat'

#define siCompressionType 'comp'

#define siCompressionFactor 'cmfa'

#define siCompressionHeader 'cmhd'

#define siDeviceName 'name'

#define siDeviceIcon 'icon'

#define siDeviceBufferInfo 'dbin'

#define siSampleSizeAvailable 'ssav'

#define siSampleRateAvailable 'srav'

#define siCompressionAvailable 'cmav'

#define siChannelAvailable 'chav'

#define siAsync 'asyn'

#define siOptionsDialog 'optd'

#define siContinuous 'cont'

#define siActiveChannels 'chac'

#define siActiveLevels 'lmac'

#define siInputSource 'sour'

#define siInitializeDriver 'init'

#define siCloseDriver 'clos'

#define siPauseRecording 'paus'

#define siUserInterruptProc 'user'


/* Qualities */

#define siBestQuality 'best'

#define siBetterQuality 'betr'

#define siGoodQuality 'good'

typedef struct SPB SPB, *SPBPtr;


/* user procedures called by sound input routines */


/*
	SIInterruptProcs cannot be written in or called from a high-level 
	language without the help of mixed mode or assembly glue because they 
	use the following parameter-passing convention:

		typedef pascal void (*SIInterruptProcPtr)(SPBPtr inParamPtr, Ptr dataBuffer,
 			short peakAmplitude, long sampleSize);

		In:
			=> 	inParamPtr				A0.L
			=> 	dataBuffer				A1.L
			=> 	peakAmplitude			D0.W
			=> 	sampleSize				D1.L
		Out:
			none
*/

enum  {
	uppSIInterruptProcInfo		= kRegisterBased|REGISTER_ROUTINE_PARAMETER(1,kRegisterA0,kFourByteCode)|REGISTER_ROUTINE_PARAMETER(2,kRegisterA1,kFourByteCode)|REGISTER_ROUTINE_PARAMETER(3,kRegisterD0,kTwoByteCode)|REGISTER_ROUTINE_PARAMETER(4,kRegisterD1,kFourByteCode)
};

#if USESROUTINEDESCRIPTORS
typedef pascal void (*SIInterruptProcPtr)(SPBPtr inParamPtr, Ptr dataBuffer, short peakAmplitude, long sampleSize);

typedef UniversalProcPtr SIInterruptUPP;

#define CallSIInterruptProc(userRoutine, inParamPtr, dataBuffer, peakAmplitude, sampleSize)  \
	CallUniversalProc((UniversalProcPtr)(userRoutine), uppSIInterruptProcInfo, (inParamPtr),  \
	(dataBuffer), (peakAmplitude), (sampleSize))

#define NewSIInterruptProc(userRoutine)  \
	(SIInterruptUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSIInterruptProcInfo, GetCurrentISA())

#else
typedef ProcPtr SIInterruptUPP;

#define NewSIInterruptProc(userRoutine)  \
	(SIInterruptUPP)(userRoutine)

#endif

typedef pascal void (*SICompletionProcPtr)(SPBPtr inParamPtr);

enum {
	uppSICompletionProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SPBPtr)))
};

#if USESROUTINEDESCRIPTORS
typedef UniversalProcPtr SICompletionUPP;

#define CallSICompletionProc(userRoutine, inParamPtr)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSICompletionProcInfo, (inParamPtr))
#define NewSICompletionProc(userRoutine)		\
		(SICompletionUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSICompletionProcInfo, GetCurrentISA())
#else
typedef SICompletionProcPtr SICompletionUPP;

#define CallSICompletionProc(userRoutine, inParamPtr)		\
		(*(userRoutine))((inParamPtr))
#define NewSICompletionProc(userRoutine)		\
		(SICompletionUPP)(userRoutine)
#endif


/* Sound Input Parameter Block */

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct SPB {
	long						inRefNum;						/* reference number of sound input device */
	unsigned long				count;							/* number of bytes to record */
	unsigned long				milliseconds;					/* number of milliseconds to record */
	unsigned long				bufferLength;					/* length of buffer in bytes */
	Ptr							bufferPtr;						/* buffer to store sound data in */
	SICompletionUPP				completionRoutine;				/* completion routine */
	SIInterruptUPP				interruptRoutine;				/* interrupt routine */
	long						userLong;						/* user-defined field */
	OSErr						error;							/* error */
	long						unused1;						/* reserved - must be zero */
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

#ifdef __cplusplus
extern "C" {
#endif

extern pascal NumVersion SPBVersion(void)
 FOURWORDINLINE(0x203C, 0x0000, 0x0014, 0xA800);
extern pascal OSErr SndRecord(ModalFilterUPP filterProc, Point corner, OSType quality, Handle *sndHandle)
 FOURWORDINLINE(0x203C, 0x0804, 0x0014, 0xA800);
extern pascal OSErr SndRecordToFile(ModalFilterUPP filterProc, Point corner, OSType quality, short fRefNum)
 FOURWORDINLINE(0x203C, 0x0708, 0x0014, 0xA800);
extern pascal OSErr SPBSignInDevice(short deviceRefNum, ConstStr255Param deviceName)
 FOURWORDINLINE(0x203C, 0x030C, 0x0014, 0xA800);
extern pascal OSErr SPBSignOutDevice(short deviceRefNum)
 FOURWORDINLINE(0x203C, 0x0110, 0x0014, 0xA800);
extern pascal OSErr SPBGetIndexedDevice(short count, Str255 deviceName, Handle *deviceIconHandle)
 FOURWORDINLINE(0x203C, 0x0514, 0x0014, 0xA800);
extern pascal OSErr SPBOpenDevice(ConstStr255Param deviceName, short permission, long *inRefNum)
 FOURWORDINLINE(0x203C, 0x0518, 0x0014, 0xA800);
extern pascal OSErr SPBCloseDevice(long inRefNum)
 FOURWORDINLINE(0x203C, 0x021C, 0x0014, 0xA800);
extern pascal OSErr SPBRecord(SPBPtr inParamPtr, Boolean asynchFlag)
 FOURWORDINLINE(0x203C, 0x0320, 0x0014, 0xA800);
extern pascal OSErr SPBRecordToFile(short fRefNum, SPBPtr inParamPtr, Boolean asynchFlag)
 FOURWORDINLINE(0x203C, 0x0424, 0x0014, 0xA800);
extern pascal OSErr SPBPauseRecording(long inRefNum)
 FOURWORDINLINE(0x203C, 0x0228, 0x0014, 0xA800);
extern pascal OSErr SPBResumeRecording(long inRefNum)
 FOURWORDINLINE(0x203C, 0x022C, 0x0014, 0xA800);
extern pascal OSErr SPBStopRecording(long inRefNum)
 FOURWORDINLINE(0x203C, 0x0230, 0x0014, 0xA800);
extern pascal OSErr SPBGetRecordingStatus(long inRefNum, short *recordingStatus, short *meterLevel, unsigned long *totalSamplesToRecord, unsigned long *numberOfSamplesRecorded, unsigned long *totalMsecsToRecord, unsigned long *numberOfMsecsRecorded)
 FOURWORDINLINE(0x203C, 0x0E34, 0x0014, 0xA800);
extern pascal OSErr SPBGetDeviceInfo(long inRefNum, OSType infoType, char *infoData)
 FOURWORDINLINE(0x203C, 0x0638, 0x0014, 0xA800);
extern pascal OSErr SPBSetDeviceInfo(long inRefNum, OSType infoType, char *infoData)
 FOURWORDINLINE(0x203C, 0x063C, 0x0014, 0xA800);
extern pascal OSErr SPBMillisecondsToBytes(long inRefNum, long *milliseconds)
 FOURWORDINLINE(0x203C, 0x0440, 0x0014, 0xA800);
extern pascal OSErr SPBBytesToMilliseconds(long inRefNum, long *byteCount)
 FOURWORDINLINE(0x203C, 0x0444, 0x0014, 0xA800);
extern pascal OSErr SetupSndHeader(Handle sndHandle, short numChannels, Fixed sampleRate, short sampleSize, OSType compressionType, short baseNote, unsigned long numBytes, short *headerLen)
 FOURWORDINLINE(0x203C, 0x0D48, 0x0014, 0xA800);
extern pascal OSErr SetupAIFFHeader(short fRefNum, short numChannels, Fixed sampleRate, short sampleSize, OSType compressionType, unsigned long numBytes, unsigned long numFrames)
 FOURWORDINLINE(0x203C, 0x0B4C, 0x0014, 0xA800);
#ifdef __cplusplus
}
#endif

#endif
