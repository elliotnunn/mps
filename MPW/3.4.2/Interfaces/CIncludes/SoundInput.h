/*
 	File:		SoundInput.h
 
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
 
*/

#ifndef __SOUNDINPUT__
#define __SOUNDINPUT__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif
/*	#include <Errors.h>											*/
/*	#include <Memory.h>											*/
/*		#include <MixedMode.h>									*/
/*	#include <OSUtils.h>										*/
/*	#include <Events.h>											*/
/*		#include <Quickdraw.h>									*/
/*			#include <QuickdrawText.h>							*/
/*	#include <EPPC.h>											*/
/*		#include <AppleTalk.h>									*/
/*		#include <Files.h>										*/
/*			#include <Finder.h>									*/
/*		#include <PPCToolbox.h>									*/
/*		#include <Processes.h>									*/
/*	#include <Notification.h>									*/

#ifndef __WINDOWS__
#include <Windows.h>
#endif
/*	#include <Controls.h>										*/
/*		#include <Menus.h>										*/

#ifndef __DIALOGS__
#include <Dialogs.h>
#endif
/*	#include <TextEdit.h>										*/

#ifndef __FILES__
#include <Files.h>
#endif

#ifndef __SOUND__
#include <Sound.h>
#endif
/*	#include <Components.h>										*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

/*
						* * *  N O T E  * * *

	This file has been updated to include Sound Input Manager 1.1 interfaces.

	Some of the Sound Input Manager 1.1 interfaces were not put into the InterfaceLib
	that originally shipped with the PowerMacs. These missing functions and the
	new 1.1 interfaces have been released in the SoundLib library for PowerPC
	developers to link with. The runtime library for these functions are
	installed by Sound Manager 3.2. The following functions are found in SoundLib.

		ParseAIFFHeader(), ParseSndHeader()

*/

enum {
	siDeviceIsConnected			= 1,							/*input device is connected and ready for input*/
	siDeviceNotConnected		= 0,							/*input device is not connected*/
	siDontKnowIfConnected		= -1,							/*can't tell if input device is connected*/
	siReadPermission			= 0,							/*permission passed to SPBOpenDevice*/
	siWritePermission			= 1								/*permission passed to SPBOpenDevice*/
};

enum {
/*Info Selectors for Sound Input Drivers*/
	siActiveChannels			= 'chac',						/*active channels*/
	siActiveLevels				= 'lmac',						/*active meter levels*/
	siAGCOnOff					= 'agc ',						/*automatic gain control state*/
	siAsync						= 'asyn',						/*asynchronous capability*/
	siChannelAvailable			= 'chav',						/*number of channels available*/
	siCompressionAvailable		= 'cmav',						/*compression types available*/
	siCompressionFactor			= 'cmfa',						/*current compression factor*/
	siCompressionHeader			= 'cmhd',						/*return compression header*/
	siCompressionNames			= 'cnam',						/*compression type names available*/
	siCompressionType			= 'comp',						/*current compression type*/
	siContinuous				= 'cont',						/*continous recording*/
	siDeviceBufferInfo			= 'dbin',						/*size of interrupt buffer*/
	siDeviceConnected			= 'dcon',						/*input device connection status*/
	siDeviceIcon				= 'icon',						/*input device icon*/
	siDeviceName				= 'name',						/*input device name*/
	siHardwareBusy				= 'hwbs',						/*sound hardware is in use*/
	siInputGain					= 'gain',						/*input gain*/
	siInputSource				= 'sour',						/*input source selector*/
	siInputSourceNames			= 'snam',						/*input source names*/
	siLevelMeterOnOff			= 'lmet',						/*level meter state*/
	siModemGain					= 'mgai',						/*modem input gain*/
	siNumberChannels			= 'chan',						/*current number of channels*/
	siOptionsDialog				= 'optd',						/*display options dialog*/
	siPlayThruOnOff				= 'plth',						/*playthrough state*/
	siRecordingQuality			= 'qual',						/*recording quality*/
	siSampleRate				= 'srat',						/*current sample rate*/
	siSampleRateAvailable		= 'srav',						/*sample rates available*/
	siSampleSize				= 'ssiz',						/*current sample size*/
	siSampleSizeAvailable		= 'ssav',						/*sample sizes available*/
	siSetupCDAudio				= 'sucd',						/*setup sound hardware for CD audio*/
	siSetupModemAudio			= 'sumd',						/*setup sound hardware for modem audio*/
	siStereoInputGain			= 'sgai',						/*stereo input gain*/
	siTwosComplementOnOff		= 'twos',						/*two's complement state*/
	siVoxRecordInfo				= 'voxr',						/*VOX record parameters*/
	siVoxStopInfo				= 'voxs',						/*VOX stop parameters*/
	siCloseDriver				= 'clos',						/*reserved for internal use only*/
	siInitializeDriver			= 'init',						/*reserved for internal use only*/
	siPauseRecording			= 'paus',						/*reserved for internal use only*/
	siUserInterruptProc			= 'user',						/*reserved for internal use only*/
/*Qualities*/
	siCDQuality					= 'cd  ',						/*44.1kHz, stereo, 16 bit*/
	siBestQuality				= 'best',						/*22kHz, mono, 8 bit*/
	siBetterQuality				= 'betr',						/*22kHz, mono, MACE 3:1*/
	siGoodQuality				= 'good'
};

typedef struct SPB SPB, *SPBPtr;

/*user procedures called by sound input routines*/
/*
		SIInterruptProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

			typedef pascal void (*SIInterruptProcPtr)(SPBPtr inParamPtr, Ptr dataBuffer, short peakAmplitude, long sampleSize);

		In:
		 => inParamPtr  	A0.L
		 => dataBuffer  	A1.L
		 => peakAmplitude	D0.W
		 => sampleSize  	D1.L
*/
typedef pascal void (*SICompletionProcPtr)(SPBPtr inParamPtr);

#if GENERATINGCFM
typedef UniversalProcPtr SIInterruptUPP;
typedef UniversalProcPtr SICompletionUPP;
#else
typedef Register68kProcPtr SIInterruptUPP;
typedef SICompletionProcPtr SICompletionUPP;
#endif

struct SPB {
	long							inRefNum;					/*reference number of sound input device*/
	unsigned long					count;						/*number of bytes to record*/
	unsigned long					milliseconds;				/*number of milliseconds to record*/
	unsigned long					bufferLength;				/*length of buffer in bytes*/
	Ptr								bufferPtr;					/*buffer to store sound data in*/
	SICompletionUPP					completionRoutine;			/*completion routine*/
	SIInterruptUPP					interruptRoutine;			/*interrupt routine*/
	long							userLong;					/*user-defined field*/
	OSErr							error;						/*error*/
	long							unused1;					/*reserved - must be zero*/
};
extern pascal NumVersion SPBVersion(void)
 FOURWORDINLINE(0x203C, 0x0000, 0x0014, 0xA800);
extern pascal OSErr SndRecord(ModalFilterUPP filterProc, Point corner, OSType quality, SndListHandle *sndHandle)
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
extern pascal OSErr SPBGetDeviceInfo(long inRefNum, OSType infoType, void *infoData)
 FOURWORDINLINE(0x203C, 0x0638, 0x0014, 0xA800);
extern pascal OSErr SPBSetDeviceInfo(long inRefNum, OSType infoType, void *infoData)
 FOURWORDINLINE(0x203C, 0x063C, 0x0014, 0xA800);
extern pascal OSErr SPBMillisecondsToBytes(long inRefNum, long *milliseconds)
 FOURWORDINLINE(0x203C, 0x0440, 0x0014, 0xA800);
extern pascal OSErr SPBBytesToMilliseconds(long inRefNum, long *byteCount)
 FOURWORDINLINE(0x203C, 0x0444, 0x0014, 0xA800);
extern pascal OSErr SetupSndHeader(SndListHandle sndHandle, short numChannels, UnsignedFixed sampleRate, short sampleSize, OSType compressionType, short baseNote, unsigned long numBytes, short *headerLen)
 FOURWORDINLINE(0x203C, 0x0D48, 0x0014, 0xA800);
extern pascal OSErr SetupAIFFHeader(short fRefNum, short numChannels, UnsignedFixed sampleRate, short sampleSize, OSType compressionType, unsigned long numBytes, unsigned long numFrames)
 FOURWORDINLINE(0x203C, 0x0B4C, 0x0014, 0xA800);


/* Sound Input Manager 1.1 and later calls */
extern pascal OSErr ParseAIFFHeader(short fRefNum, SoundComponentData *sndInfo, unsigned long *numFrames, unsigned long *dataOffset)
 FOURWORDINLINE(0x203C, 0x0758, 0x0014, 0xA800);

extern pascal OSErr ParseSndHeader(SndListHandle sndHandle, SoundComponentData *sndInfo, unsigned long *numFrames, unsigned long *dataOffset)
 FOURWORDINLINE(0x203C, 0x085C, 0x0014, 0xA800);


enum {
	uppSIInterruptProcInfo = kRegisterBased
		 | REGISTER_ROUTINE_PARAMETER(1, kRegisterA0, SIZE_CODE(sizeof(SPBPtr)))
		 | REGISTER_ROUTINE_PARAMETER(2, kRegisterA1, SIZE_CODE(sizeof(Ptr)))
		 | REGISTER_ROUTINE_PARAMETER(3, kRegisterD0, SIZE_CODE(sizeof(short)))
		 | REGISTER_ROUTINE_PARAMETER(4, kRegisterD1, SIZE_CODE(sizeof(long))),
	uppSICompletionProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SPBPtr)))
};

#if GENERATINGCFM
#define NewSIInterruptProc(userRoutine)		\
		(SIInterruptUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSIInterruptProcInfo, GetCurrentArchitecture())
#define NewSICompletionProc(userRoutine)		\
		(SICompletionUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSICompletionProcInfo, GetCurrentArchitecture())
#else
#define NewSIInterruptProc(userRoutine)		\
		((SIInterruptUPP) (userRoutine))
#define NewSICompletionProc(userRoutine)		\
		((SICompletionUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallSIInterruptProc(userRoutine, inParamPtr, dataBuffer, peakAmplitude, sampleSize)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSIInterruptProcInfo, (inParamPtr), (dataBuffer), (peakAmplitude), (sampleSize))
#define CallSICompletionProc(userRoutine, inParamPtr)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSICompletionProcInfo, (inParamPtr))
#else
/* (*SIInterruptProcPtr) cannot be called from a high-level language without the Mixed Mode Manager */
#define CallSICompletionProc(userRoutine, inParamPtr)		\
		(*(userRoutine))((inParamPtr))
#endif


#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __SOUNDINPUT__ */
